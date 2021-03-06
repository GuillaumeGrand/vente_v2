// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "jquery";
import "popper.js";
import "bootstrap";

import "../stylesheets/application";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
require("packs/create_checkout.js")
require("packs/stripe_sub.js")
require("packs/trader_token.js")
require("packs/success.js")
require("packs/zoom_photo.js")
require("packs/select_value_dropdown.js")
require("packs/identification.js")
require("jquery")
