Class constructor
	
	var $icon : Picture
	
	This:C1470.isRefreshing:=False:C215
	This:C1470.sources:=Null:C1517
	This:C1470.methodStamp:=0
	This:C1470.formStamp:=0
	
	This:C1470.desc:=New collection:C1472
	This:C1470.desc[Path class:K72:19]:="class"
	This:C1470.desc[Path database method:K72:2]:="DB method"
	This:C1470.desc[Path project method:K72:1]:="method"
	This:C1470.desc[Path project form:K72:3]:="form"
	This:C1470.desc[Path trigger:K72:4]:="trigger"
	This:C1470.desc[Path table form:K72:5]:="table form"
	This:C1470.desc[8858]:="DevDoc"
	
	// List of managed source types
	This:C1470.paths:=New collection:C1472
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_628.png").platformPath; $icon)
	This:C1470.paths.push(New object:C1471(\
		"type"; Path class:K72:19; \
		"path"; "[class]/"; \
		"sources"; Folder:C1567("/PACKAGE/Project/Sources/Classes/"; *); \
		"doc"; Folder:C1567("/PACKAGE/Documentation/Classes/"; *); \
		"comment"; "Class"; \
		"icon"; $icon))
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_602.png").platformPath; $icon)
	This:C1470.paths.push(New object:C1471(\
		"type"; Path project method:K72:1; \
		"path"; ""; \
		"sources"; Folder:C1567("/PACKAGE/Project/Sources/Methods/"; *); \
		"doc"; Folder:C1567("/PACKAGE/Documentation/Methods/"; *); \
		"comment"; "Method"; \
		"icon"; $icon))
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_601.png").platformPath; $icon)
	This:C1470.paths.push(New object:C1471(\
		"type"; Path project form:K72:3; \
		"path"; ""; \
		"sources"; Folder:C1567("/PACKAGE/Project/Sources/Forms/"; *); \
		"doc"; Folder:C1567("/PACKAGE/Documentation/Forms/"; *); \
		"comment"; "Form"; \
		"icon"; $icon))
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_622.png").platformPath; $icon)
	This:C1470.paths.push(New object:C1471(\
		"type"; Path database method:K72:2; \
		"path"; "[databaseMethod]/"; \
		"sources"; Folder:C1567("/PACKAGE/Project/Sources/DatabaseMethods/"; *); \
		"doc"; Folder:C1567("/PACKAGE/Documentation/DatabaseMethods/"; *); \
		"comment"; "Database Method"; \
		"icon"; $icon))
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_600.png").platformPath; $icon)
	This:C1470.paths.push(New object:C1471(\
		"type"; Path trigger:K72:4; \
		"path"; "[trigger]/"; \
		"sources"; Folder:C1567("/PACKAGE/Project/Sources/Triggers/"; *); \
		"doc"; Folder:C1567("/PACKAGE/Documentation/Triggers/"; *); \
		"comment"; "Trigger"; \
		"icon"; $icon))
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_601.png").platformPath; $icon)
	This:C1470.paths.push(New object:C1471(\
		"type"; Path table form:K72:5; \
		"path"; "[tableForm]/table_"; \
		"sources"; Folder:C1567("/PACKAGE/Project/Sources/TableForms/"; *); \
		"doc"; Folder:C1567("/PACKAGE/Documentation/TableForms/"; *); \
		"comment"; "Table Form"; \
		"icon"; $icon))
	
	This:C1470._extras()
	
	//-----------------------------------------------------------
