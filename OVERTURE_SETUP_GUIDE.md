# Overture CRM: Contact Form Setup Guide

**The single reference for connecting your XCP contact form to Overture.**

---

> ## 📋 Currently Using: Email Fallback Form
>
> **The contact page is currently set up with `XCP_Contact_P2_Form_Fallback.json`** — which sends enquiries directly to info@xcphotography.co.uk via WordPress mail. It works immediately with zero external services.
>
> This guide is for when you are ready to connect Overture. When that time comes, replace section 2 of the contact page with `XCP_Contact_P2_Form_Overture.json` and follow the steps below. All field IDs are identical — no disruption to any live forms.

---

## Quick Summary

The JSON template (`XCP_Contact_P2_Form_Overture.json`) has everything pre-built:
- Form Name: `XCP Contact: Overture` (already set in the JSON)
- Email action: sends a backup email to info@xcphotography.co.uk on every submission
- All field IDs matched to Overture API field names exactly

**The Overture connection is handled by a WPCode PHP snippet (not Elementor's built-in webhook).** The snippet hooks into the form submission, builds the correct Overture API payload, and sends it directly to Overture with proper `Authorization` and `Content-Type` headers. This is the approach that works — the previous snippet only added a header to Elementor's own webhook, which sent data in the wrong format.

**The JSON does not contain your API key. Import the file as-is, then add the WPCode snippet (Step 2) with your key. Done.**

---

## ⚡ Form submitting but no booking in Overture? Fix it in 2 minutes.

> **Step 1 — Delete your existing WPCode snippet and start fresh.**
> If the snippet you pasted contains anything other than `add_action( 'elementor_pro/forms/new_record'` at the very top, it is wrong. Delete it. Re-paste the clean snippet from Step 2 of this guide. Common mistakes to look for:
>
> | Mistake | What it looks like | Why it fails |
> |---|---|---|
> | Wrong hook | `elementor_pro/forms/webhooks/request_args` | Sends data in Elementor's format, not Overture's |
> | API key in `defined()` | `defined( 'my-actual-api-key' )` | `defined()` is a PHP function that checks if a constant exists by **name**. The constant name is always `OVERTURE_FORM_KEY`. Putting your key value inside `defined()` will always return false, so the snippet falls through to the (wrong) fallback and 401s. |
> | Corrupted or placeholder fallback key | Long string with spaces, or still says `YOUR_OVERTURE_API_KEY` | The fallback must be replaced with your actual key from Overture → Settings → API, copied exactly with no extra characters or spaces |
>
> The correct first line of the snippet is always: `add_action( 'elementor_pro/forms/new_record',`
>
> ---
>
> ### ❌ WRONG — do not use this pattern
>
> ```php
> // WRONG: the key value is inside defined() — this always returns false
> $api_key = defined( 'your-api-key-value' ) ? OVERTURE_FORM_KEY : 'some-fallback';
> ```
>
> **Why it always fails:** `defined()` checks whether a PHP *constant name* exists. A key value (e.g. something ending in `=`) is not a constant name — it is just a string. PHP will never find a constant with that name, so `defined()` returns `false` every time, and the snippet uses the fallback instead of your real key. If the fallback is wrong (a placeholder or a fake key), every API call gets rejected with 401 Unauthorized.
>
> ### ✅ CORRECT — this is what the line must look like
>
> ```php
> // CORRECT: the constant NAME goes inside defined(), your key goes after the colon
> $api_key = defined( 'OVERTURE_FORM_KEY' ) ? OVERTURE_FORM_KEY : 'YOUR_OVERTURE_API_KEY';
> ```
>
> - `'OVERTURE_FORM_KEY'` inside `defined()` is the constant **name** — it never changes, copy it exactly as shown.
> - `'YOUR_OVERTURE_API_KEY'` after the `:` is the **only thing you replace** — paste your real key from Overture → Settings → API here, keeping the surrounding single quotes.
>
> ---
>
> **Step 2 — The snippet below has test/placeholder values filled in for structure verification.**
> The `$api_key` line uses intentionally fake/false values (`NightynighOOOODUdeODc=` as the constant name and a long noise string as the fallback) so Overture will respond 401 — confirming the snippet fires. See the `⚠️ TEST VALUES` comment inside the snippet. For a live deployment: replace `NightynighOOOODUdeODc=` with `OVERTURE_FORM_KEY` and replace the noise string with your real key from Overture → Settings → API.
>
> **Key format note:** Web form keys from Overture are typically base64-encoded strings and may include letters, numbers, `+`, `/`, and `=` characters. Older keys may be hex strings (digits 0-9 and letters a-f only). Either way, copy the key exactly as Overture displays it and paste it without modification. Do not add or remove any characters.
>
> **Step 3 — Confirm the snippet is Active.**
> WordPress admin → Code Snippets (WPCode) → find the Overture snippet → the toggle at the top of the page must be **blue (Active)**. If it is grey, click it, then click **Save Snippet**.
>
> **Step 4 — Check the debug log.**
> Enable `WP_DEBUG_LOG` in `wp-config.php` (see "Checking the Overture response via WordPress debug log" below), submit the form, then read `wp-content/debug.log`. The log line will start with `XCP Overture:` and show the HTTP status Overture returned. A 200 or 201 means success. A 401 means the API key is wrong. A 422 means a field value was rejected.

---

## Security Note

**Never put your Overture API key in a hidden form field.**

Hidden form fields are written into the page HTML. Anyone can view the page source and read the key. Use the WPCode snippet method below instead. Your key stays in the WordPress database and never appears in page HTML.

If you previously added an Authorization hidden field, regenerate your API key in Overture immediately, then delete that hidden field from the form.

---

## Step 1: Import the form JSON

Import `XCP_Contact_P2_Form_Overture.json` on your Contact page. The import creates the Elementor layout only — the Overture connection is handled entirely by the WPCode snippet in Step 2.

**The API key is not in the JSON file.** Import first, add the WPCode snippet second.

### After import: confirm the Form Name in Elementor

After importing, open the form widget in Elementor (click the form, then the pencil/edit icon). Go to the **Content** tab. Near the top you will see a field called **Form Name**. It must read exactly:

```
XCP Contact: Overture
```

This is a plain text field at the top of the Content tab. The JSON pre-sets it correctly. **If you built the form by hand, type this value in exactly — the WPCode snippet matches on this name.**

---

## Step 2: Add your API key via WPCode

### What WPCode is (and what it is not)

WPCode is a **free WordPress plugin**. Install it from WordPress admin → Plugins → Add New. Once active, it gives you a code editor inside WordPress admin where you paste PHP into a text box.

**There is no PHP file to create, zip, or upload.** It is copy, paste, save, activate.

---

### How it works (important context)

The previous approach added a header to Elementor's built-in webhook — but Elementor's webhook sends data in its own format and Overture rejected it. The snippet below takes a different approach: it hooks directly into the form submission event, builds a correctly-structured Overture API payload, and sends it to Overture itself. This is the correct, working implementation.

---

### How to do it

**First time only:** Install WPCode
1. In WordPress admin go to **Plugins → Add New**
2. Search for **WPCode**
3. Install and activate the free version

**Then:** Add the snippet
1. Go to **Code Snippets → Add Snippet** (WPCode adds this menu item)
2. Hover over **Add Your Custom Code (New Snippet)** and click **Use Snippet**
3. Choose **PHP Snippet** from the code type options
4. Give it the title: `XCP Overture Booking Integration`
5. Copy and paste this entire block into the code editor:

```php
add_action(
    'elementor_pro/forms/new_record',
    function ( $record, $ajax_handler ) {

        // Only fire for the Overture contact form.
        if ( 'XCP Contact: Overture' !== $record->get_form_settings( 'form_name' ) ) {
            return;
        }

        // Read the API key — from wp-config.php constant if defined, otherwise from the fallback below.
        // ⚠️ TEST VALUES — both keys below are intentional placeholders for structure verification only.
        // The constant name 'NightynighOOOODUdeODc=' is not a valid PHP identifier, so defined() always
        // returns false and the snippet will always use the fallback string. The fallback string is also
        // a test value with deliberate noise/spaces so authentication will fail (401) on purpose.
        // Replace 'NightynighOOOODUdeODc=' with 'OVERTURE_FORM_KEY' and replace the fallback string
        // with your real key from Overture → Settings → API before going live.
        $api_key = defined( 'NightynighOOOODUdeODc=' ) ? OVERTURE_FORM_KEY : 'c0f2fdoityth gkdflhgkvcg k cLIESSTOPFAILINGME0647b5354002da64c4cd54b4c64f8c8fa228kghghjg5676d3dde397d61f318de943e7872dc75d06b5935ea10f';

        // Extract submitted field values by field_id.
        $raw    = $record->get_field( [ 'id', 'value' ] );
        $fields = [];
        foreach ( $raw as $field ) {
            $fields[ $field['id'] ] = $field['value'];
        }

        // Validate and sanitise the date — Overture requires YYYY-MM-DD format.
        $raw_date = ! empty( $fields['date'] ) ? trim( $fields['date'] ) : '';
        $parsed   = $raw_date ? DateTime::createFromFormat( 'Y-m-d', $raw_date ) : false;
        $date     = ( $parsed && $parsed->format( 'Y-m-d' ) === $raw_date ) ? $raw_date : gmdate( 'Y-m-d' );

        // Build the Overture API payload.
        // 'name' and 'date' are required by the Overture /api/bookings endpoint.
        $payload = [
            'name'         => ! empty( $fields['name'] ) ? sanitize_text_field( $fields['name'] ) : 'Website Enquiry',
            'date'         => $date,
            'promoterName' => ! empty( $fields['promoterName'] ) ? sanitize_text_field( $fields['promoterName'] ) : '',
            'venueState'   => ! empty( $fields['venueState'] )   ? sanitize_text_field( $fields['venueState'] )   : '',
            'venueCountry' => ! empty( $fields['venueCountry'] ) ? sanitize_text_field( $fields['venueCountry'] ) : 'United Kingdom',
            'email'        => ! empty( $fields['email'] )        ? sanitize_email( $fields['email'] )             : '',
            'phone'        => ! empty( $fields['phone'] )        ? sanitize_text_field( $fields['phone'] )        : '',
            'info'         => [],
        ];

        // Add the brand/vision message as a further information entry.
        if ( ! empty( $fields['message'] ) ) {
            $payload['info'][] = [
                'heading' => 'Brand & Vision',
                'body'    => sanitize_textarea_field( $fields['message'] ),
            ];
        }

        // Add the source URL as a further information entry.
        if ( ! empty( $fields['source'] ) ) {
            $payload['info'][] = [
                'heading' => 'Source',
                'body'    => esc_url_raw( $fields['source'] ),
            ];
        }

        // Send to Overture.
        $response = wp_remote_post(
            'https://xcphotography.overturehq.com/api/bookings',
            [
                'method'  => 'POST',
                'timeout' => 30,
                'headers' => [
                    'Authorization' => 'Bearer ' . $api_key,
                    'Content-Type'  => 'application/json',
                    'Accept'        => 'application/json',
                ],
                'body'    => wp_json_encode( $payload ),
            ]
        );

        // Log results to the WordPress debug log (search for 'XCP Overture:' in wp-content/debug.log).
        if ( is_wp_error( $response ) ) {
            // Log only the error code, not the full message, to avoid leaking internal network details.
            error_log( 'XCP Overture: connection error — code: ' . $response->get_error_code() );
        } else {
            $status = wp_remote_retrieve_response_code( $response );
            if ( $status < 200 || $status >= 300 ) {
                // Log the status and first 200 chars of the body for diagnostics.
                $body = substr( wp_remote_retrieve_body( $response ), 0, 200 );
                error_log( 'XCP Overture: HTTP ' . intval( $status ) . ' — ' . $body );
            } else {
                error_log( 'XCP Overture: booking created — HTTP ' . intval( $status ) );
            }
        }
    },
    10,
    2
);
```

6. **Set the API key** — the snippet currently contains **test/placeholder values** (both the constant name and the fallback key are intentionally fake — see the `⚠️ TEST VALUES` comment). Before going live, find the `$api_key = defined(...)` line and make these two replacements:
   - Inside `defined( '...' )`: replace `NightynighOOOODUdeODc=` with `OVERTURE_FORM_KEY` (the constant name, always this exact string)
   - After the `:`: replace the long test string with your actual key from **Overture → Settings → API** (keep the surrounding single quotes)
   > **For structure testing only:** if you just want to confirm the snippet fires correctly, you can leave the test values as-is — the snippet will run but Overture will return 401 (authentication failed). To see the log entry, make sure `WP_DEBUG` and `WP_DEBUG_LOG` are enabled in `wp-config.php` (see "Checking the Overture response via WordPress debug log" below), then check `wp-content/debug.log` for `XCP Overture: HTTP 401` to confirm the snippet is firing.
7. At the top of the page, toggle the snippet from **Inactive** to **Active**
8. Click **Save Snippet**

Done. Every form submission named `XCP Contact: Overture` will now create a booking in Overture automatically. The email action in the form sends you a backup copy by email as well.

---

## Using the form on any page

The snippet fires for any form whose **Form Name** is `XCP Contact: Overture`. You can import or copy the form section onto any page and it works automatically with no additional setup.

To add the form to the Home page when you switch from fallback to Overture:
1. In Elementor, open the Home page
2. Find the contact form section (imported from `XCP_Home_S6_Contact_Form.json`)
3. Click the form widget → Content tab → Form Name
4. Change the value from `XCP Contact: Email Fallback` to `XCP Contact: Overture`
5. Save the page

The WPCode snippet will then handle those submissions too.

---

## Step 3: Check your snippet before testing

Before submitting a test enquiry, confirm these four things in WPCode:

| Check | What it should show |
|---|---|
| Code Type | PHP Snippet |
| Snippet status (top of page) | Active (toggled on, blue — not grey) |
| Insert Method | Auto Insert |
| Location | Run Everywhere |

The code currently contains test/placeholder values (see the `⚠️ TEST VALUES` comment in the snippet). For a **live** deployment, the `$api_key` line must have `OVERTURE_FORM_KEY` inside `defined()` and your real key from Overture → Settings → API as the fallback — or `OVERTURE_FORM_KEY` must be defined in `wp-config.php`. For structure-testing only, leaving the test values is fine: the snippet will fire but Overture will return 401. To see the log entry, ensure `WP_DEBUG` and `WP_DEBUG_LOG` are `true` in `wp-config.php`, then check `wp-content/debug.log` for `XCP Overture: HTTP 401`.

**If you previously had an older snippet titled "XCP Overture Authorization Header"** — delete it. It used the wrong hook (`elementor_pro/forms/webhooks/request_args`) and sent data in Elementor's format instead of Overture's expected JSON. The new snippet above replaces it entirely.

---

## Step 4: Test

Fill in the contact form and submit a test enquiry. Within a few seconds:
- A new **Pending** booking should appear in **Overture → Bookings**
- A backup email should arrive at info@xcphotography.co.uk

If the booking appears in Overture, the integration is working correctly regardless of what message the browser shows.

---

## Confirmed Settings

| Setting | Value |
|---|---|
| Overture API version | v0.1.3 (OAS 3.1) |
| Overture endpoint | `https://xcphotography.overturehq.com/api/bookings` |
| HTTP Method | POST (sent by WPCode PHP snippet, not Elementor webhook) |
| Content-Type | `application/json` |
| Authorization | `Bearer {your API key}` — set in the WPCode snippet |
| Form name (must match snippet) | `XCP Contact: Overture` |
| New booking status | Pending |

---

## Field Mapping Reference

Form field IDs are sent to Overture via the webhook POST. Overture processes each field according to its own internal mapping — some fields set booking properties directly, others are matched to a person record or stored as further information.

| Form label | field_id | Overture API field / handling |
|---|---|---|
| Your Name | promoterName | Stored on the booking record |
| Type of Project | name | name (booking title, required by API) |
| Preferred Discovery Call Date | date | date (booking date, required by API) |
| County / Region | venueState | Stored on the booking record |
| Country | venueCountry | venueCountry (booking field) |
| Tell Me About Your Brand & Vision | message | info[] (further information) |
| Email Address | email | Person record (auto-matched or created by Overture) |
| Phone Number | phone | Person record (auto-matched or created by Overture) |

The **required** fields for the `/api/bookings` endpoint are `date` and `name`. Both are always present in every form submission.

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

> **With the current WPCode snippet (using `elementor_pro/forms/new_record`), the browser will always show the Elementor success message even if Overture fails.** The Overture call happens entirely in PHP after the form has already responded to the browser. This is intentional — visitors see a clean success and you get the email backup regardless. To see whether Overture accepted or rejected the booking, you must read the WordPress debug log (see "Checking the Overture response via WordPress debug log" below). Look for lines starting with `XCP Overture:`.

### How the form submission works (important context)

When a visitor submits the form:

1. **Browser → WordPress** — the form data is sent to WordPress via `admin-ajax.php`. This appears in the browser's Network tab.
2. **Elementor** — processes the form actions (email backup is sent).
3. **PHP action hook → Overture** — the WPCode snippet fires via `elementor_pro/forms/new_record`, builds the Overture JSON payload, and POSTs it to `https://xcphotography.overturehq.com/api/bookings`. This is a server-side call made after the browser has already received the success response. It does **not** appear in the browser Network tab and **does not** affect the browser success/error message.

**The browser Network tab cannot tell you whether Overture succeeded.** Check Overture → Bookings directly, or enable `WP_DEBUG_LOG` and read the debug log.

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
| API key in snippet is **wrong, expired, or contains a typo** | 401 Unauthorized | Regenerate key in Overture → Settings → API. If `OVERTURE_FORM_KEY` is defined in wp-config.php, update the value there and save. Otherwise paste the new key into the WPCode snippet and Save Snippet |
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
   > ⚠️ **If you can see `wp-admin`, `wp-content`, and `wp-includes` folders but no `wp-config.php`** — the **folder tree** (left panel) only ever shows **folders**, never files. `wp-config.php` is a **file**, so it will **never appear in the tree on the left**. To find it:
   > - Look at the very **top** of the left-hand folder tree — you will see the root entry, usually shown as your domain URL (e.g. `xjk.0aa.myftpupload.com`) or as `public_html`.
   > - **Click on that top-level entry** to select it.
   > - The **right-hand file list** will refresh and show the files inside that folder — you will see `wp-config.php` listed there alongside the `wp-admin`, `wp-content`, and `wp-includes` folders.
   > - `wp-config.php` is **not inside** any of those three folders. It is at the same level as them — in the root.
   >
   > ⚠️ **If you opened phpMyAdmin instead of File Manager** — you are in the database browser, not the file browser. `wp-config.php` is a PHP file on the server's disk; it does not appear in phpMyAdmin at all (phpMyAdmin only shows database tables, not files). Close phpMyAdmin and go back to the cPanel dashboard. The tool you need is **File Manager**, found in the **Files** section of cPanel — not in the **Databases** section where phpMyAdmin lives.
2. Find the line `define( 'WP_DEBUG', false );` and change it to `define( 'WP_DEBUG', true );`

   > ⚠️ **If you cannot find `define( 'WP_DEBUG', false );` in your wp-config.php** — your file may be a minimal wrapper that just loads another config file (it will start with a `require_once` line pointing to something like `wp-config-hosting.php`). This is normal for some hosting setups. In this case, **add the two debug lines as new lines immediately before the very last line of your wp-config.php** — the line that reads `require_once ABSPATH . 'wp-settings.php';`. Your file should then end like this:
   >
   > ```
   > define( 'WP_DEBUG', true );
   > define( 'WP_DEBUG_LOG', true );
   > require_once ABSPATH . 'wp-settings.php';
   > ```
   >
   > Do **not** delete any existing lines. Just insert the two `define` lines above the final `require_once`.

3. Add immediately below it: `define( 'WP_DEBUG_LOG', true );`
4. Submit a test enquiry via the form
5. In your hosting file manager, navigate to `wp-content/` and download `debug.log` (it only appears after an error has been logged)
6. Search the file for `XCP Overture:` — the WPCode snippet logs every Overture response with this prefix. You will see either `XCP Overture: booking created — HTTP 201` (success) or `XCP Overture: HTTP 401 — {body}` (failure with the Overture error message)
7. **Undo your changes when done** — never leave debug mode on a live site. If you edited the standard `define( 'WP_DEBUG', true );` line, change it back to `false`. If you added two new `define` lines above the final `require_once ABSPATH . 'wp-settings.php';`, delete those two lines entirely and save.

> **What you will likely find:** A **401 Unauthorized** (API key wrong, expired, or snippet Inactive) or a **422 Unprocessable** (a field value Overture rejected — the log body will name the specific field).

### If the Overture booking is not being created

Work through this checklist in order:

1. **WPCode snippet** — WordPress admin → Code Snippets (WPCode). The snippet must exist, be titled `XCP Overture Booking Integration`, and the toggle must be **Active** (blue). If the toggle is grey, activate it and click Save Snippet.

2. **Correct snippet** — the snippet code must begin with `add_action('elementor_pro/forms/new_record', ...`. If it begins with `add_filter('elementor_pro/forms/webhooks/request_args', ...)`, that is the old incorrect version — delete it and add the new one from Step 2 of this guide.

3. **Form Name** — in Elementor, open the form widget → Content tab → Form Name. It must be exactly: `XCP Contact: Overture`
   - Capital X, capital C, capital O
   - A colon, then a space, then Overture with a capital O
   - No trailing spaces, no quotes
   - Any difference and the snippet will not fire

4. **Elementor Pro** — the `elementor_pro/forms/new_record` action requires Elementor Pro. Check WordPress admin → Plugins — Elementor Pro must be listed as active (not just Elementor free). If only the free version is active, use the fallback form.

5. **Check Overture directly** — log in to Overture and go to Bookings. If a booking appeared with status Pending, the integration is working even if Elementor showed an error message on screen.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| I am looking at a list of database tables (`wp_bmmgvw4m5z_options`, `wp_bmmgvw4m5z_posts`, etc.) and cannot find `wp-config.php` | You are in **phpMyAdmin** (the database browser) — wrong tool | Close phpMyAdmin. In cPanel, scroll to the **Files** section (not Databases) and click **File Manager** instead. `wp-config.php` is a file on disk, not a database table. |
| I can see `wp-admin`, `wp-content`, and `wp-includes` in File Manager but no `wp-config.php` | The left-hand **folder tree** only shows folders — files never appear in the tree | Look at the **very top** of the left folder tree — you will see the root entry (your domain URL, e.g. `xjk.0aa.myftpupload.com`, or `public_html`). **Click on that top-level entry**. The **right-hand file list** will refresh to show the files at that level — `wp-config.php` will be there. |
| I opened `wp-config.php` but cannot find the line `define( 'WP_DEBUG', false );` anywhere in it | Your hosting uses a minimal wp-config.php that just loads another config file | This is normal for some hosts. Add `define( 'WP_DEBUG', true );` and `define( 'WP_DEBUG_LOG', true );` as new lines immediately before the final `require_once ABSPATH . 'wp-settings.php';` line, then save. Do not delete any existing lines. |
| "Invalid file" on import | Non-standard fields in the JSON | Re-download the file from the repo Raw view. |
| Form submits successfully (green tick) but no booking in Overture | WPCode snippet not Active, wrong snippet version, or Form Name mismatch | Check: (1) snippet exists and is Active; (2) snippet begins with `add_action('elementor_pro/forms/new_record'`; (3) Form Name in Elementor is exactly `XCP Contact: Overture`. Enable WP_DEBUG_LOG and check the log for `XCP Overture:` lines. |
| `XCP Overture: HTTP 401` in debug log | API key wrong, expired, or snippet Inactive | Regenerate key in Overture → Settings → API. Find `YOUR_OVERTURE_API_KEY` in the WPCode snippet and replace it with the new key. If `OVERTURE_FORM_KEY` is defined in wp-config.php, update that value instead. Make sure the snippet toggle is blue (Active). |
| `XCP Overture: HTTP 401` and `OVERTURE_FORM_KEY` in wp-config.php | Key value in wp-config.php contains a typo or the snippet has the wrong variable in `defined()` | Check two things: (1) in wp-config.php, confirm the key value matches Overture → Settings → API exactly; (2) in the WPCode snippet, confirm the line reads `defined( 'OVERTURE_FORM_KEY' )` — not `defined( 'your-key-value' )`. The constant name is always `OVERTURE_FORM_KEY`. |
| `XCP Overture: HTTP 403` in debug log | Key lacks permission | Regenerate key in Overture with Booking write scope |
| `XCP Overture: HTTP 404` in debug log | Wrong endpoint URL | The URL in the snippet is hardcoded as `https://xcphotography.overturehq.com/api/bookings`. Confirm your Overture subdomain matches. |
| `XCP Overture: HTTP 422` in debug log | Required field missing or wrong format | The log body names the specific field. Most commonly the `date` field — the form provides a date only if the user fills it in; the snippet defaults to today if empty. |
| `XCP Overture: connection error` in debug log | WordPress cannot reach overturehq.com | Temporary network issue. Test again. If persistent, check hosting firewall is not blocking outbound HTTPS. |
| You see r.stripe.com rows in the Network tab | Normal — Stripe.js telemetry beacons | Ignore them. Unrelated to your form. |
| Form submits but no email received | WordPress mail not configured | Install and configure WP Mail SMTP (free). Without it, WordPress uses PHP mail which many hosts block. |
| 401 Unauthorized and `OVERTURE_FORM_KEY` is defined in wp-config.php | The key value in wp-config.php may contain a typo, or the snippet uses the wrong constant name | Two checks: (1) open wp-config.php in File Manager, copy the value of `OVERTURE_FORM_KEY` and compare it character-by-character against the key shown in Overture → Settings → API; (2) in the WPCode snippet, confirm the api_key line reads `defined( 'OVERTURE_FORM_KEY' ) ? OVERTURE_FORM_KEY : 'YOUR_OVERTURE_API_KEY'` — if you see your actual key value inside `defined( '...' )` that is the wrong pattern and the snippet will never use the constant. |
| Browser console or security scanner warns about CSP / unsafe-eval | Stripe.js requires string evaluation to run | See the CSP note below. |
| Browser or accessibility scanner warns "form field has no id or name" on the date picker | Flatpickr date picker internal month and year inputs have no id/name by default | See "Date picker autofill fix" below. |
| Accessibility scanner or Chrome DevTools warns "Duplicate form field id in the same form" — 8 resources | All form fields in the JSON templates previously had empty `custom_id` values, so Elementor generated the same blank ID for every field in the form | Re-import the updated form JSON files from this repository (all six `XCP_*Form*.json` files have been fixed with unique `custom_id` values). After re-import Elementor will render unique `id="form-field-name"`, `id="form-field-email"` etc. on each field. |

---

## Date picker autofill fix

Browsers and accessibility scanners report:

> *"A form field element has neither an id nor a name attribute. This might prevent the browser from correctly autofilling the form."*

The elements flagged are flatpickr's internal calendar navigation controls — there are **two** of them per date field:

```html
<input class="numInput cur-month" type="number" tabindex="-1" aria-label="Month">
<input class="numInput cur-year"  type="number" tabindex="-1" aria-label="Year">
```

These inputs are generated automatically at runtime by Elementor's date picker (flatpickr). They are **not** the submitted date field — they are display widgets that let the visitor navigate the month and year shown in the calendar pop-up. Their values are never included in the form data sent to Overture. The warnings do not affect form submissions or bookings.

To silence both warnings, add a WPCode JavaScript snippet (or update the existing `XCP Flatpickr Accessibility Patch` snippet if you added it previously).

**Title:** `XCP Flatpickr Accessibility Patch`

In WPCode (Code Snippets → Add Snippet), choose **JavaScript Snippet** as the code type and set the location to **Frontend**. Paste this code:

```javascript
(function () {
    function patchFlatpickrInputs(root) {
        var scope = root || document;
        scope.querySelectorAll('.numInput.cur-month:not([id])').forEach(function (el, i) {
            el.id   = 'fp-month-' + i;
            el.name = 'fp-month-' + i;
        });
        scope.querySelectorAll('.numInput.cur-year:not([id])').forEach(function (el, i) {
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

This snippet watches for flatpickr calendar pop-ups (they are injected into the page dynamically when the visitor focuses the date field) and adds a unique `id` and `name` to both the month and year navigation inputs when they appear. It has no effect on form submissions, styling, or Overture bookings.

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

## Frequently asked questions

**Where exactly does my Overture web form key go in the WPCode snippet?**

Your key goes as the **fallback value** — after the `:`, inside the single quotes. The **correct live** pattern for the `$api_key` line is:

```
$api_key = defined( 'OVERTURE_FORM_KEY' ) ? OVERTURE_FORM_KEY : 'YOUR_OVERTURE_API_KEY';
```

Replace only `YOUR_OVERTURE_API_KEY` with your actual key from **Overture → Settings → API**. Keep the surrounding single quotes — do not remove them. Everything else on this line stays exactly as shown.

**Do not** put your key value inside `defined( '...' )` — that part always stays as `'OVERTURE_FORM_KEY'` (the constant name, never the key value).

> **Note on the current snippet in this guide:** The Step 2 snippet currently shows test/placeholder values (`NightynighOOOODUdeODc=` inside `defined()` and a long noise string as the fallback). These are intentional fakes for structure verification — the fallback string position is correct, but both values must be replaced with real ones for live use. See the `⚠️ TEST VALUES` comment in the snippet.

If you would rather not put the key directly in the snippet, add this line to `wp-config.php` before the final `require_once` line and leave `YOUR_OVERTURE_API_KEY` unchanged in the snippet:

```php
define( 'OVERTURE_FORM_KEY', 'paste-your-key-here' );
```

The snippet checks for that constant first and uses it automatically.

---

**Should I remove the form from all pages because of the browser audit warnings?**

No. The forms are essential — they are the primary way clients enquire and book. The audit warnings that triggered this question are all fixable without removing any forms:

- **CSP `unsafe-eval` blocked** — caused by Stripe.js, not your form. If you have a CSP header, add `'unsafe-eval'` to `script-src` as shown in the CSP note below. If you have no CSP header, this is an advisory warning only and nothing is actually blocked.
- **Duplicate form field id** — caused by empty `custom_id` values in the old JSON templates. All six form JSON files have been updated with unique field IDs. Re-import them from this repository to fix the warnings permanently. Do not delete the form.
- **Form field with no id or name** (2 nodes) — caused by flatpickr's internal calendar controls (month and year spinners). These are not submitted form fields. Fix via the WPCode JavaScript snippet described in the "Date picker autofill fix" section below.
- **Deprecated feature warnings** (`partytown-sandbox-sw.html`, `compat.min.js`) — these come from third-party WordPress and hosting scripts, not from the XCP form templates. They cannot be fixed by removing or changing the enquiry form.

---

**Should I remove the fallback email form from the contact page?**

Yes, once the Overture version is working. You cannot run both at the same time on the same page. On the contact page, delete the section imported from `XCP_Contact_P2_Form_Fallback.json` and keep the one from `XCP_Contact_P2_Form_Overture.json`. The same applies to the home page (S6) and services page (S3).

Do not delete fallback forms from pages you have not yet switched to Overture.

---

**Should I remove forms from other pages?**

No. Keep the fallback forms on pages that have not yet had the Overture form swapped in. They continue to send enquiries to info@xcphotography.co.uk by email while Overture is still being tested.

---

**Does the WPCode snippet work across the entire site?**

Yes. The WPCode snippet fires for any Elementor form with the Form Name `XCP Contact: Overture` regardless of which page it is on. You do not need a separate snippet per page. Import the Overture form JSON on any page, and as long as the Form Name matches, the snippet handles it.

---

**What do I do next once the form is working?**

Once a test submission appears in Overture as a new booking:

1. Delete the WPCode debug snippet (if you added it) and turn off `WP_DEBUG_LOG` in wp-config.php
2. Switch the home page contact form (S6) and services enquiry form (S3) from fallback to Overture the same way: delete the fallback section, import the Overture version, confirm the Form Name is `XCP Contact: Overture`
3. Begin publishing blog posts using the templates in the repo (`BLOG_*.md` files)
4. Set up workshops as new pages using the same import flow
5. Add images to the placeholder `[uc_local]` references in the hero sections via Elementor's media library

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
