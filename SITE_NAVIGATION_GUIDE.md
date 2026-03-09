# XCP Photography — Site Navigation & UX Guide

**← [Back to Start](START_HERE.md) | [JSON Import Index](JSON_IMPORT_INDEX.md) | [Site Architecture](SITE_ARCHITECTURE.md)**

---

## ✅ Quick Answer: Can I Copy the Form to Any Page?

**Yes — absolutely.** The enquiry form can be placed on any page.

You have **two strategies**:

| Strategy | How |
|---|---|
| **Import the JSON** | Use `XCP_Home_S6_Contact_Form.json` (fallback) or `XCP_Home_S6_Contact_Form_Overture.json` on any page via Elementor → Import Template |
| **Copy within Elementor** | On any page where the form already exists, right-click the section → **Copy** → open another page → right-click → **Paste** |

The **WPCode Overture snippet fires on all forms** named `XCP Contact: Overture` — it doesn't matter which page it's on. See [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md) for details.

**Three pages already have form JSONs in the repo:**

| Page | Fallback | Overture |
|---|---|---|
| Contact | `XCP_Contact_P2_Form_Fallback.json` | `XCP_Contact_P2_Form_Overture.json` ✅ live |
| Home | `XCP_Home_S6_Contact_Form.json` | `XCP_Home_S6_Contact_Form_Overture.json` |
| Services | `XCP_Services_S3_Transformation_Bespoke.json` | `XCP_Services_S3_Transformation_Bespoke_Overture.json` |

For any other page: copy the section in Elementor or import either home/contact form JSON.

---

## The 3-Click Booking Rule

**Goal: A visitor can initiate a booking call within 3 clicks from any page.**

| Click | Action |
|---|---|
| 1 | Land on any page |
| 2 | See a CTA button / nav link → click "Book a Call" or "Start Your Project" |
| 3 | Land on Contact page or Booking page — form is visible above the fold |

Every page in the XCP template set includes at least one CTA button pointing to `/contact` or `/booking`. The sticky header nav (already in `XCP_Header_Navigation.json`) means the "Book a Call" CTA is always visible as they scroll.

**The rule in practice:**
- Never bury the booking path behind more than 2 navigation steps
- Every blog post, magazine review, shop page, and workshop page ends with a section linking to book a call
- The header CTA button is the always-on escape route

---

## WordPress Menu Setup — Exact Steps

### Step 1: Create the Menu

**WordPress Dashboard → Appearance → Menus → Create a new menu**

- Menu name: `Primary Navigation`
- Display location: ✅ Primary Menu
- Click **Create Menu**

### Step 2: Add Pages in This Order

