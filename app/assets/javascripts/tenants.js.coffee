# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $('#tenant_individual_name').autocomplete({
        source: '/individuals/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#tenant_individual_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#tenant_room_name').autocomplete({
        source: '/rooms/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#tenant_room_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)