rm -rf upstream
git clone --filter=blob:none --no-checkout --depth 1 --sparse https://github.com/swagger-api/swagger-ui upstream
cd upstream
git sparse-checkout add src/style src/core/plugins webpack
git checkout
rm -rf .git
find ./src/style/ -name "*.scss" -exec gsed -i \
  `# replace rgba() with color-mix(base, transparent) so that we can add transparency to CSS vars` \
  -e 's/rgba(\(.*\),\s*.\(.*\))/color-mix(in srgb, \1 \2%, transparent)/' \
  `# replace lighten() with color-mix(base, white)` \
  -e 's/lighten(\(.*\),\s*.\(.*\))/color-mix(in srgb, \1, white \2)/' \
  `# replace darken() with color-mix(base, black)` \
  -e 's/darken(\(.*\),\s*.\(.*\))/color-mix(in srgb, \1, black \2)/' \
  `# replace hardcoded fonts with variables (not defined in sass)` \
  -e 's/sans-serif/var(--swagger-ui-font-sans-serif, sans-serif)/' \
  -e 's/monospace/var(--swagger-ui-font-monospace, monospace)/' \
  {} \;
