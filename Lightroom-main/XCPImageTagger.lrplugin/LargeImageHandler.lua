--[[----------------------------------------------------------------------------
XCP Platform Publisher - Large Image Handler
Copyright 2025 XC Photography

Handles large image files (50MP+, 100MB+ RAW files) efficiently without
causing memory issues or crashes in Lightroom.

FEATURES:
1. Smart thumbnail generation at optimal sizes for each use case
2. Memory-efficient processing for files of any size
3. Chunked base64 encoding for API transmission
4. Progressive quality scaling based on available memory
5. Batch processing optimization
6. Support for RAW, TIFF, PSD, and other large formats

This ensures the plugin works reliably with:
- High-resolution camera files (100MP Phase One, 61MP Sony, etc.)
- Large format scans
- Composite/layered files
- Batch processing of hundreds of images
------------------------------------------------------------------------------]]

local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'
local LrFileUtils = import 'LrFileUtils'
local LrPathUtils = import 'LrPathUtils'
local LrStringUtils = import 'LrStringUtils'
local LrExportSession = import 'LrExportSession'
local LrFunctionContext = import 'LrFunctionContext'
local LrProgressScope = import 'LrProgressScope'

require 'Logger'

LargeImageHandler = {}

-- ============================================================================
-- CONFIGURATION
-- ============================================================================

LargeImageHandler.Config = {
    -- Thumbnail sizes for different purposes
    thumbnailSizes = {
        -- For AI vision APIs (balance quality vs token cost)
        aiAnalysis = {
            maxDimension = 1024,  -- Good quality for AI analysis
            quality = 85,
            format = 'JPEG',
        },
        -- For privacy-mode metadata extraction (no image sent)
        metadataOnly = {
            maxDimension = 256,   -- Minimal size, not actually sent
            quality = 60,
            format = 'JPEG',
        },
        -- For high-detail analysis when needed
        highDetail = {
            maxDimension = 2048,
            quality = 90,
            format = 'JPEG',
        },
        -- Quick preview for UI
        preview = {
            maxDimension = 512,
            quality = 70,
            format = 'JPEG',
        },
    },
    
    -- Memory management
    maxMemoryMB = 512,           -- Max memory to use for image processing
    chunkSizeBytes = 1048576,    -- 1MB chunks for base64 encoding
    
    -- Batch processing
    maxConcurrentExports = 3,    -- Limit concurrent thumbnail generations
    batchPauseMs = 100,          -- Pause between batch items to prevent UI freeze
    
    -- Temp file management
    tempFilePrefix = 'xcp_thumb_',
    cleanupOnComplete = true,
}

-- ============================================================================
-- SMART THUMBNAIL GENERATION
-- ============================================================================

-- Get optimal thumbnail size based on original dimensions
function LargeImageHandler.calculateOptimalSize(originalWidth, originalHeight, maxDimension)
    if not originalWidth or not originalHeight then
        return maxDimension, maxDimension
    end
    
    -- Already smaller than max
    if originalWidth <= maxDimension and originalHeight <= maxDimension then
        return originalWidth, originalHeight
    end
    
    -- Calculate aspect-ratio-preserving dimensions
    local aspectRatio = originalWidth / originalHeight
    local newWidth, newHeight
    
    if originalWidth > originalHeight then
        newWidth = maxDimension
        newHeight = math.floor(maxDimension / aspectRatio)
    else
        newHeight = maxDimension
        newWidth = math.floor(maxDimension * aspectRatio)
    end
    
    return newWidth, newHeight
end

-- Get image dimensions from photo metadata
function LargeImageHandler.getImageDimensions(photo)
    local dimensions = photo:getFormattedMetadata('dimensions')
    local croppedDimensions = photo:getFormattedMetadata('croppedDimensions')
    
    -- Use cropped dimensions if available (what will actually be exported)
    local dimStr = croppedDimensions or dimensions or ''
    
    -- Parse "4000 x 6000" format
    local width, height = dimStr:match('(%d+)%s*x%s*(%d+)')
    
    return tonumber(width), tonumber(height)
end

-- Estimate file size in memory
function LargeImageHandler.estimateMemoryUsage(width, height, bitDepth)
    bitDepth = bitDepth or 8
    local channels = 3  -- RGB
    local bytesPerPixel = (bitDepth / 8) * channels
    local rawBytes = width * height * bytesPerPixel
    
    -- Account for processing overhead (typically 2-3x raw size)
    return rawBytes * 2.5
