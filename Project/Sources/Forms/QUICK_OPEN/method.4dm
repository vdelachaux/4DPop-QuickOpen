var $e : Object

$e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		// Set up the UI
		Form:C1466.resultList:=cs:C1710.listbox.new("results")
		Form:C1466.icon:=cs:C1710.static.new("currentIcon")
		Form:C1466.minimized:=cs:C1710.widget.new("search.border")
		Form:C1466.maximized:=cs:C1710.widget.new("list.border")
		Form:C1466.weWork:=cs:C1710.thermometer.new("weWork").start()
		
		var $file : 4D:C1709.File
		$file:=Folder:C1567(fk database folder:K87:14; *).file("Preferences/4dPop design.preferences")
		
		If ($file.exists)
			
			Form:C1466.preferences:=JSON Parse:C1218($file.getText())
			Form:C1466.search:=Form:C1466.preferences.lastSearch
			
		Else 
			
			// First use
			Form:C1466.preferences:=New object:C1471("lastSearch"; "")
			
		End if 
		
		//______________________________________________________
	: ($e.code=On After Edit:K2:43)
		
		// Reset the selected item
		Form:C1466.preferences.selectedItem:=0
		
		// Keep the current serch string
		Form:C1466.preferences.lastSearch:=Get edited text:C655
		
		// Launch the search
		Form:C1466.quickOpen.search(Form:C1466.preferences.lastSearch)
		
		//______________________________________________________
	: ($e.code=On Double Clicked:K2:5)\
		 & ($e.objectName="results")
		
		If (Macintosh option down:C545 | Windows Alt down:C563)
			
			// Open/create the doc
			Form:C1466.current.target:="doc"
			
		End if 
		
		// Keep the current selected item
		Form:C1466.preferences.selectedItem:=Form:C1466.index
		
		// Open/Edit
		Form:C1466.quickOpen.open(Form:C1466.current)
		
		//______________________________________________________
	: ($e.code=On Clicked:K2:4)
		
		Case of 
				
				//…………………………………………………………………
			: ($e.objectName="results")
				
				If (Contextual click:C713)
					
					If (Form:C1466.current#Null:C1517)
						
						// Display the contextual menu
						Form:C1466.quickOpen.menu(Form:C1466.current)
						
					End if 
				End if 
				
				//…………………………………………………………………
			: ($e.objectName="edit")  // Edit form or method
				
				Form:C1466.quickOpen.open(Form:C1466.current)
				
				//…………………………………………………………………
			: ($e.objectName="openDoc")  // Open/create the doc
				
				Form:C1466.current.target:="doc"
				Form:C1466.quickOpen.open(Form:C1466.current)
				
				//…………………………………………………………………
			: ($e.objectName="clear")  // Clear the search field
				
				Form:C1466.quickOpen.search("")
				
				//…………………………………………………………………
			: ($e.objectName="upArrow")
				
				If ((Form:C1466.index>1)\
					 & (Form:C1466.index<=Form:C1466.result.length))
					
					Form:C1466.resultList.select(Form:C1466.index-1)
					
				End if 
				
				//…………………………………………………………………
			: ($e.objectName="downArrow")
				
				If ((Form:C1466.index>=0)\
					 & (Form:C1466.index<Form:C1466.result.length))
					
					Form:C1466.resultList.select(Form:C1466.index+1)
					
				End if 
				
				//…………………………………………………………………
			: ($e.objectName="close")  // Close the dialog
				
				Form:C1466.quickOpen.close()
				
				//…………………………………………………………………
		End case 
		
		// Keep the current selected item
		Form:C1466.preferences.selectedItem:=Form:C1466.index
		
		//________________________________________
End case 