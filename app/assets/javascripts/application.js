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
//= require jquery_ujs
//= require jquery.turbolinks 
//= require jquery.scrollTo
//= require turbolinks
//= require bootstrap
//= require parsley
//= require parsley.i18n.de 
//= require piwik_turbolinks

$(document).ready(function() {

  document.addEventListener("touchstart", function() {},false);

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
    base = $(this).closest('.open-close')
    if ($(this).hasClass("close-others")) {
      var group = base.data("open-close-group")
      //console.log(group)
      $(".open-close.opened[data-open-close-group="+group+"]").removeClass("opened")
    }
    if (!base.hasClass("opened")) {
      if (base.hasClass("open-toggle-height"))
        toggleHeightElems = base  
      else
        toggleHeightElems = base.find(".open-toggle-height")
      if (toggleHeightElems.length > 0) {
        toggleHeightElem = $(toggleHeightElems.get(0))
        toggleHeightElem.data("closed-height", toggleHeightElem.css("height"))
        toggleHeightElem.css("height", toggleHeightElem.prop("scrollHeight"))
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
        toggleHeightElem = $(toggleHeightElems.get(0))
        var closed_height = toggleHeightElem.data("closed-height") || 0
        toggleHeightElem.css("height", closed_height)
      }    
      base.removeClass("opened")
      $(this).closest('.open-close-shade').removeClass("shaded")
    }
  });

  // init opened elements method 1
  setTimeout(function () {
    $(".open-close.init-opened").removeClass("init-opened").find(".open-trigger").trigger("click")
  }, 200)

  // init opened elements method 2
  $(".open-close.opened .open.open-toggle-height").css("height",$(".open-close.opened .open.open-toggle-height").height()+"px")

  // adjust content container height for popups
  adjust_cc_height_elems = $(".adjust-content-container-height")
    if (adjust_cc_height_elems.length > 0) {
    cc_height = $("#content-container").height()
    max = cc_height
    adjust_cc_height_elems.each (function () {
      bottom_y = $(this).prop("scrollHeight") + $(this).offset().top
      if (bottom_y > max) max = bottom_y
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
        var triggerElem = elem.find(":not(.opened) .open-trigger")
        var scrollElem = elem.find(".open-toggle-height")
        var parentElem = $(elem).find(".open-close")
        parentElem.addClass("no-height-transition")
        triggerElem.trigger("click")
        setTimeout( function() {scrollScreenTo(scrollElem, 1500, function(){parentElem.removeClass("no-height-transition")} )}, 20)
        //$(location.hash +"  
      }      
      last_w = w
    }, 20)
  }

  // alphabet menu events
  $(".alphabet a").click(function(event) {
    event.preventDefault()
    var li = $(event.target).parent()
    
    if(li.hasClass("unavailable")) {
      return
    } 
    
    $(li.toggleClass("selected"))
    $(".alphabet li").not(li).removeClass("selected")
    
    $(".alphabet li").each(function(index, elem) {
      if($(elem).hasClass("selected") || $(".alphabet .selected").length == 0) {
        $(".teacher[data-letter='"+$(elem).attr("data-letter")+"']").show()
      } else {
        $(".teacher[data-letter='"+$(elem).attr("data-letter")+"']").hide()
      }
    })
    
  })

  // form events
  $(".form-radio input[type=radio] + .input-style-helper").click(function () {
    radio = $(this).prev('input[type=radio]')
    radios = $(this).parents(".form-radio").find("input[type=radio]")
    radios.each(function(i,elem) {
      $(this).prop("checked", false)
      $(this).removeClass("checked")
    })
    radio.prop("checked", true)
    radio.addClass("checked")
  })

  $(".form-checkbox input[type=checkbox] + .input-style-helper").click(function () {
    checkbox = $(this).prev('input[type=checkbox]')
    if (checkbox.prop("checked")) {
      checkbox.prop("checked",false)
      checkbox.removeClass("checked")
    }
    else {
      checkbox.prop("checked", true)
      checkbox.addClass("checked")
    }
    checkbox.trigger("change")
  })

  initMenuContentHide()

  // background fading init (executed once with turbolinks)
  if (typeof last_background_status == "undefined") {
    last_background_status = $("body.start").length == 1 ? "strong" : "weak"
    if (last_background_status == "strong") {
      $(".site-background").addClass(last_background_status)
      //console.log("init "+ last_background_status)
    }
  }

  // highlight finds on page

  var find = getUrlParameterByName('f')

  if (find && typeof(window.find) == "function") {
    window.find(find)
  }

  // manage start video

  $('.start_video_close').click(function(){
    $('.start_video').addClass('closed')
  })

  // special 40 years logo
  // $("#logo span").on("transitionend", function() {
  //   $("#logo").addClass("transitionend")
  // })
  

  // add ready to html when it's ready

  $("html").addClass("ready")

});

// background fading on turbolinks page load 
$(document).on('page:change', function () {
  new_background_status = $("body.start").length == 1 ? "strong" : "weak"
  $(".site-background").addClass(last_background_status)
  setTimeout(function() {
    $(".site-background").removeClass(last_background_status)
    $(".site-background").addClass("with-transition")
    $(".site-background").addClass(new_background_status)
    last_background_status = new_background_status
  }, 10)
  
})

/********* functions **********/

// clip #content on top where it is behind an opened 3rd level menu
var initMenuContentHide = function () {
  topInit = parseInt($("#content-container").css("top"))
  $("#content-container").data("defaultTop", topInit)  
  last_menu3Height = null
  $("#top-menu ul ul li").on("mouseenter mouseleave", contentHider)
}

contentHider = function () { 
  setTimeout( function() { // firefox needs a delay to be able to restore
    var contentContainer = $("#content-container")
    menu3 = $("#top-menu ul ul ul:visible")
    menu3Height = menu3.outerHeight()
    if (last_menu3Height != menu3Height) {
      last_menu3Height = menu3Height
      if (menu3Height == null) {
        delta = 0
      }
      else {
        var menu3Offset = menu3.offset().top
        var contentOffset = contentContainer.offset().top
        var delta = menu3Offset + menu3Height - contentOffset
      }
      //console.log(menu3Height, menu3Offset, contentOffset, delta)
      var topPlus = contentContainer.data("defaultTop")
      var container_height = contentContainer.height()
      if (delta > 0) {
        $("#content").css("margin-top", -delta + "px")
        contentContainer.css("top", (delta+topPlus) + "px")
      }
      else {
        $("#content").css("margin-top", "0px")
        contentContainer.css("top", topPlus + "px")
      }
      contentContainer.height(container_height)
    }
  },1)
}

function reflow(elt){
    //console.log(elt.offsetHeight);
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
var scrollScreenTo = function (el, duration, cb) {
    var elOffset = el.offset().top;
    var elHeight = el.height();
    //console.log(elHeight)
    var windowHeight = $(window).height();
    var offset;

    if (elHeight < windowHeight) {
      offset = elOffset - ((windowHeight / 2) - (elHeight / 2));
    }
    else {
      offset = elOffset;
    }

    $.scrollTo( offset, duration, { easing:'elasout' }, (typeof(cb)=="function"? cb() : null) );
  }

// get parameter from URL
function getUrlParameterByName(name, url) {
  if (!url) url = window.location.href;
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}
