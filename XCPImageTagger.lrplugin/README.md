# XCP Platform Publisher - Lightroom Plugin

A professional Lightroom Classic plugin for **XC Photography** that prepares images for multiple publishing platforms with platform-specific titles, captions, keywords, and IPTC metadata.

## 🎯 Key Features

### Platform-First Workflow
- **Instagram/Social Media** - Engaging captions with hashtags, emojis, and **optional post ideas** to help you get started
- **Website/Portfolio** - SEO-optimized titles and professional descriptions
- **Print Shop** - Elegant gallery-worthy titles for fine art sales
- **Stock Photography (Alamy, Shutterstock, Getty, Adobe Stock)** - Extensive keyword generation (25-50 keywords) using a structured three-layer keywording approach

### Batch Context Feature
- **Describe your image set** with context like "This shoot was a corporate headshot session" or "These images are for sale as fine art prints"
- Context is used to generate more relevant and descriptive metadata across all platforms
- Especially powerful for stock photography where detailed descriptions improve discoverability

### SEO Tagging
Professional SEO tagging using a structured keywording methodology:
- **Hierarchical keywords** - broad to specific (who, what, where, when, why, how)
- **Conceptual & emotional keywords** - not just literal descriptions
- **Buyer-intent focused** - think like someone searching for this image
- **Natural language variations** - synonyms and related terms
- **Platform-optimized** - 25-50 keywords optimal for stock platforms

### Multi-Platform Preparation
- Prepare images for **multiple platforms at once**
- All platform-specific content stored in IPTC Instructions field
- Easy copy/paste workflow for each destination

### Privacy Protection 🔒
- **Privacy Mode** ensures NO image data is sent to external AI services
- Content generated from metadata, keywords, and templates only
- Protects photographers' intellectual property from AI training datasets
- Local Ollama support with TEXT-ONLY mode (no image analysis)

### Large File Support
- Handles huge image files (50MP+, 100MB+ RAW files)
- Smart thumbnail generation for efficient processing
- Memory-efficient chunked encoding
- Works with Phase One, Hasselblad, and other medium format files

### Complete IPTC Metadata
All standard IPTC fields are populated:
- Title, Caption, Headline
- Copyright and Creator information
- Location data
- Keywords
- Instructions (contains all platform-specific content)

## 📁 Installation

1. Download the `XCPImageTagger.lrplugin` folder
2. In Lightroom Classic, go to **File → Plug-in Manager**
3. Click **Add** and navigate to the plugin folder
4. Select the `XCPImageTagger.lrplugin` folder and click **Add Plug-in**
5. The plugin will appear as "XCP Platform Publisher" in the Plugin Manager

## 🚀 Usage

### Quick Start - Single Platform

1. Select photos in the Library module
2. Go to **Library → Plug-in Extras → Prepare for [Platform]**
3. Configure options in the dialog
4. Click **Prepare**

### Multi-Platform Preparation (Recommended)

1. Select photos in the Library module
2. Go to **Library → Plug-in Extras → Multi-Platform Preparation...**
3. Check the platforms you want to prepare for (up to 3)
4. Configure IPTC creator information
5. Enable **Privacy Mode** (recommended)
6. Click **Prepare All**

### Accessing Platform-Specific Content

After preparation, all platform content is stored in the **IPTC Instructions** field:

```
=== PLATFORM-SPECIFIC CONTENT ===

--- INSTAGRAM ---
[Instagram caption with hashtags]

💡 Post Idea: [Creative suggestion for how to use this image]

--- WEBSITE ---
Title: [SEO title]
[Website description]

--- PRINT SHOP ---
Title: [Gallery title]
[Print description]

--- STOCK PHOTOGRAPHY (ALAMY) ---
Title: [Descriptive stock title]

Description:
[Detailed description with use cases]

Keywords (35):
portrait, person, face, headshot, professional, UK, United Kingdom, Britain...

Notes: Optimized for Alamy. 35 keywords generated across three specificity layers.
SEO Methodology: three-layer keywording (specific / mid-level / general)
```

You can view this in:
- **Metadata panel** → IPTC → Instructions
- **File Info** dialog (Ctrl/Cmd + Alt + Shift + I)

## ⚙️ Plugin Settings

Access plugin settings via **File → Plug-in Manager → XCP Platform Publisher**

### Brand Identity
- **Photographer Credit** - Your name/studio name
- **Instagram Handle** - Your Instagram @username
- **Website URL** - Your website address
- **Default Location** - Your primary location (e.g., "United Kingdom")
- **Brand Voice** - Professional, Friendly, Bold, Elegant, or Documentary

