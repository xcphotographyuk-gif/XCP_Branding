# XCP Photography — Elementor Import Guide
## Every page. Every section. In order. One file at a time.

**← [Back to Start: README](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/README.md) · [Master Action Plan](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_MASTER_PLAN.md) (this is Step 5)**

Import each file below using **Elementor → folder icon (bottom-left) → Import Template → Insert**.
Work top to bottom within each page. Finish one page before starting the next.

> **Contact form import:** If Elementor returns "invalid file" on the contact form JSON, re-download the file from GitHub (click Raw, then Save As). Do not paste the JSON from chat or add any `_comment` or `custom_headers` fields to the file. The API key is intentionally not in the JSON. Add it after import using the WPCode snippet in [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md).

> **✅ Can I copy the form to any page?** YES. Right-click the form section in Elementor → Copy → open another page → Paste. Or import any of the form JSONs below. The WPCode Overture snippet fires on all forms named `XCP Contact: Overture` regardless of which page they're on. See [SITE_NAVIGATION_GUIDE.md](SITE_NAVIGATION_GUIDE.md) for full details.

> **Repo privacy:** To make this GitHub repository private, go to: **GitHub → your repository → Settings → Danger Zone → Change repository visibility → Make private**. This guide cannot change GitHub repository settings.

> **Dual-version forms:** Every page with an enquiry form now has both a **Fallback** version (email-only, works immediately) and an **Overture** version (connects to your Overture CRM, same field IDs). Import the Fallback version first to go live straight away. When Overture is ready, swap in the Overture version — no disruption, no data loss. Full Overture connection instructions are in [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md).

> **Navigation setup:** Before or after importing templates, set up your WordPress Primary Menu. Full instructions — including the 3-click booking rule, audience journey maps, and WooCommerce shop structure — are in [SITE_NAVIGATION_GUIDE.md](SITE_NAVIGATION_GUIDE.md).

---

## Page order — jump to any section

