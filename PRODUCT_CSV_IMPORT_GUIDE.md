# Product CSV Import Guide - City Spirit Collection
**Fast-Track WooCommerce Product Integration**

**Time Required:** 2-3 hours for complete City Spirit collection setup

**What This Guide Does:**
- Import your CSV product data directly into WooCommerce
- Set up product categories and suppliers automatically
- Configure pricing tiers (Accessible, Brand, Premium)
- Add SEO descriptions and metadata
- Connect products to UK suppliers (The Print Space, UKPrintingCompany, etc.)

---

## Prerequisites

**Required:**
- WooCommerce installed on www.xcphotography.co
- WooCommerce Product CSV Import Suite plugin (free) OR WP All Import (premium)
- Your complete product CSV file
- Product images ready (or placeholder URLs)

**CSV Format Confirmed:**
Your CSV structure is already WooCommerce-compatible with:
- Handle, Title, Description
- Vendor (Supplier name)
- Product Category, Tier
- Variants (Option1 Name/Value)
- SKU, Price, Image URL
- Status (active/draft)
- SEO Description

---

## Step 1: Prepare Your CSV File (15 minutes)

### 1.1 Review Your Current CSV Structure

Your CSV includes:
```csv
Handle,Title,Description,Vendor,Product Category,Tier,Option1 Name,Option1 Value,Variant SKU,Variant Price,Variant Image,Status,SEO Description,Supplier
```

**Collections Identified:**
- City Spirit Wall Art (fine art prints, mounted/unmounted)
- City Spirit Gifts (mugs, blankets, apparel, accessories)

### 1.2 Add WooCommerce Required Columns

Add these columns to your CSV for WooCommerce compatibility:

```csv
Type,Published,Categories,Tags,Tax Status,Tax Class,Stock,Backorders,Weight,Length,Width,Height
```

**Quick fill values:**
- **Type:** `simple` (for single products) or `variable` (for products with size/color options)
- **Published:** `1` (active) or `0` (draft)
- **Categories:** Use your existing "Product Category" value
- **Tax Status:** `taxable`
- **Stock:** `instock` (for print-on-demand) or actual quantity

### 1.3 Map Your CSV to WooCommerce Fields

| Your CSV Column | WooCommerce Field | Notes |
|----------------|-------------------|-------|
| Title | Name | Product title |
| Description | Description | Full product description |
| Variant Price | Regular Price | Your selling price (£) |
| Variant SKU | SKU | Unique product identifier |
| Variant Image | Images | Product photo URL |
| SEO Description | Meta Description | SEO text |
| Vendor/Supplier | Custom Field | Supplier attribution |
| Product Category | Categories | Auto-create categories |
| Tier | Tags | Accessible/Brand/Premium |

---

## Step 2: Install WooCommerce Importer (10 minutes)

### Option A: WooCommerce Built-in Importer (Free, Recommended)

1. **Go to:** WordPress Admin → Products → Import
2. **Upload CSV:** Choose your updated CSV file
3. **Column Mapping:** WooCommerce auto-detects most columns
4. **Run Import:** Click "Run the importer"

### Option B: WP All Import (Premium, More Control)

1. **Install:** Plugins → Add New → Search "WP All Import"
2. **Activate:** WP All Import + WooCommerce Add-On
3. **Import:** All Import → New Import → Upload File
4. **Map Fields:** Drag-and-drop interface for precise control

---

## Step 3: Configure Product Categories (15 minutes)

### 3.1 Create Main Categories

**Navigate to:** Products → Categories

**Create these parent categories:**

1. **City Spirit Wall Art**
   - Slug: `city-spirit-wall-art`
   - Description: "Fine art prints from the City Spirit collection. Museum-grade giclée prints on archival paper, available mounted or unmounted."

2. **City Spirit Gifts**
   - Slug: `city-spirit-gifts`
   - Description: "Premium lifestyle products from the City Spirit collection. Everyday items transformed into narrative pieces."

