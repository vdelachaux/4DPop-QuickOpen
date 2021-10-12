//%attributes = {"invisible":true}
#DECLARE($action : Object)

If (False:C215)
	C_OBJECT:C1216(quickAction_FORM; $1)
End if 

var $formName : Text

$formName:=String:C10($action.form)

If ($formName="@.4DForm")
	
	$action.file:=Folder:C1567(fk resources folder:K87:11; *).file("quickOpen/"+$formName)
	
Else 
	
	$action.file:=Folder:C1567(fk resources folder:K87:11; *).folder("quickOpen/"+$formName).file("form.4DForm")
	
End if 

cs:C1710.menu.new().defaultMinimalMenuBar().setBar()

If ($action.file.exists)
	
	$action.window:=Open form window:C675(String:C10($action.file.path); Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	DIALOG:C40($action.file.path; $action)
	CLOSE WINDOW:C154($action.window)
	
Else 
	
	ALERT:C41(Replace string:C233(Get localized string:C991("formNotFound"); "{name}"; $action.file.parent.platformPath))
	
End if 