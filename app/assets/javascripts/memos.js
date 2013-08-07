$(function() {
    $(".marker").on("ajax:success", function(e, content){
        $(".memos-container").append(content) 
    });
})
