# XCP Photography UK - Complete Site Architecture

## Site Structure & Visitor Journey

### Primary Pages

1. **Homepage** ✅ COMPLETE
   - Entry point for all visitors
   - Hero: "Your Story Deserves to Be Seen"
   - Clear path to contact form
   - Showcases transformation potential

2. **About Page**
   - "The Story Behind Your Story"
   - Client-centric narrative about partnership approach
   - Process transparency
   - Values alignment (authenticity, connection, elevation)
   - CTA: "Let's Create Your Story Together"

3. **Portfolio/Gallery Page**
   - "Stories That Resonate"
   - Filterable by industry/type
   - Before/after transformations
   - Client success stories integrated
   - CTA: "Ready for Your Transformation?"

4. **Services Page**
   - "Imagery That Elevates Your Brand"
   - Service packages focused on client outcomes
   - Investment guidance
   - Ideal client fit indicators
   - CTA: "Find Your Perfect Package"

5. **Blog/Stories Page**
   - "Insights for Your Brand Journey"
   - Educational content
   - Client transformation stories
   - Industry insights
   - CTA: "Start Your Own Story"

6. **Contact Page**
   - "Let's Bring Your Vision to Life"
   - Comprehensive contact form
   - What to expect next
   - FAQs
   - Direct contact options

### Navigation Flow

**Primary Navigation:**
- Home
- About
- Portfolio
- Services
- Stories (Blog)
- Contact

**User Journey Paths:**

1. **Awareness Stage** (First Visit)
   - Homepage → About → Portfolio
   - Goal: Build trust and showcase transformation

2. **Consideration Stage** (Exploring Fit)
   - Services → Portfolio → Stories
   - Goal: Demonstrate value and establish expertise

3. **Decision Stage** (Ready to Engage)
   - Any Page → Contact Form
   - Goal: Frictionless conversion

### Cross-Page CTAs

**Every page includes:**
- Primary CTA (context-specific)
- Secondary navigation to logical next step
- Footer with contact form link
- Consistent brand voice

### SEO Structure

**Homepage:** Broad brand keywords
**About:** "Photography partnership," "brand storytelling"
**Portfolio:** "Portfolio photography," "[industry] imagery"
**Services:** "Brand photography services," "corporate portraits"
**Stories:** Long-tail keywords, educational content
**Contact:** Local + service-specific keywords

### Mobile-First Approach

All pages optimized for:
- 320px (mobile)
- 768px (tablet)
- 1024px+ (desktop)

### Consistent Elements Across All Pages

1. **Hero Section** - Unique to each page, emotionally resonant
2. **Value Proposition** - Clear benefits for visitor
3. **Visual Breaks** - Images/galleries maintaining engagement
4. **Social Proof** - Stats, testimonials, client logos
5. **Strategic CTA** - Contextual, benefit-driven
6. **Footer** - Contact info, quick links, newsletter signup

---

## Implementation Priority

1. ✅ Homepage — Templates complete (`XCP_HomeP1–P5_*_FINAL.json`); placeholder images must be replaced
2. ✅ About Page — Templates complete (`XCP_About_P1_Hero_Story.json`, `XCP_About_P2_Process_CTA.json`)
3. ⚠️ Services Page — Template exists (`XCP_Services_P1_Packages.json`); pricing to be confirmed; booking CTA to add
4. ✅ Portfolio Page — Templates complete (`XCP_Portfolio_P1_Hero_Filter.json`, `XCP_Portfolio_P2_Gallery_CTA.json`); real images needed
5. ⚠️ Contact Page — Template complete (`XCP_Contact_P1_Complete.json`); GDPR consent field and Overture API webhook required
6. ✅ Blog/Stories Page — Template created (`XCP_Blog_P1_Grid_CTA.json`); 5 blog posts written and ready to publish
7. ✅ Header/Navigation — Template created (`XCP_Header_Navigation.json`); configure Elementor Pro Theme Builder
8. ✅ Footer — Template created (`XCP_Footer.json`); update contact details and social URLs before importing
9. ❌ Booking Page — Not yet created; required for Overture calendar embed
10. ❌ Privacy Policy — Required for GDPR; create via WordPress → Pages
11. ❌ Terms & Conditions — Recommended; create via WordPress → Pages

**See `PHASED_DEVELOPMENT_AUDIT.md` for the full gap analysis and phased build roadmap.**

---

## Technical Notes

- All templates use Elementor v0.4 format
- Staged imports to avoid file size issues
- Consistent naming: `XCP_[PageName]_[Section].json`
- Image paths: `[uc_local]assets/images/[page]/` — all placeholder paths must be replaced with real uploaded images
- Global styles applied via Elementor → Global Settings (typography: Montserrat + Open Sans; colours: #1a1a1a, #d4af37, #ffffff)
- Header and footer use Elementor Pro Theme Builder (Templates → Theme Builder → Header / Footer)
- Contact forms require Overture API webhook and GDPR acceptance field — see `PHASED_DEVELOPMENT_AUDIT.md` Appendix A