end

-- Check if we should use low-memory mode
function LargeImageHandler.shouldUseLowMemoryMode(photo)
    local width, height = LargeImageHandler.getImageDimensions(photo)
    
    if not width or not height then
        -- Unknown size, assume large
        return true
    end
    
    local estimatedMB = LargeImageHandler.estimateMemoryUsage(width, height) / (1024 * 1024)
    
    logger:infof('LargeImageHandler: Image %dx%d, estimated memory: %.1fMB', 
        width, height, estimatedMB)
    
    return estimatedMB > LargeImageHandler.Config.maxMemoryMB
end

-- ============================================================================
-- THUMBNAIL EXPORT
-- ============================================================================

-- Generate a thumbnail for a single photo
function LargeImageHandler.generateThumbnail(photo, purpose, outputPath)
    purpose = purpose or 'aiAnalysis'
    local config = LargeImageHandler.Config.thumbnailSizes[purpose]
    
    if not config then
        config = LargeImageHandler.Config.thumbnailSizes.aiAnalysis
    end
    
    -- Get original dimensions
    local origWidth, origHeight = LargeImageHandler.getImageDimensions(photo)
    local newWidth, newHeight = LargeImageHandler.calculateOptimalSize(
        origWidth or 10000, 
        origHeight or 10000, 
        config.maxDimension
    )
    
    -- Generate temp path if not provided
    if not outputPath then
        local tempDir = LrPathUtils.getStandardFilePath('temp')
        local timestamp = os.time()
        local fileName = LargeImageHandler.Config.tempFilePrefix .. timestamp .. '_' .. photo.localIdentifier .. '.jpg'
        outputPath = LrPathUtils.child(tempDir, fileName)
    end
    
    logger:infof('LargeImageHandler: Generating %s thumbnail (%dx%d) for photo %s', 
        purpose, newWidth, newHeight, photo:getFormattedMetadata('fileName'))
    
    -- Use Lightroom's built-in thumbnail/preview system when possible
    local success = false
    local errorMsg = nil
    
    -- Try to get existing preview first (much faster for large files)
    local previewSuccess, jpegData = LargeImageHandler.getExistingPreview(photo, config.maxDimension)
    
    if previewSuccess and jpegData then
        -- Write preview data to file
        local file = io.open(outputPath, 'wb')
        if file then
            file:write(jpegData)
            file:close()
            success = true
            logger:infof('LargeImageHandler: Used existing preview cache')
        end
    end
    
    if not success then
        -- Fall back to export (slower but works for all cases)
        success, errorMsg = LargeImageHandler.exportThumbnail(photo, outputPath, newWidth, newHeight, config.quality)
    end
    
    if success then
        return {
            path = outputPath,
            width = newWidth,
            height = newHeight,
            purpose = purpose,
            success = true,
        }
    else
        return {
            success = false,
            error = errorMsg or 'Unknown error generating thumbnail',
        }
    end
end

-- Try to get existing preview from Lightroom's cache
function LargeImageHandler.getExistingPreview(photo, maxSize)
    -- Lightroom stores previews in different sizes
    -- Try to get the most appropriate one
    
    local success, result = pcall(function()
        -- This uses Lightroom's internal preview system
        -- which is much faster than re-rendering from RAW
        local requestedData = photo:requestJpegThumbnail(maxSize, maxSize, function(jpegData, errorMsg)
            if jpegData then
                return jpegData
            end
            return nil
        end)
        return requestedData
    end)
    
    if success and result then
        return true, result
    end
    
    return false, nil
end