### 3.2 Create Subcategories

**Under City Spirit Wall Art:**
- Fine Art Prints (Unmounted)
- Fine Art Prints (Mounted)
- Framed Prints
- Canvas Prints

**Under City Spirit Gifts:**
- Mugs & Drinkware
- Home Textiles (blankets, cushions)
- Apparel
- Accessories

### 3.3 Assign Category Images

Upload hero images for each category:
- City Spirit Wall Art: Featured print image
- City Spirit Gifts: Lifestyle product shot

---

## Step 4: Import Products from CSV (30 minutes)

### 4.1 Run the Import

**Using WooCommerce Built-in Importer:**

1. **Upload CSV:** Products → Import → Choose File
2. **Update existing products:** Check this if re-importing
3. **Column Mapping:**
   - Name → Title
   - Description → Description
   - Regular Price → Variant Price
   - SKU → Variant SKU
   - Images → Variant Image (URL)
   - Categories → Product Category
   - Tags → Tier

4. **Review & Import:** Click "Run the importer"
5. **Wait:** Import processes (1-2 minutes per 100 products)
6. **Review:** Check import log for any errors

### 4.2 Handle Product Variants

For products with size options (A4, A3, A2, A1, A0):

**Option 1: Manual Variable Product Setup**
1. Create parent product: "City Spirit Fine Art Print"
2. Add attribute: Size (A4, A3, A2, A1, A0)
3. Create variations with individual prices
4. Assign SKUs to each variation

**Option 2: CSV Variable Product Format**
Create multiple rows for each variation:

```csv
Type,Name,Published,SKU,Regular Price,Attributes: Size
variable,City Spirit Fine Art Print,1,CS-PRT-PARENT,,,
variation,City Spirit Fine Art Print - A4,1,CS-PRT-A4-U,185.00,A4
variation,City Spirit Fine Art Print - A3,1,CS-PRT-A3-U,285.00,A3
```

---

## Step 5: Configure Supplier Integration (20 minutes)

### 5.1 Add Supplier Custom Fields

**Install:** Advanced Custom Fields (ACF) plugin

**Create custom fields for products:**
- Supplier Name (text)
- Supplier URL (URL)
- Production Time (text)
- Fulfillment Method (dropdown: Print-on-Demand / In Stock)

### 5.2 Map Suppliers from CSV

Update your CSV to include supplier details:

| Supplier | Fulfillment | Production Time |
|----------|-------------|-----------------|
| The Print Space | Print-on-Demand | 5-7 business days |
| UKPrintingCompany | Print-on-Demand | 3-5 business days |
| WHCC Europe | Print-on-Demand | 7-10 business days |

### 5.3 Display Supplier Info on Product Pages

Add to your theme's `single-product.php`:

```php
<?php
$supplier = get_field('supplier_name');
$production_time = get_field('production_time');
if ($supplier) {
    echo '<div class="product-supplier">';
    echo '<p><strong>Produced by:</strong> ' . esc_html($supplier) . '</p>';
    echo '<p><strong>Production time:</strong> ' . esc_html($production_time) . '</p>';
    echo '</div>';
}
?>
```

---

## Step 6: Pricing Tiers & Tags (15 minutes)

### 6.1 Create Pricing Tier Tags

**Navigate to:** Products → Tags

**Create tags:**
1. **Accessible** - Entry-level pricing (£35-£95)
2. **Brand** - Mid-tier pricing (£95-£285)
3. **Premium** - High-end pricing (£285+)

### 6.2 Auto-Tag Products by Price

Add this to your theme's `functions.php`:

