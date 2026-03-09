# XCP Elementor Global Settings Reference

**This file is the single source of truth for all site colours, fonts, and form styling.**  
**Never override these values with inline styles in individual widgets, sections, or columns.**  
**Change a setting here (in Elementor → Global Settings) and it applies everywhere instantly.**

---

## How to Access Global Settings in Elementor

1. Open any page in Elementor editor
2. Click the **hamburger menu** (top-left ☰) → **Site Settings**  
   *or* press **Ctrl + P** (Windows) / **Cmd + P** (Mac) to open the panel
3. Select **Global Colors** or **Global Fonts**

---

## Global Colours

### System Colours

These are the four built-in Elementor system colour slots. Every widget that uses a "global" colour picker references one of these.

| Slot | Label | Hex Value | Usage |
|---|---|---|---|
| System Primary | Primary | `#CECECE` | Primary brand colour — main headings, dominant UI elements |
| System Secondary | Secondary | `#A2A1A1` | Secondary text, supporting elements |
| System Text | Text | `#919191` | Body copy, paragraph text, labels |
| System Accent | Accent | `#BBBBBB` | Accent details, highlights, dividers, icon colour |

### Custom Colours

| Slot | Label | Hex Value | Usage |
|---|---|---|---|
| Custom 1 | Primary Font | `#D5D5D5` | Lightest tone — eyebrow text, captions, small print |

### Colour Usage Rules

- **All section backgrounds** → set via Elementor page/section settings using the global colour picker — never hardcoded hex
- **All text colours** → inherit from widget defaults or reference a global colour slot — never inline
- **All button colours** → set via Global Settings → Buttons — never per-widget
- **All form field colours** → set via Global Settings → Form or the Elementor Form widget's global style — never per-field inline

