$(document).ready(function() {
    $(".memo-wrapper .image-toggle").click(function(event) {
        // this.append wouldn't work
        var image = $(event.target).siblings("img")[0]
        image.style.display = ((image.style.display == 'block') ? 'none' : 'block');
    });

    // Render LaTeX in posts.
    MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
});
