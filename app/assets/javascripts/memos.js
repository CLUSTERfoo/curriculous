$(document).ajaxSuccess(function(e, content){
    console.log(content);
    $(".memos-container").prepend(content.responseText);
});
