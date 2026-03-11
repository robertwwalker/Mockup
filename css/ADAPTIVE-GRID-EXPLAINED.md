# Adaptive Grid Layout - How It Works

## From Single Row to Adaptive Grid

### Previous Layout (Single Row)
```
[About] [Research] [Publications] [Teaching] [Blog] [AI Tools]
```
- All 6 circles forced into one horizontal line
- Could be cramped on smaller screens
- Required manual wrapping via flexbox

### New Layout (Adaptive Grid)
The grid automatically adapts to screen width:

#### Desktop (wide screen ~1400px+)
```
[About]    [Research]    [Publications]
[Teaching] [Blog]        [AI Tools]
```
Grid: 3 columns × 2 rows

#### Laptop (~1000-1400px)
```
[About]       [Research]   [Publications]
[Teaching]    [Blog]       [AI Tools]
```
Grid: 3 columns × 2 rows

#### Tablet (~768-1000px)
```
[About]      [Research]    [Publications]
[Teaching]   [Blog]        [AI Tools]
```
Grid: 3 columns × 2 rows (slightly tighter)

#### Large Phone (~480-768px)
```
[About]       [Research]
[Publications] [Teaching]
[Blog]        [AI Tools]
```
Grid: 2 columns × 3 rows

#### Small Phone (~320-480px)
```
[About]       [Research]
[Publications] [Teaching]
[Blog]        [AI Tools]
```
Grid: 2 columns × 3 rows (smaller circles)

## How It Works

### CSS Grid Auto-Fit
```css
grid-template-columns: repeat(auto-fit, minmax(108px, 1fr));
```

**What this means:**
- `repeat(auto-fit, ...)`: Create as many columns as fit
- `minmax(108px, 1fr)`: Each column is at least 108px wide, but can grow
- Browser automatically calculates optimal number of columns
- Circles wrap to new rows naturally

### Responsive Breakpoints
The grid adjusts at different screen sizes:

| Screen Size | Grid Config | Circle Size | Gap |
|-------------|-------------|-------------|-----|
| Desktop (1400px+) | auto-fit, min 108px | 108px | 1.5rem |
| Laptop (768-1400px) | auto-fit, min 108px | 108px | 1.25rem |
| Tablet (480-768px) | auto-fit, min 105px | 105px | 1rem |
| Phone (<480px) | auto-fit, min 95px | 95px | 0.9rem |

### Benefits

1. **Automatic Adaptation**: Grid recalculates on window resize
2. **No Manual Breakpoints**: CSS does the math for you
3. **Optimal Use of Space**: Always fills available width
4. **Consistent Gaps**: Spacing scales proportionally
5. **Centered Layout**: `justify-items: center` keeps circles aligned

### Customization Examples

**Force 2 columns:**
```css
.circle-grid {
  grid-template-columns: repeat(2, 1fr);
}
```

**Force 3 columns:**
```css
.circle-grid {
  grid-template-columns: repeat(3, 1fr);
}
```

**Single row (original):**
```css
.circle-grid {
  grid-template-columns: repeat(6, 1fr);
}
```

**Different min-width threshold:**
```css
.circle-grid {
  /* Wraps sooner (more rows on wide screens) */
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  
  /* Wraps later (more columns on narrow screens) */
  grid-template-columns: repeat(auto-fit, minmax(80px, 1fr));
}
```

### Testing the Grid

To see the grid adapt in real-time:
1. Open your landing page in a browser
2. Open DevTools (F12)
3. Resize the browser window
4. Watch circles automatically rearrange

The grid will smoothly transition between layouts without any jumps or breaks.

### Max Width Control

The grid is constrained by `max-width`:
```css
max-width: 750px; /* Desktop */
max-width: 600px; /* Tablet */
max-width: 100%;  /* Phone (full width) */
```

This ensures the grid doesn't get too wide on very large screens.

## Why Adaptive Grid is Better

1. **Flexible**: Works on any screen size without manual intervention
2. **Balanced**: Always creates visually balanced layouts
3. **Future-proof**: Works with any number of circles (add/remove items)
4. **Performance**: No JavaScript needed, pure CSS
5. **Accessible**: Maintains logical reading order
6. **Maintainable**: One layout rule handles all cases

## Visual Flow

```
Container width: 750px
Circle min-width: 108px
Gap: 1.25rem (20px)

Calculation:
750 - (20 × 2 side padding) = 710px available
(108 + 20 gap) = 128px per circle
710 ÷ 128 = 5.5 → fits 5 columns
Extra space: 710 - (5 × 128) = 70px
70px ÷ 5 = 14px extra per circle
Final circle width: 108 + 14 = 122px each

Result: 5 columns × 2 rows (last row has 1 circle)
```

The browser does this math automatically and perfectly every time!
