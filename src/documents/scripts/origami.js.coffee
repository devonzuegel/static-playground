	
class Origami
	hierarchy = []

	## public::constructor()
	 #		Initialize Origami object.
	 # Params
	 #  	to_fold {array}: List of header types to fold.
	constructor: (to_fold) ->
		hierarchy = (to_fold).reverse() if is_defined(to_fold)
		console.log hierarchy
		fold_here = $('#origami') || $('body')
		elems = $.makeArray(fold_here.siblings())

		for hdr, h in elems when hdr.tagName in hierarchy
			# Create closure on `hdr` and `h`.
			do (hdr, h) ->
				# Update header.
				hdr.id = "fold-hdr-#{h}"
				hdr.innerHTML = "<a style='cursor:pointer'>+ #{hdr.innerHTML}</a>"

				# Find all children to be folded under `hdr`.
				children = []
				for e in elems[h+1..]
					if not is_child_of(e, hdr) then break
					children.push e
				
				# Wrap children in `fold-me-#` div.
				$(children).wrapAll("<div id='fold-me-#{h}'></div>")

				# Define sliding collapse/open behavior on header click.
				$("#fold-hdr-#{h}").click -> $("#fold-me-#{h}").slideToggle()


	##### Private ###############################################

	## private::is_defined()
	 #		Normalize `to_fold` array.
	 # Params
	 #  	to_fold {array}: List of header types to fold.
	 # Return value
	 #		true:  if a defined array that doesn't only contain "".
	 #		false: otherwise
	is_defined = (to_fold) ->
		(to_fold) and (JSON.stringify(to_fold) != '[""]')


	## private::is_child_of()
	 #		Determine whether elem is child of hdr.
	 # Params
	 #		elem {html}: to check if lower than hdr in hierarchy.
	 #		hdr {html}:  current header under consideration
	 # Return value
	 #		true:  if elem is child of hdr.
	 #		false: otherwise
	is_child_of = (elem, hdr) ->
		i_e = hierarchy.indexOf elem.tagName
		i_h = hierarchy.indexOf hdr.tagName
		return i_e < i_h


$(document).ready ->
	origami = new Origami(document.origami)