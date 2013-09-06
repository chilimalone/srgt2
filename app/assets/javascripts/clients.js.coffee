$ ->
	$('#client_individual_name').autocomplete({
		source: '/individuals/autocomplete',
		minLength: 0,
		select: (event, ui) -> $('#client_individual_id').val(ui.item.id)
	}).focus -> $(this).autocomplete("search", @value)
