$(function() {
    $(document).ajaxSuccess(function(e, content){
        console.log(content.responseText)
        $(".memos-container").append(content.responseText);
    });
})
