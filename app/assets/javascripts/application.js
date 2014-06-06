// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.sortable
//= require jquery.ui.accordion
//= require bootstrap
//= require turbolinks
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/es-ES
//= require jquery.Jcrop
//= require_tree .

// $(document).ready(over_and_clicks);

// Generate preview ehen select image on input type=file
(function($) {

    $.extend(true, jQuery.fn, {
        imagePreview: function(options) {
            var defaults = {};
            if (options) {
                $.extend(true, defaults, options);
            }
            $.each(this, function() {
                var $this = $(this);
                $this.bind('change', function(evt) {

                    var files = evt.target.files; // FileList object
                    // Loop through the FileList and render image files as thumbnails.
                    for (var i = 0, f; f = files[i]; i++) {
                        // Only process image files.
                        if (!f.type.match('image.*')) {
                            continue;
                        }
                        var reader = new FileReader();
                        // Closure to capture the file information.
                        reader.onload = (function(theFile) {
                            return function(e) {
                                // Render thumbnail.
                                $('#image_url').attr('src', e.target.result);
                            };
                        })(f);
                        // Read in the image file as a data URL.
                        reader.readAsDataURL(f);
                    }

                });
            });
        }
    });

    $.extend(true, jQuery.fn, {
        large_scroll: function() {
            $.each(this, function() {
                $(".large_scroll").hover(function() {
                    var $daChild = $(this).find('.children_scroll'),
                        maxHeight = $(this).height(),
                        totalTop = $(this).offset().top,
                        childHeight = $daChild.height();

                    if (childHeight > maxHeight) {
                        $(this).on('mousemove', function(e) {
                            var onSet = (e.pageY) - totalTop,
                                daTop = ((onSet * childHeight) / maxHeight);
                            $daChild.css({
                                top: -(daTop - 100)
                            });
                        });
                    } else $('#container_arrows').hide();
                }, function() {
                    var topcenter = $(this).find('.children_scroll').data('topcenter');
                    var child_Offset = $('.date_active').position().top;
                    var topValue = child_Offset - topcenter;
                    $('.children_scroll').stop().animate({
                        top: -topValue
                    }, 300);
                });
            });
        }
    });

})(jQuery);

function over_and_clicks() {

    //Hovers & clicks for Views => spot_new & attendance_new

    $(document).on("mouseenter", ".child_selector, .child_attendance", function() {
        $(this).find('.child_selected').fadeIn(250);
        $(this).find('.child_selected span').stop().animate({
            opacity: 1,
            top: 13
        }, 600, 'easeOutQuart');
    });
    $(document).on("mouseleave", ".child_selector, .child_attendance", function() {
        $(this).find('.child_selected').fadeOut(250);
        $(this).find('.child_selected span').stop().animate({
            opacity: 0,
            top: 25
        }, 600, 'easeOutQuart');
    });

    $(document).on("click", ".asistente, .inscrito", function() {
        $(this).remove();
    });

    $(document).on("mouseenter", ".pops", function() {
        $(this).popover('show');
    });

    $(document).on("mouseleave", ".pops", function() {
        $(this).popover('hide');
    });

    $(document).on("mouseenter", ".attendance_photo", function() {
        $(this).find('.child_attendance_over').stop().fadeIn();
        $(this).find('.child_attendance_over span').stop().animate({
            top: 27,
            opacity: 1
        }, 600, 'easeOutQuart');
    });

    $(document).on("mouseleave", ".attendance_photo", function() {
        $(this).find('.child_attendance_over').stop().fadeOut();
        $(this).find('.child_attendance_over span').stop().animate({
            top: 7,
            opacity: 0
        }, 600, 'easeOutQuart', function() {
            $(this).removeAttr('style');
        });
    });

    $(document).on('click', '.close_results', function() {
        var theID = $(this).attr('id').replace('close_results_', '');
        $("#" + theID + "_search_container").hide();
    });

    $(document).on('submit', "#searcher_exercises_form, #searcher_payments_form", function() {
        var modalID = $(this).attr('id').replace('_form', '');
        $("#" + modalID).modal('hide');
    });

    $('.tip').tooltip();
    // $(document).on('click', '.date_over', function() {
    //     alert("click")
    //     $(this).addClass('date_active');
    //     $('.date_over').not(this).removeClass('date_active');
    // });

    $('.date_over').on('click', function() {
        $(this).addClass('date_active');
        $('.date_over').not(this).removeClass('date_active');
    });

}

function scrollAdjust() {

    $('.tiny_scroll').each(function() {
        var tinyScroll = $(this);
        tinyScroll.tinyscrollbar();
        var newScroll = tinyScroll.data("plugin_tinyscrollbar");
        newScroll.update();
    });
    $('.modal_attendance').on('show.bs.modal', function() {
        var theID = $(this).attr('id').replace('att_', '');
        $("#form_child_container_" + theID).load("/attendances/observation/" + theID + " #form_child_container", function() {
            var tinyScroll = $("#tiny_att_" + theID);
            tinyScroll.tinyscrollbar();
            $('.observation_wysiwyg').wysihtml5({
                "font-styles": false,
                "emphasis": true,
                "lists": true,
                "html": false,
                "link": true,
                "image": false,
                "color": true,
                "locale": "es-ES"
            });
        });
    });

    $('.modal_attendance').on('hide.bs.modal', function() {
        var theID = $(this).attr('id').replace('att_', '');
        $("#form_child_container_" + theID + " .observation_wysiwyg").html("");
    });

}

function sort_tables() {
    $(".tablesorter").tablesorter();
}