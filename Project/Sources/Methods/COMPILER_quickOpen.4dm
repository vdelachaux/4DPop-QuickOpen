//%attributes = {"invisible":true}
var design : cs:C1710.design

If (False:C215)  // * SHARED
	
	//______________________________________________________
	C_OBJECT:C1216(quickOpenInit; $1)
	C_OBJECT:C1216(quickOpenInit; $2)
	C_LONGINT:C283(quickOpenInit; $3)
	
	//______________________________________________________
	C_BOOLEAN:C305(quickOpenEventHandler; $0)
	C_LONGINT:C283(quickOpenInit; $4)
	
	//______________________________________________________
	C_VARIANT:C1683(QUICK_OPEN; $1)
	
	//______________________________________________________
End if 

If (False:C215)  // * PRIVATE
	
	//______________________________________________________
	C_OBJECT:C1216(quickOpen_CALLBACK; $1)
	
	//______________________________________________________
	C_OBJECT:C1216(quickOpen_WORKER; $1)
	
	//______________________________________________________
	C_OBJECT:C1216(quickOpen_DO_EXTRAS; $1)
	
	//______________________________________________________
End if 