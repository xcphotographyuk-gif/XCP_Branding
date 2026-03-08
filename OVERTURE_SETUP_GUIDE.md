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

### After import: confirm the Form Name in Elementor

After importing, open the form widget in Elementor (click the form, then click the pencil/edit icon). Go to the **Content** tab. Near the top you will see a field called **Form Name**. It must read exactly:

```
XCP Contact: Overture
```

This is not a hidden ID field. It is a plain text field at the top of the Content tab, visible to the editor only. The JSON pre-sets this value, so if you imported the JSON it will already be correct. If you built the form by hand, type it in manually.

**The snippet checks this field name to decide whether to add the Authorization header.** If the name is missing, blank, or spelt differently (including different capitalisation), the snippet will not fire and Overture will return an error on submission.

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

The form name is set in the Elementor form widget under **Content → Form Name**. The JSON pre-sets this to `XCP Contact: Overture`. Do not change it unless you also update the snippet to match exactly.

---

## Step 3: Check your snippet before testing

Before submitting a test enquiry, confirm these four things in WPCode:

| Check | What it should show |
|---|---|
| Code Type | PHP Snippet |
| Snippet status (top of page) | Active (toggled on, not grey/inactive) |
| Insert Method | Auto Insert |
| Location | Run Everywhere |

The code itself should match the block in Step 2 exactly, with `YOUR_OVERTURE_API_KEY` replaced by your actual key from Overture. No other changes needed.

If the snippet is set to **Inactive**, the Authorization header is never added and Overture will reject the request silently. Toggle to **Active** and click **Save Snippet** before testing.

---

## Step 4: Test

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
| Preferred Discovery Call Date | date | date |
| County / Region | venueState | venueState |
| Country | venueCountry | venueCountry |
| Tell Me About Your Brand & Vision | message | info[] |
| Email Address | email | Person record (auto-matched) |
| Phone Number | phone | Person record (auto-matched) |

**Why "Discovery Call Date" and not "Shoot Date"?**

The form is the first point of contact. The visitor does not know their shoot date yet and the shoot date gets agreed during the discovery call, not before it. Asking for a preferred call date sets the right expectation: enquiry comes in, you book a call, the call confirms the brief and shoot date. The date field (`date`) is sent to Overture as the booking date and you can update it to the actual shoot date after the call.

---

## Overture Field Configuration

### Booking further information fields: what to set as default

Overture lets you mark booking fields as "default on every booking". **You do not need to tick this for the fields sent by the website form.** The form already populates those fields on submission. Ticking "default on every booking" is only useful for fields you want to appear blank on every new booking you create manually inside Overture.

Recommended defaults for manually-created bookings:

| Field | Default on every booking? | Reason |
|---|---|---|
| Message / Brief | No | Sent by form or filled during call |
| Preferred Date | No | Agreed during discovery call |
| Type of Photoshoot | No | Sent by form as "Type of Project" |
| Shoot Location | No | Agreed during discovery call |
| Further Information | No | Optional, filled as needed |
| Budget | No | Discussed during call |
| Hair & Makeup Interest | No | Portrait bookings only |
| Requirements | No | Filled per booking as needed |

Leave all booking further information fields at their defaults. Only tick "default on every booking" if you find yourself repeatedly adding the same heading to new bookings manually and want it to appear pre-populated.

---

### Calendar events: recommended field groups

The website form creates a booking in Overture. You can then create a calendar event linked to that booking. For the discovery call, create a calendar event using the **Branding photography - Details** group (or create a new group called **Discovery Call**).

Suggested calendar event field groups to set up in Overture (Settings → Calendar Events → Default further information fields):

**Discovery Call** group (create this if it does not exist):

| Heading | Event default | Notes |
|---|---|---|
| Call platform | Yes | Zoom / Teams / Phone |
| Brief summary | Yes | One-line note after the call |
| Agreed next step | Yes | Shoot date, quote, follow-up |

**Photoshoot** group (already exists, add to it):

| Heading | Event default | Notes |
|---|---|---|
| Details | Yes | Already set |
| Location confirmed | Yes | Address or studio name |
| Kit required | Yes | Equipment list |
| Delivery date | Yes | When final files are due |

You do not need to populate every field on every event. These are prompts, not requirements. Add what is useful for that specific booking.

---

### Contact fields: what goes where

Contact fields in Overture (the fields you saw under Contacts → Further Information) are separate from booking fields. They store information about the person, not the booking.

The website form does not write to contact fields directly. When a form submission creates a booking in Overture, Overture auto-matches the email address to an existing contact or creates a new one. The contact record will have the name, email and phone from the form. The booking fields (type of project, location, brief) are stored on the booking, not the contact.

**To add contact-level information** (industry sector, company bio, social links, etc.) after the enquiry comes in, open the contact record in Overture and fill in those fields manually, or send the client a contact update link so they can fill them in themselves.

The contact further information fields (brand vision, ideal audience, industry admiration, etc.) do not need to come from the website form. They are more suited to a pre-shoot questionnaire sent after the discovery call, once the booking is confirmed. Overture can generate a client questionnaire link from the booking page.

---



