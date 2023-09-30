const path = require("path");
const CopyPlugin = require("copy-webpack-plugin");

const upstream = require("./upstream/webpack/stylesheets.js");

module.exports = {
  ...upstream,
  entry: {
    "swagger-ui": "./main.scss",
  },
  output: {
    path: path.join(__dirname, "dist"),
    publicPath: "/dist",
  },
  plugins: [
    ...upstream.plugins,
    new CopyPlugin({
      patterns: [{ from: "./upstream/src/style", to: "scss" }],
    }),
  ],
};
