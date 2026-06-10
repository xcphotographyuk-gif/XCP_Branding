--[[----------------------------------------------------------------------------
PrepareAndExport.lua - Prepare Metadata Then Export
XCP Platform Publisher - Lightroom Plugin
Copyright 2025 XC Photography

Combines the metadata preparation step (Privacy-first content generation,
IPTC fields, keyword tagging) with an immediate Lightroom export in one
action. Useful for photographers who want a single-click workflow:

  Select photos → Prepare & Export → done.

The user chooses:
  1. Target platform (controls content style)
  2. Export destination (folder on disk)
  3. File format and quality

After clicking OK, the plugin:
  a. Writes all metadata to the catalog (title, caption, keywords, IPTC)
  b. Triggers a Lightroom export using the configured settings
------------------------------------------------------------------------------]]

local LrApplication      = import 'LrApplication'
local LrDialogs          = import 'LrDialogs'
local LrTasks            = import 'LrTasks'
local LrProgressScope    = import 'LrProgressScope'
local LrView             = import 'LrView'
local LrBinding          = import 'LrBinding'
local LrFunctionContext  = import 'LrFunctionContext'
local LrPrefs            = import 'LrPrefs'
local LrDate             = import 'LrDate'
local LrExportSession    = import 'LrExportSession'
local LrPathUtils        = import 'LrPathUtils'
local LrFileUtils        = import 'LrFileUtils'
local LrColor            = import 'LrColor'

require 'Logger'
local PrivacyContentMatcher = require 'PrivacyContentMatcher'
local SEOTaggingEngine      = require 'SEOTaggingEngine'

-- ============================================================================
-- HELPERS
-- ============================================================================

-- Build a default export folder in the user's Pictures directory
local function defaultExportFolder()
    local pictures = LrPathUtils.getStandardFilePath('pictures')
    return pictures and LrPathUtils.child(pictures, 'XCP Exports') or ''
end

-- ============================================================================
-- MAIN
-- ============================================================================

