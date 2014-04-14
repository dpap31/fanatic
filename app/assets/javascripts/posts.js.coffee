ready = ->
  $("#post_tags").tokenInput("/posts/tags.json", {
    prePopulate: $("#post_tags").data("pre"),
    preventDuplicates: true,
    noResultsText:     "No results, needs to be created.",
    animateDropdown:   false,
    theme: "facebook",
    hintText: "Start Taggging..",
    crossDomain: false,
    propertyToSearch: "tags"
  });
$(document).ready(ready)
