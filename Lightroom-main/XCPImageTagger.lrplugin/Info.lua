--[[----------------------------------------------------------------------------
XCP Platform Publisher - Lightroom Plugin
Multi-Platform Image Preparation Tool for XC Photography

A unique workflow-focused plugin that prepares images for different 
publishing platforms with appropriate titles, captions, and keywords.

Key Features:
- Platform-First Workflow (choose destination, then prepare)
- XC Photography Brand Voice Integration
- UK Market Optimized (British English, UK locations, UK trends)
- Multi-Platform Batch Preparation
- Visual Style Detection (Documentary, Branding, Portrait, etc.)
- Export Profile Integration

Version: 1.0.0
Author: XC Photography
Website: https://xcphotography.co.uk
------------------------------------------------------------------------------]]

return {
    LrSdkVersion = 6.0,
    LrSdkMinimumVersion = 4.0,
    
    LrToolkitIdentifier = 'uk.co.xcphotography.platformpublisher',
    LrPluginName = "XCP Platform Publisher",
    LrPluginInfoUrl = "https://xcphotography.co.uk",
    
    LrPluginInfoProvider = 'PluginInfoProvider.lua',
    
    -- Main Library Menu - Platform-First Approach
    LrLibraryMenuItems = {
        {
            title = "Prepare for Instagram",
            file = "PrepareForInstagram.lua",
        },
        {
            title = "Prepare for Website Gallery",
            file = "PrepareForWebsite.lua",
        },
        {
            title = "Prepare for Print Shop",
            file = "PrepareForPrint.lua",
        },
        {
            title = "-", -- Separator
        },
        {
            title = "Multi-Platform Preparation...",
            file = "MultiPlatformPrep.lua",
        },
        {
            title = "Brand Voice Settings...",
            file = "BrandVoiceSettings.lua",
        },
    },
    
    -- Export Menu Integration
    LrExportMenuItems = {
        {
            title = "Prepare & Export for Platform...",
            file = "PrepareAndExport.lua",
        },
    },
    
    -- Custom Metadata for tracking platform preparation
    LrMetadataProvider = 'MetadataDefinition.lua',
    
    -- Export Post-Process Actions
    LrExportServiceProvider = {
        title = "XCP Platform Publisher",
        file = "XCPExportServiceProvider.lua",
    },
    
    VERSION = { major = 1, minor = 0, revision = 0, build = 1 },
}
