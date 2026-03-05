# XCP Photography — Image Keywording and DAM Reference

---

## The Foundation: Why Keywords Come First

Search engines cannot see images. They can only read the words attached to them.

An image of Skunk Anansie at Concorde 2 Brighton is, to a search engine, meaningless
pixels until words describe it. The most striking photograph in the library is invisible
online without keywords. This is true whether the image lives on the website, in
Lightroom, on SmugMug galleries, on Alamy, or anywhere else.

The standard that runs through every keyword decision here is three words:

**Relevant. Accurate. Consistent.**

- **Relevant** — use the words people actually type when searching, not photography
  jargon or internal shorthand
- **Accurate** — only describe what is genuinely in the image, never keyword-stuff
  with terms that do not apply
- **Consistent** — the same subject always gets the same keyword, every time,
  across every platform

Without consistency, the same image filed under "headshot", "portrait", "head shot",
and "head photograph" becomes unfindable by anyone searching for any of those terms.

---

## The Three Layers of Keywording

Every image gets keywords applied in three layers, from specific to general.
This is how search works — people search at different levels of specificity.

### Layer 1: Specific (What is literally in this image)

The exact, precise content of this particular image.

Examples:
- `Concorde 2 Brighton` (not just "music venue")
- `Skunk Anansie` (not just "rock band")
- `Hotel du Vin Brighton` (not just "hotel")
- `Millennium Bridge London` (not just "bridge")
- `brand portrait woman natural light` (not just "portrait")

### Layer 2: Mid-level (Category and context)

What type of image this is, and what it is for.

Examples:
- `live music photography`
- `brand photography Brighton`
- `documentary street photography`
- `professional headshot`
- `event coverage`
- `fine art print`

### Layer 3: General (Broad searchable terms)

The widest terms that still accurately apply. These catch searches from people
who do not yet know the specific subject.

Examples:
- `photographer Brighton`
- `photography Sussex`
- `XC Photography`
- `UK photography`
- `documentary photography`

---

## Where Keywords Live (The Four Fields)

Keywords are not just website tags. They live in four places, and all four matter.

### 1. IPTC Metadata (embedded in the file itself)

This travels with the image wherever it goes. Set this in Lightroom before export.
It is the most important field because it cannot be lost.

**IPTC fields to fill for every image:**

| Field | What to put in it | Example |
|---|---|---|
| Title | One clear, descriptive sentence | `Brand photography session, Brighton — founder portrait` |
| Description / Caption | 2-3 sentences describing the image specifically | `Brand portrait of a female founder photographed in natural window light during a brand photography session in Brighton. Photographed by XC Photography.` |
| Keywords | Comma-separated keyword list (see category sets below) | `brand photography Brighton, professional portrait, natural light photography...` |
| Creator | Your name | `Xavier Clarke` |
| Credit | Your business name | `XC Photography` |
| Copyright | Copyright line | `Copyright XC Photography xcphotography.co.uk` |
| Location | City/country where shot | `Brighton, East Sussex, England` |
| Source | Platform/usage context | `xcphotography.co.uk` |

**Setting IPTC in Lightroom:**
Library module > select image(s) > Metadata panel (right side) > choose "IPTC"
from the dropdown. Fill every field above. Use Lightroom Metadata Presets
(Metadata > Edit Metadata Presets) to auto-fill Creator, Credit, and Copyright
on every image at import — so those three never need typing again.

### 2. Filename (before export)

Filenames are read by search engines. `IMG_4521.jpg` tells Google nothing.
`brand-photography-brighton-founder-portrait-xc-photography.jpg` is a search signal.

**Filename convention (descriptive, consistent, lower case, hyphens):**

```
[category]-[subject]-[location]-[detail]-xc-photography.jpg
```

Examples:
```
brand-photography-brighton-founder-portrait-xc-photography.jpg
live-music-concorde2-brighton-skunk-anansie-xc-photography.jpg
street-photography-millennium-bridge-london-xc-photography.jpg
documentary-event-slack-city-brighton-xc-photography.jpg
fine-art-print-hotel-du-vin-brighton-xc-photography.jpg
```

Set this as the export filename in Lightroom:
File Naming > Edit > use tokens: `{custom_text}-xc-photography` and rename
before export, or batch rename using Library > Rename Photos.

### 3. Alt Text (on the website and SmugMug galleries)

Alt text is what screen readers read and what Google indexes for image search.
Every image on every page must have unique alt text. Empty alt text is a failure
on both accessibility and SEO.

**Format:**
```
[Descriptive subject], [XC Photography], [location if relevant]
```

**Rules:**
- Never start with "photo of" or "image of" — Google ignores those words
- Never leave blank
- Never use the filename as alt text
- Keep under 125 characters
- Include Brighton or Sussex on at least half of all website images

