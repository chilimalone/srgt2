# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $('#sale_agent_name').autocomplete({
        source: '/agents/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#sale_agent_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#sale_buyer_name').autocomplete({
        source: '/individuals/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#sale_buyer_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#sale_broker_name').autocomplete({
        source: '/individuals/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#sale_broker_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#sale_room_name').autocomplete({
        source: '/rooms/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#sale_room_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)