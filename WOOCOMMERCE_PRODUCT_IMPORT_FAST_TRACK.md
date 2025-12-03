# WooCommerce Product Import - Fast Track Guide

**Objective:** Import your City Spirit collection products into WooCommerce quickly using your CSV data.

**Time to Complete:** 30-45 minutes

**Prerequisites:**
- WooCommerce plugin installed and activated
- Admin access to WordPress dashboard
- Your product CSV file ready

---

## Your Product CSV Structure

Based on your data, you have:
- **City Spirit Wall Art** - Fine art prints (A4-A0, mounted/framed)
- **City Spirit Gifts** - Mugs, blankets, apparel, accessories

**Suppliers:**
- The Print Space (fine art prints)
- UKPrintingCompany (gifts, apparel)

---

## Step 1: Prepare Your CSV for WooCommerce Import (5 minutes)

WooCommerce requires specific column headers. Here's the mapping:

| Your Column | WooCommerce Column | Notes |
|------------|-------------------|-------|
| Handle | SKU | Unique product identifier |
| Title | Name | Product name |
| Description | Description | Full product description |
| Variant Price | Regular price | Price in £ |
| Variant Image | Images | Image URL |
| Status | Published | 1 for active, 0 for draft |
| SEO Description | Meta: _yoast_wpseo_metadesc | For Yoast SEO |
| Option1 Name | Attribute 1 name | e.g., "Size" |
| Option1 Value | Attribute 1 value(s) | e.g., "A4" |
| Vendor | Meta: _supplier | Custom field for supplier |
| Product Category | Categories | Separate with > for hierarchy |

### Quick CSV Template for Your Products

```csv
SKU,Name,Type,Published,Description,Regular price,Images,Categories,Attribute 1 name,Attribute 1 value(s),Meta: _supplier,Meta: _yoast_wpseo_metadesc
CS-PRT-A4-U,City Spirit Fine Art Print (A4 Unmounted),variable,1,"Archival giclée print on museum-grade paper.",185.00,[image URL],City Spirit Wall Art,Size,A4,The Print Space,"Part of the City Spirit collection by XC Photography, each fine art print is produced on archival giclée paper and available framed or unmounted."
CS-MUG-001,City Spirit Mug,simple,1,"Ceramic mug with City Spirit imagery.",45.00,[image URL],City Spirit Gifts,Size,11oz,UKPrintingCompany,"A premium ceramic mug from the City Spirit collection, blending everyday utility with exclusive imagery."
CS-MUG-SET,City Spirit Mug Gift Set,simple,1,"Set of 4 ceramic mugs in wooden gift box.",145.00,[image URL],City Spirit Gifts,Size,Gift Set,UKPrintingCompany,"Celebrate identity and artistry with the City Spirit Mug Gift Set."
```

### Product Type Guide:
- **Simple** = Single product (mug, blanket, single print size)
- **Variable** = Multiple variants (prints with different sizes A4-A0)

---

## Step 2: Create Product Categories (5 minutes)

**In WordPress Admin:**

1. Go to **Products → Categories**
2. Create main categories:
   - **City Spirit Wall Art**
   - **City Spirit Gifts**
3. Optional sub-categories:
   - Under Wall Art: Fine Art Prints, Framed Prints, Mounted Prints
   - Under Gifts: Mugs, Blankets, Apparel, Accessories

---

## Step 3: Import CSV into WooCommerce (10 minutes)

### Method 1: WooCommerce Built-in Importer (Recommended)

1. **Go to:** Products → Import
2. **Choose file:** Upload your CSV
3. **Column Mapping:**
   - Map your CSV columns to WooCommerce fields
   - Use the mapping table from Step 1
4. **Run Importer**
5. **Review:** Check for errors, fix and re-import if needed

### Method 2: Product Import Export Plugin

If you have many products or complex variations:

1. **Install:** WooCommerce Product Import Export (free plugin)
2. **Import:** Use same CSV format
3. **Advantage:** Better handling of variations and custom fields

---

## Step 4: Set Up Product Variations (For Variable Products) (10 minutes)

For products with multiple options (e.g., print sizes A4, A3, A2, A1, A0):

1. **Create Attributes:**
   - Go to Products → Attributes
   - Add "Size" attribute
   - Add terms: A4, A3, A2, A1, A0

2. **For Each Variable Product:**
   - Edit product
   - Go to Attributes tab
   - Select "Size" attribute
   - Check "Used for variations"
   - Click "Save attributes"
   - Go to Variations tab
   - Click "Add variation" or "Create variations from all attributes"
   - Set price for each size:
     - A4: £185
     - A3: £245
     - A2: £325
     - A1: £425
     - A0: £585

---

## Step 5: Configure Shipping & Suppliers (5 minutes)

### Add Supplier Information

For each product, add supplier as custom field:

1. **Install:** Advanced Custom Fields (free plugin)
2. **Create Field Group:** "Product Supplier Info"
3. **Add Fields:**
   - Supplier Name (text)
   - Supplier Contact (text)
   - Production Time (text)
   - Shipping Method (text)

4. **Assign to Products:**
   - The Print Space products: 3-5 business days production
   - UKPrintingCompany products: 5-7 business days production

### Shipping Zones

1. **Go to:** WooCommerce → Settings → Shipping
2. **Add Zones:**
   - UK Domestic
   - Europe
   - International

3. **Set Rates:**
   - Fine Art Prints: £12 UK, £25 EU, £35 International
   - Gifts: £6 UK, £15 EU, £20 International

---

## Step 6: Optimize Product Pages (5 minutes)

### SEO Setup (Yoast SEO)