Function _extras()
	
	This:C1470.extras:=New collection:C1472
	
	var $icon : Picture
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_604.png").platformPath; $icon)
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Runtime Explorer"; \
		"desc"; "runtimeExplorer"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Structure Settings"; \
		"desc"; "structureSettings"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "User settings"; \
		"desc"; "userSettings"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Security Center"; \
		"desc"; "msc"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Restart"; \
		"desc"; "restart"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Build Application"; \
		"desc"; "build"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Check Syntax"; \
		"desc"; "checkSyntax"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Compil"; \
		"desc"; "compile"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Active 4D Folder"; \
		"desc"; "4dFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Database Folder"; \
		"desc"; "dataBaseFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Resources Folder"; \
		"desc"; "resourcesFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Editor Theme Folder"; \
		"desc"; "editorThemeFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Web Folder"; \
		"desc"; "webFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Licences Folder"; \
		"desc"; "licensesFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Logs Folder"; \
		"desc"; "logsFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "MobileApps Folder"; \
		"desc"; "mobileAppsFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Settings Folder"; \
		"desc"; "settingsFolder"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	If (Application type:C494=4D Remote mode:K5:5)
		
		This:C1470.extras.push(New object:C1471(\
			"type"; -1; \
			"name"; "Server Administration Window"; \
			"desc"; "serverAdministrationWindow"; \
			"folder"; "_"; \
			"doc"; ""; \
			"icon"; $icon; \
			"attributes"; Null:C1517))
		
	Else 
		
		This:C1470.extras.push(New object:C1471(\
			"type"; -1; \
			"name"; "Data Folder"; \
			"desc"; "dataFolder"; \
			"folder"; "_"; \
			"doc"; ""; \
			"icon"; $icon; \
			"attributes"; Null:C1517))
		
		This:C1470.extras.push(New object:C1471(\
			"type"; -1; \
			"name"; "Documentation Folder"; \
			"desc"; "docFolder"; \
			"folder"; "_"; \
			"doc"; ""; \
			"icon"; $icon; \
			"attributes"; Null:C1517))
		
		If (Bool:C1537(Get database parameter:C643(Is host database a project:K37:99)))
			
			This:C1470.extras.push(New object:C1471(\
				"type"; -1; \
				"name"; "Project Folder"; \
				"desc"; "projectFolder"; \
				"folder"; "_"; \
				"doc"; ""; \
				"icon"; $icon; \
				"attributes"; Null:C1517))
			
		End if 
		
	End if 
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Start Web Server"; \
		"desc"; "startWebServer"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	This:C1470.extras.push(New object:C1471(\
		"type"; -1; \
		"name"; "Stop Web Server"; \
		"desc"; "stopWebServer"; \
		"folder"; "_"; \
		"doc"; ""; \
		"icon"; $icon; \
		"attributes"; Null:C1517))
	
	//-----------------------------------------------------------
	// Build the list of source files
