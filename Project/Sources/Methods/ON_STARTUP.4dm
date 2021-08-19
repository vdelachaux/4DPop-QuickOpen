//%attributes = {"invisible":true}
If (Not:C34(Is compiled mode:C492(*)))
	
	// Launch of quickOpen
	ON EVENT CALL:C190("quickOpen_Event_handler"; "$quickOpenListener")
	
End if 