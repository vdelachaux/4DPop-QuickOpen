//%attributes = {"invisible":true}
#DECLARE($action : Object)

If (False:C215)
	C_OBJECT:C1216(quickOpen_ACTIONS; $1)
End if 

var $t : Text
var $process : Integer
var $o : Object

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
		
		$t:=Method called on error:C704
		
		//====================== [
		ON ERR CALL:C155("noError")
		
		ERROR:=0
		
		OPEN SETTINGS WINDOW:C903("/"; False:C215; User settings:K5:27)
		
		ON ERR CALL:C155($t)
		
		//====================== ]
		
		If (ERROR=-10531)
			
			ALERT:C41(Get localized string:C991("theUserSettingsOfTheDatabaseHaveNotBeenActivated"))
			
		End if 
		
		//______________________________________________________
	: ($action.action="checkSyntax")\
		 | ($action.action="compile")
		
		$o:=New object:C1471
		$o.checkSyntax:=$action.action="checkSyntax"
		$process:=New process:C317("quickAction_COMPILE"; 0; "$quickOpen"; $o)
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 