--[[----------------------------------------------------------------------------
SEOTaggingEngine.lua - Professional SEO Tagging for Stock Photography
Copyright 2025 XC Photography

Based on SEO tagging best practices from Clemencey Wright methodology:
- Hierarchical keyword structure (broad → specific)
- Conceptual and emotional keywords alongside descriptive
- Buyer-intent focused tagging
- Platform-specific optimization (Alamy, Shutterstock, Getty, Adobe Stock)
- Natural language variations and synonyms
- Avoiding keyword stuffing while maximizing discoverability
------------------------------------------------------------------------------]]

local SEOTaggingEngine = {}

-- ============================================================================
-- CLEMENCEY WRIGHT SEO TAGGING METHODOLOGY
-- ============================================================================
-- Key principles:
-- 1. Start broad, get specific (hierarchy)
-- 2. Include WHO, WHAT, WHERE, WHEN, WHY, HOW
-- 3. Add conceptual/emotional keywords (not just literal descriptions)
-- 4. Think like a buyer - what would they search for?
-- 5. Use natural language, not just single words
-- 6. Include synonyms and related terms
-- 7. Balance quantity with relevance (25-50 keywords optimal)
-- 8. Front-load most important keywords
-- ============================================================================

-- Primary subject keywords - WHO/WHAT is in the image
SEOTaggingEngine.SubjectKeywords = {
    portrait = {
        primary = {"portrait", "person", "individual", "face", "headshot"},
        descriptive = {"looking at camera", "eye contact", "facial expression", "human", "adult"},
        gender_neutral = {"professional", "businessperson", "worker", "employee"},
        emotional = {"confident", "thoughtful", "serious", "smiling", "contemplative"},
    },
    event = {
        primary = {"event", "gathering", "celebration", "occasion", "function"},
        descriptive = {"crowd", "audience", "attendees", "participants", "guests"},
        types = {"conference", "wedding", "party", "concert", "festival", "ceremony"},
        emotional = {"excitement", "energy", "atmosphere", "memorable", "special moment"},
    },
    branding = {
        primary = {"business", "corporate", "professional", "commercial", "brand"},
        descriptive = {"office", "workplace", "company", "organization", "enterprise"},
        concepts = {"success", "growth", "teamwork", "leadership", "innovation"},
        emotional = {"ambitious", "driven", "successful", "confident", "modern"},
    },
    documentary = {
        primary = {"documentary", "real life", "authentic", "candid", "genuine"},
        descriptive = {"everyday", "lifestyle", "moment", "story", "narrative"},
        concepts = {"truth", "reality", "unscripted", "natural", "spontaneous"},
        emotional = {"raw", "honest", "moving", "powerful", "intimate"},
    },
    landscape = {
        primary = {"landscape", "scenery", "nature", "outdoors", "environment"},
        descriptive = {"vista", "panorama", "horizon", "sky", "terrain"},
        elements = {"mountains", "water", "trees", "clouds", "fields"},
        emotional = {"peaceful", "majestic", "breathtaking", "serene", "dramatic"},
    },
    product = {
        primary = {"product", "item", "object", "merchandise", "goods"},
        descriptive = {"still life", "studio shot", "isolated", "detail", "close up"},
        concepts = {"quality", "design", "craftsmanship", "retail", "commercial"},
        emotional = {"desirable", "premium", "elegant", "modern", "stylish"},
    },
    street = {
        primary = {"street", "urban", "city", "metropolitan", "downtown"},
        descriptive = {"pedestrian", "sidewalk", "pavement", "road", "buildings"},
        concepts = {"everyday life", "urban culture", "society", "community"},
        emotional = {"vibrant", "bustling", "atmospheric", "gritty", "authentic"},
    },
}

-- Technical/Style keywords - HOW was it captured
SEOTaggingEngine.TechnicalKeywords = {
    lighting = {
        natural = {"natural light", "daylight", "sunlight", "golden hour", "blue hour"},
        studio = {"studio lighting", "flash", "strobe", "softbox", "professional lighting"},
        mood = {"dramatic lighting", "high key", "low key", "silhouette", "backlit"},
    },
    composition = {
        framing = {"close up", "medium shot", "wide shot", "full length", "detail shot"},
        perspective = {"eye level", "high angle", "low angle", "bird's eye view", "worm's eye view"},
        style = {"portrait orientation", "landscape orientation", "square format", "panoramic"},
    },
    quality = {
        resolution = {"high resolution", "high quality", "sharp", "detailed", "crisp"},
        professional = {"professional photography", "commercial quality", "stock photo", "editorial"},
    },
}

