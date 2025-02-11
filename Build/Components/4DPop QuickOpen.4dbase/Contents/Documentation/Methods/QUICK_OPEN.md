<!-- QUICK_OPEN() -->
## Description
`QUICK_OPEN` display the quick open dialog

## Usage

Call `QUICK_OPEN` from your code. For example, a button.

🚨 **Note**: As the purpose of this component is only development, to avoid including it in the final application, it is strongly recommended to test if the component is loaded and then use EXECUTE METHOD to call the shared method like this:

```4d
If (Not(Is compiled mode))	
	COMPONENT LIST($componentsArray)	
	If (Find in array($componentsArray; "4DPop QuickOpen")>0)
		EXECUTE METHOD("QUICK_OPEN")
	End if 
End if 
```

