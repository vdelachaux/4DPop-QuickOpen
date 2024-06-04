//%attributes = {"invisible":true,"shared":true}
// Allows the host database or a component to push its own actions.
#DECLARE($action : Object)

var $key : Text
var $icon : Picture
var $o : Object

If (Storage:C1525.actions=Null:C1517)
	
	Use (Storage:C1525)
		
		Storage:C1525.actions:=New shared collection:C1527
		
	End use 
End if 

$o:=Storage:C1525.actions.query("name = :1"; $action.name).pop()

Use (Storage:C1525.actions)
	
	If ($o=Null:C1517)  // *CREATE
		
		$action:=OB Copy:C1225($action; ck shared:K85:29)
		
		Use ($action)
			
			$action.type:=-1
			$action.desc:="action"
			$action.comment:="embedded action"
			$action.folder:="_"
			
			If ($action.icon=Null:C1517)
				
				READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_606.png").platformPath; $icon)
				
			Else 
				
				CREATE THUMBNAIL:C679($action.icon; $icon; 16; 16)
				
			End if 
			
			$action.icon:=$icon
			
			Storage:C1525.actions.push($action)
			
		End use 
		
	Else   // *UPDATE
		
		For each ($key; $action)
			
			Case of 
					
					//______________________________________________________
				: ($key="icon")
					
					CREATE THUMBNAIL:C679($action.icon; $icon; 16; 16)
					$o.icon:=$icon
					
					//______________________________________________________
				Else 
					
					$o[$key]:=$action[$key]
					
					//______________________________________________________
			End case 
			
		End for each 
	End if 
End use 