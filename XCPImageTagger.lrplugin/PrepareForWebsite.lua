--[[----------------------------------------------------------------------------
XCP Platform Publisher - Prepare for Website
Copyright 2025 XC Photography

Prepares selected images for website/portfolio with:
- SEO-optimized titles and descriptions
- Alt text for accessibility
- Professional keywords
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
local function prepareForWebsite()
    LrFunctionContext.callWithContext('prepareForWebsite', function(context)
        local catalog = LrApplication.activeCatalog()
        local selectedPhotos = catalog:getTargetPhotos()
        local prefs = LrPrefs.prefsForPlugin()
        
        if #selectedPhotos == 0 then
            LrDialogs.message(
                "No Photos Selected",
                "Please select one or more photos to prepare for your website.",
                "info"
            )
            return
        end
        
        -- Create dialog for options
        local viewFactory = LrView.osFactory()
        local props = LrBinding.makePropertyTable(context)
        
        -- Initialize properties
        props.privacyMode = true
        props.brandVoice = prefs.brandVoice or 'professional'
        props.seoOptimize = true
        props.generateAltText = true
        props.includeLocation = true
        props.websiteSection = 'portfolio'
        
        local contents = viewFactory:column {
            spacing = viewFactory:control_spacing(),
            bind_to_object = props,
            
            viewFactory:static_text {
                title = string.format("Prepare %d photo(s) for Website", #selectedPhotos),
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
                        title = "Privacy Mode - No image data sent externally",
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Website section
            viewFactory:row {
                viewFactory:static_text {
                    title = "Website Section:",
                    width = 120,
                },
                viewFactory:popup_menu {
                    value = LrView.bind 'websiteSection',
                    items = {
                        { title = 'Portfolio Gallery', value = 'portfolio' },
                        { title = 'Blog Post', value = 'blog' },
                        { title = 'Services Page', value = 'services' },
                        { title = 'About Page', value = 'about' },
                        { title = 'Client Gallery', value = 'client' },
                    },
                },
            },
            
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
                value = LrView.bind 'seoOptimize',
                title = "Optimize titles for SEO (under 60 characters)",
            },
            
            viewFactory:checkbox {
                value = LrView.bind 'generateAltText',
                title = "Generate accessibility alt text",
            },
            
            viewFactory:checkbox {
                value = LrView.bind 'includeLocation',
                title = "Include location in descriptions",
            },
        }
        
        local result = LrDialogs.presentModalDialog({
            title = "XCP Platform Publisher - Website",
            contents = contents,
            actionVerb = "Prepare",
        })
        
        if result == 'ok' then
            -- Process photos
            local progress = LrProgressScope({
                title = "Preparing for Website",
                functionContext = context,
            })
            
            local successCount = 0
            local errorCount = 0
            
            catalog:withWriteAccessDo("Prepare for Website", function()
                for i, photo in ipairs(selectedPhotos) do
                    progress:setPortionComplete(i - 1, #selectedPhotos)
                    progress:setCaption(photo:getFormattedMetadata('fileName'))
                    
                    if progress:isCanceled() then
                        break
                    end
                    
                    -- Generate content
                    local contentResult = PrivacyContentMatcher.generateContent(photo, 'website', {
                        brandVoice = props.brandVoice,
                        useAi = prefs.useAiAssist and not props.privacyMode,
                    })
                    
                    if contentResult and contentResult.content then
                        local description = contentResult.content
                        
                        -- Generate SEO-optimized title
                        local style = contentResult.style or 'Photography'
                        local location = contentResult.location or ''
                        local photographerCredit = prefs.photographerCredit or 'XC Photography'
                        
                        local title
                        if props.seoOptimize then
                            -- Keep title under 60 characters for SEO
                            if location ~= '' then
                                title = string.format("%s Photography | %s", 
                                    style:gsub("^%l", string.upper), location)
                            else
                                title = string.format("%s Photography | %s", 
                                    style:gsub("^%l", string.upper), photographerCredit)
                            end
                            if #title > 60 then
                                title = title:sub(1, 57) .. "..."
                            end
                        else
                            title = string.format("%s Photography by %s", 
                                style:gsub("^%l", string.upper), photographerCredit)
                        end
                        
                        -- Set metadata
                        photo:setRawMetadata('title', title)
                        photo:setRawMetadata('caption', description)
                        
                        -- Set headline (used for alt text)
                        if props.generateAltText then
                            local altText = string.format("%s photograph%s by %s",
                                style,
                                location ~= '' and ' in ' .. location or '',
                                photographerCredit
                            )
                            photo:setRawMetadata('headline', altText)
                        end
                        
                        -- Update custom metadata
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpWebsiteReady', 'yes')
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpWebsiteAltText', 
                            photo:getFormattedMetadata('headline') or '')
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPhotoStyle', contentResult.style)
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpLastPrepared', 
                            LrDate.timeToUserFormat(LrDate.currentTime(), "%Y-%m-%d %H:%M"))
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPreparedBy', 
                            contentResult.generatedBy == 'ai_text_only' and 'ai_assisted' or 'template')
                        
                        -- Add SEO-friendly keywords
                        local seoKeywords = {
                            photographerCredit:gsub('%s+', ''),
                            style .. ' photography',
                            'UK photographer',
                            'professional photography',
                        }
                        if location ~= '' then
                            table.insert(seoKeywords, location .. ' photographer')
                        end
                        
                        for _, kwName in ipairs(seoKeywords) do
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
                "Successfully prepared %d photo(s) for website.", 
                successCount
            )
            if errorCount > 0 then
                message = message .. string.format("\n%d photo(s) had errors.", errorCount)
            end
            
            if props.privacyMode then
                message = message .. "\n\n✓ Privacy Mode: No image data was sent externally."
            end
            
            LrDialogs.message("Website Preparation Complete", message, "info")
        end
    end)
end

-- Run the function
LrTasks.startAsyncTask(prepareForWebsite)
