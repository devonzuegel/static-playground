	
class Origami
	hierarchy = []

	## public::constructor()
	 #		Initialize Origami object.
	 # Params
	 #  	optns {object}: Defines options for Origami.
	constructor: (optns) ->
		hierarchy = (optns.hierarchy).reverse() if is_defined(optns.hierarchy)
		elems = $.makeArray($('#origami').children())

		for hdr, h in elems when hdr.tagName in optns.fold
			do (hdr, h) ->   # Closure on `hdr` and `h`.
				make_elem_header(hdr, h, optns)
				children = get_children(elems, hdr, h)
				$(children).wrapAll("<div id='fold-me-#{h}'></div>")

				$hdr = $("#fold-hdr-#{h}")
				$div = $("#fold-me-#{h}")
				$btn = $("#origami-btn-#{h}")[0]

				##
				 # Define sliding collapse/open and changing button
				 # behavior on hdr click.
				$hdr.click -> open_close($hdr, $div, $btn, optns)

				##
				 # If hdr is defined as one of the levels to begin
				 # closed, then close it.
				if hdr.tagName in optns.start_closed
					open_close($hdr, $div, $btn, optns)

		##
		 # Once everything's done, display `#origami` (and its
		 # foldable children).
		$('#origami').show()


	##### Private ###############################################

	## private::is_defined()
	 #		Normalize `hierarchy` array.
	 # Params
	 #  	hierarchy {array}: List of header types to fold.
	 # Return value
	 #		true:  if a defined array that doesn't only contain "".
	 #		false: otherwise
	is_defined = (hierarchy) ->
		(hierarchy) and (JSON.stringify(hierarchy) != '[""]')


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

	## private::make_elem_header()
	 #		Add btn to header, make clickable.
	 # Params
	 #		header {html}: header html object
	 #		h {int}:			 header id number
	 # 		optns {obj}:	 hash of user-defined optns
	 # Returns
	 # 		Side-effects only.
	make_elem_header = (header, h, optns) ->
		$(header).css('cursor', 'pointer')
		$(header).addClass(optns.hdr_klass.open)
		header.id = "fold-hdr-#{h}"
		header.innerHTML = "
			<span class='origami-btn #{optns.btn_klass.open}'
						id='origami-btn-#{h}'>#{optns.btn_symbols.open}</span>
			#{header.innerHTML}
			"

	## private::get_children()
	 # 		Gets sub-headers under given header.
	 # Params
	 #		elems {[html]}:	siblings of header, array of html objs
	 #		header {html}:	header html object
	 #		h {int}:				header id number
	 # Returns
	 # 		Side-effects only.
	get_children = (elems, header, h) ->
		# Find all children to be folded under `hdr`.
		children = []
		for e in elems[h+1..]
			if not is_child_of(e, header) then break
			children.push e
		children

	## private::open_close()
	 #		Close the given sub-headers in $div.
	 # Params
	 #		$div {jquery}: contains sub-headers to be folded
	 #		$btn {jquery}: button whose buttons have to be updated
	 # 		optns {obj}:	 hash of user-defined optns
	 # Returns
	 # 		Side-effects only.
	open_close = ($hdr, $div, $btn, optns) ->
		# Fold sub-headers.
		$div.slideToggle(optns.duration)
		$($btn).toggleClass("#{optns.btn_klass.open} 
												 #{optns.btn_klass.closed}")

		# Update button.
		open = optns.btn_symbols.open
		closed = optns.btn_symbols.closed
		$btn.innerText = if $btn.innerText==open then closed else open
		$hdr.toggleClass("#{optns.hdr_klass.open} 
										  #{optns.hdr_klass.closed}")




## Default options can be overidden by `document.origami`.
optns = {
	hierarchy: ['H1', 'H2', 'H3', 'H4', 'H5', 'H6']
	fold:	 		 ['H1', 'H2', 'H3', 'H4', 'H5', 'H6']
	btn_symbols:
		open: 	'+'
		closed: '-'
	start_closed: []  # No headers start folded.
	hdr_klass:  			# No default classes defined for header.
		open: ''
		closed: ''
	btn_klass: 		 		# No default classes defined for button.
		open: ''
		closed: ''
	duration: 200  	 	# Milliseconds.
}

$(document).ready ->

	# Override default options with user-provided options.
	$.extend(optns, document.origami)

	# Only proceed if an `#origami` element is defined. 
	if $('#origami') then origami = new Origami(optns)


