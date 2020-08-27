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
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// styles handled by webpacker
import 'minimal-css-reset/sass/_reset.scss'
import "stylesheets/application/"

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



/*********************************/

// observe if the feature module is visible
document.addEventListener("DOMContentLoaded", function () {
  if (
    "IntersectionObserver" in window &&
    "IntersectionObserverEntry" in window &&
    "intersectionRatio" in window.IntersectionObserverEntry.prototype
  ) {
    let observer = new IntersectionObserver(entries => {
      //console.log(entries[0].boundingClientRect.height + entries[0].boundingClientRect.y - entries[0].intersectionRect.height)
      if (entries[0].boundingClientRect.height + entries[0].boundingClientRect.y - entries[0].intersectionRect.height >= 0) {
        document.body.classList.add("featured_visible");
      } else {
        document.body.classList.remove("featured_visible");
      }
    });
    var elements = document.querySelector(".end_of_module__feature")
    if (elements) observer.observe(elements);
  }
})

// do something when X is clicked
document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("[data-close]").forEach((button) => {
    button.addEventListener('click', () => {
      window.history.back();
    });
  });
})