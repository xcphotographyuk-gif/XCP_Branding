# XC Photography Shop Setup Guide

**Objective:** Set up WooCommerce shop with print-on-demand products (blankets, prints, canvases) and photography fine art

**Time:** 3-4 hours initial setup | Ongoing product additions

**Expected Revenue:** £500-£2,000/month passive income from existing traffic

---

## Quick Start Checklist

- [ ] Install WooCommerce plugin (10 min)
- [ ] Connect Printify or Gelato (15 min)
- [ ] Import existing products via CSV (20 min)
- [ ] Add photography fine art products (1-2 hours)
- [ ] Configure payment gateway (15 min)
- [ ] Set up shipping zones (20 min)
- [ ] Test checkout process (15 min)
- [ ] Add products to shop page (30 min)

---

## Part 1: WooCommerce Setup

### Install WooCommerce

1. **WordPress Admin → Plugins → Add New**
2. Search "WooCommerce"
3. Click "Install Now" → "Activate"
4. Follow setup wizard:
   - Store Location: UK
   - Currency: GBP (£)
   - Industry: Other
   - Product types: Physical products
   - Business details: Skip for now

### Payment Gateway Setup

**Recommended: Stripe**
- Lower fees than PayPal (1.5% + 20p vs 2.9% + 30p)
- Better checkout experience
- Instant payouts available

**Setup:**
1. WooCommerce → Settings → Payments
2. Enable "Stripe"
3. Click "Manage"
4. Connect Stripe account or create new
5. Enable "Apple Pay" and "Google Pay"

---

## Part 2: Print-on-Demand Integration

### Option A: Printify (Recommended)

**Why Printify:**
- Lower base costs (better margins)
- More UK-based print partners
- 2-4 day UK shipping
- 100+ product types
- Easy WooCommerce integration

**Setup:**
1. Go to https://printify.com
2. Sign up (free plan)
3. Install Printify plugin on WordPress
4. Connect to WooCommerce
5. Select print partner: "SPOKE Custom Products UK" or "Prodigi" for premium quality

**Margins Example:**
- Fleece Blanket 100x150cm: Base cost £25 → Sell £68.99 → Profit £43.99 (64% margin)
- Fleece Blanket 120x175cm: Base cost £28 → Sell £74.99 → Profit £46.99 (63% margin)

### Option B: Gelato

**Why Gelato:**
- Premium quality (better for fine art)
- Faster shipping (24-72 hours)
- More expensive base costs
- Better for high-end products

**Setup:**
1. Go to https://www.gelato.com
2. Sign up for business account
3. Install Gelato plugin
4. Connect WooCommerce
5. Use for premium products only

---

## Part 3: Product Import - Existing Blankets

### Your Current Product Data

From your old shop CSV, you have:
- **Product:** City Spirit - Bond Street Brighton - Polar Blanket
- **Vendor:** UKPrintingCompany
- **Variants:**
  - Size 1: 100cm x 150cm - £68.99
  - Size 2: 120cm x 175cm - £74.99

### WooCommerce CSV Format

I've converted your Shopify CSV to WooCommerce format. Save this as `products_blankets.csv`:

```csv
Type,SKU,Name,Published,Categories,Tags,Short description,Description,Images,Price,Stock,Attribute 1 name,Attribute 1 value(s),Attribute 1 visible,Attribute 1 global
variable,bond-street-blanket-parent,City Spirit - Bond Street Brighton Polar Blanket,1,"Home Decor, Gifts","city-spirit, brighton, blankets, home-decor","Cosy Brighton-inspired polar blanket. Soft, lightweight, perfect for home or picnics.","<p>Wrap yourself in Brighton spirit with this luxurious polar fleece blanket featuring the iconic Bond Street.</p><p>This soft and snuggly blanket is lightweight yet warming, perfect for:</p><ul><li>Cosy evenings at home</li><li>Beach trips and picnics</li><li>Adding character to your space</li><li>Unique gift for Brighton lovers</li></ul><p><strong>Features:</strong></p><ul><li>Premium polar fleece material</li><li>Vibrant, fade-resistant print</li><li>Machine washable</li><li>Lightweight and portable</li></ul>","https://cdn.shopify.com/s/files/1/0568/1817/1952/products/mockup-23269-1660569743124.jpg|https://cdn.shopify.com/s/files/1/0568/1817/1952/products/mockup-23269-112401-1660569734437.jpg",,,Size,"100cm x 150cm, 120cm x 175cm",1,0
variation,UK-1332-23269,City Spirit - Bond Street Brighton Polar Blanket - 100cm x 150cm,1,"Home Decor, Gifts","city-spirit, brighton, blankets","","","",68.99,100,Size,100cm x 150cm,1,0
variation,UK-1333-23269,City Spirit - Bond Street Brighton Polar Blanket - 120cm x 175cm,1,"Home Decor, Gifts","city-spirit, brighton, blankets","","","",74.99,100,Size,120cm x 175cm,1,0
```

### Import Process

