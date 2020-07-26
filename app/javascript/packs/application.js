/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// styles handled by webpacker
import 'minimal-css-reset/sass/_reset.scss'
import "stylesheets/application/__variables.scss"
import "stylesheets/application/_fonts.scss"
import "stylesheets/application/_general.scss"
import "stylesheets/application/_main_nav.scss"

// all other generic js imports here
import "core-js/stable"
import "regenerator-runtime/runtime"

// stimulus
import "controllers"

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// other
require("trix")
require("@rails/actiontext")