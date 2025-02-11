Class extends design

property commands:=[]

Class constructor()
	
	Super:C1705()
	
	var $icon : Picture
	
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/objectsIcons/Icon_604.png").platformPath; $icon)
	This:C1470.paths.push({\
		type: -1; \
		comment: "embedded action"; \
		icon: $icon; \
		folder: "_"; \
		desc: "action"})
	
	This:C1470._loadActions()
	
	//-----------------------------------------------------------
Function _loadActions()
	
	var $o : Object:=JSON Parse:C1218(File:C1566("/RESOURCES/quickOpen.json").getText())
	$o:=JSON Resolve pointers:C1478($o; {merge: True:C214})
	
	If ($o.success)
		
		var $tmpl : Object:=This:C1470.paths.query("type = :1"; -1).first()
		
		For each ($o; $o.value.actions)
			
			If ($o.condition#Null:C1517 ? Formula from string:C1601($o.condition).call() : True:C214)
				
				// Localize
				var $t:=Localized string:C991(String:C10($o.name))
				$o.name:=Bool:C1537(OK) ? $t : $o.name
				
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
Function search($string : Text)
	
	var $toMaximize; $toMinimize : Boolean
	var $bottom; $left; $right; $top : Integer
	
	If (Count parameters:C259>=1)
		
		Form:C1466.search:=$string
		
	End if 
	
	// Makes sure the window is expanded if at least 3 characters are entered
	Case of 
			
			// ………………………………………………………………………………………………………………………
		: (Length:C16(Form:C1466.search)=0)\
			 & (Form:C1466.isMaximized)
			
			$toMinimize:=True:C214  // Zero character & maximized -> Needs to be minimized
			
			// ………………………………………………………………………………………………………………………
		: ((Length:C16(Form:C1466.search)>=3)\
			 | (Character code:C91(Form:C1466.search)=At sign:K15:46)\
			 | (Form:C1466.search="$@"))\
			 & (Not:C34(Form:C1466.isMaximized))
			
			$toMaximize:=True:C214  // At least 3 characters or "@" & minimized -> Needs to be maximized
			
			// ………………………………………………………………………………………………………………………
		: (Length:C16(Form:C1466.search)<3)\
			 & (Form:C1466.isMaximized)
			
			$toMinimize:=(Form:C1466.search#"$@")  // Less than 3 characters & maximized -> Needs to be minimized
			
			// ………………………………………………………………………………………………………………………
	End case 
	
	Case of 
			
			// ………………………………………………………………………………………………………………………
		: ($toMaximize)
			
			GET WINDOW RECT:C443($left; $top; $right; $bottom)
			SET WINDOW RECT:C444($left; $top; $right; $bottom+(Form:C1466.maximized.coordinates.bottom-Form:C1466.minimized.coordinates.bottom))
			
			Form:C1466.minimized.hide()
			Form:C1466.maximized.show(Is macOS:C1572)
			
			Form:C1466.isMaximized:=True:C214
			
			// ………………………………………………………………………………………………………………………
		: ($toMinimize)
			
			GET WINDOW RECT:C443($left; $top; $right; $bottom)
			SET WINDOW RECT:C444($left; $top; $right; $bottom-(Form:C1466.maximized.coordinates.bottom-Form:C1466.minimized.coordinates.bottom))
			
			Form:C1466.maximized.hide()
			Form:C1466.minimized.show(Is macOS:C1572)
			
			Form:C1466.isMaximized:=False:C215
			
			// ………………………………………………………………………………………………………………………
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
	
	If ($item=Null:C1517)  // Make sure an item is selected
		
		return 
		
	End if 
	
	Form:C1466.preferences.lastItem:={name: $item.name}
	
	Case of 
			
			//______________________________________________________
		: ($item.type=-1)
			
			// Include in the list of the last used to allow the most used to be presented first
			Form:C1466.preferences.latestActions.insert(0; {name: $item.name})
			
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
	
	//======================================================================================
Function show($item : Object; $editDoc : Boolean)
	
	If ($item=Null:C1517)  // Make sure an item is selected
		
		return 
		
	End if 
	
	If (Count parameters:C259>=2)
		
		var $doc:=$editDoc
		
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
	
	//======================================================================================
	// Propose a contextual menu with more actions
Function menu($item : Object)
	
	If ($item=Null:C1517)  // Make sure an item is selected
		
		return 
		
	End if 
	
	var $menu:=cs:C1710.menu.new()\
		.append($item.type>0 ? ":xliff:edit" : ":xliff:execute"; "edit")
	
	If ($item.type>0)
		
		If ($item.type=Path project form:K72:3)\
			 | ($item.type=Path table form:K72:5)
			
			$menu.append(":xliff:editFormMethod"; "method")
			
		End if 
		
		$menu.append(Bool:C1537($item.doc.exists) ? ":xliff:editDocumentation" : ":xliff:createDocumentation"; "doc")\
			.append(":xliff:showSourceFile"; "showSource")\
			.append(":xliff:showDocumentationFile"; "showDoc").enable(Bool:C1537($item.doc.exists))\
			.line()\
			.append(":xliff:copyTheName"; "copy")\
			.line()\
			.append(":xliff:deleteSourceFile"; "deleteSource")
		
		If (Bool:C1537($item.doc.exists))
			
			$menu.append(":xliff:deleteDocumentation"; "deleteDoc")
			
		End if 
		
		If ($item.type=Path project form:K72:3)\
			 | ($item.type=Path table form:K72:5)
			
			$menu.append(":xliff:deleteFormMethod"; "deleteFormMethod")
			
		End if 
	End if 
	
	Case of 
			
			// ________________________________________
		: (Not:C34($menu.popup().selected))
			
			// <NOTHING MORE TO DO>
			
			// ________________________________________
		: ($menu.choice="edit")
			
			This:C1470.open($item)
			
			// ________________________________________
		: ($menu.choice="method")\
			 | ($menu.choice="doc")
			
			$item.target:=$menu.choice
			This:C1470.open($item)
			
			// ________________________________________
		: ($menu.choice="showSource")
			
			// Shows the file on disk
			This:C1470.show($item)
			
			// ________________________________________
		: ($menu.choice="showDoc")
			
			// Shows the documentation file on disk
			This:C1470.show($item; True:C214)
			
			// ________________________________________
		: ($menu.choice="copy")
			
			// Copies the name of the selected item to the clipboard.
			SET TEXT TO PASTEBOARD:C523($item.name)
			This:C1470.close()
			
			// ________________________________________
		: ($menu.choice="deleteSource")
			
			CONFIRM:C162(Replace string:C233(Replace string:C233(Localized string:C991("areYouSureYouWantToDeleteTheTypeItem"); "{type}"; $item.desc); "{item}"; $item.name); \
				Localized string:C991("delete"); \
				Localized string:C991("keepIt"))
			
			If (Bool:C1537(OK))
				
				This:C1470.delete($item)
				This:C1470.close()
				
			End if 
			
			// ________________________________________
		: ($menu.choice="deleteDoc")
			
			CONFIRM:C162(Replace string:C233(Replace string:C233(Localized string:C991("areYouSureYouWantToDeleteTheDocumentationForTypeItem"); "{type}"; $item.desc); "{item}"; $item.name); \
				Localized string:C991("delete"); \
				Localized string:C991("keepIt"))
			
			If (Bool:C1537(OK))
				
				This:C1470.deleteDoc($item)
				This:C1470.close()
				
			End if 
			
			// ________________________________________
		Else 
			
			ALERT:C41("We are going tout doux 🤣")
			
			// ________________________________________
	End case 
	
	//======================================================================================
Function close
	
	var $file : 4D:C1709.File:=Folder:C1567(fk database folder:K87:14; *).file("Preferences/4DPop design.preferences")
	$file.setText(JSON Stringify:C1217(Form:C1466.preferences; *))
	
	CANCEL:C270
	
	//======================================================================================
Function _search($string : Text) : Collection
	
	Case of 
			
			//______________________________________________________
		: (Length:C16($string)=0)
			
			This:C1470.getSources()
			return This:C1470.sources
			
			//______________________________________________________
		: ($string="$@")
			
			var $found : Collection:=Form:C1466.list.query("folder = '_'")
			
			If (Length:C16($string)>1)
				
				$found:=$found.query("name = :1 OR folder = :1 or desc = :1 or shortcut = :1"; "@"+Delete string:C232($string; 1; 1)+"@")
				
				// Assign a ranking with fewer points the farther from the beginning of the chain.
				var $o : Object
				
				For each ($o; $found)
					
					If (OB Is shared:C1759($o))
						
						$o:=OB Copy:C1225($o)
						
					End if 
					
					$o.rank:=0
					
					var $pos:=Position:C15($string; String:C10($o.shortcut))
					
					If ($pos>0)
						
						$o.rank+=1000-($pos*25)
						
					End if 
					
					$pos:=Position:C15($string; $o.name)
					
					If ($pos>0)
						
						$o.rank+=400-($pos*20)
						
					End if 
					
					$pos:=Position:C15($string; String:C10($o.desc))
					
					If ($pos>0)
						
						$o.rank+=100-($pos*10)
						
					End if 
					
					$o.rank+=$o.name=$string ? 1000 : 0
					
					If ($o.type=-1)
						
						$o.rank+=2000*Form:C1466.preferences.latestActions.indices("name = :1"; $o.name).length
						
					End if 
				End for each 
				
				// Sort results by relevance.
				return $found.orderBy("rank desc, name asc")
				
			End if 
			
			// Sort results by number of uses.
			For each ($o; $found)
				
				If (OB Is shared:C1759($o))
					
					$o:=OB Copy:C1225($o)
					
				End if 
				
				$o.rank:=2000*Form:C1466.preferences.latestActions.indices("name = :1"; $o.name).length
				
			End for each 
			
			return $found.orderBy("rank desc, name asc")
			
			//______________________________________________________
		Else 
			
			If (Form:C1466.list=Null:C1517)
				
				return 
				
			End if 
			
			// Filter the list according to what is entered
			$found:=Form:C1466.list.query("name = :1 OR folder = :1 or desc = :1 or shortcut = :1"; "@"+$string+"@")
			
			// Assign a ranking with fewer points the farther from the beginning of the chain.
			For each ($o; $found)
				
				If (OB Is shared:C1759($o))
					
					$o:=OB Copy:C1225($o)
					
				End if 
				
				$o.rank:=0
				
				$pos:=Position:C15($string; $o.name)
				
				If ($pos>0)
					
					$o.rank+=1000-($pos*25)
					
				End if 
				
				$pos:=Position:C15($string; String:C10($o.folder))
				
				If ($pos>0)
					
					$o.rank+=400-($pos*20)
					
				End if 
				
				$pos:=Position:C15($string; String:C10($o.desc))
				
				If ($pos>0)
					
					$o.rank+=100-($pos*10)
					
				End if 
				
				$o.rank+=$o.name=$string ? 1000 : 0
				
			End for each 
			
			// Sort results by relevance.
			return $found.orderBy("rank desc, name asc")
			
			//______________________________________________________
	End case 
	