1. [🏠 Home Page](#-home-page) — 9 files
2. [👤 About Page](#-about-page) — 5 files
3. [🎯 Services Page](#-services-page) — 3 files
4. [🔗 Service Sub-pages](#-service-sub-pages-individual-service-landing-pages) — 4 files (optional, for SEO)
5. [📷 Portfolio Page](#-portfolio-page) — 2 files
6. [📬 Contact Page](#-contact-page) — 4 files
7. [📖 Blog / Stories Page](#-blog--stories-page) — 6 files
8. [✍️ Blog Post Template](#-blog-post-template--individual-post-layout) — 1 file (apply to each post)
9. [🎵 Magazine Review Template](#-magazine-review-template--music--events) — 1 file (apply to each review)
10. [🎓 Workshops Page](#-workshops-page) — 3 files
11. [🛍️ Shop Page](#-shop-page) — 3 files
12. [🖼️ Shop: Individual Print Product Page](#-shop-individual-print-product-page-template) — 1 file (use as template per print)
13. [📅 Booking Page](#-booking-page) — 3 files
14. [✅ Thank You Page](#-thank-you-page) — 1 file
15. [🔒 Privacy Policy Page](#-privacy-policy-page) — 1 file
16. [🌐 Global: Header & Footer](#-global-elements--header--footer)

---

## 🏠 HOME PAGE

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero + Brand Story Concept Boxes | `XCP_Home_S1a_Hero_Concepts.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S1a_Hero_Concepts.json) |
| 2 | 4-Box Gallery Bar | `XCP_Home_S1b_Gallery.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S1b_Gallery.json) |
| 3 | Parallax + Text | `XCP_HomeP2_Parallax_Text_FINAL.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_HomeP2_Parallax_Text_FINAL.json) |
| 4 | Checkerboard (2 panels) | `XCP_HomeP3_Checkerboard_FINAL.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_HomeP3_Checkerboard_FINAL.json) |
| 5 | Stats + Three Pillars | `XCP_Home_S4a_Stats_Pillars.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S4a_Stats_Pillars.json) |
| 6 | Process Timeline | `XCP_Home_S4b_Process.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S4b_Process.json) |
| 7 | Behind the Lens — Statement + Shoot Images | `XCP_Home_S5a_Shoots_Statement.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S5a_Shoots_Statement.json) |
| 8 | Final CTA | `XCP_Home_S5b_CTA.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S5b_CTA.json) |
| 9 | Contact Form — **Fallback** ✅ Use this first | `XCP_Home_S6_Contact_Form.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S6_Contact_Form.json) |
| 9 | Contact Form — **Overture** (swap in when ready) | `XCP_Home_S6_Contact_Form_Overture.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Home_S6_Contact_Form_Overture.json) |

> **Section 9 — two versions:** Import `XCP_Home_S6_Contact_Form.json` (Fallback) first. It sends enquiries directly to info@xcphotography.co.uk by email — no API key needed. When you are ready to connect Overture, delete the fallback section and import `XCP_Home_S6_Contact_Form_Overture.json` instead. The WPCode snippet in [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md) will pick it up automatically — its Form Name is `XCP Contact: Overture`, identical to the Contact page Overture form.

✅ **Home page complete — [→ Next: About Page](#-about-page)**

---

## 👤 ABOUT PAGE

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero | `XCP_About_S1a_Hero.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_About_S1a_Hero.json) |
| 2 | Core Values | `XCP_About_S1b_Values.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_About_S1b_Values.json) |
| 3 | Three Pillars + Credentials | `XCP_About_S2_Pillars_Credentials.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_About_S2_Pillars_Credentials.json) |
| 4 | The Experience + Steps 1 & 2 | `XCP_About_S3_Experience_Steps12.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_About_S3_Experience_Steps12.json) |
| 5 | Steps 3 & 4 + CTA | `XCP_About_S4_Steps34_CTA.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_About_S4_Steps34_CTA.json) |

✅ **About page complete — [→ Next: Services Page](#-services-page)**

---

## 🎯 SERVICES PAGE

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero + Intro | `XCP_Services_S1_Hero_Intro.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Services_S1_Hero_Intro.json) |
| 2 | Brand Foundation + Elevation | `XCP_Services_S2_Foundation_Elevation.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Services_S2_Foundation_Elevation.json) |
| 3 | Transformation + Bespoke Enquiry — **Fallback** ✅ Use this first | `XCP_Services_S3_Transformation_Bespoke.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Services_S3_Transformation_Bespoke.json) |
| 3 | Transformation + Bespoke Enquiry — **Overture** (swap in when ready) | `XCP_Services_S3_Transformation_Bespoke_Overture.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Services_S3_Transformation_Bespoke_Overture.json) |

> **Section 3 — two versions:** Import `XCP_Services_S3_Transformation_Bespoke.json` (Fallback) first. When Overture is connected, swap in `XCP_Services_S3_Transformation_Bespoke_Overture.json`. The WPCode snippet fires automatically — the Overture version Form Name is `XCP Contact: Overture`.

✅ **Services page complete — [→ Next: Portfolio Page](#-portfolio-page)**

---

## 📷 PORTFOLIO PAGE

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero + Filter Bar + Gallery | `XCP_Portfolio_P1_Hero_Filter.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Portfolio_P1_Hero_Filter.json) |
| 2 | Extended Gallery + CTA | `XCP_Portfolio_P2_Gallery_CTA.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Portfolio_P2_Gallery_CTA.json) |

✅ **Portfolio page complete — [→ Next: Contact Page](#-contact-page)**

---

## 📬 CONTACT PAGE

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero | `XCP_Contact_P1_Hero.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Contact_P1_Hero.json) |
| 2 | Contact Form — **Fallback** ✅ Use this first | `XCP_Contact_P2_Form_Fallback.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Contact_P2_Form_Fallback.json) |
| 2 | Contact Form — **Overture** (swap in when ready) | `XCP_Contact_P2_Form_Overture.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Contact_P2_Form_Overture.json) |
| 3 | Why Xavier — Trust & Credibility | `XCP_Contact_P3_Trust.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Contact_P3_Trust.json) |
| 4 | Closing CTA | `XCP_Contact_P4_CTA.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Contact_P4_CTA.json) |

> **Currently active form:** `XCP_Contact_P2_Form_Fallback.json` — sends enquiries directly to **info@xcphotography.co.uk** via WordPress mail. No API key or external service needed. Import this now and your contact page is live immediately.
>
> **Upgrading to Overture later:** Once the Overture API connection is confirmed working, replace section 2 with `XCP_Contact_P2_Form_Overture.json`. All field IDs are identical — no disruption to live forms. Full setup steps are in [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md).
>
> **Section 3 image placeholder:** `XCP_Contact_P3_Trust.json` references `assets/images/contact-statement.jpg`. This is a full-width background image for the statement section. Replace via Elementor: click the section, go to Style → Background, and upload your chosen image from the media library. See [HOW_TO_ADD_IMAGES.md](HOW_TO_ADD_IMAGES.md) for the full workflow.

---

### 🔑 Switching to Overture — 3 steps when you're ready

> **Full guide: [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md)**

**Step 1:** On each page that has a fallback form (Contact page, Home page, Services page), open the page in Elementor, delete the fallback form section, and import the matching Overture version:

| Page | Delete | Import instead |
|---|---|---|
| Contact page | `XCP_Contact_P2_Form_Fallback.json` section | `XCP_Contact_P2_Form_Overture.json` |
| Home page | `XCP_Home_S6_Contact_Form.json` section | `XCP_Home_S6_Contact_Form_Overture.json` |
| Services page | `XCP_Services_S3_Transformation_Bespoke.json` section | `XCP_Services_S3_Transformation_Bespoke_Overture.json` |

All field IDs are identical across versions — no data loss.

**Step 2:** In WordPress admin → Code Snippets (WPCode) → Add Snippet → PHP Snippet. Title it `XCP Overture Booking Integration`. Paste the snippet from [OVERTURE_SETUP_GUIDE.md](OVERTURE_SETUP_GUIDE.md) Step 2. Set status to **Active** and save.

> The WPCode snippet fires for **any** form whose Form Name is `XCP Contact: Overture`. All three Overture versions use this exact name — one snippet covers all pages automatically.

**Step 3:** Submit a test enquiry. Check Overture → Bookings for a new Pending booking. If nothing appears, check `wp-content/debug.log` for a line starting with `XCP Overture:` — it will tell you the exact HTTP error from Overture.

> ⚠️ **Do not use the old snippet** (titled "XCP Overture Authorization Header") — it used the wrong approach and will not create bookings. Delete it and use the new one from the guide.

**Form field → Overture Booking API mapping:**

| Form label | `field_id` | Overture API field |
|---|---|---|
| Your Name | `promoterName` | `promoterName` |
| Type of Project | `name` | `name` (booking title, required) |
| Preferred Date | `date` | `date` (required — defaults to today if left blank) |
| County / Region | `venueState` | `venueState` |
| Country | `venueCountry` | `venueCountry` |
| Email Address | `email` | Person record (auto-matched or created) |
| Phone Number | `phone` | Person record |
| Brand & Vision | `message` | `info[]` — "Brand & Vision" heading |
| Source URL (hidden) | `source` | `info[]` — "Source" heading |

✅ **Contact page complete — [→ Next: Blog / Stories Page](#-blog--stories-page)**

---

## 📖 BLOG / STORIES PAGE

The blog is structured as four distinct content channels, each with its own identity and audience. Import S1-S3 for the main frame, then S4-S6 for the three channel sections.

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero + Topic Showcase | `XCP_Blog_S1_Hero_Featured.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Blog_S1_Hero_Featured.json) |
| 2 | Posts Grid + Category Filter | `XCP_Blog_S2_Grid_Filter.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Blog_S2_Grid_Filter.json) |
| 3 | Newsletter Signup + Final CTA | `XCP_Blog_S3_Newsletter_CTA.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Blog_S3_Newsletter_CTA.json) |
| 4 | Photographer Hub (gear reviews, technique, affiliate picks) | `XCP_Blog_S4_Photographer_Hub.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Blog_S4_Photographer_Hub.json) |
| 5 | Stories and Notes (personal, BTS, projects) | `XCP_Blog_S5_Stories_BTS.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Blog_S5_Stories_BTS.json) |
| 6 | Music and Shows (reviews, The Portrait Guy podcast, Slack City Radio) | `XCP_Blog_S6_Music_Shows.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Blog_S6_Music_Shows.json) |

> **Section 1 image placeholders:** `XCP_Blog_S1_Hero_Featured.json` now includes three topic card images: `blog-brand-photography.jpg`, `blog-music-events.jpg`, `blog-gear-guides.jpg`. Each references `[uc_local]assets/images/`. Replace via Elementor: click each image widget → Content → Choose Image → upload from media library. Landscape orientation (3:2 ratio) works best for all three. See [HOW_TO_ADD_IMAGES.md](HOW_TO_ADD_IMAGES.md).

**WordPress categories to create** (Settings → Posts → Categories, or via the Posts menu):

| Category | Slug | Used in section |
|---|---|---|
| For Photographers | `for-photographers` | S4 parent |
| Gear Reviews | `gear-reviews` | S4 |
| Technique | `technique` | S4 |
| Affiliate Picks | `affiliate-picks` | S4 |
| Stories and Notes | `stories-and-notes` | S5 parent |
| Behind the Lens | `behind-the-lens` | S5 |
| Personal Projects | `personal-projects` | S5 |
| Music and Shows | `music-and-shows` | S6 parent |
| Show Reviews | `show-reviews` | S6 |
| The Portrait Guy | `the-portrait-guy` | S6 |
| Slack City Radio | `slack-city-radio` | S6 |

After importing each section, add an Elementor **Posts** widget inside each section where the placeholder note appears, filtered to the relevant category.

✅ **Blog page complete — [→ Next: Blog Post Template](#-blog-post-template--individual-post-layout)**

---

## ✍️ BLOG POST TEMPLATE — Individual Post Layout

Apply this template when creating each individual blog post. Works for all three blog channels: Brand Photography / Educational, Stories & Notes, and Music & Shows.

**How to use:**
1. In WordPress, create a new **Post** (not Page) in the appropriate category
2. Open the post with Elementor
3. Click the folder icon (bottom-left) → Import Template → select `XCP_Blog_Post_Template.json` → Insert
4. Replace all placeholder text with your post content
5. Replace placeholder images with your actual post images
6. Update the sidebar category tags to match the post's category
7. Publish the post

| # | Section | File | Link |
|---|---|---|---|
| — | Individual Post Layout (all channels) | `XCP_Blog_Post_Template.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Blog_Post_Template.json) |

> **Template sections:** Post hero (category + title + meta) → Featured image → Two-column body (article left, sidebar right) → Pull quote panel → Author bio → Related posts / back link.
>
> **Sidebar:** Includes a brief Xavier bio, an enquiry CTA (Sessions from £1,495), and category tags. Update category tags per post.
>
> **Affiliate links:** Use this template for Photographer Hub (gear review) posts — insert affiliate product links naturally within the body copy. Add the standard affiliate disclosure at the top of each gear review post (see `BLOG_POST_TEMPLATE.md` for the disclosure text).

✅ **Blog post template set — [→ Next: Magazine Review Template](#-magazine-review-template--music--events)**

---

## 🎵 MAGAZINE REVIEW TEMPLATE — Music & Events

Apply this template to individual music and events reviews and previews. This is the layout for the **Music & Shows** channel — live reviews, gig previews, and event photography pieces.

**How to use:**
1. Create a new WordPress **Post** in the `Music and Shows` → `Show Reviews` category
2. Open with Elementor → Import `XCP_Magazine_Review_Template.json`
3. Replace all bracketed placeholders [like this] with real content
4. Replace hero background image with your best shot from the event
5. Update the setlist sidebar
6. Replace star rating in the rating widget (★ = filled, ☆ = empty)
7. Publish

| # | Section | File | Link |
|---|---|---|---|
| — | Music & Events Review Layout | `XCP_Magazine_Review_Template.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Magazine_Review_Template.json) |

> **Template sections:** Full-width event hero (image + title + meta) → Event info panel (star rating + event details) → Opening paragraph → Lead photo → Review body (article + setlist sidebar) → Highlights → Photographing the night → Verdict → Full gallery CTA.
>
> **The "Photographing the night" section** is unique to XCP reviews — it connects the writing to the images and demonstrates photographic expertise. Always include this. Reference the specific gear used, the light conditions, and what made this gig interesting (or difficult) to shoot.
>
> **Gallery CTA:** Points to `/portfolio` by default. Update to link to the specific show gallery page if you create one.

✅ **Magazine review template set — [→ Next: Workshops Page](#-workshops-page)**

---

## 🎓 WORKSHOPS PAGE

Create a new WordPress page titled **"Workshops"** at the URL `/workshops`. Import all three sections in order.

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero + Philosophy + What's Included | `XCP_Workshop_S1_Hero.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Workshop_S1_Hero.json) |
| 2 | In-Person &amp; Online Workshop Formats + Pricing | `XCP_Workshop_S2_Formats_Pricing.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Workshop_S2_Formats_Pricing.json) |
| 3 | Deposit Booking Form | `XCP_Workshop_S3_Deposit_Booking.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Workshop_S3_Deposit_Booking.json) |

> **In-person workshops:** The Monopoly Run (London, £895/person or £1,595/couple) and Sound & Celluloid (Brighton, £595/person). All hospitality, post-processing session, and personalised camera settings card included in every in-person workshop.
>
> **Online workshops:** Brand Photography Fundamentals — 3 sessions (£395), Music Photography Masterclass — 1 session (£195), Portfolio Review & Mentoring — 1-to-1 (£295).
>
> **Deposit process:** The booking form (Section 3) sends enquiries to info@xcphotography.co.uk. After responding to confirm availability, send the deposit payment link manually (via Stripe, PayPal, or your preferred payment method). Deposits: 50% for in-person, full payment for online. Balance due 14 days before the workshop date.
>
> **Anchor link:** The "Reserve Your Place" buttons throughout the page link to `#workshop-booking` — the booking form section has `css_id: workshop-booking` set in Elementor → Advanced → CSS ID. Confirm this is set after import.
>
> **Adding workshops to navigation:** Add "Workshops" to the main navigation in `XCP_Header_Navigation.json`. Re-import the header template, or add the menu item directly via WordPress → Appearance → Menus.

✅ **Workshops page complete — [→ Next: Shop Page](#-shop-page)**

---

## 🛍️ SHOP PAGE

Create a new WordPress page titled **"Shop"** at the URL `/shop`. Import all three sections in order. WooCommerce must be installed and active before importing — the product listing widgets require it.

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero + Collections Intro | `XCP_Shop_S1_Hero_Collections.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Shop_S1_Hero_Collections.json) |
| 2 | Product Categories (Prints / Books / Gifts / Workshop Passes) | `XCP_Shop_S2_Categories.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Shop_S2_Categories.json) |

> **WooCommerce setup:** See `SHOP_SETUP_GUIDE.md` for full setup instructions. See `PRODUCT_CSV_IMPORT_GUIDE.md` for importing the initial product list via CSV. Install WooCommerce → Stripe → Printify (or Gelato) before adding products.
>
> **After import — add product widgets:** In Section 2, after each category's "Browse" button, add an Elementor **WooCommerce Products** widget filtered to that category (Prints / Books / Gifts / Workshop Passes). Set to 3 columns, 6 products per category.
>
> **Categories to create in WooCommerce:** Products → Categories: `prints`, `books`, `gifts`, `workshop-passes`. Sub-categories for prints: `framed-prints`, `unframed-prints`, `limited-editions`.
>
> **Payment:** WooCommerce Stripe plugin (recommended). See `SHOP_SETUP_GUIDE.md` Part 1 for Stripe setup.
>
> **Shipping zones:** UK Standard, UK Express, International. Configure in WooCommerce → Settings → Shipping.

✅ **Shop page complete — [→ Next: Individual Print Product Page Template](#-shop-individual-print-product-page-template)**

---

## 🖼️ SHOP: Individual Print Product Page Template

This template is applied to **each individual print product page** in WooCommerce. Every print gets its own Elementor-designed product page — not a generic WooCommerce default. Each print has a unique description, location note, artist note, and gallery of images (main shot, framed version, detail crop).

**How to set up:**
1. In WooCommerce → Products → Add New, create the product (name, price, size variants, frame variants)
2. Open the product page with Elementor (enable Elementor on Products in Elementor → Settings → Post Types)
3. Import `XCP_Shop_Product_Print_Template.json`
4. Replace all placeholder content with content specific to this print
5. In the product info column: replace the WooCommerce note widget with the actual WooCommerce **Add to Cart** and **Product Price** widgets (from Elementor Pro's WooCommerce widget library)
6. Publish

| # | Template | File | Link |
|---|---|---|---|
| — | Fine Art Print Product Page | `XCP_Shop_Product_Print_Template.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Shop_Product_Print_Template.json) |

> **Unique content per print:** Every print gets its own "About This Print" story (2–4 sentences), "A Note From Xavier" (2–3 sentences), and location/context metadata. Never use generic descriptions like "This image was taken in Brighton and is available in A3, A2 etc." — write a specific story for each image.
>
> **Framed and unframed options:** In WooCommerce, set up product variations: Size (A4 / A3 / A2 / A1 / 60×90 / 90×120) × Format (Unframed / Matt White Frame / Matt Black Frame / Natural Oak Frame). Price each variation separately.
>
> **Limited editions:** If the print is a limited edition, add edition size and number remaining to the product info column. Update the `[X] remaining` line as editions sell.
>
> **Books and gifts:** Use the same template approach — import, customise content per product, replace the WooCommerce note with live product widgets. Books and gifts will have simpler variant structures (typically just quantity).

✅ **Product page template set — [→ Next: Booking Page](#-booking-page)**

---

## 📅 BOOKING PAGE

| # | Section | File | Link |
|---|---|---|---|
| 1 | Hero + Trust Bar | `XCP_Booking_S1_Hero_Trust.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Booking_S1_Hero_Trust.json) |
| 2 | Booking Calendar + FAQ | `XCP_Booking_S2_Calendar_FAQ.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Booking_S2_Calendar_FAQ.json) |
| 3 | Closing CTA | `XCP_Booking_S3_CTA.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Booking_S3_CTA.json) |

✅ **Booking page complete — [→ Next: Thank You Page](#-thank-you-page)**

---

## ✅ THANK YOU PAGE

Create a new WordPress page titled **"Thank You"** at the URL `/thank-you`. Import this template into that page.

After importing the contact form, go to Elementor → form widget → Content → Actions After Submit. Add a **Redirect** action pointing to `/thank-you`. This redirects visitors automatically after a successful form submission.

| # | Section | File | Link |
|---|---|---|---|
| 1 | Thank You / Confirmation | `XCP_ThankYou_P1.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_ThankYou_P1.json) |

✅ **Thank You page complete — [→ Next: Privacy Policy Page](#-privacy-policy-page)**

---

## 🔒 PRIVACY POLICY PAGE

> **GDPR requirement** — a Privacy Policy page is legally required if you collect any personal data from UK visitors (including form submissions). Create a new WordPress page titled **"Privacy Policy"** at the URL `/privacy-policy` and import this template.

| # | Section | File | Link |
|---|---|---|---|
| 1 | Privacy Policy Content | `XCP_Privacy_Policy_P1.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Privacy_Policy_P1.json) |

> After importing, review the content and update any details that don't match your business (e.g. confirm the email address, adjust the Overture section if you are not yet using it). You should also add a link to this page in the footer — open `XCP_Footer.json` in Elementor and add a Privacy Policy link to the legal links column.

✅ **Privacy Policy page complete — [→ Next: Global Header & Footer](#-global-elements--header--footer)**

---

## 🔗 SERVICE SUB-PAGES (Individual Service Landing Pages)

These are **optional but recommended** for SEO. Each is a standalone page for a specific service type. Create separate WordPress pages for each (e.g. `/services/brand-photography/`, `/services/documentary/`, etc.) and import the relevant template.

| # | Service | File | WordPress URL slug | Link |
|---|---|---|---|---|
| 1 | Brand Photography Session | `XCP_Service_BrandPhotography_P1.json` | `services/brand-photography` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Service_BrandPhotography_P1.json) |
| 2 | Documentary Business Storytelling | `XCP_Service_Documentary_P1.json` | `services/documentary` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Service_Documentary_P1.json) |
| 3 | Corporate Portraits & Headshots | `XCP_Service_CorporatePortraits_P1.json` | `services/corporate-portraits` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Service_CorporatePortraits_P1.json) |
| 4 | Event & Performance Photography | `XCP_Service_Events_P1.json` | `services/events` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Service_Events_P1.json) |

