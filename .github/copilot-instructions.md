# GitHub Copilot Instructions for XCP_Branding

## Repository Overview

This repository contains the Elementor homepage layout template and comprehensive section templates for XC Photography's branding and documentary photography website. It primarily consists of:

- **Elementor JSON templates** - Website templates in Elementor v0.4 format
- **HTML preview files** - Static HTML previews of the templates
- **Documentation files** - Comprehensive guides for implementation and customization

## Project Context

### Purpose
This is a website template repository for XC Photography UK, a branding and documentary photography business. The templates are designed to be imported into WordPress sites using the Elementor page builder.

### Target Audience
- Web developers implementing XC Photography websites
- Designers customizing the templates
- Content managers updating copy and images

## File Structure and Naming Conventions

### Template Files
- **Pattern**: `XCP_[PageName]_[Section].json`
- Examples: `XCP_HomeP1_Hero_Gallery.json`, `XCP_About_P1_Hero_Story.json`
- Files ending in `_FINAL.json` are the approved versions

### HTML Files
- `preview.html` - Static preview of the design
- `sections-template.html` - Complete HTML template with all sections
- `contact-form-section.html` - Standalone contact form template

### Documentation Files
- `README.md` - Main overview and quick start
- `TEMPLATE_DOCUMENTATION.md` - Detailed installation guide
- `SECTIONS_GUIDE.md` - Implementation guide for sections
- `SITE_ARCHITECTURE.md` - Complete site structure
- Other guides: `HOW_TO_ADD_IMAGES.md`, `CONTENT_COPY_UPDATES.md`, etc.

## Making Changes

### When Modifying JSON Template Files
1. **Preserve Structure**: Elementor JSON files have a specific schema - maintain the structure
2. **Version Control**: Create `_FINAL.json` versions for approved templates
3. **Backup Files**: Keep `.backup` files when making significant changes
4. **Image Paths**: Use the convention `[uc_local]assets/images/[page]/`
5. **Naming**: Follow the established `XCP_[PageName]_[Section].json` pattern

### When Updating Documentation
1. **Consistency**: Maintain the existing documentation style and formatting
2. **Cross-references**: Update related documentation files when making changes
3. **Completeness**: Ensure all sections, features, and instructions are documented
4. **Examples**: Include practical examples and use cases where relevant

### When Adding New Templates or Sections
1. **Follow Naming Convention**: Use `XCP_[PageName]_P[Number]_[Description].json`
2. **Update Documentation**: Add entries to relevant guides (SECTIONS_GUIDE.md, SITE_ARCHITECTURE.md)
3. **Create Preview**: Consider adding preview HTML if it's a major section
4. **Test Import**: Verify the JSON can be imported into Elementor successfully

## Content Guidelines

### Brand Voice
- **Professional** but approachable
- **Client-centric** language focusing on transformation and partnership
- **Action-oriented** with clear CTAs
- **Authentic** reflecting the photographer's approach

### Copy Patterns
- Headings: Emotional, benefit-driven ("Your Story Deserves to Be Seen")
- Subheadings: Clarifying, supportive ("Iconic Imagery for Iconic Brands with an Edge")
- CTAs: Direct, value-focused ("Book Your Free Consultation", "View Portfolio")

## Technical Specifications

### Elementor Requirements
- Compatible with Elementor Free or Pro
- Format: Elementor v0.4
- WordPress compatible theme required

### Responsive Design
All templates must support:
- Mobile: 320px minimum
- Tablet: 768px
- Desktop: 1024px+

### Page Structure
Standard page elements across templates:
1. Hero Section (unique per page)
2. Value Proposition
3. Visual breaks (images/galleries)
4. Social proof (stats, testimonials, logos)
5. Strategic CTA
6. Footer

## Testing and Validation

### For Template Changes
1. Validate JSON syntax
2. Test import in Elementor (if possible)
3. Verify responsive behavior in preview
4. Check image path references
5. Ensure CTAs are functional

### For Documentation Changes
1. Check markdown syntax
2. Verify all links work
3. Ensure consistency with other docs
4. Test code examples if included

## Common Tasks

### Adding a New Page Template
1. Create JSON file: `XCP_[PageName]_P1_[Section].json`
2. Update `SITE_ARCHITECTURE.md` with the new page
3. Add section details to `SECTIONS_GUIDE.md`
4. Update `README.md` with file listing if major addition
5. Consider creating a preview HTML file

### Updating Site Content
1. Review `CONTENT_COPY_UPDATES.md` for copy guidelines
2. Maintain brand voice and messaging consistency
3. Update any affected template files
4. Document changes in relevant guides

### Adding Images
1. Follow instructions in `HOW_TO_ADD_IMAGES.md`
2. Use proper path convention: `[uc_local]assets/images/[page]/`
3. Ensure responsive versions are considered
4. Update documentation if adding new image sections

## Important Notes

- **No Build Process**: This repository contains templates and documentation only - no compilation or build steps required
- **No Testing Framework**: Changes should be validated through Elementor import and visual inspection
- **No Dependencies**: No package managers or external dependencies
- **Static Content**: All content is static; changes are direct file edits

## Optimization Priorities

When making improvements, prioritize:
1. **User Experience**: Clear navigation, logical flow, mobile responsiveness
2. **Documentation Clarity**: Instructions should be accessible to non-technical users
3. **Template Consistency**: Maintain visual and structural patterns across pages
4. **SEO Readiness**: Proper heading hierarchy, semantic HTML, descriptive content

## Questions to Consider

Before making changes, ask:
- Does this change maintain consistency with existing templates?
- Is the documentation updated to reflect this change?
- Will this work across different screen sizes?
- Does this align with the brand voice and photography business focus?
- Are file naming conventions followed?
