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
//= require turbolinks
//= require bootstrap


$(document).ready(function() {

  $(".open-trigger").click( function() {
    $(this).parents('.open-close').addClass("opened")
  });

  $(".close-trigger").click(function () {
    $(this).parents('.open-close').removeClass("opened")
  });

});

var setMaxHeight = function(elem) {
    var oldMaxHeight = elem.css("max-height")
    elem.css("visibility", "hidden")
    elem.css("max-height", "400px")
    var maxHeight = elem.outerHeight()
    elem.css("max-height", oldMaxHeight)
    elem.css("visibility", "visible")
    elem.css("max-height", maxHeight)
}

/**** EDIT ****/

$(document).ready(function() {

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};

  $.fn.editable.defaults.mode = 'inline';

  $(".editable").editable();

  
  $("a[rel~=popover], .has-popover").popover();
  $("a[rel~=tooltip], .has-tooltip").tooltip();
  
  
  $('.textarea').wysihtml5();

});

// for wysihtml5
$(document).on('page:load', function(){
  window['rangy'].initialized = false
})