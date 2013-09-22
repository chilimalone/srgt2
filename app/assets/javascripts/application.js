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
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks

function remove_fields(link) {
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest(".fields").remove();
}

function add_fields(link, index, association, content) {
	$(link).parent().before(content);
	$('#property_rooms_attributes_' + index + "_individual_name").autocomplete({
        source: '/individuals/autocomplete',
        minLength: 0,
        select: function(event, ui) {
			$('#property_rooms_attributes_' + index + '_individual_id').val(ui.item.id);
		}
    }).focus(function() {
		$(this).autocomplete("search", this.value);
	});
}
