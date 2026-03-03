# Special Characters Reference
## Copy-Paste Ready for Elementor Widget Editor

When typing directly into Elementor's text or heading widget, special characters
can be tricky to produce reliably from the keyboard. Use this page to copy and
paste the exact character you need.

---

## Characters in Use Across XCP Templates

### Em Dash — (U+2014)
Used for: strong pauses, asides, separating clauses with emphasis.
> Example: *"Partnership, not just photography — your vision, elevated."*

**Copy this:**
```
—
```

**HTML entity alternative (for HTML widget/custom HTML blocks):**
```
&mdash;
```

**When to use:**  
Long pause or break. Stronger than a comma, more flowing than a full stop mid-sentence.  
*Correct:* `Documentary work — real stories, told with clarity.`  
*Not:* `Documentary work -- real stories` (double hyphen is not the same)

---

### En Dash – (U+2013)
Used for: ranges (times, dates, pages).
> Example: *"Mon–Fri: 9:00 – 18:00"*

**Copy this:**
```
–
```

**HTML entity alternative:**
```
&ndash;
```

**When to use:**  
Between two values in a range. Not for pauses (use em dash for those).  
*Correct:* `10:30–16:00`, `UK–Europe`  
*Not:* `10:30 - 16:00` (hyphen is not an en dash)

---

### Right Single Quote / Apostrophe ' (U+2019)
Used for: possessives and contractions in body copy.
> Example: *"Your brand's story"*, *"Let's talk"*

**Copy this:**
```
'
```

**When to use:**  
Anywhere a typographic apostrophe is needed. In Elementor's visual editor,
typing a straight apostrophe `'` usually auto-converts — but if it doesn't,
copy-paste this character instead.

**Note:** Straight apostrophe `'` (keyboard key) works in HTML and code but
looks less polished in headline and display text.

---

### Non-Breaking Space (U+00A0)
Used for: keeping words together (e.g. brand partners separator line).
> Example: *"Slack City &nbsp;•&nbsp; Hotel du Vin Brighton"*

**HTML entity (use this in Elementor HTML/text widgets):**
```
&nbsp;
```

**When to use:**  
- Between a bullet separator and a brand name so they don't line-break awkwardly
- Between a number and its unit: `10&nbsp;years`, `£800&nbsp;+&nbsp;VAT`

---

### Bullet Point • (U+2022)
Used for: decorative separator dots in brand partner lines and inline lists.

**Copy this:**
```
•
```

**HTML entity alternative:**
```
&bull;
```

---

### Ellipsis … (U+2026)
Not currently in templates but frequently needed in subheadings and captions.

**Copy this:**
```
…
```

**HTML entity alternative:**
```
&hellip;
```

**Note:** Use `…` not three full stops `...` in display text — the spacing is different and it looks more polished.

---

## Quick Reference Table

| Character | Name | Copy | HTML Entity |
|---|---|---|---|
| — | Em dash | — | `&mdash;` |
| – | En dash | – | `&ndash;` |
| ' | Right single quote / apostrophe | ' | `&rsquo;` |
| " | Left double quote | " | `&ldquo;` |
| " | Right double quote | " | `&rdquo;` |
| • | Bullet point | • | `&bull;` |
| … | Ellipsis | … | `&hellip;` |
| &nbsp; | Non-breaking space | (see note) | `&nbsp;` |
| £ | Pound sterling | £ | `&pound;` |
| ® | Registered trademark | ® | `&reg;` |
| © | Copyright | © | `&copy;` |

---

## How to Use in Elementor

### In the Visual (WYSIWYG) Editor:
1. Place cursor where you want the character
2. Copy the character from the **"Copy this"** box above
3. Paste directly — Elementor preserves it correctly

### In the HTML/Code Editor:
Use the HTML entity form (e.g. `&mdash;`) — this is the safest option if you
are editing raw HTML inside an Elementor HTML widget or custom code block.

### In Heading Widgets:
Paste the literal character directly. Heading widgets do not process HTML
entities, so `&mdash;` will display as the text `&mdash;` — always paste
the actual character for headings.

---

## Template Text Blocks Containing Special Characters

These are the exact current strings from the XCP templates that contain
special characters, ready to copy-paste into Elementor if a widget
import goes wrong or a character displays incorrectly.

---

### HomeP2 — Text Content Block (heading)
```
Good Photographs Are Easy. The Right Photograph Is Something Else.
```

### HomeP2 — Parallax subheading
```
Your Authentic Story. Their Undivided Attention.
```

### HomeP3 — Checkerboard Section 1 (body, key phrase)
```
Not polished into something safe and forgettable. Not softened for an audience that wouldn't get it anyway.
```

### HomeP3 — Checkerboard Section 2 (closing line)
```
When the right people see themselves reflected in your story, they don't just engage — they recognise you. That's not a metric. That's the person you were trying to reach.
```
*(Em dash between "engage" and "they")*

### HomeP4 — Narrative-Led Content pillar
```
A decade of active visual work — from gallery exhibitions and headline music photography to brand work across the UK and Europe. Imagery that does not just look good, it says something.
```
*(Em dash after "work")*

### HomeP4 — Process Step 04
```
designed to build immediate trust, reflect the real character of your brand, and earn the attention of the people worth reaching.
```

### HomeP5 — Final CTA
```
let's craft imagery that reflects exactly who you are and commands the attention of the right people. Your story deserves to be seen—and felt.
```
*(Em dash between "seen" and "and")*

### About P1 — Hero subheading
```
Partnership, not just photography. Your vision, elevated through imagery that truly reflects who you are and connects with the people who were always meant to find you.
```

### About P2 — Process CTA
```
Ready to see your brand elevated through imagery that truly reflects who you are — and connects with the people worth reaching? Let's talk about your vision.
```
*(Em dash after "are")*

### Services — Hero subheading
```
Strategic photography packages built on a decade of active visual work — designed to help the right brands show up in a way that commands genuine attention.
```
*(Em dash after "work")*

### Portfolio — Hero subheading
```
A decade of visual work — gallery exhibitions, headline music photography, brand documentary, and street portraiture. Work that has been exhibited, published, and trusted by some of the UK's most respected venues and brands.
```
*(Em dash after "work")*

### Footer — Brand line (if used as plain text)
```
XCP Photography — Brand & Documentary Imagery
```
*(Em dash between Photography and Brand)*

---

## Common Mistakes to Avoid in Elementor

| Instead of | Use |
|---|---|
| `--` (double hyphen) | `—` (em dash) |
| `-` (hyphen) as a range separator | `–` (en dash) |
| `'` (straight apostrophe) in headlines | `'` (right single quote) |
| `"..."` (straight double quotes) | `"..."` (curly double quotes) |
| `...` (three dots) | `…` (ellipsis) |
| `&mdash;` in a Heading widget | `—` (paste the character) |

---

*Keep this file open in a browser tab while editing Elementor — copy from here, paste directly into widgets.*
