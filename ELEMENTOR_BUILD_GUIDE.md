# XCP Photography — Elementor Site Build Guide
## Complete Standalone Reference: Install, Import, Configure

This document covers everything needed to build the XCP Photography website from scratch
using the JSON templates in this repository. Follow the steps in order.

---

## Overview: What You Are Building

| Page | Template Files | Type |
|---|---|---|
| Home | HomeP1 + HomeP2 + HomeP3 + HomeP4 + HomeP5 | Page (5 sections) |
| About | About_P1 + About_P2 | Page (2 sections) |
| Services | Services_P1 | Page (1 section) |
| Portfolio | Portfolio_P1 + Portfolio_P2 | Page (2 sections) |
| Stories (Blog) | Blog_P1 | Page (1 section) |
| Contact | Contact_P1 + Contact_P2 + Contact_P4 | Page (3 sections) |
| Booking | Booking_Page | Page (1 section) |
| Header | Header_Navigation | Header (global) |
| Footer | Footer | Footer (global) |

---

## Part 1: WordPress and Elementor Setup

### 1.1 WordPress Requirements

- WordPress 6.3 or later
- PHP 8.0 or later
- MySQL 5.7 or later
- HTTPS enabled (SSL certificate installed)
- Memory limit: 256MB minimum (set in wp-config.php or php.ini)

```php
// Add to wp-config.php if needed:
define('WP_MEMORY_LIMIT', '256M');
```

### 1.2 Required Plugins — Install These First

Install and activate all of these before importing any templates.

**Core (required — site will not work without these):**

| Plugin | Where to Get | Why It Is Needed |
|---|---|---|
| Elementor (free) | WordPress plugin directory | Page builder engine |
| Elementor Pro | elementor.com | Forms widget, nav-menu widget, header/footer builder, posts widget, global sections |
| WooCommerce | WordPress plugin directory | Shop, booking products, cart, checkout |

**Strongly recommended (used in templates):**

| Plugin | Where to Get | Why |
|---|---|---|
| Yoast SEO or Rank Math | WordPress plugin directory | SEO meta, sitemap, schema |
| WP Rocket or LiteSpeed Cache | Their respective sites | Performance, image lazy load |
| Smush or ShortPixel | WordPress plugin directory | Image compression |
| Contact Form 7 (fallback only) | WordPress plugin directory | Backup if Elementor forms are not available |

**Optional but useful:**

| Plugin | Why |
|---|---|
| WooCommerce Stripe Gateway | Card payments without PayPal |
| Fluent CRM | Email list for blog subscribers |
| MonsterInsights | Google Analytics integration |

### 1.3 Elementor Pro Settings

Once Elementor Pro is activated:

1. **Elementor > Settings > Experiments** — enable Container (Flexbox) if prompted
2. **Elementor > Settings > Style** — set default colours:
   - Primary: `#E8E4DC` (platinum)
   - Secondary: `#FFFFFF`
   - Text: `#333333`
   - Accent: `#000000`
3. **Elementor > Settings > Typography** — set default fonts:
   - Primary font: Raleway (or your chosen heading font)
   - Secondary font: Raleway (or your chosen body font)
4. **Elementor > Theme Builder** — this is where Header and Footer templates are imported

---

## Part 2: Theme Setup

### 2.1 Install a Blank/Hello Theme

Use **Hello Elementor** (free, official Elementor theme) — it outputs the least
interfering code and gives Elementor full control.

Appearance > Themes > Add New > search "Hello Elementor" > Install > Activate

### 2.2 Disable the Theme Header and Footer

With Hello Elementor active, the theme header and footer are blank by default.
The XCP header and footer are built in Elementor Pro's Theme Builder — they override
the theme completely.

---

## Part 3: Create the Page Structure

Before importing templates, create empty pages with the correct slugs.
This ensures internal links work immediately after import.

Go to **Pages > Add New** and create each page below. Title and slug must match exactly.

| Page Title | URL Slug | Template Setting |
|---|---|---|
| Home | (front page) | Elementor Full Width |
| About | `/about` | Elementor Full Width |
| Services | `/services` | Elementor Full Width |
| Portfolio | `/portfolio` | Elementor Full Width |
| Stories | `/stories` | Elementor Full Width |
| Contact | `/contact` | Elementor Full Width |
| Book a Call | `/book` | Elementor Full Width |
| Privacy Policy | `/privacy-policy` | Default |
| Terms and Conditions | `/terms-and-conditions` | Default |
| Cookie Policy | `/cookie-policy` | Default |

