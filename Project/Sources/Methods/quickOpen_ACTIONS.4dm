//%attributes = {"invisible":true}
#DECLARE($action : Object)

var $process : Integer

Case of 
		
		//______________________________________________________
	: ($action.formula#Null:C1517)
		
		If (Bool:C1537($action.modal))
			
			quickAction_FORMULA(OB Copy:C1225($action))
			
		Else 
			
			$process:=New process:C317("quickAction_FORMULA"; 0; "$quickOpen"; OB Copy:C1225($action))
			
		End if 
		
		//______________________________________________________
	: ($action.form#Null:C1517)
		
		$process:=New process:C317("quickAction_FORM"; 0; "$quickOpen"; OB Copy:C1225($action))
		
		//______________________________________________________
	: ($action.action="userSettings")
		
		Try(OPEN SETTINGS WINDOW:C903("/"; False:C215; User settings:K5:27))
		
		If (Last errors:C1799.length>0)\
			 && (Last errors:C1799[0].errCode=-10531)
			
			ALERT:C41(Get localized string:C991("theUserSettingsOfTheDatabaseHaveNotBeenActivated"))
			
		End if 
		
		//______________________________________________________
	: ($action.action="checkSyntax")\
		 | ($action.action="compile")
		
		$process:=New process:C317("quickAction_COMPILE"; 0; "$quickOpen"; {checkSyntax: $action.action="checkSyntax"})
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 