--[[----------------------------------------------------------------------------
XCP Platform Publisher - Prepare for Instagram
Copyright 2025 XC Photography

Prepares selected images for Instagram with:
- Engaging captions with hashtags
- Appropriate keywords
- Location tags
- Privacy-first processing (no image data sent to AI by default)
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
local function prepareForInstagram()
    LrFunctionContext.callWithContext('prepareForInstagram', function(context)
        local catalog = LrApplication.activeCatalog()
        local selectedPhotos = catalog:getTargetPhotos()
        local prefs = LrPrefs.prefsForPlugin()
        
        if #selectedPhotos == 0 then
            LrDialogs.message(
                "No Photos Selected",
                "Please select one or more photos to prepare for Instagram.",
                "info"
            )
            return
        end
        
        -- Create dialog for options
        local viewFactory = LrView.osFactory()
        local props = LrBinding.makePropertyTable(context)
        
        -- Initialize properties
        props.useAiAssist = prefs.useAiAssist or false
        props.privacyMode = true  -- Default to privacy mode
        props.brandVoice = prefs.brandVoice or 'professional'
        props.addLocationTags = true
        props.includePhotographerCredit = true
        props.customHashtags = ''
        
        local contents = viewFactory:column {
            spacing = viewFactory:control_spacing(),
            bind_to_object = props,
            
            viewFactory:static_text {
                title = string.format("Prepare %d photo(s) for Instagram", #selectedPhotos),
                font = "<system/bold>",
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Privacy options
            viewFactory:group_box {
                title = "Privacy Settings",
                fill_horizontal = 1,
                
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:checkbox {
                        value = LrView.bind 'privacyMode',
                        title = "Privacy Mode (recommended)",
                    },
                    
                    viewFactory:static_text {
                        title = "When enabled, NO image data is sent to AI services.",
                        font = "<system/small>",
                        text_color = LrColor(0.4, 0.4, 0.4),
                    },
                    
                    viewFactory:static_text {
                        title = "Content is generated from metadata, keywords, and templates.",
                        font = "<system/small>",
                        text_color = LrColor(0.4, 0.4, 0.4),
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Brand voice
            viewFactory:row {
                viewFactory:static_text {
                    title = "Brand Voice:",
                    width = 120,
                },
                viewFactory:popup_menu {
                    value = LrView.bind 'brandVoice',
                    items = {
                        { title = 'Professional & Polished', value = 'professional' },
                        { title = 'Friendly & Approachable', value = 'friendly' },
                        { title = 'Bold & Edgy', value = 'bold' },
                        { title = 'Elegant & Refined', value = 'elegant' },
                        { title = 'Documentary & Authentic', value = 'documentary' },
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Options
            viewFactory:checkbox {
                value = LrView.bind 'addLocationTags',
                title = "Add location hashtags from metadata",
            },
            
            viewFactory:checkbox {
                value = LrView.bind 'includePhotographerCredit',
                title = "Include photographer credit",
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Custom hashtags
            viewFactory:row {
                viewFactory:static_text {
                    title = "Additional Hashtags:",
                    width = 120,
                },
                viewFactory:edit_field {
                    value = LrView.bind 'customHashtags',
                    width_in_chars = 35,
                    height_in_lines = 2,
                    placeholder_string = "#photography #ukphotographer",
                },
            },
        }
        
        local result = LrDialogs.presentModalDialog({
            title = "XCP Platform Publisher - Instagram",
            contents = contents,
            actionVerb = "Prepare",
        })
        
        if result == 'ok' then
            -- Process photos
            local progress = LrProgressScope({
                title = "Preparing for Instagram",
                functionContext = context,
            })
            
            local successCount = 0
            local errorCount = 0
            
            catalog:withWriteAccessDo("Prepare for Instagram", function()
                for i, photo in ipairs(selectedPhotos) do
                    progress:setPortionComplete(i - 1, #selectedPhotos)
                    progress:setCaption(photo:getFormattedMetadata('fileName'))
                    
                    if progress:isCanceled() then
                        break
                    end
                    
                    -- Check file size for large images
                    local fileInfo = LargeImageHandler.getFileInfo(photo)
                    if fileInfo.isLargeFile or fileInfo.isHighRes then
                        logger:infof('PrepareForInstagram: Large image detected (%.1fMP, %.1fMB)', 
                            fileInfo.megapixels or 0, fileInfo.fileSizeMB or 0)
                    end
                    
                    -- Generate content using privacy-first approach
                    local contentResult = PrivacyContentMatcher.generateContent(photo, 'instagram', {
                        brandVoice = props.brandVoice,
                        useAi = props.useAiAssist and not props.privacyMode,
                    })
                    
                    if contentResult and contentResult.content then
                        local caption = contentResult.content
                        
                        -- Add custom hashtags if provided
                        if props.customHashtags and props.customHashtags ~= '' then
                            caption = caption .. '\n\n' .. props.customHashtags
                        end
                        
                        -- Set caption (stored in caption field)
                        photo:setRawMetadata('caption', caption)
                        
                        -- Set title based on detected style
                        local title = photo:getFormattedMetadata('title')
                        if not title or title == '' then
                            local style = contentResult.style or 'photograph'
                            local location = contentResult.location or ''
                            if location ~= '' then
                                title = string.format("%s | %s", 
                                    style:gsub("^%l", string.upper), location)
                            else
                                title = style:gsub("^%l", string.upper) .. " | XC Photography"
                            end
                            photo:setRawMetadata('title', title)
                        end
                        
                        -- Update custom metadata
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpInstagramReady', 'yes')
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpInstagramCaption', caption)
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPhotoStyle', contentResult.style)
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpLastPrepared', 
                            LrDate.timeToUserFormat(LrDate.currentTime(), "%Y-%m-%d %H:%M"))
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPreparedBy', 
                            contentResult.generatedBy == 'ai_text_only' and 'ai_assisted' or 'template')
                        
                        -- Add keywords from content
                        if contentResult.keywords and #contentResult.keywords > 0 then
                            for _, kwName in ipairs(contentResult.keywords) do
                                local keyword = catalog:createKeyword(kwName, {}, true, nil, true)
                                photo:addKeyword(keyword)
                            end
                        end
                        
                        successCount = successCount + 1
                    else
                        errorCount = errorCount + 1
                        logger:errorf('PrepareForInstagram: Failed to generate content for %s', 
                            photo:getFormattedMetadata('fileName'))
                    end
                    
                    progress:setPortionComplete(i, #selectedPhotos)
                end
            end)
            
            progress:done()
            
            -- Show summary
            local message = string.format(
                "Successfully prepared %d photo(s) for Instagram.", 
                successCount
            )
            if errorCount > 0 then
                message = message .. string.format("\n%d photo(s) had errors.", errorCount)
            end
            
            if props.privacyMode then
                message = message .. "\n\n✓ Privacy Mode: No image data was sent externally."
            end
            
            LrDialogs.message("Instagram Preparation Complete", message, "info")
        end
    end)
end

-- Run the function
LrTasks.startAsyncTask(prepareForInstagram)