For each product:
- **Focus Keyword:** Product name + "City Spirit"
- **Meta Description:** Use your SEO Description from CSV
- **Image Alt Text:** Descriptive, includes "City Spirit" + product type

### Product Gallery Images

1. **Featured Image:** Main product photo
2. **Gallery Images:**
   - Lifestyle shots (product in situ)
   - Detail shots
   - Size comparison (for prints)
   - Packaging (for gifts)

---

## Step 7: Test & Launch (5 minutes)

### Pre-Launch Checklist

- [ ] All products imported successfully
- [ ] Prices correct (including VAT if applicable)
- [ ] Images displaying properly
- [ ] Product descriptions complete
- [ ] Variations working (for variable products)
- [ ] Shipping zones configured
- [ ] Test order placed successfully
- [ ] Payment gateway connected
- [ ] SSL certificate active (https://)

### Test Purchase

1. Add product to cart
2. Go through checkout
3. Use test payment (Stripe test mode)
4. Check order confirmation email
5. Verify order in WordPress admin

---

## Fast Track: CSV Import Command (Advanced)

If you're comfortable with WP-CLI:

```bash
# Upload CSV to server
# SSH into server
wp wc product import products.csv --user=admin

# Or with mapping
wp wc product import products.csv --user=admin --map='{"Handle":"SKU","Title":"Name"}'
```

---

## Troubleshooting

### Common Issues:

**Images not importing:**
- Ensure image URLs are publicly accessible
- Use direct image URLs (not Dropbox/Google Drive share links)
- Upload images to WordPress Media Library first, then use those URLs

**Variations not creating:**
- Ensure product Type is set to "variable"
- Check attribute names are exact match
- Create attributes in WordPress before import

**Prices showing wrong:**
- Check decimal separator (use . not ,)
- Ensure no currency symbols in CSV
- Set WooCommerce currency to GBP in settings

**Supplier field not showing:**
- Install Advanced Custom Fields plugin
- Create custom field group for products
- Manually add supplier info post-import

---

## Post-Import: Enhanced Product Setup

### Add Cross-Sells & Upsells

For each product, suggest:
- **Cross-sells:** Related products (mug + blanket)
- **Upsells:** Larger size (A4 → A3 print)

### Product Bundles

Create bundled offers:
- Print + Frame combo (save £50)
- Gift Set collections
- Workshop + Print package

### Inventory Management

Set stock levels:
- **Print on Demand:** Set as "In Stock" always
- **Limited Editions:** Set actual stock quantity
- **Pre-orders:** Use pre-order plugin

---

## Integration with Suppliers

### The Print Space Integration

**API Option:** Use their API for automated order fulfillment
**Manual Option:** Email orders daily, update tracking manually

**Setup:**
1. Create The Print Space account
2. Get API credentials
3. Install WooCommerce Print Provider plugin
4. Connect account
5. Map products to Print Space SKUs

### UKPrintingCompany Integration

Similar process - check if they offer:
- API integration
- CSV order export
- Printful/Printify compatibility

---

## Revenue Optimization

### Pricing Strategy

**City Spirit Wall Art:**
- A4 Unmounted: £185 (Cost: £65, Margin: 65%)
- A4 Mounted: £245 (Cost: £85, Margin: 65%)
- A4 Framed: £325 (Cost: £125, Margin: 62%)

**City Spirit Gifts:**
- Mug: £45 (Cost: £15, Margin: 67%)
- Mug Set: £145 (£36.25/mug, Cost: £55, Margin: 62%)
- Blanket: £85 (Cost: £30, Margin: 65%)

### Conversion Optimization

**Product Page Elements:**
- High-quality images (minimum 1500px)
- Detailed descriptions (200+ words)
- Customer reviews section
- Size guide (for prints)
- "Why This Matters" section
- Free UK shipping over £100 banner
- 30-day return policy badge

**Call-to-Actions:**
- "Add to Cart" (primary)
- "Request Custom Size" (for bespoke orders)
- "See in Your Space" (AR preview if possible)
- "Gift This" (gift wrapping option)

---

## Next Steps After Import

1. **Set up email automation:**
   - Order confirmation
   - Dispatch notification
   - Delivery confirmation
   - Review request (7 days post-delivery)

2. **Create shop page:**
   - Featured products slider
   - Category navigation
   - Filter by price/size
   - Search functionality

3. **Marketing integration:**
   - Add products to Instagram Shopping
   - Create Facebook catalog
   - Set up Google Shopping feed
   - Add to Pinterest Rich Pins

4. **Analytics setup:**
   - Google Analytics ecommerce tracking
   - Facebook Pixel
   - Track conversion rates by product
   - Monitor cart abandonment

---

## Support Resources

**WooCommerce Documentation:**
- https://woocommerce.com/documentation/

**CSV Import Guide:**
- https://woocommerce.com/document/product-csv-importer-exporter/

**Your Existing Guides:**
- SHOP_SETUP_COMPLETE_GUIDE.md (detailed supplier info)
- Premium UK suppliers and pricing strategies

---

## Estimated Timeline

**Today (Total: 2-3 hours)**
- CSV prep: 30 min
- Import: 30 min
- Variations setup: 45 min
- Testing: 30 min
- Fine-tuning: 30 min

**This Week**
- Add all product images
- Write enhanced descriptions
- Set up supplier integrations
- Configure email templates

**This Month**
- Launch marketing campaigns
- Collect first reviews
- Optimize based on analytics
- Expand product range

---

**Ready to import? Your CSV structure is solid - just map the columns correctly and you'll have products live within the hour.**