**Examples:**
```
Brand portrait session, XC Photography Brighton — founder in natural window light
Live music photography at Concorde 2 Brighton — headline act in stage lighting
City Spirit documentary photography, Millennium Bridge London — long exposure at dusk
Fine art photography print, Hotel du Vin Brighton — Brighton Spirit Collection
```

### 4. Page/Gallery Title and Description (SmugMug galleries, website, Lightroom collections)

The words surrounding an image on a page also contribute to how it is found.
Gallery titles, page headings, and captions all feed into search ranking.

Use the same language that is in the IPTC keywords — consistency across all four
fields is what makes the keyword strategy work.

---

## Controlled Vocabulary: The Master Keyword List

A controlled vocabulary means you always use the same word for the same thing.
Never switch between "headshot" and "head shot", between "Brighton" and "Brighton,
East Sussex", between "Concorde 2" and "Concorde2".

The list below is the controlled vocabulary for XCP Photography.
Use these exact terms, every time.

### People and subjects
```
founder portrait
business portrait
brand portrait
executive portrait
creative portrait
female founder
male founder
team photograph
professional headshot
LinkedIn headshot
```

### Services (what the photography is for)
```
brand photography
brand photographer
personal brand photography
documentary photography
documentary photographer
live music photography
music photographer
street photography
fine art photography
event photography
event photographer
corporate photography
```

### Locations (always spell in full, consistently)
```
Brighton
Brighton East Sussex
Brighton UK
Sussex
East Sussex
London
UK
England
Concorde 2 Brighton
Hotel du Vin Brighton
Millennium Bridge London
```

### Quality and style descriptors (use sparingly, only when accurate)
```
natural light photography
available light photography
no flash photography
candid photography
editorial photography
cinematic photography
black and white photography
colour photography
long exposure photography
```

### Business and brand terms (for SEO relevance)
```
XC Photography
xcphotography
xcphotography.co.uk
brand imagery
brand identity photography
visual storytelling
```

---

## Category Keyword Sets (Ready to Apply in Batches)

Select all images in a category in Lightroom, apply the relevant set as a
batch, then add specific Layer 1 keywords to individual images afterwards.

### Brand Photography

**Batch keywords (apply to all images in category):**
```
brand photography Brighton, brand photographer Brighton, brand photography Sussex,
personal brand photography, commercial photography Brighton, brand portrait Brighton,
professional photography Brighton, brand imagery, visual storytelling Brighton,
XC Photography, xcphotography, brand photographer UK, business photography Brighton,
professional headshot Brighton, brand photographer, brand photography UK
```

**Then add per image (Layer 1 specifics):**
- Client business sector (e.g. `hospitality photography`, `creative agency photography`)
- Specific location if on location (e.g. `Brighton seafront`, `London studio`)
- Subject gender/role if relevant and accurate
- Style note (e.g. `natural light portrait`, `environmental portrait`)

---

### Portraits and Headshots

**Batch keywords:**
```
portrait photographer Brighton, headshot photographer Brighton, professional headshot
Brighton, corporate headshot Sussex, business portrait Brighton, LinkedIn headshot
Brighton, personal brand portrait, natural light portrait, XC Photography portrait,
portrait photography Brighton, professional portrait Brighton, headshot photography UK
```

**Per image additions:**
- Subject context: `founder portrait`, `creative professional portrait`, `team headshot`
- Location: `Brighton studio`, `on location Brighton`, `natural light window`

---

### Live Music and Performance

**Batch keywords:**
```
music photographer Brighton, live music photography Brighton, concert photography
Brighton, gig photographer Sussex, performance photography UK, editorial music
photography, pit photography, no flash photography, available light photography,
XC Photography music, Brighton music scene, live music photographer UK
```

**Per image additions:**
- Venue name: `Concorde 2 Brighton`
- Artist name if known and correct: `Skunk Anansie`, `Beach Boys`, `Gomez`
- Style: `concert photography`, `stage lighting photography`, `front of house photography`

---

### City Spirit and Street

**Batch keywords:**
```
street photography Brighton, city spirit photography, documentary photography Brighton,
urban photography UK, fine art street photography, city documentary photography,
XC Photography city spirit, UK street photography, documentary photographer Brighton
```

**Per image additions:**
- Specific location: `Millennium Bridge London`, `Brighton seafront`, `Brighton Lanes`
- Country/city if not Brighton: `Paris street photography`, `Barcelona photography`
- Style: `long exposure photography`, `black and white street photography`

---

### Documentary and Events

**Batch keywords:**
```
documentary photographer Brighton, event photographer Brighton, event photography Sussex,
documentary photography UK, business event photography Brighton, conference photographer,
community photography Brighton, corporate event photographer Sussex, reportage photography,
XC Photography events, Sussex event photographer, Sussex Business Show photography
```

