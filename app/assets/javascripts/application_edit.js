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
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/de-DE
//= require editable/bootstrap-editable
//= require editable/inputs-ext/wysihtml5-editable
//= require editable/rails

$(document).ready(function() {

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};
  $.fn.editable.defaults.wysihtml5 = {
    "toolbar": {
      "image": false, 
      "lists":false, 
      "font-styles":false,
      "lists": false,
      "blockquote":false,
      "html": true,
    },
    "locale": "de-DE"
  };

  $.fn.editable.defaults.mode = 'inline';
  $.fn.editable.defaults.emptytext = '(Klicken, um Text einzufügen)';

  $(".editable").editable();

  
  $("a[rel~=popover], .has-popover").popover();
  $("a[rel~=tooltip], .has-tooltip").tooltip();

  //$('.textarea').wysihtml5();

});

// for wysihtml5
$(document).on('page:load', function(){
  window['rangy'].initialized = false
})