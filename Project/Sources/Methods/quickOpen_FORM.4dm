//%attributes = {"invisible":true}
#DECLARE($action : Object)

If (False:C215)
	C_OBJECT:C1216(quickOpen_FORM; $1)
End if 

$action.file:=Folder:C1567(fk resources folder:K87:11; *).folder("quickOpen/"+$action.form).file("form.4DForm")

If ($action.file.exists)
	
	cs:C1710.menu.new().defaultMinimalMenuBar().setBar()
	
	$action.window:=Open form window:C675(String:C10($action.file.path); Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	DIALOG:C40($action.file.path; $action)
	CLOSE WINDOW:C154($action.window)
	
End if 