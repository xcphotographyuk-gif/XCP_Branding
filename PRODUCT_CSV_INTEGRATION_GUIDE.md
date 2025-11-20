# Product CSV Integration Guide - Fast Setup for XC Photography Shop

**Objective:** Import your City Spirit collection products into WooCommerce quickly using CSV, with proper categorization, SEO, and supplier assignments.

**Time Estimate:** 2-3 hours for complete setup

---

## Your Product Data Structure

Based on your CSV, you have:
- **City Spirit Wall Art** - Fine art prints (A4-A0, mounted/framed)
- **City Spirit Gifts** - Mugs, blankets, apparel, accessories

**Suppliers:**
- The Print Space (prints)
- UKPrintingCompany (gifts/merchandise)

---

## Step 1: Prepare Your CSV File (15 minutes)

### Required WooCommerce CSV Columns

Your current CSV has most fields. Here's the complete format needed:

```csv
SKU,Name,Published,Categories,Tags,Short description,Description,Price,Regular price,Stock,Attribute 1 name,Attribute 1 value(s),Images,Vendor,SEO Title,Meta description
```

### Convert Your CSV Format

**Example row transformation:**

**Your format:**
```csv
city-spirit-print-a4-unmounted,City Spirit Fine Art Print (A4, Unmounted),Archival giclée print on museum-grade paper.,The Print Space,City Spirit Wall Art,Accessible,Size,A4,CS-PRT-A4-U,185.00,[image URL],active,"Part of the City Spirit collection by XC Photography...",The Print Space
```

**WooCommerce format:**
```csv
CS-PRT-A4-U,City Spirit Fine Art Print (A4, Unmounted),1,"City Spirit Wall Art > Fine Art Prints","wall art, fine art, A4, Brighton photography","Archival giclée print on museum-grade paper.","Part of the City Spirit collection by XC Photography, each fine art print is produced on archival giclée paper and available framed or unmounted. These collector pieces capture cinematic atmosphere and cultural identity, designed to bring lasting impact to homes, offices, and showrooms.",185.00,185.00,In stock,Size,A4,[image URL],The Print Space,"City Spirit Fine Art Print A4 | XC Photography UK","Museum-grade archival giclée print from the City Spirit collection by XC Photography. A4 size, unmounted. Brighton documentary photography capturing cinematic atmosphere and cultural identity."
```

### Quick Conversion Script (Optional)

If you have many products, save this as `convert_csv.py`:

```python
import csv

input_file = 'your_products.csv'
output_file = 'woocommerce_import.csv'

with open(input_file, 'r') as infile, open(output_file, 'w', newline='') as outfile:
    reader = csv.DictReader(infile)
    fieldnames = ['SKU', 'Name', 'Published', 'Categories', 'Tags', 'Short description', 
                  'Description', 'Price', 'Regular price', 'Stock', 'Attribute 1 name', 
                  'Attribute 1 value(s)', 'Images', 'Vendor', 'SEO Title', 'Meta description']
    writer = csv.DictWriter(outfile, fieldnames=fieldnames)
    writer.writeheader()
    
    for row in reader:
        # Extract product type from category for tags
        tags = f"wall art, {row['Product Category'].lower()}, Brighton photography"
        
        # Create SEO title
        seo_title = f"{row['Title']} | XC Photography UK"
        
        # Convert to WooCommerce format
        woo_row = {
            'SKU': row['Variant SKU'],
            'Name': row['Title'],
            'Published': '1' if row['Status'] == 'active' else '0',
            'Categories': f"{row['Product Category']} > {row['Tier']}",
            'Tags': tags,
            'Short description': row['Description'],
            'Description': row['SEO Description'],
            'Price': row['Variant Price'],
            'Regular price': row['Variant Price'],
            'Stock': 'In stock',
            'Attribute 1 name': row['Option1 Name'],
            'Attribute 1 value(s)': row['Option1 Value'],
            'Images': row['Variant Image'],
            'Vendor': row['Supplier'],
            'SEO Title': seo_title,
            'Meta description': row['SEO Description'][:160]
        }
        writer.writerow(woo_row)
```

