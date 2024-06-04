//%attributes = {"invisible":true}
// Open the QUICK_OPEN dialog in its own process & launch the quickOpen_WORKER
var $t : Text
var $form; $signal : Object

If (Count parameters:C259=0)
	
	$t:=Current method name:C684
	BRING TO FRONT:C326(New process:C317($t; 0; "$"+$t; $t; *))
	
Else 
	
	COMPILER_quickOpen
	
	$form:={\
		search: ""; \
		list: []; \
		result: []; \
		current: Null:C1517; \
		index: 0; \
		isMaximized: False:C215; \
		quickOpen: cs:C1710._quickOpen.new()}
	
	$signal:=New signal:C1641("quickOpen")
	
	Use ($signal)
		
		$signal.window:=Open form window:C675("QUICK_OPEN"; Pop up form window:K39:11+(Is macOS:C1572 ? 0x8000 : 0x0000); Horizontally centered:K39:1; Menu bar height:C440+Tool bar height:C1016+40)
		
	End use 
	
	CALL WORKER:C1389(1; "quickOpen_WORKER"; $signal)
	$signal.wait()
	
	DIALOG:C40("QUICK_OPEN"; $form)
	CLOSE WINDOW:C154($signal.window)
	
End if 