Function getSources()->$this : cs:C1710.design
	
	This:C1470.isRefreshing:=True:C214
	
	// Update the folders list
	This:C1470._folders()
	
	// Update sources list if any
	var $mustBeUpdated : Boolean
	var $i : Integer
	var $stamp : Real
	ARRAY TEXT:C222($dummy; 0x0000)
	
	If (This:C1470.methodStamp=0)
		
		$mustBeUpdated:=True:C214
		
		// Initialize the timestamp
		METHOD GET PATHS:C1163(Path database method:K72:2; $dummy; $stamp; *)
		This:C1470.methodStamp:=$stamp
		
	Else 
		
		$stamp:=This:C1470.methodStamp
		METHOD GET PATHS:C1163(Path all objects:K72:16; $dummy; $stamp; *)
		$mustBeUpdated:=($stamp#This:C1470.methodStamp)
		
		If ($mustBeUpdated)
			
			// Store the last timestamp for methods
			This:C1470.methodStamp:=$stamp
			
		Else 
			
			$stamp:=This:C1470.formStamp
			FORM GET NAMES:C1167($dummy; $stamp; *)
			$mustBeUpdated:=($stamp#This:C1470.formStamp)
			
			For each ($table; ds:C1482) While (Not:C34($mustBeUpdated))
				
				$i:=ds:C1482[$table].getInfo().tableNumber
				FORM GET NAMES:C1167(Table:C252($i)->; $dummy; $stamp; *)
				$mustBeUpdated:=($stamp#This:C1470.formStamp)
				
			End for each 
			
			// Store the last timestamp for forms
			This:C1470.formStamp:=$stamp
			
			If (Not:C34($mustBeUpdated))  // #ACI0101530 - the timestamp isn't updated for forms.
				
				var $hash; $table : Text
				var $c; $c1 : Collection
				
				FORM GET NAMES:C1167($dummy; *)
				$c:=New collection:C1472
				ARRAY TO COLLECTION:C1563($c; $dummy)
				
				For each ($table; ds:C1482)
					
					$i:=ds:C1482[$table].getInfo().tableNumber
					FORM GET NAMES:C1167(Table:C252($i)->; $dummy; *)
					$c1:=New collection:C1472
					ARRAY TO COLLECTION:C1563($c1; $dummy)
					$c:=$c.combine($c1)
					
				End for each 
				
				$hash:=Generate digest:C1147(JSON Stringify:C1217($c); MD5 digest:K66:1)
				$mustBeUpdated:=($hash#String:C10(This:C1470.formHash))
				
				If ($mustBeUpdated)
					
					This:C1470.formHash:=$hash
					
				End if 
			End if 
		End if 
	End if 
	
	If ($mustBeUpdated)
		
		// Update source lists
		This:C1470.sources:=New collection:C1472
		
		This:C1470._load(Path class:K72:19)
		This:C1470._load(Path project method:K72:1)
		This:C1470._load(Path project form:K72:3)
		This:C1470._load(Path database method:K72:2)
		This:C1470._load(Path table form:K72:5)
		This:C1470._load(Path trigger:K72:4)
		
		This:C1470.sources.combine(This:C1470.extras)
		This:C1470.sources:=This:C1470.sources.orderBy("type asc name asc")  //.orderBy("folder asc, name asc, type asc")
		
	End if 
	
	This:C1470.isRefreshing:=False:C215
	
	$this:=This:C1470
	
	//-----------------------------------------------------------
	// Handle the search
Function search($tring : Text)->$result : Collection
	
	var $pos : Integer
	var $o : Object
	var $found : Collection
	
	Case of 
			//______________________________________________________
		: (Length:C16($tring)=0)
			
			This:C1470.getSources()
			$result:=This:C1470.sources
			
			//______________________________________________________
		: ($tring="_")
			
			$found:=Form:C1466.list.query("folder = _")
			
			// Sort results by nale. 
			$result:=$found.orderBy("name asc")
			
			//______________________________________________________
		Else 
			
			If (Form:C1466.list#Null:C1517)
				
				// Filter the list according to what is entered
				$found:=Form:C1466.list.query("name = :1 OR folder = :1 or desc = :1"; "@"+$tring+"@")
				
				// Assign a ranking with fewer points the farther from the beginning of the chain.
				For each ($o; $found)
					
					$o.rank:=0
					
					$pos:=Position:C15($tring; $o.name)
					
					If ($pos>0)
						
						$o.rank:=$o.rank+(1000-($pos*25))
						
					End if 
					
					$pos:=Position:C15($tring; $o.folder)
					
					If ($pos>0)
						
						$o.rank:=$o.rank+(400-($pos*20))
						
					End if 
					
					$pos:=Position:C15($tring; $o.desc)
					
					If ($pos>0)
						
						$o.rank:=$o.rank+(100-($pos*10))
						
					End if 
					
					$o.rank:=$o.rank+Choose:C955($o.name=$tring; 1000; 0)
					
				End for each 
				
				// Sort results by relevance. 
				$result:=$found.orderBy("rank desc, name asc")
				
			End if 
			
			//______________________________________________________
	End case 
	
	//-----------------------------------------------------------
Function edit($designObject : Object; $formMethod : Boolean)
	
	var $formMethodƒ : Boolean
	var $regex : cs:C1710.regex
	
	If ($designObject.type=Path project form:K72:3)\
		 | ($designObject.type=Path table form:K72:5)
		
		If (Count parameters:C259>=2)
			
			$formMethodƒ:=$formMethod  // Edit form method
			
		End if 
		
	Else 
		
		$formMethodƒ:=True:C214
		
	End if 
	
	$regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$").match()
	
	If ($formMethodƒ)
		
		// ⚠️ METHOD OPEN PATH could generate an error if form method doesn't exists
		var $onErrCallMethod : Text
		$onErrCallMethod:=This:C1470._errorCatch()
		
		Case of 
				
				//………………………………………………………………………………………………
			: ($designObject.type=Path table form:K72:5)
				
				METHOD OPEN PATH:C1213(METHOD Get path:C1164(Path table form:K72:5; Table:C252($designObject.tableNumber)->; $regex.matches[1].data); *)
				
				//………………………………………………………………………………………………
			: ($designObject.type=Path project form:K72:3)
				
				METHOD OPEN PATH:C1213("[projectForm]/"+This:C1470.paths.query("type = :1"; $designObject.type).pop().path+$designObject.name+"/{formMethod}"; *)
				
				//………………………………………………………………………………………………
			Else 
				
				METHOD OPEN PATH:C1213(This:C1470.paths.query("type = :1"; $designObject.type).pop().path+$designObject.name; *)
				
				//………………………………………………………………………………………………
		End case 
		
		This:C1470._errorCatch($onErrCallMethod)
		
	Else 
		
		If ($designObject.type=Path table form:K72:5)
			
			FORM EDIT:C1749(Table:C252($designObject.tableNumber)->; $regex.matches[1].data)
			
		Else 
			
			FORM EDIT:C1749(String:C10($designObject.name))
			
		End if 
	End if 
	
	//-----------------------------------------------------------
Function editDoc($designObject : Object)
	
	var $o : Object
	var $file : 4D:C1709.File
	var $regex : cs:C1710.regex
	
	$o:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
	Case of 
			
			//______________________________________________________
		: ($designObject.type<0)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: ($designObject.type=Path trigger:K72:4)
			
			// Triggers are referenced by the table number
			$file:=$o.doc.file("table_"+String:C10($designObject.tableNumber)+".md")
			
			//______________________________________________________
		: ($designObject.type=Path project form:K72:3)
			
			$file:=$o.doc.folder($designObject.name).file("form.md")
			
			//______________________________________________________
		: ($designObject.type=Path table form:K72:5)
			
			$regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$").match()
			$file:=$o.doc.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).file("form.md")
			
			//______________________________________________________
		Else 
			
			$file:=$o.doc.file($designObject.name+".md")
			
			//______________________________________________________
	End case 
	
	// Create, if necessary, and open the doc file
	If (Not:C34($file.exists))
		
		$file.create()
		$file.setText("# "+$designObject.name+" "+$o.comment+" Documentation\r")
		
	End if 
	
	If ($file.exists)
		
		OPEN URL:C673($file.platformPath)
		
	End if 
	
	//-----------------------------------------------------------
Function showOnDisk($designObject : Object)
	
	var $o : Object
	var $file : 4D:C1709.File
	var $regex : cs:C1710.regex
	
	$o:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
	
	Case of 
			
			//______________________________________________________
		: ($designObject.type<0)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: ($designObject.type=Path trigger:K72:4)
			
			$file:=$o.sources.file("table_"+String:C10($designObject.tableNumber)+".4dm")
			
			//______________________________________________________
		: ($designObject.type=Path table form:K72:5)
			
			$regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$").match()
			$file:=$o.sources.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).file("form.4dform")
			
			//______________________________________________________
		: ($designObject.type=Path project form:K72:3)
			
			$file:=$o.sources.folder($designObject.name).file("form.4dform")
			
			//______________________________________________________
		Else 
			
			$file:=$o.sources.file($designObject.name+".4dm")
			
			//______________________________________________________
	End case 
	
	If ($file.exists)
		
		SHOW ON DISK:C922($file.platformPath)
		
	End if 
	
	//-----------------------------------------------------------
	// Create, if necessary, and open the doc file
Function showDocOnDisk($designObject : Object; $createIfNotExists : Boolean)
	
	var $file : 4D:C1709.File
	var $o : Object
	
	$file:=$designObject.doc
	
	If (Not:C34($file.exists))
		
		If (Count parameters:C259>=2)
			
			If ($createIfNotExists)
				
				$o:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
				$file.create()
				$file.setText("# "+$designObject.name+" "+String:C10($o.comment)+" Documentation\r")
				
			End if 
		End if 
	End if 
	
	If ($file.exists)
		
		SHOW ON DISK:C922($file.platformPath)
		
	End if 
	
	//-----------------------------------------------------------
	// Delete a method file or a form folder & documentation if any
Function delete($designObject : Object)
	
	var $o : Object
	var $regex : cs:C1710.regex
	
	$o:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
	Case of 
			
			//______________________________________________________
		: ($designObject.type<0)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: ($designObject.type=Path trigger:K72:4)
			
			$o.sources.file("table_"+String:C10($designObject.tableNumber)+".4dm").delete()
			
			//………………………………………………………………………………………………
		: ($designObject.type=Path table form:K72:5)
			
			$regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$").match()
			$o.sources.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).delete(Delete with contents:K24:24)
			
			//………………………………………………………………………………………………
		: ($designObject.type=Path project form:K72:3)
			
			$o.sources.folder($designObject.name).delete(Delete with contents:K24:24)
			
			//………………………………………………………………………………………………
		Else 
			
			$o.sources.file($designObject.name+".4dm").delete()
			
			//………………………………………………………………………………………………
	End case 
	
	//delete doc
	This:C1470.deleteDoc($designObject)
	
	RELOAD PROJECT:C1739
	
	//-----------------------------------------------------------
	// Delete a documentation file
Function deleteDoc($designObject : Object)
	
	var $o : Object
	var $regex : cs:C1710.regex
	
	$o:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
	Case of 
			
			//______________________________________________________
		: ($designObject.type<0)
			
			// <NOTHING MORE TO DO>
			
			//………………………………………………………………………………………………
		: ($designObject.type=Path trigger:K72:4)
			
			// Triggers are referenced by the table number
			$o.doc.file("table_"+String:C10($designObject.tableNumber)+".md").delete()
			
			//………………………………………………………………………………………………
		: ($designObject.type=Path project form:K72:3)
			
			$o.doc.folder($designObject.name).delete(Delete with contents:K24:24)
			
			//………………………………………………………………………………………………
		: ($designObject.type=Path table form:K72:5)
			
			$regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$").match()
			$o.doc.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).delete(Delete with contents:K24:24)
			
			//………………………………………………………………………………………………
		Else 
			
			$o.doc.file($designObject.name+".md").delete()
			
			//………………………………………………………………………………………………
	End case 
	
	//-----------------------------------------------------------
	// Build the folders list
Function _folders()
	
	var $key; $t : Text
	var $folders : Object
	var $file : 4D:C1709.File
	var $sources : 4D:C1709.Folder
	
	This:C1470.folders:=New object:C1471(\
		"classes"; New object:C1471; \
		"methods"; New object:C1471; \
		"forms"; New object:C1471; \
		"tables"; New object:C1471)
	
	$sources:=Folder:C1567("/PACKAGE/Project/Sources/"; *)
	
	$file:=$sources.file("folders.json")
	
	If ($file.exists)
		
		$folders:=JSON Parse:C1218($file.getText())
		
		For each ($key; $folders)
			
			If ($folders[$key].methods#Null:C1517)
				
				For each ($t; $folders[$key].methods)
					
					This:C1470.folders.methods[$t]:=$key
					
				End for each 
			End if 
			
			If ($folders[$key].classes#Null:C1517)
				
				For each ($t; $folders[$key].classes)
					
					This:C1470.folders.classes[$t]:=$key
					
				End for each 
			End if 
			
			If ($folders[$key].forms#Null:C1517)
				
				For each ($t; $folders[$key].forms)
					
					This:C1470.folders.forms[$t]:=$key
					
				End for each 
			End if 
			
			If ($folders[$key].tables#Null:C1517)
				
				For each ($t; $folders[$key].tables)
					
					This:C1470.folders.tables[$t]:=$key
					
				End for each 
			End if 
		End for each 
	End if 
	
	//-----------------------------------------------------------
	// Load a type of source files
Function _load($type : Integer)
	
	var $tableNumber : Integer
	var $form; $item; $o : Object
	var $docFiles; $sourceFiles : Collection
	
	$o:=This:C1470.paths.query("type = :1"; $type).pop()
	
	If ($type=Path project form:K72:3)\
		 | ($type=Path table form:K72:5)
		
		// Each table items are in a folder nammed "N" with N = table number
		$sourceFiles:=$o.sources.folders(fk ignore invisible:K87:22)
		
	Else 
		
		$sourceFiles:=$o.sources.files(fk ignore invisible:K87:22).query("extension = .4dm")
		
	End if 
	
	$docFiles:=$o.doc.files(fk ignore invisible:K87:22).query("extension = .md")
	
	For each ($item; $sourceFiles)
		
		Case of 
				
				//………………………………………………………………………………………………
			: ($type=Path trigger:K72:4)
				
				$tableNumber:=Num:C11($item.name)
				
				If ($tableNumber>0)
					
					This:C1470.sources.push(New object:C1471(\
						"type"; Path trigger:K72:4; \
						"tableNumber"; $tableNumber; \
						"name"; Table name:C256($tableNumber); \
						"desc"; This:C1470.desc[Path trigger:K72:4]; \
						"folder"; String:C10(This:C1470.folders.tables["Table_"+String:C10($tableNumber)]); \
						"doc"; $docFiles.query("name = :1"; "table_"+String:C10($tableNumber)).pop(); \
						"icon"; $o.icon; \
						"attributes"; Null:C1517))
					
				End if 
				
				//………………………………………………………………………………………………
			: ($type=Path table form:K72:5)
				
				$tableNumber:=Num:C11($item.name)
				
				If ($tableNumber>0)
					
					For each ($form; $item.folders(fk ignore invisible:K87:22))
						
						If ($form.file("form.4DForm").exists)
							
							This:C1470.sources.push(New object:C1471(\
								"type"; Path table form:K72:5; \
								"tableNumber"; $tableNumber; \
								"name"; "["+Table name:C256($tableNumber)+"]"+$form.name; \
								"desc"; This:C1470.desc[Path table form:K72:5]; \
								"folder"; String:C10(This:C1470.folders.tables["Table_"+String:C10($tableNumber)]); \
								"doc"; $o.doc.folder(String:C10($tableNumber)).folder($form.name).file("form.md"); \
								"icon"; $o.icon; \
								"attributes"; Null:C1517))
							
						End if 
					End for each 
				End if 
				
				//………………………………………………………………………………………………
			: ($type=Path project form:K72:3)
				
				If ($item.file("form.4DForm").exists)
					
					This:C1470.sources.push(New object:C1471(\
						"type"; Path project form:K72:3; \
						"name"; $item.name; \
						"desc"; This:C1470.desc[Path project form:K72:3]; \
						"folder"; String:C10(This:C1470.folders.forms[$item.name]); \
						"doc"; $o.doc.folder($item.name).file("form.md"); \
						"icon"; $o.icon; \
						"attributes"; Null:C1517))
					
				End if 
				
				//………………………………………………………………………………………………
			: ($type=Path class:K72:19)
				
				This:C1470.sources.push(New object:C1471(\
					"type"; $type; \
					"name"; $item.name; \
					"desc"; This:C1470.desc[$type]; \
					"folder"; String:C10(This:C1470.folders.classes[$item.name]); \
					"doc"; $docFiles.query("name = :1"; $item.name).pop(); \
					"icon"; $o.icon; \
					"attributes"; Null:C1517))
				
				//………………………………………………………………………………………………
			: ($type=Path project method:K72:1)
				
				var $attributes : Object
				METHOD GET ATTRIBUTES:C1334($item.name; $attributes; *)
				
				This:C1470.sources.push(New object:C1471(\
					"type"; $type; \
					"name"; $item.name; \
					"desc"; This:C1470.desc[$type]; \
					"folder"; String:C10(This:C1470.folders.methods[$item.name]); \
					"doc"; $docFiles.query("name = :1"; $item.name).pop(); \
					"icon"; $o.icon; \
					"attributes"; $attributes))
				
				//………………………………………………………………………………………………
			: ($type=Path database method:K72:2)
				
				This:C1470.sources.push(New object:C1471(\
					"type"; $type; \
					"name"; $item.name; \
					"desc"; This:C1470.desc[$type]; \
					"folder"; ""; \
					"doc"; $docFiles.query("name = :1"; $item.name).pop(); \
					"icon"; $o.icon; \
					"attributes"; Null:C1517))
				
				//………………………………………………………………………………………………
			Else 
				
				
				//………………………………………………………………………………………………
		End case 
	End for each 
	
	//-----------------------------------------------------------
Function _errorCatch($onErrCallMethod : Text)->$currentOnErrCallMethod : Text
	
	If (Count parameters:C259>=1)
		
		ON ERR CALL:C155($onErrCallMethod)
		
	Else 
		
		$currentOnErrCallMethod:=Method called on error:C704
		ON ERR CALL:C155("noError")
		CLEAR VARIABLE:C89(ERROR)
		
	End if 