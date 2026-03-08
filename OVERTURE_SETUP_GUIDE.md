# Overture CRM: Contact Form Setup Guide

**The single reference for connecting your XCP contact form to Overture.**

---

## Quick Summary

The JSON template (`XCP_Contact_P2_Form_Overture.json`) has everything pre-built:
- Webhook URL: `https://xcphotography.overturehq.com/api/bookings`
- All field IDs mapped to Overture API field names exactly
- Authorization handled via WPCode snippet (see Step 2 below)

**After importing, you add one WPCode snippet with your API key. Done.**

---

## Security Note

**Never put your Overture API key in a hidden form field.**

Hidden form fields are written into the page HTML. Anyone can view the page source and read the key. Use the WPCode snippet method below instead. Your key stays in the WordPress database and never appears in page HTML.

If you previously added an Authorization hidden field, regenerate your API key in Overture immediately, then delete that hidden field from the form.

---

## Step 1: Import the form JSON

Import `XCP_Contact_P2_Form_Overture.json` on your Contact page (or any page where you want the form).

The webhook URL is pre-set to `https://xcphotography.overturehq.com/api/bookings`.

---

## Step 2: Add your API key via WPCode

This is the confirmed method. It works with all Elementor versions, and because it targets the form by its **name** rather than the page it is on, you can place the form on any page (home, services, booking, etc.) and the Authorization header will be added automatically.

1. In WordPress admin, install the free **WPCode** plugin if you do not have it, or go to **Code Snippets** if you have a snippets plugin already
2. Click **Add New Snippet** and choose **PHP Snippet**
3. Title it: `XCP Overture Authorization Header`
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

5. Replace `YOUR_OVERTURE_API_KEY` with your token from **Overture → Settings → Integrations → API Keys**
6. Set the snippet to **Active** and save

---

## Using the form on any page

The snippet targets the form by its name (`XCP Contact: Overture`), not by which page it is on. This means:

- Import the form JSON on your Contact page
- Copy the form section in Elementor and paste it onto any other page (Home, Services, Booking, etc.)
- No additional setup needed. The snippet picks up any submission from that form, on any page, and adds the Authorization header automatically.

The form name is pre-set in the JSON. Do not change it unless you update the snippet to match.

---

## Step 3: Test

Submit a test enquiry. Within a few seconds a new **Pending** booking should appear in **Overture → Bookings**.

---

## Confirmed Settings

| Setting | Value |
|---|---|
| Webhook URL | `https://xcphotography.overturehq.com/api/bookings` |
| HTTP Method | POST |
| Authorization | Bearer token via WPCode snippet |
| Form name (must match snippet) | `XCP Contact: Overture` |
| New booking status | Pending |

---

## Field Mapping Reference

Form field IDs match Overture Booking API field names exactly.

| Form label | field_id | Overture API field |
|---|---|---|
| Your Name | promoterName | promoterName |
| Type of Project | name | name (booking title) |
| Preferred Shoot Date | date | date |
| County / Region | venueState | venueState |
| Country | venueCountry | venueCountry |
| Brand & Vision | message | info[] |
| Email Address | email | Person record (auto-matched) |
| Phone Number | phone | Person record (auto-matched) |

---

## Fallback Option

If you are not ready to connect Overture yet, import `XCP_Contact_P2_Form_Fallback.json` instead. It is identical in layout and styling but sends enquiries by email only, with no API required. Field IDs are identical, so swapping to the Overture version later causes no disruption.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| 401 or no booking in Overture | API key wrong or revoked | Regenerate in Overture, update the WPCode snippet |
| No booking created | Wrong webhook URL | Confirm: `https://xcphotography.overturehq.com/api/bookings` |
| 403 error | Key lacks permission | Check key has Booking write scope in Overture |
| 422 error | Required field missing or wrong format | Check date field outputs YYYY-MM-DD |
| Key visible in page HTML | Key is in a form field, not the snippet | Delete that hidden field, use the WPCode snippet |

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
