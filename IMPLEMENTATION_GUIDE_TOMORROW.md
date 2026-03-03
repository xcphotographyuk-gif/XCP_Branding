# XC Photography — Implementation Guide
## Everything built in this session, step by step

**Work through this guide in order. Estimated total time: 3–4 hours.**

---

## OVERVIEW — What was built

| # | Deliverable | File | Time |
|---|---|---|---|
| A | Overture contact form: page tag + email opt-in | `XCP_Contact_P2_Form_Overture.json` | 20 min |
| B | Fallback contact form: same additions | `XCP_Contact_P2_Form_Fallback.json` | 5 min |
| C | Coming soon page Elementor template | `XCP_Coming_Soon_Page.json` | 30 min |
| D | Lead magnet PDF (services & workshops guide) | `XCP_Lead_Magnet_Services_Guide.md` | 20 min |
| E | Lightroom plugin — 3 missing files completed | `XCPImageTagger.lrplugin/` | 45 min |

---

---

# PART A — OVERTURE CONTACT FORM: PAGE TAG + EMAIL OPT-IN

**File to use:** `XCP_Contact_P2_Form_Overture.json`

**What was added:**
- A hidden `page_source` field that automatically captures which page the enquirer was on when they submitted — so Overture tags every contact with the source page URL
- A marketing opt-in checkbox (optional, separate from GDPR consent)
- Webhook tags `source:contact-form` sent to Overture with every submission

---

### A1 — Re-import the form into Elementor

