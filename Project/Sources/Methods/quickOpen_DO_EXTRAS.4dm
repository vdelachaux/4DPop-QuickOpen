//%attributes = {}
#DECLARE($item : Object)

If (False:C215)
	C_OBJECT:C1216(quickOpen_DO_EXTRAS; $1)
End if 

var $t : Text
var $o : Object

Case of 
		
		//______________________________________________________
	: ($item.desc="runtimeExplorer")
		
		OPEN RUNTIME EXPLORER:C1781
		
		//______________________________________________________
	: ($item.desc="structureSettings")
		
		OPEN SETTINGS WINDOW:C903("/"; False:C215; Structure settings:K5:26)
		
		//______________________________________________________
	: ($item.desc="userSettings")
		
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
	: ($item.desc="msc")
		
		OPEN SECURITY CENTER:C1018
		
		//______________________________________________________
	: ($item.desc="serverAdministrationWindow")
		
		OPEN ADMINISTRATION WINDOW:C1047
		
		//______________________________________________________
	: ($item.desc="restart")
		
		RESTART 4D:C1292
		
		//______________________________________________________
	: ($item.desc="checkSyntax")
		
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
	: ($item.desc="compile")
		
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
	: ($item.desc="build")
		
		BUILD APPLICATION:C871(File:C1566(Build application settings file:K5:60; *).platformPath)
		
		//______________________________________________________
	: ($item.desc="4dFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk user preferences folder:K87:10).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="dataBaseFolder")
		
		If (Application type:C494=4D Remote mode:K5:5)
			
			SHOW ON DISK:C922(Get 4D folder:C485(4D Client database folder:K5:13; *); *)
			
		Else 
			
			SHOW ON DISK:C922(Folder:C1567(fk database folder:K87:14; *).platformPath; *)
			
		End if 
		//______________________________________________________
	: ($item.desc="dataFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk data folder:K87:12; *).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="resourcesFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk resources folder:K87:11; *).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="dataFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk data folder:K87:12; *).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="editorThemeFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk editor theme folder:K87:23).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="webFolder")
		
		If (Folder:C1567(fk web root folder:K87:15; *).exists)
			
			SHOW ON DISK:C922(Folder:C1567(fk web root folder:K87:15; *).platformPath; *)
			
		Else 
			
			ALERT:C41("The web root folder doesn't exists.")
			
		End if 
		
		//______________________________________________________
	: ($item.desc="startWebServer")
		
		WEB Server:C1674(Web server host database:K73:31).start()
		//______________________________________________________
	: ($item.desc="stopWebServer")
		
		WEB Server:C1674(Web server host database:K73:31).stop()
		
		//______________________________________________________
	: ($item.desc="licensesFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk licenses folder:K87:16).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="logsFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk logs folder:K87:17; *).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="mobileAppsFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk mobileApps folder:K87:18; *).platformPath; *)
		
		//______________________________________________________
	: ($item.desc="settingsFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk database folder:K87:14; *).folder("setting").platformPath; *)
		
		//______________________________________________________
	: ($item.desc="docFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk database folder:K87:14; *).folder("Documentation").platformPath; *)
		
		//______________________________________________________
	: ($item.desc="projectFolder")
		
		SHOW ON DISK:C922(Folder:C1567(fk database folder:K87:14; *).folder("Project").platformPath; *)
		
		//______________________________________________________
End case 