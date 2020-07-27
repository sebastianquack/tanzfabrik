// Load Active Admin's styles into Webpacker,
// see `active_admin.scss` for customization.

// active admin basics
import "../stylesheets/active_admin";
import "@activeadmin/activeadmin";
import "jquery-ui";

// sortable tree (extracted from gem)
import "../sortable_tree/jquery.mjs.nestedSortable.js";
import "../sortable_tree/sortable.js";
import "../sortable_tree/sortable.sass";

// front end style sheet for preview
import "stylesheets/application/"

// trix
import "trix"


import CMConfig from "../../../config/content_module_config.yml"

$( document ).ready(function() {
  console.log("loaded content module config", CMConfig)

  $("#content_module_module_type").on("change", (e)=>{
    let selectedModuleType = $("#content_module_module_type").val()
    
    // always do direct submit & reload
    if(confirm("Modul wird gespeichert - fortfahren?")) {
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



})