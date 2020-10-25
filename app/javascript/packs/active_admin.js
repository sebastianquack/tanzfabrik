// Load Active Admin's styles into Webpacker,
// see `active_admin.scss` for customization.

// enable image_pack_tag
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// active admin basics
import "stylesheets/active_admin";
import "@activeadmin/activeadmin";
import "jquery-ui";

// sortable tree (extracted from gem)
import "sortable_tree/jquery.mjs.nestedSortable.js";
import "sortable_tree/sortable.js";

// additional npm modules
import autosize from "autosize"

// front end style sheet for preview
import "stylesheets/application/"

// trix
import Trix from "trix"
import "@rails/actiontext"

// import content modules definitions
import CMConfig from "../../../config/content_module_config.yml"

// customize Trix
Trix.config.blockAttributes.heading1.tagName = "h4";

var editors = {}
var trixListenerSet = false

Trix.config.textAttributes.small = { tagName: "small", terminal: true }

addEventListener("trix-initialize", function(event) {
  console.log("trix-initialize")
  var element = event.target
  let trixId = "trix-id-" + $(element).attr("trix-id")
  editors[trixId] = element.editor
  var toolbarElement = element.toolbarElement
  console.log(toolbarElement)
  var blockGroupElement = toolbarElement.querySelector(".trix-button-group--block-tools")
  var textGroupElement = toolbarElement.querySelector(".trix-button-group--text-tools")
	
  // insert "small" button
  blockGroupElement.insertAdjacentHTML("beforeend", '<button title="Small" type="button" class="trix-button trix-button--icon trix-button--icon-small" data-trix-attribute="small"><small>small</small></button>')
  
  var selectedAttributes = new Set
  function updateSelectedAttributes() {
    selectedAttributes = new Set
    
    var selectedRange = editors[trixId].getSelectedRange()
    if (selectedRange[0] === selectedRange[1]) { selectedRange[1]++ }
    
    var selectedPieces = editors[trixId].getDocument().getDocumentAtRange(selectedRange).getPieces()
    selectedPieces.forEach(function(piece) {
    	Object.keys(piece.getAttributes()).forEach(function(attribute) {
      	selectedAttributes.add(attribute)
      })
    })
  }
  
	updateSelectedAttributes()
  element.addEventListener("trix-selection-change", updateSelectedAttributes) 

  // insert arrow button
  textGroupElement.insertAdjacentHTML("afterbegin", '<button title="↪" type="button" data-trix-action="x-arrow" class="trix-button trix-button--icon trix-button--icon-arrow">↪</button>')
  textGroupElement.insertAdjacentHTML("beforeend", '<button title="Formatierung löschen" type="button" data-trix-action="x-clear-formatting" class="trix-button trix-button--icon trix-button--icon-clear">x</button>')

  if(!trixListenerSet) {
    trixListenerSet = true;
    document.addEventListener("trix-action-invoke", function(event) {
      let trixId = "trix-id-" + $(event.target).attr("trix-id")
      console.log(trixId)
      if(event.actionName === "x-arrow"){
        editors[trixId].insertString("↪ ") // <-- the space is a UTF non-breaking space
      }

      if(event.actionName === "x-clear-formatting") {
        var plainTextOfSelection = editors[trixId].getDocument().toString().substring(...editors[trixId].getSelectedRange());
        editors[trixId].insertString(plainTextOfSelection);
      }
    })
  }

})

addEventListener("trix-paste", function(event) {
  console.log(event.paste)

})


// --> see here for further customization: https://matthaliski.com/blog/customizing-the-trix-toolbar

$( document ).ready(function() {
 console.log("loaded content module config", CMConfig)

  $("#content_module_module_type").on("change", (e)=>{
    let selectedModuleType = $("#content_module_module_type").val()
    
    // always do direct submit & reload
    if(confirm("Modul wird gespeichert - fortfahren?")) {

      // remove parameter when switching content module type
      $("#content_module_parameter").val("");

      $("#edit_content_module").submit()
      return;
    }
    
    // js updates of form not needed anymore - here for future reference
    /*
    console.log("module type changed to", selectedModuleType);

    // update style option drop down
    var options = CMConfig[selectedModuleType]["style-options"]
    var optionsSelect = $("#content_module_style_option");
    optionsSelect.empty(); // remove old options
    options.forEach((option)=> {
      optionsSelect.append($("<option></option>").attr("value", option).text(option));
    });

    // update hidden form fields
    let inputs = [
    "super", "headline", "sub", "special_text", "rich_content_1", "rich_content_2", "custom_html", "parameter"]

    inputs.forEach((input)=>{

      let el = $("#content_module_" + input + "_input");
      let el_en = $("#content_module_" + input + "_en_input");
      let el_de = $("#content_module_" + input + "_de_input");

      if(CMConfig[selectedModuleType]["form-fields"].includes(input)) {
        el.show()
        el_en.show()
        el_de.show()
      } else {
        el.hide()
        el_en.hide()
        el_de.hide()
      }

    });

    // hide or show images and downloads area
    if(CMConfig[selectedModuleType].images == false) {
      $("#active_admin_cm_images").hide()
    } else {
      $("#active_admin_cm_images").show()
    }

    if(CMConfig[selectedModuleType].downloads == false) {
      $("#active_admin_cm_downloads").hide()
    } else {
      $("#active_admin_cm_downloads").show()
    }
    */

  })


  $(".active-admin-delete-content-module").click((event)=>{
    if(!confirm("Modul löschen?"))
      event.preventDefault();
  })

  const textareas = document.querySelectorAll('li.text textarea')
  autosize(textareas);

})