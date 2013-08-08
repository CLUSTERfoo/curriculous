$(document).ajaxSuccess(function(e, content){
    console.log(content);
    console.log("hi");
    $(".memos-container").append(content.responseText);
});