**Per image additions:**
- Event name where known: `Sussex Business Show`, `Slack City Brighton`
- Event type: `networking event photography`, `conference photography`, `workshop photography`

---

### Fine Art and Prints

**Batch keywords:**
```
fine art photography prints UK, photography prints for sale, fine art prints Brighton,
limited edition photography prints, wall art photography, photographic prints UK,
XC Photography prints, Brighton Spirit Collection, Hotel du Vin Brighton photography,
gallery photography Brighton, exhibition photography, collectible photography
```

**Per image additions:**
- Edition details if limited: `limited edition print`, `edition of 25`
- Series name: `Brighton Spirit Collection`, `City Spirit series`, `Millennium series`
- Subject of print: `Brighton seafront print`, `Millennium Bridge London print`

---

## Lightroom Workflow: Step by Step

This is the sequence for every image that leaves Lightroom, whether for the website,
SmugMug galleries, social media, or a client delivery.

**1. At import:**
- Apply a metadata preset that auto-fills: Creator, Credit, Copyright, Source
- Set up once in Metadata > Edit Metadata Presets, apply at every import

**2. During cull and edit:**
- Star-rate and colour-label images before keywording — only keyword selects, not rejects
- No point keywording images that will never be used

**3. Before export — IPTC:**
- Add Title (one sentence, descriptive)
- Add Description/Caption (2-3 sentences, specific)
- Add Keywords using the relevant category batch set, then Layer 1 specifics

**4. Rename before export:**
- Use the filename convention: `category-subject-location-detail-xc-photography.jpg`
- Lightroom: File > Export > File Naming > choose or create naming template

**5. Export settings for web:**
- Format: JPEG
- Quality: 80-85 (not 100 — unnecessarily large)
- Colour space: sRGB (not Adobe RGB — browsers cannot display it correctly)
- Resize: longest edge 2000px for portfolio/gallery, 1200px for thumbnails
- Sharpen for screen: Standard

**6. After export — website alt text:**
- Open WordPress media library
- Find the uploaded image
- Add alt text following the format in this document
- Add caption if the image appears with a caption on the front end

---

## SmugMug Keywording (Per Gallery)

SmugMug galleries are indexed by Google. Treat them as SEO pages, not just image stores.

For every gallery:
- **Gallery title:** descriptive + location. `Brand Photography Brighton | XC Photography`
- **Gallery description:** 2-3 sentences using the same language as the keyword sets.
  Include `Brighton`, `Sussex` or `UK` naturally in the first sentence.
- **Keywords field:** paste the relevant batch set from this document

For every individual image in SmugMug:
- **Caption:** the IPTC Description field (copy across from Lightroom)
- **Keywords:** the IPTC Keywords (SmugMug reads these from the file automatically
  if "Read metadata from files" is enabled in SmugMug settings)

Enable SmugMug metadata sync: Account > Settings > Privacy and Sharing >
"Allow SmugMug to read metadata from your photos" — ON.

---

## What Not to Do

Based on common keywording mistakes that make images invisible:

- **Do not use the same keyword list on every image.** A keyword that applies to
  everything is specific to nothing. Batch keywords set the category baseline;
  individual images need their own Layer 1 specifics on top.

- **Do not keyword-stuff.** Adding irrelevant terms (e.g. adding `London` to a
  Brighton image because London gets more searches) damages credibility with search
  algorithms and is flagged by stock library review systems.

- **Do not ignore IPTC.** Website tags and SmugMug keywords help. But IPTC metadata
  travels with the file forever. It is the most durable form of keywording and the
  one that matters most if images are ever licensed, syndicated, or re-uploaded anywhere.

- **Do not leave alt text empty.** Every blank alt text field is a missed SEO
  opportunity and an accessibility failure. Screen reader users cannot understand
  the page without it.

- **Do not use inconsistent spelling.** Pick one form and use it always. `Concorde 2`
  not `Concorde2` or `The Concorde`. `Hotel du Vin` not `Hotel Du Vin` or `HDV`.

---

## Resources

**Keywording education for photographers** — search for keywording courses,
stock library guides, and metadata training designed for independent creatives.
The Individual Creatives level of specialist keywording platforms typically runs
around £96/year and covers toolkits for Alamy and Getty, online courses, and
live community sessions. Worth exploring once the Elementor site is live and
stock library submission begins.

---

## Phase 2 (After Elementor Site Is Live)

Once the site is live and galleries are structured, the following will be built:

- Per-image alt text written for every image in the live portfolio
- IPTC keyword presets set up directly in Lightroom for each category
- Stock library keyword sets for Alamy (built against actual stock library requirements)
- Client-sector specific vocabulary additions (hospitality, music, medical cannabis,
  creative agencies) mapped against actual search volume data
- SmugMug gallery keyword audit aligned to the live gallery structure
