const { environment } = require("@rails/webpacker");

// エントリーファイルの@importでのワイルドカード読み取り
environment.loaders.get("sass").use.push("import-glob-loader");

module.exports = environment;