Run: `python convert_csv.py`

---

## Step 2: Set Up WooCommerce Product Categories (10 minutes)

### Create Category Hierarchy

**In WordPress Admin → Products → Categories:**

1. **City Spirit Wall Art** (Parent)
   - Fine Art Prints (Child)
   - Framed Art (Child)
   - Canvas Prints (Child)

2. **City Spirit Gifts** (Parent)
   - Mugs & Drinkware (Child)
   - Apparel (Child)
   - Home Decor (Child)
   - Accessories (Child)

3. **By Price Tier** (Parent)
   - Accessible (£35-£95)
   - Brand (£95-£185)
   - Premium (£185-£385)
   - Signature (£385+)

### Category SEO Settings

Use Yoast SEO or Rank Math:

**City Spirit Wall Art:**
- **SEO Title:** City Spirit Fine Art Prints | Brighton Photography | XC Photography UK
- **Meta Description:** Museum-quality fine art prints capturing Brighton's cinematic atmosphere. Archival giclée printing on premium paper, mounted and framed options available.

**City Spirit Gifts:**
- **SEO Title:** City Spirit Collection Gifts | Premium Photography Merchandise | XC Photography
- **Meta Description:** Exclusive City Spirit merchandise featuring Brighton documentary photography. Premium mugs, blankets, apparel, and accessories celebrating craft, culture, and rebellion.

---

## Step 3: Import Products to WooCommerce (30 minutes)

### Method 1: WooCommerce Product CSV Import Suite (Recommended)

