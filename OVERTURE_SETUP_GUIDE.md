# 🔑 Overture CRM — Contact Form Setup Guide

**The single reference for connecting your XCP contact form to Overture.**

---

## ⚡ Quick Summary

The JSON template (`XCP_Contact_P2_Form_Overture.json`) has **everything pre-built**:
- ✅ Webhook URL: `https://xcphotography.overturehq.com/api/bookings`
- ✅ Authorization header structure: pre-set, placeholder only
- ✅ All field IDs mapped to Overture API field names

**After importing, you do ONE thing: replace `YOUR_OVERTURE_API_KEY` with your actual key.**

---

## 🚨 Security Warning — Read First

**Never put your Overture API key in a hidden form field.**

Hidden form fields are written into the page's HTML source code. Anyone can right-click → View Source and read the key. The `Authorization` header must be set in **Additional Options → Custom Headers** inside the form widget — not as a form field.

If you have already added an Authorization **hidden field**:

1. **Go to Overture → Settings → Integrations → API Keys → regenerate/revoke that key immediately.** The old key is now public.
2. Remove that hidden field (see Step 2 below).
3. Follow Step 3 to set it correctly.

---

## Step 1 — Import the form JSON

Import `XCP_Contact_P2_Form_Overture.json` on your Contact page.

The webhook URL is pre-set to `https://xcphotography.overturehq.com/api/bookings` and the Authorization header structure is included — it just needs your real key.

---

## Step 2 — Remove any incorrect Authorization hidden field

If your form currently has a hidden field labelled **Authorization**:

1. Open the page in Elementor
2. Click the form widget
3. Go to **Content** tab → scroll to **Form Fields**
4. Find the field with Label: `Authorization` and Type: `Hidden`
5. Click the **×** (delete) icon on that field row
6. Click **Update**

> The JSON template does not include an Authorization hidden field. If you re-import fresh, this problem will not exist.

---

## Step 3 — Add your API key securely

The API key goes in the form widget's **Custom Headers** — not in a form field. Choose the method that matches your setup.

> **Can't find Custom Headers in your Elementor?** This UI only appears in Elementor Pro 3.5 or later. If you do not see it, skip Method A entirely and go straight to **Method B** (WPCode snippet) — it works on all Elementor versions and is equally secure.

### Method A — Elementor Additional Options → Custom Headers (Elementor Pro 3.5+)

This is the simplest method if your Elementor Pro version supports it. The JSON template already includes the Authorization header structure — you just need to enter your key.

1. Open the Contact page in Elementor
2. Click the **form widget**
3. In the left panel, go to the **Content** tab
4. Scroll past the form fields to **Additional Options**
5. Open **Additional Options** → look for **Custom Headers**
6. You should see an entry already: `Authorization` / `Bearer YOUR_OVERTURE_API_KEY`
7. Click **Edit** on that row and change `YOUR_OVERTURE_API_KEY` to your actual key from **Overture → Settings → Integrations → API Keys**
8. Click **Update**

> ℹ️ If you do not see **Custom Headers** inside Additional Options, your Elementor Pro version is older than 3.5. Use Method B instead.

---

### Method B — WPCode snippet (works with all Elementor versions)

This method is reliable and keeps your key out of the database and out of any UI that could be accidentally changed.

1. In WordPress admin, go to **Code Snippets** (or install the free **WPCode** plugin)
2. Click **Add New Snippet** → choose **PHP Snippet**
3. Give it a title: `XCP Overture Authorization Header`
4. Paste this code:

```php
add_filter(
    'elementor_pro/forms/webhooks/request_args',
    function ( $request_args, $record ) {
        if ( 'XCP Contact: Overture' === $record->get_form_settings( 'form_name' ) ) {
            $request_args['headers']['Authorization'] = 'Bearer YOUR_OVERTURE_API_KEY';
        }
        return $request_args;
    },
    10,
    2
);
```

5. Replace `YOUR_OVERTURE_API_KEY` with the token from **Overture → Settings → Integrations → API Keys**
6. Set the snippet to **Active** and save

> Your key is stored in the WordPress database (encrypted by WPCode) and never appears in page HTML.

---

## Step 4 — Test

Submit a test enquiry on your contact page. Within a few seconds, a new **Pending** booking should appear in **Overture → Bookings**.

---

## Confirmed Settings

| Setting | Value |
|---|---|
| Webhook URL | `https://xcphotography.overturehq.com/api/bookings` |
| HTTP Method | POST (Elementor always uses POST) |
| Authorization header name | `Authorization` |
| Authorization header value | `Bearer YOUR_OVERTURE_API_KEY` |
| Where to set it | Elementor Additional Options → Custom Headers (Method A) OR WPCode snippet (Method B) |
| Where it must NOT be | A hidden form field |
| New booking status | `Pending` (set automatically by Overture) |

---

## Field Mapping Reference

Form field IDs in `XCP_Contact_P2_Form_Overture.json` match Overture Booking API field names exactly — no transformation needed.

| Form label | `field_id` | Overture API field |
|---|---|---|
| Your Name | `promoterName` | `promoterName` |
| Type of Project | `name` | `name` (booking title) |
| Preferred Shoot Date | `date` | `date` |
| County / Region | `venueState` | `venueState` |
| Country | `venueCountry` | `venueCountry` |
| Brand & Vision | `message` | `info[]` note |
| Email Address | `email` | Person record (auto-matched) |
| Phone Number | `phone` | Person record (auto-matched) |

---

## Fallback Option

If you want to hold off on Overture for now, import `XCP_Contact_P2_Form_Fallback.json` instead — identical layout and styling, sends enquiries by email only, no API required. Field IDs are identical so you can swap to the Overture version at any time with zero disruption.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| 401 / no booking in Overture | API key revoked or wrong | Regenerate key in Overture → Settings → API Keys; update header in Elementor or WPCode snippet |
| No booking in Overture | Wrong webhook URL | Confirm URL: `https://xcphotography.overturehq.com/api/bookings` |
| 403 error | API key lacks permission | Check key has Booking write scope in Overture |
| 422 error | Required field missing or wrong format | Check `date` field outputs ISO 8601 (YYYY-MM-DD) |
| Form submits but shows error | Overture unreachable | Check Overture status; confirm server allows outbound POST |
| No Custom Headers option in Elementor | Older Elementor Pro version | Use Method B (WPCode snippet) — works on all versions |
| Key still showing in page HTML | API key is in a form field, not a header | Delete the Authorization form field; add key via Method A or B above |

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
