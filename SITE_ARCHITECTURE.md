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

1. ✅ Homepage — Templates complete (9 sections across `XCP_Home_S1a` through `XCP_Home_S6_Contact_Form.json`); placeholder images must be replaced
2. ✅ About Page — Templates complete (5 sections: `XCP_About_S1a` through `XCP_About_S4_Steps34_CTA.json`)
3. ✅ Services Page — Templates complete (3 sections: `XCP_Services_S1_Hero_Intro.json`, `XCP_Services_S2_Foundation_Elevation.json`, `XCP_Services_S3_Transformation_Bespoke.json`)
4. ✅ Service Sub-pages — 4 individual service landing pages for SEO: Brand Photography, Documentary, Corporate Portraits, Events (`XCP_Service_*_P1.json`)
5. ✅ Portfolio Page — Templates complete (`XCP_Portfolio_P1_Hero_Filter.json`, `XCP_Portfolio_P2_Gallery_CTA.json`); real images needed
6. ✅ Contact Page — 3 sections complete; **currently using email fallback form** (`XCP_Contact_P2_Form_Fallback.json`); Overture form available in `XCP_Contact_P2_Form_Overture.json` when ready — see OVERTURE_SETUP_GUIDE.md
7. ✅ Blog/Stories Page — 6 sections complete (`XCP_Blog_S1` through `XCP_Blog_S6_Music_Shows.json`); blog posts written and ready to publish
8. ✅ Header/Navigation — Template created (`XCP_Header_Navigation.json`); configure Elementor Pro Theme Builder
9. ✅ Footer — Template created (`XCP_Footer.json`); update contact details and social URLs before importing
10. ✅ Booking Page — 3 sections complete (`XCP_Booking_S1_Hero_Trust.json`, `XCP_Booking_S2_Calendar_FAQ.json`, `XCP_Booking_S3_CTA.json`)
11. ✅ Thank You Page — Template created (`XCP_ThankYou_P1.json`); import into a WordPress page at /thank-you and set as form redirect target
12. ✅ Privacy Policy — Template created (`XCP_Privacy_Policy_P1.json`); GDPR-compliant content included; review and import into WordPress page at /privacy-policy
13. ❌ Terms & Conditions — Recommended; create manually in WordPress → Pages (standard service contract T&Cs to be drafted separately)

**See `PHASED_DEVELOPMENT_AUDIT.md` for the full gap analysis and phased build roadmap.**

---

## Technical Notes

- All templates use Elementor v0.4 format
- Staged imports to avoid file size issues
- Consistent naming: `XCP_[PageName]_[Section].json`
- Image paths: `[uc_local]assets/images/[page]/` — all placeholder paths must be replaced with real uploaded images
- Global styles applied via Elementor → Global Settings (typography: Raleway + Open Sans; colours: #1a1a1a, #d4af37, #ffffff)
- Header and footer use Elementor Pro Theme Builder (Templates → Theme Builder → Header / Footer)
- Contact forms require Overture API webhook and GDPR acceptance field — see `PHASED_DEVELOPMENT_AUDIT.md` Appendix A
