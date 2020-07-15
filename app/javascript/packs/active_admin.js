// Load Active Admin's styles into Webpacker,
// see `active_admin.scss` for customization.
import "../stylesheets/active_admin";

import "@activeadmin/activeadmin";

import "jquery-ui";

import "../sortable_tree/jquery.mjs.nestedSortable.js";
import "../sortable_tree/sortable.js";
import "../sortable_tree/sortable.sass";


import CMConfig from "../../../config/content_module_config.yml"

$( document ).ready(function() {
  console.log("loaded content module config", CMConfig)

  $("#content_module_module_type").on("change", (e)=>{
    let selectedModuleType = $("#content_module_module_type").val()
    console.log("module type changed to", selectedModuleType);

    var options = CMConfig[selectedModuleType]
    var optionsSelect = $("#content_module_style_option");
    optionsSelect.empty(); // remove old options
    options.forEach((option)=> {
      optionsSelect.append($("<option></option>").attr("value", option).text(option));
    });

  })

})