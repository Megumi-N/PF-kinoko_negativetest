// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery3
//= require popper
//= require bootstrap-sprockets

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "jquery";
import "bootstrap";
import "bootstrap/scss/bootstrap";
import "@fortawesome/fontawesome-free/js/all";
import "./js/top";

require("packs/application");

// import "../stylesheets/application.scss";
// import "../stylesheets/application.scss";
// import "../stylesheets/top/index.scss";
// import "../stylesheets/result/index.scss";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

const images = require.context("../images", true);
global.$ = require("jquery");
