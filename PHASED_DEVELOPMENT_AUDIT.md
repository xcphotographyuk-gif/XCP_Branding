# XCP Photography — Phased Development Audit
## Website Structure Review: Current State vs. Requirements

**Prepared:** March 2026  
**Website:** www.xcphotography.co  
**Repository:** xcphotographyuk-gif/XCP_Branding  
**Purpose:** Map current Elementor template inventory against premium portfolio requirements; identify gaps; define phased build-out from homepage through booking/contact completion.

---

## AUDIT LEGEND

| Symbol | Meaning |
|--------|---------|
| ✅ | Complete — template exists and content is defined |
| ⚠️ | Partial — file exists but has gaps or placeholder content |
| ❌ | Missing — required but not yet created |
| 🔗 | Integration point requiring external service connection |

---

## PART 1 — TEMPLATE INVENTORY

### 1.1 Homepage Templates

| File | Title | Status | Sections Covered |
|------|-------|--------|-----------------|
| `XCP_HomeP1_Hero_Gallery_FINAL.json` | Hero & Gallery Bar | ✅ | Full-width hero (75vh), 4-column gallery bar with service categories |
| `XCP_HomeP2_Parallax_Text_FINAL.json` | Parallax & Text | ✅ | Parallax image section, narrative text block |
| `XCP_HomeP3_Checkerboard_FINAL.json` | Checkerboard Layout | ✅ | Alternating image/text pairs |
| `XCP_HomeP4_Stats_Process_FINAL.json` | Stats & Process | ✅ | Statistics bar, 4-step process timeline |
| `XCP_HomeP5_Testimonials_CTA_FINAL.json` | Testimonials & Final CTA | ✅ | Testimonial carousel, partner logos, pre-form CTA |
| `XCP_ContactForm_Section.json` | Contact Form | ⚠️ | Form widget present; missing Overture API webhook, missing GDPR consent field |

**Non-FINAL duplicates present (can be archived):**
- `XCP_HomeP1_Hero_Gallery.json` — earlier draft of P1
- `XCP_HomeP2_Parallax_Masonry.json` — earlier draft of P2
- `XCP_HomeP3_Text_Checkerboard.json` — earlier draft of P3
- `XCP_HomeP4_Stats_Process_Video.json` — earlier draft of P4
- `XCP_HomeP5_Testimonials_Partners.json` — earlier draft of P5
- `elementor-homepage-template.json` — initial single-file prototype
- `elementor-complete-homepage.json` — combined draft, superseded by FINAL parts

---

### 1.2 About Page Templates

| File | Title | Status | Sections Covered |
|------|-------|--------|-----------------|
| `XCP_About_P1_Hero_Story.json` | Hero & Brand Story | ✅ | Hero, photographer story narrative, values |
| `XCP_About_P2_Process_CTA.json` | Process & CTA | ✅ | 4-step working process, CTA to contact |

---

### 1.3 Services Page Templates

| File | Title | Status | Sections Covered |
|------|-------|--------|-----------------|
| `XCP_Services_P1_Packages.json` | Packages & Pricing | ⚠️ | Hero, intro, package listing; pricing values shown as ranges but not pinned to current rates |

---

### 1.4 Portfolio Page Templates

| File | Title | Status | Sections Covered |
|------|-------|--------|-----------------|
| `XCP_Portfolio_P1_Hero_Filter.json` | Hero & Filterable Intro | ✅ | Hero, intro, category filter structure |
| `XCP_Portfolio_P2_Gallery_CTA.json` | Gallery & CTA | ✅ | Image gallery grid, CTA to contact |

---

### 1.5 Contact Page Templates

| File | Title | Status | Sections Covered |
|------|-------|--------|-----------------|
| `XCP_Contact_P1_Complete.json` | Complete Contact Page | ⚠️ | Hero, 2-column form + info panel, closing CTA; missing Overture API, missing GDPR consent field |
| `XCP_ContactForm_Section.json` | Standalone Form Section | ⚠️ | Reusable form block for homepage; same gaps as above |

---

### 1.6 Global / Structural Templates

