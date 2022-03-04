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
import smoothscroll from 'smoothscroll-polyfill';

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

// kick off the smoothscroll polyfill
smoothscroll.polyfill();

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

    //console.log("slideshow",slideContainer, amountVisibleSlides)

    function moveSlide(direction=1) {

      var currentSlide = Array.from(slides.values()).findIndex(function (slide) {
        return slide.offsetLeft >= (slideContainer.scrollLeft)
      })

      index = currentSlide

      var scrollLeft = slideContainer.scrollLeft
      var targetSlide = slides.item(index + direction)

      //console.log("slideshow 2", index, scrollLeft)
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

      console.log(document.referrer)

      // if we are already on tanzfabrik page, just go back 
      /*if(document.referrer.includes("localhost:3000")
        || document.referrer.includes("tanzfabrik")) {
          window.history.back();
      } else {*/

        let baseUrl = window.location.href.split('/').slice(0, 4).join('/')

        if(window.location.href.includes("festivals")) {
          window.location = window.location.href.split('/').slice(0, 6).join('/')
          return
        }
        
        // read event type encoded in meta tag
        function getMeta(metaName) {
          const metas = document.getElementsByTagName('meta');
          for (let i = 0; i < metas.length; i++) {
            if (metas[i].getAttribute('name') === metaName) {
              return metas[i].getAttribute('content');
            }
          }
          return '';
        }
        let destination_page = "";
        let event_type_id = getMeta('event_type')

        if(event_type_id == "2") {
          destination_page = "workshop_programm"
        }
        else if(event_type_id == "3") {
          destination_page = "kursplan"
        }
        else if(event_type_id == "4") {
          destination_page = "profitraining"
        }
        else if(event_type_id == "5") {
          destination_page = "performance_projekte"
        }
        else 
          destination_page = "programm"

        window.location = baseUrl + "/" + destination_page 

      //}  

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

      if (targetElem.tagName != "SPAN" && targetElem.tagName != "A") return;

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


      // mark parent li as selected, other li not
      navElem.querySelectorAll("li").forEach(function (elem) {
        if (!targetElemIsSelected && elemInArray(elem, parentLiElems)) {
          elem.classList.add("selected")  
        } else {
          elem.classList.remove("selected")
        }
      })

      //targetElem.parentElement.classList.toggle("selected")
      //targetElem.closest("#main_nav").classList.toggle("selected")
    }
  })
})

function elemInArray(elem, elemArray) {
  var found = false
  elemArray.forEach(function(elem0){
    if (elem0 === elem) {
      found = true
      return
    }
  })
  return found
}

/****************** AUTO OPEN EXTERNAL LINKS IN NEW TAB ********************/

// Define the Function targetBlank()

function targetBlank() {
  // remove subdomain of current site's url and setup regex
  var internal = location.host.replace("www.", "");
  internal = new RegExp(internal, "i");

  var a = document.getElementsByTagName('a'); // then, grab every link on the page
  for (var i = 0; i < a.length; i++) {
    var href = a[i].host; // set the host of each link
    if (!internal.test(href)) { // make sure the href doesn't contain current site's host
      a[i].setAttribute('target', '_blank'); // if it doesn't, set attributes
      a[i].setAttribute('rel', 'external'); // that's the proper way of doing it (valid XHTML 1.0 Strict)
    }
  }
};

// Run the function targetBlank()

document.addEventListener("DOMContentLoaded", function () {
  targetBlank();
})

/**************** 100vh WORKAROUND for mobile Safari ************/

function update100vh() {
  document.querySelector(':root').style
    .setProperty('--100vh', window.innerHeight + 'px');
}

window.addEventListener('resize', update100vh)
window.addEventListener('orientationChange', update100vh)
document.addEventListener('DOMContentLoaded', update100vh)


/************ auto scroll to first to today on programm page ********/

window.addEventListener("load", function () {
  var element = document.querySelector(".row.event.event-programm:not(.past)")
  if (element) {
    // scroll to center element
    var elementRect = element.getBoundingClientRect();
    var absoluteElementTop = elementRect.top + window.pageYOffset;
    var middle = absoluteElementTop - (window.innerHeight / 3);
    window.scrollTo({
      top: middle,
      left: 0,
      behavior: 'smooth'
    });

  }
})

/************ vorschalt seite **************************************/

window.addEventListener("DOMContentLoaded", function () {
  var element = document.querySelector(".module__vorschalt")
  if (element) {
    // hide all li elements except a random one
    var liElems = element.querySelectorAll("li")
    var randomIndex = Math.floor(Math.random() * liElems.length)
    liElems.forEach(function (elem) {
      if (elem != liElems[randomIndex]) {
        elem.style.display = "none"
      }
    })
    // remove element when clicked on
    element.addEventListener("click", function () {
      element.style.display = "none"
    })
  }
})

