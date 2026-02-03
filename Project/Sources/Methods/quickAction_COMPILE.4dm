//%attributes = {"invisible":true}
#DECLARE($options : Object)

var $context:=Localized string:C991(Bool:C1537($options.checkSyntax) ? "syntaxCheck" : "compilation")

//$progress:=Progress New
//Progress SET TITLE($progress; $context; -1; ""; True)

ARRAY TEXT:C222($names; 0x0000)
var $components:=[]

COMPONENT LIST:C1001($names)
ARRAY TO COLLECTION:C1563($components; $names)

var $compiler:={components: $components}

If (Bool:C1537($options.checkSyntax))
	
	$compiler.targets:=[]
	
End if 

//MARK: TODO - Find a way to force everything to be saved before compiling

$compiler:=Compile project:C1760($compiler)

If ($compiler.success)
	
	//Progress SET MESSAGE($progress; $context+" "+Get localized string("isSuccessful"); True)
	//DELAY PROCESS(Current process; 60)
	//Progress QUIT($progress)
	
Else 
	
	//Progress QUIT($progress)
	
	BEEP:C151
	
	// Only show errors
	$compiler.errors:=$compiler.errors.query("isError = true")
	
	var $error : Object
	For each ($error; $compiler.errors)
		
		Case of 
				//______________________________________________________
			: ($error.code.type="projectMethod")
				
				$error.method:=$error.code.methodName
				
				//______________________________________________________
			: ($error.code.type="classFunction")
				
				$error.method:=$error.code.className+":"+(Length:C16($error.code.functionName)>0 ? $error.code.functionName : "constructor")
				
				//______________________________________________________
			: ($error.code.type="databaseMethod")
				
				var $t:=Replace string:C233($error.code.path; "[databaseMethod]/"; "")
				$t[[1]]:=Uppercase:C13($t[[1]])
				$error.method:=_4D Get 4D App localized string:C1578("DatabaseMethodName_"+$t)
				
				//______________________________________________________
			Else 
				
				$error.method:="???"
				
				//______________________________________________________
		End case 
	End for each 
	
	cs:C1710.ui.menuBar.new().defaultMinimalMenuBar().set()
	
	$compiler.window:=Open form window:C675("COMPILER"; Plain form window:K39:10; Horizontally centered:K39:1; At the bottom:K39:6; *)
	SET WINDOW TITLE:C213($context+" result")
	DIALOG:C40("COMPILER"; $compiler)
	CLOSE WINDOW:C154($compiler.window)
	
End if 