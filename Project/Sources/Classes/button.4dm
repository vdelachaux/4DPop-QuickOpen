Class extends widget

//═════════════════════════════════════════════════
Class constructor($name : Text; $datasource)
	
	If (Count parameters:C259>=2)
		
		Super:C1705($name; $datasource)
		
	Else 
		
		Super:C1705($name)
		
	End if 
	
/*═════════════════════════════════════════════════
Tryes to underline the first capital letter or, 
if not found the first letter, corresponding to 
the associated key shortcut
*/
Function highlightShortcut()->$this : Object
	
	C_LONGINT:C283($index; $lModifier)
	C_TEXT:C284($key; $t)
	
	OBJECT GET SHORTCUT:C1186(*; This:C1470.name; $key; $lModifier)
	
	If (Length:C16($key)>0)
		
		$t:=This:C1470.getTitle()
		
		$index:=Position:C15(Uppercase:C13($key); $t; *)
		
		If ($index=0)
			
			$index:=Position:C15($key; $t)
			
		End if 
		
		If ($index>0)
			
			This:C1470.setTitle(Substring:C12($t; 1; $index)+Char:C90(0x0332)+Substring:C12($t; $index+1))
			
		End if 
	End if 
	
	$this:=This:C1470
	
/*═════════════════════════════════════════════════
Association of a pop-up menu with a 3D button
	
If no parameter, the pop menu is removed, if any, 
else, possible values are:
	
   • 0 or "none": No pop-up menu
   • 1 or "linked": With linked pop-up menu
   • 2 or "separate": With separate pop-up menu
*/
Function setPopupMenu($value : Variant)->$this : Object
	
	If (This:C1470.type=Object type 3D button:K79:17)
		
		If (Count parameters:C259>=1)
			
			If (Value type:C1509($value)=Is text:K8:3)
				
				Case of 
						//______________________________________________________
					: ($value="none")
						
						This:C1470.setFormat(";;;;;;;;;;0")
						
						//______________________________________________________
					: ($value="linked")
						
						This:C1470.setFormat(";;;;;;;;;;1")
						
						//______________________________________________________
					: ($value="separate")
						
						This:C1470.setFormat(";;;;;;;;;;2")
						
						
						//______________________________________________________
					Else 
						
						// #ERROR
						
						//______________________________________________________
				End case 
				
			Else 
				
				This:C1470.setFormat(";;;;;;;;;;"+String:C10(Num:C11($value)))
				
			End if 
			
		Else 
			
			This:C1470.setFormat(";;;;;;;;;;0")
			
		End if 
		
	Else 
		
		// #ERROR
		
	End if 
	
	$this:=This:C1470
	
/*═════════════════════════════════════════════════
A hack to force a button to be boolean type
	
⚠️ Obsolete in project mode because you can 
   choose the type for the checkboxes
*/
Function asBoolean->$this : Object
	
	If (This:C1470.type=Object type checkbox:K79:26)
		If (This:C1470.assignable)
			
			EXECUTE FORMULA:C63(":C305((:C1124(:K67:5;This.name))->)")
			
		End if 
	End if 
	
	$this:=This:C1470