--[[----------------------------------------------------------------------------
PromptPresets.lua - Platform-specific prompt presets for XCP Image Tagger
Copyright 2025 XC Photography

Provides pre-configured prompts optimized for different platforms:
- Social Media (Instagram, Facebook, Twitter/X)
- Website (Portfolio, Blog, Gallery)  
- Print & Gifts (Fine Art Prints, Merchandise)
------------------------------------------------------------------------------]]

local PromptPresets = {}

-- ============================================================================
-- SOCIAL MEDIA PRESETS
-- ============================================================================
PromptPresets.SocialMedia = {
    name = "Social Media",
    description = "Engaging content for Instagram, Facebook, Twitter/X with hashtags and emojis",
    
    prompt = [[Please analyze this photograph and provide metadata optimized for social media platforms (Instagram, Facebook, Twitter/X).

Generate:
1. A catchy, attention-grabbing title (2-5 words, can include emoji)
2. An engaging caption that encourages interaction (1-3 sentences with 3-5 relevant hashtags)
3. A brief headline/description for sharing (1 sentence)
4. 10-15 relevant keywords including trending hashtags (without # symbol)
5. Suggested posting time or content tips
6. Location if identifiable (use location tags format)

Style guidelines:
- Use conversational, friendly tone
- Include 1-2 tasteful emojis where appropriate
- Keep hashtags relevant and mix popular + niche tags
- Consider engagement hooks (questions, calls to action)

Please format your response as JSON:
{
  "title": "catchy title here",
  "caption": "engaging caption with hashtags",
  "headline": "shareable description",
  "keywords": "keyword1, keyword2, hashtag1, hashtag2",
  "instructions": "posting suggestions",
  "location": "location tag if applicable"
}

Photographer credit: XC Photography (@xcphotography)]],
    
    defaultLanguage = "English",
    maxTitleLength = 100,
    maxCaptionLength = 2200,
}

-- ============================================================================
-- WEBSITE/PORTFOLIO PRESETS
-- ============================================================================
PromptPresets.Website = {
    name = "Website/Portfolio",
    description = "SEO-optimized professional content for portfolio websites and blogs",
    
    prompt = [[Please analyze this photograph and provide metadata optimized for professional photography portfolio websites.

Generate:
1. A professional, SEO-friendly title (under 60 characters)
2. An informative caption suitable for portfolio display (2-3 sentences)
3. A detailed headline/alt text for accessibility and SEO (1-2 sentences)
4. 8-12 professional keywords for search optimization
5. Technical notes or artistic commentary
6. Location information if identifiable

Style guidelines:
- Use professional, polished language
- Focus on artistic and technical merit
- Optimize for search engines (include relevant descriptive terms)
- Describe composition, lighting, mood, and subject
- Suitable for professional portfolio presentation

Please format your response as JSON:
{
  "title": "SEO-optimized professional title",
  "caption": "detailed portfolio caption",
  "headline": "descriptive alt text for accessibility",
  "keywords": "professional, keyword1, keyword2, photography",
  "instructions": "display or usage notes",
  "location": "location name if applicable"
}

Photography by XC Photography - Professional Branding & Documentary Photography]],
    
    defaultLanguage = "English",
    maxTitleLength = 60,
    maxCaptionLength = 500,
}

-- ============================================================================
-- PRINT & GIFTS PRESETS
-- ============================================================================
PromptPresets.PrintGifts = {
    name = "Print & Gifts",
    description = "Elegant descriptions for fine art prints and merchandise",
    
    prompt = [[Please analyze this photograph and provide metadata suitable for fine art prints and merchandise sales.

Generate:
1. An elegant, gallery-worthy title (2-6 words)
2. A refined description that would appeal to art collectors (2-4 sentences)
3. A compelling headline for product listings (1-2 sentences)
4. 8-12 keywords suitable for art print marketplaces
5. Suggested print sizes, framing options, or display recommendations
6. Location or series information if applicable

Style guidelines:
- Use sophisticated, refined language
- Emphasize artistic value and emotional impact
- Consider what would appeal to art collectors and gift buyers
- Describe the mood, atmosphere, and what makes it special
- Suitable for gallery presentation and high-end merchandise

Please format your response as JSON:
{
  "title": "elegant gallery title",
  "caption": "refined collector-focused description",
  "headline": "compelling product headline",
  "keywords": "fine art, wall art, print, photography",
  "instructions": "print and framing recommendations",
  "location": "location or series name"
}

Limited Edition Fine Art Print by XC Photography]],
    
    defaultLanguage = "English",
    maxTitleLength = 100,
    maxCaptionLength = 1000,
}

-- ============================================================================
-- STOCK PHOTOGRAPHY PRESET
-- ============================================================================
PromptPresets.Stock = {
    name = "Stock Photography",
    description = "Keyword-rich metadata for stock photography platforms",
    
    prompt = [[Please analyze this photograph and provide metadata optimized for stock photography platforms.

Generate:
1. A clear, descriptive title (50-70 characters)
2. A detailed description for stock buyers (2-3 sentences, include use cases)
3. A concise headline (1 sentence)
4. 25-50 highly relevant keywords for maximum discoverability
5. Suggested categories and use cases
6. Model release notes if people are visible

Style guidelines:
- Be extremely descriptive and specific
- Include conceptual and emotional keywords
- Think about how buyers would search for this image
- Include variations (singular/plural, synonyms)
- Cover subject, mood, style, colors, concepts

Please format your response as JSON:
{
  "title": "descriptive stock title",
  "caption": "detailed stock description with use cases",
  "headline": "concise headline",
  "keywords": "extensive, comma, separated, keyword, list",
  "instructions": "categories and licensing notes",
  "location": "generic or specific location"
}]],
    
    defaultLanguage = "English",
    maxTitleLength = 200,
    maxCaptionLength = 500,
}

-- ============================================================================
-- EVENT PHOTOGRAPHY PRESET
-- ============================================================================
PromptPresets.Event = {
    name = "Event Photography",
    description = "Metadata for event coverage and live photography",
    
    prompt = [[Please analyze this photograph from an event and provide appropriate metadata.

Generate:
1. A descriptive title capturing the moment (3-6 words)
2. A caption describing the action/moment (1-2 sentences)
3. A headline suitable for event galleries (1 sentence)
4. 10-15 relevant keywords for event photography
5. Notes about the type of event, moment captured, or significance
6. Location or venue if identifiable

Style guidelines:
- Capture the energy and atmosphere
- Be specific about the moment or action
- Consider who might want this photo (organizers, participants, press)
- Include event-related terminology

Please format your response as JSON:
{
  "title": "event moment title",
  "caption": "description of the moment",
  "headline": "event gallery headline",
  "keywords": "event, photography, keywords",
  "instructions": "usage or moment notes",
  "location": "venue or event name"
}

Event Coverage by XC Photography]],
    
    defaultLanguage = "English",
    maxTitleLength = 100,
    maxCaptionLength = 300,
}

-- ============================================================================
-- PRESET ACCESS FUNCTIONS
-- ============================================================================

-- Get all available presets
function PromptPresets.getPresets()
    return {
        SocialMedia = PromptPresets.SocialMedia,
        Website = PromptPresets.Website,
        PrintGifts = PromptPresets.PrintGifts,
        Stock = PromptPresets.Stock,
        Event = PromptPresets.Event,
    }
end

-- Get preset names for UI dropdown
function PromptPresets.getPresetNames()
    return {
        { title = "Social Media", value = "SocialMedia" },
        { title = "Website/Portfolio", value = "Website" },
        { title = "Print & Gifts", value = "PrintGifts" },
        { title = "Stock Photography", value = "Stock" },
        { title = "Event Photography", value = "Event" },
    }
end

-- Get a specific preset by name
function PromptPresets.getPreset(name)
    local presets = PromptPresets.getPresets()
    return presets[name] or PromptPresets.SocialMedia
end

-- Get the prompt text for a specific preset
function PromptPresets.getPromptText(name)
    local preset = PromptPresets.getPreset(name)
    return preset.prompt
end

-- Apply language instruction to a prompt
function PromptPresets.applyLanguage(prompt, language)
    if not language or language == "English" then
        return prompt
    end
    
    local languageInstruction = string.format(
        "IMPORTANT: Please respond in %s language. All text fields (title, caption, headline, keywords, instructions, location) should be in %s.\n\n",
        language, language
    )
    
    return languageInstruction .. prompt
end

-- Get available languages
function PromptPresets.getLanguages()
    return {
        { title = "English", value = "English" },
        { title = "Spanish (Español)", value = "Spanish" },
        { title = "French (Français)", value = "French" },
        { title = "German (Deutsch)", value = "German" },
        { title = "Italian (Italiano)", value = "Italian" },
        { title = "Portuguese (Português)", value = "Portuguese" },
        { title = "Dutch (Nederlands)", value = "Dutch" },
        { title = "Polish (Polski)", value = "Polish" },
        { title = "Japanese (日本語)", value = "Japanese" },
        { title = "Chinese (中文)", value = "Chinese" },
        { title = "Korean (한국어)", value = "Korean" },
    }
end

return PromptPresets
