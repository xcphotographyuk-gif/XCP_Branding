# reCAPTCHA Implementation Guide

## Overview
Google reCAPTCHA v3 has been integrated into the XC Photography contact forms to protect against spam and automated submissions while maintaining a seamless user experience.

## What's Been Added

### Forms with reCAPTCHA Protection
1. **XCP_ContactForm_Section.json** - Main contact form (✅ Updated)
2. **XCP_Contact_P1_Complete.json** - Full contact page (requires manual update if using embedded form)

### reCAPTCHA Configuration Added
```json
{
  "field_type": "recaptcha_v3",
  "field_label": "",
  "field_id": "recaptcha",
  "required": "yes",
  "width": "100"
}
```

Plus form-level settings:
```json
{
  "recaptcha": "yes",
  "recaptcha_site_key": "[YOUR_RECAPTCHA_SITE_KEY]",
  "recaptcha_secret_key": "[YOUR_RECAPTCHA_SECRET_KEY]",
  "recaptcha_version": "v3",
  "recaptcha_badge": "inline"
}
```

## Setup Instructions

### Step 1: Get reCAPTCHA Keys (5 minutes)
1. Go to [Google reCAPTCHA Admin](https://www.google.com/recaptcha/admin)
2. Click **"+"** to create a new site
3. Fill in the form:
   - **Label:** XC Photography Website
   - **reCAPTCHA type:** ✅ reCAPTCHA v3
   - **Domains:** 
     - `xcphotography.co`
     - `www.xcphotography.co`
   - Accept terms and click **Submit**
4. Copy your **Site Key** and **Secret Key**

### Step 2: Configure Elementor Forms (10 minutes)

#### Method A: Using Elementor Pro Form Widget
1. In WordPress admin, go to **Elementor → Settings**
2. Navigate to **Integrations** tab
3. Find **reCAPTCHA** section
4. Paste your **Site Key** and **Secret Key**
5. Select **reCAPTCHA v3**
6. Click **Save Changes**

#### Method B: Manual Form Configuration
If you need to add keys directly to form settings:
1. Edit the contact form page in Elementor
2. Click on the Form widget
3. Go to **Form Fields** tab
4. Scroll to **reCAPTCHA** field (already added)
5. In **Additional Options** → **reCAPTCHA**:
   - Enable: **Yes**
   - Site Key: `[paste your site key]`
   - Secret Key: `[paste your secret key]`
   - Version: **v3**

### Step 3: Update Template Files
Replace placeholder keys in template JSON:
```bash
# Find and replace in templates
[YOUR_RECAPTCHA_SITE_KEY] → your_actual_site_key
[YOUR_RECAPTCHA_SECRET_KEY] → your_actual_secret_key
```

Files to update:
- `XCP_ContactForm_Section.json` (already has placeholders)
- Any custom contact forms you create

### Step 4: Test reCAPTCHA (5 minutes)
1. Visit your contact page: `https://www.xcphotography.co/contact`
2. Fill out the form
3. Look for **reCAPTCHA badge** in bottom-right corner (or inline if configured)
4. Submit the form
5. Check for successful submission

## reCAPTCHA Badge Placement Options

### Option 1: Inline (Recommended)
Badge appears directly in the form:
```json
"recaptcha_badge": "inline"
```
✅ Clear to users
✅ No floating element
❌ Takes up form space

### Option 2: Bottom Right (Default)
Badge floats in bottom-right corner:
```json
"recaptcha_badge": "bottomright"
```
✅ Stays out of the way
❌ May conflict with chat widgets

### Option 3: Bottom Left
```json
"recaptcha_badge": "bottomleft"
```

### Option 4: Hidden (requires terms)
Only use if you display reCAPTCHA terms elsewhere:
```json
"recaptcha_badge": "hide"
```
⚠️ Requires you to include reCAPTCHA terms of service link

## Troubleshooting

### reCAPTCHA Not Appearing
1. ✅ Check that Elementor Pro is installed and activated
2. ✅ Verify keys are correctly entered (no extra spaces)
3. ✅ Ensure domain is added in Google reCAPTCHA console
4. ✅ Clear browser and WordPress cache
5. ✅ Check browser console for errors (F12 → Console tab)

### Form Submission Failing
1. ✅ Check secret key is entered in WordPress (not just site key)
2. ✅ Verify reCAPTCHA v3 is selected (not v2)
3. ✅ Test with incognito/private browsing window
4. ✅ Check PHP error logs for verification failures

### Score Too Low Errors
reCAPTCHA v3 gives a score (0.0-1.0):
- **0.9-1.0:** Very likely human
- **0.5-0.8:** Probably human
- **0.0-0.4:** Likely bot

Adjust threshold in Elementor settings:
- Go to **Elementor → Settings → Integrations**
- Find **reCAPTCHA Score Threshold**
- Default: **0.5** (recommended)
- Lower = more permissive
- Higher = stricter

## Additional Forms to Protect

Consider adding reCAPTCHA to:
1. **Booking forms** (workshops, portraits, retreats)
2. **Product reviews** (if enabled)
3. **Newsletter signup** (if you add one)
4. **Account registration** (if customer accounts enabled)

## Privacy & GDPR Compliance

### Required Disclosure
Add to your Privacy Policy (already included in XCP_Privacy_P1_Policy.json):

> "This site is protected by reCAPTCHA and the Google Privacy Policy and Terms of Service apply."

### Cookie Notice
reCAPTCHA sets cookies. Ensure your cookie consent banner mentions:
- **reCAPTCHA cookies** for spam protection
- Link to [Google Privacy Policy](https://policies.google.com/privacy)

## Alternative: reCAPTCHA v2

If you prefer visible "I'm not a robot" checkbox:

1. In Google reCAPTCHA admin, create new site with **reCAPTCHA v2**
2. In Elementor settings, change to **v2**
3. Users will see checkbox before submitting

**Pros:**
- More obvious to users
- Can be more trustworthy feeling

**Cons:**
- Extra step for users
- Slightly lower conversion

## Testing Checklist

- [ ] reCAPTCHA keys obtained from Google
- [ ] Keys entered in Elementor settings
- [ ] Template placeholders replaced with actual keys
- [ ] Contact form submission tested successfully
- [ ] reCAPTCHA badge visible (or hidden with terms displayed)
- [ ] No console errors
- [ ] Spam submissions are blocked
- [ ] Privacy policy updated with reCAPTCHA disclosure
- [ ] Cookie consent banner mentions reCAPTCHA

## Support

If you encounter issues:
1. **Elementor Support:** [https://elementor.com/help/](https://elementor.com/help/)
2. **Google reCAPTCHA Docs:** [https://developers.google.com/recaptcha](https://developers.google.com/recaptcha)
3. **WordPress Forums:** Search for "Elementor reCAPTCHA"

## Quick Reference: Implementation Status

| Form/Page | reCAPTCHA Status | Notes |
|-----------|------------------|-------|
| Contact Form Section | ✅ Integrated | Placeholders ready for keys |
| Contact Complete Page | ⚠️ Check if uses ContactForm_Section | May need manual update |
| Booking Forms | ⚠️ To be added | Add to WooCommerce forms if needed |
| Thank You Pages | N/A | No forms on these pages |

---

**Last Updated:** November 2025
**Template Version:** v0.4
