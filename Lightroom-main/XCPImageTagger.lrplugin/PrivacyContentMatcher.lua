--[[----------------------------------------------------------------------------
XCP Platform Publisher - Privacy-First Content Matcher
Copyright 2025 XC Photography

A privacy-focused content matching system that generates titles, captions,
and keywords WITHOUT sending images to AI services.

PRIVACY PROTECTION FEATURES:
1. No image data leaves your computer
2. Uses EXIF/metadata analysis only
3. Matches content based on existing catalog keywords and collections
4. Learns from your existing captioning patterns
5. Never contributes to AI training datasets

This protects photographers' intellectual property and visual style from
being learned or replicated by AI image generation systems.
------------------------------------------------------------------------------]]

local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'
local LrPrefs = import 'LrPrefs'
local LrDate = import 'LrDate'
local LrStringUtils = import 'LrStringUtils'
local LrHttp = import 'LrHttp'

local JSON = require 'JSON'
require 'Logger'

PrivacyContentMatcher = {}

-- ============================================================================
-- PRIVACY-FIRST METADATA EXTRACTION
-- No image data is transmitted - only text metadata is analyzed
-- ============================================================================

-- Extract all available text metadata from a photo
function PrivacyContentMatcher.extractTextMetadata(photo)
    local metadata = {
        -- Basic info
        fileName = photo:getFormattedMetadata('fileName') or '',
        fileType = photo:getFormattedMetadata('fileType') or '',
        
        -- Existing user-entered metadata
        title = photo:getFormattedMetadata('title') or '',
        caption = photo:getFormattedMetadata('caption') or '',
        headline = photo:getFormattedMetadata('headline') or '',
        
        -- Location data
        city = photo:getFormattedMetadata('city') or '',
        stateProvince = photo:getFormattedMetadata('stateProvince') or '',
        country = photo:getFormattedMetadata('country') or '',
        location = photo:getFormattedMetadata('location') or '',
        gps = photo:getFormattedMetadata('gps') or '',
        
        -- Camera/Technical
        cameraMake = photo:getFormattedMetadata('cameraMake') or '',
        cameraModel = photo:getFormattedMetadata('cameraModel') or '',
        lens = photo:getFormattedMetadata('lens') or '',
        focalLength = photo:getFormattedMetadata('focalLength') or '',
        aperture = photo:getFormattedMetadata('aperture') or '',
        shutterSpeed = photo:getFormattedMetadata('shutterSpeed') or '',
        isoSpeedRating = photo:getFormattedMetadata('isoSpeedRating') or '',
        flash = photo:getFormattedMetadata('flash') or '',
        
        -- Date/Time
        dateTimeOriginal = photo:getFormattedMetadata('dateTimeOriginal') or '',
        
        -- Copyright
        copyright = photo:getFormattedMetadata('copyright') or '',
        creator = photo:getFormattedMetadata('creator') or '',
        
        -- Dimensions
        dimensions = photo:getFormattedMetadata('dimensions') or '',
        croppedDimensions = photo:getFormattedMetadata('croppedDimensions') or '',
        
        -- Rating and flags
        rating = photo:getRawMetadata('rating') or 0,
        colorLabel = photo:getRawMetadata('colorNameForLabel') or '',
        
        -- Keywords (existing)
        keywords = {},
        
        -- Collections
        collections = {},
    }
    
    -- Get existing keywords
    local keywordsList = photo:getRawMetadata('keywords') or {}
    for _, keyword in ipairs(keywordsList) do
        local name = keyword:getName()
        if name and name ~= '' then
            table.insert(metadata.keywords, name)
        end
    end
    
    -- Get collection names (can indicate subject/project type)
    local containedCollections = photo:getContainedCollections() or {}
    for _, collection in ipairs(containedCollections) do
        local name = collection:getName()
        if name and name ~= '' then
            table.insert(metadata.collections, name)
        end
    end
    
    return metadata
end

-- ============================================================================
-- PATTERN LEARNING FROM YOUR CATALOG
-- Learns from YOUR existing captions, not external data
-- ============================================================================

