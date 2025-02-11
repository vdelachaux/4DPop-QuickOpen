//%attributes = {"invisible":true}
/* 
Instantiate the "design" class if needed,
and create/update the list of sources if any
*/

#DECLARE($signal : Object)

var design : cs:C1710.design


If (design=Null:C1517)\
 | (Structure file:C489=Structure file:C489(*))  // In development mode, always instantiate a new class
	
	design:=cs:C1710.design.new()
	
End if 

design.getSources()

// Let the dialog be displayed
$signal.trigger()

// Notify the dialog that the list is ready
CALL FORM:C1391($signal.window; "quickOpen_CALLBACK"; design)