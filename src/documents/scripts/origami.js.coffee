	
class Origami
	hierarchy = []

	## public::constructor()
	 #		Initialize Origami object
	 # Params
	 #  	to_fold {array}: List of header types to fold
	 # Return value
	 #		true:  if a defined array that doesn't only contain ""
	 #		false: otherwise
	constructor: (to_fold) ->
		hierarchy = to_fold if is_defined(to_fold)
		fold_here = $('#origami') || $('body')
		elems = $.makeArray(fold_here.siblings())
		console.log hierarchy

		for hdr, h in elems when hdr.tagName in hierarchy
			hdr.innerHTML = "<a href='#'>+ #{hdr.innerHTML}</a>"
			children = (e for e in elems[h+1..] when is_child_of(e, hdr))
			
			console.log ''
			console.log hdr
			console.log children

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

	is_child_of = (el, hdr) ->
		hierarchy.indexOf el.tagName < hierarchy.indexOf hdr.tagName



$(document).ready ->
	origami = new Origami(document.origami)