-- Analyze patterns in existing catalog captions
function PrivacyContentMatcher.learnFromCatalog()
    local catalog = LrApplication.activeCatalog()
    local patterns = {
        titlePatterns = {},
        captionPatterns = {},
        keywordGroups = {},
        locationFormats = {},
        styleIndicators = {},
    }
    
    -- Sample existing photos with captions
    local allPhotos = catalog:getAllPhotos()
    local sampledCount = 0
    local maxSamples = 100 -- Limit to avoid performance issues
    
    for _, photo in ipairs(allPhotos) do
        if sampledCount >= maxSamples then break end
        
        local title = photo:getFormattedMetadata('title') or ''
        local caption = photo:getFormattedMetadata('caption') or ''
        
        if title ~= '' or caption ~= '' then
            sampledCount = sampledCount + 1
            
            -- Extract title patterns (word count, structure)
            if title ~= '' then
                local wordCount = select(2, title:gsub('%S+', ''))
                patterns.titlePatterns[wordCount] = (patterns.titlePatterns[wordCount] or 0) + 1
            end
            
            -- Extract caption sentence patterns
            if caption ~= '' then
                local sentenceCount = select(2, caption:gsub('[.!?]', ''))
                patterns.captionPatterns[sentenceCount] = (patterns.captionPatterns[sentenceCount] or 0) + 1
                
                -- Check for hashtag usage
                if caption:find('#') then
                    patterns.styleIndicators.usesHashtags = true
                end
                
                -- Check for emoji usage
                if caption:find('[\128-\255]') then
                    patterns.styleIndicators.usesEmoji = true
                end
            end
            
            -- Build keyword co-occurrence groups
            local keywords = photo:getRawMetadata('keywords') or {}
            local kwNames = {}
            for _, kw in ipairs(keywords) do
                table.insert(kwNames, kw:getName())
            end
            if #kwNames > 1 then
                local groupKey = table.concat(kwNames, '|')
                patterns.keywordGroups[groupKey] = (patterns.keywordGroups[groupKey] or 0) + 1
            end
        end
    end
    
    logger:infof('PrivacyContentMatcher: Learned from %d catalog photos', sampledCount)
    return patterns
end

-- ============================================================================
-- CONTENT MATCHING WITHOUT IMAGE ANALYSIS
-- Uses metadata, keywords, collections, and filename patterns
-- ============================================================================

-- Detect photography style from metadata clues
function PrivacyContentMatcher.detectStyle(metadata)
    local style = 'general'
    local confidence = 0.5
    
    -- Check collections for style hints
    for _, collName in ipairs(metadata.collections) do
        local lowerName = collName:lower()
        if lowerName:find('portrait') or lowerName:find('headshot') then
            style = 'portrait'
            confidence = 0.9
        elseif lowerName:find('event') or lowerName:find('wedding') or lowerName:find('concert') or lowerName:find('gig') then
            style = 'event'
            confidence = 0.9
        elseif lowerName:find('brand') or lowerName:find('commercial') or lowerName:find('product') then
            style = 'branding'
            confidence = 0.9
        elseif lowerName:find('documentary') or lowerName:find('street') then
            style = 'documentary'
            confidence = 0.9
        elseif lowerName:find('landscape') or lowerName:find('nature') then
            style = 'landscape'
            confidence = 0.9
        end
    end
    
    -- Check keywords for style hints
    for _, keyword in ipairs(metadata.keywords) do
        local lowerKw = keyword:lower()
        if style == 'general' then
            if lowerKw:find('portrait') or lowerKw:find('headshot') or lowerKw:find('model') then
                style = 'portrait'
                confidence = 0.8
            elseif lowerKw:find('event') or lowerKw:find('live') or lowerKw:find('concert') then
                style = 'event'
                confidence = 0.8
            elseif lowerKw:find('brand') or lowerKw:find('corporate') then
                style = 'branding'
                confidence = 0.8
            end
        end
    end
    
    -- Check camera settings for hints
    local focalNum = tonumber(metadata.focalLength:match('%d+')) or 0
    local apertureNum = tonumber(metadata.aperture:match('%d+%.?%d*')) or 0
    
    if style == 'general' then
        -- Wide angle + small aperture often = landscape
        if focalNum > 0 and focalNum <= 35 and apertureNum >= 8 then
            style = 'landscape'
            confidence = 0.6
        -- 85mm+ with wide aperture often = portrait
        elseif focalNum >= 85 and apertureNum > 0 and apertureNum <= 2.8 then
            style = 'portrait'
            confidence = 0.6
        end
    end
    
    -- Check filename patterns
    local fileName = metadata.fileName:lower()
    if fileName:find('portrait') or fileName:find('headshot') then
        style = 'portrait'
        confidence = math.max(confidence, 0.7)
    elseif fileName:find('event') or fileName:find('gig') or fileName:find('concert') then
        style = 'event'
        confidence = math.max(confidence, 0.7)
    end
    
    return style, confidence