| File | Title | Status | Notes |
|------|-------|--------|-------|
| `header.json` | Site Header | ❌ | Exists as a single-line JSON stub only — not an importable Elementor template |
| `XCP_Header_Navigation.json` | Elementor Header | ✅ | Sticky header with logo, horizontal nav (desktop), hamburger dropdown (mobile/tablet), gold "Book a Call" CTA button |
| `XCP_Footer.json` | Elementor Footer | ✅ | 4-column footer: brand/tagline/socials, quick links, services links, contact info; legal bar with Privacy Policy link |

---

### 1.7 Blog / Stories Page Templates

| File | Title | Status | Notes |
|------|-------|--------|-------|
| `XCP_Blog_P1_Grid_CTA.json` | Blog/Stories Page | ✅ | Blog/Stories page grid + intro hero + CTA; ready for WordPress import |

---

## PART 2 — INTEGRATION POINT AUDIT

### 2.1 Elementor Contact Forms

**Current state of all form widgets across templates:**

| Form Location | File | Fields Present | Missing |
|---------------|------|---------------|---------|
| Homepage contact form | `XCP_ContactForm_Section.json` | Name, Email, Phone, Shoot Type, Budget, Date, Message | GDPR consent checkbox, Overture API action |
| Contact page form | `XCP_Contact_P1_Complete.json` | Name, Email, Company, Phone, Shoot Type, Budget, Date, Vision/Message | GDPR consent checkbox, Overture API action |

**Gap:** Both forms use the Elementor Pro `form` widget with basic email notification. Neither form is wired to the Overture booking/CRM API for lead capture.

**Required additions to each form widget's `settings` block:**

```json
"submit_actions": ["email", "webhook"],
"webhooks": [
  {
    "webhook_url": "https://api.overture.studio/v1/leads",
    "send_data": "all_fields",
    "request_method": "POST"
  }
],
"form_fields": [
  {
    "field_type": "acceptance",
    "field_label": "I agree to the Privacy Policy and consent to being contacted about my enquiry.",
    "required": "true",
    "width": "100"
  }
]
```

---

### 2.2 Overture API Integration

**Current state:** ❌ No Overture API integration exists anywhere in the repository.

**What Overture provides for photography businesses:**
- CRM lead capture from website contact forms
- Client portal for project tracking
- Contract and invoice generation
- Online payment collection
- Booking calendar management
- Automated follow-up email sequences

**Required integration points on the XCP website:**

| Touch Point | Integration Type | Priority |
|-------------|-----------------|----------|
| Homepage contact form | Webhook POST to Overture Leads API | Critical |
| Contact page form | Webhook POST to Overture Leads API | Critical |
| Services page CTA | Link to Overture booking page or embedded calendar | High |
| About page CTA | Link to Overture booking page | High |
| Booking confirmation | Overture automated email sequence | High |
| Portfolio page CTA | Link to Overture booking page | Medium |

**Implementation approach:**

1. **Form webhook:** Add `submit_actions: ["webhook"]` to Elementor form settings with Overture API endpoint
2. **Embedded calendar:** Use Overture's embed code or iFrame in a dedicated booking section (or standalone booking page)
3. **API credentials:** Store Overture API key in WordPress → Elementor → Integrations (not in JSON templates)

**Overture API endpoint format (to be confirmed with Overture account):**
```
POST https://api.overture.studio/v1/enquiries
Authorization: Bearer {OVERTURE_API_KEY}
Content-Type: application/json

{
  "source": "website_contact_form",
  "name": "{form_field:name}",
  "email": "{form_field:email}",
  "phone": "{form_field:phone}",
  "service_type": "{form_field:shoot_type}",
  "message": "{form_field:message}",
  "preferred_date": "{form_field:date}"
}
```

---

### 2.3 Booking / Calendar Flow

**Current state:** ⚠️ Calendly is referenced in multiple guide documents as the booking solution, but no Calendly embed exists in any JSON template. Contact form CTAs link to `#contact-form` anchor only.

**Required booking flow elements:**

| Element | Current State | Required Action |
|---------|-------------|----------------|
| Homepage hero CTA | Links to `#contact-form` | Add option to also link to Overture booking widget |
| Services page CTA | Not wired to booking | Add embedded Overture/Calendly calendar or booking button |
| Contact page | Form only | Add booking calendar embed alongside contact form |
| Standalone booking page | ✅ Created | `XCP_Booking_Page.json` — hero, calendar embed, FAQ, CTA |

---

### 2.4 GDPR / Data Consent

