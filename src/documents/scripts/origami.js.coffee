	
class Origami

	## public::constructor()
	 #		Initialize Origami object
	 # Params
	 #  	to_fold {array}: List of header types to fold
	 # Return value
	 #		true:  if a defined array that doesn't only contain ""
	 #		false: otherwise
	constructor: (to_fold) ->
		@to_fold = if is_defined(to_fold) then to_fold else []
		console.log @to_fold


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