**How to set up sub-pages in WordPress:**
1. WordPress Admin → Pages → Add New
2. Title: e.g. "Brand Photography Brighton"
3. URL slug: `services/brand-photography` (set this in Page Attributes → Permalink)
4. Set Parent Page to "Services" — this creates a proper `/services/brand-photography/` URL hierarchy
5. Publish the page, then open with Elementor to import the template

> **SEO note:** Each sub-page targets a specific search term (e.g. "brand photography Brighton") whereas the main Services page is too broad to rank well for any individual service. Sub-pages significantly increase your chances of appearing in search results for specific service queries.

✅ **Service sub-pages complete — [→ Next: Global Header & Footer](#-global-elements--header--footer)**

---

## 🌐 GLOBAL ELEMENTS — Header & Footer

These go in via **WordPress dashboard → Elementor → Templates → Import Templates** (not inside a page).
Then assign via **Theme Builder → All Pages**.

| Element | File | Link |
|---|---|---|
| Header (sticky nav) | `XCP_Header_Navigation.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Header_Navigation.json) |
| Footer (full 4-column) | `XCP_Footer.json` | [→ Open](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_Footer.json) |

✅ **Global elements done — all templates imported!**

---

## How to download a file from GitHub

1. Click the **→ Open** link
2. Click **Raw** (top-right of the page)
3. Right-click anywhere → **Save As** → keep the `.json` extension
4. Import in Elementor: **folder icon → Import Template → select file → Insert**

---

## Quick checks after each import

- **Colours** — black `#000000`, warm off-white `#E8E4DC`, white `#FFFFFF`
- **Font** — Raleway throughout
- **Your name** — "Xavier" / "XCP Photography" everywhere, no placeholder text
- **Contact details** — replace any dummy phone/email with your real ones
- **Prices** — £1,495 floor showing correctly on Services and wherever pricing appears
- **Images** — placeholders will show; add yours from the `images/` folder in this repo

---

## Can I turn off my laptop while the agent is working?

**Yes — completely safe to do so.**

Once you have opened a task with the GitHub Copilot agent (by submitting the issue or PR), the agent runs entirely in GitHub's cloud infrastructure. Your laptop plays no part in the process. Every change the agent makes is committed directly to this GitHub repository.

When you return, open the Pull Request in GitHub and all the changes will be there, committed with a clear message. You can then download or pull the updated files and carry on.

**There is nothing running on your laptop. You can close the browser, turn off the machine, and come back in the morning.**

---

🎉 **All imports complete — [→ Return to Master Action Plan (Step 6: Add Images)](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/XCP_MASTER_PLAN.md)**
