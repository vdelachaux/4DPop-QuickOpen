//%attributes = {"invisible":true,"shared":true}
// Allows the host database or a component to push its own actions.
#DECLARE($action : Object)

If (False:C215)
	C_OBJECT:C1216(quickOpenPushAction; $1)
End if 

var $icon : Picture

If (Storage:C1525.actions=Null:C1517)
	
	Use (Storage:C1525)
		
		Storage:C1525.actions:=New shared collection:C1527
		
	End use 
End if 

If (Storage:C1525.actions.query("name = :1"; $action.name).pop()=Null:C1517)
	
	Use (Storage:C1525.actions)
		
		READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_604.png").platformPath; $icon)
		
		$action:=OB Copy:C1225($action; ck shared:K85:29)
		
		Use ($action)
			
			$action.type:=-1
			$action.icon:=$icon
			$action.desc:=Choose:C955($action.desc=Null:C1517; $action.name; $action.desc)
			
			$action.folder:="_"
			$action.doc:=""
			$action.attributes:=Null:C1517
			
		End use 
		
		Storage:C1525.actions.push($action)
		
	End use 
	
Else   // ACTION ALREADY EXISTS
	
End if 