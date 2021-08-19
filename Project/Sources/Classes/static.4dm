/*

Static objects are generally used for setting the appearance of the form and its 
labels as well as for the graphic interface.Static objects do not have 
associated variables like active objects.

            ╔══════════════════════════════════════════════╗
            ║ This is the parent class of all form objects ║
            ╚══════════════════════════════════════════════╝

                                ┏━━━━━━━━┓           ┏━━━━━━━━━┓
                             ┏━━┫ button ┃        ┏━━┫ picture ┃
                             ┃  ┗━━━━━━━━┛        ┃  ┗━━━━━━━━━┛
┏━━━━━━━━┓⁢⁢⁢⁢⁣     ┏━━━━━━━━┓    ┃  ┏━━━━━━━━━━━━┓    ┃  ┏━━━━━━━━━┓
┃ static ┣━━┳━━┫ widget ┣━━━━╋━━┫ scrollable ┣━━━━╋━━┫ listbox ┃
┗━━━━━━━━┛  ┃  ┗━━━━━━━━┛    ┃  ┗━━━━━━━━━━━━┛    ┃  ┗━━━━━━━━━┛
            ┃  ┏━━━━━━━━━┓   ┃  ┏━━━━━━━━━━┓      ┃  ┏━━━━━━━━━┓
            ┗━━┫ webArea ┃   ┣━━┫ progress ┃      ┗━━┫ subform ┃
               ┗━━━━━━━━━┛   ┃  ┗━━━━━━━━━━┛         ┗━━━━━━━━━┛
                             ┃  ┏━━━━━━━┓
                             ┣━━┫ input ┃
                             ┃  ┗━━━━━━━┛
                             ┃  ┏━━━━━━━━━┓
                             ┣━━┫ stepper ┃
                             ┃  ┗━━━━━━━━━┛
                             ┃  ┏━━━━━━━━━━━━━┓
                             ┗━━┫ thermometer ┃
                                ┗━━━━━━━━━━━━━┛
*/