**Set front page:** Settings > Reading > Static page > select "Home"

**Set blog page:** Settings > Reading > Posts page > select "Stories"

---

## Part 4: Import the Header and Footer

The header and footer are global templates — import them first, before any page templates.

### 4.1 Import Header

1. Elementor > Theme Builder > Header > Add New
2. Click the folder icon (Import Template)
3. Upload `XCP_Header_Navigation.json`
4. Set display conditions: Entire Site
5. Save and publish

### 4.2 Import Footer

1. Elementor > Theme Builder > Footer > Add New
2. Click the folder icon (Import Template)
3. Upload `XCP_Footer.json`
4. Set display conditions: Entire Site
5. Save and publish

---

## Part 5: Import Page Templates

For each page, open the page in Elementor, then import each template section in order.

### Import method (same for every section):
1. Open the page in Elementor editor
2. Click the grey folder icon at the bottom of the canvas (or the "+" > Templates)
3. Go to "My Templates" > Import
4. Upload the JSON file
5. Click "Insert"
6. Repeat for each section of the same page, in order

---

### 5.1 Home Page

Import in this order:

| Order | File | Section title |
|---|---|---|
| 1 | `XCP_HomeP1_Hero_Gallery_FINAL.json` | Hero + gallery bar |
| 2 | `XCP_HomeP2_Parallax_Text_FINAL.json` | Parallax text panel |
| 3 | `XCP_HomeP3_Checkerboard_FINAL.json` | Checkerboard: brand + story |
| 4 | `XCP_HomeP4_Stats_Process_FINAL.json` | Stats, pillars, process |
| 5 | `XCP_HomeP5_Testimonials_CTA_FINAL.json` | Testimonials + final CTA |

### 5.2 About Page

| Order | File | Section title |
|---|---|---|
| 1 | `XCP_About_P1_Hero_Story.json` | Hero, values, credentials |
| 2 | `XCP_About_P2_Process_CTA.json` | Process steps + CTA |

### 5.3 Services Page

| Order | File | Section title |
|---|---|---|
| 1 | `XCP_Services_P1_Packages.json` | Hero + all three packages + bespoke |

### 5.4 Portfolio Page

| Order | File | Section title |
|---|---|---|
| 1 | `XCP_Portfolio_P1_Hero_Filter.json` | Hero + filter tabs + grid |
| 2 | `XCP_Portfolio_P2_Gallery_CTA.json` | Extended gallery + CTA |

### 5.5 Stories (Blog) Page

| Order | File | Section title |
|---|---|---|
| 1 | `XCP_Blog_P1_Grid_CTA.json` | Blog grid + newsletter CTA |

### 5.6 Contact Page

Two versions of the contact form are provided. Use one only.

**Version A — Overture (recommended):**

| Order | File |
|---|---|
| 1 | `XCP_Contact_P1_Hero.json` |
| 2 | `XCP_Contact_P2_Form_Overture.json` |
| 3 | `XCP_Contact_P4_CTA.json` |

**Version B — Email fallback (if Overture is not available):**

| Order | File |
|---|---|
| 1 | `XCP_Contact_P1_Hero.json` |
| 2 | `XCP_Contact_P2_Form_Fallback.json` |
| 3 | `XCP_Contact_P4_CTA.json` |

Note: `XCP_Contact_P1_Complete.json` is a single-file all-in-one version of the contact
page — use this as an alternative to the three-section approach above if preferred.

### 5.7 Booking Page

| Order | File |
|---|---|
| 1 | `XCP_Booking_Page.json` |

---

## Part 6: Fonts

No Google Fonts are hard-coded in the templates — fonts are set through Elementor's
global settings (Part 1.3 above). This keeps the site under your control and avoids
third-party font load issues.

**Recommended font pairing (free, on Google Fonts):**

| Role | Font | Weight |
|---|---|---|
| Headings | Raleway | 400, 700 |
| Body | Raleway | 300, 400, 700 |
| Labels / caps | Raleway | 400 (letter-spacing applied via Elementor) |

**To load these in WordPress:**
Install the plugin **OMGF (Optimize My Google Fonts)** — it downloads the fonts to
your server so there is no outbound call to Google. GDPR-compliant and faster.

