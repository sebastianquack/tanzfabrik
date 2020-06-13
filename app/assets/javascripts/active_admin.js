#= require active_admin/base
//= require jquery
//= require ckeditor-jquery
//= require active_admin/sortable
//= require bootstrap

$(document).ready(function() {
  // $(".edit_link, .view_link").addClass("button")

  //console.log(wysihtml5)

CKEDITOR.stylesSet.add( 'my_styles', [
    // Block-level styles
    { name: 'Klein', element: 'small', },
    { name: 'H4', element: 'h4', }
    ] );


  $('.wysihtml5').ckeditor({
    language: "de",
    width: '79%',
    height: '450px',
    toolbar: [
      { name: 'format', items: ['Bold', 'Italic','Small', 'Link', 'Unlink', 'Styles'] },
      { name: 'undo', items: ['Undo', 'Redo'] },
      { name: 'copy', items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord'] },
      { name: 'document', items: [ 'Source'] },
      { name: 'table', items: [ 'Table'] },
      { name: 'image', items: [ 'Image' ] }
    ],
    stylesSet: 'my_styles'
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

