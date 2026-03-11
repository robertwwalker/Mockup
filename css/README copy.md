# Circular Landing Page - Implementation Guide

## What Changed

I've transformed your landing page into an **ultra-minimal design** with nearly transparent animated circular spots featuring stunning lavender-pink professional typography in **Inter** (modern, clean, professional font), maximizing the visibility of your background image.

## New Files

### 1. **index.qmd** (Modified)
- Minimal text: Just your name and title (small, subtle)
- Six circular navigation spots in a single row
- Lower page positioning for dramatic entrance
- Nearly zero visual clutter - background image dominates

### 2. **cgpt-circles.css** (New)
- **Quarto Override**: Removes default Quarto spacing that caused scrolling
- **Flexbox Layout**: Ensures footer is always visible at page bottom
- **Adaptive Grid**: Circles automatically arrange in optimal layout
- **Modern Typography**: Inter font throughout for clean, professional look
- **Centered Title**: Landing page title centered with proper spacing
- **Nearly transparent circles** (97% transparent)
- **Lavender-pink professional typography** 
- Responsive grid that adapts from 1-6 columns
- Lower page positioning (starts around 62vh)
- Minimal padding and spacing throughout
- Subtle text that doesn't compete with background
- Floating animations with lavender-pink glow effects
- Hover effects with rotating lavender-pink rings
- Fully responsive design for all screen sizes

**Footer**: The page footer (defined in `_quarto.yml`) displays at the bottom with copyright and Quarto attribution.

### 3. **steampunk-cgpt-r3.scss** (Updated)
- **Font Synchronization**: Updated to use Inter throughout
- Consistent typography across entire site
- Modern, clean, professional aesthetic

### 3. **_quarto.yml** (Updated)
- Added `css/cgpt-circles.css` to the CSS list
- All other settings remain unchanged

## Key Features

### 🎯 Minimal Layout
- **Adaptive Grid**: Circles automatically arrange in optimal rows based on screen width
- **Lower Page Position**: Content begins at 62vh
- **Viewport Fit**: Max height 26vh with visible footer
- **Flexbox Layout**: Ensures footer always visible at bottom
- **Better Spacing**: 1.25rem gaps for visual balance
- **Readable Typography**: Optimized font sizes
- **Centered**: Perfectly centered on the page
- **Fully Responsive**: Grid adapts from 1-6 columns based on screen size

### ✨ Subtle Animations
- **Floating Effect**: Each circle gently floats up and down with unique timing
- **Glow Pulse**: Subtle pulsing glow effect
- **Rotating Ring**: On hover, a colorful ring rotates around the circle
- **Scale Transform**: Circles grow and lift on hover

### 🎨 Visual Design
- **Nearly Transparent**: Circles are 97% transparent, showing the background through
- **Lavender-Pink Typography**: Stunning professional color (#E8BADB)
- **Modern Font**: Inter - clean, professional, highly readable
- **Centered Title**: Landing page title centered with proper spacing
- **Subtle Borders**: Minimal lavender-pink border glow
- **Steampunk Harmony**: Matches your existing purple/pink theme

### 📱 Responsive
- **Desktop (>768px)**: Single horizontal row of 6 circles
- **Tablet (768px)**: Row wraps naturally
- **Mobile (<480px)**: 2-3 circles per row
- Sizes and spacing adjust automatically

## Installation

**IMPORTANT**: The new `cgpt-circles.css` includes critical overrides for Quarto's default spacing. Without these overrides, the landing page will have unwanted scrolling due to Quarto's `body { min-height: 100vh }`, `#quarto-content { min-height: 100vh }`, and padding settings. The CSS now caps the body at exactly 100vh and removes all padding to ensure perfect viewport fit.

1. Replace your current `index.qmd` with the new version
2. Add `cgpt-circles.css` to your `css/` folder
3. Replace `steampunk-cgpt-r3.scss` with the updated version (synchronized Inter font)
4. Update `_quarto.yml` to include the new CSS file (if not already present)
5. Render your Quarto site

```bash
quarto render
```

**Font Synchronization**: The SCSS file has been updated to use Inter throughout for consistency with the landing page.

## Customization Options

### Adjust Page Positioning
```css
.home-hero-overlay.mid-page-start {
  margin-top: 62vh;
  max-height: 26vh; /* Must leave room for footer */
}
```

### Adjust Circle Size
```css
.circle-card {
  width: 108px;
  height: 108px;
}
```

### Change Typography
```css
.circle-card a {
  font-family: 'Inter', sans-serif;
  font-size: 0.95rem;
  font-weight: 600;
  letter-spacing: 0.05em;
}
```

### Change Site-Wide Font
To use a different font across the entire site:
1. Update Google Font import in both `steampunk-cgpt-r3.scss` and `cgpt-circles.css`
2. Update `$font-family-base` in SCSS
3. Update font-family in circle and lead styles in CSS

### Adjust Spacing
```css
.circle-grid {
  gap: 1.25rem; /* Space between circles */
  max-width: 750px; /* Max grid width */
}
```

### Change Grid Columns
```css
.circle-grid {
  /* Current: adapts automatically */
  grid-template-columns: repeat(auto-fit, minmax(108px, 1fr));
  
  /* For exactly 3 columns: */
  grid-template-columns: repeat(3, 1fr);
  
  /* For exactly 2 columns: */
  grid-template-columns: repeat(2, 1fr);
}
```
```

### Change Colors
Modify the gradient colors:
```css
background: linear-gradient(135deg, 
  rgba(175, 152, 230, 0.25),  /* Purple */
  rgba(218, 153, 230, 0.15)   /* Pink */
);
```

### Disable Animations
Remove or comment out the animation line:
```css
/* animation: floatSpot 6s ease-in-out infinite; */
```

## Optional: Constellation Background

To add twinkling star effects between circles, add the `constellation` class:

```markdown
::: {.circle-grid .constellation}
```

## Subpages Unchanged

All your subpages (Research, Teaching, Publications, etc.) maintain their current styling with:
- Rectangular cards (cgpt-cards.css)
- Floating cards (floating-card-standalone.css)
- Navbar branding (navbar-branding.css)

Only the landing page (index.qmd) uses the new circular design.

## Browser Support

- Chrome/Edge: Full support
- Firefox: Full support
- Safari: Full support (including iOS)
- Backdrop blur requires modern browsers (2020+)

## Need Help?

- Adjust animation timings in the `@keyframes` sections
- Modify hover effects in the `.circle-card a:hover` section
- Change responsive breakpoints in the `@media` queries

Enjoy your new minimal, animated landing page! ✨