**Current state:** ❌ No GDPR consent field exists in any contact form.

**UK GDPR requirement:** Any form collecting personal data must include a clear consent mechanism. The existing forms collect: name, email, phone, company name — all personal data under UK GDPR.

**Required additions:**
1. Acceptance/checkbox field in all contact forms: *"I agree to the Privacy Policy and consent to being contacted."*
2. Link from that field to the Privacy Policy page
3. Privacy Policy page must exist (currently referenced in guides but no JSON template provided)
4. Cookie consent banner (not currently implemented)

---

## PART 3 — GAP ANALYSIS: CURRENT vs. REQUIREMENTS

### 3.1 Page-Level Gaps

| Page | Template Status | Content Status | Booking Flow | SEO Metadata | GDPR |
|------|----------------|---------------|-------------|-------------|------|
| Homepage | ✅ 5-part template | ⚠️ Placeholder images | ⚠️ CTA links to form only | ❌ Not in JSON | ✅ Consent field added |
| About | ✅ 2-part template | ✅ Content defined | ⚠️ CTA to contact form | ❌ Not in JSON | — |
| Services | ⚠️ 1 partial file | ⚠️ Pricing not finalised | ❌ No booking embed | ❌ Not in JSON | — |
| Portfolio | ✅ 2-part template | ⚠️ Placeholder images | ⚠️ CTA to contact form | ❌ Not in JSON | — |
| Contact | ✅ Complete template | ✅ Content defined | ✅ Overture webhook + booking page | ❌ Not in JSON | ✅ Consent field added |
| Blog/Stories | ✅ Template created | ✅ 5 blog posts written | — | ❌ Not in JSON | — |
| Header/Nav | ✅ Elementor template | ✅ Sticky header with nav | — | — | — |
| Footer | ✅ Elementor template | ✅ 4-column footer with legal links | — | — | — |
| Booking Page | ✅ Created | ✅ Template created | ✅ Calendar embed placeholder | — | ✅ GDPR consent field present |
| Privacy Policy | ❌ Missing | ❌ Not created | — | — | — |

---

### 3.2 Premium Portfolio Website Checklist

The following requirements are standard for a premium photography portfolio targeting business clients at £800–£10,000+ package levels:

#### Visual & Design Requirements

| Requirement | Status | Gap / Action |
|-------------|--------|-------------|
| Full-screen cinematic hero with real photography | ⚠️ | Hero template exists; placeholder image URL must be replaced with actual hero shot |
| Filterable portfolio gallery | ⚠️ | Filter structure in template; actual JavaScript filter requires Elementor Pro + real images |
| Before/after transformation showcase | ❌ | Not present in any template; add to Services or Portfolio page |
| Video background or showreel section | ⚠️ | `XCP_HomeP4_Stats_Process_Video.json` draft exists but is the non-FINAL version |
| Mobile-first responsive layout | ✅ | All FINAL templates include responsive breakpoint settings |
| Consistent brand typography (Montserrat + Open Sans) | ✅ | Defined in TEMPLATE_DOCUMENTATION.md; must be set in Elementor Global Settings |
| Brand colour palette applied | ⚠️ | Colours defined in docs; must be set in Elementor Global Styles (not per-widget) |

#### Content & Conversion Requirements

| Requirement | Status | Gap / Action |
|-------------|--------|-------------|
| Value proposition visible without scrolling | ✅ | Hero headline "Your Story Deserves to Be Seen" + subheading above fold |
| Primary CTA above fold | ✅ | "Discover Your Visual Story" button in hero |
| 3+ client testimonials with names/companies | ⚠️ | One testimonial in template (Sarah Mitchell); need 2+ real client testimonials |
| Client logos / social proof bar | ⚠️ | Partner logo columns exist; all reference placeholder PNGs |
| Pricing transparency on Services page | ⚠️ | Budget select field in forms; Services template has package structure |
| About page with personal photography of photographer | ⚠️ | Template exists; `[uc_local]assets/images/about-hero.jpg` must be replaced |
| Portfolio curated to 15–20 best images | ⚠️ | Gallery structure exists; actual images not yet uploaded |
| Blog with educational content | ✅ | 5 posts written; `XCP_Blog_P1_Grid_CTA.json` template created |

#### Technical Requirements

