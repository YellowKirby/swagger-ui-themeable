# swagger-ui-themeable

A rebuild of [Swagger UI's](https://github.com/swagger-api/swagger-ui) default stylesheet that exposes CSS and/or SASS variables to better support custom themes.

## Caveats

This package attempts to make as few changes as possible to the upstream stylesheet. Ideally this means it's a safe drop-in replacement, but also has a few drawbacks:
- **Stability**: Variable names are automatically generated and may be changed or removed between different versions. See (#1)
- **Browser Support**: Some SASS features (such as `lighten()`) don't work with CSS variables. These have been replaced with [`color-mix()`](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix), and should be fairly equivalent but require [a recent version of most browsers](https://caniuse.com/?search=color-mix) to work correctly.

## Usage

Install with your favorite package manager

```sh
npm i swagger-ui-themeable
```

### [CSS Variables](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)

Replace any import of the default Swagger UI CSS file with an import of this package:

```diff
// example JS import with swagger-ui-react
- import "swagger-ui-react/swagger-ui.css"
+ import "swagger-ui-themeable/swagger-ui.css"

// example CSS import
- @import "swagger-ui/swagger-ui.css"
+ @import "swagger-ui-themeable/swagger-ui.css"
```


Then define values for any of the CSS variables:

```css
:root {
  --swagger-ui-font-sans-serif: Inter, ui-sans-serif;
  --swagger-ui-font-monospace: "IBM Plex Mono", ui-monospace;
  --swagger-ui-text-body-default-font-color: gray;
  --swagger-ui-color-bright-gray: gray;
  --swagger-ui-_color-post: lime;
  --swagger-ui-_color-get: indigo;
  --swagger-ui-_color-put: yellow;
  --swagger-ui-_color-delete: red;
  --swagger-ui-_color-head: purple;
  --swagger-ui-_color-patch: teal;
  --swagger-ui-_color-disabled: gray;
  --swagger-ui-color-method-options: lightblue;
  --swagger-ui-btn-authorize-font-color: lime;
  --swagger-ui-btn-authorize-border-color: lime;
}
```

### SASS Variables

You can also use SASS variables instead, which will result in a smaller filesize but the values can't be changed dynamically at runtime.

```scss
@use "~swagger-ui-themeable/sass" with (
    $color-primary: red,
    $color-secondary: orange,
    $color-info: yellow,
    $color-warning: green,
    $color-danger: blue
)
```

### What variables can be defined?
See the full list [here](./main.scss). Use the `--swagger-ui-` names if you're configuring with CSS variables, and the `$var` names if you're configuring in SASS
