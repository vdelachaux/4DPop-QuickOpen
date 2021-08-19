//%attributes = {"invisible":true}
var $caught : Boolean
ARRAY TEXT:C222($componentsArray; 0)

COMPONENT LIST:C1001($componentsArray)

If (Find in array:C230($componentsArray; "4DPop QuickOpen")>0)
	
	If (MODIFIERS ?? Option key bit:K16:8)  // ⌥
		
		If (KEYCODE=202)  // Space
			
			var $t : Text
			var $i : Integer
			PROCESS PROPERTIES:C336(Frontmost process:C327(*); $t; $i; $i; $i; $i; $i)
			
			$caught:=($i=Design process:K36:9)
			
		End if 
	End if 
End if 

If ($caught)
	
	FILTER EVENT:C321  // 💪 Let it go, I'll take care of it for you.
	EXECUTE METHOD:C1007("QUICK_OPEN")
	
Else 
	
	// <THE DATABASE EVENT HANDLER CODE, IF ANY>
	
End if 