Class constructor
	var $1 : Text
	
	If (Count parameters:C259>=1)
		
		This:C1470.name:=$1
		
	Else 
		
		// Called from the widget method
		This:C1470.name:=OBJECT Get name:C1087(Object current:K67:2)
		
	End if 
	
	This:C1470.type:=OBJECT Get type:C1300(*; This:C1470.name)
	
	If (Asserted:C1132(This:C1470.type#0; Current method name:C684+": No objects found named \""+This:C1470.name+"\""))
		
		This:C1470._updateCoordinates()
		
	End if 
	
/*════════════════════════════════════════════
.hide() -> This
══════════════════════════*/
Function hide
	var $0 : Object
	
	OBJECT SET VISIBLE:C603(*; This:C1470.name; False:C215)
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.show() -> This
.show(bool) -> This
══════════════════════════*/
Function show
	var $0 : Object
	var $1 : Boolean
	
	If (Count parameters:C259>=1)
		
		If ($1)
			
			OBJECT SET VISIBLE:C603(*; This:C1470.name; True:C214)
			
		Else 
			
			OBJECT SET VISIBLE:C603(*; This:C1470.name; False:C215)
			
		End if 
		
	Else 
		
		OBJECT SET VISIBLE:C603(*; This:C1470.name; True:C214)
		
	End if 
	
	$0:=This:C1470
	
/*════════════════════════════════════════════*/
Function getVisible
	var $0 : Boolean
	
	$0:=OBJECT Get visible:C1075(*; This:C1470.name)
	
/*════════════════════════════════════════════
.enable() -> This
.enable(bool) -> This
══════════════════════════*/
Function enable
	var $0 : Object
	var $1 : Boolean
	
	If (Count parameters:C259>=1)
		
		If ($1)
			
			OBJECT SET ENABLED:C1123(*; This:C1470.name; True:C214)
			
		Else 
			
			OBJECT SET ENABLED:C1123(*; This:C1470.name; False:C215)
			
		End if 
		
	Else 
		
		OBJECT SET ENABLED:C1123(*; This:C1470.name; True:C214)
		
	End if 
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.disable() -> This
══════════════════════════*/
Function disable
	var $0 : Object
	
	OBJECT SET ENABLED:C1123(*; This:C1470.name; False:C215)
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.setTitle(text) -> This
══════════════════════════*/
Function setTitle
	var $0 : Object
	var $1 : Text
	
	var $t : Text
	
	If (Count parameters:C259>=1)
		
		$t:=Get localized string:C991($1)
		$t:=Choose:C955(Length:C16($t)>0; $t; $1)  // Revert if no localization
		
	End if 
	
	OBJECT SET TITLE:C194(*; This:C1470.name; $t)
	
	$0:=This:C1470
	
	// ════════════════════════════════════════════
Function fontStyle($style : Integer)->$this : Object
	
	If (Count parameters:C259>=1)
		
		OBJECT SET FONT STYLE:C166(*; This:C1470.name; $style)
		
	Else 
		
		OBJECT SET FONT STYLE:C166(*; This:C1470.name; Plain:K14:1)
		
	End if 
	
	$this:=This:C1470
	
/*════════════════════════════════════════════
.getTitle() -> text
══════════════════════════*/
Function getTitle
	var $0 : Text
	
	$0:=OBJECT Get title:C1068(*; This:C1470.name)
	
/*════════════════════════════════════════════
.setCoordinates (left;top;right;bottom) -> This
.setCoordinates (obj) -> This
  obj = {"left":int,"top":int,"right":int,"bottom":int}
══════════════════════════*/
Function setCoordinates
	var $0 : Object
	var $1 : Variant
	var $2 : Integer
	var $3 : Integer
	var $4 : Integer
	
	var $o : Object
	
	If (Value type:C1509($1)=Is object:K8:27)
		
		$o:=New object:C1471(\
			"left"; Num:C11($1.left); \
			"top"; Num:C11($1.top); \
			"right"; Num:C11($1.right); \
			"bottom"; Num:C11($1.bottom))
		
	Else 
		
		$o:=New object:C1471(\
			"left"; Num:C11($1); \
			"top"; Num:C11($2); \
			"right"; Num:C11($3); \
			"bottom"; Num:C11($4))
		
	End if 
	
	OBJECT SET COORDINATES:C1248(*; This:C1470.name; $o.left; $o.top; $o.right; $o.bottom)
	
	This:C1470._updateCoordinates($o.left; $o.top; $o.right; $o.bottom)
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.getCoordinates() -> obj 
  obj = {"left":int,"top":int,"right":int,"bottom":int})
══════════════════════════*/
Function getCoordinates
	var $0 : Object
	
	var $bottom; $left; $right; $top : Integer
	
	OBJECT GET COORDINATES:C663(*; This:C1470.name; $left; $top; $right; $bottom)
	This:C1470._updateCoordinates($left; $top; $right; $bottom)
	
	$0:=This:C1470.coordinates
	
/*════════════════════════════════════════════
.bestSize(obj) -> This
  obj = {"alignment":int,"min":int,"max:int}}
	
.bestSize({alignment{;min{;max}}}) -> This
══════════════════════════*/
Function bestSize
	var $0 : Object
	var $1 : Variant
	var $2 : Integer
	var $3 : Integer
	
	var $bottom; $height; $left; $right; $top; $width : Integer
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		If (Value type:C1509($1)=Is object:K8:27)
			
			$o:=$1
			
			If ($o.alignment=Null:C1517)
				
				$o.alignment:=Align left:K42:2
				
			End if 
			
		Else 
			
			$o:=New object:C1471
			
			$o.alignment:=$1
			
			If (Count parameters:C259>=2)
				
				$o.min:=$2
				
				If (Count parameters:C259>=3)
					
					$o.max:=$3
					
				End if 
			End if 
		End if 
		
	Else 
		
		$o:=New object:C1471(\
			"alignment"; Align left:K42:2)
		
	End if 
	
	OBJECT GET COORDINATES:C663(*; This:C1470.name; $left; $top; $right; $bottom)
	
	If ($o.max#Null:C1517)
		
		OBJECT GET BEST SIZE:C717(*; This:C1470.name; $width; $height; $o.max)
		
	Else 
		
		OBJECT GET BEST SIZE:C717(*; This:C1470.name; $width; $height)
		
	End if 
	
	Case of 
			
			//______________________________
		: (This:C1470.type=Object type static text:K79:2)\
			 | (This:C1470.type=Object type checkbox:K79:26)
			
			If (Num:C11($o.alignment)=Align left:K42:2)
				
				// Add 10 pixels
				$width:=$width+10
				
			End if 
			
			//______________________________
		: (This:C1470.type=Object type push button:K79:16)
			
			// Add 10% for margins
			$width:=Round:C94($width*1.1; 0)
			
			//______________________________
		Else 
			
			// Add 10 pixels
			$width:=$width+10
			
			//______________________________
	End case 
	
	If ($o.min#Null:C1517)
		
		$width:=Choose:C955($width<$o.min; $o.min; $width)
		
	End if 
	
	If ($o.alignment=Align right:K42:4)
		
		$left:=$right-$width
		
	Else 
		
		// Default is Align left
		$right:=$left+$width
		
	End if 
	
	OBJECT SET COORDINATES:C1248(*; This:C1470.name; $left; $top; $right; $bottom)
	This:C1470._updateCoordinates($left; $top; $right; $bottom)
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.moveHorizontally(int) -> This
══════════════════════════*/
Function moveHorizontally
	var $0 : Object
	var $1 : Integer
	
	var $bottom; $left; $right; $top : Integer
	
	OBJECT GET COORDINATES:C663(*; This:C1470.name; $left; $top; $right; $bottom)
	
	$left:=$left+$1
	$right:=$right+$1
	
	This:C1470.setCoordinates(New object:C1471(\
		"left"; $left; \
		"top"; $top; \
		"right"; $right; \
		"bottom"; $bottom))
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.moveVertically(int) -> This
══════════════════════════*/
Function moveVertically
	var $0 : Object
	var $1 : Integer
	
	var $bottom; $left; $right; $top : Integer
	
	OBJECT GET COORDINATES:C663(*; This:C1470.name; $left; $top; $right; $bottom)
	
	$top:=$top+$1
	$bottom:=$bottom+$1
	
	This:C1470.setCoordinates(New object:C1471(\
		"left"; $left; \
		"top"; $top; \
		"right"; $right; \
		"bottom"; $bottom))
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.resizeHorizontally(int) -> This
══════════════════════════*/
Function resizeHorizontally
	var $0 : Object
	var $1 : Integer
	
	var $bottom; $left; $right; $top : Integer
	
	OBJECT GET COORDINATES:C663(*; This:C1470.name; $left; $top; $right; $bottom)
	
	$right:=$right+$1
	
	This:C1470.setCoordinates(New object:C1471(\
		"left"; $left; \
		"top"; $top; \
		"right"; $right; \
		"bottom"; $bottom))
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.resizeVertically(int) -> This
══════════════════════════*/
Function resizeVertically
	var $0 : Object
	var $1 : Integer
	
	var $bottom; $left; $right; $top : Integer
	
	OBJECT GET COORDINATES:C663(*; This:C1470.name; $left; $top; $right; $bottom)
	
	$bottom:=$bottom+$1
	
	This:C1470.setCoordinates(New object:C1471(\
		"left"; $left; \
		"top"; $top; \
		"right"; $right; \
		"bottom"; $bottom))
	
	$0:=This:C1470
	
/*════════════════════════════════════════════
.setDimension(width {; height}) -> This
══════════════════════════*/
Function setDimension
	var $0 : Object
	var $1 : Integer
	var $2 : Integer
	
	var $o : Object
	
	$o:=This:C1470.getCoordinates()
	$o.right:=$o.left+$1
	
	If (Count parameters:C259>=2)
		
		$o.bottom:=$o.top+$2
		
	End if 
	
	OBJECT SET COORDINATES:C1248(*; This:C1470.name; $o.left; $o.top; $o.right; $o.bottom)
	This:C1470._updateCoordinates($o.left; $o.top; $o.right; $o.bottom)
	
	$0:=This:C1470
	
Function setColors($foreground : Variant; $background : Variant; $altBackground : Variant)->$this : cs:C1710.static
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259>=3)
			
			$foreground:=Choose:C955(Value type:C1509($foreground)=Is text:K8:3; $foreground; Num:C11($foreground))
			$background:=Choose:C955(Value type:C1509($background)=Is text:K8:3; $background; Num:C11($background))
			$altBackground:=Choose:C955(Value type:C1509($altBackground)=Is text:K8:3; $altBackground; Num:C11($altBackground))
			
			OBJECT SET RGB COLORS:C628(*; This:C1470.name; $foreground; $background; $altBackground)
			
			//______________________________________________________
		: (Count parameters:C259>=2)
			
			$foreground:=Choose:C955(Value type:C1509($foreground)=Is text:K8:3; $foreground; Num:C11($foreground))
			$background:=Choose:C955(Value type:C1509($background)=Is text:K8:3; $background; Num:C11($background))
			
			OBJECT SET RGB COLORS:C628(*; This:C1470.name; $foreground; $background)
			
			//______________________________________________________
		: (Count parameters:C259>=1)
			
			$foreground:=Choose:C955(Value type:C1509($foreground)=Is text:K8:3; $foreground; Num:C11($foreground))
			
			OBJECT SET RGB COLORS:C628(*; This:C1470.name; $foreground)
			
			//______________________________________________________
		Else 
			
			// #ERROR
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
/*════════════════════════════════════════════*/
Function _updateCoordinates
	var $0 : Object
	var $1 : Integer
	var $2 : Integer
	var $3 : Integer
	var $4 : Integer
	
	var $bottom; $left; $right; $top : Integer
	
	If (Count parameters:C259>=4)
		
		$left:=$1
		$top:=$2
		$right:=$3
		$bottom:=$4
		
	Else 
		
		OBJECT GET COORDINATES:C663(*; This:C1470.name; $left; $top; $right; $bottom)
		
	End if 
	
	This:C1470.coordinates:=New object:C1471(\
		"left"; $left; \
		"top"; $top; \
		"right"; $right; \
		"bottom"; $bottom)
	
	This:C1470.dimensions:=New object:C1471(\
		"width"; $right-$left; \
		"height"; $bottom-$top)
	
	CONVERT COORDINATES:C1365($left; $top; XY Current form:K27:5; XY Current window:K27:6)
	CONVERT COORDINATES:C1365($right; $bottom; XY Current form:K27:5; XY Current window:K27:6)
	
	This:C1470.windowCoordinates:=New object:C1471(\
		"left"; $left; \
		"top"; $top; \
		"right"; $right; \
		"bottom"; $bottom)
	
	$0:=This:C1470
	
/*════════════════════════════════════════════*/