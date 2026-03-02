--[[----------------------------------------------------------------------------
XCP Platform Publisher - Metadata Provider
Custom metadata fields for tracking platform preparation status.
Copyright 2025 XC Photography
------------------------------------------------------------------------------]]

return {
    metadataFieldsForPhotos = {
        -- Platform preparation status
        {
            id = 'xcpInstagramReady',
            title = "Instagram Ready",
            dataType = 'enum',
            values = {
                { value = 'no', title = 'Not Prepared' },
                { value = 'pending', title = 'Pending Review' },
                { value = 'yes', title = 'Ready to Post' },
            },
            searchable = true,
            browsable = true,
            version = 1,
        },
        {
            id = 'xcpWebsiteReady',
            title = "Website Ready",
            dataType = 'enum',
            values = {
                { value = 'no', title = 'Not Prepared' },
                { value = 'pending', title = 'Pending Review' },
                { value = 'yes', title = 'Ready to Publish' },
            },
            searchable = true,
            browsable = true,
            version = 1,
        },
        {
            id = 'xcpPrintReady',
            title = "Print Shop Ready",
            dataType = 'enum',
            values = {
                { value = 'no', title = 'Not Prepared' },
                { value = 'pending', title = 'Pending Review' },
                { value = 'yes', title = 'Ready for Sale' },
            },
            searchable = true,
            browsable = true,
            version = 1,
        },
        {
            id = 'xcpStockReady',
            title = "Stock Photography Ready",
            dataType = 'enum',
            values = {
                { value = 'no', title = 'Not Prepared' },
                { value = 'pending', title = 'Pending Review' },
                { value = 'yes', title = 'Ready to Submit' },
            },
            searchable = true,
            browsable = true,
            version = 1,
        },
        {
            id = 'xcpStockPlatform',
            title = "Stock Platform",
            dataType = 'enum',
            values = {
                { value = 'alamy', title = 'Alamy' },
                { value = 'shutterstock', title = 'Shutterstock' },
                { value = 'getty', title = 'Getty Images' },
                { value = 'adobe', title = 'Adobe Stock' },
                { value = 'general', title = 'Multi-Platform' },
            },
            searchable = true,
            browsable = true,
            version = 1,
        },
        
        -- Photography style classification
        {
            id = 'xcpPhotoStyle',
            title = "Photography Style",
            dataType = 'enum',
            values = {
                { value = 'portrait', title = 'Portrait' },
                { value = 'documentary', title = 'Documentary' },
                { value = 'branding', title = 'Branding/Commercial' },
                { value = 'event', title = 'Event/Live' },
                { value = 'landscape', title = 'Landscape' },
                { value = 'product', title = 'Product' },
                { value = 'street', title = 'Street' },
                { value = 'abstract', title = 'Abstract/Fine Art' },
            },
            searchable = true,
            browsable = true,
            version = 1,
        },
        
        -- Client/Project information
        {
            id = 'xcpClientName',
            title = "Client/Project Name",
            dataType = 'string',
            searchable = true,
            browsable = true,
            version = 1,
        },
        
        -- Platform-specific generated content storage
        {
            id = 'xcpInstagramCaption',
            title = "Instagram Caption",
            dataType = 'string',
            searchable = false,
            version = 1,
        },
        {
            id = 'xcpInstagramPostIdea',
            title = "Instagram Post Idea",
            dataType = 'string',
            searchable = false,
            version = 1,
        },
        {
            id = 'xcpWebsiteAltText',
            title = "Website Alt Text",
            dataType = 'string',
            searchable = false,
            version = 1,
        },
        {
            id = 'xcpPrintDescription',
            title = "Print Description",
            dataType = 'string',
            searchable = false,
            version = 1,
        },
        {
            id = 'xcpStockKeywords',
            title = "Stock Keywords (SEO)",
            dataType = 'string',
            searchable = false,
            version = 1,
        },
        {
            id = 'xcpStockKeywordCount',
            title = "Stock Keyword Count",
            dataType = 'string',
            searchable = true,
            browsable = true,
            version = 1,
        },
        
        -- Processing metadata
        {
            id = 'xcpLastPrepared',
            title = "Last Prepared Date",
            dataType = 'string',
            searchable = true,
            browsable = true,
            version = 1,
        },
        {
            id = 'xcpPreparedBy',
            title = "Prepared By",
            dataType = 'enum',
            values = {
                { value = 'manual', title = 'Manual Entry' },
                { value = 'template', title = 'Template' },
                { value = 'ai_assisted', title = 'AI Assisted' },
            },
            searchable = true,
            browsable = true,
            version = 1,
        },
    },
    
    schemaVersion = 4,
}
