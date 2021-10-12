//%attributes = {"invisible":true}
#DECLARE($action : Variant)

If (False:C215)
	C_VARIANT:C1683(quickAction_FORMULA; $1)
End if 

cs:C1710.menu.new().defaultMinimalMenuBar().setBar()

Case of 
		
		//======================================
	: (Value type:C1509($action.formula)=Is object:K8:27)
		
		$action.formula.call()
		
		//======================================
	: (Value type:C1509($action.formula)=Is text:K8:3)
		
		Formula from string:C1601($action.formula).call()
		
		//======================================
End case 