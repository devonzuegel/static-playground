	
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
		hierarchy = if is_defined(to_fold) then to_fold else []
		origami_tag = $('#origami')[0] || $('body')
		console.log origami_tag
		elems = $.makeArray($('#origami').siblings())

		for hdr, h in elems when hdr.tagName in hierarchy
		# 	for elem, e in elems[h+1..] when is_child_of(elem, hdr)
				console.log " #{hdr.tagName}"
		# 	hdr.innerHTML = "<a href='#'>+ #{hdr.innerHTML}</a>"


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

	is_child_of = (elem, hdr) ->
		hierarchy.indexOf elem.tagName < hierarchy.indexOf hdr.tagName



$(document).ready ->
	origami = new Origami(document.origami)