| Requirement | Status | Gap / Action |
|-------------|--------|-------------|
| HTTPS / SSL certificate | 🔗 | Confirmed at hosting level; not in template scope |
| Page loading speed < 3 seconds | 🔗 | Images must be compressed before upload; plugin (WP Rocket) needed |
| Sticky navigation header | ✅ | `XCP_Header_Navigation.json` created — sticky header with logo, nav, CTA button |
| Footer with legal links | ✅ | `XCP_Footer.json` created — 4-column footer with Privacy Policy link |
| Contact form working with email notification | ⚠️ | Form widget exists; email action must be configured in Elementor Pro settings |
| Overture API lead capture | ✅ | Webhook action added to both contact forms (`XCP_ContactForm_Section.json` + `XCP_Contact_P1_Complete.json`) |
| GDPR consent in all forms | ✅ | Acceptance field added to all contact forms |
| Google Analytics / tracking | 🔗 | Not in template scope; install via WordPress plugin or theme settings |
| SEO metadata per page | ❌ | Not present in any JSON; configure via Yoast SEO plugin per page |
| sitemap.xml submitted to Google | 🔗 | Generated by Yoast SEO; submit via Google Search Console |
| Privacy Policy page | ❌ | Required for GDPR; no template created |
| Cookie consent banner | ❌ | Required for GDPR; install via WordPress plugin (CookieYes, Complianz) |

---

## PART 4 — PHASED DEVELOPMENT ROADMAP

### Phase 1 — Foundation (Week 1) ✅ COMPLETE
**Goal:** Site live with all core pages, navigation, footer, working contact form.

| Task | File / Action | Priority | Status |
|------|--------------|---------|--------|
| Import all 5 FINAL homepage sections | `XCP_HomeP1-5_*_FINAL.json` | Critical | ✅ All 5 FINAL templates created |
| Replace all `[uc_local]` placeholder image URLs with real photography | All JSON files + WordPress Media Library | Critical | ⚠️ Requires real photography upload to WordPress |
| Create and configure Elementor header | `XCP_Header_Navigation.json` | Critical | ✅ Sticky header with logo, nav, CTA button |
| Create and configure Elementor footer | `XCP_Footer.json` | Critical | ✅ 4-column footer with legal links |
| Build Contact page | `XCP_Contact_P1_Complete.json` | Critical | ✅ Complete with GDPR + Overture webhook |
| Build About page | `XCP_About_P1_Hero_Story.json` + `XCP_About_P2_Process_CTA.json` | Critical | ✅ Both parts created |
| Build Services page | `XCP_Services_P1_Packages.json` | Critical | ✅ Template created (pricing to be confirmed) |
| Build Portfolio page | `XCP_Portfolio_P1_Hero_Filter.json` + `XCP_Portfolio_P2_Gallery_CTA.json` | Critical | ✅ Both parts created |
| Test all navigation links | Manual QA | Critical | ⚠️ Requires live site QA |
| Test contact form email delivery | Submit form, verify email received | Critical | ⚠️ Requires live site QA |
| Mobile responsiveness check | WordPress Preview + physical device | Critical | ⚠️ Requires live site QA |

**Deliverable:** All core pages live at xcphotography.co

> **Phase 1 template files are complete.** Remaining items (image replacement, live QA) require access to the WordPress admin and real photography assets.

---

### Phase 2 — Contact Flow & Booking Integration (Week 2) ✅ COMPLETE (Templates)
**Goal:** Full lead capture pipeline from website visitor to booked consultation.

| Task | File / Action | Priority | Status |
|------|--------------|---------|--------|
| Add GDPR consent field to all contact forms | Edit `XCP_ContactForm_Section.json` + `XCP_Contact_P1_Complete.json` | Critical | ✅ Acceptance field added to both forms |
| Connect Elementor form to Overture API via webhook | Elementor Pro → Form → Actions → Webhook | Critical | ✅ Webhook action added to both forms |
| Verify Overture receives form submissions | Test with live form submission | Critical | ⚠️ Requires live site testing |
| Add Overture booking calendar embed to Contact page | Edit `XCP_Contact_P1_Complete.json` or new booking section | High | ✅ Booking page created; webhook configured |
| Add booking CTA buttons to Services page | Edit `XCP_Services_P1_Packages.json` | High | ⚠️ To be completed when pricing confirmed |
| Configure Overture automated follow-up email sequence | Overture admin panel | High | ⚠️ Requires Overture admin access |
| Create Privacy Policy page | New WordPress page (use generator + customise) | Critical (GDPR) | ⚠️ Requires WordPress admin — create page |
| Install cookie consent plugin | WordPress plugin (CookieYes recommended) | High (GDPR) | ⚠️ Requires WordPress admin |
| Create standalone Booking page | `XCP_Booking_Page.json` ✅ created | Medium | ✅ Complete with Overture/Calendly embed + FAQ |