1. **WordPress Admin → Tools → Import**
2. **Select "WooCommerce products (CSV)"**
3. **Upload your converted CSV file**
4. **Map columns** (if auto-detection doesn't work):
   - SKU → SKU
   - Name → Product Name
   - Categories → Product Categories
   - etc.
5. **Run import**
6. **Review** - Check for errors in import log

### Method 2: WP All Import Plugin (More Control)

1. **Install WP All Import Pro** (if you have it)
2. **Create New Import → Upload CSV**
3. **Map fields visually:**
   - Drag CSV columns to WooCommerce fields
   - Set up category hierarchy
   - Configure attributes
4. **Run import**

### Common Import Issues & Fixes

**Issue:** Images don't import
- **Fix:** Upload images to WordPress Media Library first, then reference URLs in CSV

**Issue:** Categories create duplicates
- **Fix:** Use exact category names (case-sensitive)

**Issue:** Variations don't link
- **Fix:** Use parent SKU for variable products, child SKU for variations

---

## Step 4: Configure Product Settings (45 minutes)

### For Each Product (or bulk edit):

1. **Inventory Settings:**
   - ✅ Stock status: In stock
   - ✅ Sold individually (for limited editions)

2. **Shipping:**
   - Weight: 0.5kg (prints), 0.3kg (gifts)
   - Dimensions: Actual product size
   - Shipping class: Standard UK / International

3. **Advanced:**
   - Purchase note: "Your City Spirit piece will be printed and dispatched within 3-5 business days."

4. **Product Data:**
   - Virtual: No
   - Downloadable: No

### Bulk Edit Settings

**WordPress Admin → Products → All Products:**
1. **Select all imported products**
2. **Bulk Actions → Edit**
3. **Set:**
   - Tax status: Taxable
   - Tax class: Standard
   - Visibility: Catalog & search
   - Stock status: In stock

---

## Step 5: Set Up Print-on-Demand Integration (60 minutes)

### Option A: Printful/Prodigi Plugin

1. **Install plugin** from WordPress repository
2. **Connect API** (get API key from supplier dashboard)
3. **Map products:**
   - Link WooCommerce SKU to supplier product ID
   - Set mockup images
   - Configure automatic fulfillment

### Option B: Manual Fulfillment Setup

Create **order fulfillment workflow**:

1. **New order received** (WooCommerce email)
2. **Export order details** → Send to The Print Space / UKPrintingCompany
3. **Supplier ships** → Update order status to "Completed"
4. **Customer receives tracking**

**Automate with Zapier:**
- Trigger: New WooCommerce order
- Action: Create order in supplier system (if they have API)

---

## Step 6: Optimize Product Pages (30 minutes)

### SEO Optimization Checklist

**For each product:**

- [ ] **Title:** Include primary keyword (e.g., "City Spirit Fine Art Print A4")
- [ ] **URL slug:** Simple, keyword-rich (e.g., `/city-spirit-print-a4`)
- [ ] **Meta description:** 150-160 characters with CTA
- [ ] **Alt text for images:** Descriptive (e.g., "Brighton street photography fine art print A4 size")
- [ ] **Product description:** 300+ words with:
  - What it is
  - Why it matters
  - Specifications
  - Use cases (home, office, gifting)
  - Your story/vision

### Product Description Template

```markdown
## Transform Your Space with City Spirit

This [PRODUCT NAME] captures [SPECIFIC SCENE/MOOD] from Brighton's urban landscape. Part of the City Spirit collection, each piece tells a story of [THEME].

**Why This Print Matters:**
Your walls aren't just decoration—they're a statement about who you are. This museum-quality giclée print brings cinematic atmosphere and cultural authenticity to your home or office. Whether you're building a brand identity or creating a space that reflects your values, this piece anchors your environment with intention.

**Specifications:**
- Size: [SIZE]
- Medium: Archival giclée print on museum-grade paper
- Finish: [Mounted/Unmounted/Framed]
- Supplier: The Print Space (premium UK printing)
- Shipping: 3-5 business days UK, 7-10 days international

**Perfect For:**
- Home offices that need character
- Creative studios building visual identity
- Thoughtful gifts for discerning clients
- Collectors celebrating craft and culture

**The City Spirit Collection:**
Documentary photography that captures the ordinary and transforms it into the extraordinary. Each frame is an invitation into Brighton's evolving narrative—quiet moments, electrifying energy, craft, culture, and rebellion.

→ **Book a discovery call** to discuss custom prints or exclusive collections: [www.xcphotography.co/services](http://www.xcphotography.co/services)
```

---

## Step 7: Test & Launch (15 minutes)

### Pre-Launch Checklist

- [ ] Test product page display on desktop/mobile
- [ ] Test add-to-cart functionality
- [ ] Complete a test purchase (use Stripe test mode)
- [ ] Verify order confirmation emails
- [ ] Check payment gateway integration
- [ ] Test shipping calculations
- [ ] Review all product images load correctly
- [ ] Verify SEO titles and meta descriptions

### Launch Tasks

1. **Publish all products** (if in draft mode)
2. **Add to navigation menu:**
   - Shop → City Spirit Collection
   - Shop by Category
3. **Create shop page banner/hero:**
   - "City Spirit Collection - Documentary Photography for Your Walls"
4. **Add CTA to homepage:**
   - Link to shop
5. **Social media announcement:**
   - Use ADOBE_EXPRESS_TEMPLATES_FINAL.md templates
   - Post on Instagram: "Shop is live"

---

## Step 8: Product Marketing Integration (30 minutes)

### Link Shop to Instagram Carousels

**Use these completed templates (already created):**
- INSTAGRAM_CAROUSEL_SERVICES_FOCUS.md (Carousel 4: Wall Art & Fine Art)
- ADOBE_EXPRESS_TEMPLATES_FINAL.md (Template 4: Wall Art & Fine Art)

**Instagram Caption Formula:**

```
Your walls speak before you do. 

The City Spirit collection is now live—fine art prints and exclusive gifts that transform spaces and anchor identity. 

From quiet moments to electrifying energy, each piece captures Brighton's evolving narrative. Museum-quality printing. Archival paper. Premium finish.

→ Shop the collection: [link in bio]
→ DM "SHOP" for exclusive early access

#CitySpiritCollection #WallArt #FineArtPhotography #BrightonPhotography #XCPhotography #BrandIdentity #InteriorDesign #PhotographyPrints #HomeDecor
```

### Email Sequence (if you have email list)

**Email 1:** Shop Launch Announcement
**Email 2:** Behind the Scenes - Creating City Spirit
**Email 3:** Customer Spotlight / Use Case
**Email 4:** Limited Time Offer / Exclusive Variant

---

## CSV Import Quick Reference

### Complete WooCommerce CSV Template

Download or create with these exact headers:

```csv
SKU,Name,Published,Categories,Tags,Short description,Description,Price,Regular price,Sale price,Stock,Backorders allowed,Sold individually,Weight (kg),Length (cm),Width (cm),Height (cm),Attribute 1 name,Attribute 1 value(s),Attribute 1 visible,Attribute 1 global,Images,Download limit,Download expiry days,Parent,Grouped products,Upsells,Cross-sells,External URL,Button text,Tax status,Tax class,In stock?,Stock,Low stock amount,Backorders allowed?,Sold individually?,Position,Vendor,SEO Title,Meta description
```

### Sample Complete Row (City Spirit Print A4)

```csv
CS-PRT-A4-U,"City Spirit Fine Art Print (A4, Unmounted)",1,"City Spirit Wall Art > Fine Art Prints","wall art, fine art, A4, Brighton photography, documentary photography, giclée print","Archival giclée print on museum-grade paper.","Transform your space with this City Spirit fine art print capturing Brighton's cinematic atmosphere. Museum-quality giclée printing on archival paper. A4 size, unmounted. Part of the City Spirit collection celebrating craft, culture, and rebellion through documentary photography.",185.00,185.00,,In stock,0,0,0.5,29.7,21,0.5,Size,A4,1,0,https://xcphotography.co/wp-content/uploads/city-spirit-a4.jpg,,,,,,,,,Taxable,Standard,1,,,0,0,0,The Print Space,"City Spirit Fine Art Print A4 | XC Photography UK","Museum-grade archival giclée print from the City Spirit collection by XC Photography. A4 size, unmounted. Brighton documentary photography capturing cinematic atmosphere and cultural identity."
```

---

## Troubleshooting

### Import Failed

1. Check CSV encoding (UTF-8)
2. Verify no extra commas in descriptions
3. Test with 5 products first
4. Check WooCommerce system status for PHP limits

### Images Not Showing

1. Upload to Media Library first
2. Use full image URLs in CSV
3. Check file permissions (uploads folder)

### Categories Not Matching

1. Create categories manually first
2. Use exact names in CSV (case-sensitive)
3. Use " > " for hierarchy (Parent > Child)

### Prices Not Importing

1. Use numbers only (no currency symbols)
2. Use decimal point (185.00 not 185,00)
3. Check WooCommerce currency settings

---

## Next Steps After Import

1. **Review SHOP_SETUP_COMPLETE_GUIDE.md** for ongoing shop management
2. **Create product collections** (Best Sellers, New Arrivals, Gifts)
3. **Set up abandoned cart emails**
4. **Configure shipping zones and rates**
5. **Add product reviews plugin**
6. **Install related products plugin**
7. **Create shop policies** (Returns, Shipping, Privacy)

---

## File References

- **SHOP_SETUP_COMPLETE_GUIDE.md** - Complete e-commerce strategy
- **ADOBE_EXPRESS_TEMPLATES_FINAL.md** - Shop marketing templates
- **INSTAGRAM_CAROUSEL_SERVICES_FOCUS.md** - Wall art carousel content
- **PHOTOGRAPHY_TRAINING_BROCHURES.md** - Cross-sell opportunities

---

**Total Setup Time:** 2-3 hours for complete product import and configuration

**Expected Result:** Fully functional WooCommerce shop with City Spirit collection, SEO-optimized product pages, and integrated marketing strategy ready to launch.
