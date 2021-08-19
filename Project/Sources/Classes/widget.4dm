Class extends static

//═════════════════════════════════════════════════
Class constructor($name : Text; $datasource)
	
	Super:C1705($name)
	
	C_POINTER:C301($p)
	$p:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.name)
	This:C1470.assignable:=Not:C34(Is nil pointer:C315($p))
	
	If (This:C1470.assignable)
		
		This:C1470.pointer:=$p
		This:C1470.value:=$p->
		
	Else 
		
		If (Count parameters:C259>=2)
			
			This:C1470.dataSource:=$datasource
			
			If (Value type:C1509($datasource)=Is object:K8:27)
				
				// Formula
				This:C1470.value:=This:C1470.dataSource.call()
				
			Else 
				
				This:C1470.value:=Formula from string:C1601($datasource).call()
				
			End if 
		End if 
	End if 
	
	This:C1470.action:=OBJECT Get action:C1457(*; This:C1470.name)
	
	//________________________________________________________________
	// Update the widget pointer in case of form reload
Function updatePointer()->$p : Pointer
	
	$p:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.name)
	
	If (Not:C34(Is nil pointer:C315($p)))
		
		This:C1470.pointer:=$p
		
	End if 
	
	//________________________________________________________________
	// Return the pointer to the widget
Function pointer()->$p : Pointer
	
	$p:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.name)
	
/*═════════════════════════════════════════════════
sets the format for the widget
*/
Function setFormat($format : Text)->$this : cs:C1710.static
	
	OBJECT SET FORMAT:C236(*; This:C1470.name; $format)
	
	$this:=This:C1470
	
/*═════════════════════════════════════════════════
Attaches an image to the widget
	
   Possible values for proxy values are:
    • "#{folder/}picturename" or "file:{folder/}picturename" if the picture comes from a file stored in the Resources folder
    • variable name if the picture comes from a picture variable
    • number, preceded with a question mark (ex.: “?250”) if the picture comes from a picture library
*/
Function setPicture($proxy : Text)->$this : Object
	
	Case of 
			
			//______________________________________________________
		: (This:C1470.type=Object type 3D button:K79:17)
			
			This:C1470.setFormat(";"+$proxy)
			
			//______________________________________________________
		: (This:C1470.type=Object type picture button:K79:20)\
			 | (This:C1470.type=Object type picture popup menu:K79:15)
			
			This:C1470.setFormat(";;"+$proxy)
			
			//______________________________________________________
		: (This:C1470.type=Object type listbox header:K79:9)\
			 | (This:C1470.type=Object type static picture:K79:3)
			
			This:C1470.setFormat($proxy)
			
			//______________________________________________________
		Else 
			
			// #ERROR
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//________________________________________________________________
Function getCoordinates
	
	Super:C1706.getCoordinates()
	
	Case of 
			
			//…………………………………………………………………………………………………
		: (This:C1470.type=Object type picture input:K79:5)
			
			This:C1470.getScrollPosition()
			This:C1470.getDimensions()
			
			//…………………………………………………………………………………………………
		: (This:C1470.type=Object type listbox:K79:8)
			
			This:C1470.updateDefinition()
			This:C1470.getCell()
			
			//…………………………………………………………………………………………………
		: (This:C1470.type=Object type subform:K79:40)
			
			This:C1470.getSubform()
			
			//…………………………………………………………………………………………………
		Else 
			
			//ASSERT(False; "Non implemented for: "+String(This.type))
			
			//…………………………………………………………………………………………………
	End case 
	
/*══════════════════════════*/
Function getEnterable
	
	C_BOOLEAN:C305($0)
	
	$0:=OBJECT Get enterable:C1067(*; This:C1470.name)
	