> ⚠️ The site uses a **dark/neutral palette** (black/near-black background with platinum grey text).  
> The grey scale (#CECECE → #919191) is designed to read clearly on dark backgrounds.  
> Do **not** add bright/saturated colours without updating the global palette first.

---

## Global Fonts

### System Font Slots

All typography is controlled through these four slots. Set each slot once; every widget using that slot updates automatically.

| Slot | Name | Fallback |
|---|---|---|
| Primary | Primary | Sans-serif |
| Secondary | Secondary | Sans-serif |
| Text | Text (body) | Sans-serif |
| Accent | Accent | Sans-serif |

### Font Configuration (set in Site Settings → Global Fonts)

For each slot, configure these values **in Elementor** (do not set per-widget):

| Property | Recommended Setting |
|---|---|
| Family | [Set your chosen typeface here] |
| Size | Leave unset — use Elementor responsive defaults |
| Weight | 400 (Normal) for body; 700 (Bold) for headings |
| Transform | Normal |
| Style | Normal |
| Decoration | None |
| Line Height | Leave unset — use Elementor responsive defaults |
| Letter Spacing | Leave unset — use Elementor responsive defaults |
| Word Spacing | Leave unset — use Elementor responsive defaults |

> **Custom Font slot ("New Item #1")** — assign your brand typeface here if it differs from the system font. Set it as the **Primary** slot typeface so all headings inherit it automatically.

---

## Global Form Field Styles

Set these once in **Site Settings → Form Styles** (or via the Elementor Forms widget Global Style tab). All form widgets on the site will inherit these settings — no per-widget overrides.

### Label

| Property | Setting |
|---|---|
| Colour | → Global: **Text** (`#919191`) |
| Typography | → Global: **Text** font slot |

### Field (Input / Textarea / Select)

| Property | Setting |
|---|---|
| Typography | → Global: **Text** font slot |

### Field Normal State

| Property | Setting |
|---|---|
| Text Colour | → Global: **Primary** (`#CECECE`) |
| Accent Colour | → Global: **Accent** (`#BBBBBB`) |
| Background Colour | → Set to site dark background colour (match section background) |
| Box Shadow | None (default) |
| Border Type | Default (or set once globally) |
| Border Radius | 0px (sharp corners — consistent with brand aesthetic) |
| Padding | Set globally — do not override per-form |

### Field Focus State

| Property | Setting |
|---|---|
| Text Colour | → Global: **Primary** (`#CECECE`) |
| Accent Colour | → Global: **Accent** (`#BBBBBB`) |
| Background Colour | Slightly lighter than normal state background |
| Box Shadow | None or subtle (set globally) |

### Submit Button

| Property | Setting |
|---|---|
| Text | Set per-form (content, not style) |
| Size | `lg` (large) — consistent across all forms |
| Alignment | `left` on Contact page form; `center` on homepage form |
| Background Colour | → Global: **Accent** — set in Site Settings → Buttons |
| Text Colour | → Global: **Text** or contrast colour — set in Site Settings → Buttons |
| Hover Background | → Set in Site Settings → Buttons |
| Border Radius | 0px (sharp — set in Site Settings → Buttons) |
| Padding | Set in Site Settings → Buttons |

> ✅ After stripping all inline styles from the JSON templates, the forms inherit ALL styling from these global settings. To change button colour site-wide: update **Site Settings → Buttons** once.

---

## Global Button Styles

Set in **Site Settings → Buttons**. Applies to ALL button widgets that use the default button type.

| Property | Value |
|---|---|
| Background Colour | → Global: **Accent** (`#BBBBBB`) or brand highlight colour |
| Text Colour | Dark contrast (e.g. `#000000` or near-black) |
| Hover Background | → Global: **Primary** (`#CECECE`) or lighter tone |
| Border Radius | `0px` — sharp corners |
| Padding | Consistent vertical + horizontal (e.g. 16px top/bottom, 48px left/right) |
| Typography | → Global: **Accent** font slot |

**Outline button variant** (used on hero secondary CTA):  
Set Border colour → Global: **Primary**; Background → Transparent; Text → Global: **Primary**

---

## Applying Global Settings — Checklist

When adding or editing any section, widget, or element:

- [ ] **Colours** — use the global colour picker (coloured circle icon in any colour field), never type a hex value
- [ ] **Fonts** — select from the global font slots in any typography panel, never set a custom family inline
- [ ] **Padding / Margin** — use Elementor's default spacing where possible; only set custom spacing at the section level when layout genuinely requires it, and keep values consistent (multiples of 8px or 16px recommended)
- [ ] **Button styles** — never set button colours in a widget; they must come from global button settings
- [ ] **Form styles** — never set field colours, padding, or border radius per-form; they must come from global form settings
- [ ] **No `custom_css`** — do not add custom CSS to individual elements; use global custom CSS (Elementor → Custom CSS, or via the WordPress Customizer Additional CSS)

---

## What Was Stripped from the JSON Templates

All 34 Elementor JSON template files have been cleaned of inline style overrides. The following properties were removed from every widget, column, and section and must now be controlled **only** through Elementor Global Settings:

**Colours removed:** `background_color`, `background_background`, `color`, `text_color`, `title_color`, `hover_color`, `icon_color`, `button_background_color`, `button_text_color`, `button_hover_background_color`, `button_border_color`, `border_color`, `primary_color`, `secondary_color`, per-icon `item_icon_primary_color`/`item_icon_secondary_color`, overlay colours, gradient colours

**Typography removed:** `typography_font_family`, `typography_font_size`, `typography_font_weight`, `typography_line_height`, `typography_letter_spacing`, `typography_text_transform`, `typography_typography`, and all `title_typography_*` variants

**Spacing removed:** `padding`, `padding_mobile`, `padding_tablet`, `margin`, `gap`, `item_gap`, `space_between`, `dropdown_padding`, `button_padding`

**Dimensions removed:** `height`, `custom_height`, `min_height`, `width`, `width_mobile`, `width_tablet`, `_element_custom_width`, `content_width`, `item_ratio`, `object_fit`

**Effects removed:** `border_radius`, `border_width`, `border_border`, `text_shadow_*`, `animation_duration`, `image_hover_animation`, `overlay_background`, `style` (divider/border style)

**What was kept (content + structure only):**
- Element IDs, types, widget types
- Column sizes (`_column_size`, responsive variants) — layout structure
- Section structure and layout (`structure`, `layout`)
- All text content (`title`, `editor`, `text`, `html`)
- All form field definitions (`form_fields`, `form_name`, `webhook`, `submit_actions`)
- Semantic tags (`header_size`, `title_html_tag`)
- Alignment (`align`, `text_align`, `content_position`, `flex_*`) — layout not colour
- Responsive visibility (`hide_desktop`, `hide_tablet`, `hide_mobile`)
- Image content (`image`, `background_image`, `gallery`)
- Navigation settings (`menu`, `sticky`, `sticky_on`)
- Functional button properties (`button_text`, `button_size`, `button_type`, `button_align`)
- Form success/error messages

---

## Updating the Site Style — Single Source of Truth

| To change… | Update… | Effect |
|---|---|---|
| Brand colour | Elementor → Site Settings → Global Colours | All widgets using that slot update instantly |
| Body font | Elementor → Site Settings → Global Fonts → Text slot | All body text updates instantly |
| Heading font | Elementor → Site Settings → Global Fonts → Primary slot | All headings update instantly |
| Button colour | Elementor → Site Settings → Buttons | All buttons update instantly |
| Form field style | Elementor → Site Settings → Form or global form style | All forms update instantly |
| Section spacing | Elementor → Site Settings → Layout (if available) or update spacing at template level | All sections update |

> **Never** set colours or fonts directly in a widget panel. If you find yourself reaching for the hex input field, stop — use the global colour picker instead.

---

## Form Placeholder Text — Darker Colour (WPCode CSS Snippet)

Elementor's default placeholder text is very light grey. To make it darker across all forms, add a **WPCode CSS snippet** (type: CSS, Location: Site Wide Header).

**Snippet name:** `XCP Form Placeholder Colour`

```css
/* XCP — darker form placeholder text */
.elementor-form input::placeholder,
.elementor-form textarea::placeholder,
.elementor-form select {
    color: #6b6b6b;
    opacity: 1;
}
/* Fallback for older browsers */
.elementor-form input:-ms-input-placeholder,
.elementor-form textarea:-ms-input-placeholder {
    color: #6b6b6b;
}
```

> Adjust `#6b6b6b` (mid-grey) to taste. `#555555` is darker still; `#888888` is lighter. The `opacity: 1` override is required in Firefox, which reduces placeholder opacity by default. The `select` rule also covers the dropdown default state (before a choice is made).

---

*Last updated: March 2026*
