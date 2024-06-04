//%attributes = {"invisible":true}
#DECLARE($action)

cs:C1710.menuBar.new().defaultMinimalMenuBar().set()

Case of 
		
		//======================================
	: (Value type:C1509($action.formula)=Is object:K8:27)
		
		$action.formula.call()
		
		//======================================
	: (Value type:C1509($action.formula)=Is text:K8:3)
		
		Formula from string:C1601($action.formula).call()
		
		//======================================
End case 