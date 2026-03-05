# 🔑 Overture CRM — Contact Form Setup Guide

**The single reference for connecting your XCP contact form to Overture.**

---

## ✅ Quick Setup (3 steps)

**Step 1 — Import the form JSON**

Import `XCP_Contact_P2_Form_Overture.json` on your Contact page. The webhook URL is already set inside: `https://xcphotography.overturehq.com/api/bookings`

**Step 2 — Add your API key**

In WordPress → Pages → Contact → Edit with Elementor:
1. Click the **form widget**
2. Go to the **Advanced** tab in the left panel
3. Find **Custom Headers** and add one entry:

| Header name | Header value |
|---|---|
| `Authorization` | `Bearer [YOUR_OVERTURE_API_KEY]` |

> Replace `[YOUR_OVERTURE_API_KEY]` with the token from Overture → Settings → Integrations → API Keys.
> Keep the word `Bearer` and a space before the key.
> ⚠️ **Do not** add the API key as a hidden form field — it must be in Custom Headers only.

**Step 3 — Save and test**

Click **Update** in Elementor. Submit a test enquiry. Check Overture → Bookings — a new Pending booking should appear within seconds.

---

## Confirmed Settings

| Setting | Value |
|---|---|
| Webhook URL | `https://xcphotography.overturehq.com/api/bookings` |
| HTTP Method | POST (automatic — Elementor always uses POST) |
| Authorization location | Form widget → Advanced tab → Custom Headers |
| Header name | `Authorization` |
| Header value | `Bearer [YOUR_OVERTURE_API_KEY]` |
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
| No booking in Overture | Wrong API key | Re-copy Bearer token from Overture → Settings → API Keys |
| No booking in Overture | Wrong webhook URL | Confirm URL: `https://xcphotography.overturehq.com/api/bookings` |
| 403 error | API key lacks permission | Check key has Booking write scope in Overture |
| 422 error | Required field missing or wrong format | Check `date` field outputs ISO 8601 (YYYY-MM-DD) |
| Form submits but shows error | Overture unreachable | Check Overture status; confirm server allows outbound POST |

---

*See [JSON_IMPORT_INDEX.md](JSON_IMPORT_INDEX.md) for the full page-by-page import guide.*
