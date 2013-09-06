# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $('#property_individual_name').autocomplete({
        source: '/individuals/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#property_individual_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)