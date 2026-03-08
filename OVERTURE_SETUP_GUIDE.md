# 🔑 Overture CRM — Contact Form Setup Guide

**The single reference for connecting your XCP contact form to Overture.**

---

## 🚨 Security Warning — Read First

**Never put your Overture API key in a hidden form field.**

Hidden form fields are written into the page's HTML source code. Anyone can right-click → View Source and read the key. If you have done this:

1. **Go to Overture → Settings → Integrations → API Keys → regenerate/revoke that key immediately.** The old key is now public.
2. Remove the Authorization hidden field from your Elementor form (instructions below).
3. Follow the correct method in this guide to add the key securely.

---

## Step 1 — Remove any incorrect Authorization hidden field

If your form currently has a hidden field labelled **Authorization**:

1. Open the page in Elementor
2. Click the form widget
3. Go to the **Content** tab → **Form Fields** list
4. Find the field with Label: `Authorization` and Type: `Hidden`
5. Click the **×** (delete) icon on that field row
6. Click **Update**

The JSON template (`XCP_Contact_P2_Form_Overture.json`) does not include this field. If you re-import it fresh you will not have the problem.

---

## Step 2 — Import the form JSON

Import `XCP_Contact_P2_Form_Overture.json` on your Contact page. The webhook URL is pre-set: `https://xcphotography.overturehq.com/api/bookings`

---

## Step 3 — Add your API key securely

The API key is a **webhook HTTP header** — not a form field. Choose whichever method works for your setup.

### Method A — WPCode snippet (recommended, works with all Elementor versions)

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

### Method B — Elementor Custom Headers UI (Elementor Pro 3.5+ only)

If your version of Elementor Pro supports it, you can add the header inside Elementor:

1. Open the page in Elementor
2. Click the **form widget** to select it
3. In the **left panel**, go to the **Content** tab
4. Scroll all the way down past the form fields to the **Additional Options** accordion section
5. Inside Additional Options, look for a **Custom Headers** sub-section
6. Click **+ Add Item** and enter:

| Key | Value |
|---|---|
| `Authorization` | `Bearer YOUR_OVERTURE_API_KEY` |

7. Click **Update**

> ℹ️ If you do not see Custom Headers inside Additional Options, your Elementor Pro version does not include this UI. Use Method A instead — it works on all versions.

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
| Where to set it | WPCode snippet (Method A) OR Elementor Additional Options → Custom Headers (Method B) |
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
| 401 / no booking in Overture | API key revoked or wrong | Regenerate key in Overture → Settings → API Keys; update WPCode snippet |
| No booking in Overture | Wrong webhook URL | Confirm URL: `https://xcphotography.overturehq.com/api/bookings` |
| 403 error | API key lacks permission | Check key has Booking write scope in Overture |
| 422 error | Required field missing or wrong format | Check `date` field outputs ISO 8601 (YYYY-MM-DD) |
| Form submits but shows error | Overture unreachable | Check Overture status; confirm server allows outbound POST |
| No Custom Headers option in Elementor | Older Elementor Pro version | Use Method A (WPCode snippet) |

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