1. **WooCommerce → Products → Import**
2. Upload `products_blankets.csv`
3. Map columns:
   - Type → Type
   - SKU → SKU
   - Name → Name
   - Price → Regular price
   - Images → Images
4. **Run the importer**
5. Review products

---

## Part 4: Photography Fine Art Products

### Recommended Product Line

**Prints (Unframed):**
- A4 (21x30cm): £15-£25
- A3 (30x42cm): £25-£45
- A2 (42x59cm): £45-£75
- A1 (59x84cm): £75-£125

**Canvas Prints:**
- 30x40cm: £45-£65
- 40x60cm: £75-£95
- 60x90cm: £125-£175
- 80x120cm: £200-£300

**Framed Prints:**
- A4 framed: £45-£65
- A3 framed: £75-£95
- A2 framed: £125-£175

**Limited Editions:**
- Signed & numbered (edition of 25)
- A3: £95-£150
- A2: £175-£275
- Include certificate of authenticity

### Creating Photography Products in Printify

1. **Printify Dashboard → Catalog**
2. Select product type:
   - Posters (unframed prints)
   - Canvas
   - Framed posters
3. **Upload Your Best Photos:**
   - Concert/music documentary shots
   - Branding session highlights
   - Brighton cityscapes
   - Behind-the-scenes moments
4. **Select Print Partner:**
   - "Prodigi" for premium quality
   - "SPOKE" for budget-friendly
5. **Set Your Prices** (use recommended ranges above)
6. **Publish to WooCommerce**

### Product Collections to Create

**Collection 1: "Brighton Diaries"**
- City Spirit series (Bond Street, North Laine, Beach, Pier)
- 4-6 images
- Available in all print sizes

**Collection 2: "Music & Mayhem"**
- Concert photography highlights
- Limited edition signed prints
- 3-5 iconic moments

**Collection 3: "Brand Stories"**
- Behind-the-scenes from client shoots
- Available as canvas or framed
- Shows your commercial work quality

**Collection 4: "Documentary Moments"**
- Raw, authentic street photography
- Unframed prints only
- More accessible pricing

---

## Part 5: Pricing Strategy

### Current Margins (from your data)

**Fleece Blanket 100x150cm:**
- Your price: £68.99
- Typical base cost: £25-£28
- Your profit: ~£43.99 (64%)
- **Recommendation:** Good margin, keep price

**Fleece Blanket 120x175cm:**
- Your price: £74.99
- Typical base cost: £28-£32
- Your profit: ~£46.99 (63%)
- **Recommendation:** Good margin, keep price

### Improved Product Line Pricing

**Budget Range (High Volume):**
- A4 prints: £15-£20 (50-60% margin)
- Small canvas 30x40cm: £45-£55 (45-55% margin)
- Attract browsers, build email list

**Mid-Range (Best Sellers):**
- A3 prints: £35-£45 (55-65% margin)
- Medium canvas 40x60cm: £85-£95 (50-60% margin)
- Sweet spot for most customers

**Premium (High Margin):**
- A2+ prints framed: £125-£175 (60-70% margin)
- Large canvas 80x120cm: £250-£300 (55-65% margin)
- Limited editions: £150-£275 (70-80% margin)
- For serious collectors and corporate clients

---

## Part 6: Shop Page Setup

### Add Products to Your Shop Page

1. **Edit XCP Main Shop Page in Elementor**
2. **Add Product Grid Widget**
3. **Configure Display:**
   - Products per page: 12
   - Columns: 3 (desktop), 2 (tablet), 1 (mobile)
   - Show: Featured products first
4. **Add Filter Sidebar:**
   - Filter by category
   - Filter by price range
   - Filter by tags

### Create Product Categories

**WordPress → Products → Categories:**

1. **Home Decor**
   - Blankets
   - Cushions (future)
   
2. **Fine Art Prints**
   - Unframed Prints
   - Canvas Prints
   - Framed Prints
   
3. **Collections**
   - Brighton Diaries
   - Music & Mayhem
   - Brand Stories
   - Documentary Moments
   
4. **Limited Editions**
   - Signed Prints
   - Exclusive Collections

### Product Tags

Use existing + add these:
- city-spirit
- brighton
- concert-photography
- documentary
- branding-photography
- limited-edition
- signed-print
- gift-ideas

---

## Part 7: Shipping Configuration

### UK Shipping (Printify Auto-Shipping)

When using Printify/Gelato, shipping is automatic:
- **Free shipping** on orders over £50 (recommended)
- Standard shipping: £4.99 (orders under £50)
- Express shipping: £9.99 (1-2 day delivery)

**Setup:**
1. WooCommerce → Settings → Shipping
2. **Shipping zones:**
   - Zone 1: UK (Free shipping >£50, £4.99 standard)
   - Zone 2: Europe (£12.99)
   - Zone 3: Rest of World (£19.99)

### Print-on-Demand Auto-Fulfillment

