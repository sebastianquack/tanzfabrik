#= require active_admin/base
//= require jquery
//= require bootstrap
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/de-DE

$(document).ready(function() {
  // $(".edit_link, .view_link").addClass("button")

  $('.wysihtml5').wysihtml5({
    "toolbar": {
      "image": false, 
      "lists":false, 
      "font-styles":false,
      "blockquote":false,
    },
    "locale": "de-DE"
  });
})

