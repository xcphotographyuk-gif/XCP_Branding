# XC Photography Elementor Templates

This directory contains Elementor page templates for the XC Photography website.

## Template: Homepage Partial Layout

**File:** `xcp-homepage-partial.json`

This template provides a partial layout for the XC Photography homepage, including three key sections that establish the brand's premium photography presence.

### Sections Included

#### 1. Hero Section
A stunning, full-width cinematic hero section featuring:
- **Background:** Full-width background image with customizable overlay (default: 50% dark overlay)
- **Height:** 100vh (full viewport height) for maximum impact
- **Content:**
  - H1 Heading: "Capturing Your Story" (72px desktop, 48px tablet, 36px mobile)
  - H2 Heading: "Professional Photography That Tells Your Unique Story" (36px desktop, 28px tablet, 22px mobile)
  - Descriptive subheading paragraph
  - Two call-to-action buttons:
    - **Primary CTA:** "Book Your Free Consultation" (gold background: #d4af37)
    - **Secondary CTA:** "View Portfolio" (transparent with white border)
- **Typography:** Raleway font family throughout
- **Responsive:** Fully responsive with specific breakpoints for tablet and mobile

#### 2. Bold Intro Narrative
A premium-styled text section that communicates the XC Photography brand ethos:
- **Background:** Light gray (#f8f8f8) to contrast with white content box
- **Content Box Styling:**
  - White background (#ffffff)
  - Subtle shadow (0 4px 20px rgba(0,0,0,0.08))
  - Rounded corners (8px border-radius)
  - 40px padding for breathing room
  - Max-width: 800px, centered
- **Typography:**
  - Font: Raleway, 400 weight (clean, elegant)
  - Size: 20px desktop, 18px tablet, 16px mobile
  - Line-height: 1.8 for excellent readability
  - Color: #333333 (dark gray for readability)
- **Layout:** Centered alignment across all device sizes

#### 3. Masonry Gallery
A robust 3x3 gallery showcasing portfolio work:
- **Layout:** Masonry-style grid (automatically adjusts to image dimensions)
- **Grid Configuration:**
  - Desktop: 3 columns
  - Tablet: 2 columns
  - Mobile: 1 column
- **Images:** 9 placeholder images with descriptive titles:
  1. Wedding Photography
  2. Portrait Session
  3. Event Coverage
  4. Family Moments
  5. Corporate Events
  6. Nature Shots
  7. Studio Portraits
  8. Lifestyle Photography
  9. Creative Sessions
- **Hover Effects:**
  - Dark overlay (70% opacity) appears on hover
  - Title fades in with smooth animation
  - Image zoom effect for visual interest
- **Interaction:** Images link to full-size versions (lightbox-ready)
- **Gap:** 15px spacing between images

### Color Palette

The template uses XC Photography's brand colors:
- **Primary Gold:** `#d4af37` (CTAs, accents)
- **Dark Background:** `#1a1a1a` (hero backgrounds)
- **Light Gray:** `#f8f8f8` (section backgrounds)
- **White:** `#ffffff` (text boxes, buttons)
- **Text Dark:** `#333333` (body text)
- **Text Light:** `#e0e0e0` (hero subtext)

### Typography

**Primary Font:** Raleway
- Clean, modern sans-serif
- Used throughout all sections
- Weights: 400 (regular), 600 (semi-bold), 700 (bold)

### How to Import

#### Method 1: Elementor Template Library
1. In WordPress admin, go to **Templates → Saved Templates**
2. Click **Import Templates**
3. Upload `xcp-homepage-partial.json`
4. Click **Import Now**
5. The template will appear in your template library

#### Method 2: Page Import
1. Create a new page or edit an existing one
2. Click **Edit with Elementor**
3. Click the folder icon (top left) → **My Templates**
4. Click the upload icon
5. Select `xcp-homepage-partial.json`
6. Click **Insert** to add to your page

### Customization Guide

#### Replacing Placeholder Images
All images use placeholder URLs. Replace with actual images:

1. **Hero Background:**
   - Navigate to Hero Section → Background
   - Upload your cinematic hero image (recommended: 1920x1080px or larger)
   - Adjust overlay opacity if needed (default: 50%)

2. **Gallery Images:**
   - Edit the Masonry Gallery widget
   - Click each placeholder image
   - Upload your portfolio images
   - Recommended sizes: Mixed dimensions for true masonry effect (e.g., 600x400, 600x600)
   - Update Alt text and titles for each image

#### Adjusting Text Content
- **Headings:** Click any heading to edit text directly
- **Intro Narrative:** Edit the text within the text box to match your brand story
- **CTA Links:** Update button links to point to your actual contact form and portfolio pages

#### Color Customization
To match your specific branding:
1. Update button colors in Hero Section → Buttons
2. Modify background colors in each section's settings
3. Adjust text colors in typography settings

#### Responsive Adjustments
The template includes responsive settings for:
- **Desktop:** 1140px+ width
- **Tablet:** 768px - 1139px width
- **Mobile:** Up to 767px width

Adjust breakpoints in Elementor settings if needed.

### Technical Specifications

- **Elementor Version:** 3.16.0 or higher recommended
- **WordPress Version:** 6.4 or higher recommended
- **Template Type:** Page template
- **Layout:** Elementor Canvas (no header/footer by default)
- **Content Sections:** 3 (Hero, Narrative, Gallery)
- **Total Elements:** 13 widgets across 3 sections

### Best Practices

1. **Image Optimization:**
   - Compress hero background to under 500KB for fast loading
   - Gallery images should be optimized (use WebP format if possible)
   - Use CDN for better performance

2. **Accessibility:**
   - All images include alt text placeholders - replace with descriptive text
   - Maintain color contrast ratios (WCAG AA compliant)
   - Ensure headings follow proper hierarchy (H1 → H2 → H3)

3. **SEO:**
   - Update page title and meta description
   - Use descriptive alt text for all images
   - Ensure proper heading structure

4. **Performance:**
   - Lazy load gallery images
   - Consider using Elementor's optimization features
   - Minimize custom CSS/JS when possible

### Support & Resources

For questions or issues:
- **Elementor Documentation:** https://elementor.com/help/
- **Template Support:** Contact XC Photography development team
- **WordPress Forums:** https://wordpress.org/support/

### Version History

- **v1.0** (2025-11-10): Initial release with Hero, Narrative, and Masonry Gallery sections

---

**Created for XC Photography** | Premium Photography Branding
