#!/bin/bash

# sparse copy just the directories we need
rm -rf upstream
git clone --no-checkout --depth 1 --sparse https://github.com/swagger-api/swagger-ui upstream
pushd upstream
git sparse-checkout add src/style src/core/plugins webpack
git checkout
rm -rf .git
popd

# We want to use CSS vars everywhere, which means we can't use some
# SASS features like lighten() with dynamic values.
replacements=(
  # replace rgba() with color-mix(base, transparent)
  -e 's/rgba(\(.*\),\s*.\(.*\))/color-mix(in srgb, \1 \2%, transparent)/'

  # replace lighten() with color-mix(base, white)
  -e 's/lighten(\(.*\),\s*\(.*\))/color-mix(in srgb, \1, white \2)/'

  # replace darken() with color-mix(base, black)`
  -e 's/darken(\(.*\),\s*\(.*\))/color-mix(in srgb, \1, black \2)/'

  # replace hardcoded fonts with variables (not defined in sass)
  -e 's/sans-serif/var(--swagger-ui-font-sans-serif, sans-serif)/'
  -e 's/monospace/var(--swagger-ui-font-monospace, monospace)/'
)
find ./upstream/src/style/ -name "*.scss" -exec gsed -i "${replacements[@]}" {} \;

# define CSS vars for all SCSS vars + copy to new entry point
cp ./upstream/src/style/_variables.scss ./main.scss
gsed -i -e 's/\$\(.\+\):\s*\(.\+\)\s*!default/$\1: var(--swagger-ui-\1, \2)/' main.scss
echo '@import "./upstream/src/style/main";' >> main.scss
