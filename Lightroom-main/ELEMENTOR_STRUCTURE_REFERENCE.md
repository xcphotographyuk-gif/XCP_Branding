# Elementor JSON Structure Reference

## Key Findings from Your Elementor Export

Based on the JSON code you provided, here's the correct structure for your Elementor installation:

### Version & Format
- **Version**: `"version": "0.4"` (not 2.0)
- **Type**: `"type": "page"`
- **Title**: Custom title for each template

### Section Structure
```json
{
  "id": "unique-id",
  "settings": {
    "layout": "full_width",  // or "boxed"
    "flex_gap": {
      "size": 0,
      "unit": "px",
      "column": "0",
      "row": "0",
      "isLinked": true
    },
    "structure": "20",  // "50" for 2 columns, "25" for 4 columns
    "min_height": {
      "unit": "px",
      "size": "80"
    },
    "content_position": "middle",  // or "top", "bottom"
    "padding": {
      "unit": "%",
      "top": "0",
      "right": "5",
      "bottom": "0",
      "left": "5",
      "isLinked": ""
    },
    "background_background": "classic",
    "background_color": "#000000"
  },
  "elements": []  // Columns go here
}
```

### Column Structure
```json
{
  "id": "unique-id",
  "settings": {
    "_column_size": "50",  // Percentage
    "width": {
      "size": 10,
      "unit": "%"
    },
    "width_mobile": {
      "size": "30",
      "unit": "%"
    },
    "width_tablet": {
      "unit": "%",
      "size": 15
    },
    "padding": {
      "unit": "px",
      "top": "0",
      "right": "0",
      "bottom": "0",
      "left": "0",
      "isLinked": true
    }
  },
  "elements": []  // Widgets go here
}
```

### Widget Structure
```json
{
  "id": "unique-id",
  "settings": {
    "image": {
      "id": "",
      "url": "[uc_local]XCP_Logo.png",  // Note the [uc_local] prefix
      "alt": "",
      "source": "library",
      "size": ""
    },
    "image_size": "full",
    "align": "center",
    "link_to": "custom",
    "width": {
      "unit": "px",
      "size": 91
    },
    "width_mobile": {
      "unit": "%",
      "size": "85"
    }
  },
  "elType": "widget",
  "widgetType": "image"  // or "heading", "text-editor", "button", etc.
}
```

### Key Differences from Generic Templates

1. **Image URLs**: Use `[uc_local]` prefix for local images
2. **Responsive Settings**: Include `width_mobile`, `width_tablet` for all size-dependent properties
3. **Flex Gap**: Uses specific flex_gap object structure
4. **Column Structure**: Uses `structure` property ("20" = 2 columns 80/20 split)
5. **Custom Extensions**: Includes EAEL (Essential Addons for Elementor) properties like `eael_image_masking_custom_clip_path`

### Image Path Format

For the homepage sections, images should use:
```
"url": "[uc_local]hero-woman-hair.jpg"
"url": "[uc_local]gallery-1.jpg"
"url": "[uc_local]parallax-triumph-bike.jpg"
```

Or for assets folder:
```
"url": "[uc_local]assets/images/hero-woman-hair.jpg"
```

### Next Steps

1. **Update JSON templates** to use version 0.4 format
2. **Match your exact structure** with proper responsive settings
3. **Use correct image path format** with [uc_local] prefix
4. **Split into manageable parts** to avoid Elementor large file issues

This reference will ensure all templates match your Elementor installation exactly.
