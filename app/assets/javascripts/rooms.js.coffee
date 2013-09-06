# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $('#room_property_name').autocomplete({
        source: '/properties/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#room_property_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)