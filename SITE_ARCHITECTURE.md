# XCP Photography UK - Complete Site Architecture

> **Navigation setup guide:** See [SITE_NAVIGATION_GUIDE.md](SITE_NAVIGATION_GUIDE.md) for WordPress menu setup, 3-click booking rule, audience journey maps, and WooCommerce shop structure.

## Domain Setup

| Item | Value |
|---|---|
| **Primary domain** | `xcphotography.co` |
| **Redirect** | `xcphotography.co.uk` → `xcphotography.co` (active redirect, future transfer planned) |
| **Admin URL** | `https://xcphotography.co/wp-admin` |
| **Contact email** | `info@xcphotography.co.uk` (mailbox hosted at .co.uk; works independently of domain redirect) |

> **Note:** All internal links and Elementor templates should use `xcphotography.co` as the base URL. Legacy references to `xcphotography.co.uk` in older docs still resolve correctly via redirect, but new work should reference `.co`.

## Site Structure & Visitor Journey

### Primary Pages

1. **Homepage** ✅ COMPLETE
   - Entry point for all visitors
   - Hero: "Your Story Deserves to Be Seen"
   - Clear path to contact form
   - Showcases transformation potential

2. **About Page** ✅ COMPLETE
   - "The Story Behind Your Story"
   - Client-centric narrative about partnership approach
   - Process transparency
   - Values alignment (authenticity, connection, elevation)
   - CTA: "Let's Create Your Story Together"

3. **Portfolio/Gallery Page** ✅ COMPLETE
   - "Stories That Resonate"
   - Filterable by industry/type
   - Before/after transformations
   - Client success stories integrated
   - CTA: "Ready for Your Transformation?"

4. **Services Page** ✅ COMPLETE
   - "Imagery That Elevates Your Brand"
   - Service packages focused on client outcomes
   - Investment guidance (from £1,495 — qualifier price)
   - Ideal client fit indicators
   - CTA: "Find Your Perfect Package"

5. **Blog / Stories Page** ✅ COMPLETE
   - "Insights for Your Brand Journey"
   - Educational content + client transformation stories
   - Music & events magazine section
   - Industry insights
   - CTA: "Start Your Own Story"

6. **Blog Post Template** ✅ COMPLETE
   - `XCP_Blog_Post_Template.json` — apply to every individual post
   - Consistent header, content area, related posts, end CTA

7. **Magazine Review Template** ✅ COMPLETE
   - `XCP_Magazine_Review_Template.json` — apply to music / event reviews
   - Hero image, star rating, review body, event details, booking CTA

8. **Contact Page** ✅ COMPLETE (form working — email confirmed March 2026)
   - "Let's Bring Your Vision to Life"
   - Comprehensive contact form (Overture email-confirmed working)
   - What to expect next
   - FAQs, direct contact options

9. **Workshops Page** ✅ COMPLETE
   - In-person and online workshops
   - `XCP_Workshop_S1_Hero.json` — hero + overview
   - `XCP_Workshop_S2_Formats_Pricing.json` — format cards + pricing
   - `XCP_Workshop_S3_Deposit_Booking.json` — deposit booking form
   - Deposit = minimum base rate; flexible (full/half/base depending on client)

10. **Shop Page** ✅ COMPLETE (WooCommerce templates ready)
    - `XCP_Shop_S1_Hero_Collections.json` — hero + collection highlights
    - `XCP_Shop_S2_Categories.json` — category grid (prints, books, gifts, presets)
    - `XCP_Shop_Product_Print_Template.json` — individual product page template
    - Products: fine art prints (framed & unframed), books, gifts, digital presets
    - Each product has a unique description — not the generic "taken in Brighton, A3/A2"

### Navigation Flow

**Primary Navigation (in order):**
- Home
- About
- Portfolio
- Services ▼ (dropdown: Brand Photography, Corporate Portraits, Events, Documentary)
- Shop ▼ (dropdown: Prints & Framed, Books, Gifts, Presets)
- Workshops ▼ (dropdown: In-Person, Online)
- Magazine ▼ (dropdown: Music & Events, Brand Stories, Behind the Lens)
- **[Book a Call]** ← always-visible CTA button, top-right

> Full navigation setup: [SITE_NAVIGATION_GUIDE.md](SITE_NAVIGATION_GUIDE.md)

**User Journey Paths:**

1. **Awareness Stage** (First Visit)
   - Homepage → About → Portfolio
   - Goal: Build trust and showcase transformation

2. **Consideration Stage** (Exploring Fit)
   - Services → Portfolio → Stories
   - Goal: Demonstrate value and establish expertise

