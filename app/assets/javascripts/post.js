function posts() {
    posts_admin();
}


function posts_admin() {
    $('.wysiwyg-post').each(function(i, elem) {
        $(elem).wysihtml5();
    });
    $(document).on("mouseenter", ".live_editable", function() {
        $(this).find('.live_controls').show();
    });

    $(document).on("mouseleave", ".live_editable", function() {
        $(this).find('.live_controls').hide();
    });
}