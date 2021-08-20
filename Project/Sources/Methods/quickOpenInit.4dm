//%attributes = {"invisible":true,"shared":true}
#DECLARE(\
$mod : 4D:C1709.Function; \
$key : 4D:C1709.Function; \
$shortcutModifier : Integer; \
$shortcutKey : Integer)

Use (Storage:C1525)
	
	// Keep access to the host database variables
	Storage:C1525.MODIFIERS:=$mod
	Storage:C1525.KEYCODE:=$key
	
	Storage:C1525.shortcut:=New shared object:C1526
	
	Use (Storage:C1525.shortcut)
		
		// Default shortcut is ⌥ + Space
		Storage:C1525.shortcut.modifiers:=Option key bit:K16:8
		Storage:C1525.shortcut.keycode:=202
		
		If (Count parameters:C259>=3)
			
			Storage:C1525.shortcut.modifiers:=$shortcutModifier
			
			If (Count parameters:C259>=4)
				
				Storage:C1525.shortcut.keycode:=$shortcutKey
				
			End if 
		End if 
	End use 
End use 