var posts_actions = {
    posts_admin: function(event) {
        $(document).on("mouseenter", ".live_editable", function() {
            $(this).find('.live_controls').show();
        });

        $(document).on("mouseleave", ".live_editable", function() {
            $(this).find('.live_controls').hide();
        });
    }
}