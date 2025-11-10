# How to Add Images to Your Homepage Templates

## Quick Start: 3 Simple Steps

### Step 1: Upload Your Images

1. **Create an images folder** (if not exists):
   ```
   assets/images/
   ```

2. **Upload your images** to this folder with descriptive names:
   - `hero-woman-hair.jpg` - For the hero section background
   - `gallery-1.jpg`, `gallery-2.jpg`, `gallery-3.jpg`, `gallery-4.jpg` - For the 4-box gallery bar
   - `parallax-triumph-bike.jpg` - For the parallax section background
   - `masonry-1.jpg` through `masonry-8.jpg` - For the masonry gallery
   - `checkerboard-branding.jpg`, `checkerboard-documentary.jpg` - For checkerboard sections
   - Any additional images for other sections

### Step 2: Update Image Paths in HTML

Open `sections-template.html` or `preview.html` and replace placeholder URLs:

**Before:**
```html
<img src="https://via.placeholder.com/600x800/..." alt="...">
```

**After:**
```html
<img src="assets/images/your-image.jpg" alt="...">
```

### Step 3: Update Background Images in CSS

For sections with background images (Hero, Parallax), update the `background` property:

**Before:**
```css
background: linear-gradient(...), 
            url('https://via.placeholder.com/1920x1080/...');
```

**After:**
```css
background: linear-gradient(180deg, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.7) 100%), 
            url('assets/images/hero-woman-hair.jpg');
```

---

## Detailed Instructions by Section

### 1. Hero Section Background Image

**Location in HTML:** Line ~22-26 in `sections-template.html` or `preview.html`

**Update the inline style or CSS:**
```html
<section class="hero-section" style="background-image: linear-gradient(180deg, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.7) 100%), url('assets/images/hero-woman-hair.jpg');">
```

**Recommended Image Specs:**
- Dimensions: 1920px × 1440px (or larger)
- Format: JPG (optimized for web)
- File size: Under 500KB

---

### 2. Gallery Bar (4 Text Boxes)

**Location in HTML:** Lines ~35-65 in `sections-template.html`

**Update each image:**
```html
<div class="gallery-bar-item">
    <img src="assets/images/gallery-1.jpg" alt="Urban Edge">
    <div class="gallery-bar-overlay">
        <div class="gallery-bar-text">Urban Edge</div>
    </div>
</div>
```

Repeat for `gallery-2.jpg`, `gallery-3.jpg`, `gallery-4.jpg`

**Recommended Image Specs:**
- Dimensions: 600px × 800px (portrait orientation)
- Format: JPG
- File size: Under 200KB each

---

### 3. Parallax Transition Section Background

**Location in HTML:** Line ~70 in `sections-template.html`

**Update the style:**
```html
<section class="parallax-section" style="background-image: linear-gradient(180deg, rgba(0,0,0,0.5) 0%, rgba(0,0,0,0.7) 100%), url('assets/images/parallax-triumph-bike.jpg');">
```

**Recommended Image Specs:**
- Dimensions: 1920px × 1080px
- Format: JPG
- File size: Under 400KB

---

### 4. Masonry Gallery

**Location in HTML:** Lines ~90-120 in `sections-template.html`

**Update each masonry item:**
```html
<div class="masonry-item">
    <img src="assets/images/masonry-1.jpg" alt="Portfolio 1">
</div>
<div class="masonry-item">
    <img src="assets/images/masonry-2.jpg" alt="Portfolio 2">
</div>
<!-- Continue for masonry-3.jpg through masonry-8.jpg -->
```

**Recommended Image Specs:**
- Varying dimensions for masonry effect:
  - Items 1, 4, 7: 600px × 800px (tall)
  - Other items: 600px × 400px (standard)
- Format: JPG or WebP
- File size: Under 150KB each

---

### 5. Checkerboard Sections

**Location in HTML:** Lines ~145-180 in `sections-template.html`

**Update each checkerboard image:**
```html
<!-- Image Left Section -->
<div class="checkerboard-image">
    <img src="assets/images/checkerboard-branding.jpg" alt="Branding Excellence">
</div>

<!-- Image Right Section -->
<div class="checkerboard-image">
    <img src="assets/images/checkerboard-documentary.jpg" alt="Documentary Impact">
</div>
```