-- Location keywords - WHERE
SEOTaggingEngine.LocationKeywords = {
    uk_regions = {
        "United Kingdom", "UK", "Britain", "British", "Great Britain",
        "England", "Scotland", "Wales", "Northern Ireland",
    },
    settings = {
        indoor = {"indoor", "interior", "inside", "room", "building"},
        outdoor = {"outdoor", "exterior", "outside", "open air", "al fresco"},
        urban = {"city", "town", "urban", "metropolitan", "downtown", "high street"},
        rural = {"countryside", "rural", "village", "pastoral", "agricultural"},
    },
}

-- Conceptual keywords - WHY would someone use this image
SEOTaggingEngine.ConceptualKeywords = {
    business_use = {
        "marketing", "advertising", "branding", "website", "social media",
        "presentation", "annual report", "brochure", "flyer", "poster",
    },
    editorial_use = {
        "editorial", "news", "article", "blog", "publication",
        "magazine", "newspaper", "journalism", "media", "press",
    },
    creative_use = {
        "background", "texture", "design element", "creative",
        "artistic", "decorative", "wall art", "print", "canvas",
    },
}

-- Emotional/Mood keywords - buyer intent and feeling
SEOTaggingEngine.EmotionalKeywords = {
    positive = {
        "happy", "joyful", "optimistic", "hopeful", "uplifting",
        "inspiring", "motivational", "positive", "cheerful", "bright",
    },
    professional = {
        "professional", "corporate", "business", "formal", "executive",
        "serious", "focused", "determined", "confident", "successful",
    },
    calm = {
        "peaceful", "calm", "serene", "tranquil", "relaxing",
        "zen", "mindful", "meditative", "quiet", "still",
    },
    dramatic = {
        "dramatic", "powerful", "intense", "striking", "bold",
        "impactful", "dynamic", "energetic", "vivid", "strong",
    },
}

-- Color keywords
SEOTaggingEngine.ColorKeywords = {
    primary = {"red", "blue", "green", "yellow", "orange", "purple", "pink"},
    neutral = {"black", "white", "grey", "gray", "brown", "beige", "cream"},
    descriptive = {"colorful", "vibrant", "muted", "pastel", "monochrome", "black and white"},
    mood = {"warm tones", "cool tones", "earth tones", "natural colors"},
}

-- Time/Season keywords - WHEN
SEOTaggingEngine.TemporalKeywords = {
    time_of_day = {"morning", "afternoon", "evening", "night", "dawn", "dusk", "midday"},
    seasons = {"spring", "summer", "autumn", "fall", "winter"},
    concepts = {"timeless", "contemporary", "modern", "classic", "vintage", "retro"},
}

-- ============================================================================
-- KEYWORD GENERATION FUNCTIONS
-- ============================================================================

