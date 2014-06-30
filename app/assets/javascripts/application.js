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
// require jquery.turbolinks // stört editable
// require turbolinks
//= require bootstrap


$(document).ready(function() {

  $(".open-trigger").click( function() {
    $(this).parents('.open-close').addClass("opened")
  });

  $(".close-trigger").click(function () {
    $(this).parents('.open-close').removeClass("opened")
  });

  initMenuContentHide()

});

var initMenuContentHide = function () {
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
      if (delta > 0) {
        $("#content").css("margin-top", -delta + "px")
        $("#content-container").css("top", delta + "px")
      }
      else {
        $("#content").css("margin-top", "0px")
        $("#content-container").css("top", "0px")
      }
    }
  })
}

var setMaxHeight = function(elem) {
    var oldMaxHeight = elem.css("max-height")
    elem.css("visibility", "hidden")
    elem.css("max-height", "400px")
    var maxHeight = elem.outerHeight()
    elem.css("max-height", oldMaxHeight)
    elem.css("visibility", "visible")
    elem.css("max-height", maxHeight)
}

