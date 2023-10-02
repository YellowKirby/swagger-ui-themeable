const path = require("path");
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
};
