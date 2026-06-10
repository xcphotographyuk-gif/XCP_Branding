# XC Photography Homepage Layout Documentation

## Overview
This directory contains the Elementor page layout configuration for the XC Photography website homepage. The layout is designed to be imported directly into WordPress/Elementor with minimal post-upload edits.

## File: `homepage-layout.json`

### Purpose
A complete, production-ready Elementor layout that implements a professional photography website homepage with five distinct sections optimized for conversion and user engagement.

---

## Layout Structure

### 1. **Hero Section**
**Purpose**: Create immediate visual impact and guide visitors to primary actions

**Components**:
- **Full-width cinematic background**
  - 100vh height for full viewport coverage
  - Overlay with 50% opacity for text readability
  - Background image placeholder (add your hero image URL after import)
  
- **Typography**:
  - **H1**: "Capturing Your Most Precious Moments" (56px, Raleway Bold)
  - **H2**: "Professional Photography That Tells Your Story" (32px, Raleway Regular)
  - **Subheading**: Descriptive text explaining services (18px)
  
- **Call-to-Action Buttons**:
  - **Primary CTA**: "Book Your Free Consultation" (Gold/Platinum #D4AF37)
    - Links to contact form (#contact-form anchor)
  - **Secondary CTA**: "View Portfolio" (Outline style)
    - Links to portfolio page

**Customization Notes**:
- Replace background image URL in the settings
- Update CTA links to match your actual page structure
- Text shadow included for readability over images

---

### 2. **Bold Intro Narrative Section**
**Purpose**: Establish brand ethos and create emotional connection

**Components**:
- **Boxed layout** (900px max-width)
- **Platinum-styled container**:
  - Gradient background (E8E8E8 to D4D4D4)
  - Gold left border accent (#D4AF37)
  - Elevated shadow for depth
  
- **Typography**:
  - Font: Playfair Display (serif) or Raleway (clean sans-serif)
  - Size: 22px
  - Weight: 400 (regular)
  - Line height: 1.8 for readability
  - Color: Dark gray (#2C2C2C)

**Responsive Design**:
- Tablet: Reduced side margins (20px)
- Mobile: Further reduced margins (10px)
- Padding adjusts automatically

**Content**: Pre-filled with brand ethos text (fully editable in Elementor)

---

### 3. **Micro-Portfolio Section**
**Purpose**: Showcase best work in an engaging grid format

**Components**:
- **Heading**: "Featured Work" (42px, Raleway Bold)
- **Masonry Gallery Widget**:
  - 3 columns on desktop
  - 2 columns on tablet
  - 1 column on mobile
  - 15px gap between images
  
- **Gallery Features**:
  - Hover animation: "grow" effect
  - Dark overlay on hover (70% opacity)
  - Image captions display on hover
  - Lightbox enabled (link to file)
  - Caption source: Image title from Media Library

**Setup Instructions**:
1. After import, click on the gallery widget
2. Add 9 images from your Media Library
3. Ensure each image has a descriptive title in the Media Library
4. Titles will automatically appear as captions on hover

**Note**: A helper text widget reminds you to add images after import

---

### 4. **About Section**
**Purpose**: Build trust and credibility with visitors

**Components**:
- **Split Layout** (50/50 columns):
  
  **Left Column - Image**:
  - Full-size image placeholder
  - Rounded corners (8px border-radius)
  - Subtle shadow for depth
  - Responsive: Stacks on mobile
  
  **Right Column - Content**:
  - **Heading**: "About XC Photography" (38px, Raleway Bold)
  - **Body Text**: Two paragraphs of narrative (17px, Raleway)
  - **CTA Button**: "Learn More About Us"
    - Links to /about page
    - Gold background (#D4AF37)
    - Medium size with comfortable padding

**Customization**:
- Add your portrait or team photo in the image widget
- Update the about text to reflect your story
- Verify the /about page link

**Responsive Behavior**:
- Desktop: Side-by-side layout
- Tablet/Mobile: Stacked (image on top, text below)

---

### 5. **Two-Stage Client Funnel**

#### **Stage 1: Quick Contact Form**
**Purpose**: Low-friction initial contact point

**Form Fields**:
1. **Name** (text, required)
2. **Email** (email, required)
3. **Phone** (tel, optional)
4. **General Requirement Description** (textarea, required)
   - Guides users to describe their needs

**Styling**:
- Light background (#F9F9F9) for fields
- Gold submit button (#D4AF37)
- 4px rounded corners
- Clear labels and placeholders

**Form Actions**:
- Sends email to: info@xcphotography.com
- Redirects to: #qualifier-form (Stage 2)

**Customization Required**:
- Update `email_to` address to your actual email
- Configure email service in Elementor settings

---

#### **Stage 2: Project Qualifier (Optional)**
**Purpose**: Collect detailed project information from interested leads

**Form Fields**:
1. **Event/Project Type** (dropdown)
   - Options: Wedding, Portrait, Commercial, Corporate, Family, Engagement, Other
2. **Preferred Timeline/Event Date** (date picker)
3. **Budget Range** (dropdown)
   - Options: Under £500 to Over £5,000
4. **Location/Venue** (text)
5. **Number of Attendees/Subjects** (number)
6. **Expected Duration** (dropdown)
   - Options: 1-2 hours to Multiple days
7. **Portfolio/Social Media Usage** (radio buttons)
   - Client consent for image usage
8. **Additional Notes** (textarea)

**Styling**:
- White background fields for contrast
- Dark submit button (#2C2C2C)
- Professional, clean appearance

**Form Actions**:
- Sends detailed email to: info@xcphotography.com
- Shows success message
- Subject: "New Qualified Lead - Project Details"

**User Flow**:
1. Visitor fills Stage 1 (quick contact)
2. On submit, auto-scrolls to Stage 2
3. Visitor optionally provides detailed project info
4. Both submissions arrive via email

---

## Design System

### Color Palette
- **Primary Gold**: #D4AF37 (Platinum/Gold accent)
- **Dark Gray**: #2C2C2C (Primary text)
- **Medium Gray**: #555555 (Secondary text)
- **Light Gray**: #666666 (Tertiary text)
- **Background Light**: #F9F9F9
- **Background Platinum**: #E8E8E8 to #D4D4D4 (gradient)
- **White**: #FFFFFF

### Typography
- **Primary Font**: Raleway (Sans-serif)
  - Headings: 600-700 weight
  - Body: 400 weight
- **Accent Font**: Playfair Display (Serif)
  - Used in intro narrative for elegance

### Spacing System
- Section padding: 80px vertical, 20px horizontal
- Element margins: 15-50px depending on hierarchy
- Responsive adjustments automatically applied

---

## Import Instructions

### Prerequisites
- WordPress installed
- Elementor Pro plugin activated (required for Forms widget)
- Theme that supports Elementor Canvas template

### Import Steps

1. **Login to WordPress Admin**
   - Navigate to: Pages > Add New

2. **Edit with Elementor**
   - Click "Edit with Elementor" button

3. **Import Template**
   - Click folder icon (Template Library) in Elementor
   - Go to "Import" tab
   - Upload `homepage-layout.json`
   - Click "Import Now"

4. **Insert Template**
   - Find "XC Photography Homepage Layout" in your templates
   - Click "Insert" to apply to the page

5. **Post-Import Customization** (Required):
   
   **Hero Section**:
   - [ ] Upload and select hero background image
   - [ ] Update CTA button links if needed
   
   **Intro Narrative**:
   - [ ] Customize brand message text
   
   **Portfolio Gallery**:
   - [ ] Add 9 curated images from Media Library
   - [ ] Ensure each image has a title
   
   **About Section**:
   - [ ] Upload your portrait/team photo
   - [ ] Customize about text
   - [ ] Verify /about page link
   
   **Contact Forms**:
   - [ ] Update `email_to` address in both forms
   - [ ] Configure Elementor email settings
   - [ ] Test form submissions
   - [ ] Set up email notifications (Elementor > Settings > Integrations)

6. **Publish**
   - Click "Publish" button
   - Set as homepage: Settings > Reading > Static Page

---

## Responsive Behavior

### Desktop (1200px+)
- Full-width hero section
- 3-column portfolio grid
- Side-by-side about layout
- All sections at optimal spacing

### Tablet (768px - 1199px)
- 2-column portfolio grid
- About section remains side-by-side
- Reduced margins in intro narrative
- Buttons remain full-size

### Mobile (< 768px)
- Single-column portfolio grid
- Stacked about section (image top, text bottom)
- Reduced font sizes (auto-scaled by Elementor)
- Optimized padding and margins
- Touch-friendly button sizes maintained

---

## Form Configuration

### Required Elementor Pro Settings

1. **Email Delivery**:
   - Elementor > Settings > Integrations
   - Configure SMTP or email service
   - Recommended: WP Mail SMTP plugin

2. **Form Actions**:
   - Each form sends to specified email
   - Stage 1 redirects to Stage 2
   - Stage 2 shows success message

3. **Spam Protection** (Recommended):
   - Enable reCAPTCHA in Elementor settings
   - Add reCAPTCHA field to forms

### Testing Checklist
- [ ] Stage 1 form submits successfully
- [ ] Email arrives with form data
- [ ] Redirect to Stage 2 works
- [ ] Stage 2 form submits successfully
- [ ] Success message displays
- [ ] All field validations work
- [ ] Responsive layout functions on mobile

---

## Customization Tips

### Branding Adjustments
1. **Colors**: Search and replace hex codes in JSON before import
2. **Fonts**: Update `typography_font_family` values
3. **Spacing**: Modify `_padding` and `_margin` values

### Content Updates
- All text is editable directly in Elementor
- No raw HTML editing required
- Widget-based approach for easy updates

### Advanced Customization
- Add animations: Motion Effects in Elementor
- Custom CSS: Advanced tab in widget settings
- Add more sections: Drag and drop new sections

---

## Technical Specifications

### JSON Structure
- **Version**: 0.4 (Elementor export format)
- **Type**: Page template
- **Compatibility**: Elementor 3.0+
- **Required Widgets**: 
  - Heading
  - Text Editor
  - Button
  - Image
  - Gallery
  - Form (Pro)

### Performance Optimization
- Uses native Elementor widgets (no heavy plugins)
- Masonry gallery for optimal image loading
- Minimal custom CSS
- Mobile-first responsive design

### Browser Compatibility
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

---

## Support and Maintenance

### Common Issues

**Issue**: Gallery images not displaying
- **Solution**: Ensure images are in Media Library and assigned to gallery widget

**Issue**: Forms not sending emails
- **Solution**: Configure SMTP in Elementor settings or install WP Mail SMTP

**Issue**: Layout looks broken on mobile
- **Solution**: Clear Elementor cache (Tools > Regenerate CSS)

**Issue**: Template won't import
- **Solution**: Ensure Elementor Pro is activated and updated

### Future Updates
- Regularly update Elementor and Elementor Pro
- Test layout after major updates
- Backup layout before making changes (export template)

---

## File Metadata

- **Created**: 2025
- **Version**: 1.0
- **Author**: XC Photography Development Team
- **License**: Proprietary
- **File Size**: ~29KB
- **Total Sections**: 5
- **Total Widgets**: 20+
- **Responsive Breakpoints**: 3 (Desktop, Tablet, Mobile)

---

## Changelog

### Version 1.0 (Initial Release)
- ✅ Hero section with dual CTAs
- ✅ Platinum-styled intro narrative
- ✅ 3x3 masonry portfolio gallery
- ✅ Split-layout about section
- ✅ Two-stage client funnel forms
- ✅ Full responsive design
- ✅ Professional color scheme
- ✅ Optimized typography

---

## Additional Resources

### Recommended Plugins
- **Elementor Pro**: Required for form functionality
- **WP Mail SMTP**: Reliable email delivery
- **Wordfence**: Security
- **WP Rocket**: Performance optimization

### WordPress Settings
- **Permalinks**: Set to "Post name"
- **Media**: Enable image uploads, recommended max size 2MB
- **Privacy**: Set up privacy policy page

### Asset Preparation
- **Hero Image**: 1920x1080px minimum, optimized JPEG
- **Portfolio Images**: 800x800px, optimized JPEG/PNG
- **About Image**: 600x800px portrait orientation
- **File Format**: JPEG for photos, PNG for graphics
- **Optimization**: Use TinyPNG or similar before upload

---

## Contact for Support

For technical issues or customization requests:
- Email: info@xcphotography.com
- Documentation updates: Check repository for latest version

---

**End of Documentation**
