     $(document).ready(function() { $("#dropdown").select2({
        placeholder: "Filter Posts"}); 
        });
      $(function(){
      $('#dropdown').bind('change', function () {
         var url = "/tags/" + $( "#dropdown option:selected" ).text()
          if (url) {
              window.location.replace(url);
          }
          return false;
      });
    });