If you are not ready to connect Overture yet, import `XCP_Contact_P2_Form_Fallback.json` instead. It is identical in layout and styling but sends enquiries by email only, with no API required. Field IDs are identical, so swapping to the Overture version later causes no disruption.

The fallback form sends enquiries to `info@xcphotography.co.uk`. This is already set in the JSON. If that address changes, open the form widget in Elementor, go to Content → Email, and update the To field.

**Why does the form need a working email address?** The fallback form relies entirely on WordPress sending an email. If the To address does not exist, WordPress will still report success on the front end but the email will bounce silently and you will never see the enquiry. Always test with a real submission after import.

---

## How to see the actual error

The "There was an error" message Elementor shows is generic. It does not tell you what went wrong. To find out what Overture actually replied, use your browser's developer tools while submitting the form.

### Step-by-step: reading the real error in Chrome or Edge

1. Go to the page containing the form.
2. Press **F12** (or right-click anywhere on the page and choose **Inspect**). The developer tools panel opens.
3. Click the **Network** tab at the top of that panel.
4. In the filter bar inside the Network tab, type `bookings` to filter down to the Overture API call.
5. Fill in the form and click **Submit**.
6. A row labelled **bookings** will appear in the Network tab. Click it.
7. Click the **Response** sub-tab (or **Preview**) in the panel that opens on the right.

You will now see the exact reply Overture sent back. Match it to the table below.

### What each response means

| Response code | What Overture says | What it means | What to do |
|---|---|---|---|
| 200 or 201 | `{"status":"created"}` or similar | Success - but Elementor still showed an error | The booking was created. The "error" is a known display glitch in some Elementor versions. Check Overture → Bookings for the new entry. |
| 401 Unauthorized | `{"error":"Unauthorized"}` | No Authorization header, or the API key is wrong | Check the WPCode snippet is Active and the key is correct. |
| 403 Forbidden | `{"error":"Forbidden"}` | Key exists but lacks permission | Regenerate the key in Overture with Booking write access. |
| 404 Not Found | HTML error page | Webhook URL is wrong | Confirm the webhook URL in Elementor is exactly `https://xcphotography.overturehq.com/api/bookings`. |
| 422 Unprocessable | `{"errors":{...}}` | A required field is missing or formatted wrongly | The response body lists the specific field. Most common: the date field is blank or not in YYYY-MM-DD format. |
| No row appears | - | The snippet did not fire, so the request was never sent to Overture | The Form Name in Elementor does not match the snippet. See below. |

### If no "bookings" row appears in the Network tab

This means the PHP snippet did not add the Authorization header and the request was blocked before it reached Overture, or Elementor is not sending to the webhook at all.

Check these in order:

1. **Form Name** - In Elementor, open the form widget → Content tab → Form Name. It must be exactly: `XCP Contact: Overture`
   - Capital X, capital C, capital O
   - A colon, then a space, then Overture with a capital O
   - No trailing spaces, no quotes
   - Any difference and the snippet will not fire

2. **Snippet status** - In WordPress admin → Code Snippets (WPCode), find the Overture snippet. The toggle must show **Active** (blue/green, not grey). Click Save Snippet after changing it.

3. **Webhook URL** - In Elementor, open the form widget → Content tab → Actions After Submit → Webhook. The URL must be: `https://xcphotography.overturehq.com/api/bookings`

4. **Elementor Pro** - The webhook action requires Elementor Pro. If the Webhook option does not appear in Actions After Submit, your site is on the free version of Elementor. Use the fallback form instead.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| "Invalid file" on import | Non-standard fields in the JSON | Re-download the file from the repo. The fixed versions no longer contain `_comment` fields that caused this error. |
| "There was an error" on form submission | Overture rejected the request (no Authorization header, wrong key, or wrong webhook URL) | Open the browser Network tab and submit the form to see the real error. See "How to see the actual error" above. |
| 200 response but Elementor shows an error | Known Elementor display glitch | Check Overture Bookings anyway. The booking may have been created successfully. |
| Form submits but no booking appears in Overture | Snippet not set to Active | In WordPress admin go to Code Snippets, find the Overture snippet, check it is toggled to **Active** and click **Save Snippet**. |
| Snippet is Active but no bookings row in Network tab | Form Name in Elementor does not match the snippet | Open the form widget in Elementor → Content tab → Form Name field. It must be exactly `XCP Contact: Overture` (capital X, capital C, capital O, colon, space). Any difference and the snippet will not fire. |
| 401 Unauthorized | API key wrong, missing, or revoked | Regenerate in Overture, update the WPCode snippet, make sure the snippet is Active |
| 403 Forbidden | Key lacks permission | Regenerate key in Overture with Booking write scope |
| 404 on the bookings row | Wrong webhook URL | Confirm exactly: `https://xcphotography.overturehq.com/api/bookings` |
| 422 Unprocessable | Required field missing or wrong format | Check date field outputs YYYY-MM-DD. Check the 422 response body for the specific field name. |
| Key visible in page HTML | Key is in a form field, not the snippet | Delete that hidden field, use the WPCode snippet |
| Fallback form submits but no email received | To address does not exist on the server | Confirm the email address in Elementor form → Content → Email → To is `info@xcphotography.co.uk` (or another address that exists). WordPress cannot deliver to a non-existent mailbox. |

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
