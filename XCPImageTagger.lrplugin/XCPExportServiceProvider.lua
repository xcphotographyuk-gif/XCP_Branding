--[[----------------------------------------------------------------------------
XCPExportServiceProvider.lua - Export Service Provider
XCP Platform Publisher - Lightroom Plugin
Copyright 2025 XC Photography

Implements the Lightroom SDK LrExportServiceProvider interface.
This service provider allows the plugin to appear in the Export dialog
as a named destination and run metadata preparation as a post-process
step immediately before files are written to disk.

NOTE: This provider does NOT upload files anywhere. It prepares IPTC
metadata fields in-catalog and then passes control to Lightroom's
standard file export. If you want actual upload-to-service behaviour,
configure a standard Lightroom export preset (Hard Drive / Folder) and
select "XCP Platform Publisher" as an Export Service.
------------------------------------------------------------------------------]]

local LrView            = import 'LrView'
local LrBinding         = import 'LrBinding'
local LrPrefs           = import 'LrPrefs'
local LrDialogs         = import 'LrDialogs'
local LrProgressScope   = import 'LrProgressScope'
local LrApplication     = import 'LrApplication'
local LrTasks           = import 'LrTasks'
local LrDate            = import 'LrDate'

require 'Logger'
local PrivacyContentMatcher = require 'PrivacyContentMatcher'
local SEOTaggingEngine      = require 'SEOTaggingEngine'

-- ============================================================================
-- EXPORT PRESET FIELDS
-- These fields are stored per export preset so each preset can have its
-- own platform target, brand voice, and privacy setting.
-- ============================================================================

local exportServiceProvider = {}

exportServiceProvider.exportPresetFields = {
    { key = 'targetPlatform',    default = 'website' },
    { key = 'brandVoice',        default = 'professional' },
    { key = 'privacyMode',       default = true },
    { key = 'addCopyrightLine',  default = true },
    { key = 'overwriteMetadata', default = false },
}

-- ============================================================================
-- HIDE IRRELEVANT EXPORT SECTIONS
-- We are a metadata-preparation service, not an upload destination.
-- Hiding upload-specific panels keeps the dialog clean.
-- ============================================================================

exportServiceProvider.hideSections = {
    'fileNaming',       -- keep standard file naming
    'imageSettings',    -- keep image settings so user controls quality
    'outputSharpening',
    'metadata',
    'watermarking',
    'postProcessing',
}

-- ============================================================================
-- DIALOG SECTIONS - shown inside the Lightroom Export dialog
-- ============================================================================

exportServiceProvider.sectionsForTopOfDialog = function(viewFactory, propertyTable)
    local bind = LrView.bind
    local prefs = LrPrefs.prefsForPlugin()

    -- Sync prefs into property table
    if propertyTable.photographerCredit == nil then
        propertyTable.photographerCredit = prefs.photographerCredit or 'XC Photography'
    end

    return {
        {
            title = "XCP Platform Publisher — Export Preparation",

            viewFactory:column {
                spacing = viewFactory:control_spacing(),

                viewFactory:static_text {
                    title = "Metadata will be written to each photo before it is exported. Choose the target platform to determine which content style is applied.",
                    wrap  = true,
                    width_in_chars = 55,
                },

                viewFactory:separator { fill_horizontal = 1 },

                -- Target platform
                viewFactory:row {
                    viewFactory:static_text { title = "Target Platform:", width = 140 },
                    viewFactory:popup_menu {
                        value = bind 'targetPlatform',
                        items = {
                            { title = "Website / Portfolio",         value = "website"  },
                            { title = "Instagram / Social Media",    value = "instagram" },
                            { title = "Print Shop / Fine Art",       value = "print"    },
                            { title = "Stock Photography (Alamy…)",  value = "stock"    },
                        },
                    },
                },

                -- Brand voice
                viewFactory:row {
                    viewFactory:static_text { title = "Brand Voice:", width = 140 },
                    viewFactory:popup_menu {
                        value = bind 'brandVoice',
                        items = {
                            { title = "Professional & Polished",  value = "professional"  },
                            { title = "Friendly & Approachable",  value = "friendly"      },
                            { title = "Bold & Edgy",              value = "bold"          },
                            { title = "Elegant & Refined",        value = "elegant"       },
                            { title = "Documentary & Authentic",  value = "documentary"   },
                        },
                    },
                },

                viewFactory:separator { fill_horizontal = 1 },

                -- Privacy
                viewFactory:checkbox {
                    value = bind 'privacyMode',
                    title = "Privacy Mode — no image data sent to external services",
                },

                -- Copyright
                viewFactory:checkbox {
                    value = bind 'addCopyrightLine',
                    title = "Append © copyright line to caption",
                },

                -- Overwrite
                viewFactory:checkbox {
                    value = bind 'overwriteMetadata',
                    title = "Overwrite existing title/caption if already populated",
                },
            },
        },
    }
end

-- ============================================================================
-- VALIDATE SETTINGS - called when the user clicks Export
-- Return false + message to block the export with an explanation.
-- ============================================================================

exportServiceProvider.validateSettings = function(propertyTable)
    if not propertyTable.targetPlatform or propertyTable.targetPlatform == '' then
        return false, "Please select a target platform before exporting."
    end
    return true