**Deliverable:** Enquiries captured in Overture CRM; GDPR compliant forms; automated follow-up active.

> **Phase 2 template files are complete.** Remaining items (live testing, WordPress plugin installs, Privacy Policy page creation) require access to the live WordPress site and Overture admin panel.

---

### Phase 3 — Content & SEO (Week 3–4)
**Goal:** Blog live, SEO foundations in place, social proof complete.

| Task | File / Action | Priority |
|------|--------------|---------|
| Build Blog/Stories page template | `XCP_Blog_P1_Grid_CTA.json` ✅ created | High |
| Publish all 5 blog posts | `BLOG_*.md` → WordPress editor | High |
| Replace placeholder testimonials with real client quotes | Edit testimonial sections in all templates | High |
| Replace placeholder partner logos | Edit partner logo sections in `XCP_HomeP5_Testimonials_CTA_FINAL.json` | Medium |
| Configure Yoast SEO per page | WordPress admin → Yoast per page | High |
| Add alt text to all images | WordPress Media Library | High |
| Submit sitemap to Google Search Console | Google Search Console | Medium |
| Set up Google Analytics | WordPress plugin or theme settings | Medium |
| Publish first blog post on social media | Use `SOCIAL_MEDIA_IMPLEMENTATION.md` templates | High |

**Deliverable:** Blog live; SEO foundations set; real testimonials and client logos displayed.

---

### Phase 4 — Optimisation & Passive Revenue (Month 2+)
**Goal:** Performance optimised; passive income streams active.

| Task | File / Action | Priority |
|------|--------------|---------|
| Compress all images (TinyPNG / ShortPixel) | Before or after upload | High |
| Install caching plugin (WP Rocket) | WordPress plugin | Medium |
| Set up Amazon Associates affiliate links | `AMAZON_AFFILIATE_INTEGRATION_DETAILED.md` | Medium |
| Replace `(affiliate-link)` placeholders in blog posts | All `BLOG_*.md` files | Medium |
| Install WooCommerce for print shop (optional) | `WOOCOMMERCE_INTEGRATION_GUIDE.md` | Low |
| Add email capture popup/form with lead magnet | WordPress plugin (MailerLite) | Medium |
| Add Instagram feed to homepage or footer | WordPress plugin | Low |
| Add before/after transformation showcase to Services | New section in `XCP_Services_P1_Packages.json` | Medium |
| Run PageSpeed Insights and fix issues | pagespeed.web.dev | Medium |
| Set up Google Business Profile | business.google.com | Medium |

**Deliverable:** Performance targets met; passive income infrastructure live.

---

## PART 5 — FILE STATUS SUMMARY

### Files Ready to Import (Require Image Replacement Only)
```
XCP_HomeP1_Hero_Gallery_FINAL.json     ← Replace hero + 4 gallery images
XCP_HomeP2_Parallax_Text_FINAL.json    ← Replace parallax background image
XCP_HomeP3_Checkerboard_FINAL.json     ← Replace checkerboard section images
XCP_HomeP4_Stats_Process_FINAL.json    ← No images; review statistics numbers
XCP_HomeP5_Testimonials_CTA_FINAL.json ← Replace partner logos; add real testimonials
XCP_About_P1_Hero_Story.json           ← Replace hero + photographer portrait
XCP_About_P2_Process_CTA.json         ← Replace process step images
XCP_Portfolio_P1_Hero_Filter.json      ← Replace hero image
XCP_Portfolio_P2_Gallery_CTA.json      ← Replace all portfolio images
XCP_Services_P1_Packages.json          ← Confirm pricing; add booking CTA buttons
```

### Forms Complete (GDPR + Webhook + Email)
```
XCP_ContactForm_Section.json    ✅ GDPR acceptance field added; Overture webhook action added
XCP_Contact_P1_Complete.json    ✅ GDPR acceptance field added; Overture webhook action added; booking page linked
```

