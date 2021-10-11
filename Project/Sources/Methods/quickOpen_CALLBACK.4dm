//%attributes = {"invisible":true}
// Call back from quickOpen_WORKER when the list refresh is finished.
#DECLARE($design : cs:C1710.design)

COMPILER_quickOpen

design:=$design

design.sources.combine(Form:C1466.quickOpen.commands)

If (Storage:C1525.actions#Null:C1517)
	
	design.sources.combine(Storage:C1525.actions)
	
End if 

design.sources:=design.sources.orderBy("type asc name asc")  //.orderBy("folder asc, name asc, type asc")
Form:C1466.list:=design.sources

// Update UI
Form:C1466.weWork.hide().stop()

// Restart the search in case
Form:C1466.quickOpen.search()