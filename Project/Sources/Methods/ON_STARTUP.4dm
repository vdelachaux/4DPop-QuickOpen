//%attributes = {"invisible":true}
If (Not:C34(Is compiled mode:C492(*)))
	
	// Installing quickOpen
	quickOpenInit(Formula:C1597(MODIFIERS); Formula:C1597(KEYCODE))
	ON EVENT CALL:C190("quickOpenEventHandler"; "$quickOpenListener")
	
End if 