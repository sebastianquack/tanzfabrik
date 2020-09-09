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

// enable assets for webpacker
require.context('../svgs', true)

/***************** feature module ****************/

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

/*************** slideshow module ****************/

document.addEventListener("DOMContentLoaded", function () {
  var moduleElems = document.querySelectorAll(".module__slideshow")

  moduleElems.forEach( moduleElem => {

    // get elements
    var nextElem = moduleElem.querySelector(".next")
    var previousElem = moduleElem.querySelector(".previous")

    var slideContainer = moduleElem.querySelector(".slideshow")
    var slides = slideContainer.querySelectorAll(".slide")
    var firstSlide = slides.item(0)

    // TODO re-initialize when layout changes on viewport
    // reset
    var scrollWidth = slideContainer.scrollWidth
    var clientWidth = slideContainer.clientWidth    
    var index = 0
    slideContainer.scrollTo({
      left: 0
    })

    var amountVisibleSlides = Array.from(slides.values()).findIndex(function(slide){ 
      return slide.offsetLeft > clientWidth
    })
    
    nextElem.addEventListener("click", function() { moveSlide(1) })
    previousElem.addEventListener("click", function () { moveSlide(-1) })

    console.log(slideContainer, amountVisibleSlides)

    function moveSlide(direction=1) {

      var currentSlide = Array.from(slides.values()).findIndex(function (slide) {
        return slide.offsetLeft >= (slideContainer.scrollLeft)
      })

      index = currentSlide

      var scrollLeft = slideContainer.scrollLeft
      var targetSlide = slides.item(index + direction)

      console.log(index, scrollLeft)
      var newIndex = index + direction
      if (newIndex >= 0 && newIndex <= slides.length - amountVisibleSlides + 1) {
        slideContainer.scrollTo({ left: targetSlide.offsetLeft - firstSlide.offsetLeft, behavior: 'smooth' })
      }
    }

  })
})

/*******************************/

// do something when X is clicked
document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("[data-close]").forEach((button) => {
    button.addEventListener('click', () => {
      window.history.back();
    });
  });
})

/*************** mobile menu show/hide ******************/

document.addEventListener("DOMContentLoaded", function () {
  var openElem = document.querySelector("button.navTrigger.open")
  var closeElem = document.querySelector("button.navTrigger.close")
  openElem.addEventListener("click", function() {
    document.body.classList.add("menu_open")
  })
  closeElem.addEventListener("click", function () {
    document.body.classList.remove("menu_open")
  })  
})


/*************** mobile menu navigation ******************/

document.addEventListener("DOMContentLoaded", function () {
  var navElem = document.querySelector("#main_nav")
  var ulLevel0Elem = navElem.querySelector("ul > li > ul")
  ulLevel0Elem.addEventListener("click", function(e){
    var mobileMenuEnabled = parseInt(getComputedStyle(document.documentElement).getPropertyValue('--mobile-menu-enabled'));
    if (mobileMenuEnabled) {
      var targetElem = e.target

      var targetElemIsSelected = (targetElem.closest("li")).classList.contains("selected")

      // find all li elements that are parents
      var parentLiElems = []
      var indexElem = targetElem
      while (indexElem != navElem) {
        indexElem = indexElem.parentElement
        if (indexElem.tagName == "LI") {
          parentLiElems.push(indexElem)
        }
      }

      // prevent click unless we are at root of the tree
      if (parentLiElems.length < 3) {
        e.preventDefault();
      }

      // clear marks
      navElem.querySelectorAll("li").forEach(function(elem){
        elem.classList.remove("selected")
      })

      // mark all parent li as selected
      if (!targetElemIsSelected) {
        parentLiElems.forEach(function(elem){
          elem.classList.add("selected")
        })
      }
      //targetElem.parentElement.classList.toggle("selected")
      //targetElem.closest("#main_nav").classList.toggle("selected")
    }
  })
})