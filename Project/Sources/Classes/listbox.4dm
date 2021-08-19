Class extends scrollable

//________________________________________________________________
Class constructor
	C_TEXT:C284($1)
	C_VARIANT:C1683($2)
	
	If (Count parameters:C259>=2)
		
		Super:C1705($1; $2)
		
	Else 
		
		Super:C1705($1)
		
	End if 
	
	ASSERT:C1129(This:C1470.type=Object type listbox:K79:8)
	
	//________________________________________________________________
Function getCoordinates
	
	Super:C1706.getCoordinates()
	This:C1470.getScrollbars()
	This:C1470.updateDefinition()
	This:C1470.getCell()
	
	//________________________________________________________________
	// Select row(s)
Function select($row : Integer)->$this : cs:C1710.listbox
	
	If (Count parameters:C259=0)
		
		// Select all rows
		LISTBOX SELECT ROW:C912(*; This:C1470.name; 0; lk replace selection:K53:1)
		
	Else 
		
		// #TO_DO: use a collection for multiple selection
		LISTBOX SELECT ROW:C912(*; This:C1470.name; $row; lk replace selection:K53:1)
		
	End if 
	
	This:C1470.setScrollPosition($row)
	
	$this:=This:C1470
	
	//________________________________________________________________
	// Unselect row(s)
Function unselect($row : Integer)->$this : cs:C1710.listbox
	
	If (Count parameters:C259=0)
		
		// Unselect all rows
		LISTBOX SELECT ROW:C912(*; This:C1470.name; 0; lk remove from selection:K53:3)
		
	Else 
		
		// #TO_DO: use a collection for multiple selection
		LISTBOX SELECT ROW:C912(*; This:C1470.name; $row; lk remove from selection:K53:3)
		
	End if 
	
	$this:=This:C1470
	
	//________________________________________________________________
	// Gives the number of selected rows
Function selectedNumber()->$count : Integer
	
	$count:=Count in array:C907((This:C1470.pointer())->; True:C214)
	
	//________________________________________________________________
	// Gives the number of columns
Function columnsNumber()->$count : Integer
	
	$count:=LISTBOX Get number of columns:C831(*; This:C1470.name)
	
	//________________________________________________________________
	// Gives the number of rows
Function rowsNumber()->$count : Integer
	
	$count:=LISTBOX Get number of rows:C915(*; This:C1470.name)
	
	//________________________________________________________________
	// Reveal the row
Function reveal($row : Integer)->$this : cs:C1710.listbox
	
	LISTBOX SELECT ROW:C912(*; This:C1470.name; $row; lk replace selection:K53:1)
	OBJECT SET SCROLL POSITION:C906(*; This:C1470.name; $row)
	
	$this:=This:C1470
	
	//________________________________________________________________
	// Update the listbox columns/rows definition
Function updateDefinition()->$this : cs:C1710.listbox
	
	var $i : Integer
	
	ARRAY BOOLEAN:C223($areVisible; 0x0000)
	ARRAY POINTER:C280($columnsPtr; 0x0000)
	ARRAY POINTER:C280($footersPtr; 0x0000)
	ARRAY POINTER:C280($headersPtr; 0x0000)
	ARRAY POINTER:C280($stylesPtr; 0x0000)
	ARRAY TEXT:C222($columnNames; 0x0000)
	ARRAY TEXT:C222($footerNames; 0x0000)
	ARRAY TEXT:C222($headerNames; 0x0000)
	
	LISTBOX GET ARRAYS:C832(*; This:C1470.name; \
		$columnNames; $headerNames; \
		$columnsPtr; $headersPtr; \
		$areVisible; \
		$stylesPtr; \
		$footerNames; $footersPtr)
	
	This:C1470.definition:=New collection:C1472
	
	ARRAY TO COLLECTION:C1563(This:C1470.definition; \
		$columnNames; "names"; \
		$headerNames; "headers"; \
		$footerNames; "footers")
	
	This:C1470.columns:=New object:C1471
	
	For ($i; 1; Size of array:C274($columnNames); 1)
		
		This:C1470.columns[$columnNames{$i}]:=New object:C1471(\
			"number"; $i; \
			"pointer"; $columnsPtr{$i})
		
	End for 
	
	This:C1470.getScrollbars()
	
	$this:=This:C1470
	
	//________________________________________________________________
	// Update the current cell ondexes and coordinates
