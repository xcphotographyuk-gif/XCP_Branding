--[[----------------------------------------------------------------------------
BrandVoiceSettings.lua - Brand Voice Settings Dialog
XCP Platform Publisher - Lightroom Plugin
Copyright 2025 XC Photography

Provides a quick-access dialog for adjusting brand voice and content
generation preferences without going through the full Plugin Manager.
Changes are persisted immediately to plugin preferences.
------------------------------------------------------------------------------]]

local LrApplication = import 'LrApplication'
local LrDialogs     = import 'LrDialogs'
local LrView        = import 'LrView'
local LrBinding     = import 'LrBinding'
local LrFunctionContext = import 'LrFunctionContext'
local LrPrefs       = import 'LrPrefs'
local LrTasks       = import 'LrTasks'
local LrColor       = import 'LrColor'

require 'Logger'

local function openBrandVoiceSettings()
    LrFunctionContext.callWithContext('brandVoiceSettings', function(context)
        local prefs       = LrPrefs.prefsForPlugin()
        local viewFactory = LrView.osFactory()
        local props       = LrBinding.makePropertyTable(context)

        -- Sync current prefs into props
        props.brandVoice          = prefs.brandVoice          or 'professional'
        props.photographerCredit  = prefs.photographerCredit  or 'XC Photography'
        props.instagramHandle     = prefs.instagramHandle      or '@xcphotography'
        props.websiteUrl          = prefs.websiteUrl           or 'xcphotography.co.uk'
        props.defaultLocation     = prefs.defaultLocation      or 'United Kingdom'
        props.ukEnglish           = prefs.ukEnglish
        if props.ukEnglish == nil then props.ukEnglish = true end

        -- Caption suffix / tagline
        props.captionSuffix       = prefs.captionSuffix        or ''

        local contents = viewFactory:column {
            spacing      = viewFactory:control_spacing(),
            bind_to_object = props,

            -- Header
            viewFactory:static_text {
                title = "Brand Voice & Identity Settings",
                font  = "<system/bold>",
            },
            viewFactory:static_text {
                title = "These settings control how captions, titles, and descriptions are written across all platforms. Changes take effect immediately for new preparations.",
                wrap  = true,
                width_in_chars = 55,
            },

            viewFactory:separator { fill_horizontal = 1 },

            -- Brand voice selector
            viewFactory:row {
                viewFactory:static_text { title = "Brand Voice:", width = 150 },
                viewFactory:popup_menu {
                    value = LrView.bind 'brandVoice',
                    items = {
                        { title = "Professional & Polished",  value = "professional"  },
                        { title = "Friendly & Approachable",  value = "friendly"      },
                        { title = "Bold & Edgy",              value = "bold"          },
                        { title = "Elegant & Refined",        value = "elegant"       },
                        { title = "Documentary & Authentic",  value = "documentary"   },
                    },
                },
            },

            -- Description of each voice
            viewFactory:group_box {
                title          = "Voice Description",
                fill_horizontal = 1,
                viewFactory:static_text {
                    title = "Professional: Confident and polished — suitable for corporate and B2B clients.\n" ..
                            "Friendly: Warm and conversational — approachable for lifestyle and personal brands.\n" ..
                            "Bold: Direct and edgy — music, nightlife, cultural work.\n" ..
                            "Elegant: Refined and understated — luxury, hospitality, fine art.\n" ..
                            "Documentary: Honest and direct — photojournalism, editorial, advocacy.",
                    wrap  = true,
                    width_in_chars = 52,
                    font  = "<system/small>",
                    text_color = LrColor(0.4, 0.4, 0.4),
                },
            },

            viewFactory:separator { fill_horizontal = 1 },

            -- Identity fields
            viewFactory:static_text { title = "Identity", font = "<system/bold>" },

            viewFactory:row {
                viewFactory:static_text { title = "Photographer Credit:", width = 150 },
                viewFactory:edit_field {
                    value          = LrView.bind 'photographerCredit',
                    width_in_chars = 28,
                    immediate      = true,
                },
            },
            viewFactory:row {
                viewFactory:static_text { title = "Instagram Handle:", width = 150 },
                viewFactory:edit_field {
                    value             = LrView.bind 'instagramHandle',
                    width_in_chars    = 28,
                    immediate         = true,
                    placeholder_string = "@xcphotography",
                },
            },
            viewFactory:row {
                viewFactory:static_text { title = "Website:", width = 150 },
                viewFactory:edit_field {
                    value             = LrView.bind 'websiteUrl',
                    width_in_chars    = 28,
                    immediate         = true,
                    placeholder_string = "xcphotography.co.uk",
                },
            },
            viewFactory:row {
                viewFactory:static_text { title = "Default Location:", width = 150 },
                viewFactory:edit_field {
                    value             = LrView.bind 'defaultLocation',
                    width_in_chars    = 28,
                    immediate         = true,
                    placeholder_string = "Brighton, United Kingdom",
                },
            },

            viewFactory:separator { fill_horizontal = 1 },

            -- Language / caption options
            viewFactory:static_text { title = "Caption Options", font = "<system/bold>" },

            viewFactory:checkbox {
                value = LrView.bind 'ukEnglish',
                title = "Use British English spelling and terminology",
            },

            viewFactory:row {
                viewFactory:static_text { title = "Caption Suffix:", width = 150 },
                viewFactory:edit_field {
                    value             = LrView.bind 'captionSuffix',
                    width_in_chars    = 28,
                    height_in_lines   = 2,
                    immediate         = true,
                    placeholder_string = "Optional — e.g. 'DM to enquire.' or a standard hashtag block",
                },
            },
            viewFactory:static_text {
                title = "The caption suffix is appended to every caption generated for Instagram and website.",
                wrap  = true,
                width_in_chars = 52,
                font  = "<system/small>",
                text_color = LrColor(0.4, 0.4, 0.4),
            },
        }

        local result = LrDialogs.presentModalDialog({
            title      = "XCP Platform Publisher — Brand Voice Settings",
            contents   = contents,
            actionVerb = "Save Settings",
        })

        if result == 'ok' then
            -- Persist all changes to plugin prefs
            prefs.brandVoice         = props.brandVoice
            prefs.photographerCredit = props.photographerCredit
            prefs.instagramHandle    = props.instagramHandle
            prefs.websiteUrl         = props.websiteUrl
            prefs.defaultLocation    = props.defaultLocation
            prefs.ukEnglish          = props.ukEnglish
            prefs.captionSuffix      = props.captionSuffix

            logger:infof('BrandVoiceSettings: Saved — voice=%s, credit=%s',
                prefs.brandVoice, prefs.photographerCredit)

            LrDialogs.message(
                "Settings Saved",
                string.format("Brand voice set to '%s'. All new preparations will use these settings.", props.brandVoice),
                "info"
            )
        end
    end)
end

-- Run immediately when called from the Library menu
LrTasks.startAsyncTask(openBrandVoiceSettings)