end

-- ============================================================================
-- PROCESS RENDERED PHOTOS
-- This is the core SDK callback. Lightroom has already rendered each photo
-- to a temporary file on disk. We use this moment to write finalized
-- metadata back to the catalog record, then allow Lightroom to continue
-- copying the rendered file to the user's chosen export destination.
-- ============================================================================

exportServiceProvider.processRenderedPhotos = function(functionContext, exportContext)
    local exportSession  = exportContext.exportSession
    local exportSettings = exportContext.propertyTable
    local catalog        = LrApplication.activeCatalog()
    local prefs          = LrPrefs.prefsForPlugin()

    local nPhotos        = exportSession:countRenditions()
    local progressScope  = LrProgressScope({
        title            = string.format("XCP Platform Publisher — preparing %d photo(s)", nPhotos),
        functionContext  = functionContext,
    })

    local successCount = 0
    local errorCount   = 0

    for i, rendition in exportSession:renditions() do
        progressScope:setPortionComplete(i - 1, nPhotos)

        if progressScope:isCanceled() then break end

        local photo   = rendition.photo
        local success, pathOrMessage = rendition:waitForRender()

        if success then
            -- Generate content using privacy-first approach
            local ok, err = pcall(function()
                local contentResult = PrivacyContentMatcher.generateContent(photo, exportSettings.targetPlatform, {
                    brandVoice = exportSettings.brandVoice or 'professional',
                    useAi      = prefs.useAiAssist and not exportSettings.privacyMode,
                })

                if contentResult and contentResult.content then
                    catalog:withWriteAccessDo("XCP Export Metadata", function()
                        local existingTitle   = photo:getFormattedMetadata('title')   or ''
                        local existingCaption = photo:getFormattedMetadata('caption') or ''

                        -- Title
                        if exportSettings.overwriteMetadata or existingTitle == '' then
                            local style    = contentResult.style or 'Photograph'
                            local location = contentResult.location or ''
                            local credit   = prefs.photographerCredit or 'XC Photography'
                            local newTitle
                            if location ~= '' then
                                newTitle = string.format("%s | %s", style:gsub("^%l", string.upper), location)
                            else
                                newTitle = string.format("%s | %s", style:gsub("^%l", string.upper), credit)
                            end
                            if #newTitle > 60 then newTitle = newTitle:sub(1, 57) .. '...' end
                            photo:setRawMetadata('title', newTitle)
                        end

                        -- Caption
                        if exportSettings.overwriteMetadata or existingCaption == '' then
                            local caption = contentResult.content
                            if exportSettings.addCopyrightLine then
                                local credit = prefs.photographerCredit or 'XC Photography'
                                caption = caption .. ' © ' .. credit .. '.'
                            end
                            photo:setRawMetadata('caption', caption)
                        end

                        -- Copyright field
                        local credit = prefs.photographerCredit or 'XC Photography'
                        photo:setRawMetadata('copyright', '© ' .. tostring(os.date('%Y')) .. ' ' .. credit .. '. All rights reserved.')
                        photo:setRawMetadata('copyrightState', 'copyrighted')
                        photo:setRawMetadata('creator', credit)
                        if prefs.websiteUrl and prefs.websiteUrl ~= '' then
                            photo:setRawMetadata('creatorUrl', 'https://' .. prefs.websiteUrl)
                        end

                        -- Platform-ready custom field
                        local platformField = {
                            website  = 'xcpWebsiteReady',
                            instagram = 'xcpInstagramReady',
                            print    = 'xcpPrintReady',
                            stock    = 'xcpStockReady',
                        }
                        local fieldId = platformField[exportSettings.targetPlatform]
                        if fieldId then
                            photo:setPropertyForPlugin(_PLUGIN, fieldId, 'yes')
                        end

                        photo:setPropertyForPlugin(_PLUGIN, 'xcpLastPrepared',
                            LrDate.timeToUserFormat(LrDate.currentTime(), "%Y-%m-%d %H:%M"))
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPreparedBy', 'template')
                    end)
                end
            end)

            if ok then
                successCount = successCount + 1
                rendition:recordSuccessful()
            else
                errorCount = errorCount + 1
                logger:errorf('XCPExportServiceProvider: error processing %s — %s',
                    photo:getFormattedMetadata('fileName'), tostring(err))
                rendition:recordFailure(tostring(err))
            end
        else
            -- Render itself failed — record but don't crash
            errorCount = errorCount + 1
            logger:errorf('XCPExportServiceProvider: render failed for photo — %s', tostring(pathOrMessage))
        end

        progressScope:setPortionComplete(i, nPhotos)
    end

    progressScope:done()

    if errorCount > 0 then
        LrDialogs.message(
            "XCP Platform Publisher — Export Complete",
            string.format("%d photo(s) prepared.\n%d photo(s) had errors — check the Lightroom log for details.", successCount, errorCount),
            "warning"
        )
    end
end

-- ============================================================================
-- ALLOWED FILE TYPES
-- We work with all photo file types — no restriction needed.
-- ============================================================================

exportServiceProvider.canExportVideo = false

-- ============================================================================
-- TITLE shown in Export dialog destination dropdown
-- ============================================================================

exportServiceProvider.title = "XCP Platform Publisher"

return exportServiceProvider
