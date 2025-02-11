property isRefreshing : Boolean
property desc; paths; sources : Collection
property methodStamp; formStamp : Integer

property folders : Object
property formHash : Text

Class constructor
	
	var $icon : Picture
	
	This:C1470.isRefreshing:=False:C215
	This:C1470.sources:=Null:C1517
	This:C1470.methodStamp:=0
	This:C1470.formStamp:=0
	
	This:C1470.desc:=[]
	This:C1470.desc[Path class:K72:19]:="class"
	This:C1470.desc[Path database method:K72:2]:="DB method"
	This:C1470.desc[Path project method:K72:1]:="method"
	This:C1470.desc[Path project form:K72:3]:="form"
	This:C1470.desc[Path trigger:K72:4]:="trigger"
	This:C1470.desc[Path table form:K72:5]:="table form"
	This:C1470.desc[8858]:="DevDoc"
	
	// List of managed source types
	This:C1470.paths:=[]
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_628.png").platformPath; $icon)
	This:C1470.paths.push({\
		type: Path class:K72:19; \
		path: "[class]/"; \
		sources: Folder:C1567("/PACKAGE/Project/Sources/Classes/"; *); \
		doc: Folder:C1567("/PACKAGE/Documentation/Classes/"; *); \
		comment: "Class"; \
		icon: $icon})
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_602.png").platformPath; $icon)
	This:C1470.paths.push({\
		type: Path project method:K72:1; \
		path: ""; \
		sources: Folder:C1567("/PACKAGE/Project/Sources/Methods/"; *); \
		doc: Folder:C1567("/PACKAGE/Documentation/Methods/"; *); \
		comment: "Method"; \
		icon: $icon})
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_601.png").platformPath; $icon)
	This:C1470.paths.push({\
		type: Path project form:K72:3; \
		path: ""; \
		sources: Folder:C1567("/PACKAGE/Project/Sources/Forms/"; *); \
		doc: Folder:C1567("/PACKAGE/Documentation/Forms/"; *); \
		comment: "Form"; \
		icon: $icon})
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_622.png").platformPath; $icon)
	This:C1470.paths.push({\
		type: Path database method:K72:2; \
		path: "[databaseMethod]/"; \
		sources: Folder:C1567("/PACKAGE/Project/Sources/DatabaseMethods/"; *); \
		doc: Folder:C1567("/PACKAGE/Documentation/DatabaseMethods/"; *); \
		comment: "Database Method"; \
		icon: $icon})
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_600.png").platformPath; $icon)
	This:C1470.paths.push({\
		type: Path trigger:K72:4; \
		path: "[trigger]/"; \
		sources: Folder:C1567("/PACKAGE/Project/Sources/Triggers/"; *); \
		doc: Folder:C1567("/PACKAGE/Documentation/Triggers/"; *); \
		comment: "Trigger"; \
		icon: $icon})
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_601.png").platformPath; $icon)
	This:C1470.paths.push({\
		type: Path table form:K72:5; \
		path: "[tableForm]/table_"; \
		sources: Folder:C1567("/PACKAGE/Project/Sources/TableForms/"; *); \
		doc: Folder:C1567("/PACKAGE/Documentation/TableForms/"; *); \
		comment: "Table Form"; \
		icon: $icon})
	
	//-----------------------------------------------------------
	// Build the list of source files
