window.onload = function () {

//jQuery File Upload
$(function () {
    'use strict';
    $('#fileupload').fileupload({
        replaceFileInput: false,
        url:'nil',
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo('#files');
            });
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
});
$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        add: function (e, data) {
            data.context = $('<p/>').text('Image Uploaded').appendTo('#files');
            data.submit();
        },
        done: function (e, data) {
            data.context.text('Image uploaded.');
        }
    });
});

var ready;
//Token Input
tokenOptions = {
    allowFreeTagging: true,
    tokenValue: 'name'
}
ready = function() {
  return $("#post_tags").tokenInput("/posts/tags.json", {
    prePopulate: $("#post_tags").data("pre"),
    preventDuplicates: true,
    noResultsText: "No results, needs to be created.",
    animateDropdown: false,
    theme: "facebook",
    placeholder: 'Add Tags',
    crossDomain: false,
    allowFreeTagging: true,
    tokenValue: 'name'
  });
};
// WYSWIG Text Editor
$(document).ready(ready);
$(function(){
    function initToolbarBootstrapBindings() {
      var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier', 
            'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
            'Times New Roman', 'Verdana'],
            fontTarget = $('[title=Font]').siblings('.dropdown-menu');
      $.each(fonts, function (idx, fontName) {
          fontTarget.append($('<li><a data-edit="fontName ' + fontName +'" style="font-family:\''+ fontName +'\'">'+fontName + '</a></li>'));
      });
      $('a[title]').tooltip({container:'body'});
      $('.dropdown-menu input').click(function() {return false;})
        .change(function () {$(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');})
        .keydown('esc', function () {this.value='';$(this).change();});

      $('[data-role=magic-overlay]').each(function () { 
        var overlay = $(this), target = $(overlay.data('target')); 
        overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
      });
      if ("onwebkitspeechchange"  in document.createElement("input")) {
        var editorOffset = $('#editor').offset();
        $('#voiceBtn').css('position','absolute').offset({top: editorOffset.top, left: editorOffset.left+$('#editor').innerWidth()-35});
      } else {
        $('#voiceBtn').hide();
      }
  };
  $( document ).ready(function() {
  function showErrorAlert (reason, detail) {
    var msg='';
    if (reason==='unsupported-file-type') { msg = "Unsupported format " +detail; }
    else {
      console.log("error uploading file", reason, detail);
    }
    $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
     '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
  };
    initToolbarBootstrapBindings();  
  $('#editor').wysiwyg({ fileUploadError: showErrorAlert} );
    window.prettyPrint && prettyPrint();
  });
  });
  function getContent(){
var form = $('#new_post');
var element;
$('[contenteditable=true]').each(function(){
  element = $(this);
  form.append($('<input/>', {
    type:'hidden',
    name:'post[content]',
    value:element.html()
  }));
});
};
var get = document.getElementById('form_submit')
get.addEventListener('click', getContent)
};