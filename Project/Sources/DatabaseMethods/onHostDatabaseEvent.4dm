#DECLARE($eventCode : Integer)

Case of 
		
		//______________________________________________________
	: (Is compiled mode:C492(*))
		
		// <NOTHING MORE TO DO>
		
		//______________________________________________________
	: (Not:C34(Bool:C1537(Get database parameter:C643(Is host database a project:K37:99))))
		
		// <NOTHING MORE TO DO>
		
		//______________________________________________________
	: ($eventCode=On before host database startup:K74:3)
		
/*
The host database has just been started, its On Startup method has not been called yet
and will not be called until the execution of this method is finished.
		
So, if the On Startup method does not exist, we can create it.
		
*/
		ARRAY TEXT:C222($arrPaths; 0x0000)
		METHOD GET PATHS:C1163(Path database method:K72:2; $arrPaths; *)
		
		If (Find in array:C230($arrPaths; "[databaseMethod]/onStartup")=-1)
			
			var $folder : 4D:C1709.Folder
			var $file : 4D:C1709.File
			$folder:=Folder:C1567(Folder:C1567(fk database folder:K87:14; *).platformPath; fk platform path:K87:2).folder("Project/Sources/DatabaseMethods")
			$file:=File:C1566("/RESOURCES/init"+Choose:C955(Command name:C538(1)="Sum"; "US"; "FR")+".4dm").copyTo($folder; "onStartup.4dm")
			RELOAD PROJECT:C1739
			
		End if 
		
		//______________________________________________________
	: ($eventCode=On after host database startup:K74:4)
		
		// The On Startup database method of the host database just finished running
		
		//______________________________________________________
	: ($eventCode=On before host database exit:K74:5)
		
/*
The host database is closing, its On Exit database method has not been called yet
and will not be called until the execution of this method is finished.
*/
		
		//______________________________________________________
	: ($eventCode=On after host database exit:K74:6)
		
		// The On Exit database method of the host database has just finished running
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($eventCode)+")")
		
		//______________________________________________________
End case 