/*══════════════════════════
.enterable()
.enterable(bool)
══════════════════════════*/
Function enterable
	
	C_BOOLEAN:C305($1)
	
	If (Count parameters:C259>=1)
		
		OBJECT SET ENTERABLE:C238(*; This:C1470.name; $1)
		
	Else 
		
		OBJECT SET ENTERABLE:C238(*; This:C1470.name; True:C214)
		
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*══════════════════════════
.notEnterable() --> This
══════════════════════════*/
Function notEnterable
	
	OBJECT SET ENTERABLE:C238(*; This:C1470.name; False:C215)
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*════════════════════════════════════════════════════
.getValue() -> value
*/
Function getValue()->$value
	
	$value:=OBJECT Get value:C1743(This:C1470.name)
	
/*════════════════════════════════════════════════════
.setValue(value) -> This
*/
Function setValue($value)->$this : cs:C1710.widget
	
	OBJECT SET VALUE:C1742(This:C1470.name; $value)
	
	$this:=This:C1470
	
/*══════════════════════════
.clear() -> This
══════════════════════════*/
Function clear
	
	If (This:C1470.assignable)
		
		CLEAR VARIABLE:C89((This:C1470.pointer)->)
		
	Else 
		
		If (This:C1470.dataSource#Null:C1517)
			
			C_LONGINT:C283($l)
			$l:=Value type:C1509(This:C1470.getValue())
			
			C_TEXT:C284($t)
			If (Value type:C1509(This:C1470.dataSource)=Is object:K8:27)
				
				$t:=This:C1470.dataSource.source
				
			Else 
				
				$t:=This:C1470.dataSource
				
			End if 
			
			Case of 
					
					//______________________________________________________
				: ($l=Is text:K8:3)
					
					EXECUTE FORMULA:C63($t+":=\"\"")
					
					//______________________________________________________
				: ($l=Is real:K8:4)\
					 | ($l=Is longint:K8:6)
					
					EXECUTE FORMULA:C63($t+":=0")
					
					//______________________________________________________
				: ($l=Is boolean:K8:9)
					
					EXECUTE FORMULA:C63($t+":=")
					
					//______________________________________________________
				: ($l=Is date:K8:7)
					
					EXECUTE FORMULA:C63($t+":=(\"\")")
					
					//______________________________________________________
				: ($l=Is time:K8:8)
					
					EXECUTE FORMULA:C63($t+":=(0)")
					
					//______________________________________________________
				: ($l=Is object:K8:27)
					
					EXECUTE FORMULA:C63($t+":=null")
					
					//______________________________________________________
				: ($l=Is collection:K8:32)
					
					EXECUTE FORMULA:C63($t+":=")
					
					//______________________________________________________
				: ($l=Is picture:K8:10)
					
					EXECUTE FORMULA:C63($t+":="+$t+"*0")
					
					//______________________________________________________
				Else 
					
					EXECUTE FORMULA:C63($t+":=null")
					
					//______________________________________________________
			End case 
		End if 
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*══════════════════════════
.touch() -> This
══════════════════════════*/
Function touch
	
	If (This:C1470.assignable)
		
		This:C1470.pointer->:=(This:C1470.pointer)->
		
	Else 
		
		If (This:C1470.dataSource=Null:C1517)
			
			If (Value type:C1509(OBJECT Get value:C1743(This:C1470.name))#Is undefined:K8:13)
				
				OBJECT SET VALUE:C1742(This:C1470.name; OBJECT Get value:C1743(This:C1470.name))
				
			End if 
			
		Else 
			
			// ⚠️ OBSOLETE: we don't need this trick anymore since "Object get/set value" is now available.
			C_TEXT:C284($t)
			$t:=Choose:C955(Value type:C1509(This:C1470.dataSource)=Is object:K8:27; This:C1470.dataSource.source; This:C1470.dataSource)
			
			EXECUTE FORMULA:C63($t+":="+$t)
			
		End if 
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*══════════════════════════
.on(e;callback) -> bool
══════════════════════════*/
Function on
	
	C_BOOLEAN:C305($0)
	C_VARIANT:C1683($1)
	C_OBJECT:C1216($2)
	
	If (Asserted:C1132(This:C1470.type#-1; "Does not apply to a group"))
		
		If (Count parameters:C259=0)
			
			$0:=(This:C1470.name=FORM Event:C1606.objectName)
			
		Else 
			
			If (Value type:C1509($1)=Is object:K8:27)
				
				If (Count parameters:C259>=2)
					
					$0:=(This:C1470.name=String:C10($1.objectName))\
						 & ($1.code=$2)
					
				Else 
					
					$0:=(This:C1470.name=String:C10($1.objectName))
					
				End if 
			Else 
				
				$0:=(This:C1470.name=String:C10($1))
				
			End if 
		End if 
		
		If ($0)
			
			$2.call()
			
		End if 
	End if 
	
/*══════════════════════════
.catch(e) -> bool
══════════════════════════*/
Function catch
	
	C_BOOLEAN:C305($0)
	C_VARIANT:C1683($1)
	C_LONGINT:C283($2)
	
	If (Asserted:C1132(This:C1470.type#-1; "Does not apply to a group"))
		
		If (Count parameters:C259=0)
			
			$0:=(This:C1470.name=FORM Event:C1606.objectName)
			
		Else 
			
			If (Value type:C1509($1)=Is object:K8:27)
				
				If (Count parameters:C259>=2)
					
					$0:=(This:C1470.name=String:C10($1.objectName))\
						 & ($1.code=$2)
					
				Else 
					
					$0:=(This:C1470.name=String:C10($1.objectName))
					
				End if 
			Else 
				
				$0:=(This:C1470.name=String:C10($1))
				
			End if 
		End if 
	End if 
	
	If ($0)
		
		If (This:C1470.callback#Null:C1517)
			
			This:C1470.callback()
			
		End if 
	End if 
	
/*══════════════════════════
.setCallback(formula) -> This
.setCallback(text) -> This
══════════════════════════*/
Function setCallback
	
	C_VARIANT:C1683($1)
	
	If (Value type:C1509($1)=Is object:K8:27)
		
		This:C1470.callback:=$1
		
	Else 
		
		This:C1470.callback:=Formula from string:C1601(String:C10($1))
		
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*══════════════════════════
.execute()
══════════════════════════*/
Function execute
	
	If (Asserted:C1132(This:C1470.callback#Null:C1517; "No callback method define"))
		
		This:C1470.callback()
		
	End if 
	
/*══════════════════════════
.getHelpTip() -> text
══════════════════════════*/
Function getHelpTip
	
	C_TEXT:C284($0)
	
	$0:=OBJECT Get help tip:C1182(*; This:C1470.name)
	
/*══════════════════════════
.setHelpTip(text) -> This
══════════════════════════*/
Function setHelpTip
	
	C_TEXT:C284($1)  // Text or resname
	C_TEXT:C284($t)
	
	If (Count parameters:C259>=1)
		
		$t:=Get localized string:C991($1)
		$t:=Choose:C955(Length:C16($t)>0; $t; $1)  // Revert if no localization
		
	End if 
	
	OBJECT SET HELP TIP:C1181(*; This:C1470.name; $t)
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*══════════════════════════
.getShortcut() -> object
  {"key";text;"modifier";int)
══════════════════════════*/
Function getShortcut
	
	C_OBJECT:C1216($0)
	C_TEXT:C284($t)
	C_LONGINT:C283($l)
	
	OBJECT GET SHORTCUT:C1186(*; This:C1470.name; $t; $l)
	
	$0:=New object:C1471(\
		"key"; $t; \
		"modifier"; $l)
	
/*══════════════════════════
.setShortcut(text{;int} ) -> This
══════════════════════════*/
Function setShortcut
	
	C_TEXT:C284($1)  // key
	C_LONGINT:C283($2)  // modifier
	
	If (Count parameters:C259>=2)
		
		OBJECT SET SHORTCUT:C1185(*; This:C1470.name; $1; $2)
		
	Else 
		
		OBJECT SET SHORTCUT:C1185(*; This:C1470.name; $1)
		
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*══════════════════════════
.focus() -> This
══════════════════════════*/
Function focus
	
	GOTO OBJECT:C206(*; This:C1470.name)
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
	