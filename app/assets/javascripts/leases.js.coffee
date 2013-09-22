# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $('#lease_agent_name').autocomplete({
        source: '/agents/autocomplete',
        minLength: 0,
        select: (event, ui) -> $('#lease_agent_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#lease_client_name').autocomplete({
	    source: '/clients/autocomplete',
	    minLength: 0,
	    select: (event, ui) -> $('#lease_client_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
    $('#lease_room_name').autocomplete({
	    source: '/room/autocomplete',
	    minLength: 0,
	    select: (event, ui) -> $('#lease_room_id').val(ui.item.id)
    }).focus -> $(this).autocomplete("search", @value)
