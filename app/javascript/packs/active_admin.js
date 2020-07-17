// Load Active Admin's styles into Webpacker,
// see `active_admin.scss` for customization.
import "../stylesheets/active_admin";

import "@activeadmin/activeadmin";

import "jquery-ui";

import "../sortable_tree/jquery.mjs.nestedSortable.js";
import "../sortable_tree/sortable.js";
import "../sortable_tree/sortable.sass";


import "trix"


import CMConfig from "../../../config/content_module_config.yml"

$( document ).ready(function() {
  console.log("loaded content module config", CMConfig)

  $("#content_module_module_type").on("change", (e)=>{
    let selectedModuleType = $("#content_module_module_type").val()
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

    })




  })

})