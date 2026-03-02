--[[----------------------------------------------------------------------------
XCP Platform Publisher - Plugin Info Provider
Configuration and settings interface for the plugin.
Copyright 2025 XC Photography
------------------------------------------------------------------------------]]

local LrView = import 'LrView'
local LrPrefs = import 'LrPrefs'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrColor = import 'LrColor'

local prefs = LrPrefs.prefsForPlugin()

-- Initialize default preferences
local function initPrefs()
    if prefs.brandVoice == nil then prefs.brandVoice = "professional" end
    if prefs.ukEnglish == nil then prefs.ukEnglish = true end
    if prefs.photographerCredit == nil then prefs.photographerCredit = "XC Photography" end
    if prefs.instagramHandle == nil then prefs.instagramHandle = "@xcphotography" end
    if prefs.websiteUrl == nil then prefs.websiteUrl = "xcphotography.co.uk" end
    if prefs.defaultLocation == nil then prefs.defaultLocation = "United Kingdom" end
    if prefs.aiProvider == nil then prefs.aiProvider = "none" end
    if prefs.openaiApiKey == nil then prefs.openaiApiKey = "" end
    if prefs.ollamaBaseUrl == nil then prefs.ollamaBaseUrl = "http://localhost:11434" end
    if prefs.ollamaModel == nil then prefs.ollamaModel = "llava:latest" end
    if prefs.useAiAssist == nil then prefs.useAiAssist = false end
end

initPrefs()

return {
    sectionsForTopOfDialog = function(viewFactory, propertyTable)
        local bind = LrView.bind
        
        -- Sync preferences with property table
        propertyTable.brandVoice = prefs.brandVoice
        propertyTable.ukEnglish = prefs.ukEnglish
        propertyTable.photographerCredit = prefs.photographerCredit
        propertyTable.instagramHandle = prefs.instagramHandle
        propertyTable.websiteUrl = prefs.websiteUrl
        propertyTable.defaultLocation = prefs.defaultLocation
        propertyTable.aiProvider = prefs.aiProvider
        propertyTable.openaiApiKey = prefs.openaiApiKey
        propertyTable.ollamaBaseUrl = prefs.ollamaBaseUrl
        propertyTable.ollamaModel = prefs.ollamaModel
        propertyTable.useAiAssist = prefs.useAiAssist
        
        return {
            -- Plugin Header
            {
                title = "XCP Platform Publisher",
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:static_text {
                        title = "Multi-Platform Image Preparation Tool",
                        font = "<system/bold>",
                    },
                    
                    viewFactory:static_text {
                        title = "Prepare your images for different publishing platforms with appropriate titles, captions, and keywords tailored to each destination.",
                        wrap = true,
                        width_in_chars = 55,
                    },
                },
            },
            
            -- Brand Identity Settings
            {
                title = "Brand Identity",
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Photographer Credit:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = bind 'photographerCredit',
                            width_in_chars = 25,
                            immediate = true,
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Instagram Handle:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = bind 'instagramHandle',
                            width_in_chars = 25,
                            immediate = true,
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Website:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = bind 'websiteUrl',
                            width_in_chars = 25,
                            immediate = true,
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Default Location:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = bind 'defaultLocation',
                            width_in_chars = 25,
                            immediate = true,
                        },
                    },
                    
                    viewFactory:separator { fill_horizontal = 1 },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Brand Voice:",
                            width = 130,
                        },
                        viewFactory:popup_menu {
                            value = bind 'brandVoice',
                            items = {
                                { title = "Professional & Polished", value = "professional" },
                                { title = "Friendly & Approachable", value = "friendly" },
                                { title = "Bold & Edgy", value = "bold" },
                                { title = "Elegant & Refined", value = "elegant" },
                                { title = "Documentary & Authentic", value = "documentary" },
                            },
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:checkbox {
                            value = bind 'ukEnglish',
                            title = "Use British English spelling and terminology",
                        },
                    },
                },
            },
            
            -- AI Assistant Settings (Optional)
            {
                title = "AI Assistant (Optional)",
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:static_text {
                        title = "Enable AI to help generate descriptions based on image content.",
                        wrap = true,
                        width_in_chars = 55,
                    },
                    
                    viewFactory:row {
                        viewFactory:checkbox {
                            value = bind 'useAiAssist',
                            title = "Enable AI-Assisted Content Generation",
                        },
                    },
                    
                    viewFactory:separator { fill_horizontal = 1 },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "AI Provider:",
                            width = 130,
                        },
                        viewFactory:popup_menu {
                            value = bind 'aiProvider',
                            enabled = bind 'useAiAssist',
                            items = {
                                { title = "None (Manual Only)", value = "none" },
                                { title = "OpenAI GPT-4 Vision", value = "openai" },
                                { title = "Ollama (Local)", value = "ollama" },
                            },
                        },
                    },
                    
                    viewFactory:separator { fill_horizontal = 1 },
                    
                    viewFactory:static_text {
                        title = "OpenAI Settings:",
                        font = "<system/bold>",
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "API Key:",
                            width = 130,
                        },
                        viewFactory:password_field {
                            value = bind 'openaiApiKey',
                            width_in_chars = 35,
                            enabled = bind 'useAiAssist',
                        },
                    },
                    
                    viewFactory:separator { fill_horizontal = 1 },
                    
                    viewFactory:static_text {
                        title = "Ollama Settings (Local AI):",
                        font = "<system/bold>",
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Server URL:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = bind 'ollamaBaseUrl',
                            width_in_chars = 25,
                            enabled = bind 'useAiAssist',
                        },
                    },
                    
                    viewFactory:row {
                        viewFactory:static_text {
                            title = "Model:",
                            width = 130,
                        },
                        viewFactory:edit_field {
                            value = bind 'ollamaModel',
                            width_in_chars = 20,
                            enabled = bind 'useAiAssist',
                        },
                    },
                },
            },
        }
    end,
    
    sectionsForBottomOfDialog = function(viewFactory, propertyTable)
        return {
            {
                title = "Supported Platforms",
                viewFactory:column {
                    spacing = viewFactory:control_spacing(),
                    
                    viewFactory:static_text {
                        title = "📱 Instagram - Engaging captions with hashtags",
                    },
                    viewFactory:static_text {
                        title = "🌐 Website Gallery - SEO-optimized professional descriptions",
                    },
                    viewFactory:static_text {
                        title = "🖼️ Print Shop - Elegant titles for fine art prints",
                    },
                    viewFactory:static_text {
                        title = "📦 Multi-Platform - Prepare for all platforms at once",
                    },
                },
            },
            {
                title = "About",
                viewFactory:row {
                    viewFactory:static_text {
                        title = "XCP Platform Publisher v1.0.0 | © 2025 XC Photography",
                    },
                },
            },
        }
    end,
    
    -- Save preferences when dialog closes
    endDialog = function(propertyTable)
        prefs.brandVoice = propertyTable.brandVoice
        prefs.ukEnglish = propertyTable.ukEnglish
        prefs.photographerCredit = propertyTable.photographerCredit
        prefs.instagramHandle = propertyTable.instagramHandle
        prefs.websiteUrl = propertyTable.websiteUrl
        prefs.defaultLocation = propertyTable.defaultLocation
        prefs.aiProvider = propertyTable.aiProvider
        prefs.openaiApiKey = propertyTable.openaiApiKey
        prefs.ollamaBaseUrl = propertyTable.ollamaBaseUrl
        prefs.ollamaModel = propertyTable.ollamaModel
        prefs.useAiAssist = propertyTable.useAiAssist
    end,
}
