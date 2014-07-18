function resource_type_select() {
    $("#resource_photo_path").imagePreview();
    $("#resource_resource_type").change(function() {
        var type = $(this).val();
        switch (type) {
            case 'Foto':
                $("#container_select_file").removeClass('hidden');
                $("#container_media_url").addClass('hidden');
                break;
            case 'Video':
            case 'Audio':
                $("#container_select_file").addClass('hidden');
                $("#container_media_url").removeClass('hidden');
                break;
        }
    });
}