-- Export thumbnail using Lightroom's export system
function LargeImageHandler.exportThumbnail(photo, outputPath, width, height, quality)
    local success = false
    local errorMsg = nil
    
    LrFunctionContext.callWithContext('exportThumbnail', function(context)
        local exportSession = LrExportSession({
            photosToExport = { photo },
            exportSettings = {
                LR_format = 'JPEG',
                LR_jpeg_quality = quality / 100,
                LR_size_doConstrain = true,
                LR_size_maxWidth = width,
                LR_size_maxHeight = height,
                LR_size_resizeType = 'longEdge',
                LR_size_resolution = 72,
                LR_size_units = 'inch',
                LR_outputSharpeningOn = false,
                LR_minimizeEmbeddedMetadata = true,
                LR_removeLocationMetadata = true,  -- Privacy: remove GPS from thumbnails
                LR_export_destinationType = 'specificFolder',
                LR_export_destinationPathPrefix = LrPathUtils.parent(outputPath),
                LR_export_useSubfolder = false,
                LR_collisionHandling = 'overwrite',
                LR_reimportExportedPhoto = false,
                LR_renamingTokensOn = true,
                LR_tokens = '{{custom_token}}',
                LR_tokenCustomString = LrPathUtils.leafName(outputPath):gsub('%.jpg$', ''),
            },
        })
        
        -- Render the export
        for _, rendition in exportSession:renditions() do
            local renditionSuccess, pathOrMessage = rendition:waitForRender()
            if renditionSuccess then
                -- Rename to expected output path if needed
                local exportedPath = pathOrMessage
                if exportedPath ~= outputPath then
                    if LrFileUtils.exists(outputPath) then
                        LrFileUtils.delete(outputPath)
                    end
                    LrFileUtils.move(exportedPath, outputPath)
                end
                success = true
            else
                errorMsg = pathOrMessage or 'Render failed'
            end
        end
    end)
    
    return success, errorMsg
end

-- ============================================================================
-- MEMORY-EFFICIENT BASE64 ENCODING
-- ============================================================================