**Enable in Printify:**
- Settings → Publishing → Auto-fulfill orders: ON
- This means:
  - Customer orders
  - Payment processes
  - Order auto-sends to Printify
  - They print, ship, send tracking
  - You do nothing except customer service

---

## Part 8: Product Photography Tips

### For Your Fine Art Products

**Image Requirements:**
- **Resolution:** Minimum 2400x3000px (for A2+ prints)
- **Format:** JPEG or PNG
- **Color profile:** sRGB
- **File size:** Under 10MB per image

**Best Images to Sell:**
1. **Strong emotional impact** - Concert moments, raw documentary
2. **Brighton landmarks** - Recognizable locations
3. **Bold compositions** - Clean, striking visuals
4. **Limited edition worthy** - Your absolute best work

**Product Mockups:**
- Use Printify's mockup generator
- Add lifestyle mockups (frame on wall, blanket on couch)
- Show scale with room settings
- 4-6 images per product minimum

---

## Part 9: Marketing Your Shop

### On-Site Promotion

**Homepage:**
- Add "Shop" CTA in hero section
- Featured product carousel
- "New Arrivals" section

**Blog Posts:**
- Link to relevant products inline
- "Shop This Look" sections
- Gift guide blog posts

**Portfolio Pages:**
- "Available as Print" under select images
- Direct links to shop

### Social Media Integration

**Instagram:**
- Tag products in posts
- Instagram Shop integration
- "Shop" highlight reel
- Stories: "Swipe up to shop"

**Pinterest:**
- Create product pins
- "Gift Ideas" boards
- "Home Decor Inspiration" boards
- Links direct to product pages

### Email Marketing

**Abandoned Cart:**
- 1 hour after: "Forgot something?"
- 24 hours: "Still interested?" with 10% off
- 3 days: "Last chance" with free shipping

**Product Launches:**
- New collection announcements
- Limited edition drops
- Seasonal promotions

---

## Part 10: Revenue Projections

### Conservative Estimate (Month 1-3)

**Assumptions:**
- 1,000 monthly website visitors
- 2% shop visit rate = 20 shop visitors
- 5% conversion = 1 sale/month
- Average order value: £75

**Revenue:** £75/month

### Realistic Estimate (Month 4-6)

**With marketing:**
- 2,000 monthly visitors
- 5% shop visit rate = 100 shop visitors
- 10% conversion = 10 sales/month
- Average order value: £85

**Revenue:** £850/month

### Target Estimate (Month 7-12)

**With active promotion:**
- 5,000 monthly visitors
- 8% shop visit rate = 400 shop visitors
- 12% conversion = 48 sales/month
- Average order value: £95

**Revenue:** £4,560/month

---

## Quick Reference: Product Upload Workflow

### For Each New Product

1. **Select best photo** (high resolution)
2. **Upload to Printify** → Choose product type
3. **Position image** on mockup preview
4. **Set pricing** (50-70% margin)
5. **Write description:**
   - Story behind the shot
   - Technical details
   - Size/material info
   - Why it's special
6. **Add 4-6 mockup images**
7. **Categorize and tag**
8. **Publish to WooCommerce**
9. **Review on site**
10. **Promote on socials**

---

## Troubleshooting

### Product Images Not Showing
- Check file size (under 10MB)
- Verify image URL in CSV
- Re-upload via Media Library

### Printify Orders Not Auto-Fulfilling
- Check Printify → Settings → Publishing
- Verify WooCommerce connection
- Ensure payment gateway is active

### Shipping Costs Too High
- Review print partner selection
- Consider UK-based partners only
- Bundle products to increase order value

### Low Conversion Rate
- Improve product photography
- Add customer reviews
- Offer free shipping threshold
- Create urgency (limited stock, seasonal)

---

## Next Steps

**This Week:**
- [ ] Install WooCommerce
- [ ] Connect Printify
- [ ] Import blanket products
- [ ] Add 3-5 photography prints

**Next 2 Weeks:**
- [ ] Create Brighton Diaries collection (6 prints)
- [ ] Add Music & Mayhem collection (4 prints)
- [ ] Set up abandoned cart emails
- [ ] Promote on Instagram stories

**Month 2:**
- [ ] Launch limited edition series
- [ ] Add framed print options
- [ ] Create gift bundles
- [ ] Run first promotion

---

## Files in Repository

**Your Old Shop Data:** Saved in this PR for reference
**WooCommerce CSV:** Ready to import (see Part 3)
**Implementation Guide:** This document

---

## Expected Outcomes

**After 1 week:**
- Functional shop with 8-12 products
- Payment processing active
- First test order completed

**After 1 month:**
- 15-20 products live
- First organic sales
- Email list growing

**After 3 months:**
- 30-40 products
- Consistent sales (8-12/month)
- £600-£1,000/month revenue
- Passive income stream established

---

**Ready to launch?** Start with Part 1 and work through sequentially. Each part builds on the previous, and you'll have a fully functional shop in 3-4 hours.

**Questions?** All product images from your old shop are saved. Print-on-demand means zero inventory risk. You can start with just a few products and scale based on demand.
