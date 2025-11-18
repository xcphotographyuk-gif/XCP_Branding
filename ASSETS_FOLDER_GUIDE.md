# Assets Folder Structure Guide

## Overview
This guide explains the image asset structure referenced in the XC Photography shop templates. These placeholder paths show where to upload images in your WordPress Media Library.

## Folder Structure

```
WordPress Media Library
└── assets/
    └── images/
        └── shop/
            ├── welcome-hero.jpg              (Main shop welcome hero image)
            ├── collection-fineart.jpg        (Fine art category image)
            ├── collection-wallart.jpg        (Wall art category image - use image 2 or 3)
            ├── collection-gifts.jpg          (Gifts category image)
            ├── collection-blackfriday.jpg    (Black Friday promotional image)
            ├── collection-christmas.jpg      (Christmas promotional image)
            ├── hdv-landing-hero.jpg          (Hotel du Vin landing hero - use image 4)
            ├── hdv-prints-showcase.jpg       (HDV prints showcase - use image 1)
            ├── hdv-book-showcase.jpg         (HDV book showcase)
            ├── hdv-postcards.jpg             (HDV postcards product)
            ├── hdv-umbrella.jpg              (HDV umbrella product)
            └── hdv-sunglasses.jpg            (HDV sunglasses product)
```

## Your Reference Images Mapping

Based on your mention of 4 reference images:

1. **Image 1 (Fine Art)** → Use for:
   - `hdv-prints-showcase.jpg`
   - `collection-fineart.jpg`

2. **Images 2-3 (Wall Art)** → Use for:
   - `collection-wallart.jpg`
   - `welcome-hero.jpg`

3. **Image 4 (Hotel du Vin)** → Use for:
   - `hdv-landing-hero.jpg`

## WordPress Upload Instructions

### Method 1: Upload via Media Library
1. Go to WordPress Admin → Media → Add New
2. Upload your images
3. After upload, organize by renaming or using folders (if you have a media folder plugin)
4. Copy the image URL
5. In Elementor, replace `[uc_local]assets/images/shop/filename.jpg` with the actual URL

### Method 2: Direct Elementor Image Widget
1. Open the page in Elementor
2. Click on any Image widget
3. Click "Choose Image"
4. Upload or select from Media Library
5. Elementor will automatically insert the correct URL

## WooCommerce Product Images

For WooCommerce products (Fine Art, Wall Art, Merchandise):
- Upload product images through **Products → Add New → Product Image**
- WooCommerce handles these separately from the templates
- The templates use WooCommerce widgets that pull images automatically

## Notes
- All placeholder paths use `[uc_local]` which Elementor will replace with your actual media URLs
- You don't need to create an actual "assets" folder - this is just the logical structure shown in placeholders
- Images should be high quality (at least 1920px wide for hero images, 800px for category thumbnails)

## Quick Links to New Templates

**Shop Welcome Page:** `XCP_Shop_Welcome_Page.json`  
**Hotel du Vin Landing:** `XCP_HotelDuVin_Landing.json`

Both templates include:
- WooCommerce widget placeholder areas
- Responsive layouts
- Professional targeting copy for interior designers, architects, and galleries
- Black Friday and Christmas collection sections
