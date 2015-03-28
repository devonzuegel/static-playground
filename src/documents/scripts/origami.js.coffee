	
class Origami
	hierarchy = []

	## public::constructor()
	 #		Initialize Origami object.
	 # Params
	 #  	optns {object}: Defines options for Origami.
	constructor: (optns) ->
		hierarchy = (optns.hierarchy).reverse() if is_defined(optns.hierarchy)
		elems = $.makeArray(optns.fold_here.siblings())

		for header, h in elems when header.tagName in hierarchy
			do (header, h) ->   # Closure on `hdr` and `h`.
				make_elem_header(header, h, optns)
				children = get_children(elems, header, h)
				$(children).wrapAll("<div id='fold-me-#{h}'></div>")

				$hdr = $("#fold-hdr-#{h}")
				$div = $("#fold-me-#{h}")
				$btn = $("#origami-btn-#{h}")[0]

				##
				# Define sliding collapse/open and changing button
				# behavior on header click.
				$hdr.click ->
					$div.slideToggle()
					open = optns.btn_symbols.open
					closed = optns.btn_symbols.closed
					console.log "#{$btn.innerText}==#{open} = #{$btn.innerText==open}"
					$btn.innerText = if $btn.innerText==open then closed else open


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

	make_elem_header = (header, h, optns) ->
		# Update header.
		$(header).css('cursor', 'pointer')
		header.id = "fold-hdr-#{h}"
		header.innerHTML = "
			<span id='origami-btn-#{h}'
						class='origami-btn'>#{optns.btn_symbols.open}</span>
			#{header.innerHTML}
			"

	get_children = (elems, header, h) ->
		# Find all children to be folded under `hdr`.
		children = []
		for e in elems[h+1..]
			if not is_child_of(e, header) then break
			children.push e
		children


# $(document).ready ->

$ ->

	## Default options can be overidden by `document.origami`.
	optns = {
		fold_here: $('#origami')
		hierarchy: ["H1", "H2", "H3", "H4", "H5", "H6"]
		btn_symbols:
			open: 	'+'
			closed: '-'
		start_closed: [] # No headers start folded.
		header_klass: undefined
		button_klass: undefined
	}

	# Override default options with user-provided options.
	$.extend(optns, document.origami)

	# Only proceed if an `#origami` element is defined. 
	if $(optns.fold_here) then origami = new Origami(optns)


