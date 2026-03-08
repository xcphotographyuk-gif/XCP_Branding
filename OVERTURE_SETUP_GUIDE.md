# Overture CRM: Contact Form Setup Guide

**The single reference for connecting your XCP contact form to Overture.**

---

## Quick Summary

The JSON template (`XCP_Contact_P2_Form_Overture.json`) has everything pre-built:
- Webhook URL: `https://xcphotography.overturehq.com/api/bookings`
- All field IDs mapped to Overture API field names exactly
- Authorization added via WPCode snippet after import (see Step 2 below)

**The JSON does not contain your API key. Import the file as-is, then add the key via WPCode. Done.**

> **Why is the key not in the JSON?** Elementor does not support importing custom webhook headers via JSON template files. Adding the key to the JSON would cause the import to fail with an "invalid file" error. The WPCode snippet method adds the header server-side, securely, without touching the JSON at all.

---

## Security Note

**Never put your Overture API key in a hidden form field.**

Hidden form fields are written into the page HTML. Anyone can view the page source and read the key. Use the WPCode snippet method below instead. Your key stays in the WordPress database and never appears in page HTML.

If you previously added an Authorization hidden field, regenerate your API key in Overture immediately, then delete that hidden field from the form.

---

## Step 1: Import the form JSON

Import `XCP_Contact_P2_Form_Overture.json` on your Contact page, or `XCP_Home_S6_Contact_Form.json` on your Home page (or any page where you want the form). You can import on as many pages as you like, in any order.

**The API key is not in the JSON file and is not needed for the import to work.** The import only creates the Elementor layout. The API key is only used when a visitor actually submits the form. Import first, add the key second.

Do not add `custom_headers` to the JSON manually. Elementor does not support this field during template import and will reject the file as invalid. Use the WPCode snippet in Step 2 instead.

The webhook URL is pre-set to `https://xcphotography.overturehq.com/api/bookings`.

---

## Step 2: Add your API key via WPCode

### What WPCode is (and what it is not)

WPCode is a **free WordPress plugin**. You install it from inside WordPress like any other plugin. Once installed, it gives you a simple code editor inside your WordPress admin panel, where you paste PHP directly into a text box.

**There is no PHP file to create. No file to zip. No uploading.** It is just copy, paste, save, activate. That is all.

---

### How to do it

**First time only:** Install WPCode
1. In WordPress admin go to **Plugins → Add New**
2. Search for **WPCode**
3. Install and activate the free version

**Then, every time:** Add the snippet
1. In WordPress admin go to **Code Snippets → Add Snippet** (WPCode adds this menu item)
2. Hover over **Add Your Custom Code (New Snippet)** and click **Use Snippet**
3. Choose **PHP Snippet** from the code type options
4. Give it the title: `XCP Overture Authorization Header`
5. Copy and paste this entire block into the code editor:

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

6. In the code you just pasted, replace `YOUR_OVERTURE_API_KEY` with your actual token from **Overture → Settings → Integrations → API Keys**
7. At the top of the page, toggle the snippet from **Inactive** to **Active**
8. Click **Save Snippet**

Done. The code now runs automatically in the background every time someone submits the form. You never have to touch it again unless you need to update the API key.

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

The fallback form sends enquiries to `info@xcphotography.co.uk`. This is already set in the JSON. If that address changes, open the form widget in Elementor, go to Content → Email, and update the To field.

**Why does the form need a working email address?** The fallback form relies entirely on WordPress sending an email. If the To address does not exist, WordPress will still report success on the front end but the email will bounce silently and you will never see the enquiry. Always test with a real submission after import.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| "Invalid file" on import | Non-standard fields in the JSON | Re-download the file from the repo. The fixed versions no longer contain `_comment` fields that caused this error. |
| 401 or no booking in Overture | API key wrong or revoked | Regenerate in Overture, update the WPCode snippet |
| No booking created | Wrong webhook URL | Confirm: `https://xcphotography.overturehq.com/api/bookings` |
| 403 error | Key lacks permission | Check key has Booking write scope in Overture |
| 422 error | Required field missing or wrong format | Check date field outputs YYYY-MM-DD |
| Key visible in page HTML | Key is in a form field, not the snippet | Delete that hidden field, use the WPCode snippet |
| Fallback form submits but no email received | To address does not exist on the server | Confirm the email address in Elementor form → Content → Email → To is `info@xcphotography.co.uk` (or another address that exists). WordPress cannot deliver to a non-existent mailbox. |

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
