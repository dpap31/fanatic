
$(document).ready(function(){
// Select 2 With AJAX
$(function () {
    $('#dropdown').select2({
        placeholder: "Filter Posts",
        minimumInputLength: 2,
        selectOnBlur: true,
        formatResult: format,
        createSearchChoice: function(term, data) {
        if ($(data).filter(function() {
              return this.name.localeCompare(term) === 0;
            }).length === 0) {
              return {
                id: term,
                text: term
              };
            }
        },
        ajax: {
            dataType: 'json',
            url: '/posts/tags.json',
            data: function (term, page) {
                return { q: term };
            },
            results: function(data, page) {
                return { results: data };
            }
        }
    })
function format(item) { return item.name; }

//onSelect find highlighted value and redirect to URL
$('#dropdown').on("select2-selecting", function(e) { 
   var url = "/tags/" + $( ".select2-highlighted" ).text()
      if (url) {
              window.location.replace(url);
          }
          return false;
});
});
});




    // // Working Select2 Drop Down w/ out ajax
    //  $(document).ready(function() { $("#dropdown").select2({
    //     placeholder: "Filter Posts"}); 
    //     });
    //   $(function(){
    //   $('#dropdown').bind('change', function () {
    //      var url = "/tags/" + $( "#dropdown option:selected" ).text()
    //       if (url) {
    //           window.location.replace(url);
    //       }
    //       return false;
    //   });

 // $('#dropdown2').select2({
 //                minimumInputLength: 2,
 //        ajax: {
 //            url: "posts/tags.json",
 //            dataType: 'json',
 //            data: function (term, page) {
 //                return {
 //                    q: term
 //                  };
 //            },
 //            results: function (data, page) {
 //                return {
 //                    results: data
 //                };
 //            }
 //        }
 //    });
  

//     $("#dropdown2").select2({
//     placeholder: "Filter Posts",
//     minimumInputLength: 2,
//     ajax: {
//         url: "/posts/tags.json",
//         dataType: 'jsonp',
//         quietMillis: 100,
//         data: function (term, page) { // page is the one-based page number tracked by Select2
//             return {
//                 q: term, //search term
//                 page_limit: 10, // page size
//                 page: page, // page number
//                 apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
//             };
//         },
//         results: function (data, page) {
//             var more = (page * 10) < data.total; // whether or not there are more results available
 
//             // notice we return the value of more so Select2 knows if more results can be loaded
//             return {results: data.name};
//         }
//     },
//     dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
//     escapeMarkup: function (m) { return m; } // we do not want to escape markup since we are displaying html in results
// });


  // Create Filter
  //     ready = function() {
  // return $("#post_tags").tokenInput("/posts/tags.json", {
  //   prePopulate: $("#post_tags").data("pre"),
  //   preventDuplicates: true,
  //   noResultsText: "No results, needs to be created.",
  //   animateDropdown: false,
  //   theme: "facebook",
  //   placeholder: 'Add Tags',
  //   crossDomain: false,
  //   allowFreeTagging: true,
  //   tokenValue: 'name'
  // });
