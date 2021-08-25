<!-- quickOpenEventHandler() -> $caught : Boolean -->

## Description

`quickOpenEventHandler` first tests the modifier, then the key and finally whether we are in design process. If all tests are satisfied, the quick open dialog is displayed.

## Syntax

`quickOpenEventHandler() ➞ Boolean`

## Usage

See the [complete documentation](https://github.com/vdelachaux/4DPop-QuickOpen/blob/master/README.md) 


### A - If you do not use an event-catching method

Create, if any, the database method On startup and enter this code:

```4d
If (Not(Is compiled mode))
	
	ARRAY TEXT($componentsArray; 0)
	COMPONENT LIST($componentsArray)
	
	If (Find in array($componentsArray; "4DPop QuickOpen")>0)
		
		// Installing quickOpen
		EXECUTE METHOD("quickOpenInit"; *; Formula(MODIFIERS); Formula(KEYCODE))
		ON EVENT CALL("quickOpenEventHandler"; "$quickOpenListener")
		
	End if 
End if
```


### B - If you already use an event-catching method

1 - Call the init method before installing your event-catching method. Something like:

```4d
ARRAY TEXT($componentsArray; 0)
COMPONENT LIST($componentsArray)

If (Find in array($componentsArray; "4DPop QuickOpen")>0)
	
	// Installing quickOpen
	EXECUTE METHOD("quickOpenInit"; *; Formula(MODIFIERS); Formula(KEYCODE))
	
End if 

ON EVENT CALL("MY_METHOD"; "$eventHandler")
```
 

2 - Modify your event-catching method like this:

```4d
var $quickOpen : Boolean

// Only in development mode
If (Not(Is compiled mode(*)))
	
	// Only if the component is loaded
	ARRAY TEXT($components; 0)
	COMPONENT LIST($components)
	
	If (Find in array($components; "4DPop QuickOpen")>0)
		
		// Is it a quickOpen call?
		EXECUTE METHOD("quickOpenEventHandler"; $quickOpen)
		
	End if 
End if 

If (Not($quickOpen))
	
	// <THE DATABASE EVENT HANDLER CODE>
	
End if 
```

