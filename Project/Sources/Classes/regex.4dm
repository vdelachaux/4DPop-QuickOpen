Class constructor($target; $pattern : Text)
	
	This:C1470.target:=""
	This:C1470.pattern:=""
	This:C1470.success:=True:C214
	This:C1470.matches:=Null:C1517
	
	If (Count parameters:C259>=1)
		
		This:C1470.setTarget($target)
		
		If (Count parameters:C259>=2)
			
			This:C1470.setPattern($pattern)
			
		End if 
	End if 
	
	// ----------------------------------------------------
	// Sets the string where will be perform the search.
	// Could be a text or a disk file
Function setTarget($target)->$this : cs:C1710.regex
	
	Case of 
			
			//…………………………………………………………………………………………
		: (Value type:C1509($target)=Is text:K8:3)
			
			This:C1470.target:=$target
			
			//…………………………………………………………………………………………
		: (Value type:C1509($target)=Is object:K8:27)
			
			If (OB Class:C1730($target).name="File")
				
				If ($target.exists)
					
					This:C1470.target:=$target.getText()
					
				Else 
					
					ASSERT:C1129(False:C215; "file not found")
					
				End if 
				
			Else 
				
				ASSERT:C1129(False:C215; "target is not a 4D File")
				
			End if 
			
			//…………………………………………………………………………………………
		Else 
			
			ASSERT:C1129(False:C215; "target must be text or file")
			
			//…………………………………………………………………………………………
	End case 
	
	$this:=This:C1470
	
	// ----------------------------------------------------
	// Sets the regular expression to use.
Function setPattern($pattern : Text)->$this : cs:C1710.regex
	
	This:C1470.pattern:=$pattern
	
	$this:=This:C1470
	
	// ----------------------------------------------------
Function match($start; $all : Boolean)->$this : cs:C1710.regex
	
	var $match; $allƒ : Boolean
	var $i; $size; $startƒ : Integer
	var $item : Object
	var $currentMethodCalledOnError : Text
	
	ARRAY LONGINT:C221($positions; 0x0000)
	ARRAY LONGINT:C221($lengths; 0x0000)
	
	$startƒ:=1  // Start the search with the first character
	
	If (Count parameters:C259>=1)
		
		If (Value type:C1509($start)=Is boolean:K8:9)
			
			$allƒ:=$start
			
		Else 
			
			$startƒ:=Num:C11($start)
			
			If (Count parameters:C259>=2)
				
				$allƒ:=$all
				
			End if 
		End if 
	End if 
	
	This:C1470.success:=False:C215
	This:C1470.matches:=New collection:C1472
	
	$currentMethodCalledOnError:=This:C1470._errorCatch()
	
	Repeat 
		
		ERROR:=0
		
		$match:=Match regex:C1019(This:C1470.pattern; This:C1470.target; $startƒ; $positions; $lengths)
		
		If (ERROR=0)
			
			If ($match)
				
				This:C1470.success:=True:C214
				
				For ($i; 0; Size of array:C274($positions); 1)
					
					$item:=New object:C1471(\
						"data"; Substring:C12(This:C1470.target; $positions{$i}; $lengths{$i}); \
						"position"; $positions{$i}; \
						"length"; $lengths{$i})
					
					If ($lengths{$i}=0)
						
						$match:=($i>0)
						
						If ($match)
							
							$match:=($positions{$i}#$positions{$i-1})
							
						End if 
					End if 
					
					This:C1470.matches.push($item)
					
					If ($positions{$i}>0)
						
						$startƒ:=$positions{$i}+$lengths{$i}
						
					End if 
				End for 
				
				$match:=$allƒ  // Stop after the first match ?
				
			End if 
			
		Else 
			
			This:C1470.error:=ERROR
			
		End if 
	Until (Not:C34($match))
	
	This:C1470._errorCatch($currentMethodCalledOnError)
	
	$this:=This:C1470
	
	//-----------------------------------------------------------
Function _errorCatch($onErrCallMethod : Text)->$currentOnErrCallMethod : Text
	
	If (Count parameters:C259>=1)
		
		ON ERR CALL:C155($onErrCallMethod)
		
	Else 
		
		$currentOnErrCallMethod:=Method called on error:C704
		ON ERR CALL:C155("noError")
		CLEAR VARIABLE:C89(ERROR)
		
	End if 