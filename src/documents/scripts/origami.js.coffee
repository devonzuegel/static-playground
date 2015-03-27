	
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
		hierarchy = (to_fold).reverse() if is_defined(to_fold)
		console.log hierarchy
		fold_here = $('#origami') || $('body')
		elems = $.makeArray(fold_here.siblings())

		for hdr, h in elems when hdr.tagName in hierarchy
			do (hdr) ->
				do (h) ->
					# Update header.
					hdr.id = "fold-hdr-#{h}"
					hdr.innerHTML = "<a>+ #{hdr.innerHTML}</a>"

					# Wrap children in `fold-me-#` div.
					children = [] #(e for e in elems[h+1..] when is_child_of(e, hdr))
					for e in elems[h+1..]
						i_e = hierarchy.indexOf e.tagName
						i_h = hierarchy.indexOf hdr.tagName
						if i_e < i_h
							# if is_child_of(e, hdr)
							children.push e
						else
							break
					
					console.log children
					$(children).wrapAll("<div id='fold-me-#{h}'></div>")

					$("#fold-hdr-#{h}").click ->
						$("#fold-me-#{h}").slideToggle()

					# console.log ''
					# console.log hdr
					# console.log children

	##### Private ###############################################

	## private::is_defined()
	 #		Normalize `to_fold` array
	 # Params
	 #  	to_fold {array}: List of header types to fold
	 # Return value
	 #		true:  if a defined array that doesn't only contain ""
	 #		false: otherwise
	is_defined = (to_fold) ->
		(to_fold) and (JSON.stringify(to_fold) != '[""]')

	is_child_of = (el, hdr) ->
		console.log ''
		# console.log "#{el.tagName} #{hierarchy.indexOf el.tagName}"
		# console.log "#{hdr.tagName} #{hierarchy.indexOf hdr.tagName}"
		res = (hierarchy.indexOf el.tagName - hierarchy.indexOf hdr.tagName)
		# console.log res
		# console.log hierarchy.indexOf el.tagName - hierarchy.indexOf hdr.tagName
		return res



$(document).ready ->
	origami = new Origami(document.origami)