# XCP Photography — Master Action Plan
## Everything in order. One step at a time.

**← [Back to Start: README](README.md) · Step 5 opens [JSON Import Index](JSON_IMPORT_INDEX.md)**

**Target:** £30,000–£60,000 per month within 18 months.
**Floor:** £1,495 per session — never lower.
**Phase 1:** WordPress + Elementor. SmugMug is Phase 2 — only after the main site is fully live.

---

## HOW TO USE THIS PLAN

Work through the steps in numbered order. Each step is self-contained — do as many as your day allows, then pick up at the next one next time. Some sessions you'll clear three steps; some you'll do half of one. That's fine. The order is what matters.

Every step includes:
- How long it takes
- Exactly what to do (no "go read another file")
- What you have when it's done

---

---

# PART 1 — BUILD THE SITE
## Steps 1–9 | WordPress + Elementor

**Goal:** xcphotography.co live, every page working, contact form tested.
**Total time:** 8–12 hours. Split across as many sessions as you like.

---

### STEP 1 — WordPress requirements and theme (~30 minutes)

**Check WordPress version:**
Dashboard → Updates → confirm WordPress 6.3 or later. Update if not.

**Check HTTPS:**
Your browser address bar should show a padlock and `https://xcphotography.co`. If not, contact your hosting provider — they provide free SSL certificates (Let's Encrypt).

**Set memory limit (only if you see errors):**
Add this to your `wp-config.php` file (via hosting file manager or FTP), just above the line `/* That's all, stop editing! */`:
```php
define('WP_MEMORY_LIMIT', '256M');
```

**Install Hello Elementor theme:**
1. Appearance → Themes → Add New
2. Search: Hello Elementor
3. Install → Activate

This gives Elementor full control of every page with zero interference from the theme.

**✓ Done when:** You're at xcphotography.co/wp-admin, URL shows https://, Hello Elementor is active.

---

### STEP 2 — Install all plugins (~30 minutes)

Go to **Plugins → Add New** for each free plugin. For Elementor Pro, upload the zip file you downloaded from elementor.com.

**Must have — install all before importing templates:**

| Plugin | How to install |
|---|---|
| Elementor (free) | Search "Elementor" in plugin directory → Install → Activate |
| Elementor Pro | Purchase at elementor.com → Plugins → Add New → Upload Plugin → activate licence |
| WooCommerce | Search "WooCommerce" → Install → Activate |
| Yoast SEO | Search "Yoast SEO" → Install → Activate |
| WP Mail SMTP | Search "WP Mail SMTP" → Install → Activate → connect to your email provider |

**Recommended — install now to save time later:**

| Plugin | Why |
|---|---|
| Smush | Image compression — speeds up the site automatically |
| WP Rocket or LiteSpeed Cache | Caching — makes pages load faster |
| OMGF (Optimize My Google Fonts) | Downloads Raleway to your server — faster, GDPR-compliant |

**Set Elementor global colours (do this before importing any template):**
Elementor → Settings → Style → set:
- Primary: `#E8E4DC` (warm platinum)
- Secondary: `#FFFFFF`
- Text: `#333333`
- Accent: `#000000`

**Set Elementor global font:**
Elementor → Settings → Typography:
- Primary font: Raleway
- Secondary font: Raleway

**✓ Done when:** All required plugins installed and active. Elementor global colours and font set.

---

### STEP 3 — Create the page structure (~15 minutes)

Create these empty pages first. The correct slugs mean all internal links work the moment you import the templates.

**Pages → Add New** — for each row below, create the page and set the slug in the Permalink field, and set the Page Template to **Elementor Full Width** (except the legal pages):

| Page title | URL slug | Template |
|---|---|---|
| Home | (leave blank — set as front page below) | Elementor Full Width |
| About | `about` | Elementor Full Width |
| Services | `services` | Elementor Full Width |
| Portfolio | `portfolio` | Elementor Full Width |
| Stories | `stories` | Elementor Full Width |
| Contact | `contact` | Elementor Full Width |
| Book a Call | `book` | Elementor Full Width |
| Privacy Policy | `privacy-policy` | Default |
| Terms and Conditions | `terms-and-conditions` | Default |
| Cookie Policy | `cookie-policy` | Default |

**Set front page:** Settings → Reading → A static page → Front page: Home → Save

**Set blog page:** Settings → Reading → Posts page: Stories → Save

**Set permalink structure:** Settings → Permalinks → Post name → Save Changes

**Create blog categories (Posts → Categories → Add New):**
- Brand Photography
- Behind the Scenes
- Client Stories
- Gear Guides
- Music & Nightlife
- Photography Tips

**✓ Done when:** All pages exist with correct slugs. Front page is set to Home. Permalink structure is Post name.

---

### STEP 4 — Import the header and footer (~20 minutes)

These are global — they appear on every page. Import them before any page templates.

**Header:**
1. Elementor → Theme Builder → Header → Add New → type a name (e.g. "XCP Header") → Create Template
2. Click the folder icon (Import Template)
3. Upload `XCP_Header_Navigation.json` from this repository
4. Click Insert
5. Publish → Display Conditions → Add Condition → Entire Site → Save & Close

**Footer:**
1. Elementor → Theme Builder → Footer → Add New → name it → Create Template
2. Click the folder icon (Import Template)
3. Upload `XCP_Footer.json`
4. Click Insert
5. Publish → Display Conditions → Entire Site → Save & Close

**✓ Done when:** When you preview any page, the XCP header and footer appear at the top and bottom.

---

### STEP 5 — Import all page templates (~90 minutes)

> 📋 **Full import index with direct download links:** see [`JSON_IMPORT_INDEX.md`](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/JSON_IMPORT_INDEX.md) — every file, every page, in order.

**The method is the same for every section:**
1. Open the page in Elementor (Pages list → hover → Edit with Elementor)
2. Click the grey folder icon at the bottom of the canvas, or click **+** → Templates
3. My Templates → Import → upload the JSON file → Insert
4. Repeat for each section of the same page, in order
5. When all sections are imported, click Update to save

**Home page — import in this exact order:**

> ⚠️ The original Part 1 file has been split into two smaller files so Elementor can handle it. Import S1a first, then S1b.

| # | File |
|---|---|
| 1 | `XCP_Home_S1a_Hero_Concepts.json` |
| 2 | `XCP_Home_S1b_Gallery.json` |
| 3 | `XCP_HomeP2_Parallax_Text_FINAL.json` |
| 4 | `XCP_HomeP3_Checkerboard_FINAL.json` |
| 5 | `XCP_Home_S4a_Stats_Pillars.json` |
| 6 | `XCP_Home_S4b_Process.json` |
| 7 | `XCP_HomeP5_Testimonials_CTA_FINAL.json` |

**About page:**

| # | File |
|---|---|
| 1 | `XCP_About_S1_Hero_Values.json` |
| 2 | `XCP_About_S2_Pillars_Credentials.json` |
| 3 | `XCP_About_S3_Experience_Steps12.json` |
| 4 | `XCP_About_S4_Steps34_CTA.json` |

**Services page:**

| # | File |
|---|---|
| 1 | `XCP_Services_S1_Hero_Intro.json` |
| 2 | `XCP_Services_S2_Foundation_Elevation.json` |
| 3 | `XCP_Services_S3_Transformation_Bespoke.json` |

**Portfolio page:**

| # | File |
|---|---|
| 1 | `XCP_Portfolio_P1_Hero_Filter.json` |
| 2 | `XCP_Portfolio_P2_Gallery_CTA.json` |

**Stories (Blog) page:**

| # | File |
|---|---|
| 1 | `XCP_Blog_S1_Hero_Featured.json` |
| 2 | `XCP_Blog_S2_Grid_Filter.json` |
| 3 | `XCP_Blog_S3_Newsletter_CTA.json` |

**Contact page — choose one version:**

*With Overture CRM (recommended if you use Overture):*

| # | File |
|---|---|
| 1 | `XCP_Contact_P1_Hero.json` |
| 2 | `XCP_Contact_P2_Form_Overture.json` |
| 3 | `XCP_Contact_P4_CTA.json` |

*Email only (simpler — use if you don't use Overture):*

| # | File |
|---|---|
| 1 | `XCP_Contact_P1_Hero.json` |
| 2 | `XCP_Contact_P2_Form_Fallback.json` |
| 3 | `XCP_Contact_P4_CTA.json` |

*Or use the single all-in-one file:* `XCP_Contact_P1_Complete.json` (import this alone instead of the three above)

**Booking page:**

| # | File |
|---|---|
| 1 | `XCP_Booking_S1_Hero_Trust.json` |
| 2 | `XCP_Booking_S2_Calendar_FAQ.json` |
| 3 | `XCP_Booking_S3_CTA.json` |

**✓ Done when:** Every page has its sections imported. You can preview each page and see the layout.

---

### STEP 6 — Add your images (~1–2 hours)

After import, images appear as broken placeholders. Replace each one with a real image from your work.

**To replace any image:**
1. Open the page in Elementor
2. Click the section or widget with the broken image
3. Left panel → click the broken image thumbnail → Choose Image → upload from your computer or select from Media Library

**Image slots to fill — in priority order:**

**Homepage hero + gallery bar (HomeP1):**
- Hero background: your single strongest brand/portrait image. Full bleed. Landscape.
- Gallery bar image 1: editorial brand shot
- Gallery bar image 2: music/nightlife shot
- Gallery bar image 3: documentary/hospitality
- Gallery bar image 4: portrait/corporate edge

**Homepage parallax (HomeP2):**
- Full-bleed, moody, cinematic. Dark tones. Editorial. Your City Spirit or Triumph bike-era work.

**Homepage checkerboard (HomeP3):**
- Left panel: brand/commercial work
- Right panel: documentary/music/nightlife

**Homepage partner logos (HomeP5):**
- Hotel du Vin, Concorde 2, The Ivy, BBC, Amazon, The Royal Pavilion — white PNG, transparent background
- If you don't have these as files yet, skip and add later — don't hold up the launch

**About page hero:**
- Xavier on a shoot, or a strong environmental portrait of you working — not a studio headshot

**About page process steps:**
- Step 1 (Discovery): conversation/consultation image
- Step 2 (Planning): preparation/planning image
- Step 3 (Shoot): on-shoot action
- Step 4 (Delivery): results/output

**Services page:**
- Hero: strong brand shoot image
- Package images (one per package): Brand Foundation, Brand Elevation, Brand Transformation

**Portfolio grid (Portfolio P1 + P2):**
- Minimum 12 real images. Your best work. Mix of subjects.
- Category thumbnails: music, documentary, brand/corporate

**Image size and format guide:**

| Slot | Dimensions | File format | Max size |
|---|---|---|---|
| Hero backgrounds (full bleed) | 1920 × 1080px minimum | JPG | 300KB |
| Gallery/portfolio grid | 1200 × 800px | JPG | 150KB |
| Parallax background | 1920 × 1200px | JPG | 400KB |
| Process step images | 800 × 600px | JPG | 100KB |
| Logo (footer) | 300 × 80px (600 × 160 for retina) | PNG, transparent | 50KB |
| Partner logos | 320 × 120px (640 × 240 for retina) | PNG, transparent | 30KB |

**✓ Done when:** Every hero is a real image. Portfolio grid shows 12+ real images. No critical broken placeholders remain.

---

### STEP 7 — Update placeholder details (~30 minutes)

**Phone number:**
The templates contain `+441234567890`. Replace it everywhere:
- Contact page: Elementor → phone number widget → update
- Footer: Elementor footer editor → phone widget → update

**Email address:**
Confirm `hello@xcphotography.co.uk` is correct in:
- Contact form widget → Actions After Submit → Email → "To" field
- WP Mail SMTP settings

**Social links in footer:**
Footer → Elementor → Social Icons widget → update each:
- Instagram: `https://www.instagram.com/xcphotographyuk`
- LinkedIn: `https://www.linkedin.com/in/xcphotographyuk`
- Facebook: `https://www.facebook.com/xcphotographyuk`

**Calendly link:**
You'll set this up in Step 11. Come back and update the Booking page widget then.

**✓ Done when:** Phone, email, and social links are real throughout the site.

---

### STEP 8 — WooCommerce products and payments (~30 minutes)

Create the three booking products so the "Book Now" buttons on the Services page work.

**WooCommerce → Products → Add New — create all three:**

| Product name | Slug | Price | Notes |
|---|---|---|---|
| Brand Foundation Session | `brand-foundation` | £1,495 | Tick "Virtual" — no physical shipping |
| Brand Elevation Session | `brand-elevation` | £2,500 | Tick "Virtual" |
| Brand Transformation Session | `brand-transformation` | £4,500 | Tick "Virtual" |

For each: add a one-paragraph description → set the price → tick Virtual → Publish.

**Connect Stripe:**
WooCommerce → Settings → Payments → Stripe → Enable → enter API keys from dashboard.stripe.com
Use test keys first. Switch to live keys when ready to take real payments.

**Set currency:**
WooCommerce → Settings → General → Currency: Pound Sterling (£) → Save

**✓ Done when:** Three products exist at correct prices. Stripe is connected. Test checkout works.

---

### STEP 9 — Pre-launch checks (~45 minutes)

Go through every item. Don't skip this — it takes 45 minutes and prevents embarrassing a live site.

**Content:**
- [ ] Homepage loads at xcphotography.co — no broken sections
- [ ] About, Services, Portfolio, Contact, Book pages all load at correct URLs
- [ ] Phone number and email are real on contact page and footer
- [ ] All social links open the correct profiles
- [ ] Services page shows pricing starting at £1,495
- [ ] Portfolio shows minimum 12 real images
- [ ] No placeholder text remains (search the pages for "[" or "Lorem")

**Forms and bookings:**
- [ ] Submit the contact form to yourself — confirm the email arrives in your inbox within 2 minutes
- [ ] Click every "Book" button — confirm it goes to the right place
- [ ] Test WooCommerce checkout with a test product using Stripe test mode

**SEO (Yoast):**
- [ ] Homepage SEO title: `Brand and Documentary Photographer Brighton | XC Photography`
- [ ] Homepage meta description: `Brand and documentary photography in Brighton and London. XC Photography — authentic imagery for brands with edge.`
- [ ] Set SEO title and meta description on every page via the Yoast panel at the bottom of each page editor

**Submit sitemap to Google:**
1. Go to search.google.com/search-console → Add property → enter xcphotography.co
2. Sitemaps (left menu) → enter `sitemap.xml` → Submit
Google will now start indexing your site.

**Mobile check:**
- [ ] View every page on your phone — confirm no layout breaks, text is readable, buttons are tappable
- [ ] Click every navigation link

**✓ Done when:** Every item ticked. Site is live and professional.

---

---

# PART 2 — LAUNCH
## Steps 10–16 | Go live, start talking to people

**Goal:** Bookable, findable, first conversations started. First paid session within 14 days.
**Total time:** 8–10 hours. Each step is independent.

---

### STEP 10 — Fix the four known typos (~15 minutes)

These are confirmed in the original templates. Fix before anyone sees the site.

Open each page in Elementor → find the text → fix → Update:

| Page | Section | Change this | To this |
|---|---|---|---|
| Home | Gallery bar, 3rd box | "Timless beuty" | "Timeless Beauty" |
| Home | Features section | "Personalised Colloboration" | "Personalised Collaboration" |
| Home | Features section | "Narative-Led Content" | "Narrative-Led Content" |
| Footer | Quick Links | "Porfolio" | "Portfolio" |

**✓ Done when:** No typos. Every word on the site is correct.

---

### STEP 11 — Set up your booking link (~30 minutes)

This eliminates email ping-pong. A client clicks, picks a time, they're booked.

1. Sign up at **calendly.com** (free)
2. Create one event: **"Free Discovery Call — 20 minutes"**
3. Set your actual available times (block out any days you won't be available)
4. Copy your Calendly link (it looks like `calendly.com/xcphotographyuk/discovery-call`)

Add this link to:
- Homepage hero CTA button (Edit with Elementor → find "Book Your Free Consultation" button → update URL)
- Services page "Book a Call" buttons (update each one)
- Booking page Calendly widget (update the URL in the widget settings)
- Your email signature
- Instagram bio link
- LinkedIn "Website" field (edit your LinkedIn profile → intro → Website)

**✓ Done when:** The "Book" button on your homepage takes someone directly to your Calendly page and they can pick a time.

---

### STEP 12 — Update LinkedIn (~30 minutes)

LinkedIn is where business clients look before they book. This takes 30 minutes and pays back indefinitely.

Open **`LINKEDIN_PROFILE_UPDATED.md`** — the complete text is word-for-word ready.

1. Replace your current headline with the line from the file (exactly as written)
2. Replace your entire About section with the text from the file
3. Website URL: `xcphotography.co`
4. Profile photo: a strong, well-lit shot of you — not a logo, not a dark or blurred image
5. Settings → Visibility → Creator mode → On (this gives you follower stats and newsletter access)
6. Featured section → add a link to your portfolio (xcphotography.co/portfolio)

**✓ Done when:** Headline and About are updated. Website URL is correct. Creator mode is on. Portfolio is in Featured.

---

### STEP 13 — Publish the five blog posts (~2 hours)

You have five complete, ready-to-publish blog posts in this repo. Every day they sit unpublished is a day Google isn't indexing them.

**For each post:**
1. WordPress → Posts → Add New
2. Title: copy from the top of the .md file
3. Body: paste the full content
4. Featured image: upload one strong image relevant to the post topic (from your portfolio)
5. Set the Category (from the categories you created in Step 3)
6. Yoast SEO panel (scroll to bottom of page editor): set the Focus Keyphrase, SEO Title, and Meta Description — these are listed in each file
7. Publish

**The five posts:**

| File | What it targets |
|---|---|
| `BLOG_Brand_Photography_Brighton_Guide.md` | Local Brighton searches — "brand photographer Brighton" |
| `BLOG_Brand_Photography_ROI.md` | Decision-stage buyers — people who need convincing |
| `BLOG_5_Signs_New_Brand_Photos.md` | Awareness-stage buyers — people who haven't decided yet |
| `BLOG_Corporate_Event_Photography_Guide.md` | Corporate event clients |
| `BLOG_Documentary_Business_Photography.md` | Your specialist niche positioning |

**Once all five are live:**
Share one on LinkedIn. Not "check out my blog" — pull one strong sentence from the post, write two sentences of your own context around it, then add the link. That's a proper LinkedIn post.

**✓ Done when:** Five posts are published and visible at xcphotography.co/stories. One has been shared on LinkedIn.

---

### STEP 14 — Lead magnet and coming soon page (~2 hours)

**Part A — Create the lead magnet PDF (30 minutes):**
1. Open Google Docs: docs.google.com → File → Open → Upload → select `XCP_Lead_Magnet_Services_Guide.md`
2. The content imports as a document — tidy any formatting if needed
3. File → Download → PDF Document
4. Rename the downloaded file: `xcp-photography-services-guide.pdf`
5. WordPress → Media → Add New → upload this PDF → once uploaded, click it → copy the File URL (you'll need this in Part C)

**Part B — Publish the coming soon page (1 hour):**
1. WordPress → Pages → find the "Coming Soon" page (you created it in Step 3) → Edit with Elementor
2. Import Template → upload `XCP_Coming_Soon_Page.json` → Insert
3. In the sign-up form widget → find the **Page Source** field → click the dynamic tag icon → select "Current URL"
4. Update the email address in the footer of the page if needed
5. Update

**Part C — Set up PDF delivery automation in Overture (30 minutes):**
1. Log into Overture → Automations → Create New Automation
2. Trigger: Contact created with tag `coming-soon-signup`
3. Action: Send Email
4. Subject line: `Your XC Photography Services Guide`
5. Email body:
   > Hi [First Name],
   >
   > Thanks for signing up — here's your copy of the XC Photography Services Guide.
   >
   > [Download your guide here] — link to your PDF URL from Part A
   >
   > The main site launches soon. In the meantime, if you have any questions or want to discuss a project, reply to this email.
   >
   > Xavier
6. Save and activate the automation

**✓ Done when:** PDF is uploaded. Coming soon page is live. Someone can sign up and automatically receive the PDF by email.

---

### STEP 15 — Warm outreach (~2 hours)

The fastest path to your first booking. Not social media, not SEO — people who already know you.

**Build your list:**
Go through: past clients, business contacts, LinkedIn connections who run businesses, anyone you've worked with in any capacity. Aim for 20–30 names. Write them in a notes document.

**The email to send:**

> **Subject: Updated my services**
>
> Hi [Name],
>
> Quick update — I'm relaunching and taking on new brand photography clients from [this month].
>
> If you or anyone you know needs professional imagery — headshots, team photos, brand content — I have availability. Sessions from £1,495 for a half day.
>
> Portfolio: xcphotography.co
> Book a call: [your Calendly link]
>
> Xavier

No pitch. No features list. No pressure. If you know them well, personalise the opening line. If it's been a while, acknowledge it briefly. Send to your full list.

You only need one yes to cover your first month of effort.

More email templates: `WARM_OUTREACH_TEMPLATES.md`

**✓ Done when:** Email sent to 20–30 people on your list.

---

### STEP 16 — Find and attend a networking event (~3 hours including travel)

You're better with people in person than any algorithm. This is faster than waiting for Google.

**Where to find events:**
- Brighton & Hove Business Club
- Brighton Chamber of Commerce events
- Any industry mixer, launch, or open studio
- BNI Brighton
- Creative or music industry events
- Google: "Brighton business networking [this month]"

**At the event:**
You are not selling. You are meeting people. When someone asks what you do:

> *"I'm a brand photographer. I work with businesses who want imagery that actually looks like them — not a stock photo. Here's my card."*

Get 10 business cards. Have real conversations.

**Within 24 hours of the event:**
Send a follow-up email to everyone you met. Use this template:

> **Subject: Great to meet you at [event name]**
>
> Hi [Name],
>
> Really enjoyed our conversation at [event]. Your work on [thing they mentioned] sounds like exactly the kind of challenge I'd find interesting to document.
>
> I work with businesses on brand photography specifically to [solve the thing they mentioned / show the side of them that isn't on their website].
>
> Portfolio: xcphotography.co
> Happy to jump on a quick call: [Calendly link]
>
> Either way, good to meet you.
>
> Xavier

**✓ Done when:** One event attended. Follow-up emails sent within 24 hours.

---

---

# PART 3 — VISIBILITY
## Steps 17–20 | Build ongoing findability

**Goal:** Google finds you, social media is consistent, print shop is live.
**Total time:** 5–6 hours, spread across a week.

---

### STEP 17 — SEO and Google Business Profile (~2 hours)

**Set up Google Business Profile (free — essential for local search):**
1. Go to business.google.com → Manage Now → Add your business
2. Business name: XC Photography
3. Category: Photographer
4. Service area: Brighton (add London if you work there regularly)
5. Website: xcphotography.co
6. Upload 10 of your best images
7. Write a description (750 characters max) — use these phrases naturally: "brand photographer Brighton", "documentary photographer", "brand photography London"
8. Once verified (Google will send a postcard or call), ask your first five clients to leave a review by sharing the review link from your profile

**Yoast SEO — configure every page:**

| Page | SEO title | Focus keyphrase |
|---|---|---|
| Home | Brand and Documentary Photographer Brighton \| XC Photography | brand photographer Brighton |
| About | About XC Photography — Xavier Clarke | brand photographer Brighton |
| Services | Brand Photography Packages \| XC Photography | brand photography packages Brighton |
| Portfolio | Portfolio \| XC Photography | brand photography portfolio |
| Contact | Book a Brand Photographer \| XC Photography | book brand photographer Brighton |

For each page: open the page editor → scroll to Yoast SEO panel → set Focus Keyphrase, SEO Title, Meta Description.

Full keyword map and strategy: `SEO_VISIBILITY_STRATEGY.md`

**✓ Done when:** Google Business Profile submitted. Yoast SEO configured on every page.

---

### STEP 18 — Social media rhythm (45 minutes per week, every week)

Not about going viral. About being consistently visible so people who already know you think of you when they need a photographer.

**Three posts per week — Monday, Wednesday, Friday:**

| Day | What to post |
|---|---|
| Monday | One blog post — pull one strong sentence from it, write two sentences of context, add the link |
| Wednesday | One image from your portfolio — one line caption, no hashtag soup |
| Friday | Something real — a thought, an observation, something from a shoot this week |

**LinkedIn:** Write 100–200 words per post. This length performs significantly better than 30-word posts on LinkedIn.

**Instagram:** Images first. Caption is secondary. Same three content types — image leads.

Ready-made carousel content: `INSTAGRAM_CAROUSEL_TEMPLATES.md`
Services showcase carousel: `INSTAGRAM_CAROUSEL_SERVICES_SHOWCASE.md`

**✓ Done when:** You've posted three times this week. Schedule next week's three posts on Sunday evening (10 minutes).

---

### STEP 19 — WooCommerce print shop (~one afternoon)

All print sales go through WooCommerce — one payment gateway, one order system, no commission to a third party. Set it up once, it runs indefinitely.

**Import the product range in one step:**
WooCommerce → Products → Import → upload `SHOP_PRODUCTS_CSV_WOOCOMMERCE.csv` → run import
(This creates all print products at once rather than one by one)

**Connect Prodigi for print fulfilment:**
1. Go to prodigi.com → sign up (free)
2. Dashboard → Connect a Store → WooCommerce → enter your store URL → authorise
3. Follow the Prodigi setup wizard to map your WooCommerce products to Prodigi print SKUs
4. Prodigi will handle printing, packing, and UK delivery every time an order comes in

**Add shop access to your site:**
- Navigation: Elementor header editor → nav menu → add "Prints" or "Shop" linking to `/shop`
- Portfolio page: under your best images, add a "Buy a Print" button linking to the relevant WooCommerce product

Full setup guide: `WOOCOMMERCE_INTEGRATION_GUIDE.md`
Product details and SKU mapping: `WOOCOMMERCE_PRODUCT_IMPORT_FAST_TRACK.md`

**✓ Done when:** Print products are visible at xcphotography.co/shop. Prodigi is connected. A customer can order a print and it gets fulfilled without you touching it.

---

### STEP 20 — Lightroom plugin (~1 hour)

Every image you deliver should be keyworded, titled, and ready for the platform it's going to. This plugin automates all of that.

**Install:**
1. Lightroom Classic → File → Plug-in Manager → Add
2. Navigate to the `XCPImageTagger.lrplugin` folder in this repository → select it → Add Plug-in
3. Confirm it shows: "XCP Platform Publisher — Installed and running"

**Configure once:**
1. Library → Plug-in Extras → Brand Voice Settings
2. Set:
   - Photographer Credit: Xavier Clarke / XC Photography
   - Instagram handle: xcphotographyuk
   - Website: xcphotography.co
   - Location: Brighton, United Kingdom
   - Brand Voice: Documentary & Authentic
3. Save Settings

**Workflow for every shoot going forward:**
1. Cull and edit in Lightroom as normal
2. Select the prepared images (the ones you're delivering or publishing)
3. Library → Plug-in Extras → Multi-Platform Preparation
4. Tick: Website, Instagram (minimum) — add others as needed
5. Click Prepare All
6. The plugin writes: title, caption, alt text, 25–50 keywords, IPTC fields — automatically
7. Platform-specific copy is stored in the Instructions field — copy/paste to each destination

Full plugin guide: `XCPImageTagger.lrplugin/README.md`

**✓ Done when:** Plugin installed. Brand Voice settings saved. Run it on your next batch before export.

---

---

# PART 4 — SCALE
## Steps 21–24 | Multiple revenue streams

**Goal:** £5,000–£10,000/month from sessions alone. Multiple income streams active.
**Start these in months 2–3, after bookings are flowing consistently.**

---

### STEP 21 — Your first workshop

Workshops generate revenue, authority, community, and content — at the same time.

**The format to start with:**

| | Brighton | London |
|---|---|---|
| Duration | 4 hours | 4 hours |
| Group size | Maximum 8 | Maximum 8 |
| Price per person | £295 | £395 |
| What they leave with | 5+ images from the session, a personal shot list, clarity on when to hire vs DIY |

**To fill your first one:**
1. One LinkedIn post: "I'm running my first photography workshop in Brighton. 8 places. [Date]. [Link to book]." Direct. No waffle.
2. Email everyone from your warm outreach list using a modified version of the Step 15 email (replace "brand session" with "workshop")
3. List on Eventbrite (free to list)
4. Add it to your Services page in Elementor

The best outcome at every workshop: attendees understand what you do and almost always book a professional session afterwards. The workshop is both revenue and a pipeline.

Full strategy including advanced formats and 1-2-1 mentoring packages: `WORKSHOPS_EVENTS_STRATEGY.md`

---

### STEP 22 — Amazon affiliate income (~one afternoon)

You have ten blog posts across this repo. Each can carry legitimate affiliate links to photography equipment, books, and tools. Commission is earned on every purchase — no extra work after setup.

1. Apply at affiliate-program.amazon.co.uk (free, approval usually within 24–72 hours)
2. Once approved, get your affiliate tracking ID
3. Go back through each published blog post and add affiliate links to any products mentioned (camera gear, books, studio equipment, etc.)
4. Add this disclosure at the top of each post that contains affiliate links: *"This post contains affiliate links. I may earn a small commission if you purchase through these links, at no extra cost to you."*

Realistic earnings: £150–£400/month once all posts are indexed and getting traffic. Low ceiling, but zero maintenance after setup.

Full guide: `AMAZON_AFFILIATE_INTEGRATION_DETAILED.md`

---

### STEP 23 — Print shop expansion

WooCommerce is already running. Expand the product range to increase average order value:

**Add via WooCommerce → Products → Add New (or import via CSV):**
- Fine art prints: A3, A2, A1 sizes
- Canvas gallery wraps
- Framed editions (standard and premium frame options)
- Limited edition numbered prints — set stock quantity = edition size, WooCommerce marks as sold out automatically
- Gift vouchers

For each new product, map it to the matching Prodigi product SKU inside the Prodigi WooCommerce plugin. Prodigi prints and ships automatically when an order comes in.

Full product range and Prodigi SKU guide: `WOOCOMMERCE_INTEGRATION_GUIDE.md`

---

### STEP 24 — London market and stock photography

**London sessions:**
A corporate brand photography session in London commands £3,000–£8,000, not £1,495. One London day covers a week of Brighton rates. Once you're established in the Brighton market:
- Target "brand photographer London" as a secondary keyword in Yoast SEO across the site
- Add London to your Google Business Profile service area
- Attend at least one London networking event per month

**Stock photography — the back catalogue asset:**
Every image that isn't client-confidential is a potential stock asset. The Lightroom plugin handles the keywording.

1. Identify 500–1,000 of your best non-client-specific images
2. Run Multi-Platform Preparation → tick Stock Photography → Alamy
3. Plugin generates 25–50 keywords per image
4. Upload to Alamy (best UK editorial royalties), Shutterstock, and Adobe Stock
5. Refresh with 50–100 new images every month

**Stock income:** £50–£200/month in year one. £500–£2,000/month by year two. Passive — compounds as the catalogue grows.

---

---

# THE DAILY RHYTHM
## Once everything is running, this is the week

| Time | Activity |
|---|---|
| Monday morning | Check Overture for new enquiries. Reply within 2 hours. Post on LinkedIn/Instagram. |
| Tuesday–Thursday | Shoots, editing, client delivery. Run Lightroom plugin on every batch before export. |
| Wednesday | Mid-week post (one image, one line). Check Google Analytics — what blog posts are getting traffic? |
| Friday morning | Weekly post (something real — a thought, something from the week). Review bookings pipeline. |
| Friday afternoon | One hour admin: pending outreach, upcoming workshops, stock image upload. |

**Monthly:**
- One networking event attended
- Two blog posts published (you have more ready in the repo — see the file index below)
- Workshop planned or delivered
- 50–100 stock images uploaded to Alamy, Shutterstock, Adobe Stock
- One Google Business Profile review requested from a recent client

---

---

# THE REVENUE STACK AT SCALE
## Where this leads — months 6–18

| Revenue stream | Monthly target | How |
|---|---|---|
| Brand photography sessions | £15,000–£25,000 | 10–17 sessions at £1,495+ |
| Workshop income | £5,000–£10,000 | 2 half-day + 1 full-day per month |
| 1-2-1 mentoring | £3,000–£6,000 | 6–12 hours/month at £500/hour |
| Print sales (WooCommerce + Prodigi) | £1,500–£3,000 | Compounds as catalogue grows |
| Affiliate income | £300–£800 | Grows with blog traffic |
| Stock photography | £500–£2,000 | Back catalogue generating royalties |
| **Total** | **£25,300–£46,800** | Then add London premium sessions |

London corporate sessions: £3,000–£8,000 per day. Add a few each month and the £30,000–£60,000 target becomes the standard operating month, not the aspiration.

---

---

# EVERY FILE IN THIS REPOSITORY
## What it is and when you need it

## Elementor templates — import directly to WordPress

> For the full ordered import guide with direct download links, see [`JSON_IMPORT_INDEX.md`](https://github.com/xcphotographyuk-gif/XCP_Branding/blob/copilot/audit-website-structure/JSON_IMPORT_INDEX.md).

| File | What it builds | When |
|---|---|---|
| `XCP_Header_Navigation.json` | Site header and nav | Step 4 — import first |
| `XCP_Footer.json` | Site footer | Step 4 — import first |
| `XCP_Home_S1a_Hero_Concepts.json` | Homepage hero + concept boxes | Step 5 |
| `XCP_Home_S1b_Gallery.json` | Homepage 4-box gallery bar | Step 5 |
| `XCP_HomeP2_Parallax_Text_FINAL.json` | Homepage parallax panel | Step 5 |
| `XCP_HomeP3_Checkerboard_FINAL.json` | Homepage checkerboard strip | Step 5 |
| `XCP_Home_S4a_Stats_Pillars.json` | Homepage stats + three pillars | Step 5 |
| `XCP_Home_S4b_Process.json` | Homepage process timeline | Step 5 |
| `XCP_HomeP5_Testimonials_CTA_FINAL.json` | Homepage testimonials + CTA | Step 5 |
| `XCP_About_S1_Hero_Values.json` | About hero + core values | Step 5 |
| `XCP_About_S2_Pillars_Credentials.json` | About pillars + credentials | Step 5 |
| `XCP_About_S3_Experience_Steps12.json` | About experience + steps 1–2 | Step 5 |
| `XCP_About_S4_Steps34_CTA.json` | About steps 3–4 + CTA | Step 5 |
| `XCP_Services_S1_Hero_Intro.json` | Services hero + intro | Step 5 |
| `XCP_Services_S2_Foundation_Elevation.json` | Services Foundation + Elevation packages | Step 5 |
| `XCP_Services_S3_Transformation_Bespoke.json` | Services Transformation + Bespoke | Step 5 |
| `XCP_Portfolio_P1_Hero_Filter.json` | Portfolio hero + filter tabs | Step 5 |
| `XCP_Portfolio_P2_Gallery_CTA.json` | Portfolio extended gallery | Step 5 |
| `XCP_Blog_S1_Hero_Featured.json` | Blog hero + featured post | Step 5 |
| `XCP_Blog_S2_Grid_Filter.json` | Blog posts grid + filter | Step 5 |
| `XCP_Blog_S3_Newsletter_CTA.json` | Blog newsletter + final CTA | Step 5 |
| `XCP_Contact_P1_Hero.json` | Contact hero | Step 5 |
| `XCP_Contact_P2_Form_Overture.json` | Contact form → Overture | Step 5 |
| `XCP_Contact_P2_Form_Fallback.json` | Contact form → email only | Step 5 |
| `XCP_Contact_P4_CTA.json` | Contact closing CTA | Step 5 |
| `XCP_Booking_S1_Hero_Trust.json` | Booking hero + trust bar | Step 5 |
| `XCP_Booking_S2_Calendar_FAQ.json` | Booking calendar + FAQ | Step 5 |
| `XCP_Booking_S3_CTA.json` | Booking closing CTA | Step 5 |
| `XCP_Coming_Soon_Page.json` | Coming soon + sign-up | Step 14 |

## Blog posts — upload to WordPress

| File | Post title | Step |
|---|---|---|
| `BLOG_Brand_Photography_Brighton_Guide.md` | Brand Photography Guide: Brighton | Step 13 |
| `BLOG_Brand_Photography_ROI.md` | The ROI of Brand Photography | Step 13 |
| `BLOG_5_Signs_New_Brand_Photos.md` | 5 Signs You Need New Brand Photos | Step 13 |
| `BLOG_Corporate_Event_Photography_Guide.md` | Corporate Event Photography Guide | Step 13 |
| `BLOG_Documentary_Business_Photography.md` | Documentary Business Photography | Step 13 |
| `BLOG_10_Brand_Photo_Prep_Tips.md` | 10 Tips for Your Brand Shoot | Step 22 |
| `BLOG_10_Photography_Essentials.md` | 10 Photography Essentials | Step 22 |
| `BLOG_M43_Music_Photography_Gear.md` | Music Photography Gear | Step 22 |
| `BLOG_Home_Studio_Setup.md` | Home Studio Setup | Step 22 |
| `BLOG_Budget_Photography_Upgrades.md` | Budget Photography Upgrades | Step 22 |

## Brand materials — for Adobe Express and desktop

| File | What it contains | When |
|---|---|---|
| `XCP_BRAND_STATIONERY_TEMPLATES.md` | Business card, letterhead, email signature, proposal cover, compliment slip, quote template, LinkedIn banner, Instagram assets — all pre-written for Adobe Express | Anytime |
| `ADOBE_EXPRESS_DESIGN_PROMPTS.md` | AI prompts for brochures, catalogues, flyers | Anytime |

## Images — desktop folder structure

| Folder | What to put in it |
|---|---|
| `images/hero/` | Homepage and page hero backgrounds |
| `images/portfolio/` | Portfolio grid images |
| `images/about/` | About page and process step images |
| `images/services/` | Services page images |
| `images/blog/` | Blog post featured images |
| `images/stationery/` | Logo files (white, dark, SVG versions) |
| `images/social/` | Social media content images |
| `images/partner-logos/` | Client and partner logos (white PNG) |

## Strategy and reference

| File | What it covers |
|---|---|
| `ELEMENTOR_BUILD_GUIDE.md` | Complete technical Elementor reference — when something doesn't work, check here |
| `BLOG_UPLOAD_INSTRUCTIONS.md` | Step-by-step blog publishing with screenshots |
| `LINKEDIN_PROFILE_UPDATED.md` | Complete LinkedIn profile — copy and paste directly |
| `WARM_OUTREACH_TEMPLATES.md` | Every outreach email for every situation |
| `SEO_VISIBILITY_STRATEGY.md` | Full keyword map and SEO blueprint |
| `VISIBILITY_PLAYBOOK.md` | LinkedIn engine and social system |
| `WOOCOMMERCE_INTEGRATION_GUIDE.md` | WooCommerce and Prodigi setup |
| `WOOCOMMERCE_PRODUCT_IMPORT_FAST_TRACK.md` | Fast product import |
| `AMAZON_AFFILIATE_INTEGRATION_DETAILED.md` | Affiliate income setup |
| `WORKSHOPS_EVENTS_STRATEGY.md` | Workshop formats, pricing, venues, marketing |
| `INSTAGRAM_CAROUSEL_TEMPLATES.md` | 10 ready carousel templates |
| `INSTAGRAM_CAROUSEL_SERVICES_SHOWCASE.md` | Services-focused carousel |
| `SITE_ARCHITECTURE.md` | Complete site structure reference |
| `SMUGMUG_SETUP_GUIDE.md` | **Phase 2 only** — portfolio display and client gallery delivery. Do not start until the main site is fully live and generating bookings. |

## Lightroom plugin

| Item | What it does |
|---|---|
| `XCPImageTagger.lrplugin/` | Complete plugin — install directly into Lightroom Classic |
| `XCPImageTagger.lrplugin/README.md` | Full usage guide |

## Lead magnet

| File | What to do with it |
|---|---|
| `XCP_Lead_Magnet_Services_Guide.md` | Convert to PDF → upload to WordPress Media → link in Overture automation (Step 14) |

---

*XC Photography · Xavier Clarke · xcphotography.co · Brighton & London*
*Work the steps. Build the business.*