end

-- Build location string from metadata
function PrivacyContentMatcher.buildLocationString(metadata, format)
    local parts = {}
    
    if format == 'full' then
        if metadata.location ~= '' then table.insert(parts, metadata.location) end
        if metadata.city ~= '' then table.insert(parts, metadata.city) end
        if metadata.stateProvince ~= '' then table.insert(parts, metadata.stateProvince) end
        if metadata.country ~= '' then table.insert(parts, metadata.country) end
    elseif format == 'short' then
        if metadata.city ~= '' then 
            table.insert(parts, metadata.city)
        end
        if metadata.country ~= '' then
            table.insert(parts, metadata.country)
        end
    elseif format == 'hashtag' then
        if metadata.city ~= '' then 
            table.insert(parts, metadata.city:gsub('%s+', ''))
        end
        if metadata.country ~= '' then
            table.insert(parts, metadata.country:gsub('%s+', ''))
        end
    end
    
    return table.concat(parts, ', ')
end

-- ============================================================================
-- OLLAMA TEXT-ONLY MODE
-- Uses Ollama for text generation but NEVER sends image data
-- ============================================================================

function PrivacyContentMatcher.generateWithOllamaTextOnly(metadata, platform, brandVoice)
    local prefs = LrPrefs.prefsForPlugin()
    local baseUrl = prefs.ollamaBaseUrl or 'http://localhost:11434'
    local model = prefs.ollamaTextModel or 'llama3:latest' -- Text-only model
    
    -- Build a text-only prompt from metadata
    local style, confidence = PrivacyContentMatcher.detectStyle(metadata)
    local location = PrivacyContentMatcher.buildLocationString(metadata, 'full')
    
    local contextPrompt = string.format([[
You are helping a UK-based professional photographer prepare image metadata.
DO NOT describe what you think the image looks like - you cannot see it.
Instead, generate appropriate metadata based on the following information:

PHOTOGRAPHY STYLE: %s (confidence: %.0f%%)
EXISTING KEYWORDS: %s
COLLECTIONS: %s
LOCATION: %s
CAMERA: %s %s with %s
SETTINGS: %s at f/%s, %s, ISO %s
DATE TAKEN: %s
PHOTOGRAPHER: %s

Based on this metadata, generate a %s-style %s for this %s photograph.

Brand voice: %s
Use British English spelling.

Respond with ONLY the generated text, no explanations.
]], 
        style, confidence * 100,
        #metadata.keywords > 0 and table.concat(metadata.keywords, ', ') or 'none provided',
        #metadata.collections > 0 and table.concat(metadata.collections, ', ') or 'none',
        location ~= '' and location or 'not specified',
        metadata.cameraMake, metadata.cameraModel, metadata.lens ~= '' and metadata.lens or 'unknown lens',
        metadata.focalLength, metadata.aperture, metadata.shutterSpeed, metadata.isoSpeedRating,
        metadata.dateTimeOriginal ~= '' and metadata.dateTimeOriginal or 'not recorded',
        prefs.photographerCredit or 'XC Photography',
        platform,
        platform == 'instagram' and 'caption with relevant hashtags' or 
        platform == 'website' and 'SEO-optimized description' or 
        'elegant print description',
        style,
        brandVoice
    )
    
    local reqHeaders = {
        { field = 'Content-Type', value = 'application/json' },
        { field = 'Accept', value = 'application/json' },
    }
    
    local reqBody = JSON:encode({
        model = model,
        prompt = contextPrompt,
        stream = false,
        options = {
            temperature = 0.7,
            num_predict = 500
        }
    })
    
    local serviceUri = string.format('%s/api/generate', baseUrl)
    
    logger:infof('PrivacyContentMatcher: Sending TEXT-ONLY request to Ollama (no image data)')
    
    local resBody, resHeaders = LrHttp.post(serviceUri, reqBody, reqHeaders, 'POST', 60)
    
    if not resBody or (resHeaders and resHeaders.status ~= 200) then
        logger:errorf('PrivacyContentMatcher: Ollama request failed')
        return nil, 'Ollama request failed'
    end
    
    local resJson = JSON:decode(resBody)
    if resJson and resJson.response then
        return resJson.response, nil
    end
    
    return nil, 'Invalid response from Ollama'
