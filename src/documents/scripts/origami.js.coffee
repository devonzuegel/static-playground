	
class Origami
	hierarchy = ['H1', 'H2', 'H3', 'H4', 'H5', 'H6']

	## public::constructor()
	 #		Initialize Origami object
	 # Params
	 #  	to_fold {array}: List of header types to fold
	 # Return value
	 #		true:  if a defined array that doesn't only contain ""
	 #		false: otherwise
	constructor: (to_fold) ->
		to_fold = if is_defined(to_fold) then to_fold else []
		elems = $.makeArray($('#fold-here').siblings()).reverse()
		headers = (e for e in elems when e.tagName in hierarchy)


		#e.innerHTML in hierarchy
		# elems[0].innerHTML = '+ ' + elems[0].innerHTML
		for e in elems by -1
			e.innerHTML = "<a href='#'>+ #{e.innerHTML}</a>"

		console.log headers

	##### Private ###############################################

	## private::is_defined()
	 #		Normalize `to_fold` array
	 # Params
	 #  	to_fold {array}: List of header types to fold
	 # Return value
	 #		true:  if a defined array that doesn't only contain ""
	 #		false: otherwise
	is_defined = (to_fold) ->
		return (to_fold) and (JSON.stringify(to_fold) != '[""]')


$(document).ready ->
	origami = new Origami(document.origami)