local function prepareAndExport()
    LrFunctionContext.callWithContext('prepareAndExport', function(context)
        local catalog       = LrApplication.activeCatalog()
        local selectedPhotos = catalog:getTargetPhotos()
        local prefs         = LrPrefs.prefsForPlugin()

        if #selectedPhotos == 0 then
            LrDialogs.message(
                "No Photos Selected",
                "Please select one or more photos in the Library before using Prepare & Export.",
                "info"
            )
            return
        end

        -- ================================================================
        -- BUILD DIALOG
        -- ================================================================
        local viewFactory = LrView.osFactory()
        local props       = LrBinding.makePropertyTable(context)

        props.targetPlatform    = 'website'
        props.brandVoice        = prefs.brandVoice        or 'professional'
        props.privacyMode       = true
        props.overwriteMetadata = false
        props.addCopyrightLine  = true

        local contents = viewFactory:column {
            spacing        = viewFactory:control_spacing(),
            bind_to_object = props,

            viewFactory:static_text {
                title = string.format("Prepare & Export — %d photo(s) selected", #selectedPhotos),
                font  = "<system/bold>",
            },

            viewFactory:separator { fill_horizontal = 1 },

            -- Platform
            viewFactory:group_box {
                title          = "Step 1 — Choose Platform",
                fill_horizontal = 1,
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    viewFactory:row {
                        viewFactory:static_text { title = "Target Platform:", width = 140 },
                        viewFactory:popup_menu {
                            value = LrView.bind 'targetPlatform',
                            items = {
                                { title = "Website / Portfolio",        value = "website"   },
                                { title = "Instagram / Social Media",   value = "instagram" },
                                { title = "Print Shop / Fine Art",      value = "print"     },
                                { title = "Stock Photography (Alamy…)", value = "stock"     },
                            },
                        },
                    },
                    viewFactory:row {
                        viewFactory:static_text { title = "Brand Voice:", width = 140 },
                        viewFactory:popup_menu {
                            value = LrView.bind 'brandVoice',
                            items = {
                                { title = "Professional & Polished",  value = "professional" },
                                { title = "Friendly & Approachable",  value = "friendly"     },
                                { title = "Bold & Edgy",              value = "bold"         },
                                { title = "Elegant & Refined",        value = "elegant"      },
                                { title = "Documentary & Authentic",  value = "documentary"  },
                            },
                        },
                    },
                },
            },

            -- Metadata options
            viewFactory:group_box {
                title          = "Step 2 — Metadata Options",
                fill_horizontal = 1,
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    viewFactory:checkbox {
                        value = LrView.bind 'privacyMode',
                        title = "Privacy Mode — no image data sent externally (recommended)",
                    },
                    viewFactory:checkbox {
                        value = LrView.bind 'addCopyrightLine',
                        title = "Append © copyright line to caption",
                    },
                    viewFactory:checkbox {
                        value = LrView.bind 'overwriteMetadata',
                        title = "Overwrite existing title/caption if already set",
                    },
                },
            },

            -- Export notice
            viewFactory:group_box {
                title          = "Step 3 — Export",
                fill_horizontal = 1,
                viewFactory:static_text {
                    title = "After clicking Prepare & Export, Lightroom's standard Export dialog will open. Choose your export folder, file format, and quality settings there.\n\nMetadata preparation runs automatically before your files are written to disk.",
                    wrap  = true,
                    width_in_chars = 52,
                    font  = "<system/small>",
                    text_color = LrColor(0.35, 0.35, 0.35),
                },
            },
        }

        local result = LrDialogs.presentModalDialog({
            title      = "XCP Platform Publisher — Prepare & Export",
            contents   = contents,
            actionVerb = "Prepare & Export",
        })

        if result ~= 'ok' then return end

        -- ================================================================
        -- PHASE 1: WRITE METADATA TO CATALOG
        -- ================================================================
        local progress = LrProgressScope({
            title           = string.format("XCP — Preparing metadata for %d photo(s)", #selectedPhotos),
            functionContext = context,
        })

        local successCount = 0
        local errorCount   = 0

        catalog:withWriteAccessDo("XCP Prepare & Export — Metadata", function()
            for i, photo in ipairs(selectedPhotos) do
                progress:setPortionComplete(i - 1, #selectedPhotos)
                progress:setCaption(photo:getFormattedMetadata('fileName'))

                if progress:isCanceled() then break end

                local ok, err = pcall(function()
                    local contentResult = PrivacyContentMatcher.generateContent(photo, props.targetPlatform, {
                        brandVoice = props.brandVoice,
                        useAi      = prefs.useAiAssist and not props.privacyMode,
                    })

                    if contentResult and contentResult.content then
                        -- Title
                        local existingTitle = photo:getFormattedMetadata('title') or ''
                        if props.overwriteMetadata or existingTitle == '' then
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
                        local existingCaption = photo:getFormattedMetadata('caption') or ''
                        if props.overwriteMetadata or existingCaption == '' then
                            local caption = contentResult.content
                            if props.addCopyrightLine then
                                local credit = prefs.photographerCredit or 'XC Photography'
                                caption = caption .. ' © ' .. credit .. '.'
                            end
                            photo:setRawMetadata('caption', caption)
                        end

                        -- Copyright
                        local credit = prefs.photographerCredit or 'XC Photography'
                        photo:setRawMetadata('copyright', '© ' .. tostring(os.date('%Y')) .. ' ' .. credit .. '. All rights reserved.')
                        photo:setRawMetadata('copyrightState', 'copyrighted')
                        photo:setRawMetadata('creator', credit)
                        if prefs.websiteUrl and prefs.websiteUrl ~= '' then
                            photo:setRawMetadata('creatorUrl', 'https://' .. prefs.websiteUrl)
                        end

                        -- Platform-ready status
                        local platformFields = {
                            website   = 'xcpWebsiteReady',
                            instagram = 'xcpInstagramReady',
                            print     = 'xcpPrintReady',
                            stock     = 'xcpStockReady',
                        }
                        local fieldId = platformFields[props.targetPlatform]
                        if fieldId then
                            photo:setPropertyForPlugin(_PLUGIN, fieldId, 'yes')
                        end

                        photo:setPropertyForPlugin(_PLUGIN, 'xcpLastPrepared',
                            LrDate.timeToUserFormat(LrDate.currentTime(), "%Y-%m-%d %H:%M"))
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPreparedBy', 'template')

                        -- Add keywords
                        if contentResult.keywords and #contentResult.keywords > 0 then
                            for _, kwName in ipairs(contentResult.keywords) do
                                local keyword = catalog:createKeyword(kwName, {}, true, nil, true)
                                photo:addKeyword(keyword)
                            end
                        end

                        successCount = successCount + 1
                    else
                        errorCount = errorCount + 1
                        logger:errorf('PrepareAndExport: No content generated for %s',
                            photo:getFormattedMetadata('fileName'))
                    end
                end)

                if not ok then
                    errorCount = errorCount + 1
                    logger:errorf('PrepareAndExport: Error processing %s — %s',
                        photo:getFormattedMetadata('fileName'), tostring(err))
                end

                progress:setPortionComplete(i, #selectedPhotos)
            end
        end)

        progress:done()

        -- ================================================================
        -- PHASE 2: OPEN LIGHTROOM EXPORT DIALOG
        -- Lightroom's built-in export dialog is opened with the
        -- currently selected photos. The user configures folder,
        -- format, and quality as normal.
        -- ================================================================
        if successCount > 0 then
            -- Show a brief summary before opening export
            local summaryMsg = string.format(
                "Metadata prepared for %d photo(s).\n\n" ..
                "The Lightroom Export dialog will open now — choose your export folder and file settings.",
                successCount
            )
            if errorCount > 0 then
                summaryMsg = summaryMsg .. string.format("\n\n⚠ %d photo(s) had errors during preparation.", errorCount)
            end
            LrDialogs.message("XCP — Metadata Ready", summaryMsg, "info")

            -- Invoke Lightroom's built-in export dialog
            -- This is the standard LrApplication call that opens Export
            LrApplication.invokeBuiltInCommand('exportSelectedFiles')
        else
            LrDialogs.message(
                "XCP — No Photos Prepared",
                "Metadata preparation did not succeed for any selected photo. Export has not been started.\n\nCheck the Lightroom log (Help → Lightroom Log) for details.",
                "warning"
            )
        end
    end)
end

-- Run the function
LrTasks.startAsyncTask(prepareAndExport)