Or add to your theme's `functions.php`:
```php
function xcp_enqueue_fonts() {
    wp_enqueue_style(
        'xcp-fonts',
        'https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,400;0,700;1,400&family=Raleway:wght@300;400;700&display=swap',
        array(),
        null
    );
}
add_action( 'wp_enqueue_scripts', 'xcp_enqueue_fonts' );
```

---

## Part 7: Images — What to Upload and Where

All image references in the templates use the placeholder format `[uc_local]assets/images/...`
These will appear as broken images after import until replaced. This is expected — the
templates are built around your actual photography, not stock images.

### Image slots to fill (upload to Media Library, then click each widget to swap in)

**Home — Hero and Gallery (HomeP1):**
- `hero-woman-hair.jpg` — main hero background: use your strongest brand/portrait image
- `gallery-1.jpg` through `gallery-4.jpg` — the 4-box gallery bar below the hero

**Home — Parallax (HomeP2):**
- `triumph-bike-snow.jpg` — parallax background: full-bleed, strong, moody. Use a City Spirit image or strong editorial shot.

**Home — Checkerboard (HomeP3):**
- `checkerboard-1.jpg` — left panel: brand/editorial
- `checkerboard-2.jpg` — right panel: documentary/music

**Home — Partner logos (HomeP5):**
- `partner-logo-1.png` through `partner-logo-5.png` — Hotel du Vin, Concorde 2, Slack City, Sussex Business Show, + one more. White/transparent PNG logos, approx 160x60px.

**About — Hero (About_P1):**
- `about/hero-partnership.jpg` — about page hero background: use a behind-the-scenes or portrait of Xavier working

**About — Process steps (About_P2):**
- `about/process-discovery.jpg` — conversation/discovery image
- `about/process-planning.jpg` — planning/prep image
- `about/process-shoot.jpg` — on-shoot image
- `about/process-delivery.jpg` — delivery/results image

**Services — Hero and packages (Services_P1):**
- `services/hero-services.jpg` — services hero background
- `services/package-foundation.jpg` — Brand Foundation card image
- `services/package-elevation.jpg` — Brand Elevation card image
- `services/package-transformation.jpg` — Brand Transformation card image

**Portfolio — Hero and grid (Portfolio_P1 + P2):**
- `portfolio-hero.jpg` — portfolio page hero
- `portfolio-music.jpg`, `portfolio-city.jpg`, `portfolio-portraits.jpg` — category filter tab thumbnails
- `portfolio-1.jpg` through `portfolio-9.jpg` — main grid images
- `gallery-5.jpg` through `gallery-15.jpg` — extended gallery (Portfolio_P2)

**Blog hero:**
- `blog-hero.jpg` — blog page header background

**Contact hero:**
- `contact-hero.jpg` — contact page header background

**Footer logo:**
- `XCP_Logo_White.png` — white version of the XCP logo, transparent background. Upload to Media Library and select in the footer logo widget.

### Image size recommendations

| Slot | Recommended dimensions | Format |
|---|---|---|
| Hero backgrounds (full bleed) | 1920 x 1080px minimum | JPG, compress to under 300KB |
| Gallery grid images | 1200 x 800px | JPG, compress to under 150KB |
| Parallax background | 1920 x 1200px | JPG, compress to under 400KB |
| Partner logos | 320 x 120px (2x for retina) | PNG with transparent background |
| Process step images | 800 x 600px | JPG, compress to under 100KB |
| Logo (footer) | 300 x 80px (2x for retina) | PNG with transparent background |

---

## Part 8: External Services to Configure

These are referenced in the templates and need to be set up separately.

### 8.1 Contact Form — Email Notifications

The Elementor form in `Contact_P2_Form_Overture` or `Contact_P2_Form_Fallback` sends
email via Elementor's built-in form handler.

1. Open the Contact page in Elementor
2. Click the form widget > Edit
3. Go to "Actions After Submit" > Email
4. Set "To" field: `hello@xcphotography.co.uk`
5. Set subject line: `New Enquiry from xcphotography.co.uk`

For reliable email delivery, install **WP Mail SMTP** and connect it to a transactional
email service (Brevo/Sendinblue free tier works well).

### 8.2 Booking — Calendly

The Booking page references `https://calendly.com/xcphotographyuk/discovery-call`.

1. Create a Calendly account at calendly.com
2. Create an event type: "Discovery Call" — 20 minutes
3. Update the Calendly URL in the Booking page widget to match your actual Calendly link
4. Or replace the Calendly embed with an Elementor form if you prefer to keep everything on-site

### 8.3 WooCommerce Shop (for session bookings)

