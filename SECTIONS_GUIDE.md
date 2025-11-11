# XC Photography Homepage Sections - Code Templates

## Overview
This document provides finalized code templates for all homepage sections with a narrative-driven, cinematic layout. Each section is designed to be implemented in Elementor or as standalone HTML/CSS.

---

## Section 1: Hero Section (Top)

### Description
Full-height hero section with background image and centered CTA widget.

### HTML Structure
```html
<section class="hero-section">
    <div class="hero-content">
        <h1>Branding & Documentary Photography That Demands Attention</h1>
        <h2>Iconic Imagery for Iconic Brands with an Edge</h2>
        <div class="cta-buttons">
            <a href="#consultation" class="btn btn-primary">Book Your Free Consultation</a>
            <a href="#portfolio" class="btn btn-secondary">View Portfolio</a>
        </div>
    </div>
</section>
```

### Key CSS Classes
- `.hero-section` - Full viewport height, flexbox centered
- `.hero-content` - Max-width container for content
- `.cta-buttons` - Flex container for buttons

### Elementor Implementation
1. Add Section → Full Width
2. Background → Type: Classic, add background image
3. Minimum Height: 100vh
4. Content Position: Middle
5. Add Column (100% width)
6. Add Heading widget (H1)
7. Add Heading widget (H2)
8. Add Button widgets (2)

### Notes
- Background image should be added in Elementor section settings
- Parallax effect handled by Elementor's background attachment setting
- Use woman with hair/eye image as specified

---

## Section 2: Bar with 4 Text Boxes (Gallery)

### Description
Responsive gallery bar with 4 images and text overlays in a grid layout.

### HTML Structure
```html
<section class="gallery-bar">
    <div class="gallery-bar-grid">
        <div class="gallery-bar-item">
            <img src="image1.jpg" alt="Urban Edge">
            <div class="gallery-bar-overlay">
                <div class="gallery-bar-text">Urban Edge</div>
            </div>
        </div>
        <!-- Repeat for 4 items total -->
    </div>
</section>
```

### Key CSS Classes
- `.gallery-bar-grid` - CSS Grid with 4 columns (responsive to 1 on mobile)
- `.gallery-bar-item` - 400px height, overflow hidden
- `.gallery-bar-overlay` - Absolute positioned overlay for text
- `.gallery-bar-text` - Text content at bottom of overlay

### Elementor Implementation
1. Add Section → Full Width
2. Add 4 Columns (25% each)
3. In each column:
   - Add Image widget (set as background or use Image Box)
   - Add Heading widget positioned absolutely
   - Style overlay gradient in column settings

### Responsive Behavior
- Desktop: 4 columns side by side
- Tablet: 2x2 grid
- Mobile: Single column stack

---

## Section 3: Parallax Transition Section

### Description
Full-height section with Triumph bike background and centered CTA banner.

### HTML Structure
```html
<section class="parallax-section">
    <div class="cta-banner">
        <h2>Capture Your Brand's Essence</h2>
        <p>
            Every image tells a story. Let's create something extraordinary 
            together that resonates with your audience.
        </p>
        <div class="cta-buttons">
            <a href="#contact" class="btn btn-primary">Start Your Journey</a>
        </div>
    </div>
</section>
```

### Key CSS Classes
- `.parallax-section` - Full viewport height with background
- `.cta-banner` - Centered content box, max-width 800px

### Elementor Implementation
1. Add Section → Full Width
2. Background → Type: Classic, add Triumph bike snow image
3. Background Attachment: Fixed (for parallax)
4. Minimum Height: 100vh
5. Add Column (100% width)
6. Add Heading widget
7. Add Text Editor widget
8. Add Button widget
9. Style column background with semi-transparent overlay

---

## Section 4: Masonry Gallery

### Description
Grid-style gallery with varying image heights for dynamic masonry effect.

### HTML Structure
```html
<section class="masonry-section">
    <div class="container">
        <h2>Our Portfolio</h2>
        <div class="masonry-grid">
            <div class="masonry-item">
                <img src="portfolio1.jpg" alt="Portfolio 1">
            </div>
            <!-- Repeat for 8+ items -->
        </div>
    </div>
</section>
```

### Key CSS Classes
- `.masonry-grid` - CSS Grid with auto-fill columns
- `.masonry-item` - Individual grid items
- `:nth-child(1,4,7)` - Span 2 rows for masonry effect

### Elementor Implementation
1. Add Section → Boxed
2. Add Heading widget for title
3. Add Gallery widget or use Custom HTML with grid
4. Set Gallery to "Masonry" layout if using native widget
5. Columns: 3-4 desktop, 2 tablet, 1 mobile

### Grid Pattern
- Items 1, 4, 7: Tall (span 2 rows)
- All other items: Regular height (1 row)

---

## Section 5: Blocks of Content (Text Focus)

### Description
Centered text content block for narrative storytelling.

### HTML Structure
```html
<section class="text-block">
    <div class="text-block-container">
        <h2>The Art of Visual Storytelling</h2>
        <p class="text-block-content">Paragraph 1...</p>
        <p class="text-block-content">Paragraph 2...</p>
        <p class="text-block-content">Paragraph 3...</p>
    </div>
</section>
```

### Key CSS Classes
- `.text-block` - Section padding
- `.text-block-container` - Max-width 900px, centered
- `.text-block-content` - Individual paragraphs with spacing

### Elementor Implementation
1. Add Section → Boxed
2. Add Column (100% width)
3. Column Settings: Max Width 900px, Centered
4. Add Heading widget
5. Add Text Editor widget for paragraphs
6. Set text alignment to center

---

## Section 6: Checkerboard Layout