```php
function auto_assign_pricing_tier($post_id) {
    $product = wc_get_product($post_id);
    if (!$product) return;
    
    $price = $product->get_regular_price();
    
    if ($price < 95) {
        wp_set_object_terms($post_id, 'Accessible', 'product_tag', true);
    } elseif ($price < 285) {
        wp_set_object_terms($post_id, 'Brand', 'product_tag', true);
    } else {
        wp_set_object_terms($post_id, 'Premium', 'product_tag', true);
    }
}
add_action('woocommerce_update_product', 'auto_assign_pricing_tier');
```

---

## Step 7: SEO Optimization (20 minutes)

### 7.1 Install Yoast SEO or Rank Math

**Recommended:** Rank Math SEO (free, WooCommerce integration)

1. **Install:** Plugins → Add New → "Rank Math"
2. **Activate:** Rank Math + WooCommerce module
3. **Configure:** Rank Math → Titles & Meta → Products

### 7.2 Bulk Import SEO Descriptions

Your CSV includes SEO descriptions. Import them using:

**WP All Import:**
- Map "SEO Description" → Rank Math Meta Description
- Map "Title" → SEO Title (auto-generated)
- Map "Product Category" → Focus Keyword

**Manual method:**
Products → Bulk Edit → Select products → Add meta description

### 7.3 SEO-Optimize Product URLs

**Pattern:** `/shop/city-spirit/wall-art/print-a4-unmounted/`

Set in: WooCommerce → Settings → Products → Permalinks
- Product base: `/shop/`
- Product category base: `/shop/%product_cat%/`

---

## Step 8: Product Images Setup (30 minutes)

### 8.1 Image URL Format in CSV

Your CSV uses `[image URL]` placeholders. Replace with actual URLs:

**Format:**
```csv
Variant Image
https://xcphotography.co/wp-content/uploads/city-spirit/CS-PRT-A4-U.jpg
```

**Batch upload:**
1. Upload all product images to: Media Library
2. Use Media Library Assistant plugin to get URLs
3. Copy URLs into CSV "Variant Image" column

### 8.2 Image Requirements

**Optimal sizes:**
- Product images: 1200 x 1200px (square) or 1200 x 1600px (portrait)
- Category images: 1920 x 600px (banner)
- Gallery images: 800 x 800px

**Format:** JPG (photography) or PNG (graphics)
**File size:** <200KB per image (compressed)

### 8.3 Bulk Image Import

**Using WP All Import:**
1. Map "Variant Image" → Images
2. Select "Download images hosted elsewhere"
3. Set image title = Product name
4. Set alt text = SEO description

---

## Step 9: Test & Verify (20 minutes)

### 9.1 Product Page Checklist

Visit 3-5 imported products and verify:

- [ ] Product title displays correctly
- [ ] Description is complete and formatted
- [ ] Price shows in GBP (£)
- [ ] "Add to Cart" button works
- [ ] Product images load
- [ ] Category breadcrumbs work
- [ ] Supplier info displays
- [ ] SEO meta description set
- [ ] Stock status correct

### 9.2 Category Page Check

- [ ] All products appear in correct categories
- [ ] Category descriptions show
- [ ] Filtering works (price, tags)
- [ ] Sorting works (price low-high, newest)

### 9.3 Cart & Checkout Test

1. Add product to cart
2. Proceed to checkout
3. Verify price calculations
4. Test payment gateway (test mode)

---

## Step 10: Finalize & Launch (15 minutes)

### 10.1 Set Up Inventory Management

**For Print-on-Demand products:**
- Stock status: "In Stock"
- Stock management: Disabled
- Backorders: Allow

**For Physical Inventory:**
- Stock management: Enabled
- Stock quantity: Enter actual count
- Low stock threshold: 5 units

### 10.2 Configure Shipping

**Navigate to:** WooCommerce → Settings → Shipping

**Create zones:**
1. **UK Mainland** - Free shipping over £95
2. **UK Highlands & Islands** - £12 flat rate
3. **International** - £25 flat rate

**Add to product pages:**
"Shipping: 5-7 business days (UK), 10-14 days (International)"

### 10.3 Enable Product Reviews