-- Generate comprehensive keyword list following Clemencey Wright methodology
function SEOTaggingEngine.generateKeywords(style, options)
    local keywords = {}
    local usedKeywords = {}  -- Prevent duplicates
    
    local function addKeyword(kw)
        if kw and kw ~= '' and not usedKeywords[kw:lower()] then
            table.insert(keywords, kw)
            usedKeywords[kw:lower()] = true
        end
    end
    
    local function addKeywordsFromTable(tbl)
        if type(tbl) == "table" then
            for _, kw in ipairs(tbl) do
                addKeyword(kw)
            end
        end
    end
    
    options = options or {}
    local batchContext = options.batchContext or ''
    local location = options.location or ''
    local photographerCredit = options.photographerCredit or 'XC Photography'
    
    -- ========================================
    -- 1. PRIMARY SUBJECT KEYWORDS (most important - front-loaded)
    -- ========================================
    local subjectData = SEOTaggingEngine.SubjectKeywords[style] or SEOTaggingEngine.SubjectKeywords.portrait
    addKeywordsFromTable(subjectData.primary)
    addKeywordsFromTable(subjectData.descriptive)
    
    -- ========================================
    -- 2. BATCH CONTEXT KEYWORDS (user-provided context)
    -- ========================================
    if batchContext ~= '' then
        -- Extract meaningful words from batch context
        for word in batchContext:gmatch("%w+") do
            if #word > 3 then
                addKeyword(word:lower())
            end
        end
        -- Also add the full context as a phrase if short enough
        if #batchContext < 50 then
            addKeyword(batchContext)
        end
    end
    
    -- ========================================
    -- 3. EMOTIONAL/CONCEPTUAL KEYWORDS
    -- ========================================
    addKeywordsFromTable(subjectData.emotional)
    if subjectData.concepts then
        addKeywordsFromTable(subjectData.concepts)
    end
    if subjectData.types then
        addKeywordsFromTable(subjectData.types)
    end
    
    -- ========================================
    -- 4. LOCATION KEYWORDS
    -- ========================================
    if location ~= '' then
        addKeyword(location)
        -- Extract city/region from location
        local firstPart = location:match("^([^,]+)")
        if firstPart then
            addKeyword(firstPart)
        end
    end
    addKeywordsFromTable(SEOTaggingEngine.LocationKeywords.uk_regions)
    
    -- Add appropriate setting keywords
    if style == 'landscape' or style == 'street' then
        addKeywordsFromTable(SEOTaggingEngine.LocationKeywords.settings.outdoor)
    end
    if style == 'street' or style == 'branding' then
        addKeywordsFromTable(SEOTaggingEngine.LocationKeywords.settings.urban)
    end
    
    -- ========================================
    -- 5. TECHNICAL/QUALITY KEYWORDS
    -- ========================================
    addKeywordsFromTable(SEOTaggingEngine.TechnicalKeywords.quality.resolution)
    addKeywordsFromTable(SEOTaggingEngine.TechnicalKeywords.quality.professional)
    
    -- Add style-appropriate composition keywords
    if style == 'portrait' then
        addKeyword("headshot")
        addKeyword("close up portrait")
        addKeyword("professional headshot")
    elseif style == 'landscape' then
        addKeyword("scenic view")
        addKeyword("landscape photography")
        addKeyword("nature photography")
    end
    
    -- ========================================
    -- 6. USE CASE KEYWORDS (buyer intent)
    -- ========================================
    if style == 'branding' or style == 'portrait' then
        addKeywordsFromTable(SEOTaggingEngine.ConceptualKeywords.business_use)
    end
    if style == 'documentary' or style == 'event' or style == 'street' then
        addKeywordsFromTable(SEOTaggingEngine.ConceptualKeywords.editorial_use)
    end
    if style == 'landscape' or style == 'product' then
        addKeywordsFromTable(SEOTaggingEngine.ConceptualKeywords.creative_use)
    end
    
    -- ========================================
    -- 7. PHOTOGRAPHER CREDIT
    -- ========================================
    addKeyword(photographerCredit)
    addKeyword(photographerCredit:gsub('%s+', ''))  -- Without spaces
    
    -- ========================================
    -- 8. GENERAL PHOTOGRAPHY KEYWORDS
    -- ========================================
    addKeyword("photography")
    addKeyword("photograph")
    addKeyword("image")
    addKeyword("photo")
    addKeyword("stock photo")
    addKeyword("royalty free")
    
    return keywords
end

-- Generate a descriptive title following SEO best practices
function SEOTaggingEngine.generateTitle(style, options)
    options = options or {}
    local batchContext = options.batchContext or ''
    local location = options.location or ''
    
    local titleParts = {}
    
    -- Primary subject descriptor
    local styleTitles = {
        portrait = "Professional Portrait",
        event = "Event Photography",
        branding = "Corporate Business Photography",
        documentary = "Documentary Photograph",
        landscape = "Scenic Landscape",
        product = "Product Photography",
        street = "Urban Street Photography",
    }
    table.insert(titleParts, styleTitles[style] or "Professional Photography")
    
    -- Add context if provided
    if batchContext ~= '' and #batchContext < 40 then
        table.insert(titleParts, "-")
        table.insert(titleParts, batchContext)
    end
    
    -- Add location
    if location ~= '' then
        table.insert(titleParts, "in")
        table.insert(titleParts, location)
    end
    
    -- Add UK identifier
    table.insert(titleParts, "- UK")
    
    local title = table.concat(titleParts, " ")
    
    -- Ensure title is within optimal length (50-200 chars for Alamy)
    if #title > 200 then
        title = title:sub(1, 197) .. "..."
    end
    
    return title
