---
name: Emerald Electronica
colors:
  surface: '#111415'
  surface-dim: '#111415'
  surface-bright: '#373a3b'
  surface-container-lowest: '#0c0f10'
  surface-container-low: '#191c1d'
  surface-container: '#1d2021'
  surface-container-high: '#282a2b'
  surface-container-highest: '#323536'
  on-surface: '#e1e3e4'
  on-surface-variant: '#bccabd'
  inverse-surface: '#e1e3e4'
  inverse-on-surface: '#2e3132'
  outline: '#879488'
  outline-variant: '#3d4a40'
  surface-tint: '#5cde94'
  primary: '#5cde94'
  on-primary: '#00391e'
  primary-container: '#2eb872'
  on-primary-container: '#004224'
  inverse-primary: '#006d3e'
  secondary: '#d4beea'
  on-secondary: '#39294c'
  secondary-container: '#513f64'
  on-secondary-container: '#c2add8'
  tertiary: '#ffb77f'
  on-tertiary: '#4e2600'
  tertiary-container: '#f58400'
  on-tertiary-container: '#592c00'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#7afbae'
  primary-fixed-dim: '#5cde94'
  on-primary-fixed: '#00210f'
  on-primary-fixed-variant: '#00522e'
  secondary-fixed: '#efdbff'
  secondary-fixed-dim: '#d4beea'
  on-secondary-fixed: '#241436'
  on-secondary-fixed-variant: '#513f64'
  tertiary-fixed: '#ffdcc4'
  tertiary-fixed-dim: '#ffb77f'
  on-tertiary-fixed: '#2f1500'
  on-tertiary-fixed-variant: '#6f3900'
  background: '#111415'
  on-background: '#e1e3e4'
  surface-variant: '#323536'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '800'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-bold:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  container-margin: 24px
  gutter-md: 16px
  section-gap: 32px
  stack-sm: 8px
  stack-md: 12px
---

## Brand & Style

This design system is crafted for a premium electronics e-commerce experience, merging high-energy "tech" aesthetics with a sophisticated, professional foundation. The brand personality is innovative and direct, using high-contrast visual cues to guide the user through a dense catalog of premium gadgets.

The aesthetic follows a **Corporate Modern** style infused with **vibrant accents**. It leverages deep obsidian and navy tones to provide a "dark mode" canvas that feels expensive and cinematic, while using a bright emerald green as the primary driver for conversion and interaction. The emotional response should be one of excitement, reliability, and cutting-edge modernity.

## Colors

The color strategy relies on a "Midnight Canvas" approach. The deep purple/navy (#19092B) serves as the primary surface for navigation and immersive onboarding, while a pristine white is used for the transactional "Light Mode" interfaces to ensure maximum legibility during product browsing.

- **Primary (Emerald):** Used for primary actions, success states, and featured product highlights.
- **Secondary (Obsidian Purple):** The anchor for dark-themed surfaces, sidebars, and onboarding backgrounds.
- **Tertiary (Electric Orange):** Reserved for filters, high-priority notifications, or "New" badges to create immediate visual tension against the cool greens and purples.
- **Neutral (Snow):** Provides the clean background for the product grid and search screens, ensuring hardware photography remains the hero.

## Typography

This design system utilizes **Plus Jakarta Sans** for its modern, geometric construction that remains friendly and readable. The hierarchy is intentionally dramatic; headlines use tight letter-spacing and heavy weights to command attention.

For mobile-specific views, "Display" styles are reserved for onboarding and promotional banners. Product titles and prices utilize the "Headline-MD" style for clarity. Body text is kept clean with a slight decrease in opacity for secondary information to maintain a focused visual path.

## Layout & Spacing

The layout philosophy is based on a **Fluid Grid** for mobile, utilizing a 4-column system with generous 24px outer margins. This increased breathing room at the edges reinforces the premium "luxury tech" feel.

- **Vertical Rhythm:** A base 8px unit dictates all spacing. Components like cards use 16px internal padding, while vertical sections are separated by 32px to allow the user to focus on one category at a time.
- **Onboarding:** Center-aligned content with a focus on large, iconic imagery and high-contrast CTA buttons positioned at the bottom of the thumb-zone.
- **Product Grids:** A 2-column masonry or fixed-height grid for the "Popular" section, using 16px gutters to ensure clear separation between gadget tiles.

## Elevation & Depth

<<<<<<< HEAD
Hierarchy is established through **Tonal Layering** rather than heavy shadows.
=======
Hierarchy is established through **Tonal Layering** rather than heavy shadows. 
>>>>>>> main

1.  **Base Layer:** Solid backgrounds (Deep Purple or White).
2.  **Card Layer:** Surfaces that sit on the base layer use a very subtle 1px border or a faint, diffused shadow (0px 4px 20px, 5% opacity) to create a "lifted" effect.
3.  **Floating Elements:** Elements like the bottom navigation bar use a backdrop blur (glassmorphism) or a stark white surface with a soft shadow to remain persistent and accessible.
4.  **Interactive States:** Buttons use a solid, vibrant color fill with no shadow, relying on color contrast (Primary Green vs White text) to indicate interactability.

## Shapes

The shape language is defined by **pronounced, organic roundness**. This softens the "technical" nature of the product, making the app feel approachable and ergonomic.

- **Primary Cards:** Use a 24px-32px corner radius, echoing the industrial design of modern flagship smartphones.
- **Buttons:** Fully pill-shaped or 16px radius depending on the context.
- **Icon Containers:** Small utility icons (like the filter or category icons) are placed within circular or highly rounded "squircle" containers to maintain consistency with the large feature graphics.

## Components

### Buttons
Primary buttons are high-contrast blocks of the primary color. On dark backgrounds, text is white; on light backgrounds, text can be white or the deep secondary color. The "Let's Go" style button is large, spanning nearly the full width of the container.

### Category Chips
Circular icons with a label underneath. Active states are indicated by the icon container changing color to the primary green or adding a thick border.

### Product Cards
Minimalist tiles with high-quality PNG product renders. Text is bottom-aligned with the price clearly emphasized. The background of the card should be a very light neutral (#F8F9FA) or a slightly lifted version of the dark purple.

### Search Bar
A clean, rounded-pill input with a light grey fill and a subtle search icon. The "Filter" button sits adjacent, styled in the Tertiary Orange to separate it from the search action.

### Bottom Navigation
A clean, floating or docked bar with simple line-art icons. The active state is marked by a small dot indicator or a color shift to the deep brand purple.