Add these pages (create the pages first if they don't exist yet):

```
Home
About
Portfolio
Services ▼                ← dropdown parent
  Brand Photography
  Corporate Portraits
  Events
  Documentary
Shop ▼                    ← dropdown parent (WooCommerce shop page)
  Prints & Framed
  Books & Publications
  Gifts & Accessories
Workshops ▼               ← dropdown parent
  In-Person Workshops
  Online Workshops
Magazine ▼                ← dropdown parent (this is your blog/stories page)
  Music & Events
  Brand Stories
  Behind the Lens
[Book a Call]             ← CTA button (custom link to /contact or /booking)
```

### Step 3: Style the "Book a Call" as a Button

The Elementor header template renders the nav menu. To make "Book a Call" visually a button:

1. In WordPress → Menus, add a Custom Link: URL = `/contact`, Label = `Book a Call`
2. In the **CSS Classes** field (enable via Screen Options at top of Menus page), add: `xcp-nav-cta`
3. In WordPress → Appearance → Customize → Additional CSS (or via WPCode), add:
```css
.xcp-nav-cta > a {
  background: var(--e-global-color-accent);
  color: var(--e-global-color-primary-font, #D5D5D5) !important;
  padding: 10px 24px;
  border-radius: 2px;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}
```

### Step 4: Mobile Menu

The `XCP_Header_Navigation.json` includes a hamburger menu for mobile. It shows/hides automatically via Elementor Pro's responsive nav widget. No additional setup needed.

---

## Recommended Nav Order — Why This Works

```
Home | About | Portfolio | Services | Shop | Workshops | Magazine | [Book a Call]
```

**Rationale:**

- **Home → About → Portfolio** — The trust-building path for new visitors
- **Services** — For visitors who know they want photography
- **Shop** — High-intent buyers can find it quickly; it's prominent without being the first thing
- **Workshops** — Separates the education offering from the photography service
- **Magazine** — Brand authority content, SEO driver
- **[Book a Call]** — Always visible, always accessible, ends every journey

> 🎯 **The Golden Rule**: No visitor should need to scroll or hunt to find how to contact you. The CTA button in the top-right of the header solves this on every page.

---

## Audience Journey Maps

Different audiences enter through different doors. Here's how the site caters to each:

### 1. Executive / Brand Client (High-value photography enquiry)

**Entry:** Google search → Services page or direct referral → Home

```
Home ──► Services ──► Contact / Book a Call
  │          │
  └── About ─┘
      (builds trust before they commit)
```

**Key CTAs:** "From £1,495 — Let's Talk" → Contact form

---

### 2. Music Fan / Event-Goer

**Entry:** Instagram → Blog/Magazine → Shop or Photography enquiry

```
Instagram ──► Magazine post ──► Shop (prints/merch)
                    │
                    └──► Contact (if they want event photography)
```

**Key CTAs:** "Buy This Print" → Shop product / "Book Event Coverage" → Contact

---

### 3. Business Owner (Referral or LinkedIn)

**Entry:** LinkedIn → About or Home

```
LinkedIn ──► Home ──► Portfolio ──► Services ──► Book a Call
```

**Key CTAs:** "See the Work" → Portfolio → "Start Your Project" → Contact

---

### 4. Aspiring Photographer / Workshop Seeker

**Entry:** Blog post (gear, technique) → Workshop page

```
Blog ──► Workshops ──► Deposit Booking form
```

**Key CTAs:** "Join the Workshop" → Booking form with deposit

---

### 5. Gift Buyer

**Entry:** Google ("photography prints Brighton gift") → Shop

```
Google ──► Shop category ──► Product ──► WooCommerce checkout
```

**Key CTAs:** "Add to Basket" → WooCommerce

---

## Shop Navigation — Structure

The shop does NOT need to be front-and-centre on the homepage. Instead:

- **Shop is in the nav** — prominent, accessible, but not forced
- **Relevant pages link to it** — blog posts mention prints, workshop pages mention books, etc.
- **No "featured products" widget on the homepage** — the homepage stays focused on photography services

### WooCommerce Shop Structure

```
/shop                          ← Main shop page (WooCommerce default)
  /product-category/prints     ← Fine art prints (framed & unframed)
  /product-category/books      ← Photo books, publications
  /product-category/gifts      ← Mugs, cards, gifts
  /product-category/presets    ← Lightroom presets (digital)
  /product-category/workshops  ← Online workshop access (digital)
```

**Product types:**

| Category | Format | Notes |
|---|---|---|
| Prints | A4, A3, A2, A1 — unframed | WooCommerce variable product |
| Prints | A4, A3, A2 — framed | Same product, different variation |
| Books | Hardback, softback | Fixed product |
| Gifts | Mugs, cards, phone cases | Variable (image choice) |
| Digital | Lightroom presets pack | Downloadable product |
| Digital | Online workshop recording | Downloadable product |
| Workshop deposit | In-person / online | Simple product, variable price |

---

## Page-by-Page CTA Connections

Every page ends with a path to booking or to the shop. Here is the map:

| Page | End CTA | Links To |
|---|---|---|
| Home | "Book a Call" | /contact |
| About | "Let's Create Together" | /contact |
| Portfolio | "Start Your Project" | /contact |
| Services | "Book a Discovery Call" | /contact |
| Brand Photography | "Get a Quote" | /contact |
| Corporate Portraits | "Book a Consultation" | /contact |
| Events | "Discuss Your Event" | /contact |
| Documentary | "Tell Us Your Story" | /contact |
| Blog post | "Book a Call" + "Shop Prints" | /contact + /shop |
| Magazine review | "Get Event Coverage" | /contact |
| Workshop | "Reserve Your Spot" | /contact (with deposit) |
| Shop | Back to photography | /services |
| Contact | — | Confirmation / Thank You |

---

## WordPress Page Slugs — Recommended

Create pages with these exact slugs so they match all CTA link references in the JSON templates:

| Page | Slug |
|---|---|
| Home | `/` |
| About | `/about` |
| Portfolio | `/portfolio` |
| Services | `/services` |
| Brand Photography | `/services/brand-photography` |
| Corporate Portraits | `/services/corporate-portraits` |
| Events | `/services/events` |
| Documentary | `/services/documentary` |
| Shop | `/shop` (WooCommerce creates this automatically) |
| Workshops | `/workshops` |
| Blog/Magazine | `/stories` |
| Contact | `/contact` |
| Booking | `/booking` |
| Thank You | `/thank-you` |
| Privacy Policy | `/privacy-policy` |

---

## Sitemap (Visual)

```
xcphotography.co  (or your registered domain)
│
├── / (Home)
│   └── [CTA → /contact]
│
├── /about
│   └── [CTA → /contact]
│
├── /portfolio
│   └── [CTA → /contact]
│
├── /services
│   ├── /services/brand-photography
│   ├── /services/corporate-portraits
│   ├── /services/events
│   ├── /services/documentary
│   └── [CTA → /contact]
│
├── /shop (WooCommerce)
│   ├── /product-category/prints
│   ├── /product-category/books
│   ├── /product-category/gifts
│   └── /product-category/presets
│
├── /workshops
│   ├── In-Person details (anchor #in-person)
│   ├── Online details (anchor #online)
│   └── [Deposit booking form]
│
├── /stories (Blog + Magazine)
│   ├── /stories/category/brand-photography
│   ├── /stories/category/music-events
│   └── /stories/category/behind-the-lens
│
├── /contact
├── /booking
├── /thank-you
└── /privacy-policy
```

---

## What the Elementor Header Nav JSON Already Does

The `XCP_Header_Navigation.json` template:
- Shows the WordPress **Primary Menu** (whatever you build in Appearance → Menus)
- Sticky on scroll — always visible
- Responsive: collapses to hamburger on mobile/tablet
- Logo top-left, nav centre, CTA button top-right

**You do not need to re-import the header JSON** if you already have it. Just update your WordPress Primary Menu and it will reflect immediately.

---

## Quick Checklist — Navigation Setup

- [ ] Create all pages in WordPress with the recommended slugs above
- [ ] Install WooCommerce and let it create `/shop` automatically
- [ ] Go to Appearance → Menus → Create "Primary Navigation"
- [ ] Add pages in the order: Home, About, Portfolio, Services (with sub-pages), Shop, Workshops, Magazine, Book a Call
- [ ] Enable CSS Classes in Screen Options, add `xcp-nav-cta` to "Book a Call" link
- [ ] Add the button CSS via WPCode or Customizer (code above)
- [ ] Verify the sticky header is working (Elementor → Header & Footer)
- [ ] Test the 3-click rule: from Home → click once → click twice → land on contact form ✅

---

*This guide is part of the XCP Branding repository. For Elementor template imports, see [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md). For WooCommerce product setup, see [WOOCOMMERCE_INTEGRATION_GUIDE.md](WOOCOMMERCE_INTEGRATION_GUIDE.md).*