Function updateCell()->$this : cs:C1710.listbox
	
	This:C1470.cellPosition()
	This:C1470.cellCoordinates()
	
	$this:=This:C1470
	
	//________________________________________________________________
	// Current cell indexes {column,row}
Function cellPosition($event : Object)->$position : Object
	
	var $_; $column; $row; $x; $y : Integer
	var $e; $event : Object
	
	$e:=Choose:C955(Count parameters:C259>=1; $event; FORM Event:C1606)
	
	If ($e.code=On Clicked:K2:4)\
		 | ($e.code=On Double Clicked:K2:5)
		
		LISTBOX GET CELL POSITION:C971(*; This:C1470.name; $column; $row)
		
	Else 
		
		GET MOUSE:C468($x; $y; $_)
		LISTBOX GET CELL POSITION:C971(*; This:C1470.name; $x; $y; $column; $row)
		
	End if 
	
	$position:=New object:C1471(\
		"column"; $column; \
		"row"; $row)
	
	//________________________________________________________________
Function cellCoordinates($column : Integer; $row : Integer)->$coordinates : Object
	
	var $bottom; $left; $right; $top : Integer
	var $columnƒ; $rowƒ : Integer
	var $e : Object
	
	If (Count parameters:C259=0)
		
		$e:=FORM Event:C1606
		
		If ($e.column#Null:C1517)
			
			$columnƒ:=$e.column
			$rowƒ:=$e.row
			
		Else 
			
			// A "If" statement should never omit "Else"
			
		End if 
		
	Else 
		
		$columnƒ:=$column
		$rowƒ:=$row
		
	End if 
	
	LISTBOX GET CELL COORDINATES:C1330(*; This:C1470.name; $columnƒ; $rowƒ; $left; $top; $right; $bottom)
	
	If (This:C1470.cellBox=Null:C1517)
		
		This:C1470.cellBox:=New object:C1471(\
			"left"; $left; \
			"top"; $top; \
			"right"; $right; \
			"bottom"; $bottom)
		
	Else 
		
		This:C1470.cellBox.left:=$left
		This:C1470.cellBox.top:=$top
		This:C1470.cellBox.right:=$right
		This:C1470.cellBox.bottom:=$bottom
		
	End if 
	
	$coordinates:=This:C1470.cellBox
	
	//________________________________________________________________
	// Displays a cs.menu at the bottom left of the current cell
Function popup($menu : cs:C1710.menu; $default : Text)->$choice : cs:C1710.menu
	
	var $bottom; $left : Integer
	
	This:C1470.cellCoordinates()
	
	$left:=This:C1470.cellBox.left
	$bottom:=This:C1470.cellBox.bottom
	
	CONVERT COORDINATES:C1365($left; $bottom; XY Current form:K27:5; XY Current window:K27:6)
	
	If (Count parameters:C259=1)
		
		$menu.popup(""; $left; $bottom)
		
	Else 
		
		$menu.popup($default; $left; $bottom)
		
	End if 
	
	$choice:=$menu
	
	//________________________________________________________________
Function clear()->$this : cs:C1710.listbox
	
	var $o : Object
	
	This:C1470.updateDefinition()
	
	For each ($o; This:C1470.definition)
		
		CLEAR VARIABLE:C89(OBJECT Get pointer:C1124(Object named:K67:5; $o.names)->)
		
	End for each 
	
	$this:=This:C1470
	
	//________________________________________________________________
Function deleteRow($row : Integer)->$this : cs:C1710.listbox
	
	
	If (Count parameters:C259=0)
		
		// Delete all rowsLISTBOX DELETE ROWS(*; This.name; 1; This.rowsNumber())
		LISTBOX SELECT ROW:C912(*; This:C1470.name; 0; lk remove from selection:K53:3)
		
	Else 
		
		// #TO_DO: use a collection for multiple delrtion
		LISTBOX DELETE ROWS:C914(*; This:C1470.name; $row; 1)
		
	End if 
	
	$this:=This:C1470
	
	//________________________________________________________________
	// Returns all properties of the column or listbox
Function getProperties($column : Text)->$properties : Object
	
	var $target : Text
	
	If (Count parameters:C259>=1)
		
		$target:=$column
		
	Else 
		
		$target:=This:C1470.name
		
	End if 
	
	$properties:=New object:C1471(\
		"allowWordwrap"; LISTBOX Get property:C917(*; $target; lk allow wordwrap:K53:39); \
		"autoRowHeight"; LISTBOX Get property:C917(*; $target; lk auto row height:K53:72); \
		"backgroundColorExpression"; LISTBOX Get property:C917(*; $target; lk background color expression:K53:47); \
		"columnMinWidth"; LISTBOX Get property:C917(*; $target; lk column min width:K53:50); \
		"columnResizable"; LISTBOX Get property:C917(*; $target; lk column resizable:K53:40); \
		"detailFormName"; LISTBOX Get property:C917(*; $target; lk detail form name:K53:44); \
		"displayFooter"; LISTBOX Get property:C917(*; $target; lk display footer:K53:20); \
		"displayHeader"; LISTBOX Get property:C917(*; $target; lk display header:K53:4); \
		"displayType"; LISTBOX Get property:C917(*; $target; lk display type:K53:46); \
		"doubleClickOnRow"; LISTBOX Get property:C917(*; $target; lk double click on row:K53:43); \
		"extraRows"; LISTBOX Get property:C917(*; $target; lk extra rows:K53:38); \
		"fontColorExpression"; LISTBOX Get property:C917(*; $target; lk font color expression:K53:48); \
		"fontStyleExpression"; LISTBOX Get property:C917(*; $target; lk font style expression:K53:49); \
		"hideSelectionHighlight"; LISTBOX Get property:C917(*; $target; lk hide selection highlight:K53:41); \
		"highlightSet"; LISTBOX Get property:C917(*; $target; lk highlight set:K53:66); \
		"horScrollbarHeight"; LISTBOX Get property:C917(*; $target; lk hor scrollbar height:K53:7); \
		"multiStyle"; LISTBOX Get property:C917(*; $target; lk multi style:K53:71); \
		"namedSelection"; LISTBOX Get property:C917(*; $target; lk named selection:K53:67); \
		"resizingMode"; LISTBOX Get property:C917(*; $target; lk resizing mode:K53:36); \
		"rowHeightUnit"; LISTBOX Get property:C917(*; $target; lk row height unit:K53:42); \
		"selectionMode"; LISTBOX Get property:C917(*; $target; lk selection mode:K53:35); \
		"singleClickEdit"; LISTBOX Get property:C917(*; $target; lk single click edit:K53:70); \
		"sortable"; LISTBOX Get property:C917(*; $target; lk sortable:K53:45); \
		"truncate"; LISTBOX Get property:C917(*; $target; lk truncate:K53:37); \
		"verScrollbarWidth"; LISTBOX Get property:C917(*; $target; lk ver scrollbar width:K53:9)\
		)
	
	//________________________________________________________________
Function getProperty($property : Integer; $column : Text)->$value : Variant
	
	If (Count parameters:C259=0)
		
		$value:=LISTBOX Get property:C917(*; This:C1470.name; $property)
		
	Else 
		
		$value:=LISTBOX Get property:C917(*; $column; $property)
		
	End if 
	
	//________________________________________________________________
Function setProperty($property : Integer; $value)->$this : cs:C1710.listbox
	
	LISTBOX SET PROPERTY:C1440(*; This:C1470.name; $property; $value)
	
	$this:=This:C1470