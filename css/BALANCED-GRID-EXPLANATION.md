# Balanced Grid Layout - Bottom Third Position

## Overview

The landing page circles are now:
1. **Anchored to the bottom third** of the page (68vh)
2. **Perfectly balanced** across grid rows
3. **Flexibly adaptive** to different screen sizes

## Grid Structure

### Desktop & Tablet (>480px)
```
Row 1: [About]       [Research]      [Publications]
Row 2: [Teaching]    [Blog]          [AI Tools]
```
**Layout**: 3 columns × 2 rows (3 + 3 = perfectly balanced)

### Mobile (≤480px)
```
Row 1: [About]       [Research]
Row 2: [Publications] [Teaching]
Row 3: [Blog]        [AI Tools]
```
**Layout**: 2 columns × 3 rows (2 + 2 + 2 = perfectly balanced)

## Why Balanced Grid?

### Previous Issue (Auto-Fit)
With `repeat(auto-fit, minmax(108px, 1fr))`, the grid could create uneven rows:
```
Wide screen: [1] [2] [3] [4] [5]
             [6]
(5 in first row, 1 in second - unbalanced!)

Narrow screen: [1] [2] [3] [4]
               [5] [6]
(4 in first row, 2 in second - unbalanced!)
```

### Current Solution (Fixed Columns)
With `repeat(3, 1fr)` on desktop and `repeat(2, 1fr)` on mobile:
```
Desktop: Always 3 columns
[1] [2] [3]
[4] [5] [6]
(3 + 3 = balanced!)

Mobile: Always 2 columns
[1] [2]
[3] [4]
[5] [6]
(2 + 2 + 2 = balanced!)
```

## Positioning - Bottom Third

### Viewport Breakdown
```
0vh  ┌─────────────────┐
     │                 │
     │   Top Third     │
     │   (0-33vh)      │
33vh ├─────────────────┤
     │                 │
     │  Middle Third   │
     │  (33-66vh)      │
66vh ├─────────────────┤
     │                 │
     │  Bottom Third   │ ← Circles start at 68vh
68vh │  ▼ CONTENT      │
     │  [Circles]      │
     │  [Footer]       │
100vh└─────────────────┘
```

### Space Allocation
- **0-68vh**: Background image fully visible
- **68-92vh**: Circle content area (24vh max)
- **92-100vh**: Footer (~8vh)

## Responsive Behavior

| Screen Size | Columns | Rows | Position | Max Height |
|-------------|---------|------|----------|------------|
| **Desktop** (>1400px) | 3 | 2 | 68vh | 24vh |
| **Laptop** (768-1400px) | 3 | 2 | 68vh | 24vh |
| **Tablet** (480-768px) | 3 | 2 | 60vh | 35vh |
| **Mobile** (<480px) | 2 | 3 | 50vh | 45vh |

### Why Different Positions on Mobile?
- **Desktop (68vh)**: Plenty of screen real estate, can start very low
- **Tablet (60vh)**: Need more vertical space for 3-column layout
- **Mobile (50vh)**: 2×3 grid needs even more height, start mid-page

## Gap Sizing

The spacing between circles scales with screen size:

| Screen Size | Gap | Visual Effect |
|-------------|-----|---------------|
| **Desktop (>1400px)** | 2.5rem (40px) | Generous, airy |
| **Laptop (768-1400px)** | 2rem (32px) | Balanced |
| **Tablet (480-768px)** | 1.5rem (24px) | Comfortable |
| **Mobile (<480px)** | 1.25rem (20px) | Compact |

## Benefits

### 1. Visual Balance
- All rows have equal number of items
- Creates symmetrical, pleasing composition
- No orphaned items in last row

### 2. Predictable Layout
- Grid structure is consistent across sessions
- No unexpected shifts based on viewport width
- Easier to visualize and design around

### 3. Optimal Spacing
- Equal gaps between all circles
- Maintains visual rhythm
- Adapts gracefully to screen size

### 4. Background Visibility
- 68% of viewport shows pure background
- Content occupies only bottom third
- Maintains dramatic hero image impact

### 5. Footer Integration
- Always visible at page bottom
- No scrolling required
- Flexbox ensures proper positioning

## Code Structure

### Desktop Grid
```css
.circle-grid {
  grid-template-columns: repeat(3, 1fr);
  gap: 2rem;
  max-width: 750px;
}
```
- **3 equal columns**: `1fr 1fr 1fr`
- **Fixed column count**: Always 3, never changes
- **Max width**: Prevents grid from getting too wide

### Mobile Grid
```css
@media (max-width: 480px) {
  .circle-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1.25rem;
  }
}
```
- **2 equal columns**: `1fr 1fr`
- **Tighter gaps**: Less horizontal space available
- **Full width**: No max-width constraint

## Customization Examples

### Change to Single Row (6 columns)
```css
.circle-grid {
  grid-template-columns: repeat(6, 1fr);
  max-width: 900px;
}
```

### Change to 2×3 Grid on Desktop
```css
.circle-grid {
  grid-template-columns: repeat(2, 1fr);
}
```

### Return to Auto-Fit (Variable)
```css
.circle-grid {
  grid-template-columns: repeat(auto-fit, minmax(108px, 1fr));
}
```
*Note: This loses guaranteed balance*

### Adjust Bottom Third Position
```css
.home-hero-overlay.mid-page-start {
  margin-top: 70vh; /* Start even lower */
  margin-top: 66vh; /* Start at exact bottom third */
  margin-top: 60vh; /* Start a bit higher */
}
```

## Testing the Layout

1. Open landing page in browser
2. Resize browser window
3. Observe:
   - Desktop: 3×2 grid (3 circles per row)
   - Mobile: 2×3 grid (2 circles per row)
   - All rows perfectly balanced
   - Circles always in bottom third
   - Footer always visible

## Mathematical Precision

With 6 circles:
- **Factors of 6**: 1, 2, 3, 6
- **Balanced options**:
  - 1×6 (single row)
  - 2×3 (2 rows of 3) ✓ **Desktop**
  - 3×2 (3 rows of 2) ✓ **Mobile**
  - 6×1 (single column)

We chose 3×2 for desktop and 2×3 for mobile because they:
- Create visual balance
- Work well with screen aspect ratios
- Maintain readable circle sizes
- Allow adequate spacing

## Summary

The balanced grid ensures:
✓ Even distribution across rows
✓ Bottom third positioning
✓ Flexible adaptation to screen size
✓ Maximum background visibility
✓ Professional, symmetric appearance
✓ Predictable, consistent layout
