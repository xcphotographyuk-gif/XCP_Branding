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

## ⚡ Getting "submission failed" right now? Fix it in 30 seconds.

> **If the admin-ajax.php Response tab shows `"errors":{"":""}`, Overture returned a 401 Unauthorized. The two fixes below resolve this 95% of the time. Try them before reading anything else.**
>
> **Fix 1 — Confirm the WPCode snippet is Active (10 seconds)**
> WordPress admin → Code Snippets (WPCode) → find the Overture snippet → the toggle at the top of the page must be **blue (Active)**. If it is grey, click it, then click **Save Snippet**. Test the form again.
>
> **Fix 2 — Refresh the API key (30 seconds)**
> Log in to Overture → **Settings → API** → copy the key shown there. In the WPCode snippet, find the line:
> ```
>             $request_args['headers']['Authorization'] = 'Bearer YOUR_OVERTURE_API_KEY';
> ```
> Replace `YOUR_OVERTURE_API_KEY` (everything between the single quotes after `Bearer `) with the key you just copied from Overture. Click **Save Snippet**. Test the form again.
>
> Both of these produce the same `errors: {"":""}` response in the browser. You cannot tell from the browser which one it is — just do both.
>
> If the error persists after both fixes, continue to the full troubleshooting section below.

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

The "There was an error" message Elementor shows is generic. It does not tell you what went wrong. To find out what actually happened, use your browser's developer tools while submitting the form.

### How the form submission works (important context)

When a visitor submits the form, two separate requests happen:

1. **Browser → WordPress** — the form data is sent from the browser to your WordPress site as an AJAX request to `admin-ajax.php`. This request **does appear** in your browser's Network tab.
2. **WordPress → Overture** — WordPress then makes a server-side POST to `https://xcphotography.overturehq.com/api/bookings` with the Authorization header. This request is made by the server, not the browser, so it **does NOT appear** in your browser's Network tab.

**You will never see an `overturehq.com` row in your browser Network tab.** That call happens entirely on the server. What you will see is `admin-ajax.php`.

> **What about `r.stripe.com` rows?**
> You may see multiple requests to `r.stripe.com` in the Network tab. These are Stripe telemetry beacons. They fire automatically on every page load because Stripe.js is embedded somewhere on the site. They have nothing to do with your form or Overture. Ignore them entirely.
>
> Similarly, ignore any `proxytown`, `imagegen204`, or other third-party tracking rows. The only row that matters for debugging the form is the POST to `admin-ajax.php` that fires when you click Submit.

> **What about browser extension errors in the Console tab?**
> If you open the **Console** tab (not the Network tab) you will likely see errors from your browser extensions alongside any real site errors. These are completely separate and unrelated to your form or WordPress. Common examples:
>
> - **LastPass:** `Unchecked runtime.lastError: Cannot create item with duplicate id LastPass` / `Cannot create item with duplicate id Add Address` / `No tab with id: …` — these come from `background-redux-new.js`, which is LastPass's own background script. They are a known LastPass extension bug. They appear on every page and mean nothing about your site.
> - **Grammarly, 1Password, Honey, and other extensions** produce similar console noise.
>
> When debugging the form, use the **Network** tab (not the Console tab) and look only at the `admin-ajax.php` row. Ignore everything in the Console that references an extension script (the source column will show an extension URL such as `chrome-extension://…` rather than your site URL).

### Step-by-step: reading the real error in Chrome or Edge

1. Go to the page containing the form.
2. Press **F12** (or right-click anywhere on the page and choose **Inspect**). The developer tools panel opens.
3. Click the **Network** tab at the top of that panel.
4. Optional but helpful: click the clear button (🚫 circle icon) to clear existing rows so the list is empty.
5. Fill in the form and click **Submit**.
6. In the Network tab you will see a burst of new rows. Find the one that says **admin-ajax.php** and has **Method: POST**. Click it.
7. A side panel opens. You will see a row of sub-tabs along the top: **Headers**, **Payload**, **Preview**, **Response**, **Cookies**, **Timing**. Click **Response** (or **Preview**).

> **You must be on the Response tab — not Headers, Payload, or Cookies.** Those other tabs show supporting data but not the diagnostic answer. Only the Response tab shows what WordPress sent back to the browser.

The response will be a JSON object. Look for a `data` field that contains information about what happened. If the webhook to Overture failed, the error will appear here.

### What each DevTools sub-tab tells you

