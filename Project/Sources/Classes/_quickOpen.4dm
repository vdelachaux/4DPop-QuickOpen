Class extends design

Class constructor()
	
	var $icon : Picture
	
	Super:C1705()
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_604.png").platformPath; $icon)
	This:C1470.paths.push(New object:C1471(\
		"type"; -1; \
		"comment"; "embedded action"; \
		"icon"; $icon; \
		"folder"; "_"; \
		"desc"; "action"))
	
	This:C1470.commands:=New collection:C1472
	
	This:C1470._loadActions()
	
	//-----------------------------------------------------------
Function _loadActions()
	
	var $t : Text
	var $toPush : Boolean
	var $o; $tmpl : Object
	
	$o:=JSON Parse:C1218(File:C1566("/RESOURCES/quickOpen.json").getText())
	$o:=JSON Resolve pointers:C1478($o; New object:C1471("merge"; True:C214))
	
	If ($o.success)
		
		$tmpl:=This:C1470.paths.query("type = :1"; -1).pop()
		
		For each ($o; $o.value.actions)
			
			If ($o.condition#Null:C1517)
				
				$toPush:=Formula from string:C1601($o.condition).call()
				
			Else 
				
				$toPush:=True:C214  // Default
				
			End if 
			
			If ($toPush)
				
				// Localize
				$t:=Get localized string:C991(String:C10($o.name))
				$o.name:=Choose:C955(Bool:C1537(OK); $t; $o.name)
				
				$o.type:=$tmpl.type
				$o.icon:=$tmpl.icon
				$o.desc:=$tmpl.desc
				$o.folder:=$tmpl.folder
				$o.doc:=""
				$o.attributes:=Null:C1517
				
				This:C1470.commands.push($o)
				
			End if 
		End for each 
	End if 
	
	//======================================================================================
	// Handles updating the window and list as keystrokes are entered in the search field.
Function search($tring : Text)
	
	var $bottom; $left; $pos; $right; $top : Integer
	var $toMaximize; $toMinimize : Boolean
	var $o : Object
	var $found : Collection
	
	If (Count parameters:C259>=1)
		
		Form:C1466.search:=$tring
		
	End if 
	
	// Makes sure the window is expanded if at least 3 characters are entered
	Case of 
			
			//………………………………………………………………………………………………………………………
		: (Length:C16(Form:C1466.search)=0)\
			 & (Form:C1466.isMaximized)
			
			$toMinimize:=True:C214  // Zero character & maximized -> Needs to be minimized
			
			//………………………………………………………………………………………………………………………
		: ((Length:C16(Form:C1466.search)>=3) | (Character code:C91(Form:C1466.search)=At sign:K15:46) | (Form:C1466.search="$@"))\
			 & (Not:C34(Form:C1466.isMaximized))
			
			$toMaximize:=True:C214  // At least 3 characters or "@" & minimized -> Needs to be maximized
			
			//………………………………………………………………………………………………………………………
		: (Length:C16(Form:C1466.search)<3)\
			 & (Form:C1466.isMaximized)
			
			$toMinimize:=(Form:C1466.search#"$@")  // Less than 3 characters & maximized -> Needs to be minimized
			
			//………………………………………………………………………………………………………………………
	End case 
	
	Case of 
			
			//………………………………………………………………………………………………………………………
		: ($toMaximize)
			
			GET WINDOW RECT:C443($left; $top; $right; $bottom)
			SET WINDOW RECT:C444($left; $top; $right; $bottom+(Form:C1466.maximized.coordinates.bottom-Form:C1466.minimized.coordinates.bottom))
			
			Form:C1466.minimized.hide()
			Form:C1466.maximized.show(Is macOS:C1572)
			
			Form:C1466.isMaximized:=True:C214
			
			//………………………………………………………………………………………………………………………
		: ($toMinimize)
			
			GET WINDOW RECT:C443($left; $top; $right; $bottom)
			SET WINDOW RECT:C444($left; $top; $right; $bottom-(Form:C1466.maximized.coordinates.bottom-Form:C1466.minimized.coordinates.bottom))
			
			Form:C1466.maximized.hide()
			Form:C1466.minimized.show(Is macOS:C1572)
			
			Form:C1466.isMaximized:=False:C215
			
			//………………………………………………………………………………………………………………………
	End case 
	
	// Handle the search
	Form:C1466.result:=This:C1470._search(Form:C1466.search)
	
	If (Form:C1466.isMaximized)
		
		If (Num:C11(Form:C1466.preferences.selectedItem)=0)
			
			// Let's hope that the first one is the right one, so we select it.
			Form:C1466.resultList.select(1)
			
		Else 
			
			// Just opened with the memorized search --> Restore the selected item
			Form:C1466.resultList.select(Form:C1466.preferences.selectedItem)
			
		End if 
		
		Form:C1466.icon.show()
		
	Else 
		
		Form:C1466.resultList.unselect()
		Form:C1466.icon.hide()
		
	End if 
	
	//======================================================================================
Function open($item : Object)
	
	If ($item#Null:C1517)  // Make sure an item is selected
		
		Form:C1466.preferences.lastItem:=New object:C1471("name"; $item.name)
		
		Case of 
				
				//______________________________________________________
			: ($item.type=-1)
				
				// Include in the list of the last used to allow the most used to be presented first
				Form:C1466.preferences.latestActions.insert(0; New object:C1471("name"; $item.name))
				
				If (Form:C1466.preferences.latestActions.length>10)
					
					Form:C1466.preferences.latestActions.resize(10)
					
				End if 
				
				CALL WORKER:C1389(1; "quickOpen_ACTIONS"; $item)
				
				//______________________________________________________
			: ($item.target=Null:C1517)
				
				This:C1470.edit($item)
				
				//______________________________________________________
			: ($item.target="doc")
				
				This:C1470.editDoc($item)
				
				//______________________________________________________
			: ($item.target="method")
				
				This:C1470.edit($item; True:C214)
				
				//______________________________________________________
		End case 
		
		This:C1470.close()
		
	End if 
	
	//======================================================================================
Function show($item : Object; $editDoc : Boolean)
	
	var $doc : Boolean
	
	If ($item#Null:C1517)  // Make sure an item is selected
		
		If (Count parameters:C259>=2)
			
			$doc:=$editDoc
			
		Else 
			
			// Modifier
			$doc:=(Macintosh option down:C545 | Windows Alt down:C563)
			
		End if 
		
		If ($doc)
			
			This:C1470.showDocOnDisk($item; True:C214)
			
		Else 
			
			This:C1470.showOnDisk($item)
			
		End if 
		
		This:C1470.close()
		
	End if 
	
	//======================================================================================
	// Propose a contextual menu with more actions
Function menu($item : Object)
	
	var $menu : cs:C1710.menu
	
	If ($item#Null:C1517)
		
		$menu:=cs:C1710.menu.new()\
			.append(Choose:C955($item.type>0; "edit"; "execute"); "edit")
		
		If ($item.type>0)
			
			If ($item.type=Path project form:K72:3)\
				 | ($item.type=Path table form:K72:5)
				
				$menu.append("editFormMethod"; "method")
				
			End if 
			
			$menu.append(Choose:C955(Bool:C1537($item.doc.exists); "editDocumentation"; "createDocumentation"); "doc")\
				.append("showSourceFile"; "showSource")\
				.append("showDocumentationFile"; "showDoc").enable(Bool:C1537($item.doc.exists))\
				.line()\
				.append("copyTheName"; "copy")\
				.line()\
				.append("deleteSourceFile"; "deleteSource")
			
			If (Bool:C1537($item.doc.exists))
				
				$menu.append("deleteDocumentation"; "deleteDoc")
				
			End if 
			
			If ($item.type=Path project form:K72:3)\
				 | ($item.type=Path table form:K72:5)
				
				$menu.append("deleteFormMethod"; "deleteFormMethod")
				
			End if 
		End if 
		
		$menu.popup()
		
		Case of 
				
				//________________________________________
			: (Not:C34($menu.selected))
				
				// <NOTHING MORE TO DO>
				
				//=======================================================
			: ($menu.choice="edit")
				
				This:C1470.open($item)
				
				//=======================================================
			: ($menu.choice="method")\
				 | ($menu.choice="doc")
				
				$item.target:=$menu.choice
				This:C1470.open($item)
				
				//=======================================================
			: ($menu.choice="showSource")
				
				// Shows the file on disk
				This:C1470.show($item)
				
				//=======================================================
			: ($menu.choice="showDoc")
				
				// Shows the documentation file on disk
				This:C1470.show($item; True:C214)
				
				//=======================================================
			: ($menu.choice="copy")
				
				// Copies the name of the selected item to the clipboard.
				SET TEXT TO PASTEBOARD:C523($item.name)
				This:C1470.close()
				
				//=======================================================
			: ($menu.choice="deleteSource")
				
				CONFIRM:C162(Replace string:C233(Replace string:C233(Get localized string:C991("areYouSureYouWantToDeleteTheTypeItem"); "{type}"; $item.desc); "{item}"; $item.name); \
					Get localized string:C991("delete"); \
					Get localized string:C991("keepIt"))
				
				If (Bool:C1537(OK))
					
					This:C1470.delete($item)
					This:C1470.close()
					
				End if 
				
				//=======================================================
			: ($menu.choice="deleteDoc")
				
				CONFIRM:C162(Replace string:C233(Replace string:C233(Get localized string:C991("areYouSureYouWantToDeleteTheDocumentationForTypeItem"); "{type}"; $item.desc); "{item}"; $item.name); \
					Get localized string:C991("delete"); \
					Get localized string:C991("keepIt"))
				
				If (Bool:C1537(OK))
					
					This:C1470.deleteDoc($item)
					This:C1470.close()
					
				End if 
				
				//________________________________________
			Else 
				
				ALERT:C41("We are going tout doux 🤣")
				
				//________________________________________
		End case 
		
	End if 
	
	//======================================================================================
Function close
	
	var $file : 4D:C1709.File
	
	$file:=Folder:C1567(fk database folder:K87:14; *).file("Preferences/4DPop design.preferences")
	$file.setText(JSON Stringify:C1217(Form:C1466.preferences; *))
	
	CANCEL:C270
	
	//======================================================================================
Function _search($tring : Text)->$result : Collection
	
	var $pos : Integer
	var $o : Object
	var $found : Collection
	
	Case of 
			
			//______________________________________________________
		: (Length:C16($tring)=0)
			
			This:C1470.getSources()
			$result:=This:C1470.sources
			
			//______________________________________________________
		: ($tring="$@")
			
			$found:=Form:C1466.list.query("folder = '_'")
			
			If (Length:C16($tring)>1)
				
				$found:=$found.query("name = :1 OR folder = :1 or desc = :1 or shortcut = :1"; "@"+Delete string:C232($tring; 1; 1)+"@")
				
				// Assign a ranking with fewer points the farther from the beginning of the chain.
				For each ($o; $found)
					
					If (OB Is shared:C1759($o))
						
						$o:=OB Copy:C1225($o)
						
					End if 
					
					$o.rank:=0
					
					$pos:=Position:C15($tring; String:C10($o.shortcut))
					
					If ($pos>0)
						
						$o.rank:=$o.rank+(1000-($pos*25))
						
					End if 
					
					$pos:=Position:C15($tring; $o.name)
					
					If ($pos>0)
						
						$o.rank:=$o.rank+(400-($pos*20))
						
					End if 
					
					$pos:=Position:C15($tring; String:C10($o.desc))
					
					If ($pos>0)
						
						$o.rank:=$o.rank+(100-($pos*10))
						
					End if 
					
					$o.rank:=$o.rank+Choose:C955($o.name=$tring; 1000; 0)
					
					If ($o.type=-1)
						
						$o.rank:=$o.rank+(2000*Form:C1466.preferences.latestActions.indices("name = :1"; $o.name).length)
						
					End if 
				End for each 
				
				// Sort results by relevance.
				$result:=$found.orderBy("rank desc, name asc")
				
			Else 
				
				// Sort results by number of uses.
				For each ($o; $found)
					
					If (OB Is shared:C1759($o))
						
						$o:=OB Copy:C1225($o)
						
					End if 
					
					$o.rank:=2000*Form:C1466.preferences.latestActions.indices("name = :1"; $o.name).length
					
				End for each 
				
				$result:=$found.orderBy("rank desc, name asc")
				
			End if 
			
			//______________________________________________________
		Else 
			
			If (Form:C1466.list#Null:C1517)
				
				// Filter the list according to what is entered
				$found:=Form:C1466.list.query("name = :1 OR folder = :1 or desc = :1 or shortcut = :1"; "@"+$tring+"@")
				
				// Assign a ranking with fewer points the farther from the beginning of the chain.
				For each ($o; $found)
					
					If (OB Is shared:C1759($o))
						
						$o:=OB Copy:C1225($o)
						
					End if 
					
					$o.rank:=0
					
					$pos:=Position:C15($tring; $o.name)
					
					If ($pos>0)
						
						$o.rank+=(1000-($pos*25))
						
					End if 
					
					$pos:=Position:C15($tring; String:C10($o.folder))
					
					If ($pos>0)
						
						$o.rank+=(400-($pos*20))
						
					End if 
					
					$pos:=Position:C15($tring; String:C10($o.desc))
					
					If ($pos>0)
						
						$o.rank+=(100-($pos*10))
						
					End if 
					
					$o.rank+=Choose:C955($o.name=$tring; 1000; 0)
					
				End for each 
				
				// Sort results by relevance.
				$result:=$found.orderBy("rank desc, name asc")
				
			End if 
			
			//______________________________________________________
	End case 
	