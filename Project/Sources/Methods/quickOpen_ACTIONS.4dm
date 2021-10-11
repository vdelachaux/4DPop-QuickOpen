//%attributes = {"invisible":true}
#DECLARE($action : Object)

If (False:C215)
	C_OBJECT:C1216(quickOpen_ACTIONS; $1)
End if 


Case of 
		
		//______________________________________________________
	: ($action.form#Null:C1517)
		
		var $process : Integer
		$process:=New process:C317("quickOpen_FORM"; 0; "$quickOpen"; OB Copy:C1225($action))
		
		//______________________________________________________
	: ($action.formula#Null:C1517)
		
		Case of 
				
				//======================================
			: (Value type:C1509($action.formula)=Is object:K8:27)
				
				$action.formula.call()
				
				//======================================
			: (Value type:C1509($action.formula)=Is text:K8:3)
				
				Formula from string:C1601($action.formula).call()
				
				//======================================
		End case 
		
		//______________________________________________________
	: ($action.action="userSettings")
		
		var $t : Text
		$t:=Method called on error:C704
		
		//====================== [
		ON ERR CALL:C155("noError")
		
		ERROR:=0
		
		OPEN SETTINGS WINDOW:C903("/"; False:C215; User settings:K5:27)
		
		ON ERR CALL:C155($t)
		
		//====================== ]
		
		If (ERROR=-10531)
			
			ALERT:C41("User database settings haven't been enabled.")
			
		End if 
		
		//______________________________________________________
	: ($action.action="checkSyntax")
		
		var $o : Object
		$o:=Folder:C1567(fk database folder:K87:14; *).folder("Project").files().query("extension = .4dProject").pop()
		
		If ($o.exists)
			
			$o:=Compile project:C1760($o; New object:C1471)
			
			If ($o.success)
				
				ALERT:C41("Syntax check successful")
				
			Else 
				
				ALERT:C41("⛔️ SYNTAX CHECK FAILED!")
				
			End if 
		End if 
		
		//______________________________________________________
	: ($action.action="compile")
		
		var $o : Object
		$o:=Folder:C1567(fk database folder:K87:14; *).folder("Project").files().query("extension = .4dProject").pop()
		
		If ($o.exists)
			
			$o:=Compile project:C1760($o)
			
			If ($o.success)
				
				ALERT:C41("Compilation successful")
				
			Else 
				
				ALERT:C41("⛔️ COMPILATION FAILED!")
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 