When you click on the `admin-ajax.php` row, several sub-tabs appear. Each one shows different information:

| Sub-tab | What it shows | Useful for diagnosing Overture? |
|---|---|---|
| **Headers** | HTTP metadata: status code, content-type, content-length, server info, cookies sent | Partially — see note below |
| **Payload** | The form data sent from the browser to WordPress: post_id, form_id, form_fields[] values, action | Confirms the form reached WordPress and which fields were submitted |
| **Preview** | A formatted view of the JSON response body | ✅ Yes — same as Response but easier to read |
| **Response** | The raw JSON response body — the actual answer from WordPress/Overture | ✅ Yes — this is the diagnostic data |
| **Cookies** | Cookies present in the browser during the request | No — browser cookies do not affect the server-side Overture call |
| **Timing** | How long each phase of the request took | No |

#### Reading the Headers sub-tab

The Headers tab is not the final answer, but it contains one useful clue: **`content-length`**.

- **`content-length: 78`** is a strong indicator of the error response. The body `{"success":false,"data":{"message":"There was an error"}}` is approximately 78 bytes when encoded. If you see this number, the form reached WordPress and WordPress tried to call Overture, but Overture rejected it. Switch to the **Response** tab to confirm and read the exact message.
- **`content-length: 200+`** or larger suggests a success response or a longer error with more detail.
- **Status `200 OK`** means WordPress received the form submission. It does **not** mean Overture succeeded — WordPress always returns 200 for AJAX requests, even when the webhook call failed.

#### Reading the Payload sub-tab

The Payload tab shows what the browser sent to WordPress. If you can see a list of `form_fields[]` values (name, email, phone, date, etc.) in the Payload tab, the form is definitely reaching WordPress correctly. The problem is then entirely server-side — in the WPCode snippet or the Overture API response.

#### Reading the Cookies sub-tab

The Cookies tab shows `wordpress_logged_in_*`, `__stripe_mid`, `wp_consent_*` and other browser cookies. These are browser-to-WordPress authentication cookies. They have no effect on the server-side call WordPress makes to Overture. Consent cookies (`wp_consent_statistics=deny`, etc.) do not block the PHP snippet. You do not need to change your cookie consent settings to fix the Overture integration.

### What each Elementor form response means

| What the admin-ajax.php Response tab shows | What it means | What to do |
|---|---|---|
| `{"success":true,...}` with a booking in Overture | ✅ Everything worked | Nothing — you are done |
| `{"success":true,...}` with **no** booking in Overture | Elementor succeeded but the webhook was not configured | Check the Webhook action is added in Elementor form → Content → Actions After Submit |
| `{"success":false,"data":{"message":"Your submission failed because of an error.","errors":{"":""},"data":[]}}` | **Webhook action failed** — Overture rejected the request with a non-2xx HTTP status | See "What `errors: {"": ""}` means" below — enable WP_DEBUG_LOG to find the exact HTTP status |
| `{"success":false,"data":{"message":"There was an error"}}` | Older Elementor version — same meaning as above | Same fix as above |
| `{"success":false,"data":{"message":"..."}}` with a named field in `errors` | A specific form field failed Elementor's server-side validation | Read the field name in the `errors` object and check that field in the form widget |
| No admin-ajax.php row appears at all after Submit | The form submission did not fire | Check Elementor Pro is active and the form is not in draft/preview-only mode |

### What `"errors": {"": ""}` means

This is the most important pattern to understand. In Elementor's response JSON, the `errors` object maps **field IDs to error messages**. For example, a required field left blank would appear as `{"field_email": "This field is required"}`.

**An empty key with an empty value — `{"": ""}` — is not a field error.** It means a **form action** (in this case the Webhook action that calls Overture) returned a failure. Elementor has no field to blame, so it uses an empty key.

**This tells you:**
- ✅ The form reached WordPress correctly (the payload was valid)
- ✅ Elementor's webhook fired and reached Overture (Overture responded — even a 401 counts as a response)
- ❌ Overture rejected the request and returned a non-2xx HTTP status (most commonly **401 Unauthorized**)

> **Important:** Overture responds with 401 whether or not the WPCode snippet fired. If the snippet is Inactive, the Authorization header is simply missing and Overture still replies — it just rejects the request immediately. You **cannot** tell from `errors: {"":""}` alone whether the snippet ran. Always check both: snippet Active AND API key current.

**The `errors: {"": ""}` response means the issue is entirely between WordPress and Overture.** The browser-side data (cookies, headers, payload) will not tell you more. You need the server-side Overture response, which only appears in the WordPress debug log.

