# 🔑 Overture CRM — Contact Form Setup Guide

**The single reference for connecting your XCP contact form to Overture.**

> **Short answer to "where do I add the API key?"**
> In WordPress, open the Contact page in Elementor → click the form widget → **Content tab → Additional Options → Custom Headers** → add `Authorization` = `Bearer YOUR_KEY`. That's it. The form will work as expected.

---

## Prerequisites

| What you need | Where to find it |
|---|---|
| Overture account active | [app.overture.studio](https://app.overture.studio) (or your Overture instance URL) |
| Your Overture API key | Overture Admin → **Settings → Integrations → API Keys** → copy Bearer token |
| WordPress + Elementor Pro installed | Must be Elementor Pro (free version has no webhook action) |
| Contact page imported from JSON | Use `XCP_Contact_P2_Form_Overture.json` — see [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) |

---

## Step 1 — Get Your API Key from Overture

1. Log in to your Overture dashboard
2. Go to **Settings** (bottom-left cog icon)
3. Click **Integrations** → **API Keys**
4. Copy your API Bearer token — it will look like a long alphanumeric string

> **Keep this safe.** Treat it like a password. Do not commit it to GitHub.

---

## Step 2 — Add the API Key in Elementor

1. In WordPress admin, go to **Pages → Contact**
2. Click **Edit with Elementor**
3. Click on the **form widget** (the enquiry form in Section 2)
4. In the left panel, click the **Content** tab
5. Scroll down to **Additional Options**
6. Find **Custom Headers** — add one header:

| Header name | Header value |
|---|---|
| `Authorization` | `Bearer YOUR_OVERTURE_API_KEY` |

> Replace `YOUR_OVERTURE_API_KEY` with the token you copied in Step 1. Include the word `Bearer` followed by a space before the key.

---

## Step 3 — Set the Webhook URL

In the same form widget, still on the **Content** tab:

1. Find the **Actions After Submit** area — confirm **Webhook** is listed (it is, in the JSON)
2. Find the **Webhook URL** field and set it to:

```
https://YOUR-OVERTURE-INSTANCE.overture.studio/api/bookings
```

> Replace `YOUR-OVERTURE-INSTANCE` with your actual Overture subdomain or custom domain. The endpoint is always `/api/bookings` — this is the Overture Booking API `POST` endpoint.

**Method:** `POST` (Elementor's webhook action always uses POST — this matches the Overture API spec.)

---

## Step 4 — Confirm Email Action Still Active

While you're in the form settings, confirm the **Actions After Submit** includes both:

- ✅ **Email** — sends you a notification copy
- ✅ **Webhook** — posts to Overture

Both should already be set in the imported JSON. If email is missing, add it and configure the recipient as `hello@xcphotography.co.uk`.

---

## Step 5 — Save & Test

1. Click **Update** in Elementor to save
2. Open the Contact page in a browser
3. Fill in the test form with real-looking data and submit
4. Check your **Overture dashboard → Bookings** — a new Pending booking should appear within seconds
5. Check your email inbox — the notification copy should also arrive

> If the booking does not appear in Overture, the most common causes are: wrong API key, wrong webhook URL, or the Overture API key lacks Booking write permission. See Troubleshooting below.

---

## Field Mapping Reference

The form field IDs in `XCP_Contact_P2_Form_Overture.json` are set to match the Overture Booking API field names exactly. **No transformation required.** What the visitor types goes directly into the correct Overture field.

| Form label shown to visitor | `field_id` in JSON | Overture API field | Resource created |
|---|---|---|---|
| Your Name | `promoterName` | `promoterName` | Booking |
| Type of Project | `name` | `name` (booking title) | Booking |
| Preferred Shoot Date | `date` | `date` | Booking |
| County / Region | `venueState` | `venueState` | Booking |
| Country | `venueCountry` | `venueCountry` | Booking |
| Brand & Vision message | `message` | `info[]` array note | Booking |
| Email Address | `email` | Links to Person record | Overture auto-matches / creates |
| Phone Number | `phone` | Attached to Person record | Overture auto-matches / creates |
| Source URL (hidden) | `source` | Source tag | Booking |

> **Status:** All bookings created via the API default to `status: "Pending"` in Overture. They appear in your dashboard ready to action.

---

## Address Resource — What It Is & When to Use It

The Overture Address API (`POST /api/addresses`) allows you to record a shoot location address against a Person or booking.

**You do not need Address fields on the contact form.** Here is why:

- At enquiry stage, the exact shoot address is rarely known
- `venueState` (county/region) and `venueCountry` on the form give enough location context to filter and respond
- Once you have spoken to the client and confirmed a shoot location, **add the address directly in Overture** against their Person record:
  - Overture → People → find the person → Add Address
  - Fields: `line1`, `line2`, `line3`, `city`, `state`, `country`, `zip`
  - `label`: set to `"Shoot Location"` to distinguish from billing address

This keeps the contact form clean and fast for prospects while giving you full address capability in the CRM post-enquiry.

---

## Fallback: No Overture Account Yet?

Import `XCP_Contact_P2_Form_Fallback.json` for Section 2 of the Contact page instead. It is a plain Elementor form that sends enquiries by email only — no API required. All field IDs are identical, so when you connect Overture later you can swap the section without losing any form history.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| No booking appears in Overture | Wrong API key | Re-copy the Bearer token from Overture → Settings → API Keys |
| No booking appears in Overture | Wrong webhook URL | Confirm the URL matches your Overture instance exactly |
| 403 error in Elementor logs | API key lacks permission | Check the key has Booking write scope in Overture |
| 422 error | Required field missing or wrong format | Check `date` field is ISO 8601 (YYYY-MM-DD). The Elementor date picker outputs this format by default |
| Email notification not received | Email action not configured | Add Email action in form → Additional Options → Actions After Submit |
| Form submits but shows generic error | Overture API is unreachable | Check Overture service status; confirm your server can make outbound POST requests |

---

## Quick Reference Card

```
Overture API key:   Settings → Integrations → API Keys → copy Bearer token
Elementor location: Form widget → Content → Additional Options → Custom Headers
Header name:        Authorization
Header value:       Bearer YOUR_OVERTURE_API_KEY
Webhook URL:        https://YOUR-OVERTURE-INSTANCE/api/bookings
Method:             POST (automatic)
New booking status: Pending (automatic)
Address:            Add in Overture after enquiry — not on the form
```

---

*Part of the XCP Branding repository. See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
