# WooCommerce Product CSV Integration Guide
## Complete Shop Setup with Your Product Data

**Time Required:** 2-3 hours for complete setup
**Difficulty:** Beginner-friendly with step-by-step instructions

---

## What You'll Accomplish

- Import all your existing products into WooCommerce
- Set up product categories and collections (City Spirit, Fine Art, Gifts)
- Configure pricing, descriptions, and images
- Integrate with print-on-demand suppliers
- Launch your shop ready for Black Friday

---

## STEP 1: Prepare Your CSV File (15 minutes)

### Your Current CSV Structure
You have products in this format:
```
Handle,Title,Description,Vendor,Product Category,Tier,Option1 Name,Option1 Value,Variant SKU,Variant Price,Variant Image,Status,SEO Description,Supplier
```

### Convert to WooCommerce Format

**Option A: Use the Pre-Converted File (Easiest)**
I've already created `SHOP_PRODUCTS_CSV_WOOCOMMERCE.csv` with your products in WooCommerce format.

**Option B: Convert Your CSV**
If you have additional products in your original format, use this conversion guide:

1. **Open your CSV in Excel or Google Sheets**
2. **Add these WooCommerce required columns:**
   - `Type` (all "simple" for now)
   - `SKU` (your Variant SKU)
   - `Name` (your Title)
   - `Published` (1 for active, 0 for draft)
   - `Regular price` (your Variant Price)
   - `Categories` (your Product Category)
   - `Short description` (first 2 sentences of Description)
   - `Description` (full Description with HTML)
   - `Images` (your Variant Image URL)

3. **Save as CSV (UTF-8)**

---

## STEP 2: Install WooCommerce (10 minutes)

### If WooCommerce is Not Installed:

1. **WordPress Dashboard** → **Plugins** → **Add New**
2. **Search:** "WooCommerce"
3. **Click:** "Install Now" → "Activate"
4. **Follow Setup Wizard:**
   - Store Address: Brighton, UK
   - Currency: GBP (£)
   - Shipping: UK-wide + International
   - Tax: Enable UK VAT (if applicable - check with accountant)
   - Payment: Stripe + PayPal (recommended)

