//%attributes = {"invisible":true,"shared":true}
// The method for catching events
#DECLARE() : Boolean

If (Storage:C1525.MODIFIERS#Null:C1517)\
 && (Storage:C1525.MODIFIERS.call() ?? Storage:C1525.shortcut.modifiers)\
 && (Storage:C1525.KEYCODE.call()=Storage:C1525.shortcut.keycode)
	
	var $t : Text
	var $i : Integer
	PROCESS PROPERTIES:C336(Frontmost process:C327(*); $t; $i; $i; $i; $i; $i)
	
	If ($i=Design process:K36:9)
		
		// 💪 Let it go, I'll take care of it
		FILTER EVENT:C321
		QUICK_OPEN
		
		return True:C214
		
	End if 
End if 