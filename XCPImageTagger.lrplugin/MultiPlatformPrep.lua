--[[----------------------------------------------------------------------------
XCP Platform Publisher - Multi-Platform Preparation
Copyright 2025 XC Photography

Prepares selected images for up to 3 platforms at once:
- Instagram (Social Media)
- Website (Portfolio/Gallery)
- Print Shop (Fine Art/Merchandise)

Fills all IPTC metadata fields and stores platform-specific content
for easy copying to each destination.
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
local LrColor = import 'LrColor'

require 'Logger'
local PrivacyContentMatcher = require 'PrivacyContentMatcher'
local LargeImageHandler = require 'LargeImageHandler'

-- ============================================================================
-- IPTC FIELD MAPPING
-- ============================================================================

local IPTCFields = {
    -- Basic fields
    title = 'title',
    caption = 'caption',
    headline = 'headline',
    
    -- Creator/Copyright
    copyright = 'copyright',
    copyrightState = 'copyrightState',
    creator = 'creator',
    creatorJobTitle = 'creatorJobTitle',
    creatorAddress = 'creatorAddress',
    creatorCity = 'creatorCity',
    creatorStateProvince = 'creatorStateProvince',
    creatorPostalCode = 'creatorPostalCode',
    creatorCountry = 'creatorCountry',
    creatorPhone = 'creatorPhone',
    creatorEmail = 'creatorEmail',
    creatorUrl = 'creatorUrl',
    
    -- Content
    descriptionWriter = 'descriptionWriter',
    instructions = 'instructions',
    
    -- Location
    location = 'location',
    city = 'city',
    stateProvince = 'stateProvince',
    country = 'country',
    isoCountryCode = 'isoCountryCode',
    
    -- Categories
    intellectualGenre = 'intellectualGenre',
    scene = 'scene',
    subjectCode = 'subjectCode',
}

-- ============================================================================
-- PLATFORM-SPECIFIC CONTENT GENERATORS
-- ============================================================================

local function generateInstagramContent(photo, metadata, prefs, options)
    local style = metadata.style or 'photography'
    local location = metadata.location or ''
    local photographerCredit = prefs.photographerCredit or 'XC Photography'
    local instagramHandle = prefs.instagramHandle or '@xcphotography'
    
    -- Build engaging caption with emojis and hashtags
    local captionParts = {}
    
    -- Opening line based on style
    local openings = {
        portrait = "✨ Portrait session vibes",
        event = "⚡ Capturing the energy",
        branding = "💼 Brand photography that tells your story",
        documentary = "📷 Real moments, real stories",
        landscape = "🌄 Nature's beauty captured",
        product = "📸 Product in the spotlight",
        street = "🏙️ Street life",
        general = "📸 Another day behind the lens",
    }
    table.insert(captionParts, openings[style] or openings.general)
    
    -- Location if available
    if location ~= '' then
        table.insert(captionParts, "\n📍 " .. location)
    end
    
    -- Credit line
    table.insert(captionParts, "\n\n" .. photographerCredit)
    table.insert(captionParts, instagramHandle)
    
    -- Hashtags
    local hashtags = {
        "#Photography", "#UKPhotographer", "#" .. style:gsub("^%l", string.upper) .. "Photography",
    }
    
    if location ~= '' then
        local locationTag = location:gsub('%s+', ''):gsub(',', '')
        table.insert(hashtags, "#" .. locationTag)
    end
    
    -- Style-specific hashtags
    local styleHashtags = {
        portrait = {"#PortraitMode", "#Headshots", "#PortraitPhotographer"},
        event = {"#EventPhotography", "#LiveMusic", "#EventPhotographer"},
        branding = {"#BrandPhotography", "#CommercialPhotography", "#BusinessPhotography"},
        documentary = {"#DocumentaryPhotography", "#Storytelling", "#RealMoments"},
        landscape = {"#LandscapePhotography", "#NaturePhotography", "#Outdoors"},
        product = {"#ProductPhotography", "#CommercialPhotography", "#StillLife"},
    }
    
    if styleHashtags[style] then
        for _, tag in ipairs(styleHashtags[style]) do
            table.insert(hashtags, tag)
        end
    end
    
    table.insert(captionParts, "\n\n" .. table.concat(hashtags, " "))
    
    return {
        caption = table.concat(captionParts),
        title = string.format("%s | %s", style:gsub("^%l", string.upper), photographerCredit),
        platform = "Instagram",
    }
end

local function generateWebsiteContent(photo, metadata, prefs, options)
    local style = metadata.style or 'photography'
    local location = metadata.location or ''
    local photographerCredit = prefs.photographerCredit or 'XC Photography'
    local websiteUrl = prefs.websiteUrl or 'xcphotography.co.uk'
    
    -- SEO-optimized title (under 60 chars)
    local title
    if location ~= '' then
        title = string.format("%s Photography in %s | %s", 
            style:gsub("^%l", string.upper), location, photographerCredit)
    else
        title = string.format("%s Photography | %s", 
            style:gsub("^%l", string.upper), photographerCredit)
    end
    
    if #title > 60 then
        title = title:sub(1, 57) .. "..."
    end
    
    -- Professional description
    local descriptions = {
        portrait = "Professional portrait photography capturing authentic expression and personality. Each session is tailored to bring out the subject's unique character through thoughtful composition and natural lighting.",
        event = "Dynamic event photography capturing the energy, emotion, and key moments that make each occasion unique. From corporate events to live performances, every frame tells part of the story.",
        branding = "Strategic brand photography designed to communicate your business identity and values. Professional imagery that elevates your visual presence and connects with your target audience.",
        documentary = "Documentary-style photography that captures life as it unfolds. Authentic, unscripted moments that tell genuine stories and preserve memories in their truest form.",
        landscape = "Fine art landscape photography celebrating the natural beauty of our surroundings. Each image captures the unique atmosphere, light, and character of the location.",
        product = "Professional product photography that showcases your items at their best. Clean, compelling imagery designed to drive engagement and sales.",
        general = "Professional photography services delivering high-quality imagery for personal and commercial projects.",
    }
    
    local caption = descriptions[style] or descriptions.general
    
    if location ~= '' then
        caption = caption .. " Photographed in " .. location .. "."
    end
    
    caption = caption .. " © " .. photographerCredit .. " | " .. websiteUrl
    
    -- Alt text for accessibility
    local altText = string.format("%s photograph%s by %s, %s",
        style:gsub("^%l", string.upper),
        location ~= '' and " taken in " .. location or "",
        photographerCredit,
        "professional photography services UK"
    )
    
    return {
        caption = caption,
        title = title,
        headline = altText,
        platform = "Website",
    }
end

local function generatePrintContent(photo, metadata, prefs, options)
    local style = metadata.style or 'photography'
    local location = metadata.location or ''
    local photographerCredit = prefs.photographerCredit or 'XC Photography'
    local isLimited = options.isLimitedEdition or false
    local editionSize = options.editionSize or '25'
    local seriesName = options.seriesName or ''
    
    -- Elegant gallery title
    local title
    if seriesName ~= '' then
        title = string.format("%s | %s Series", style:gsub("^%l", string.upper), seriesName)
    elseif location ~= '' then
        title = string.format("%s | %s", style:gsub("^%l", string.upper), location)
    else
        title = style:gsub("^%l", string.upper)
    end
    
    if isLimited then
        title = title .. " | Limited Edition"
    end
    
    -- Refined collector-focused description
    local styleDescriptions = {
        portrait = "A captivating portrait study that invites contemplation. This fine art print captures a moment of genuine connection, rendered with masterful attention to light and shadow.",
        event = "A striking moment frozen in time, this print preserves the energy and emotion of live experience. A perfect addition for those who appreciate the power of documentary imagery.",
        branding = "Contemporary commercial photography elevated to fine art. This print demonstrates the intersection of professional imagery and artistic vision.",
        documentary = "From the documentary tradition, this image captures unscripted reality with artistic sensitivity. A powerful statement piece for collectors of authentic photography.",
        landscape = "A breathtaking vista that brings the beauty of the natural world into your space. This fine art landscape print offers a window to somewhere extraordinary.",
        product = "Elevated product photography as fine art. This striking image showcases the beauty found in everyday objects through masterful composition and lighting.",
        general = "A stunning photographic print that commands attention. Gallery-quality imagery that transforms any space.",
    }
    
    local caption = styleDescriptions[style] or styleDescriptions.general
    
    -- Add print details
    caption = caption .. "\n\n"
    caption = caption .. "PRINT DETAILS\n"
    caption = caption .. "• Gallery-quality fine art print\n"
    caption = caption .. "• Archival pigment inks on museum-grade paper\n"
    caption = caption .. "• Signed by the artist\n"
    
    if isLimited then
        caption = caption .. "• Limited edition of " .. editionSize .. "\n"
        caption = caption .. "• Certificate of authenticity included\n"
    end
    
    caption = caption .. "\nPhotographer: " .. photographerCredit
    
    if location ~= '' then
        caption = caption .. "\nLocation: " .. location
    end
    
    return {
        caption = caption,
        title = title,
        platform = "Print Shop",
    }
end

-- ============================================================================
-- MAIN MULTI-PLATFORM DIALOG
-- ============================================================================

local function multiPlatformPrep()
    LrFunctionContext.callWithContext('multiPlatformPrep', function(context)
        local catalog = LrApplication.activeCatalog()
        local selectedPhotos = catalog:getTargetPhotos()
        local prefs = LrPrefs.prefsForPlugin()
        
        if #selectedPhotos == 0 then
            LrDialogs.message(
                "No Photos Selected",
                "Please select one or more photos to prepare for publishing.",
                "info"
            )
            return
        end
        
        -- Create dialog
        local viewFactory = LrView.osFactory()
        local props = LrBinding.makePropertyTable(context)
        
        -- Initialize properties
        props.prepareInstagram = true
        props.prepareWebsite = true
        props.preparePrint = false
        props.privacyMode = true
        props.brandVoice = prefs.brandVoice or 'professional'
        
        -- IPTC Creator info
        props.creator = prefs.photographerCredit or 'XC Photography'
        props.creatorEmail = prefs.creatorEmail or ''
        props.creatorUrl = prefs.websiteUrl or 'xcphotography.co.uk'
        props.copyrightYear = os.date('%Y')
        
        -- Print options
        props.isLimitedEdition = true
        props.editionSize = '25'
        props.seriesName = ''
        
        local contents = viewFactory:column {
            spacing = viewFactory:control_spacing(),
            bind_to_object = props,
            
            viewFactory:static_text {
                title = string.format("Prepare %d photo(s) for Publishing", #selectedPhotos),
                font = "<system/bold>",
            },
            
            viewFactory:static_text {
                title = "Select up to 3 platforms. Content will be generated for each and stored in metadata.",
                wrap = true,
                width_in_chars = 60,
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Platform Selection
            viewFactory:group_box {
                title = "Select Platforms (up to 3)",
                fill_horizontal = 1,
                
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:checkbox {
                        value = LrView.bind 'prepareInstagram',
                        title = "📱 Instagram / Social Media",
                    },
                    viewFactory:static_text {
                        title = "    Engaging captions with hashtags and emojis",
                        font = "<system/small>",
                    },
                    
                    viewFactory:checkbox {
                        value = LrView.bind 'prepareWebsite',
                        title = "🌐 Website / Portfolio",
                    },
                    viewFactory:static_text {
                        title = "    SEO-optimized titles and professional descriptions",
                        font = "<system/small>",
                    },
                    
                    viewFactory:checkbox {
                        value = LrView.bind 'preparePrint',
                        title = "🖼️ Print Shop / Fine Art",
                    },
                    viewFactory:static_text {
                        title = "    Elegant gallery-worthy titles and collector descriptions",
                        font = "<system/small>",
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Privacy Mode
            viewFactory:group_box {
                title = "Privacy Protection",
                fill_horizontal = 1,
                
                viewFactory:column {
                    viewFactory:checkbox {
                        value = LrView.bind 'privacyMode',
                        title = "🔒 Privacy Mode (Recommended)",
                    },
                    viewFactory:static_text {
                        title = "No image data is sent to external AI services. Content is generated from metadata and templates.",
                        wrap = true,
                        width_in_chars = 55,
                        font = "<system/small>",
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- IPTC Creator Information
            viewFactory:group_box {
                title = "IPTC Creator Information",
                fill_horizontal = 1,
                
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Creator/Photographer:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = LrView.bind 'creator',
                            width_in_chars = 30,
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Email:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = LrView.bind 'creatorEmail',
                            width_in_chars = 30,
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Website:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = LrView.bind 'creatorUrl',
                            width_in_chars = 30,
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Copyright Year:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = LrView.bind 'copyrightYear',
                            width_in_chars = 10,
                        },
                    },
                },
            },
            
            viewFactory:separator { fill_horizontal = 1 },
            
            -- Brand Voice
            viewFactory:row {
                viewFactory:static_text {
                    title = "Brand Voice:",
                    width = 130,
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
            
            -- Print Options (shown when print is selected)
            viewFactory:group_box {
                title = "Print Options",
                fill_horizontal = 1,
                visible = LrView.bind 'preparePrint',
                
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:checkbox {
                        value = LrView.bind 'isLimitedEdition',
                        title = "Limited Edition",
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Edition Size:",
                            width = 100,
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
                            width = 100,
                        },
                        viewFactory:edit_field {
                            value = LrView.bind 'seriesName',
                            width_in_chars = 25,
                            placeholder_string = "Optional",
                        },
                    },
                },
            },
        }
        
        local result = LrDialogs.presentModalDialog({
            title = "XCP Platform Publisher - Multi-Platform Preparation",
            contents = contents,
            actionVerb = "Prepare All",
        })
        
        if result == 'ok' then
            -- Validate at least one platform selected
            if not props.prepareInstagram and not props.prepareWebsite and not props.preparePrint then
                LrDialogs.message("No Platforms Selected", "Please select at least one platform.", "warning")
                return
            end
            
            -- Process photos
            local progress = LrProgressScope({
                title = "Preparing for Multiple Platforms",
                functionContext = context,
            })
            
            local successCount = 0
            local errorCount = 0
            local platformCount = (props.prepareInstagram and 1 or 0) + 
                                  (props.prepareWebsite and 1 or 0) + 
                                  (props.preparePrint and 1 or 0)
            
            catalog:withWriteAccessDo("Multi-Platform Preparation", function()
                for i, photo in ipairs(selectedPhotos) do
                    progress:setPortionComplete(i - 1, #selectedPhotos)
                    progress:setCaption(string.format("Processing: %s", 
                        photo:getFormattedMetadata('fileName')))
                    
                    if progress:isCanceled() then
                        break
                    end
                    
                    -- Get base metadata using privacy-first approach
                    local contentResult = PrivacyContentMatcher.generateContent(photo, 'website', {
                        brandVoice = props.brandVoice,
                        useAi = prefs.useAiAssist and not props.privacyMode,
                    })
                    
                    if contentResult then
                        local metadata = {
                            style = contentResult.style,
                            location = contentResult.location,
                            keywords = contentResult.keywords,
                        }
                        
                        local options = {
                            isLimitedEdition = props.isLimitedEdition,
                            editionSize = props.editionSize,
                            seriesName = props.seriesName,
                        }
                        
                        -- Generate content for each selected platform
                        local instagramContent, websiteContent, printContent
                        
                        if props.prepareInstagram then
                            instagramContent = generateInstagramContent(photo, metadata, prefs, options)
                        end
                        
                        if props.prepareWebsite then
                            websiteContent = generateWebsiteContent(photo, metadata, prefs, options)
                        end
                        
                        if props.preparePrint then
                            printContent = generatePrintContent(photo, metadata, prefs, options)
                        end
                        
                        -- ============================================
                        -- SET IPTC FIELDS
                        -- ============================================
                        
                        -- Use website content as primary IPTC data (most SEO-friendly)
                        local primaryContent = websiteContent or instagramContent or printContent
                        
                        -- Basic fields
                        if primaryContent then
                            photo:setRawMetadata('title', primaryContent.title or '')
                            photo:setRawMetadata('caption', primaryContent.caption or '')
                            if primaryContent.headline then
                                photo:setRawMetadata('headline', primaryContent.headline)
                            end
                        end
                        
                        -- Copyright
                        local copyrightText = string.format("© %s %s. All rights reserved.", 
                            props.copyrightYear, props.creator)
                        photo:setRawMetadata('copyright', copyrightText)
                        photo:setRawMetadata('copyrightState', 'copyrighted')
                        
                        -- Creator information
                        photo:setRawMetadata('creator', props.creator)
                        if props.creatorEmail and props.creatorEmail ~= '' then
                            photo:setRawMetadata('creatorEmail', props.creatorEmail)
                        end
                        if props.creatorUrl and props.creatorUrl ~= '' then
                            photo:setRawMetadata('creatorUrl', props.creatorUrl)
                        end
                        
                        -- Location (from existing metadata or detected)
                        if metadata.location and metadata.location ~= '' then
                            -- Don't overwrite existing location data
                            local existingCity = photo:getFormattedMetadata('city')
                            if not existingCity or existingCity == '' then
                                photo:setRawMetadata('location', metadata.location)
                            end
                        end
                        
                        -- Instructions field - store all platform content
                        local instructionsText = "=== PLATFORM-SPECIFIC CONTENT ===\n\n"
                        
                        if instagramContent then
                            instructionsText = instructionsText .. "--- INSTAGRAM ---\n"
                            instructionsText = instructionsText .. instagramContent.caption .. "\n\n"
                        end
                        
                        if websiteContent then
                            instructionsText = instructionsText .. "--- WEBSITE ---\n"
                            instructionsText = instructionsText .. "Title: " .. websiteContent.title .. "\n"
                            instructionsText = instructionsText .. websiteContent.caption .. "\n\n"
                        end
                        
                        if printContent then
                            instructionsText = instructionsText .. "--- PRINT SHOP ---\n"
                            instructionsText = instructionsText .. "Title: " .. printContent.title .. "\n"
                            instructionsText = instructionsText .. printContent.caption .. "\n\n"
                        end
                        
                        photo:setRawMetadata('instructions', instructionsText)
                        
                        -- ============================================
                        -- SET PLUGIN CUSTOM METADATA
                        -- ============================================
                        
                        if props.prepareInstagram then
                            photo:setPropertyForPlugin(_PLUGIN, 'xcpInstagramReady', 'yes')
                            photo:setPropertyForPlugin(_PLUGIN, 'xcpInstagramCaption', 
                                instagramContent and instagramContent.caption or '')
                        end
                        
                        if props.prepareWebsite then
                            photo:setPropertyForPlugin(_PLUGIN, 'xcpWebsiteReady', 'yes')
                            photo:setPropertyForPlugin(_PLUGIN, 'xcpWebsiteAltText', 
                                websiteContent and websiteContent.headline or '')
                        end
                        
                        if props.preparePrint then
                            photo:setPropertyForPlugin(_PLUGIN, 'xcpPrintReady', 'yes')
                            photo:setPropertyForPlugin(_PLUGIN, 'xcpPrintDescription', 
                                printContent and printContent.caption or '')
                        end
                        
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPhotoStyle', metadata.style)
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpLastPrepared', 
                            LrDate.timeToUserFormat(LrDate.currentTime(), "%Y-%m-%d %H:%M"))
                        photo:setPropertyForPlugin(_PLUGIN, 'xcpPreparedBy', 
                            props.privacyMode and 'template' or 'ai_assisted')
                        
                        -- ============================================
                        -- ADD KEYWORDS
                        -- ============================================
                        
                        -- Base keywords
                        local allKeywords = {
                            props.creator:gsub('%s+', ''),
                            'UK Photographer',
                            metadata.style and (metadata.style .. ' photography') or 'photography',
                        }
                        
                        -- Add existing detected keywords
                        if metadata.keywords then
                            for _, kw in ipairs(metadata.keywords) do
                                table.insert(allKeywords, kw)
                            end
                        end
                        
                        -- Platform-specific keywords
                        if props.prepareInstagram then
                            table.insert(allKeywords, 'social media')
                        end
                        if props.preparePrint then
                            table.insert(allKeywords, 'fine art print')
                            table.insert(allKeywords, 'wall art')
                            if props.isLimitedEdition then
                                table.insert(allKeywords, 'limited edition')
                            end
                        end
                        
                        -- Add keywords to photo
                        for _, kwName in ipairs(allKeywords) do
                            if kwName and kwName ~= '' then
                                local keyword = catalog:createKeyword(kwName, {}, true, nil, true)
                                photo:addKeyword(keyword)
                            end
                        end
                        
                        successCount = successCount + 1
                    else
                        errorCount = errorCount + 1
                        logger:errorf('MultiPlatformPrep: Failed to process %s', 
                            photo:getFormattedMetadata('fileName'))
                    end
                    
                    progress:setPortionComplete(i, #selectedPhotos)
                end
            end)
            
            progress:done()
            
            -- Show summary with platform breakdown
            local platformList = {}
            if props.prepareInstagram then table.insert(platformList, "Instagram") end
            if props.prepareWebsite then table.insert(platformList, "Website") end
            if props.preparePrint then table.insert(platformList, "Print Shop") end
            
            local message = string.format(
                "Successfully prepared %d photo(s) for:\n• %s", 
                successCount,
                table.concat(platformList, "\n• ")
            )
            
            if errorCount > 0 then
                message = message .. string.format("\n\n%d photo(s) had errors.", errorCount)
            end
            
            message = message .. "\n\n📋 All platform-specific content is stored in the 'Instructions' IPTC field."
            message = message .. "\nYou can copy/paste the appropriate text for each platform."
            
            if props.privacyMode then
                message = message .. "\n\n🔒 Privacy Mode: No image data was sent externally."
            end
            
            LrDialogs.message("Multi-Platform Preparation Complete", message, "info")
        end
    end)
end

-- Run the function
LrTasks.startAsyncTask(multiPlatformPrep)