5. **Skip:** Creating products (we'll import instead)

### If WooCommerce is Already Installed:
- Skip to Step 3

---

## STEP 3: Set Up Product Categories (10 minutes)

Before importing, create your product categories:

1. **WordPress Dashboard** → **Products** → **Categories**

2. **Create These Categories:**

### Main Categories:
- **Fine Art Prints** (slug: `fine-art-prints`)
  - Description: "Museum-quality photography prints on archival paper. Signed, numbered, investment pieces."
  
- **Canvas & Wall Art** (slug: `canvas-wall-art`)
  - Description: "Ready-to-hang gallery wraps and framed prints. Transform your space with cinematic imagery."
  
- **City Spirit Collection** (slug: `city-spirit`)
  - Description: "Exclusive collection celebrating Brighton's urban character. Limited edition prints and lifestyle products."
  
- **Home Decor** (slug: `home-decor`)
  - Description: "Curated home accessories featuring Xavier Clarke photography. Blankets, cushions, and lifestyle pieces."
  
- **Gifts & Accessories** (slug: `gifts`)
  - Description: "Unique photography gifts perfect for art lovers, Brighton enthusiasts, and creative professionals."
  
- **Brand Photography** (slug: `brand-photography`)
  - Description: "Portfolio books and digital packages from your brand photography sessions."
  
- **Limited Editions** (slug: `limited-editions`)
  - Description: "Collector pieces with certificates of authenticity. Maximum 25 prints per edition."

3. **Click "Add New Category"** for each
4. **Save**

---

## STEP 4: Import Your Products (20 minutes)

### Using WooCommerce Product Import Tool

1. **WordPress Dashboard** → **Products** → **Import**

2. **Upload CSV:**
   - Click "Choose File"
   - Select `SHOP_PRODUCTS_CSV_WOOCOMMERCE.csv`
   - Click "Continue"

3. **Map Columns:**
   WooCommerce will try to auto-map. Verify:
   - `SKU` → SKU
   - `Name` → Name
   - `Regular price` → Regular price
   - `Categories` → Categories
   - `Images` → Images
   - `Description` → Description
   - `Short description` → Short description
   - `Published` → Published
   - `Type` → Type
   - `Tags` → Tags

4. **Update Existing Products:**
   - Select: "Don't update existing products"
   - (Unless you're re-importing)

5. **Click "Run the importer"**

6. **Wait for completion** (2-5 minutes depending on number of products)

7. **Review Import Results:**
   - Products imported: [number]
   - Products skipped: [number]
   - Products updated: [number]

---

## STEP 5: Configure Product Images (30-45 minutes)

### Image Setup Options

**Option A: Import with URLs (If images are already hosted)**
- CSV already includes image URLs
- WooCommerce will download and attach them automatically
- **This should work if your CSV has valid image URLs**

**Option B: Manual Upload (If CSV import didn't grab images)**

1. **For Each Product:**
   - Products → All Products
   - Click product name
   - Scroll to "Product Image"
   - Click "Set product image"
   - Upload or select from Media Library
   - Add "Product Gallery" images (multiple angles)
   - Update

2. **Bulk Image Upload Tip:**
   - Media → Add New
   - Upload all product images at once
   - Then assign to products individually

**Option C: Use Auto-Upload Plugin (Fastest for many products)**
- Install plugin: "Import External Images"
- Run on all products to download images from URLs
- WordPress Dashboard → Media → Import Images

---

## STEP 6: Set Up Print-on-Demand Integration (30 minutes)

### Connect Your Suppliers

You mentioned Gelato, Printify, and Printspace. Here's how to integrate:

#### **For Printify:**

1. **Install Printify Plugin:**
   - Plugins → Add New
   - Search "Printify"
   - Install & Activate

2. **Connect Account:**
   - Printify Settings
   - Enter API Key (get from printify.com dashboard)
   - Test connection

3. **Link Products:**
   - Products → Printify Products
   - For each product, select matching WooCommerce product
   - Set "Publish to Store" when order received

#### **For Gelato:**

1. **Install Gelato Plugin:**
   - Plugins → Add New
   - Search "Gelato"
   - Install & Activate

2. **Connect Account:**
   - Gelato → Settings
   - API Authorization
   - Connect WooCommerce store

3. **Sync Products:**
   - Recommended for Fine Art Prints and Hotel du Vin items
   - Higher quality, premium pricing

#### **For Printspace (Manual Integration):**

1. **Set up Email Automation:**
   - Use WooCommerce → Settings → Emails
   - Forward order notifications to printspace@email.com
   - Include: SKU, quantity, shipping address

2. **Or Use Zapier:**
   - WooCommerce → Printspace automation
   - Trigger: New WooCommerce Order
   - Action: Create Printspace Order

---

## STEP 7: Configure Pricing & Shipping (20 minutes)

### Set Your Margins

Based on your CSV, you have products ranging £45-£295. Here's the pricing check:

1. **Review Each Product Category:**
   - **Fine Art Prints (A4):** £45 (good entry point)
   - **Fine Art Prints (A3):** £65 (good step-up)
   - **Canvas Wraps:** £120 (competitive for 20x30")
   - **Metal Prints:** £140 (premium positioning)
   - **Framed Prints:** £95 (excellent value)
   - **Acrylic (Luxury):** £295 (premium, limited edition)
   - **Photo Books:** £125 (add-on to sessions)
   - **Digital Packs:** £250 (session add-on)

2. **Verify Supplier Costs:**
   - Login to Printify/Gelato
   - Check production cost for each product
   - Ensure minimum 50% margin (60-70% ideal)

3. **Example Margin Calculation:**
   ```
   Canvas 20x30"
   Your Price: £120
   Supplier Cost: £35-45
   Your Margin: £75-85 (63-71%)
   ✅ Good margin for premium positioning
   ```

### Set Up Shipping

1. **WooCommerce → Settings → Shipping**

2. **Create Shipping Zones:**

   **Zone 1: UK**
   - Free shipping over £100
   - Flat rate £7.95 under £100
   - Local pickup (Brighton) - Free

   **Zone 2: Europe**
   - Flat rate £15.00
   - Free over £200

   **Zone 3: Rest of World**
   - Flat rate £25.00
   - Free over £300

3. **For Print-on-Demand:**
   - Most suppliers (Gelato/Printify) include shipping in product cost
   - Your shipping fees go to you as additional margin
   - Or offer free shipping and increase product price by £8-10

---

## STEP 8: Add Product Variants (If Needed)

### For Products with Multiple Options

Example: Fine Art Prints in different sizes

**Option A: Keep as Separate Products (Easiest - Your Current Setup)**
- City Spirit Print A4 - £45
- City Spirit Print A3 - £65
- City Spirit Print A2 - £85
- ✅ **This is what you have now - keep it**

**Option B: Convert to Variable Product (More Complex)**
Only if you want dropdown selectors:

1. **Edit Product**
2. **Product Data:** Change from "Simple" to "Variable"
3. **Attributes Tab:**
   - Add: "Size"
   - Values: A4 | A3 | A2
   - Check "Used for variations"
4. **Variations Tab:**
   - Generate variations
   - Set price for each
   - Set SKU for each

**Recommendation:** Keep separate products for now (simpler inventory)

---

## STEP 9: Test Your Shop (15 minutes)

### Pre-Launch Checklist

1. **Test Purchase Flow:**
   - [ ] Visit shop page: `yoursite.com/shop`
   - [ ] Browse categories work
   - [ ] Product images load
   - [ ] Add to cart works
   - [ ] Checkout flow smooth
   - [ ] Payment gateway active

2. **Test Payment:**
   - Enable Stripe/PayPal test mode
   - Make test purchase (£1)
   - Verify order appears in dashboard
   - Check email notifications sent

3. **Test on Mobile:**
   - Product pages responsive
   - Images display correctly
   - Checkout works on phone

4. **Check Product Pages SEO:**
   - Each product has SEO description
   - Images have alt text
   - URLs are clean (slug-based)

---

## STEP 10: Launch & Promote (Ongoing)

### Black Friday Launch Strategy

**Before Launch (This Week):**
- [ ] Import all products ✓
- [ ] Set up categories ✓
- [ ] Configure payment ✓
- [ ] Test checkout ✓
- [ ] Create "New Arrivals" collection
- [ ] Set up email capture popup

**Black Friday Week:**
- [ ] Create 20% off sitewide code: `BLACKFRIDAY2024`
- [ ] Add banner to homepage: "Black Friday Sale - 20% Off All Wall Art"
- [ ] Instagram posts with product photos + swipe-up to shop
- [ ] Email blast to existing contacts
- [ ] Pin products in Instagram stories

**Post-Launch:**
- [ ] Monitor orders daily
- [ ] Forward to print-on-demand suppliers
- [ ] Track shipping
- [ ] Request reviews after delivery
- [ ] Create "Customer Favorites" collection

---

## STEP 11: Optimize Collections (20 minutes)

### Create Strategic Product Collections

1. **WordPress → Products → Categories** (or use plugin "Product Collections")

2. **Create These Collections:**

   **"Gift Guide" (For Holiday Shopping)**
   - City Spirit Mugs
   - Blankets
   - Framed Prints under £100
   - Photo Books

   **"Hotel du Vin Exclusive"**
   - Acrylic Prints
   - Large Canvas (30x40"+)
   - Framed Limited Editions
   - Price: £200-800

   **"Wall Art Under £100"**
   - Small canvas
   - Framed A4/A3
   - Metal 12x16"
   - Good entry point

   **"Limited Edition Collectors"**
   - Numbered prints
   - Certificate of authenticity
   - Acrylic face mounts
   - Investment pieces

3. **Feature on Homepage:**
   - Use Elementor "Product Grid" widget
   - Show "Featured Products"
   - Link to each collection

---

## TROUBLESHOOTING

### Issue: Images Won't Import
**Solution:**
- Check image URLs are publicly accessible
- Download images locally
- Upload via Media Library
- Assign to products manually

### Issue: Products Show "Out of Stock"
**Solution:**
- Edit product
- Inventory tab
- Check "Stock status: In stock"
- **For print-on-demand: Always set "In stock"** (infinite inventory)

### Issue: Wrong Currency Showing
**Solution:**
- WooCommerce → Settings → General
- Currency: GBP (£)
- Position: Left (£99.00)
- Decimal Separator: .
- Save changes

### Issue: Checkout Not Working
**Solution:**
- WooCommerce → Settings → Payments
- Enable at least Stripe OR PayPal
- Test mode ON for testing
- Test mode OFF for live sales

### Issue: Print-on-Demand Orders Not Sending
**Solution:**
- Check plugin is connected
- Verify API keys
- Enable "Auto-publish" in plugin settings
- Manually push order if needed

---

## NEXT STEPS AFTER SHOP IS LIVE

### Week 1: Launch & Monitor
- Post 3x daily on Instagram with product tags
- Email announcement to list
- Monitor orders and respond quickly

### Week 2: Optimize
- Check Google Analytics: which products viewed most
- Add more photos to top products
- Create bundles (3 prints for price of 2)
- Add reviews section

### Week 3: Scale
- Launch Hotel du Vin collection
- Contact hotels for wholesale
- Create corporate gifting packages
- Pitch to interior designers

### Month 2+
- SEO optimize product descriptions
- Run Google Shopping ads
- Partner with Brighton Tourism
- Launch subscription: "Print of the Month Club"

---

## REVENUE PROJECTIONS

Based on your pricing and market:

### Conservative (Month 1-3):
- 15-20 orders/month
- Average order: £85
- Revenue: £1,275-1,700/month
- Profit (60% margin): £765-1,020/month

### Growth (Month 4-6):
- 30-40 orders/month
- Average order: £95
- Revenue: £2,850-3,800/month
- Profit: £1,710-2,280/month

### Established (Month 7-12):
- 50-70 orders/month
- Average order: £110
- Revenue: £5,500-7,700/month
- Profit: £3,300-4,620/month

### Hotel du Vin Partnership:
- 5-10 orders/month
- Average order: £400
- Additional revenue: £2,000-4,000/month

**Total Potential Year 1: £20,000-40,000 in shop revenue**

---

## QUICK START CHECKLIST

**Today (2-3 hours):**
- [ ] Create product categories in WooCommerce
- [ ] Import SHOP_PRODUCTS_CSV_WOOCOMMERCE.csv
- [ ] Verify all products imported correctly
- [ ] Upload/assign product images
- [ ] Configure shipping zones
- [ ] Enable Stripe/PayPal payments

**Tomorrow (1-2 hours):**
- [ ] Test full purchase flow
- [ ] Connect print-on-demand suppliers
- [ ] Create discount codes
- [ ] Set up product collections
- [ ] Add shop page to main menu

**This Week:**
- [ ] Instagram posts announcing shop
- [ ] Email blast to contacts
- [ ] Add product widgets to homepage
- [ ] Launch Black Friday sale

---

## SUPPORT RESOURCES

**WooCommerce Documentation:**
- Product Import: https://woocommerce.com/document/product-csv-importer-exporter/
- Payment Setup: https://woocommerce.com/document/payments/

**Print-on-Demand:**
- Printify WooCommerce: https://printify.com/app/integrations/woocommerce
- Gelato Integration: https://www.gelato.com/integrations/woocommerce

**Need Help?**
- WooCommerce Support: woocommerce.com/support
- WordPress Forums: wordpress.org/support

---

## FILES YOU NEED

1. **SHOP_PRODUCTS_CSV_WOOCOMMERCE.csv** - Your products ready to import
2. **SHOP_SETUP_COMPLETE_GUIDE.md** - Print-on-demand supplier details
3. **WOOCOMMERCE_INTEGRATION_GUIDE.md** - Additional setup help

**Your products are ready to import. Start with Step 2 above and you'll be live by this afternoon.**

Let's get your shop launched! 🚀