The Buy Now buttons in Services and Booking pages point to:
- `/shop/brand-foundation`
- `/shop/brand-elevation`
- `/shop/brand-transformation`

Create these as WooCommerce Simple Products (not physical — set to Virtual and
Downloadable if no physical product is involved, or leave as Simple with manual
fulfilment). Stripe is the recommended payment gateway (no PayPal required).

### 8.4 Social Links in Footer

The footer links to:
- Instagram: `https://www.instagram.com/xcphotographyuk`
- LinkedIn: `https://www.linkedin.com/in/xcphotographyuk`
- Facebook: `https://www.facebook.com/xcphotographyuk`

Verify these handles are correct before publishing. Update in:
Footer > Edit in Elementor > Social Icons widget.

### 8.5 Phone Number Placeholder

The contact page contains `tel:+441234567890` — this is a placeholder.
Replace with the actual number in:
- `XCP_Contact_P1_Complete.json` or the contact page in Elementor
- `XCP_Footer.json` or the footer in Elementor

---

## Part 9: Colour Palette (Reference)

These are the exact colour values used throughout every template.

| Role | Hex | Where used |
|---|---|---|
| Background | `#000000` | All section backgrounds |
| Heading text | `#FFFFFF` | All headings |
| Body text | `#333333` | Paragraphs, standard text |
| Muted text | `#888888` | Captions, labels, meta |
| Very muted | `#CCCCCC` | Footer text, secondary info |
| Light section bg | `#F8F8F8` | Occasional light-background sections |
| **Accent — platinum** | `#E8E4DC` | Nav hover, CTA borders, credential labels, accent text |
| **Gold — Hotel du Vin only** | `#d4af37` | Gallery Exhibition credential block in About P1 ONLY |

**Accessibility:** Platinum `#E8E4DC` on black `#000000` = 16.3:1 contrast ratio (WCAG AAA).
White `#FFFFFF` on black `#000000` = 21:1 (WCAG AAA).
Neither value requires modification for compliance.

---

## Part 10: Post-Import Checklist

Work through this after all templates are imported.

### Content
- [ ] Replace every `[uc_local]` image placeholder with a real image from your library
- [ ] Replace phone number `+441234567890` with your actual number (contact page + footer)
- [ ] Confirm Calendly link is correct in Booking page
- [ ] Confirm email address is correct in all contact forms (`hello@xcphotography.co.uk`)
- [ ] Check all social links in footer (Instagram, LinkedIn, Facebook)
- [ ] Upload `XCP_Logo_White.png` to Media Library and assign to footer logo widget

### WooCommerce
- [ ] Create Brand Foundation product (`/shop/brand-foundation`) — £1,495
- [ ] Create Brand Elevation product (`/shop/brand-elevation`) — £2,500
- [ ] Create Brand Transformation product (`/shop/brand-transformation`) — £4,500
- [ ] Connect Stripe as payment gateway (WooCommerce > Settings > Payments)
- [ ] Disable PayPal (leave unconfigured)
- [ ] Set shop currency to GBP (WooCommerce > Settings > General)

### SEO
- [ ] Set homepage SEO title: `Brand and Documentary Photographer Brighton | XC Photography`
- [ ] Set homepage meta description: `Brand and documentary photography in Brighton. XC Photography works with businesses, brands, and creative agencies across the UK. A decade of active visual work.`
- [ ] Set page titles and meta descriptions for each page using Yoast or Rank Math
- [ ] Submit sitemap to Google Search Console (`yourdomain.co.uk/sitemap.xml`)

### Performance
- [ ] Enable caching plugin (WP Rocket or LiteSpeed Cache)
- [ ] Enable image compression (Smush or ShortPixel)
- [ ] Check Google PageSpeed score on homepage — target 85+ on mobile

### Permalinks
- [ ] Settings > Permalinks > Post name (must be set or all links break)

### Final checks
- [ ] View every page on mobile — confirm no layout breaks
- [ ] Click every nav link — confirm all pages load
- [ ] Submit a test contact form — confirm email arrives
- [ ] Test the Calendly booking link
- [ ] Test WooCommerce checkout with a test product (use Stripe test mode)

---

## Part 11: Page-by-Page URL Structure

These are the URLs the internal links are built around. Set them up as shown.

