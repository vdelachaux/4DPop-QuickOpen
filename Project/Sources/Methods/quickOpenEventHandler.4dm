//%attributes = {"invisible":true,"shared":true}
// The method for catching events
#DECLARE() : Boolean

If (Not:C34(Shift down:C543))\
 && (Storage:C1525.MODIFIERS#Null:C1517)\
 && (Storage:C1525.MODIFIERS.call() ?? Storage:C1525.shortcut.modifiers)\
 && (Storage:C1525.KEYCODE.call()=Storage:C1525.shortcut.keycode)
	
	If (Process info:C1843(Frontmost process:C327(*)).type=Design process:K36:9)
		
		// 💪 Let it go, I'll take care of it
		FILTER EVENT:C321
		QUICK_OPEN
		
		return True:C214
		
	End if 
End if 