**Recommended Image Specs:**
- Dimensions: 800px × 600px (landscape)
- Format: JPG
- File size: Under 250KB each

---

### 6. Video Section Background

**Location in HTML:** Line ~285 in `sections-template.html`

**Update the style:**
```html
<section class="video-section" style="background-image: linear-gradient(180deg, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0.6) 100%), url('assets/images/video-background.jpg');">
```

**Recommended Image Specs:**
- Dimensions: 1920px × 1080px
- Format: JPG
- File size: Under 300KB

---

### 7. Brand Partner Logos

**Location in HTML:** Lines ~315-330 in `sections-template.html`

**Update each logo:**
```html
<div class="partner-logo">
    <img src="assets/images/logo-partner-1.png" alt="Partner 1">
</div>
```

**Recommended Image Specs:**
- Dimensions: 240px × 120px
- Format: PNG (with transparency)
- File size: Under 50KB each

---

## For Elementor Implementation

### Method 1: Using Elementor's Image Upload

1. **Edit the section** in Elementor
2. **Click on the element** (Image widget, Background, etc.)
3. **Click "Choose Image"**
4. **Upload from your computer** or select from Media Library
5. **Adjust settings:**
   - Position: Center Center
   - Attachment: Scroll (or Fixed for parallax)
   - Repeat: No-repeat
   - Size: Cover

### Method 2: Background Images in Elementor

1. **Select the Section or Column**
2. Go to **Style tab**
3. Under **Background**:
   - Type: Classic
   - Click Image icon
   - Upload your image
4. **Set properties:**
   - Position: Center Center
   - Attachment: Fixed (for parallax effect)
   - Repeat: No-repeat
   - Size: Cover

---

## Image Optimization Tips

### Before Uploading:
1. **Resize images** to recommended dimensions
2. **Compress images** using:
   - TinyPNG.com
   - Squoosh.app
   - Photoshop "Save for Web"
3. **Target file sizes:**
   - Hero/Parallax backgrounds: 300-500KB
   - Gallery images: 150-250KB
   - Icons/logos: Under 50KB

### WebP Format (Optional):
- Convert JPGs to WebP for 25-35% smaller file size
- Modern browsers support WebP
- Keep JPG as fallback

---

## Complete Image List (10 Images as Mentioned)

Based on your request for 10 images, here's the recommended structure:

| # | File Name | Section | Dimensions | Notes |
|---|-----------|---------|------------|-------|
| 1 | `hero-woman-hair.jpg` | Hero Section | 1920×1440 | Woman with whooshing hair, eye peeking |
| 2 | `gallery-1.jpg` | Gallery Bar | 600×800 | Urban Edge theme |
| 3 | `gallery-2.jpg` | Gallery Bar | 600×800 | Raw Emotion theme |
| 4 | `gallery-3.jpg` | Gallery Bar | 600×800 | Bold Stories theme |
| 5 | `gallery-4.jpg` | Gallery Bar | 600×800 | Timeless Moments theme |
| 6 | `parallax-triumph-bike.jpg` | Parallax Section | 1920×1080 | Triumph bike in snow |
| 7 | `masonry-showcase.jpg` | Masonry Gallery | 600×800 | Featured portfolio piece |
| 8 | `checkerboard-branding.jpg` | Checkerboard Left | 800×600 | Branding excellence |
| 9 | `checkerboard-documentary.jpg` | Checkerboard Right | 800×600 | Documentary impact |
| 10 | `video-background.jpg` | Video Section | 1920×1080 | Video showcase backdrop |

---

## Quick Reference: Find & Replace

Use your text editor's find and replace feature:

**Find:** `https://via.placeholder.com/1920x1080/1a1a1a/ffffff?text=Woman+Hair+Eye`  
**Replace:** `assets/images/hero-woman-hair.jpg`

**Find:** `https://via.placeholder.com/600x800/2a2a2a/ffffff?text=Urban+Edge`  
**Replace:** `assets/images/gallery-1.jpg`

And so on for each placeholder...

---

## Need Help?

If you encounter issues:
1. Check file paths are correct (relative to HTML file)
2. Verify images are uploaded to correct folder
3. Clear browser cache to see changes
4. Check image file permissions (should be readable)
5. Validate image formats are web-compatible (JPG, PNG, WebP)

---

**Last Updated:** November 2025  
**Template Version:** 2.0