```
xcphotography.co.uk/              → Home
xcphotography.co.uk/about         → About
xcphotography.co.uk/services      → Services
xcphotography.co.uk/portfolio     → Portfolio
xcphotography.co.uk/stories       → Blog
xcphotography.co.uk/contact       → Contact
xcphotography.co.uk/book          → Booking
xcphotography.co.uk/privacy-policy
xcphotography.co.uk/terms-and-conditions
xcphotography.co.uk/cookie-policy
xcphotography.co.uk/shop/brand-foundation
xcphotography.co.uk/shop/brand-elevation
xcphotography.co.uk/shop/brand-transformation
```

Blog category URLs (auto-generated by WordPress when posts are published):
```
xcphotography.co.uk/stories/category/brand-photography
xcphotography.co.uk/stories/category/behind-the-scenes
xcphotography.co.uk/stories/category/client-stories
xcphotography.co.uk/stories/category/gear-guides
xcphotography.co.uk/stories/category/music-nightlife
xcphotography.co.uk/stories/category/photography-tips
```

Create these categories in Posts > Categories before publishing blog posts.

---

## Part 12: Template File Reference (All Files)

| File | Import destination | Notes |
|---|---|---|
| `XCP_Header_Navigation.json` | Theme Builder > Header | Global — applies to all pages |
| `XCP_Footer.json` | Theme Builder > Footer | Global — applies to all pages |
| `XCP_HomeP1_Hero_Gallery_FINAL.json` | Home page — section 1 | |
| `XCP_HomeP2_Parallax_Text_FINAL.json` | Home page — section 2 | |
| `XCP_HomeP3_Checkerboard_FINAL.json` | Home page — section 3 | |
| `XCP_HomeP4_Stats_Process_FINAL.json` | Home page — section 4 | |
| `XCP_HomeP5_Testimonials_CTA_FINAL.json` | Home page — section 5 | |
| `XCP_About_P1_Hero_Story.json` | About page — section 1 | |
| `XCP_About_P2_Process_CTA.json` | About page — section 2 | |
| `XCP_Services_P1_Packages.json` | Services page — section 1 | |
| `XCP_Portfolio_P1_Hero_Filter.json` | Portfolio page — section 1 | |
| `XCP_Portfolio_P2_Gallery_CTA.json` | Portfolio page — section 2 | |
| `XCP_Blog_P1_Grid_CTA.json` | Stories page — section 1 | |
| `XCP_Contact_P1_Hero.json` | Contact page — section 1 | |
| `XCP_Contact_P2_Form_Overture.json` | Contact page — section 2 | Use this OR Fallback, not both |
| `XCP_Contact_P2_Form_Fallback.json` | Contact page — section 2 | Backup version |
| `XCP_Contact_P1_Complete.json` | Contact page — all-in-one | Alternative to the three-section approach |
| `XCP_Contact_P4_CTA.json` | Contact page — section 3 | |
| `XCP_Booking_Page.json` | Book a Call page | |

**Not needed for the live site (reference/draft files):**
- `elementor-complete-homepage.json` — early draft, superseded by the P1-P5 FINAL files
- `elementor-example-from-chat.json` — example reference only
- `elementor-homepage-template.json` — early draft, superseded
- `XCP_HomeP2_Parallax_Masonry.json` — alternative layout option
- `XCP_HomeP3_Text_Checkerboard.json` — earlier draft of HomeP3
- `XCP_HomeP4_Stats_Process_Video.json` — video variant of HomeP4
- `XCP_HomeP5_Testimonials_Partners.json` — earlier draft of HomeP5
- `header.json` — early draft of header, superseded by `XCP_Header_Navigation.json`
- `XCP_ContactForm_Section.json` — standalone form section reference
- `XCP_Contact_P2_Form_Overture.json` and `XCP_Contact_P2_Form_Fallback.json` are the same form, different delivery method — pick one

---

## Quick-Start Summary (Minimum Viable Build)

If you want the site live as fast as possible, do this in order:

1. Install WordPress + Hello Elementor theme
2. Install and activate: Elementor, Elementor Pro, WooCommerce
3. Create all pages with correct slugs (Part 3)
4. Import Header and Footer via Theme Builder (Part 4)
5. Import page sections in order (Part 5)
6. Upload your images and swap placeholders (Part 7)
7. Set up Elementor form email notification (Part 8.1)
8. Set phone number and email address across site
9. Run the post-import checklist (Part 10)
10. Set permalink structure to Post Name
11. Publish

Everything else (WooCommerce products, Calendly, SEO, caching) can be layered in
after the site is live without breaking anything.
