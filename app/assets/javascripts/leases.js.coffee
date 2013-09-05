# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('#lease_agent_name').autocomplete {
		source: '/agents/autocomplete',
		select: (event, ui) ->
			$('#lease_agent_id').val(ui.item.id)
	}