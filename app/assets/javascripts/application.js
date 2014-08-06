// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks 
//= require jquery.scrollTo
//= require turbolinks
//= require bootstrap
//= require piwik_turbolinks


$(document).ready(function() {

  // set background picture
  var background_image = $("[data-site-background-url]").data("siteBackgroundUrl")
  $(".site-background:after").css("background-image",background_image)
  $("head").append("<style>.site-background:after {background-image: url("+background_image+")}</style>")

  // hide .if-overflown elements when parent .open-close is not overflown
  $(".if-overflown").each ( function (i,elem) {
    base = $(elem).closest('.overflown-base').add($(elem).siblings('.overflown-base'))
    trigger = $(elem).closest('.is-overflown').add($(elem).siblings('.is-overflown'))
    if ($(trigger).overflown_y()) {
      $(base).addClass("overflown")
    }
    else {
      $(base).addClass("not-overflown")
    }
  })

  // set open event
  $(".open-trigger").click( function() {
    if ($(this).hasClass("close-others")) {
      $(".open-close.opened").removeClass("opened")
    }
    base = $(this).closest('.open-close')
    if (!base.hasClass("opened")) {
      toggleHeightElems = base.parent().find(".open-toggle-height")
      if (toggleHeightElems.length > 0) {
        toggleHeightElem = $(toggleHeightElems.get(0))
        toggleHeightElem.data("closed-height", toggleHeightElem.css("height"))
        toggleHeightElem.css("height", toggleHeightElem.prop("scrollHeight"))
        console.log(toggleHeightElem.prop("scrollHeight"))
      }
      base.addClass("opened")
      $(this).closest('.open-close-shade').addClass("shaded")
    }
  });

  // set close event
  $(".close-trigger").click(function (event) {
    event.stopPropagation();
    base = $(this).closest('.open-close')
    if (base.hasClass("opened")) {
      toggleHeightElems = base.parent().find(".open-toggle-height")
      if (toggleHeightElems.length > 0) {
        console.log(toggleHeightElems)
        toggleHeightElem = $(toggleHeightElems.get(0))
        toggleHeightElem.css("height", toggleHeightElem.data("closed-height"))
      }    
      base.removeClass("opened")
      $(this).closest('.open-close-shade').removeClass("shaded")
    }
  });

  // adjust content container height for popups
  adjust_cc_height_elems = $(".adjust-content-container-height")
    if (adjust_cc_height_elems.length > 0) {
    cc_height = $("#content-container").height()
    max = cc_height
    adjust_cc_height_elems.each (function () {
      bottom_y = $(this).prop("scrollHeight") + $(this).offset().top
      if (bottom_y > max) max = bottom_y
      console.log(max)
    })
    $("#content-container").css("padding-bottom", (max-cc_height) + "px")
  }


  // scroll to anchor
  if (location.hash.length > 1) {
    last_w = 0
    check_render_status = setInterval(function() {
      var w=$(window).height()
      if (last_w == w) {
        window.clearInterval(check_render_status)
        if ($("#_"+location.hash.substr(1)).length == 1) {
          elem = $("#_"+location.hash.substr(1))
        }
        else if ($(location.hash).length == 1) {
          elem = $(location.hash)
        }
        else return;
        elem.find(".open-close").addClass("opened")
        setTimeout( function() {scrollScreenTo(elem, 1500)}, 20)
      }      
      last_w = w
    }, 20)
  }

  // form events
  $(".form-radio input[type=radio] + .input-style-helper").click(function () {
    radio = $(this).prev('input[type=radio]')
    radios = $(this).parents(".form-radio").find("input[type=radio]")
    radios.each(function(i,elem) {
      $(this).removeAttr("checked")
      $(this).removeClass("checked")
    })
    radio.attr("checked", true)
    radio.addClass("checked")
  })

  $(".form-checkbox input[type=checkbox] + .input-style-helper").click(function () {
    checkbox = $(this).prev('input[type=checkbox]')
    if (checkbox.attr("checked") == "checked") {
      checkbox.removeAttr("checked")
      checkbox.removeClass("checked")
    }
    else {
      checkbox.attr("checked", true)
      checkbox.addClass("checked")
    }
  })

  initMenuContentHide()

});

// clip #content on top where it is behind an opened 3rd level menu
var initMenuContentHide = function () {
  topInit = parseInt($("#content-container").css("top"))
  $("#content-container").data("defaultTop", topInit)  
  last_menu3Height = null
  $("#top-menu ul ul li").on("mouseenter mouseleave", function () { 
    menu3 = $("#top-menu ul ul ul:visible")
    menu3Height = menu3.outerHeight()
    if (last_menu3Height != menu3Height) {
      last_menu3Height = menu3Height
      if (menu3Height == null) {
        delta = 0
      }
      else {
        menu3Offset = menu3.offset().top
        contentOffset = $("#content-container").offset().top
        delta = menu3Offset + menu3Height - contentOffset
      }
      topPlus = $("#content-container").data("defaultTop")
      if (delta > 0) {
        $("#content").css("margin-top", -delta + "px")
        $("#content-container").css("top", (delta+topPlus) + "px")
      }
      else {
        $("#content").css("margin-top", "0px")
        $("#content-container").css("top", topPlus + "px")
      }
    }
  })
}

// determine element height for css transition
var setMaxHeight = function(elem) {
    var oldMaxHeight = elem.css("max-height")
    elem.css("visibility", "hidden")
    elem.css("max-height", "400px")
    var maxHeight = elem.outerHeight()
    elem.css("max-height", oldMaxHeight)
    elem.css("visibility", "visible")
    elem.css("max-height", maxHeight)
}

// detect overflow
$.fn.overflown_y=function(){
  var e=this[0];
  return (e.scrollHeight-1)>e.clientHeight;
}

//borrowed from jQuery easing plugin
//http://gsgd.co.uk/sandbox/jquery.easing.php
$.easing.elasout = function(x, t, b, c, d) {
  var s=1.70158;var p=0;var a=c;
  if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
  if (a < Math.abs(c)) { a=c; var s=p/4; }
  else var s = p/(2*Math.PI) * Math.asin (c/a);
  return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
};

// scroll whole screen
var scrollScreenTo = function (el, duration) {
    var elOffset = el.offset().top;
    var elHeight = el.height();
    var windowHeight = $(window).height();
    var offset;

    if (elHeight < windowHeight) {
      offset = elOffset - ((windowHeight / 2) - (elHeight / 2));
    }
    else {
      offset = elOffset;
    }

    $.scrollTo( offset, duration, { easing:'elasout' } );
  }