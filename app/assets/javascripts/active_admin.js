#= require active_admin/base
//= require jquery
//= require jquery_ujs
//= require ckeditor-jquery

//= require bootstrap

$(document).ready(function() {
  // $(".edit_link, .view_link").addClass("button")

  //console.log(wysihtml5)


  $('.wysihtml5').ckeditor({
    language: "de",
    width: '79%',
    toolbar: [
      { name: 'format', items: ['Bold', 'Italic', 'Link', 'Unlink'] },
      { name: 'undo', items: ['Undo', 'Redo'] },
      { name: 'copy', items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord'] },
      { name: 'document', items: [ 'Source' ] }
    ]
    
  });  


/*
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
        td: {remove: 0},
        iframe: {check_attributes: {"src": "url"}, set_attributes: {"allowfullscreen": "true"}}
      }
    }
  });
*/
  
    
  
})