end

-- ============================================================================
-- TEMPLATE-BASED GENERATION (No AI, Maximum Privacy)
-- ============================================================================

function PrivacyContentMatcher.generateFromTemplate(metadata, platform, brandVoice)
    local prefs = LrPrefs.prefsForPlugin()
    local style, _ = PrivacyContentMatcher.detectStyle(metadata)
    local location = PrivacyContentMatcher.buildLocationString(metadata, 'short')
    local locationHashtag = PrivacyContentMatcher.buildLocationString(metadata, 'hashtag')
    
    local photographerCredit = prefs.photographerCredit or 'XC Photography'
    local instagramHandle = prefs.instagramHandle or '@xcphotography'
    
    -- Build keyword string
    local keywordStr = ''
    if #metadata.keywords > 0 then
        local displayKeywords = {}
        for i = 1, math.min(5, #metadata.keywords) do
            table.insert(displayKeywords, metadata.keywords[i])
        end
        keywordStr = table.concat(displayKeywords, ', ')
    end
    
    -- Templates by platform and style
    local templates = {
        instagram = {
            portrait = {
                professional = string.format([[Portrait session ✨

%s

📸 %s
%s

#PortraitPhotography #UKPhotographer #ProfessionalPortrait %s #Photography]], 
                    location ~= '' and '📍 ' .. location or '',
                    photographerCredit,
                    location ~= '' and '#' .. locationHashtag or '',
                    keywordStr ~= '' and '#' .. keywordStr:gsub(', ', ' #'):gsub('%s+', '') or ''
                ),
                friendly = string.format([[Had such a great time on this portrait session! 📸

%s

Shot by %s
%s

#Portraits #Photography #UKPhotographer %s]], 
                    location ~= '' and 'Location: ' .. location or '',
                    instagramHandle,
                    location ~= '' and '#' .. locationHashtag or '',
                    keywordStr ~= '' and '#' .. keywordStr:gsub(', ', ' #'):gsub('%s+', '') or ''
                ),
            },
            event = {
                professional = string.format([[Live moments captured ⚡

%s

📸 %s
#EventPhotography #LivePhotography #UKEvents %s %s]], 
                    location ~= '' and '📍 ' .. location or '',
                    photographerCredit,
                    location ~= '' and '#' .. locationHashtag or '',
                    keywordStr ~= '' and '#' .. keywordStr:gsub(', ', ' #'):gsub('%s+', '') or ''
                ),
            },
            branding = {
                professional = string.format([[Brand photography that tells your story 💼

%s

📸 %s
#BrandPhotography #CommercialPhotography #UKBusiness %s]], 
                    location ~= '' and '📍 ' .. location or '',
                    photographerCredit,
                    keywordStr ~= '' and '#' .. keywordStr:gsub(', ', ' #'):gsub('%s+', '') or ''
                ),
            },
            documentary = {
                professional = string.format([[Real moments. Real stories. 📷

%s

%s
#DocumentaryPhotography #Storytelling #AuthenticMoments %s]], 
                    location ~= '' and '📍 ' .. location or '',
                    photographerCredit,
                    keywordStr ~= '' and '#' .. keywordStr:gsub(', ', ' #'):gsub('%s+', '') or ''
                ),
            },
            general = {
                professional = string.format([[📸 %s

%s

#Photography #UKPhotographer %s %s]], 
                    photographerCredit,
                    location ~= '' and '📍 ' .. location or '',
                    location ~= '' and '#' .. locationHashtag or '',
                    keywordStr ~= '' and '#' .. keywordStr:gsub(', ', ' #'):gsub('%s+', '') or ''
                ),
            },
        },
        
        website = {
            portrait = {
                professional = string.format([[Professional portrait photography%s. This session showcases thoughtful composition and authentic expression, captured by %s.%s]], 
                    location ~= '' and ' in ' .. location or '',
                    photographerCredit,
                    keywordStr ~= '' and ' Keywords: ' .. keywordStr .. '.' or ''
                ),
            },
            event = {
                professional = string.format([[Event photography coverage%s by %s. Documentary-style imagery capturing the energy and key moments.%s]], 
                    location ~= '' and ' in ' .. location or '',
                    photographerCredit,
                    keywordStr ~= '' and ' Keywords: ' .. keywordStr .. '.' or ''
                ),
            },
            branding = {
                professional = string.format([[Commercial brand photography%s. Professional imagery by %s designed to communicate your brand story effectively.%s]], 
                    location ~= '' and ' in ' .. location or '',
                    photographerCredit,
                    keywordStr ~= '' and ' Keywords: ' .. keywordStr .. '.' or ''
                ),
            },
            general = {
                professional = string.format([[Professional photography%s by %s.%s]], 
                    location ~= '' and ' in ' .. location or '',
                    photographerCredit,
                    keywordStr ~= '' and ' Keywords: ' .. keywordStr .. '.' or ''
                ),
            },
        },
        
        print = {
            portrait = {
                professional = string.format([[Fine Art Portrait Print

%sA stunning portrait print capturing authentic expression and emotion. Gallery-quality printing on archival paper.

Photographer: %s
Edition: Limited]], 
                    location ~= '' and 'Location: ' .. location .. '\n' or '',
                    photographerCredit
                ),
            },
            landscape = {
                professional = string.format([[Fine Art Landscape Print

%sCapturing the natural beauty and atmosphere of this stunning location. Printed on archival-quality paper for lasting colour and detail.

Photographer: %s
Edition: Limited]], 
                    location ~= '' and location .. '\n' or '',
                    photographerCredit
                ),
            },
            general = {
                professional = string.format([[Fine Art Print

%sGallery-quality photography print on archival paper. A timeless piece for collectors and art enthusiasts.

Photographer: %s
Edition: Limited]], 
                    location ~= '' and 'Location: ' .. location .. '\n' or '',
                    photographerCredit
                ),
            },
        },
    }
    
    -- Get appropriate template
    local platformTemplates = templates[platform] or templates.instagram
    local styleTemplates = platformTemplates[style] or platformTemplates.general
    local template = styleTemplates[brandVoice] or styleTemplates.professional or styleTemplates[next(styleTemplates)]
    
    return template or 'Professional photography by ' .. photographerCredit
end

-- ============================================================================
-- MAIN INTERFACE
-- ============================================================================

-- Generate content for a photo without sending image data anywhere
function PrivacyContentMatcher.generateContent(photo, platform, options)
    options = options or {}
    local prefs = LrPrefs.prefsForPlugin()
    local brandVoice = options.brandVoice or prefs.brandVoice or 'professional'
    local useAi = options.useAi and prefs.useAiAssist
    
    -- Extract metadata (text only, no image data)
    local metadata = PrivacyContentMatcher.extractTextMetadata(photo)
    
    local content, error
    
    if useAi and prefs.aiProvider == 'ollama' then
        -- Use Ollama in TEXT-ONLY mode
        logger:infof('PrivacyContentMatcher: Using Ollama TEXT-ONLY mode (image data protected)')
        content, error = PrivacyContentMatcher.generateWithOllamaTextOnly(metadata, platform, brandVoice)
        
        if error then
            logger:warnf('PrivacyContentMatcher: Ollama failed, falling back to template: %s', error)
            content = PrivacyContentMatcher.generateFromTemplate(metadata, platform, brandVoice)
        end
    else
        -- Use template-based generation (no AI, maximum privacy)
        logger:infof('PrivacyContentMatcher: Using template-based generation (maximum privacy)')
        content = PrivacyContentMatcher.generateFromTemplate(metadata, platform, brandVoice)
    end
    
    -- Detect style for metadata
    local style, confidence = PrivacyContentMatcher.detectStyle(metadata)
    
    return {
        content = content,
        style = style,
        styleConfidence = confidence,
        location = PrivacyContentMatcher.buildLocationString(metadata, 'short'),
        keywords = metadata.keywords,
        generatedBy = useAi and 'ai_text_only' or 'template',
        privacyMode = true, -- Flag that no image data was transmitted
    }
end

-- Get available text-only models for Ollama
function PrivacyContentMatcher.getTextOnlyModels()
    return {
        { title = 'Llama 3 (8B)', value = 'llama3:latest' },
        { title = 'Llama 3 (70B)', value = 'llama3:70b' },
        { title = 'Mistral (7B)', value = 'mistral:latest' },
        { title = 'Mixtral (8x7B)', value = 'mixtral:latest' },
        { title = 'Phi-3 (3.8B)', value = 'phi3:latest' },
        { title = 'Gemma 2 (9B)', value = 'gemma2:latest' },
        { title = 'Qwen 2 (7B)', value = 'qwen2:latest' },
    }
end

return PrivacyContentMatcher