-- Encode image file to base64 in chunks to avoid memory issues
function LargeImageHandler.encodeToBase64Chunked(filePath)
    if not LrFileUtils.exists(filePath) then
        return nil, 'File not found: ' .. filePath
    end
    
    local fileSize = LrFileUtils.fileAttributes(filePath).fileSize
    local chunkSize = LargeImageHandler.Config.chunkSizeBytes
    
    logger:infof('LargeImageHandler: Encoding file to base64 (%.1fKB)', fileSize / 1024)
    
    -- For small files, just read all at once
    if fileSize < chunkSize * 2 then
        local file = io.open(filePath, 'rb')
        if not file then
            return nil, 'Could not open file'
        end
        local data = file:read('*all')
        file:close()
        return LrStringUtils.encodeBase64(data), nil
    end
    
    -- For larger files, read and encode in chunks
    local file = io.open(filePath, 'rb')
    if not file then
        return nil, 'Could not open file'
    end
    
    local base64Parts = {}
    local bytesRead = 0
    
    while true do
        local chunk = file:read(chunkSize)
        if not chunk then break end
        
        bytesRead = bytesRead + #chunk
        
        -- Encode chunk
        local encoded = LrStringUtils.encodeBase64(chunk)
        table.insert(base64Parts, encoded)
        
        -- Yield to prevent UI freeze
        if bytesRead % (chunkSize * 10) == 0 then
            LrTasks.yield()
        end
    end
    
    file:close()
    
    -- Combine all base64 parts
    local fullBase64 = table.concat(base64Parts)
    
    logger:infof('LargeImageHandler: Base64 encoding complete (%.1fKB output)', #fullBase64 / 1024)
    
    return fullBase64, nil
end

-- ============================================================================
-- BATCH PROCESSING
-- ============================================================================

-- Process multiple photos efficiently
function LargeImageHandler.processBatch(photos, purpose, progressCallback)
    local results = {}
    local total = #photos
    local completed = 0
    local errors = 0
    
    -- Create temp directory for thumbnails
    local tempDir = LrPathUtils.getStandardFilePath('temp')
    local batchId = os.time()
    local batchDir = LrPathUtils.child(tempDir, 'xcp_batch_' .. batchId)
    
    -- Process in smaller groups to manage memory
    local groupSize = LargeImageHandler.Config.maxConcurrentExports
    
    for i = 1, total, groupSize do
        local groupEnd = math.min(i + groupSize - 1, total)
        
        -- Process this group
        for j = i, groupEnd do
            local photo = photos[j]
            local outputPath = LrPathUtils.child(batchDir, 
                'thumb_' .. j .. '_' .. photo.localIdentifier .. '.jpg')
            
            local result = LargeImageHandler.generateThumbnail(photo, purpose, outputPath)
            
            if result.success then
                -- Read and encode the thumbnail
                local base64Data, encodeError = LargeImageHandler.encodeToBase64Chunked(result.path)
                if base64Data then
                    result.base64Data = base64Data
                else
                    result.success = false
                    result.error = encodeError
                    errors = errors + 1
                end
            else
                errors = errors + 1
            end
            
            table.insert(results, {
                photo = photo,
                result = result,
            })
            
            completed = completed + 1
            
            if progressCallback then
                progressCallback(completed, total, errors)
            end
            
            -- Pause between items to prevent UI freeze
            LrTasks.sleep(LargeImageHandler.Config.batchPauseMs / 1000)
        end
        
        -- Yield after each group
        LrTasks.yield()
    end
    
    -- Cleanup temp files if configured
    if LargeImageHandler.Config.cleanupOnComplete then
        LargeImageHandler.cleanupTempFiles(batchDir)
    end
    
    return {
        results = results,
        total = total,
        completed = completed,
        errors = errors,
    }
end

-- ============================================================================
-- CLEANUP
-- ============================================================================

-- Clean up temporary thumbnail files
function LargeImageHandler.cleanupTempFiles(directory)
    if not directory or not LrFileUtils.exists(directory) then
        return
    end
    
    logger:infof('LargeImageHandler: Cleaning up temp directory: %s', directory)
    
    -- Delete all files in directory
    for filePath in LrFileUtils.files(directory) do
        local success, err = pcall(function()
            LrFileUtils.delete(filePath)
        end)
        if not success then
            logger:warnf('LargeImageHandler: Could not delete temp file: %s', filePath)
        end
    end
    
    -- Try to remove directory
    pcall(function()
        LrFileUtils.delete(directory)
    end)
end

-- Clean up all XCP temp files
function LargeImageHandler.cleanupAllTempFiles()
    local tempDir = LrPathUtils.getStandardFilePath('temp')
    
    for filePath in LrFileUtils.files(tempDir) do
        local fileName = LrPathUtils.leafName(filePath)
        if fileName:find(LargeImageHandler.Config.tempFilePrefix) then
            pcall(function()
                LrFileUtils.delete(filePath)
            end)
        end
    end
    
    -- Also clean batch directories
    for dirPath in LrFileUtils.directoryEntries(tempDir) do
        local dirName = LrPathUtils.leafName(dirPath)
        if dirName:find('xcp_batch_') then
            LargeImageHandler.cleanupTempFiles(dirPath)
        end
    end
end

-- ============================================================================
-- CONVENIENCE FUNCTIONS
-- ============================================================================

-- Get image data ready for AI API (handles large files automatically)
function LargeImageHandler.prepareForAI(photo, highDetail)
    local purpose = highDetail and 'highDetail' or 'aiAnalysis'
    
    -- Check if we should use low-memory mode
    local useLowMemory = LargeImageHandler.shouldUseLowMemoryMode(photo)
    
    if useLowMemory then
        logger:infof('LargeImageHandler: Using low-memory mode for large image')
        purpose = 'aiAnalysis'  -- Use smaller size for large files
    end
    
    -- Generate thumbnail
    local thumbResult = LargeImageHandler.generateThumbnail(photo, purpose)
    
    if not thumbResult.success then
        return nil, thumbResult.error
    end
    
    -- Encode to base64
    local base64Data, encodeError = LargeImageHandler.encodeToBase64Chunked(thumbResult.path)
    
    -- Cleanup temp file
    if LargeImageHandler.Config.cleanupOnComplete then
        pcall(function()
            LrFileUtils.delete(thumbResult.path)
        end)
    end
    
    if not base64Data then
        return nil, encodeError
    end
    
    return {
        base64Data = base64Data,
        width = thumbResult.width,
        height = thumbResult.height,
        originalDimensions = { LargeImageHandler.getImageDimensions(photo) },
        usedLowMemoryMode = useLowMemory,
    }, nil
end

-- Get file info without loading the full image
function LargeImageHandler.getFileInfo(photo)
    local width, height = LargeImageHandler.getImageDimensions(photo)
    local filePath = photo:getRawMetadata('path')
    local fileSize = 0
    
    if filePath and LrFileUtils.exists(filePath) then
        local attrs = LrFileUtils.fileAttributes(filePath)
        if attrs then
            fileSize = attrs.fileSize or 0
        end
    end
    
    return {
        width = width,
        height = height,
        megapixels = (width and height) and (width * height / 1000000) or nil,
        fileSizeBytes = fileSize,
        fileSizeMB = fileSize / (1024 * 1024),
        isLargeFile = fileSize > (50 * 1024 * 1024),  -- > 50MB
        isHighRes = (width and height) and (width * height > 30000000) or false,  -- > 30MP
        needsLowMemoryMode = LargeImageHandler.shouldUseLowMemoryMode(photo),
    }
end

return LargeImageHandler