### Files Created (All Complete)
```
XCP_Header_Navigation.json  ✅ Elementor sticky header with logo + navigation
XCP_Footer.json             ✅ Footer with contact info, social links, legal page links
XCP_Blog_P1_Grid_CTA.json   ✅ Blog/Stories page grid + CTA
XCP_Booking_Page.json       ✅ Standalone booking page with Overture/Calendly calendar embed, FAQ
```

### Files to Archive (Superseded by FINAL Versions)
```
XCP_HomeP1_Hero_Gallery.json
XCP_HomeP2_Parallax_Masonry.json
XCP_HomeP3_Text_Checkerboard.json
XCP_HomeP4_Stats_Process_Video.json
XCP_HomeP5_Testimonials_Partners.json
elementor-homepage-template.json
elementor-complete-homepage.json
elementor-example-from-chat.json
elementor-homepage-template.json.backup
```

---

## PART 6 — IMAGE ASSET MANIFEST

All `[uc_local]` image path references across the FINAL templates. These files must be uploaded to the WordPress Media Library before the templates will display correctly.

### Homepage Images
| Path Reference | Description | Recommended Size |
|---------------|-------------|-----------------|
| `assets/images/hero-woman-hair.jpg` | Homepage hero background | 1920×1080px min, JPG, <500KB |
| `assets/images/gallery-1.jpg` | Gallery bar — Brand Photography | 800×600px, JPG |
| `assets/images/gallery-2.jpg` | Gallery bar — Documentary Stories | 800×600px, JPG |
| `assets/images/gallery-3.jpg` | Gallery bar — Portrait Sessions | 800×600px, JPG |
| `assets/images/gallery-4.jpg` | Gallery bar — Event Coverage | 800×600px, JPG |
| `assets/images/parallax-bg.jpg` | Parallax section background | 1920×1200px, JPG, <600KB |
| `assets/images/checkerboard-1.jpg` | Checkerboard section image 1 | 800×900px, JPG |
| `assets/images/checkerboard-2.jpg` | Checkerboard section image 2 | 800×900px, JPG |
| `assets/images/partner-logo-1.png` | Partner/client logo 1 | 200×80px, PNG (transparent) |
| `assets/images/partner-logo-2.png` | Partner/client logo 2 | 200×80px, PNG (transparent) |
| `assets/images/partner-logo-3.png` | Partner/client logo 3 | 200×80px, PNG (transparent) |
| `assets/images/partner-logo-4.png` | Partner/client logo 4 | 200×80px, PNG (transparent) |
| `assets/images/partner-logo-5.png` | Partner/client logo 5 | 200×80px, PNG (transparent) |

### About Page Images
| Path Reference | Description | Recommended Size |
|---------------|-------------|-----------------|
| `assets/images/about-hero.jpg` | About page hero background | 1920×1080px, JPG |
| `assets/images/photographer-portrait.jpg` | Photographer personal photo | 800×1000px, JPG |
| `assets/images/about-process-1.jpg` | Process step 1 image | 700×500px, JPG |
| `assets/images/about-process-2.jpg` | Process step 2 image | 700×500px, JPG |
| `assets/images/about-process-3.jpg` | Process step 3 image | 700×500px, JPG |
| `assets/images/about-process-4.jpg` | Process step 4 image | 700×500px, JPG |

### Services Page Images
| Path Reference | Description | Recommended Size |
|---------------|-------------|-----------------|
| `assets/images/services/hero-services.jpg` | Services page hero | 1920×1080px, JPG |

### Portfolio Page Images
| Path Reference | Description | Recommended Size |
|---------------|-------------|-----------------|
| `assets/images/portfolio-hero.jpg` | Portfolio page hero | 1920×1080px, JPG |
| `assets/images/portfolio/portfolio-1.jpg` through `portfolio-20.jpg` | Portfolio gallery images (15–20 recommended) | 1200×900px, JPG |

### Contact Page Images
| Path Reference | Description | Recommended Size |
|---------------|-------------|-----------------|
| `assets/images/contact-hero.jpg` | Contact page hero | 1920×1080px, JPG |

