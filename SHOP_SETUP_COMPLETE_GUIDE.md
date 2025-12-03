# XC Photography Shop Setup - Complete Implementation Guide

**Objective:** Set up premium photography merchandise shop with print-on-demand fulfillment, including Hotel du Vin collaboration products

**Time Required:** 
- Initial setup: 2-3 hours
- Product creation: 30-45 min per product
- Hotel du Vin strategy: 1-2 hours

---

## Contents
1. [Print-on-Demand Providers Comparison](#print-on-demand-providers)
2. [Product Strategy: Main Shop vs Hotel du Vin](#product-strategy)
3. [WooCommerce Setup & Integration](#woocommerce-setup)
4. [Product Creation Workflow](#product-creation)
5. [Hotel du Vin Partnership Products](#hotel-du-vin-products)
6. [Pricing Strategy for Premium Market](#pricing-strategy)

---

## Print-on-Demand Providers

You have **Printify, Gelato, and Printspace** already set up. Here's the UK premium provider comparison:

### ✅ ALREADY INTEGRATED

#### **1. Printify** (Best for Variety)
- **Quality:** Good-Excellent (varies by print partner)
- **UK Print Partners:** 15+ including premium options
- **Strengths:** 
  - Huge product catalog (900+ items)
  - Multiple print partners to choose from per product
  - Competitive pricing
- **Best For:** Testing different products, bulk variety
- **Margins:** 40-60% typical

#### **2. Gelato** (Best for Premium Quality)
- **Quality:** Excellent-Premium
- **UK Facilities:** 7 production facilities
- **Strengths:**
  - Superior print quality (Gelato+ premium tier)
  - Fast local fulfillment (24-72 hours UK)
  - Eco-friendly (carbon-neutral shipping)
  - Professional photography prints
- **Best For:** Fine art prints, premium products, Hotel du Vin items
- **Margins:** 50-70% typical
- **⭐ RECOMMENDED FOR HOTEL DU VIN PRODUCTS**

#### **3. Printspace** (UK Specialist)
- **Quality:** Premium
- **UK Location:** Based in London
- **Strengths:**
  - UK-focused, fast turnaround
  - High-quality fine art prints
  - Sustainable production
  - Excellent for limited editions
- **Best For:** Fine art photography prints, exhibitions
- **Margins:** 55-75% typical

### 🇬🇧 ADDITIONAL UK PREMIUM PROVIDERS TO CONSIDER

#### **4. Prodigi** (Premium + Sustainable)
- **Quality:** Premium-Luxury
- **Setup:** WooCommerce plugin available
- **Strengths:**
  - Carbon-neutral production
  - Premium packaging options
  - Wide range of luxury products
  - UK production facility
  - Excellent for corporate/B2B gifts
- **Products:**
  - Fine art prints (museum-quality)
  - Luxury home décor
  - Premium apparel
  - Photo books
- **Pricing:** Higher cost, but premium positioning
- **Margins:** 60-80%
- **Setup Time:** 1-2 hours
- **⭐ HIGHLY RECOMMENDED FOR HOTEL DU VIN LUXURY ITEMS**

#### **5. thortful** (UK Greeting Cards + Gifts)
- **Quality:** Premium
- **Setup:** API integration or manual
- **Strengths:**
  - UK-based (Yorkshire)
  - Premium greeting cards & stationery
  - Unique gift items
  - Excellent packaging
- **Products:**
  - Greeting cards (your Brighton/music photography)
  - Notebooks
  - Mugs
  - Coasters
- **Best For:** Gift shop items, Hotel du Vin boutique
- **Margins:** 45-65%

#### **6. The Print Space** (London Premium Lab)
- **Quality:** Museum-quality
- **Setup:** Direct account + manual fulfillment
- **Strengths:**
  - Professional photo lab
  - Giclée fine art prints
  - Premium framing options
  - Trusted by professional photographers
- **Products:**
  - Limited edition prints
  - Canvas wraps
  - Premium framing
- **Best For:** High-value gallery pieces (£200-£2,000)
- **Margins:** 70-85%
- **Note:** Semi-manual (not full automation), best for premium pieces

---

## Product Strategy: Main Shop vs Hotel du Vin

### **Main Shop (www.xcphotography.co/shop)**
**Target:** General public, photography enthusiasts, gift buyers

**Product Categories:**

1. **Art Prints** (Gelato/Printspace)
   - Brighton cityscapes
   - Music photography
   - Documentary series
   - Sizes: A4, A3, A2, A1
   - Price: £35-£150

2. **Home Décor** (Printify/Gelato)
   - Canvas wraps
   - Framed prints
   - Metal prints
   - Acrylic prints
   - Price: £75-£350

3. **Lifestyle Products** (Printify)
   - Tote bags (your photography designs)
   - Cushions
   - Blankets (upgrade from current)
   - Mugs
   - Price: £18-£85

4. **Stationery & Gifts** (thortful/Printify)
   - Greeting cards (Brighton scenes, music)
   - Notebooks
   - Postcards
   - Calendars
   - Price: £3.50-£25

### **Hotel du Vin Collection** (Dedicated Landing Page)
**Target:** Hotel guests, corporate gifts, luxury buyers

**Strategy:** Create a curated "Hotel du Vin Brighton Collaboration" collection featuring:

#### **1. Limited Edition Prints** (Prodigi/Gelato Premium)
- Brighton architectural photography
- Hotel du Vin building portraits
- Sussex countryside
- Vintage Brighton scenes
- **Format:** Numbered editions (1-50)
- **Sizes:** A3, A2 (framed)
- **Price:** £150-£450
- **Placement:** Hotel rooms, corridors, boutique shop

#### **2. Guest Room Products** (Gelato/Prodigi)
- Small framed prints (A4)
- Photo books: "Brighton Through My Lens"
- Postcards (hotel guests take home)
- **Price:** £25-£95
- **Bulk discount for hotel:** 30-40%

#### **3. Corporate Gift Range** (Prodigi Premium)
- Leather-bound photo books
- Premium canvas sets (triptych)
- Branded luxury items
- **Price:** £120-£500
- **For:** Hotel corporate clients, wedding packages

#### **4. Boutique Retail Items** (thortful/Printify)
- Greeting cards (Brighton themes)
- High-quality notebooks
- Tote bags (hotel collaboration branding)
- **Price:** £8-£35
- **Revenue Share:** 40-60% split with hotel

---

## WooCommerce Setup & Integration

### **Step 1: Enable WooCommerce** (5 min)
```
WordPress Dashboard → Plugins → Add New → Search "WooCommerce"
Install → Activate → Run Setup Wizard
```

### **Step 2: Install Print-on-Demand Plugins** (15 min each)

#### **Printify:**
```
1. Go to: wordpress.org/plugins/printify/
2. Install plugin
3. Connect Printify account
4. Sync products
```

#### **Gelato:**
```
1. Go to: wordpress.org/plugins/gelato/
2. Install plugin  
3. Connect Gelato account
4. Enable Gelato+ (premium quality)
5. Set shipping zones
```

#### **Prodigi** (if adding):
```
1. Sign up: prodigi.com
2. WordPress → Plugins → Add New → "Prodigi"
3. API connection via Zapier or custom integration
4. Note: May require developer ($200-400 one-time setup)
```

### **Step 3: Product Categories** (10 min)
```
Products → Categories → Add New:
- Art Prints
- Canvas & Wall Art
- Home Décor
- Stationery & Cards
- Hotel du Vin Collection ⭐
- Limited Editions
```

### **Step 4: Shipping Settings** (15 min)
```
WooCommerce → Settings → Shipping
- Free shipping over £75
- Flat rate UK: £4.95
- International: Calculated by provider
```

---

## Product Creation Workflow

### **Creating Your First Product** (30-45 min per product)

#### **Example: "City Spirit - Bond Street Brighton" Canvas Print**

**Step 1: Choose Provider**
- **Gelato** for premium quality
- Log into Gelato dashboard

**Step 2: Select Product**
- Canvas Wraps
- Size: 30cm x 40cm, 40cm x 50cm, 50cm x 70cm

**Step 3: Upload Artwork**
- Your Bond Street Brighton photo (high-res: 300 DPI minimum)
- Gelato checks quality automatically

**Step 4: Set Pricing**
| Size | Gelato Cost | Your Price | Margin |
|------|-------------|------------|--------|
| 30x40cm | £22 | £65 | £43 (66%) |
| 40x50cm | £28 | £85 | £57 (67%) |
| 50x70cm | £38 | £125 | £87 (70%) |

**Step 5: Product Details**
```
Title: City Spirit - Bond Street Brighton Canvas Print
Description:
Capture the essence of Brighton's creative quarter. 

This museum-quality canvas print features the iconic Bond Street, 
where craft, culture and rebellion converge. Shot on [camera], 
this piece celebrates the raw authenticity of Brighton's artistic soul.

• Premium canvas wrap (1.5" depth)
• Fade-resistant inks
• Ready to hang
• Sustainably produced in UK
• Limited availability

Perfect for: Home office, living room, creative spaces
```

**Step 6: SEO & Tags**
- Tags: Brighton Art, City Photography, Bond Street, Sussex Art
- SEO Title: "Bond Street Brighton Canvas Print | XC Photography"
- Meta: "Museum-quality canvas print of Brighton's creative quarter..."

**Step 7: Sync to WooCommerce**
- Gelato → Push to WooCommerce
- Verify product appears on site
- Check image quality in product gallery

---

## Hotel du Vin Partnership Products

### **Dedicated Landing Page Setup**

#### **Create New Page: "Hotel du Vin Collection"**
```
WordPress → Pages → Add New
- Title: "Hotel du Vin Brighton Collection"
- URL: /hotel-du-vin-collection
- Template: Shop template
```

#### **Page Content Structure:**

```markdown
# The Hotel du Vin Brighton Collection

*An exclusive collaboration celebrating Brighton's iconic Hotel du Vin through photography*

---

## Limited Edition Prints

[Product Grid - 6 items]
- Hotel du Vin Exterior (Evening)
- The Wine Cellar Series  
- Brighton Architecture Collection
- Sussex Countryside Portfolio
Each numbered edition of 50 | From £150

---

## For Hotel Guests

[Product Grid - 4 items]
- Take Home Brighton Postcard Set (£12)
- "Brighton Moments" Photo Book (£45)
- A4 Framed Print (Your Room's View) (£65)

---

## Corporate & Wedding Packages

[CTA Button: "Enquire About Bulk Orders"]
Bespoke photography products for Hotel du Vin events
```

### **Product Examples for Hotel du Vin:**

#### **1. "Hotel du Vin Brighton - Architectural Series" Limited Edition Print**
- **Provider:** Prodigi (premium quality)
- **Format:** A2 Giclée print, museum-quality framing
- **Edition:** 50 numbered prints
- **Price:** £250 (framed), £150 (unframed)
- **Cost:** £45-£80
- **Margin:** £105-£170 (67-70%)
- **Placement:** Hotel boutique, your website, gallery exhibitions

#### **2. "Brighton Guest Book" Photo Collection**
- **Provider:** Prodigi/Printspace
- **Format:** Hardcover photo book, 60 pages
- **Content:** Best of Brighton photography, Hotel du Vin features
- **Price:** £45
- **Bulk (Hotel rooms):** £28 (40% discount for 50+)
- **Margin:** £15-£20 per unit

#### **3. Postcard Set "Brighton Stories"**
- **Provider:** thortful or Printify
- **Format:** Set of 12 postcards
- **Content:** Hotel du Vin, Brighton landmarks, your music photography
- **Price (Retail):** £12
- **Price (Hotel shop):** £8.50 (rev share with hotel)
- **Your Margin:** £4-£5 per set

---

## Pricing Strategy for Premium Market

### **Price Positioning:**

Your work is **premium branding/documentary photography** - price accordingly:

| Product Type | Budget | Standard | Premium | Luxury |
|--------------|--------|----------|---------|--------|
| **Art Prints (unframed)** | £25-£45 | £45-£95 | £95-£200 | £200-£500 |
| **Canvas Wraps** | £55-£85 | £85-£150 | £150-£300 | - |
| **Framed Prints** | £75-£125 | £125-£250 | £250-£600 | £600-£1,500 |
| **Photo Books** | - | £35-£65 | £65-£150 | £150-£400 |
| **Limited Editions** | - | - | £150-£400 | £400-£2,000 |

### **Your Pricing Tiers:**

#### **Tier 1: Accessible** (Main Shop - General Public)
- Small prints (A4): £35-£50
- Lifestyle items: £18-£45
- Cards/Stationery: £3.50-£15
- **Target:** Gift buyers, photography fans

#### **Tier 2: Premium** (Main Shop - Enthusiasts)
- Medium/Large prints (A3-A1): £75-£200
- Canvas wraps: £85-£250
- Framed pieces: £125-£400
- **Target:** Home decorators, art collectors

#### **Tier 3: Luxury** (Hotel du Vin + Gallery)
- Limited editions: £150-£500
- Large framed pieces: £300-£1,200
- Photo books (premium): £65-£150
- Corporate packages: £500-£3,000
- **Target:** Hotel guests, corporate clients, serious collectors

---

## Implementation Checklist

### **Week 1: Foundation** (6-8 hours)
- [ ] Verify WooCommerce installation
- [ ] Connect Printify account
- [ ] Connect Gelato account (enable Gelato+)
- [ ] Connect Printspace account
- [ ] Set up product categories
- [ ] Configure shipping rates
- [ ] Create 3 test products (different providers)
- [ ] Test checkout process

### **Week 2: Main Shop Products** (8-10 hours)
- [ ] Upload 10 high-res photos for products
- [ ] Create 5 Art Print products (various sizes)
- [ ] Create 3 Canvas Wrap products
- [ ] Create 3 Lifestyle products (tote, mug, blanket upgrade)
- [ ] Create 2 Stationery products (cards, notebook)
- [ ] Write compelling product descriptions
- [ ] Optimize product images

### **Week 3: Hotel du Vin Collection** (6-8 hours)
- [ ] Contact Hotel du Vin for collaboration discussion
- [ ] Create dedicated landing page
- [ ] Design 3 limited edition prints
- [ ] Create 2 guest room products
- [ ] Create postcard set
- [ ] Set up revenue share tracking (if applicable)
- [ ] Create Hotel du Vin corporate brochure (PDF)

### **Week 4: Launch & Marketing** (4-6 hours)
- [ ] Add shop to main navigation
- [ ] Link shop from homepage CTA
- [ ] Create Instagram posts announcing shop
- [ ] Email Hotel du Vin partnership proposal
- [ ] Set up Google Shopping feed
- [ ] Create "New Arrival" section

---

## Provider Recommendation Summary

**For Your Needs:**

### **Use Gelato For:**
- ✅ Fine art prints
- ✅ Canvas wraps
- ✅ Hotel du Vin products
- ✅ Premium quality
- **Why:** Best quality-to-price ratio, fast UK shipping, Gelato+ premium tier

### **Use Printify For:**
- ✅ Lifestyle products (mugs, totes, blankets)
- ✅ Testing new products
- ✅ Budget-friendly options
- **Why:** Huge variety, competitive pricing, good for experimentation

### **Use Printspace For:**
- ✅ Limited edition fine art prints
- ✅ Gallery-quality work
- ✅ Special commissions
- **Why:** UK specialist, premium quality, photographer-focused

### **Add Prodigi For:**
- ✅ Hotel du Vin luxury items
- ✅ Corporate gifts
- ✅ Premium packaging
- **Why:** Highest quality tier, luxury positioning, carbon-neutral

---

## Revenue Projections

### **Main Shop (Month 1-3):**
- **Products:** 15-20 SKUs
- **Orders:** 5-15 per month
- **Average Order:** £75-£120
- **Revenue:** £375-£1,800/month
- **Profit (65% margin):** £240-£1,170/month

### **Hotel du Vin (Month 2-6, with partnership):**
- **Bulk order (hotel rooms):** £1,500-£3,000 one-time
- **Boutique retail (monthly):** £200-£600/month
- **Limited editions:** 2-5 sales @ £150-£500 = £300-£2,500/month
- **Profit (70% margin):** £1,400-£4,270 first order + £350-£2,170/month ongoing

### **Combined Annual Potential (Year 1):**
- **Main Shop:** £2,880-£14,040
- **Hotel du Vin:** £5,600-£30,240
- **Total:** £8,480-£44,280
- **Average:** £22,000-£25,000 (realistic with marketing)

---

## Next Actions

**TODAY:**
1. Open Gelato dashboard, create 1 test product (Bond Street canvas)
2. Set pricing: £85-£125 range
3. Sync to WooCommerce
4. Test purchase flow

**THIS WEEK:**
1. Create 5 products across different categories
2. Design Hotel du Vin landing page mockup
3. Draft partnership email to Hotel du Vin manager

**THIS MONTH:**
1. Launch shop with 15-20 products
2. Send Hotel du Vin proposal
3. Post shop launch on Instagram (use "Back to Business" carousel)
4. Add shop CTA to email signature

---

## Hotel du Vin Partnership Proposal Template

```
Subject: Exclusive Photography Collection Proposal - Hotel du Vin Brighton

Dear [Name],

I'm Xavier Clarke, a Brighton-based commercial branding and documentary 
photographer, and I'd like to propose an exclusive collaboration with 
Hotel du Vin Brighton.

**The Concept:**
A curated photography collection celebrating Hotel du Vin and Brighton's 
creative spirit, available as:
- Limited edition prints for hotel décor
- Guest room photography books
- Boutique retail items
- Corporate gift packages

**Benefits for Hotel du Vin:**
• Unique, locally-created art enhancing guest experience
• Revenue share on retail sales (40% to hotel)
• Custom corporate gift options for clients
• Exclusive, numbered editions
• No upfront cost - commission-based partnership

**Portfolio:**
www.xcphotography.co/portfolio

I'd love to discuss this over coffee at the hotel. Are you available 
for a 20-minute meeting next week?

Best regards,
Xavier Clarke
XC Photography
www.xcphotography.co
[phone]
```

---

## Troubleshooting

**Issue: Product images look pixelated**
- Solution: Upload minimum 300 DPI, check Gelato quality checker

**Issue: Margins too low**
- Solution: Increase retail price 15-25%, focus on premium positioning

**Issue: Too many product options overwhelming**
- Solution: Start with 3-5 bestsellers, expand gradually

**Issue: Hotel du Vin doesn't respond**
- Solution: Visit in person, bring portfolio, ask for boutique manager

---

## Success Metrics

Track these monthly:
- [ ] Number of shop visitors
- [ ] Conversion rate (target: 2-5%)
- [ ] Average order value (target: £85+)
- [ ] Best-selling products
- [ ] Customer reviews/feedback
- [ ] Hotel du Vin partnership status
- [ ] Revenue vs. projections

---

**Ready to launch your premium photography shop and Hotel du Vin collection!**
