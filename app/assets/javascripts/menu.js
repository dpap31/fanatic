# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(function(){
var to;
    function pieceHeights(){
        to = setTimeout(function(){
            $(".pure-g-r").each(function(i,el){
                var contentPieces = $(el).find(".dashboard-piece");
                var max = 0;
                contentPieces.css("min-height","");
                $.grep(contentPieces, function(el,i){
                    max = Math.max($(el).outerHeight(),max);
                });
                contentPieces.css("min-height", max);
            });
        }, 400);
    }
    $(window).on("resize", function(){
        clearTimeout(to);
        pieceHeights();
    }).trigger("resize");
}());