WooCommerce → Settings → Products → Reviews
- [x] Enable product reviews
- [x] Show "verified owner" label
- [x] Reviews can only be left by verified owners

---

## Troubleshooting

### Import Errors

**"SKU already exists"**
- Solution: Add unique prefix to SKUs (e.g., `XCP-CS-PRT-A4-U`)

**"Invalid price format"**
- Solution: Ensure prices use decimal format: `185.00` not `£185`

**"Images not importing"**
- Solution: Check image URLs are direct links (not redirects)
- Verify images are publicly accessible
- Use `.jpg` or `.png` extensions

### Missing Data After Import

**Products imported but no categories:**
- Re-run import with "Update existing products" checked
- Map categories column correctly

**Variations not creating:**
- Switch to "variable" product type
- Create parent product first, then variations

---

## Post-Import Optimization

### Add Cross-Sells & Upsells

For each product, add related products:
- **Cross-sells:** Similar items (other City Spirit prints)
- **Upsells:** Higher-tier versions (A4 → A3 size upgrade)

### Create Product Bundles

**Example bundles:**
- "City Spirit Print + Frame" (save 10%)
- "City Spirit Mug Set" (already in CSV)
- "City Spirit Home Collection" (print + mug + blanket)

### Set Up Discounts

WooCommerce → Coupons:
- `WELCOME10` - 10% off first order
- `CITYSET` - 15% off when buying 3+ City Spirit items
- `BLACKFRIDAY` - 25% off (seasonal)

---

## Quick Reference: CSV Template

```csv
Type,Name,Regular Price,SKU,Categories,Tags,Images,Description,Meta Description,Stock,Vendor
simple,City Spirit Fine Art Print (A4),185.00,CS-PRT-A4-U,City Spirit Wall Art,Accessible,https://...,Archival giclée print...,Part of the City Spirit collection...,instock,The Print Space
simple,City Spirit Mug,45.00,CS-MUG-001,City Spirit Gifts,Brand,https://...,Premium ceramic mug...,A premium ceramic mug from...,instock,UKPrintingCompany
```

---

## Next Steps After Import

1. **Add to homepage:** Feature 3-6 City Spirit products
2. **Create collection page:** Dedicated City Spirit landing page
3. **Set up email marketing:** Welcome series for new customers
4. **Instagram shop:** Tag products in Instagram posts
5. **Google Shopping:** Export products to Google Merchant Center

---

## Files Referenced

- **Shop Setup Guide:** `SHOP_SETUP_COMPLETE_GUIDE.md` (supplier details, pricing strategy)
- **Marketing Templates:** `ADOBE_EXPRESS_TEMPLATES_FINAL.md` (product promotion carousels)
- **Instagram Strategy:** `INSTAGRAM_CAROUSEL_SERVICES_FOCUS.md` (wall art carousel template)

---

## Estimated Timeline

**Day 1 (3 hours):**
- Prepare CSV (30 min)
- Import products (45 min)
- Configure categories (30 min)
- Set up suppliers (30 min)
- Test sample products (45 min)

**Day 2 (2 hours):**
- Upload all product images (60 min)
- SEO optimization (30 min)
- Final testing (30 min)

**Day 3 (1 hour):**
- Launch announcement
- Social media promotion
- Email newsletter

**Total:** 6 hours for complete City Spirit collection integration

---

## Support Resources

**WooCommerce Documentation:**
- Product CSV Import: https://woocommerce.com/document/product-csv-importer-exporter/
- Variable Products: https://woocommerce.com/document/variable-product/

**Your Existing Guides:**
- Premium UK suppliers in SHOP_SETUP_COMPLETE_GUIDE.md
- Product photography in ADOBE_EXPRESS_TEMPLATES_FINAL.md
- Marketing strategy in LINKEDIN_PROFILE_UPDATED.md

---

**Ready to import? Start with Step 1 and work through sequentially. Each step builds on the previous one.**