Function getSources() : cs:C1710.design
	
	This:C1470.isRefreshing:=True:C214
	
	// Update the folders list
	This:C1470._folders()
	
	// Update sources list if any
	var $i : Integer
	var $stamp : Real
	ARRAY TEXT:C222($dummy; 0x0000)
	
	If (This:C1470.methodStamp=0)
		
		var $mustBeUpdated:=True:C214
		
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
				
				FORM GET NAMES:C1167($dummy; *)
				var $c:=[]
				ARRAY TO COLLECTION:C1563($c; $dummy)
				
				var $table : Text
				For each ($table; ds:C1482)
					
					$i:=ds:C1482[$table].getInfo().tableNumber
					FORM GET NAMES:C1167(Table:C252($i)->; $dummy; *)
					var $c1:=[]
					ARRAY TO COLLECTION:C1563($c1; $dummy)
					$c:=$c.combine($c1)
					
				End for each 
				
				var $hash:=Generate digest:C1147(JSON Stringify:C1217($c); MD5 digest:K66:1)
				$mustBeUpdated:=($hash#String:C10(This:C1470.formHash))
				
				If ($mustBeUpdated)
					
					This:C1470.formHash:=$hash
					
				End if 
			End if 
		End if 
	End if 
	
	If ($mustBeUpdated)
		
		// Update source lists
		This:C1470.sources:=[]
		
		This:C1470._load(Path class:K72:19)
		This:C1470._load(Path project method:K72:1)
		This:C1470._load(Path project form:K72:3)
		This:C1470._load(Path database method:K72:2)
		This:C1470._load(Path table form:K72:5)
		This:C1470._load(Path trigger:K72:4)
		
		This:C1470.sources:=This:C1470.sources.orderBy("type asc name asc")
		
	End if 
	
	This:C1470.isRefreshing:=False:C215
	
	return This:C1470
	
	//-----------------------------------------------------------
Function edit($designObject : Object; $formMethod : Boolean)
	
	If ($designObject.type=Path project form:K72:3)\
		 | ($designObject.type=Path table form:K72:5)
		
		$formMethod:=Count parameters:C259>=2 ? $formMethod : False:C215
		
	Else 
		
		$formMethod:=True:C214
		
	End if 
	
	var $regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$")
	$regex.match()
	
	If ($formMethod)
		
		// ⚠️ METHOD OPEN PATH could generate an error if form method doesn't exists
		Case of 
				
				//………………………………………………………………………………………………
			: ($designObject.type=Path table form:K72:5)
				
				Try(METHOD OPEN PATH:C1213(METHOD Get path:C1164(Path table form:K72:5; Table:C252($designObject.tableNumber)->; $regex.matches[1].data); *))
				
				//………………………………………………………………………………………………
			: ($designObject.type=Path project form:K72:3)
				
				Try(METHOD OPEN PATH:C1213("[projectForm]/"+This:C1470.paths.query("type = :1"; $designObject.type).pop().path+$designObject.name+"/{formMethod}"; *))
				
				//………………………………………………………………………………………………
			Else 
				
				Try(METHOD OPEN PATH:C1213(This:C1470.paths.query("type = :1"; $designObject.type).pop().path+$designObject.name; *))
				
				//………………………………………………………………………………………………
		End case 
		
	Else 
		
		If ($designObject.type=Path table form:K72:5)
			
			FORM EDIT:C1749(Table:C252($designObject.tableNumber)->; $regex.matches[1].data)
			
		Else 
			
			FORM EDIT:C1749(String:C10($designObject.name))
			
		End if 
	End if 
	
	//-----------------------------------------------------------
Function editDoc($designObject : Object)
	
	var $file : 4D:C1709.File
	var $o : Object:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
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
			
			var $regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$")
			
			If ($regex.match())
				
				$file:=$o.doc.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).file("form.md")
				
			End if 
			
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
	
	var $file : 4D:C1709.File
	var $o : Object:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
	Case of 
			
			//______________________________________________________
		: ($designObject.type<0)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: ($designObject.type=Path trigger:K72:4)
			
			$file:=$o.sources.file("table_"+String:C10($designObject.tableNumber)+".4dm")
			
			//______________________________________________________
		: ($designObject.type=Path table form:K72:5)
			
			var $regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$")
			
			If ($regex.match())
				
				$file:=$o.sources.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).file("form.4dform")
				
			End if 
			
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
	
	var $file : 4D:C1709.File:=$designObject.doc
	
	If (Not:C34($file.exists))\
		 && (Count parameters:C259>=2)\
		 && ($createIfNotExists)
		
		var $o : Object:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
		$file.create()
		$file.setText("# "+$designObject.name+" "+String:C10($o.comment)+" Documentation\r")
		
	End if 
	
	If ($file.exists)
		
		SHOW ON DISK:C922($file.platformPath)
		
	End if 
	
	//-----------------------------------------------------------
	// Delete a method file or a form folder & documentation if any
Function delete($designObject : Object)
	
	var $o : Object:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
	Case of 
			
			//______________________________________________________
		: ($designObject.type<0)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: ($designObject.type=Path trigger:K72:4)
			
			$o.sources.file("table_"+String:C10($designObject.tableNumber)+".4dm").delete()
			
			//………………………………………………………………………………………………
		: ($designObject.type=Path table form:K72:5)
			
			var $regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$")
			
			If ($regex.match())
				
				$o.sources.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).delete(Delete with contents:K24:24)
				
			End if 
			
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
	
	var $o : Object:=This:C1470.paths.query("type = :1"; $designObject.type).pop()
	
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
			
			var $regex:=cs:C1710.regex.new($designObject.name; "(?mi-s)^\\[[^\\]]*\\]([^$]*)$")
			
			If ($regex.match())
				
				$o.doc.folder(String:C10($designObject.tableNumber)).folder($regex.matches[1].data).delete(Delete with contents:K24:24)
				
			End if 
			
			//………………………………………………………………………………………………
		Else 
			
			$o.doc.file($designObject.name+".md").delete()
			
			//………………………………………………………………………………………………
	End case 
	
	//-----------------------------------------------------------
	// Build the folders list