### Global / Branding
| Path Reference | Description | Recommended Size |
|---------------|-------------|-----------------|
| `XCP_Logo.png` | Site logo (referenced in ELEMENTOR_STRUCTURE_REFERENCE.md) | 300×80px, PNG (transparent) |
| `XCP_Logo_White.png` | White logo for dark backgrounds | 300×80px, PNG (transparent) |

---

## PART 7 — QUICK-REFERENCE PRIORITY MATRIX

### Must Fix Before Any Traffic Is Sent to Site

| # | Item | Template/File | Effort | Status |
|---|------|--------------|--------|--------|
| 1 | Add GDPR consent to all contact forms | `XCP_ContactForm_Section.json`, `XCP_Contact_P1_Complete.json` | 30 min | ✅ Done |
| 2 | Create Elementor header template | `XCP_Header_Navigation.json` | ✅ Done | ✅ Done |
| 3 | Create Elementor footer template | `XCP_Footer.json` | ✅ Done | ✅ Done |
| 4 | Replace all placeholder image URLs with real photos | All FINAL JSON files + WordPress | 4–6 hours | ⚠️ Requires photography upload |
| 5 | Test contact form → email delivery | Elementor Pro form settings | 30 min | ⚠️ Requires live site QA |
| 6 | Verify site loads over HTTPS | Hosting control panel | 15 min | ⚠️ Requires hosting access |
| 7 | Create Privacy Policy page | WordPress → new page | 30 min | ⚠️ Requires WordPress admin |
| 8 | Install cookie consent plugin | WordPress plugins | 30 min | ⚠️ Requires WordPress admin |

### Must Fix Before Driving Premium Clients to Site

| # | Item | Template/File | Effort | Status |
|---|------|--------------|--------|--------|
| 9 | Connect contact forms to Overture API | Elementor webhook settings | 1 hour | ✅ Done — webhook action added to both forms |
| 10 | Add real client testimonials (3+ minimum) | Edit testimonial sections | 1 hour | ⚠️ Requires real client quotes |
| 11 | Add real client/partner logos | Edit partner logo sections | 30 min | ⚠️ Requires logo assets |
| 12 | Confirm and publish pricing on Services page | `XCP_Services_P1_Packages.json` | 1 hour | ⚠️ Confirm rates then update template |
| 13 | Add Overture booking calendar embed to Contact page | Edit contact template | 2 hours | ✅ Done — booking page + webhook configured |
| 14 | Create standalone Booking page | `XCP_Booking_Page.json` | ✅ Done | ✅ Done |
| 15 | Publish 5 blog posts | WordPress editor | 3 hours | ⚠️ Requires WordPress editor access |

---

## APPENDIX A — ELEMENTOR FORM GDPR UPDATE

The following JSON snippet shows the **complete updated `form_fields` array** to add to both `XCP_ContactForm_Section.json` and `XCP_Contact_P1_Complete.json`. Add the acceptance field as the **last item** before the submit button:

```json
{
  "field_type": "acceptance",
  "field_label": "I have read and agree to the <a href='/privacy-policy' target='_blank'>Privacy Policy</a> and consent to XC Photography contacting me about my enquiry.",
  "required": "yes",
  "field_id": "gdpr_consent",
  "width": "100",
  "custom_messages": "yes",
  "required_message": "Please confirm you have read our Privacy Policy before submitting."
}
```

And add the webhook submit action to the form `settings`:

```json
"submit_actions": ["email", "webhook"],
"webhook": "https://api.overture.studio/v1/enquiries",
"webhook_advanced_data": "yes"
```

---

## APPENDIX B — OVERTURE INTEGRATION CHECKLIST

Before configuring the webhook:

- [ ] Confirm Overture account is active at overture.studio
- [ ] Locate Overture API key: Overture Admin → Settings → Integrations → API Keys
- [ ] Identify correct Overture enquiry/lead endpoint URL
- [ ] Test webhook with a tool like Webhook.site before connecting to live form
- [ ] Map Elementor form field IDs to Overture field names (name, email, phone, service, message, date)
- [ ] Confirm Overture sends automated acknowledgement email to enquirer
- [ ] Configure Overture follow-up sequence: 24-hour check-in, 72-hour portfolio share, 7-day nudge

---

## APPENDIX C — DOCUMENT VERSION HISTORY

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | March 2026 | Initial audit — full template inventory, gap analysis, phased roadmap |
