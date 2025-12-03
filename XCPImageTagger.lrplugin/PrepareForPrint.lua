--[[----------------------------------------------------------------------------
XCP Platform Publisher - Prepare for Print Shop
Copyright 2025 XC Photography

Prepares selected images for print sales with:
- Elegant gallery-worthy titles
- Refined descriptions for collectors
- Print-appropriate keywords
- Edition/series information
- Privacy-first processing
------------------------------------------------------------------------------]]

local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'
local LrProgressScope = import 'LrProgressScope'
local LrView = import 'LrView'
local LrBinding = import 'LrBinding'
local LrFunctionContext = import 'LrFunctionContext'
local LrPrefs = import 'LrPrefs'
local LrDate = import 'LrDate'

require 'Logger'
local PrivacyContentMatcher = require 'PrivacyContentMatcher'
local LargeImageHandler = require 'LargeImageHandler'

-- Main function
local function prepareForPrint()
    LrFunctionContext.callWithContext('prepareForPrint', function(context)
        local catalog = LrApplication.activeCatalog()
        local selectedPhotos = catalog:getTargetPhotos()
        local prefs = LrPrefs.prefsForPlugin()
        
        if #selectedPhotos == 0 then
            LrDialogs.message(
                "No Photos Selected",
                "Please select one or more photos to prepare for print sales.",
                "info"
            )
            return
        end
        
        -- Create dialog for options
        local viewFactory = LrView.osFactory()
        local props = LrBinding.makePropertyTable(context)
        
        -- Initialize properties
        props.privacyMode = true
        props.brandVoice = 'elegant'
        props.isLimitedEdition = true
        props.editionSize = '25'
        props.seriesName = ''
        props.printType = 'fine_art'
        props.includeFramingNotes = true
        
        local contents = viewFactory:column {
            spacing = viewFactory:control_spacing(),
            bind_to_object = props,
            
            viewFactory:static_text {
                title = string.format("Prepare %d photo(s) for Print Shop", #selectedPhotos),
                font = "<system/bold>",
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Privacy notice
            viewFactory:group_box {
                title = "Privacy Protection",
                fill_horizontal = 1,
                
                viewFactory:column {
                    viewFactory:checkbox {
                        value = LrView.bind 'privacyMode',
                        title = "Privacy Mode - Protect your images from AI training",
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Print type
            viewFactory:row {
                viewFactory:static_text {
                    title = "Print Type:",
                    width = 120,
                },
                viewFactory:popup_menu {
                    value = LrView.bind 'printType',
                    items = {
                        { title = 'Fine Art Print', value = 'fine_art' },
                        { title = 'Canvas Print', value = 'canvas' },
                        { title = 'Metal Print', value = 'metal' },
                        { title = 'Acrylic Print', value = 'acrylic' },
                        { title = 'Poster Print', value = 'poster' },
                        { title = 'Greeting Card', value = 'card' },
                        { title = 'Gift/Merchandise', value = 'merchandise' },
                    },
                },
            },
            
            -- Brand voice
            viewFactory:row {
                viewFactory:static_text {
                    title = "Description Style:",
                    width = 120,
                },
                viewFactory:popup_menu {
                    value = LrView.bind 'brandVoice',
                    items = {
                        { title = 'Elegant & Refined', value = 'elegant' },
                        { title = 'Professional & Polished', value = 'professional' },
                        { title = 'Artistic & Emotive', value = 'artistic' },
                        { title = 'Documentary & Authentic', value = 'documentary' },
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Edition settings
            viewFactory:checkbox {
                value = LrView.bind 'isLimitedEdition',
                title = "Limited Edition Print",
            },
            
            viewFactory:row {
                viewFactory:static_text {
                    title = "Edition Size:",
                    width = 120,
                },
                viewFactory:edit_field {
                    value = LrView.bind 'editionSize',
                    width_in_chars = 10,
                    enabled = LrView.bind 'isLimitedEdition',
                },
            },
            
            viewFactory:row {
                viewFactory:static_text {
                    title = "Series Name:",
                    width = 120,
                },
                viewFactory:edit_field {
                    value = LrView.bind 'seriesName',
                    width_in_chars = 30,
                    placeholder_string = "Optional (e.g., 'Urban Reflections')",
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            viewFactory:checkbox {
                value = LrView.bind 'includeFramingNotes',
                title = "Include framing/display recommendations",
            },
        }
        
        local result = LrDialogs.presentModalDialog({
            title = "XCP Platform Publisher - Print Shop",
            contents = contents,
            actionVerb = "Prepare",
        })
        
        if result == 'ok' then
            -- Process photos
            local progress = LrProgressScope({
                title = "Preparing for Print Shop",
                functionContext = context,
            })
            
            local successCount = 0
            local errorCount = 0
            
            catalog:withWriteAccessDo("Prepare for Print", function()
                for i, photo in ipairs(selectedPhotos) do
                    progress:setPortionComplete(i - 1, #selectedPhotos)
                    progress:setCaption(photo:getFormattedMetadata('fileName'))
                    
                    if progress:isCanceled() then
                        break
                    end
                    
                    -- Generate content
                    local contentResult = PrivacyContentMatcher.generateContent(photo, 'print', {
                        brandVoice = props.brandVoice,
                        useAi = prefs.useAiAssist and not props.privacyMode,
                    })
                    
                    if contentResult and contentResult.content then
                        local description = contentResult.content
                        local photographerCredit = prefs.photographerCredit or 'XC Photography'
                        
                        -- Generate elegant title
                        local style = contentResult.style or 'Photograph'
                        local location = contentResult.location or ''
                        local title
                        
                        if props.seriesName and props.seriesName ~= '' then
                            title = string.format("%s | %s Series", 
                                style:gsub("^%l", string.upper), props.seriesName)
                        elseif location ~= '' then
                            title = string.format("%s | %s", 
                                style:gsub("^%l", string.upper), location)
                        else
                            title = style:gsub("^%l", string.upper)
                        end
                        
                        -- Add edition info
                        if props.isLimitedEdition then
                            title = title .. " | Limited Edition"
                        end
                        
                        -- Build full description
                        local printTypeNames = {
                            fine_art = "Fine Art Print",
                            canvas = "Canvas Print",
                            metal = "Metal Print",
                            acrylic = "Acrylic Print",
                            poster = "Poster Print",
                            card = "Greeting Card",
                            merchandise = "Gift Item",
                        }
                        
                        local fullDescription = description
                        
                        -- Add print details
                        fullDescription = fullDescription .. "\n\n"
                        fullDescription = fullDescription .. "Print Type: " .. (printTypeNames[props.printType] or "Fine Art Print") .. "\n"
                        fullDescription = fullDescription .. "Photographer: " .. photographerCredit .. "\n"
                        
                        if props.isLimitedEdition then
                            fullDescription = fullDescription .. "Edition: Limited to " .. props.editionSize .. " prints\n"
                            fullDescription = fullDescription .. "Certificate of authenticity included\n"
                        end
                        
                        if props.includeFramingNotes then
                            local framingNotes = {
                                fine_art = "Recommended: Float mounting or traditional framing with archival materials",
                                canvas = "Ready to hang - stretched on wooden frame",
                                metal = "Float mount included - modern, sleek display",
                                acrylic = "Face-mounted for brilliant clarity and depth",
                                poster = "Suitable for standard frames or portfolio display",
                                card = "Blank inside - premium card stock with envelope",
                                merchandise = "High-quality reproduction on premium materials",
                            }
                            fullDescription = fullDescription .. "Display: " .. (framingNotes[props.printType] or "") .. "\n"
                        end
                        
                        -- Set metadata
                        photo:setRawMetadata('title', title)
                        photo:setRawMetadata('caption', fullDescription)
                        
                        -- Update custom metadata
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPrintReady', 'yes')
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPrintDescription', fullDescription)
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPhotoStyle', contentResult.style)
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpLastPrepared', 
                            LrDate.timeToUserFormat(LrDate.currentTime(), "%Y-%m-%d %H:%M"))
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPreparedBy', 
                            contentResult.generatedBy == 'ai_text_only' and 'ai_assisted' or 'template')
                        
                        -- Add print-appropriate keywords
                        local printKeywords = {
                            'Fine Art Print',
                            'Wall Art',
                            'Photography Print',
                            'Home Decor',
                            photographerCredit:gsub('%s+', ''),
                            'UK Art',
                            'Gallery Quality',
                        }
                        
                        if props.isLimitedEdition then
                            table.insert(printKeywords, 'Limited Edition')
                            table.insert(printKeywords, 'Signed Print')
                        end
                        
                        if props.seriesName and props.seriesName ~= '' then
                            table.insert(printKeywords, props.seriesName)
                        end
                        
                        for _, kwName in ipairs(printKeywords) do
                            local keyword = catalog:createKeyword(kwName, {}, true, nil, true)
                            photo:addKeyword(keyword)
                        end
                        
                        successCount = successCount + 1
                    else
                        errorCount = errorCount + 1
                    end
                    
                    progress:setPortionComplete(i, #selectedPhotos)
                end
            end)
            
            progress:done()
            
            -- Show summary
            local message = string.format(
                "Successfully prepared %d photo(s) for print sales.", 
                successCount
            )
            if errorCount > 0 then
                message = message .. string.format("\n%d photo(s) had errors.", errorCount)
            end
            
            if props.privacyMode then
                message = message .. "\n\n✓ Privacy Mode: Your images are protected from AI training."
            end
            
            LrDialogs.message("Print Shop Preparation Complete", message, "info")
        end
    end)
end

-- Run the function
LrTasks.startAsyncTask(prepareForPrint)
