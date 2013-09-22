# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $('#tour_agent_name').autocomplete({
        source: '/agents/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#tour_agent_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#tour_client_name').autocomplete({
	    source: '/clients/autocomplete',
	    minLength: 0,
	    select: (event, ui) -> $('#tour_client_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#tour_room_name').autocomplete({
        source: '/rooms/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#tour_room_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)