**Most likely causes in order:**

| Most likely cause | Overture HTTP status | How to confirm |
|---|---|---|
| WPCode snippet is **Inactive** — Authorization header never sent | 401 Unauthorized | Check WPCode → snippet toggle is blue/Active |
| API key in snippet is **wrong, expired, or contains a typo** | 401 Unauthorized | Regenerate key in Overture, paste fresh into snippet |
| Form Name in Elementor **does not exactly match** the snippet | 401 Unauthorized (header not added) | Check Content tab → Form Name = `XCP Contact: Overture` exactly |
| Overture rejected a **field value** (wrong format, empty required field) | 422 Unprocessable | Enable WP_DEBUG_LOG — the 422 body names the specific field |
| Wrong webhook URL | 404 Not Found | Confirm URL = `https://xcphotography.overturehq.com/api/bookings` |

### Checking the Overture response via WordPress debug log

> ### 🛑 BEFORE YOU START — ARE YOU IN THE RIGHT TOOL?
>
> **You need GoDaddy File Manager — NOT phpMyAdmin.**
>
> | Tool | What it shows | Where to find it in cPanel |
> |---|---|---|
> | **File Manager** ✅ | PHP files on disk — including `wp-config.php` | **Files** section of cPanel |
> | **phpMyAdmin** ❌ | Database tables only — `wp-config.php` does not exist here | **Databases** section of cPanel |
>
> If you are looking at a screen full of database table names (like `wp_bmmgvw4m5z_options`, `wp_bmmgvw4m5z_posts`, etc.) you are in **phpMyAdmin** — close it and go back to the cPanel dashboard. Scroll up to the **Files** section and click **File Manager** instead.

The browser Network tab has told you everything it can. The Response body `{"success":false,"data":{"message":"Your submission failed because of an error.","errors":{"":""},"data":[]}}` confirms the issue is between WordPress and Overture — not the browser, not the form, not the cookies. To find the exact Overture HTTP status and error body, enable WordPress debug logging:

1. Open `wp-config.php` in the GoDaddy File Manager — follow these exact steps:

   > **📁 How to find wp-config.php on GoDaddy**
   >
   > `wp-config.php` is **not** inside `wp-content/`. It sits one level above — in the WordPress root folder. Here is how to get there on GoDaddy:
   >
   > 1. Go to **https://www.godaddy.com** → sign in → click your account name (top right) → **My Products**
   > 2. Under **Web Hosting**, click **Manage** next to your hosting plan
   > 3. In the cPanel dashboard, scroll to the **Files** section and click **File Manager**
   > 4. File Manager opens. In the **left-hand folder tree**, click **public_html** (this is your WordPress root)
   > 5. In the **right-hand file list** you will now see `wp-config.php` sitting alongside the folders `wp-content`, `wp-admin`, and `wp-includes`
   > 6. Click once on `wp-config.php` to select it, then click **Edit** in the top toolbar (or right-click → Edit)
   > 7. The file opens in a text editor inside your browser — make your changes and click **Save Changes**
   >
   > ⚠️ If you do **not** see `public_html` in the left tree, look for a folder named after your domain (e.g. `yourdomain.co.uk`) — that is your WordPress root instead.
   >
   > ⚠️ **If you opened phpMyAdmin instead of File Manager** — you are in the database browser, not the file browser. `wp-config.php` is a PHP file on the server's disk; it does not appear in phpMyAdmin at all (phpMyAdmin only shows database tables, not files). Close phpMyAdmin and go back to the cPanel dashboard. The tool you need is **File Manager**, found in the **Files** section of cPanel — not in the **Databases** section where phpMyAdmin lives.
2. Find the line `define( 'WP_DEBUG', false );` and change it to `define( 'WP_DEBUG', true );`
3. Add immediately below it: `define( 'WP_DEBUG_LOG', true );`
4. Submit a test enquiry via the form
5. In your hosting file manager, navigate to `wp-content/` and download `debug.log` (it only appears after an error has been logged)
6. Search the file for `overture` or `xcphotography.overturehq` — you will find a line showing the HTTP status Overture returned (401, 403, 422, etc.) and the response body with the specific reason
7. **Set `WP_DEBUG` back to `false` when done** — never leave debug mode on a live site

