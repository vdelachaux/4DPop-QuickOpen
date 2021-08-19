//%attributes = {"invisible":true}
// The method for catching events
#DECLARE()->$caught : Boolean  // True if the event is catched

If (MODIFIERS ?? Option key bit:K16:8)  // ⌥
	
	If (KEYCODE=202)  // Space
		
		var $t : Text
		var $i : Integer
		PROCESS PROPERTIES:C336(Frontmost process:C327(*); $t; $i; $i; $i; $i; $i)
		
		If ($i=Design process:K36:9)
			
			$caught:=True:C214  // 💪 Let it go, I'll take care of it for you.
			FILTER EVENT:C321
			
			QUICK_OPEN
			
		End if 
	End if 
End if 