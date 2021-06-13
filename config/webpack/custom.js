module.exports = {
  resolve: {
    extensions: [".scss"],
    alias: {
      jquery: "jquery/src/jquery",
    },
  },
  performance: {
    maxAssetSize: 700000,
    maxEntrypointSize: 700000,
  },
};