> **What you will likely find:** Given the `errors: {"": ""}` response, the most common cause is a **401 Unauthorized** (WPCode snippet Inactive, or the API key in the snippet is wrong or expired). The second possibility is **422 Unprocessable** (a field value Overture rejected). The debug log will tell you which one and, for 422, will name the specific field.

### If the Overture booking is not being created

Work through this checklist in order:

1. **Form Name** - In Elementor, open the form widget → Content tab → Form Name. It must be exactly: `XCP Contact: Overture`
   - Capital X, capital C, capital O
   - A colon, then a space, then Overture with a capital O
   - No trailing spaces, no quotes
   - Any difference and the snippet will not fire

2. **Snippet status** - In WordPress admin → Code Snippets (WPCode), find the Overture snippet. The toggle must show **Active** (blue/green, not grey). Click Save Snippet after changing it.

3. **Webhook URL** - In Elementor, open the form widget → Content tab → Actions After Submit → Webhook. The URL must be: `https://xcphotography.overturehq.com/api/bookings`

4. **Elementor Pro** - The webhook action requires Elementor Pro. If the Webhook option does not appear in Actions After Submit, your site is on the free version of Elementor. Use the fallback form instead.

5. **Check Overture directly** - Log in to Overture and go to Bookings. If a booking appeared with status Pending, the submission worked even if Elementor showed an error message. The error message is a known display glitch in some Elementor versions.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| I am looking at a list of database tables (`wp_bmmgvw4m5z_options`, `wp_bmmgvw4m5z_posts`, etc.) and cannot find `wp-config.php` | You are in **phpMyAdmin** (the database browser) — wrong tool | Close phpMyAdmin. In cPanel, scroll to the **Files** section (not Databases) and click **File Manager** instead. `wp-config.php` is a file on disk, not a database table. |
| "Invalid file" on import | Non-standard fields in the JSON | Re-download the file from the repo. The fixed versions no longer contain `_comment` fields that caused this error. |
| "There was an error" on form submission | Overture may have rejected the request, or the webhook is not configured | First check Overture → Bookings to see if a booking was created anyway (display glitch). If not, check the WPCode snippet is Active and the API key is correct. Enable WP_DEBUG_LOG temporarily to see the server-side Overture response. See "How to see the actual error" above. |
| You see r.stripe.com rows in the Network tab | Normal — Stripe.js telemetry beacons fire on every page load | Ignore them. They are unrelated to your form or Overture. The Overture webhook is server-side and will not appear in the browser Network tab at all. |
| You see admin-ajax.php in the Network tab after Submit | Normal — this is the form submission from browser to WordPress | Click the admin-ajax.php POST row and read the **Response** tab (not Headers, not Cookies) for error detail. |
| Response tab shows `"errors": {"": ""}` | Webhook action failed — Overture returned a non-2xx HTTP status | Enable WP_DEBUG_LOG (see above) to see whether Overture returned 401, 403, or 422, then fix accordingly |
| Response tab shows `"errors": {"": ""}` and WPCode snippet is Active | API key in the snippet is wrong or expired | Regenerate API key in Overture → Settings → API, paste the new key into the WPCode snippet, Save Snippet |
| Elementor shows an error but a booking appeared in Overture | Known Elementor display glitch | The submission worked. Dismiss the error and confirm in Overture. |
| Form submits but no booking appears in Overture | Snippet not set to Active, or Form Name mismatch | Check the WPCode snippet is **Active**. Check the form widget Form Name is exactly `XCP Contact: Overture`. |
| Snippet is Active but still no booking | Form Name in Elementor does not match the snippet | Open the form widget in Elementor → Content tab → Form Name field. It must be exactly `XCP Contact: Overture` (capital X, capital C, capital O, colon, space). Any difference and the snippet will not fire. |
| 401 Unauthorized (visible in WP debug log) | API key wrong, missing, revoked, or snippet Inactive | Regenerate in Overture, update the WPCode snippet, make sure the snippet is Active |
| 403 Forbidden (visible in WP debug log) | Key lacks permission | Regenerate key in Overture with Booking write scope |
| 404 (visible in WP debug log) | Wrong webhook URL | Confirm exactly: `https://xcphotography.overturehq.com/api/bookings` |
| 422 Unprocessable (visible in WP debug log) | Required field missing or wrong format | Check date field outputs YYYY-MM-DD. The 422 response body in the debug log lists the specific field name. |
| Key visible in page HTML | Key is in a form field, not the snippet | Delete that hidden field, use the WPCode snippet |
| Fallback form submits but no email received | To address does not exist on the server | Confirm the email address in Elementor form → Content → Email → To is `info@xcphotography.co.uk` (or another address that exists). WordPress cannot deliver to a non-existent mailbox. |
| Browser console or security scanner warns about CSP / unsafe-eval | Stripe.js requires string evaluation to run | Stripe.js (`js.stripe.com`) uses `eval()` internally and will not function without `unsafe-eval` in the site's Content Security Policy. If you are implementing a CSP on the site, your `script-src` directive must include `'unsafe-eval'` and `https://js.stripe.com`. This is a Stripe requirement, not a site code issue. See the CSP note below. |
| Browser or accessibility scanner warns "form field has no id or name" on the date picker | Flatpickr date picker internal input has no id/name by default | The flagged element (`<input class="numInput cur-year">`) is the year navigation widget inside the calendar popup, not the submitted date field. It does not affect form submissions. Add the JavaScript WPCode snippet in the "Optional: date picker autofill fix" section below to silence the warning. |