Function _folders()
	
	This:C1470.folders:={\
		classes: {}; \
		methods: {}; \
		forms: {}; \
		tables: {}}
	
	var $file:=File:C1566("/PACKAGE/Project/Sources/folders.json"; *)
	
	If (Not:C34($file.exists))
		
		return 
		
	End if 
	
	var $folders : Object:=JSON Parse:C1218($file.getText())
	var $key; $t : Text
	
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
	
	//-----------------------------------------------------------
	// Load a type of source files
Function _load($type : Integer)
	
	var $o : Object:=This:C1470.paths.query("type = :1"; $type).pop()
	
	If ($type=Path project form:K72:3)\
		 | ($type=Path table form:K72:5)
		
		// Each table items are in a folder nammed "N" with N = table number
		var $sourceFiles : Collection:=$o.sources.folders(fk ignore invisible:K87:22)
		
	Else 
		
		$sourceFiles:=$o.sources.files(fk ignore invisible:K87:22).query("extension = .4dm")
		
	End if 
	
	var $docFiles : Collection:=$o.doc.files(fk ignore invisible:K87:22).query("extension = .md")
	var $item : Object
	
	For each ($item; $sourceFiles)
		
		Case of 
				
				//………………………………………………………………………………………………
			: ($type=Path trigger:K72:4)
				
				var $tableNumber : Integer:=Num:C11($item.name)
				
				If (Is table number valid:C999($tableNumber))
					
					This:C1470.sources.push({\
						type: Path trigger:K72:4; \
						tableNumber: $tableNumber; \
						name: Table name:C256($tableNumber); \
						desc: This:C1470.desc[Path trigger:K72:4]; \
						folder: String:C10(This:C1470.folders.tables["Table_"+String:C10($tableNumber)]); \
						doc: $docFiles.query("name = :1"; "table_"+String:C10($tableNumber)).pop(); \
						icon: $o.icon; \
						attributes: Null:C1517})
					
				End if 
				
				//………………………………………………………………………………………………
			: ($type=Path table form:K72:5)
				
				$tableNumber:=Num:C11($item.name)
				
				If (Is table number valid:C999($tableNumber))
					
					var $form : Object
					For each ($form; $item.folders(fk ignore invisible:K87:22))
						
						If ($form.file("form.4DForm").exists)
							
							This:C1470.sources.push({\
								type: Path table form:K72:5; \
								tableNumber: $tableNumber; \
								name: "["+Table name:C256($tableNumber)+"]"+$form.name; \
								desc: This:C1470.desc[Path table form:K72:5]; \
								folder: String:C10(This:C1470.folders.tables["Table_"+String:C10($tableNumber)]); \
								doc: $o.doc.folder(String:C10($tableNumber)).folder($form.name).file("form.md"); \
								icon: $o.icon; \
								attributes: Null:C1517})
							
						End if 
					End for each 
				End if 
				
				//………………………………………………………………………………………………
			: ($type=Path project form:K72:3)
				
				If ($item.file("form.4DForm").exists)
					
					This:C1470.sources.push({\
						type: Path project form:K72:3; \
						name: $item.name; \
						desc: This:C1470.desc[Path project form:K72:3]; \
						folder: String:C10(This:C1470.folders.forms[$item.name]); \
						doc: $o.doc.folder($item.name).file("form.md"); \
						icon: $o.icon; \
						attributes: Null:C1517})
					
				End if 
				
				//………………………………………………………………………………………………
			: ($type=Path class:K72:19)
				
				This:C1470.sources.push({\
					type: $type; \
					name: $item.name; \
					desc: This:C1470.desc[$type]; \
					folder: String:C10(This:C1470.folders.classes[$item.name]); \
					doc: $docFiles.query("name = :1"; $item.name).pop(); \
					icon: $o.icon; \
					attributes: Null:C1517})
				
				//………………………………………………………………………………………………
			: ($type=Path project method:K72:1)
				
				var $attributes : Object
				
				Try(METHOD GET ATTRIBUTES:C1334($item.name; $attributes; *))
				
				This:C1470.sources.push({\
					type: $type; \
					name: $item.name; \
					desc: This:C1470.desc[$type]; \
					folder: String:C10(This:C1470.folders.methods[$item.name]); \
					doc: $docFiles.query("name = :1"; $item.name).pop(); \
					icon: $o.icon; \
					attributes: $attributes})
				
				//………………………………………………………………………………………………
			: ($type=Path database method:K72:2)
				
				This:C1470.sources.push({\
					type: $type; \
					name: $item.name; \
					desc: This:C1470.desc[$type]; \
					folder: ""; \
					doc: $docFiles.query("name = :1"; $item.name).pop(); \
					icon: $o.icon; \
					attributes: Null:C1517})
				
				//………………………………………………………………………………………………
		End case 
	End for each 