### Description
Alternating image-text layout. Two variations: Image Left/Text Right and Image Right/Text Left.

### HTML Structure - Image Left
```html
<section class="checkerboard-section">
    <div class="checkerboard-row">
        <div class="checkerboard-image">
            <img src="branding.jpg" alt="Branding Excellence">
        </div>
        <div class="checkerboard-content">
            <h3>Branding Excellence</h3>
            <p>Content...</p>
        </div>
    </div>
</section>
```

### HTML Structure - Image Right
```html
<section class="checkerboard-section">
    <div class="checkerboard-row reverse">
        <div class="checkerboard-image">
            <img src="documentary.jpg" alt="Documentary Impact">
        </div>
        <div class="checkerboard-content">
            <h3>Documentary Impact</h3>
            <p>Content...</p>
        </div>
    </div>
</section>
```

### Key CSS Classes
- `.checkerboard-row` - Flex container for 50/50 split
- `.checkerboard-row.reverse` - Reverses flex direction
- `.checkerboard-image` - Image container (flex: 1)
- `.checkerboard-content` - Text container (flex: 1)

### Elementor Implementation
1. Add Section → Full Width
2. Add 2 Columns (50% each)
3. First Column:
   - Add Image widget (or set as column background)
   - Min Height: 500px
4. Second Column:
   - Add Heading widget
   - Add Text Editor widget
   - Padding: 60px
5. For reverse layout: Use Elementor's "Reverse Columns" on mobile and set custom order

### Responsive Behavior
- Desktop/Tablet: Side by side (50/50)
- Mobile: Stacked (image on top)

---

## Additional Section 1: Statistics Bar

### Description
Dark background section with 4 key statistics displayed in a grid.

### HTML Structure
```html
<section class="stats-section">
    <div class="container">
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number">500+</div>
                <div class="stat-label">Projects Completed</div>
            </div>
            <!-- Repeat for 4 stats -->
        </div>
    </div>
</section>
```

### Elementor Implementation
1. Add Section → Boxed
2. Background: Dark color
3. Add 4 Columns (25% each)
4. In each column:
   - Add Heading widget for number
   - Add Text widget for label
   - Center align both

### Responsive: 2x2 grid on mobile

---

## Additional Section 2: Process Timeline

### Description
Step-by-step process display with large numbers and descriptive content.

### HTML Structure
```html
<section class="process-section">
    <div class="container">
        <h2>Our Process</h2>
        <div class="process-timeline">
            <div class="process-step">
                <div class="process-number">01</div>
                <div class="process-content">
                    <h3>Discovery & Consultation</h3>
                    <p>Description...</p>
                </div>
            </div>
            <!-- Repeat for 4 steps -->
        </div>
    </div>
</section>
```

### Elementor Implementation
1. Add Section → Boxed
2. Add title with Heading widget
3. For each process step:
   - Add Column with 2 inner columns (20% number, 80% content)
   - Number column: Large text with reduced opacity
   - Content column: Heading + Text

---

## Additional Section 3: Video Showcase

### Description
Full-height background section with centered video play button.

### HTML Structure
```html
<section class="video-section">
    <div class="video-play-button">
        <!-- Video trigger -->
    </div>
</section>
```

### Elementor Implementation
1. Add Section → Full Width
2. Background: Video background image
3. Background Attachment: Fixed
4. Minimum Height: 80vh
5. Add Column (centered)
6. Add Icon or Button widget styled as play button
7. Link to video popup or lightbox

---

## Additional Section 4: Testimonials

### Description
Centered testimonial with quote, author name, and role.

### HTML Structure
```html
<section class="testimonials-section">
    <div class="container">
        <h2>What Our Clients Say</h2>
        <div class="testimonial">
            <blockquote>Quote text...</blockquote>
            <p class="testimonial-author">Sarah Mitchell</p>
            <p class="testimonial-role">Creative Director, Urban Brands Co.</p>
        </div>
    </div>
</section>
```

### Elementor Implementation
1. Add Section → Boxed
2. Add Heading widget for title
3. Add Testimonial widget or Text Editor
4. Max width: 900px
5. Center alignment

---

## Additional Section 5: Brand Partners

### Description
Logo grid displaying trusted brand partners.

### HTML Structure
```html
<section class="partners-section">
    <div class="container">
        <h2>Trusted By Leading Brands</h2>
        <div class="partners-grid">
            <div class="partner-logo">
                <img src="logo1.png" alt="Partner 1">
            </div>
            <!-- Repeat for 5 logos -->
        </div>
    </div>
</section>
```

### Elementor Implementation
1. Add Section → Boxed
2. Add Heading widget
3. Add 5 Columns (20% each)
4. In each column: Add Image widget
5. Apply grayscale filter, remove on hover

### Responsive: 3 columns tablet, 2 columns mobile

---

## General Implementation Notes

### Colors (Already Set Globally)
- Primary Gold: #d4af37
- Dark Background: #1a1a1a
- Light Background: #fafafa
- White: #ffffff
- Text Gray: #666666

### Typography (Already Set Globally)
- Headings: Montserrat
- Body: Open Sans

### Spacing Standards
- Section Padding: 80px top/bottom (desktop), 60px (mobile)
- Element Margins: 15-50px based on hierarchy
- Grid Gaps: 15-40px

### Accessibility
- All images have alt text
- Proper heading hierarchy (H1 → H2 → H3)
- Sufficient color contrast
- Text adjustable by site global settings

### Performance
- Images optimized before upload
- Lazy loading enabled
- Responsive images for different screen sizes

---

## File Reference
- `sections-template.html` - Complete HTML template with all sections
- `preview.html` - Enhanced preview with all sections

## Version
Template Version 2.0 - November 2025
