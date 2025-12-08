# XCP_Branding
XC-Photography Website - Elementor Homepage Template

## Overview
This repository contains the Elementor homepage layout template for XC Photography's branding and documentary photography website with comprehensive section templates.

## Files Included

- **elementor-homepage-template.json** - Elementor template file ready for import
- **TEMPLATE_DOCUMENTATION.md** - Comprehensive installation and customization guide
- **preview.html** - Static HTML preview of the template design
- **sections-template.html** - Complete HTML template with all homepage sections
- **SECTIONS_GUIDE.md** - Detailed implementation guide for all sections

## Quick Start

1. Review `sections-template.html` for complete HTML structure
2. Read `SECTIONS_GUIDE.md` for detailed implementation instructions
3. Import `elementor-homepage-template.json` into your WordPress/Elementor installation
4. Follow the detailed instructions in `TEMPLATE_DOCUMENTATION.md`
5. Preview the design by opening `preview.html` or `sections-template.html` in a web browser

## Homepage Sections Included

### Core Sections
1. **Hero Section** - Full-width cinematic background with woman's eye peeking through hair, cross-page CTA widget
2. **Gallery Bar** - 4 text boxes in responsive gallery layout with smooth transitions
3. **Parallax Transition** - Triumph bike in snow background with CTA banner
4. **Masonry Gallery** - Grid-style responsive gallery with dynamic heights
5. **Text Content Block** - Narrative-driven text section for storytelling
6. **Checkerboard Layout** - Alternating image/text sections (left-right, right-left)

### Additional Sections
7. **Statistics Bar** - Key metrics display (500+ projects, 150+ clients, etc.)
8. **Process Timeline** - 4-step process breakdown
9. **Video Showcase** - Full-height video section with play button
10. **Testimonials** - Client testimonial carousel
11. **Brand Partners** - Logo grid of trusted brands

## Template Features

### Hero Section
- Full-width cinematic background imagery
- Bold headline: "Branding & Documentary Photography That Demands Attention"
- Subheading: "Iconic Imagery for Iconic Brands with an Edge"
- Dual CTAs: "Book Your Free Consultation" and "View Portfolio"

### Masonry Gallery Section
- Professional grid layout
- Three placeholder galleries: Striking Stories, Embracing Individuality, Timeless Beauty
- Hover animations and responsive design

### Placeholder Section
- Customizable content area for testimonials, services, or additional information

## Documentation

For detailed installation instructions, customization options, and best practices, please refer to [TEMPLATE_DOCUMENTATION.md](TEMPLATE_DOCUMENTATION.md).

## Added: Portfolio page & data

A new portfolio page and JSON data file have been added in this branch to provide a fully functional gallery that can be extended. Files added:
- data/projects.json (sample items)
- portfolio.html
- contact.html
- assets/css/portfolio.css
- assets/js/portfolio.js

How to preview locally:
- Serve the repo root with a static server (e.g., `npx http-server` or `python -m http.server`) and visit http://localhost:8080/portfolio.html

Notes for maintainers:
- Replace image placeholders under /images/portfolio/ with optimized JPEG/WebP files and update paths in data/projects.json.
- If your site uses an include/header system, update navigation to link to /portfolio.html and /contact.html.