1. Log into WordPress → go to the **Contact page** in Elementor
2. The existing contact form section is built from `XCP_Contact_P2_Form_Overture.json`
3. To update it: click the existing form widget → **Edit** → note the current webhook URL (you'll need it in step A3)
4. Delete the old form section
5. **Add Template** → Import → upload `XCP_Contact_P2_Form_Overture.json` → insert section

> **Alternative (quicker):** If you don't want to re-import, add the two fields manually inside the existing form widget — instructions below in A2.

---

### A2 — Set the page_source dynamic tag (CRITICAL)

The `page_source` field only works if Elementor populates it automatically with the current page URL.

1. In Elementor, click the **form widget** to open its settings
2. In the **Form Fields** list, find the row labelled **Page Source**
3. Click that row to expand it
4. In the **Default Value** input field, click the **grid/diamond icon** on the right — this opens Elementor's dynamic tags picker
5. Select **"Site" → "Current URL"** (or search for "URL")
6. The field will now auto-fill with the URL of whatever page this form lives on when a visitor submits

> **Why this matters:** Every enquiry in Overture will carry the exact page URL. If someone enquires from the Services page, Overture shows `/services`. If from the Blog, it shows the post URL. You can filter and segment by source page.

---

### A3 — Confirm the Overture webhook URL is set

1. In the form widget settings, scroll to **Actions After Submit**
2. Check that **Webhook** is listed as an action
3. Click Webhook → confirm the URL is: `https://api.overture.studio/v1/enquiries`
4. If you have a different Overture webhook URL, replace it here

---

### A4 — Update the fallback form (XCP_Contact_P2_Form_Fallback.json)

The fallback form (used if Overture is down or not yet active) has had the same two fields added. Update it in Elementor the same way as above — or simply add the same Page Source hidden field and marketing opt-in checkbox to the existing fallback form widget.

---

### A5 — Test the form

1. Preview the Contact page
2. Fill in the form (use a real email address you have access to)
3. Submit
4. In Overture: check the new contact appeared and verify:
   - The `page_source` field shows the contact page URL
   - Tags `source:contact-form` are attached to the contact record

---

---

# PART B — COMING SOON PAGE

**File to use:** `XCP_Coming_Soon_Page.json`

**What it contains:** Hero section → sign-up form → download teaser → credentials strip (full portfolio) → footer.

---

### B1 — Create the WordPress page

1. WordPress dashboard → **Pages → Add New**
2. Title: **Coming Soon**
3. Slug: `/coming-soon` (check this in the URL field under the title)
4. Page template: set to **Elementor Canvas** (removes header and footer — clean standalone page) — *or* leave as default if you want the site header/footer to remain visible
5. Click **Edit with Elementor**

---

### B2 — Import the template

1. In Elementor, click the **folder icon** in the bottom bar (Insert Template)
2. Go to **My Templates → Import Template**
3. Upload `XCP_Coming_Soon_Page.json`
4. Click **Insert** — the full five-section layout will appear

---

### B3 — Set the page_source dynamic tag on the sign-up form

Same process as A2 above:

1. Click the form widget in the coming soon page
2. Find the **Page Source** field row in the Form Fields list
3. Set its Default Value to the **Current URL** dynamic tag

The `lead_tag` hidden field is already set to the static value `coming-soon-signup` — no action needed on that one.

---

### B4 — Confirm the Overture webhook

Same as A3 — verify the webhook URL points to your Overture endpoint.

---

### B5 — Update the email address in the footer

The footer currently shows `hello@xcphotography.co.uk` — update this to your actual email address if it's different.

---

### B6 — Publish the page

1. Click **Publish** in Elementor
2. Visit `https://xcphotography.co/coming-soon` to confirm it looks correct
3. On mobile: check the form and credentials strip are readable

---

---

# PART C — LEAD MAGNET: SERVICES & WORKSHOPS GUIDE (PDF)

**File to use:** `XCP_Lead_Magnet_Services_Guide.md`

This is the downloadable document leads receive when they sign up on the coming soon page (or the contact form). It contains all services, session types, workshop formats, and pricing.

---

### C1 — Convert to PDF

**Option 1 — Google Docs (easiest):**
1. Open Google Docs → **File → Open → Upload** → select `XCP_Lead_Magnet_Services_Guide.md`
2. Google Docs will render the Markdown as a document
3. **File → Download → PDF Document (.pdf)**
4. Rename the downloaded file: `xcp-photography-services-guide.pdf`

**Option 2 — Pandoc (command line, best quality):**
```
pandoc XCP_Lead_Magnet_Services_Guide.md -o xcp-photography-services-guide.pdf --pdf-engine=wkhtmltopdf
```

**Option 3 — VS Code:**
Install the "Markdown PDF" extension → right-click the file → **Export (pdf)**

> **Before converting:** Consider opening the .md file and adding your logo image at the top — insert a line like `![XC Photography](xcp-logo.png)` before the first heading, then run the conversion with the logo file in the same folder.

---

### C2 — Upload to WordPress Media Library

1. WordPress dashboard → **Media → Add New**
2. Upload `xcp-photography-services-guide.pdf`
3. After upload, click the file → copy the **File URL** from the right panel
4. It will look like: `https://xcphotography.co/wp-content/uploads/2026/03/xcp-photography-services-guide.pdf`
5. **Save this URL** — you need it in C3 and C4

---

### C3 — Set up Overture automation to deliver the PDF

This is the automated delivery when someone signs up on the coming soon page:

1. Log into Overture
2. Go to **Automations → Create Automation**
3. **Trigger:** Contact created with tag `coming-soon-signup`
4. **Action:** Send email
5. Email content:

   > **Subject:** Your XC Photography Services & Workshops Guide
   >
   > Hi [first_name],
   >
   > Thank you for signing up — here's your copy of the XC Photography Services & Workshops Guide.
   >
   > [Download your free guide →](PASTE_PDF_URL_HERE)
   >
   > I'll be in touch when the new site goes live with everything else that's coming.
   >
   > Xavier  
   > XC Photography | xcphotography.co.uk

6. Replace `PASTE_PDF_URL_HERE` with the URL from C2
7. Save and activate the automation

> **Alternatively — use Elementor's form email action instead:** In the coming soon form widget → Actions After Submit → Email → set the email body to include the PDF link. This fires immediately without needing Overture automation. Use this if Overture automation isn't set up yet.

---

### C4 — Optional: Add a direct download button to the coming soon page

If you want visitors to also be able to download without signing up (lower friction):

1. In Elementor, open the coming soon page
2. In the "Free Download" section, add a **Button** widget
3. Link: paste the PDF URL from C2
4. Text: **Download the Guide (Free)**
5. Open in new tab: yes
6. Style: platinum/white gold button (`#E8E4DC` background, `#000000` text)

---

---

# PART D — LIGHTROOM PLUGIN INSTALLATION AND USE

**Folder to use:** `XCPImageTagger.lrplugin/`

**Status:** The plugin is now complete. Three previously missing files have been created:
- `XCPExportServiceProvider.lua` — allows the plugin to appear as an Export destination
- `BrandVoiceSettings.lua` — the Brand Voice Settings menu item
- `PrepareAndExport.lua` — the Export menu combine action

---

### D1 — Install the plugin

1. In your file browser, locate the `XCPImageTagger.lrplugin` folder from this repository
2. Copy or move it to a permanent location — for example:
   - **Mac:** `~/Library/Application Support/Adobe/Lightroom/Modules/`
   - **Windows:** `C:\Users\[YourName]\AppData\Roaming\Adobe\Lightroom\Modules\`
   - Or anywhere on disk — Lightroom just needs to know where it is
3. Open **Lightroom Classic**
4. Go to **File → Plug-in Manager** (or press Ctrl/Cmd + Alt + Shift + ,)
5. Click **Add**
6. Navigate to and select the `XCPImageTagger.lrplugin` folder
7. Click **Add Plug-in**
8. The plugin should appear as **"XCP Platform Publisher"** with status **"Installed and running"**
9. Click **Done**

---

### D2 — Configure brand settings (do this first)

1. In Lightroom, go to **Library → Plug-in Extras → Brand Voice Settings...**
2. Set:
   - **Photographer Credit:** Xavier Clarke *(or XC Photography — whichever you want on image metadata)*
   - **Instagram Handle:** @xcphotography
   - **Website:** xcphotography.co.uk
   - **Default Location:** Brighton, United Kingdom
   - **Brand Voice:** Documentary & Authentic *(recommended for XCP)*
   - **UK English:** ticked
3. Click **Save Settings**
4. Alternatively, the same settings are in **File → Plug-in Manager → XCP Platform Publisher** if you want to configure AI assistant options too

---

### D3 — Prepare images for Instagram

1. Select photos in the **Library** module (any number)
2. Go to **Library → Plug-in Extras → Prepare for Instagram**
3. In the dialog:
   - **Privacy Mode:** leave ticked (no image data sent externally)
   - **Brand Voice:** Documentary & Authentic
   - **Add location hashtags:** tick if you have GPS data or location in metadata
   - **Include photographer credit:** tick
   - **Additional Hashtags:** paste any standard hashtag block you always use
4. Click **Prepare**
5. When done, check the metadata panel:
   - **Caption** field: Instagram caption with hashtags
   - **Title** field: auto-generated title
   - Custom field **Instagram Ready:** shows "Ready to Post"
   - Custom field **Instagram Caption:** the caption for easy copy-paste

---

### D4 — Prepare images for the website

1. Select photos
2. **Library → Plug-in Extras → Prepare for Website Gallery**
3. In the dialog:
   - **Website Section:** Portfolio Gallery *(or Blog Post if preparing blog images)*
   - **Brand Voice:** Documentary & Authentic
   - **Optimize titles for SEO:** tick *(keeps titles under 60 characters)*
   - **Generate accessibility alt text:** tick
   - **Include location:** tick if relevant
4. Click **Prepare**
5. Check metadata:
   - **Title:** SEO-optimized title (60 chars max)
   - **Caption:** professional website description
   - **Headline:** used as accessibility alt text
   - Custom field **Website Ready:** "Ready to Publish"
   - Custom field **Website Alt Text:** the alt text string

---

### D5 — Prepare images for Print Shop

1. Select photos
2. **Library → Plug-in Extras → Prepare for Print Shop**
3. In the dialog:
   - **Print Type:** Fine Art Print *(or Canvas, Metal, etc.)*
   - **Description Style:** Elegant & Refined
   - **Limited Edition Print:** tick
   - **Edition Size:** 25 *(or whatever your actual edition is)*
   - **Series Name:** optional — e.g. "Brighton After Dark" or leave blank
   - **Include framing notes:** tick
4. Click **Prepare**
5. The caption will include edition size, certificate note, and framing recommendation

---

### D6 — Multi-Platform Preparation (recommended workflow)

This is the most efficient option — prepares for up to three platforms at once and stores all content in the IPTC Instructions field so it's all in one place.

1. Select photos
2. **Library → Plug-in Extras → Multi-Platform Preparation...**
3. Tick the platforms you want: Instagram, Website, Print Shop *(or any combination)*
4. In the IPTC Creator Information section, fill in your details *(they auto-fill from prefs after first use)*
5. Tick **Privacy Mode**
6. Click **Prepare All**
7. After processing, find all platform content in:
   - **Metadata panel → IPTC → Instructions** — this field contains the full output for all platforms, labelled by section
   - Each platform's custom field also shows its Ready status

---

### D7 — Prepare & Export (single-click workflow)

When you're ready to actually export files after preparing metadata:

1. Select photos
2. **File → Export with Previous** — or use the Export menu item: **Prepare & Export for Platform...**
3. In the dialog, choose your target platform and brand voice
4. Click **Prepare & Export**
5. The plugin writes all metadata to the catalog, then opens Lightroom's standard Export dialog
6. In the Export dialog: choose your destination folder, file format (JPEG, recommended), and quality
7. Click **Export**

---

### D8 — Viewing custom metadata fields

To see all custom XCP fields in the Metadata panel:

1. In the Library module, open the Metadata panel (right-hand panel)
2. Click the dropdown at the top of the Metadata panel (it probably says "Default" or "EXIF")
3. Select **"XCP Platform Publisher"** from the list
4. You'll see all custom fields: Instagram Ready, Website Ready, Print Ready, Photo Style, Last Prepared, etc.

---

### D9 — Troubleshooting the plugin

**Plugin doesn't appear in the Library menu:**
- File → Plug-in Manager → confirm XCP Platform Publisher shows "Installed and running"
- If it shows an error, click the plugin name to see the error detail
- Most common cause: the plugin folder path has moved since you added it — click Remove and re-Add

**Lightroom log for errors:**
- Mac: `~/Library/Logs/Adobe/Lightroom/`
- Windows: `C:\Users\[YourName]\AppData\Local\Temp\`
- Look for `XCPImageTagger.log`

**No content being generated:**
- Make sure at least some metadata exists on the photos — even just keywords or a collection name helps the content engine
- The plugin works entirely from existing metadata in Privacy Mode, so the richer your existing keywords and captions, the better the output

---

---

# QUICK REFERENCE — Tomorrow's order of work

Run through in this order to minimise time:

| Order | Task | Time |
|---|---|---|
| 1 | Convert lead magnet MD → PDF (Google Docs) | 5 min |
| 2 | Upload PDF to WordPress Media, copy URL | 3 min |
| 3 | Install Lightroom plugin | 5 min |
| 4 | Configure plugin brand settings (D2) | 3 min |
| 5 | Set up Overture email automation with PDF link (C3) | 15 min |
| 6 | Update Overture form in Elementor — set page_source dynamic tag (A2) | 10 min |
| 7 | Create Coming Soon page in WordPress (B1–B3) | 20 min |
| 8 | Test the coming soon sign-up form end-to-end (B5–B6) | 10 min |
| 9 | Test the contact form — verify page_source tag in Overture (A5) | 10 min |
| 10 | Run multi-platform prep on 10 test images in Lightroom (D6) | 15 min |

**Total: approximately 1.5–2 hours for the website work. Plugin is independent and can be done any time.**

---

*XC Photography · Implementation Guide · Generated March 2026*
