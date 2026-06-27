# Design System Strategy: The Digital Editorial

## 1. Overview & Creative North Star
This design system is built upon the Creative North Star of **"The Modern Scribe."** Just as historical messengers (Zajil) carried vital information across vast distances with elegance, this system facilitates the sharing of visual wisdom through a high-end editorial lens. 

We move away from the "app-as-a-utility" look toward an "app-as-a-gallery" experience. This is achieved through **Intentional Asymmetry**—where masonry grids aren't just functional but dynamic—and **Tonal Depth**, where the interface feels like physical sheets of fine, semi-translucent paper layered over a soft, ethereal background.

## 2. Colors & Surface Philosophy
The palette is rooted in a serene, sophisticated spectrum of cyans and greys. We avoid harsh contrasts to maintain a "calm-tech" aesthetic.

### Tonal Tokens
*   **Primary (`#0d6683` / `#89cff0`):** Used for key actions and brand moments.
*   **Secondary (`#406376` / `#2c4f62`):** Used for deep editorial weight and secondary iconography.
*   **Background (`#f7fafc`):** A breathable, cool canvas that reduces eye strain.

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders to section off content. Sectioning must be achieved through:
1.  **Background Shifts:** Using `surface-container-low` vs. `surface`.
2.  **Negative Space:** Utilizing the `spacing-12` or `spacing-16` tokens to create distinct content groups.
3.  **Tonal Transitions:** Subtle shifts in hue to define header/footer boundaries.

### Glass & Gradient Mastery
To elevate the UI beyond standard flat design:
*   **Signature Textures:** Apply a linear gradient from `primary` to `primary-container` at a 135-degree angle for primary CTAs.
*   **Glassmorphism:** For floating quote editor menus or navigation bars, use `surface-container-lowest` at 80% opacity with a `20px` backdrop-blur. This allows the masonry quote grid to peek through, creating a sense of continuity.

## 3. Typography: The Editorial Voice
The typography is bi-directional and harmonious. Inter provides a neutral, architectural foundation for English, while a modern Kufi/Naskh variant provides the soul for Arabic content.

*   **Display (`display-lg` to `display-sm`):** Reserved for the quotes themselves. High letter-spacing (for Inter) and generous line heights to ensure the "visual" in "visual quotes" is respected.
*   **Headline & Title:** Used for navigation and category headers. These should feel authoritative yet airy.
*   **Body & Label:** Using `on-surface-variant` (`#40484d`) for secondary metadata to ensure hierarchy without visual noise.

**Directionality:** In RTL (Arabic), all horizontal typography scales and icons must mirror, ensuring the "visual flow" starts from the top-right, maintaining the same editorial weight as the LTR (English) layout.

## 4. Elevation & Depth
Depth is not a shadow; it is a **layer**. We prioritize tonal stacking over traditional skeuomorphism.

*   **The Layering Principle:** Place a `surface-container-lowest` card on a `surface-container-low` section. This creates a soft, natural lift.
*   **Ambient Shadows:** For high-priority floating elements (like the 'Create' button), use a shadow with a 24px blur, 0px offset, and 6% opacity using a tint of `on-surface` (`#181c1e`). This mimics natural, soft-box photography lighting.
*   **Ghost Borders:** If a boundary is strictly required for accessibility, use the `outline-variant` token at 15% opacity. Never use 100% opaque lines.

## 5. Components

### Masonry Grid Items (The Quote Feed)
*   **Structure:** No borders. Cards use `surface-container-lowest` with `rounded-xl` (1.5rem) corners.
*   **Spacing:** Use `spacing-4` (1rem) as the gutter between items.
*   **Interaction:** On hover/active, the card should scale slightly (1.02x) rather than changing color.

### Quote Editor Styling Tools
*   **Tool Trays:** Floating glassmorphic containers with `rounded-full` shapes for font/color selections.
*   **Frame Selectors:** Use `surface-variant` as a background for inactive frame previews to maintain a muted palette while the user edits.
*   **Inputs:** Minimalist underlines or soft-filled `surface-container-high` fields. No heavy "box" inputs.

### Buttons
*   **Primary:** Gradient-filled (`primary` to `primary_container`), `rounded-full`, with `title-sm` typography.
*   **Secondary:** Ghost style (no fill) with a `Ghost Border` at 20% opacity.
*   **Chips:** Used for quote categories (e.g., #Poetry, #Wisdom). Use `secondary-container` with `on-secondary-container` text.

## 6. Do's and Don'ts

### Do
*   **DO** use whitespace as a functional element to separate "Author" from "Quote Body."
*   **DO** ensure the Arabic Kufi font weight matches the Inter bold weight visually (optical alignment).
*   **DO** use `surface-bright` for dark mode surfaces to prevent a "pure black" hollow look.

### Don't
*   **DON'T** use 1px dividers between list items. Use `spacing-4` vertical gaps instead.
*   **DON'T** use high-contrast drop shadows. They break the "Soft Minimalism" ethos.
*   **DON'T** crowd the Quote Editor. The interface should disappear to let the user focus on the creation.