### AI Assistant (Optional)
- **Enable AI Assist** - Use AI for content suggestions
- **Provider** - OpenAI GPT-4 Vision or Ollama (Local)
- **Privacy Mode** - When enabled, uses text-only AI (no image data sent)

### Ollama Configuration (Local AI)
- **Server URL** - Default: `http://localhost:11434`
- **Vision Model** - For image analysis (e.g., `llava:latest`)
- **Text Model** - For privacy mode (e.g., `llama3:latest`)

## 🔒 Privacy Features

### Why Privacy Mode?

Many photographers are concerned about their images being used to train AI systems. This plugin addresses those concerns:

1. **No Image Upload** - In Privacy Mode, actual image data NEVER leaves your computer
2. **Metadata-Only Analysis** - Content is generated from EXIF, keywords, collections, and filename patterns
3. **Template-Based** - Professional templates ensure quality without AI image analysis
4. **Local AI Option** - Use Ollama locally for AI assistance without cloud services

### What Metadata is Used?

In Privacy Mode, the plugin analyzes:
- Existing keywords and collections
- EXIF data (camera, lens, settings)
- GPS/Location information
- Filename patterns
- File type and dimensions

**NOT analyzed**: The actual image pixels

## 📋 Custom Metadata Fields

The plugin adds these custom metadata fields (viewable in Library Metadata panel):

| Field | Description |
|-------|-------------|
| Instagram Ready | Preparation status for Instagram |
| Instagram Post Idea | Creative post/campaign suggestion based on image content |
| Website Ready | Preparation status for Website |
| Print Shop Ready | Preparation status for Print Sales |
| Stock Photography Ready | Preparation status for Stock submission |
| Stock Platform | Target platform (Alamy, Shutterstock, Getty, Adobe Stock) |
| Stock Keywords (SEO) | Generated keywords using structured three-layer keywording |
| Stock Keyword Count | Number of keywords generated (target: 25-50) |
| Photography Style | Detected style (Portrait, Event, etc.) |
| Client/Project Name | Optional client identifier |
| Last Prepared Date | When content was generated |
| Prepared By | Manual, Template, or AI Assisted |

## 🎨 Photography Styles

The plugin automatically detects photography style from:
- Collection names
- Keywords
- Camera settings (focal length, aperture)
- Filename patterns

Supported styles:
- Portrait
- Documentary
- Branding/Commercial
- Event/Live
- Landscape
- Product
- Street
- Abstract/Fine Art

## 📦 Files Included

```
XCPImageTagger.lrplugin/
├── Info.lua                    # Plugin manifest
├── PluginInfoProvider.lua      # Settings dialog
├── MetadataDefinition.lua      # Custom metadata fields
├── PrepareForInstagram.lua     # Instagram preparation
├── PrepareForWebsite.lua       # Website preparation
├── PrepareForPrint.lua         # Print shop preparation
├── MultiPlatformPrep.lua       # Multi-platform workflow
├── SEOTaggingEngine.lua        # Structured SEO keyword generation
├── PrivacyContentMatcher.lua   # Privacy-first content generation
├── LargeImageHandler.lua       # Large file support
├── PromptPresets.lua           # AI prompt templates
├── JSON.lua                    # JSON encoder/decoder
├── Logger.lua                  # Logging utility
├── inspect.lua                 # Debug utility
└── README.md                   # This file
```

## 🔧 Troubleshooting

### Plugin doesn't appear in menus
1. Check Plugin Manager shows plugin as "Installed and running"
2. Restart Lightroom
3. Re-add the plugin

### Large files causing slowdowns
- The plugin automatically uses low-memory mode for files >50MB
- Processing is optimized with chunked encoding
- Consider using Privacy Mode which doesn't need image processing

### AI features not working
1. Check API key is configured (OpenAI) or Ollama is running (local)
2. Test connection in Plugin Manager settings
3. Check Lightroom logs for error details

### Content not appearing in metadata
- Check the IPTC Instructions field contains platform content
- Ensure write access to catalog wasn't cancelled
- Verify photos are selected before running preparation

## 📄 License

Copyright © 2025 XC Photography. All rights reserved.

This plugin is for use by XC Photography and authorized licensees.

## 🤝 Support

For support, contact XC Photography:
- Website: [xcphotography.co.uk](https://xcphotography.co.uk)
- Instagram: [@xcphotography](https://instagram.com/xcphotography)

---

*XCP Platform Publisher - Multi-Platform Image Preparation for Professional Photographers*
