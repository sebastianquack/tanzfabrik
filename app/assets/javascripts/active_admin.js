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
      "lists": false,
      "blockquote":false,
      "html": true,
    },
    "locale": "de-DE",
    parserRules: {
      tags: {
        table: {remove: 0},
        tr: {remove: 0},
        td: {remove: 0}
      }
    }
  });
})

