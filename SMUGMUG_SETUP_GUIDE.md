# SmugMug Setup Guide
## XCP Photography — HTML Blocks, Selling Strategy, Brand Consistency

---

## Overview: What SmugMug Is Good For

SmugMug is a professional photo hosting and portfolio platform. For XCP Photography it
serves three specific purposes:

1. **Portfolio display** — high-resolution galleries that load fast and look sharp on any screen
2. **Client gallery delivery** — password-protected galleries for delivering work to clients
3. **Print sales** — selling physical prints directly from gallery pages

It works alongside xcphotography.co.uk, not instead of it. Think of it as the gallery
engine that feeds traffic back to the main site for bookings and brand photography services.

---

## Selling Strategy: No PayPal Required

You have two clean routes for selling on SmugMug without using PayPal.

### Option A: SmugMug Native Print Sales (Recommended for prints)

SmugMug's built-in commerce uses **Stripe** as the payment processor. PayPal is optional
and can simply be left disabled. Clients pay by card through Stripe.

**How to enable Stripe only:**
1. SmugMug Account > Selling > Payment Settings
2. Connect your Stripe account
3. Do NOT connect PayPal (leave it blank)
4. Done. Clients see card payment only.

SmugMug handles fulfilment through their partner labs (Bay Photo, WHCC, Miller's Lab).
You set your own markup on top of lab cost prices.

**Best for:** Fine art prints, canvas, framed prints, cards. Physical product sales.

**SmugMug's cut:** They take a percentage of the markup you set. You keep everything above
their base lab price. Set your prices in Gallery Manager > Selling > Price Lists.

---

### Option B: WooCommerce Redirect (Recommended for sessions and digital products)

For booking sessions, digital downloads, and anything that lives in your WooCommerce shop,
use custom HTML buy buttons inside SmugMug pages that send the customer directly to your
WooCommerce product page.

**No SmugMug commission. No PayPal. Payment goes straight through your WooCommerce gateway
(Stripe or whatever you have set up).**

Use this for:
- Brand photography session bookings
- Digital image downloads sold as WooCommerce products
- Gift vouchers
- Anything you want full margin on

---

### Option C: Combined (Best overall approach)

- Physical prints: SmugMug native commerce (Stripe, lab fulfilment handled for you)
- Sessions and digital: WooCommerce redirect buttons in HTML blocks

---

## Colour and Font Reference (Matching xcphotography.co.uk)

These values come directly from the Elementor templates. Use them in all SmugMug custom CSS.

```css
/* XCP Brand Palette */
--xcp-black:  #000000;
--xcp-platinum: #E8E4DC;  /* warm platinum / white gold — accent */
--xcp-white:  #ffffff;
--xcp-grey:   #333333;
--xcp-light:  #f8f8f8;

/* Typography — match with Google Fonts import */
font-family: 'Playfair Display', Georgia, serif;     /* headings */
font-family: 'Lato', 'Helvetica Neue', sans-serif;   /* body */
```

**Google Fonts import for SmugMug custom CSS:**
```css
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Lato:wght@300;400;700&display=swap');
```

Add this to SmugMug Customizer > Advanced > Custom CSS.

---

## SmugMug Custom CSS (Add to Customizer)

Paste this into **Customizer > Advanced > Custom CSS**. It applies brand colours and
typography across all your SmugMug pages.

```css
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Lato:wght@300;400;700&display=swap');

/* Global body */
body {
  font-family: 'Lato', 'Helvetica Neue', sans-serif;
  color: #333333;
  background-color: #000000;
}

/* Headings */
h1, h2, h3, h4 {
  font-family: 'Playfair Display', Georgia, serif;
  color: #ffffff;
  font-weight: 400;
  letter-spacing: 0.02em;
}

/* Navigation */
.sm-nav { background-color: #000000; border-bottom: 1px solid #E8E4DC; }
.sm-nav a { color: #ffffff; font-family: 'Lato', sans-serif; text-transform: uppercase;
  letter-spacing: 0.12em; font-size: 12px; }
.sm-nav a:hover { color: #E8E4DC; }

/* Gallery titles */
.sm-gallery-title { color: #ffffff; font-family: 'Playfair Display', serif; }
.sm-gallery-description { color: #cccccc; font-family: 'Lato', sans-serif;
  line-height: 1.8; }

/* Buy buttons (SmugMug native) */
.sm-buy-btn, .sm-add-to-cart {
  background-color: #E8E4DC !important;
  color: #000000 !important;
  font-family: 'Lato', sans-serif;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  border: none;
  padding: 12px 28px;
}
.sm-buy-btn:hover { background-color: #C8C4B8 !important; }

/* Custom page content */
.sm-custom-page { background-color: #000000; color: #ffffff; }
```

---

## HTML Block 1: Site Header Strip

Paste into a SmugMug Custom Page or at the top of any page using the HTML widget.
This creates a branded strip linking back to the main site.

```html
<div style="background:#000000; border-bottom:1px solid #E8E4DC; padding:16px 40px;
  display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap;
  font-family:'Lato','Helvetica Neue',sans-serif;">

  <div style="color:#ffffff; font-family:'Playfair Display',Georgia,serif;
    font-size:22px; letter-spacing:0.08em;">
    XC Photography
  </div>

  <nav style="display:flex; gap:32px; flex-wrap:wrap;">
    <a href="https://xcphotography.co.uk" target="_blank"
      style="color:#cccccc; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.12em;">Main Site</a>
    <a href="https://xcphotography.co.uk/portfolio" target="_blank"
      style="color:#cccccc; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.12em;">Portfolio</a>
    <a href="https://xcphotography.co.uk/services" target="_blank"
      style="color:#cccccc; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.12em;">Services</a>
    <a href="https://xcphotography.co.uk/contact" target="_blank"
      style="color:#E8E4DC; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.12em; font-weight:700;">Book a Session</a>
  </nav>
</div>
```

---

## HTML Block 2: About / Bio Panel

Use on your SmugMug homepage or About custom page.

```html
<section style="background:#000000; color:#ffffff; padding:80px 40px;
  font-family:'Lato','Helvetica Neue',sans-serif; max-width:900px; margin:0 auto;">

  <p style="color:#E8E4DC; font-size:12px; text-transform:uppercase;
    letter-spacing:0.15em; margin-bottom:16px;">Brand and Documentary Photographer</p>

  <h2 style="font-family:'Playfair Display',Georgia,serif; font-size:36px;
    font-weight:400; line-height:1.3; color:#ffffff; margin:0 0 32px;">
    Who Takes Your Photographs Matters
  </h2>

  <p style="font-size:17px; line-height:1.9; color:#cccccc; margin-bottom:24px;">
    Before I pick up a camera, I need to understand three things: who you actually are,
    who you want to reach, and what it is about you that will make those people stop and
    pay attention. The photograph is the result of that understanding.
  </p>

  <p style="font-size:17px; line-height:1.9; color:#cccccc; margin-bottom:24px;">
    A decade of active visual work across brand photography, documentary, music, and
    portraiture. Work exhibited at the Hotel du Vin Brighton. Pit access at Concorde 2
    for artists including Skunk Anansie, the Beach Boys, and Gomez. The City Spirit
    series, running since 2016, spanning the UK and Europe.
  </p>

  <p style="font-size:17px; line-height:1.9; color:#cccccc; margin-bottom:40px;">
    Based in Brighton. Working across Sussex, London, and the UK.
  </p>

  <a href="https://xcphotography.co.uk/about" target="_blank"
    style="display:inline-block; background:#E8E4DC; color:#000000;
    padding:14px 32px; font-size:13px; text-transform:uppercase;
    letter-spacing:0.12em; text-decoration:none; font-weight:700;">
    Full Story
  </a>
</section>
```

---

## HTML Block 3: WooCommerce Buy Buttons (Sessions and Digital)

Use inside gallery descriptions or on a custom Pricing page. These send customers
directly to your WooCommerce shop. No SmugMug commission.

```html
<div style="background:#111111; border:1px solid #333333; padding:40px;
  font-family:'Lato','Helvetica Neue',sans-serif; max-width:860px; margin:40px auto;
  border-radius:4px;">

  <h3 style="font-family:'Playfair Display',Georgia,serif; font-size:24px;
    font-weight:400; color:#ffffff; margin:0 0 8px;">Book a Session</h3>

  <p style="color:#888888; font-size:14px; margin:0 0 40px; letter-spacing:0.05em;">
    Secure online booking through xcphotography.co.uk
  </p>

  <!-- Brand Foundation -->
  <div style="border-bottom:1px solid #222; padding-bottom:28px; margin-bottom:28px;">
    <div style="display:flex; justify-content:space-between; align-items:flex-start;
      flex-wrap:wrap; gap:16px;">
      <div>
        <p style="color:#E8E4DC; font-size:11px; text-transform:uppercase;
          letter-spacing:0.15em; margin:0 0 6px;">Brand Foundation</p>
        <p style="color:#ffffff; font-size:18px; font-weight:700; margin:0 0 8px;">
          2-Hour Session &nbsp;|&nbsp; 20+ Images</p>
        <p style="color:#888888; font-size:14px; line-height:1.7; margin:0;">
          Headshots, brand context, professional presence.
          Discovery consultation included.
        </p>
      </div>
      <div style="text-align:right; flex-shrink:0;">
        <p style="color:#ffffff; font-size:24px; font-weight:700; margin:0 0 12px;">
          £800</p>
        <a href="https://xcphotography.co.uk/shop/brand-foundation" target="_blank"
          style="display:inline-block; background:#E8E4DC; color:#000000;
          padding:12px 24px; font-size:12px; text-transform:uppercase;
          letter-spacing:0.1em; text-decoration:none; font-weight:700;">
          Book Now
        </a>
      </div>
    </div>
  </div>

  <!-- Brand Elevation -->
  <div style="border-bottom:1px solid #222; padding-bottom:28px; margin-bottom:28px;">
    <div style="display:flex; justify-content:space-between; align-items:flex-start;
      flex-wrap:wrap; gap:16px;">
      <div>
        <p style="color:#E8E4DC; font-size:11px; text-transform:uppercase;
          letter-spacing:0.15em; margin:0 0 6px;">Brand Elevation</p>
        <p style="color:#ffffff; font-size:18px; font-weight:700; margin:0 0 8px;">
          Half Day &nbsp;|&nbsp; 50+ Images</p>
        <p style="color:#888888; font-size:14px; line-height:1.7; margin:0;">
          Multiple setups, locations, and contexts.
          Most popular for established brands.
        </p>
      </div>
      <div style="text-align:right; flex-shrink:0;">
        <p style="color:#ffffff; font-size:24px; font-weight:700; margin:0 0 12px;">
          £1,800</p>
        <a href="https://xcphotography.co.uk/shop/brand-elevation" target="_blank"
          style="display:inline-block; background:#E8E4DC; color:#000000;
          padding:12px 24px; font-size:12px; text-transform:uppercase;
          letter-spacing:0.1em; text-decoration:none; font-weight:700;">
          Book Now
        </a>
      </div>
    </div>
  </div>

  <!-- Brand Transformation -->
  <div>
    <div style="display:flex; justify-content:space-between; align-items:flex-start;
      flex-wrap:wrap; gap:16px;">
      <div>
        <p style="color:#E8E4DC; font-size:11px; text-transform:uppercase;
          letter-spacing:0.15em; margin:0 0 6px;">Brand Transformation</p>
        <p style="color:#ffffff; font-size:18px; font-weight:700; margin:0 0 8px;">
          Full Day+ &nbsp;|&nbsp; 100+ Images</p>
        <p style="color:#888888; font-size:14px; line-height:1.7; margin:0;">
          Complete visual rebrand or content library.
          Multi-location, multi-concept.
        </p>
      </div>
      <div style="text-align:right; flex-shrink:0;">
        <p style="color:#ffffff; font-size:24px; font-weight:700; margin:0 0 12px;">
          £3,500</p>
        <a href="https://xcphotography.co.uk/shop/brand-transformation" target="_blank"
          style="display:inline-block; background:#E8E4DC; color:#000000;
          padding:12px 24px; font-size:12px; text-transform:uppercase;
          letter-spacing:0.1em; text-decoration:none; font-weight:700;">
          Book Now
        </a>
      </div>
    </div>
  </div>

  <p style="color:#555555; font-size:12px; margin-top:32px; text-align:center;">
    Bespoke projects and commissions: contact@xcphotography.co.uk
  </p>
</div>
```

---

## HTML Block 4: Gallery Category Intro

Use at the top of each gallery category (Brand, Music, City Spirit, Documentary).
Edit the title, label, and description per category.

```html
<div style="background:#000000; padding:60px 40px 20px; max-width:900px; margin:0 auto;
  font-family:'Lato','Helvetica Neue',sans-serif; text-align:center;">

  <p style="color:#E8E4DC; font-size:11px; text-transform:uppercase;
    letter-spacing:0.2em; margin-bottom:16px;">XC Photography</p>

  <h1 style="font-family:'Playfair Display',Georgia,serif; font-size:40px;
    font-weight:400; color:#ffffff; line-height:1.3; margin:0 0 20px;">
    Brand Photography
  </h1>
  <!-- Change above to: Music Photography / City Spirit / Documentary -->

  <p style="color:#888888; font-size:16px; line-height:1.8; max-width:640px; margin:0 auto 32px;">
    Commercial brand sessions for businesses, founders, and creative agencies
    across Brighton, Sussex, and the UK. Every image built around
    who you actually are, not a polished version of you.
  </p>
  <!-- Edit this description per gallery category -->

</div>
```

---

## HTML Block 5: Footer Strip

Add at the bottom of every Custom Page.

```html
<footer style="background:#000000; border-top:1px solid #1a1a1a;
  padding:40px; text-align:center; font-family:'Lato','Helvetica Neue',sans-serif;
  margin-top:80px;">

  <p style="font-family:'Playfair Display',Georgia,serif; font-size:18px;
    color:#ffffff; margin:0 0 8px; letter-spacing:0.04em;">XC Photography</p>

  <p style="color:#555555; font-size:13px; margin:0 0 24px;">
    Brand and documentary photography, Brighton.
  </p>

  <div style="display:flex; justify-content:center; gap:32px; flex-wrap:wrap;
    margin-bottom:24px;">
    <a href="https://xcphotography.co.uk" target="_blank"
      style="color:#888888; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.1em;">Main Site</a>
    <a href="https://xcphotography.co.uk/portfolio" target="_blank"
      style="color:#888888; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.1em;">Portfolio</a>
    <a href="https://xcphotography.co.uk/services" target="_blank"
      style="color:#888888; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.1em;">Services</a>
    <a href="https://xcphotography.co.uk/contact" target="_blank"
      style="color:#E8E4DC; text-decoration:none; font-size:12px;
      text-transform:uppercase; letter-spacing:0.1em; font-weight:700;">Book</a>
  </div>

  <p style="color:#333333; font-size:11px; margin:0;">
    &copy; XC Photography. All rights reserved.
  </p>
</footer>
```

---

## SmugMug Page Structure (Recommended)

Set up these pages in your SmugMug site:

| Page | Content | Sells |
|---|---|---|
| **Home** | Header + Bio panel + featured gallery previews | Links to booking |
| **Brand Photography** | Category intro + gallery + WooCommerce buy buttons | Sessions via WooCommerce |
| **Music and Live** | Category intro + gallery | No direct sell (portfolio) |
| **City Spirit** | Category intro + gallery + print buy option | Prints via SmugMug native |
| **Documentary** | Category intro + gallery | Links to main site |
| **Prints** | Gallery with SmugMug print commerce enabled | Prints via SmugMug/Stripe |
| **Book a Session** | Buy buttons block + footer | Sessions via WooCommerce |

---

## Setting Up Print Prices (SmugMug Native Commerce)

1. Go to **Account > Selling > Price Lists**
2. Create a price list called "XCP Standard"
3. Set your prices per product. Example markups:

| Product | Lab Cost (approx) | Your Price | Your Profit |
|---|---|---|---|
| 8x10 Print | £4 | £35 | £31 |
| 12x16 Print | £8 | £65 | £57 |
| 16x20 Print | £14 | £95 | £81 |
| 20x30 Canvas | £28 | £145 | £117 |
| A2 Framed | £35 | £185 | £150 |

4. Assign the price list to each gallery where you want print sales enabled
5. Under Payment: connect Stripe only. Do not add PayPal.

---

## SmugMug SEO Settings (Per Gallery)

Fill in for every gallery you create:

- **Title:** Descriptive + location. Example: "Brand Photography Brighton | XC Photography"
- **Description:** 2 sentences, natural language. Include Brighton/Sussex/UK where relevant.
- **Keywords:** brand photographer brighton, documentary photographer sussex, music photography brighton, etc.
- **URL slug:** keep short and readable. Example: `/brand-photography-brighton`
- **Custom domain:** Point a subdomain like `gallery.xcphotography.co.uk` to SmugMug via DNS.

---

## Connecting SmugMug to the Main Site

### DNS/Subdomain approach (cleanest):
1. In your domain registrar (GoDaddy), add a CNAME record:
   - Name: `gallery`
   - Value: `xcphotography.smugmug.com`
2. In SmugMug: Account > Domain > Add custom domain > `gallery.xcphotography.co.uk`
3. Done. SmugMug galleries now live at `gallery.xcphotography.co.uk`

### Cross-linking:
- Add `gallery.xcphotography.co.uk` link to the main site Portfolio page
- Add the main site link in every SmugMug HTML header block (already done above)
- SmugMug galleries appear in Google image search and drive organic traffic back to the main site

---

## Quick Setup Checklist

- [ ] Choose SmugMug plan (Power or Portfolio recommended for commerce)
- [ ] Connect Stripe account in Selling > Payment
- [ ] Disable / do not connect PayPal
- [ ] Add custom CSS from this guide to Customizer > Advanced
- [ ] Create 4-6 main galleries (Brand, Music, City Spirit, Documentary, Prints)
- [ ] Add HTML Block 1 (header strip) to each Custom Page
- [ ] Add gallery category intro HTML to each gallery description
- [ ] Set up Price List for print sales
- [ ] Set up custom domain (gallery.xcphotography.co.uk)
- [ ] Add SmugMug gallery link to main site Portfolio page
- [ ] Fill in SEO title, description, keywords for every gallery