3. **Decision Stage** (Ready to Engage)
   - Any Page → Contact Form (3 clicks or fewer)
   - Goal: Frictionless conversion

4. **Music / Events Audience**
   - Instagram / social → Magazine review → Shop (prints) or Contact (event coverage)

5. **Workshop Seeker**
   - Blog post (technique) → Workshops → Deposit booking form

6. **Gift Buyer**
   - Google → Shop → Product → WooCommerce checkout

### Cross-Page CTAs

**Every page includes:**
- Primary CTA (context-specific)
- Secondary navigation to logical next step
- Footer with contact form link
- Consistent brand voice

### SEO Structure

**Homepage:** Broad brand keywords — "brand photographer Brighton", "XC Photography"
**About:** "Photography partnership," "brand storytelling photographer UK"
**Portfolio:** "Portfolio photography," "[industry] imagery"
**Services:** "Brand photography services," "corporate portraits Brighton"
**Stories/Magazine:** Long-tail keywords, educational content, music/event coverage
**Workshops:** "Photography workshops Brighton," "online photography course"
**Shop:** "Fine art photography prints," "framed prints Brighton"
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
6. ✅ Contact Page — 4 sections complete; **form confirmed working (email)** March 2026; Overture CRM integration ready when needed — see [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md)
7. ✅ Blog/Stories Page — 6 sections complete (`XCP_Blog_S1` through `XCP_Blog_S6_Music_Shows.json`); blog posts written and ready to publish
8. ✅ Blog Post Template — `XCP_Blog_Post_Template.json`; apply to each individual post in Elementor
9. ✅ Magazine Review Template — `XCP_Magazine_Review_Template.json`; apply to each music/event review post
10. ✅ Workshop Page — 3 sections complete (`XCP_Workshop_S1_Hero.json`, `XCP_Workshop_S2_Formats_Pricing.json`, `XCP_Workshop_S3_Deposit_Booking.json`)
11. ✅ Shop Page — 3 sections complete (`XCP_Shop_S1_Hero_Collections.json`, `XCP_Shop_S2_Categories.json`, `XCP_Shop_Product_Print_Template.json`); install WooCommerce first — see [WOOCOMMERCE_INTEGRATION_GUIDE.md](WOOCOMMERCE_INTEGRATION_GUIDE.md)
12. ✅ Header/Navigation — Template created (`XCP_Header_Navigation.json`); configure WordPress Primary Menu — see [SITE_NAVIGATION_GUIDE.md](SITE_NAVIGATION_GUIDE.md)
13. ✅ Footer — Template created (`XCP_Footer.json`); update contact details and social URLs before importing
14. ✅ Booking Page — 3 sections complete (`XCP_Booking_S1_Hero_Trust.json`, `XCP_Booking_S2_Calendar_FAQ.json`, `XCP_Booking_S3_CTA.json`)
15. ✅ Thank You Page — Template created (`XCP_ThankYou_P1.json`); import into WordPress page at /thank-you and set as form redirect target
16. ✅ Privacy Policy — Template created (`XCP_Privacy_Policy_P1.json`); GDPR-compliant content included; review and import into WordPress page at /privacy-policy
17. ❌ Terms & Conditions — Recommended; create manually in WordPress → Pages (standard service contract T&Cs to be drafted separately)
18. ❌ Individual product pages — Use `XCP_Shop_Product_Print_Template.json` as the base; each product gets a unique description (not generic) per brand guidelines

**See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the complete import order. See [SITE_NAVIGATION_GUIDE.md](SITE_NAVIGATION_GUIDE.md) for WordPress menu setup.**

---

## Technical Notes

- All templates use Elementor v0.4 format
- Staged imports to avoid file size issues
- Consistent naming: `XCP_[PageName]_[Section].json`
- Image paths: `[uc_local]assets/images/[page]/` — all placeholder paths must be replaced with real uploaded images
- **No inline styling in any JSON** — all colours, fonts, spacing use Elementor Global Settings only. See [ELEMENTOR_GLOBAL_SETTINGS.md](ELEMENTOR_GLOBAL_SETTINGS.md)
- Global colours: Primary `#CECECE`, Secondary `#A2A1A1`, Text `#919191`, Accent `#BBBBBB`, Custom Primary Font `#D5D5D5` (platinum/silver on dark)
- Header and footer use Elementor Pro Theme Builder (Templates → Theme Builder → Header / Footer)
- Contact forms: email confirmed working March 2026; Overture CRM connection ready when API key corrected — see [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md)
- **Form reuse:** The enquiry form can be copied to any page. Import any of the contact form JSONs or copy the section in Elementor. The WPCode Overture snippet fires on all forms named `XCP Contact: Overture` regardless of page.