end

-- Generate a detailed description optimized for stock platforms
function SEOTaggingEngine.generateDescription(style, options)
    options = options or {}
    local batchContext = options.batchContext or ''
    local location = options.location or ''
    local photographerCredit = options.photographerCredit or 'XC Photography'
    
    local parts = {}
    
    -- Opening sentence - what is the image
    local openings = {
        portrait = "Professional portrait photograph capturing authentic character and expression.",
        event = "Dynamic event photography documenting memorable moments and atmosphere.",
        branding = "High-quality commercial photography for business and brand applications.",
        documentary = "Authentic documentary photograph capturing real-life moments.",
        landscape = "Stunning landscape photography showcasing natural beauty and scenery.",
        product = "Clean, professional product photography with attention to detail.",
        street = "Candid street photography capturing urban life and culture.",
    }
    table.insert(parts, openings[style] or "Professional photography with high technical quality.")
    
    -- Context sentence
    if batchContext ~= '' then
        table.insert(parts, batchContext .. ".")
    end
    
    -- Use case sentence
    local useCases = {
        portrait = "Ideal for corporate websites, LinkedIn profiles, marketing materials, and editorial features.",
        event = "Perfect for event coverage, venue promotion, editorial publications, and marketing campaigns.",
        branding = "Suitable for websites, annual reports, presentations, advertising, and promotional materials.",
        documentary = "Excellent for editorial features, news publications, awareness campaigns, and educational materials.",
        landscape = "Great for travel publications, wall art, calendars, destination marketing, and environmental campaigns.",
        product = "Perfect for e-commerce, catalogs, advertising, packaging design, and retail marketing.",
        street = "Suitable for editorial content, travel features, urban planning materials, and lifestyle publications.",
    }
    table.insert(parts, useCases[style] or "Versatile for various editorial and commercial applications.")
    
    -- Location sentence
    if location ~= '' then
        table.insert(parts, "Photographed in " .. location .. ", United Kingdom.")
    else
        table.insert(parts, "Photographed in the United Kingdom.")
    end
    
    -- Technical quality statement
    table.insert(parts, "High resolution image available for commercial and editorial licensing.")
    
    -- Credit
    table.insert(parts, "© " .. photographerCredit .. ".")
    
    return table.concat(parts, " ")
end

-- Get keyword count recommendation for different platforms
function SEOTaggingEngine.getKeywordRecommendation(platform)
    local recommendations = {
        alamy = { min = 10, optimal = 25, max = 50 },
        shutterstock = { min = 7, optimal = 25, max = 50 },
        getty = { min = 5, optimal = 25, max = 50 },
        adobe = { min = 5, optimal = 25, max = 50 },
        general = { min = 10, optimal = 30, max = 50 },
    }
    return recommendations[platform] or recommendations.general
end

-- Validate and optimize keyword list
function SEOTaggingEngine.optimizeKeywords(keywords, platform)
    local recommendation = SEOTaggingEngine.getKeywordRecommendation(platform)
    
    -- Remove duplicates (case-insensitive)
    local seen = {}
    local unique = {}
    for _, kw in ipairs(keywords) do
        local lower = kw:lower()
        if not seen[lower] and kw ~= '' then
            seen[lower] = true
            table.insert(unique, kw)
        end
    end
    
    -- Limit to max keywords if necessary
    if #unique > recommendation.max then
        local trimmed = {}
        for i = 1, recommendation.max do
            trimmed[i] = unique[i]
        end
        return trimmed, #unique - recommendation.max
    end
    
    return unique, 0
end

return SEOTaggingEngine