---

## Optional: date picker autofill fix

Browsers and accessibility scanners may report:

> *"A form field element has neither an id nor a name attribute. This might prevent the browser from correctly autofilling the form."*

The element flagged is flatpickr's internal year-navigation control:

```html
<input class="numInput cur-year" type="number" tabindex="-1" aria-label="Year">
```

This input is generated automatically at runtime by Elementor's date picker (flatpickr). It is **not** the submitted date field — it is a display widget that lets the visitor change the year shown in the calendar pop-up. Its value is never included in the form data sent to Overture. The warning does not affect form submissions or bookings.

To silence the warning, add a second WPCode snippet alongside the PHP snippet from Step 2.

**Title:** `XCP Flatpickr Accessibility Patch`

In WPCode (Code Snippets → Add Snippet), choose **JavaScript Snippet** as the code type and set the location to **Frontend**. Paste this code:

```javascript
(function () {
    function patchFlatpickrInputs(root) {
        (root || document).querySelectorAll('.numInput.cur-year:not([id])').forEach(function (el, i) {
            el.id   = 'fp-year-' + i;
            el.name = 'fp-year-' + i;
        });
    }

    var observer = new MutationObserver(function (mutations) {
        mutations.forEach(function (m) {
            m.addedNodes.forEach(function (node) {
                if (node.nodeType === 1 && node.classList && node.classList.contains('flatpickr-calendar')) {
                    patchFlatpickrInputs(node);
                }
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        observer.observe(document.body, { childList: true });
        patchFlatpickrInputs();
    });
}());
```

Set the snippet to **Active** and click **Save Snippet**.

This snippet watches for flatpickr calendar pop-ups (they are injected into the page dynamically when the visitor focuses the date field) and adds a unique `id` and `name` to the year input when it appears. It has no effect on form submissions, styling, or Overture bookings.

---

## Content Security Policy (CSP) note

If you or your hosting provider implement a Content Security Policy on the site, you will see browser console warnings or security-scanner alerts about `unsafe-eval`. This is expected and is caused by **Stripe.js** (`js.stripe.com`), not by any code in this repository or the WPCode snippet.

Stripe.js uses string evaluation (`eval()`) internally for PCI-compliant card tokenisation. You cannot change this — it is part of Stripe's script. The warning is informational; the script will still run unless you have a `script-src` header that explicitly blocks it.

**If you are adding a CSP header to the site** (via `.htaccess`, an Nginx config, or a WordPress plugin), your `script-src` directive must include all of the following for Stripe and Elementor to work:

```
Content-Security-Policy: script-src 'self' 'unsafe-inline' 'unsafe-eval' https://js.stripe.com https://*.stripe.com https://*.stripe.network;
```

Notes:
- `'unsafe-eval'` — required by Stripe.js
- `'unsafe-inline'` — required by Elementor (it outputs inline `<script>` blocks)
- `https://js.stripe.com` and `https://*.stripe.com` — Stripe's own domains
- `https://*.stripe.network` — Stripe's telemetry beacon domain (`r.stripe.com`)

**If you are not implementing a CSP header**, the warning from a security scanner is a recommendation, not an error. The site continues to function normally. You can note the recommendation and choose to implement a CSP in future with the directive above included.

**The WPCode PHP snippet in Step 2 of this guide uses no `eval()` calls.** The optional JavaScript snippet in the "date picker autofill fix" section also uses no `eval()`. The CSP issue is entirely from Stripe and Elementor, both third-party tools.

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
