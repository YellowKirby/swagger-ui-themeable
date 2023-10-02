# swagger-ui-themeable

A rebuild of [Swagger UI's](https://github.com/swagger-api/swagger-ui) default stylesheet that uses [CSS custom properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties) to better support custom themes.

## Caveats

> [!WARNING]
> Consider this package a proof-of-concept that may break or be unsupported at any time. If you find this package useful please consider leaving a comment in https://github.com/YellowKirby/swagger-ui-themeable/issues/1.

This package attempts to make as few changes as possible to the upstream stylesheet. Ideally this means it's a safe drop-in replacement, but also has a few drawbacks:

- **Stability**: Variable names are automatically generated and may be changed or removed between different versions. See issue https://github.com/YellowKirby/swagger-ui-themeable/issues/1.
- **Browser Support**: Some SASS features (such as `lighten()`) don't work with CSS variables. These have been replaced with [`color-mix()`](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix), and should be fairly equivalent but require [a recent version of most browsers](https://caniuse.com/?search=color-mix) to work correctly.

## Usage

Install with your favorite package manager

```sh
npm i @goattech/swagger-ui-themeable
```

Replace any import of the default Swagger UI CSS file with an import of this package:

```diff
// example JS import with swagger-ui-react
- import "swagger-ui-react/swagger-ui.css"
+ import "@goattech/swagger-ui-themeable/swagger-ui.css"

// example CSS import
- @import "swagger-ui/swagger-ui.css"
+ @import "@goattech/swagger-ui-themeable/swagger-ui.css"
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

### What variables can be defined?

See the full list [here](./main.scss). Provide any/all values for the `--swagger-ui-` variable names.

## Development

- [`./generate.sh`](./generate.sh) will fetch the latest `master` commit of upstream `swagger-ui` and run some `sed` replacements to define CSS variables. Currently this `gsed` (`gnu-sed`) that can be installed with `brew install gnu-sed` on OSX. Sorry other OS folks :(
- `npm run build` will package it up
