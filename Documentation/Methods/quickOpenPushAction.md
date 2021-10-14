## Description
The `quickOpenPushAction` method allows you to record your own actions.

## Syntax

`quickOpenPushAction(Object)`

🚨 **Note**: As the purpose of this component is only development, to avoid including it in the final application, it is strongly recommended to test if the component is loaded and then use EXECUTE METHOD to call the `quickOpenPushAction` shared method like this:

```4d
If (Not(Is compiled mode))	
	COMPONENT LIST($componentsArray)	
	If (Find in array($componentsArray; "4DPop QuickOpen")>0)
		$o:=New object(\
			"name";"Hello";\
			"formula";Formula(ALERT("Hello World"))
		EXECUTE METHOD("quickOpenPushAction"; *; $o)
	End if 
End if 
```

## Usage

Actions can be code that will be executed or a form that will be displayed on the screen.

### 1] Code actions

The code to execute is defined by a **Formula** defined in the "[formula](#formula)" property.
<br/>It can be a simple line of encapsulated code,

```4d
$o:=New object
$o.name:="Test formula"
$o.formula:=Formula(ALERT("hello world"))
EXECUTE METHOD("quickOpenPushAction"; *; $o)
```
or a project method call.
 
```4d
$o:=New object
$o.name:="Test formula"
$o.formula:=Formula(myMethod)
EXECUTE METHOD("quickOpenPushAction"; *; $o)
```
> 📌 Unless you set a "[modal](#modal)" property to true, the code is executed in a new process and provides a default menu bar (with the `Edit` menu).

### 2] Form actions

The component automatically manages the display of a form that you have defined.
<br/>You give the name of the folder containing the form definition in the "[form](#form)" property.

```4d
$o:=New object
$o.name:="test form"
$o.form:="TEST"
EXECUTE METHOD("quickOpenPushAction"; *; $o)
```
> 📌 The form is displayed in a new process and provides a default menu bar (with the `Edit` menu).

## Action Object Properties

### • name
Is the name of the action as it will be displayed in the list. All words are used for the search.
	
#### • shortcut
This optional property contains additional keywords, other than those in the name, to be used in the search. For example, for the action "Maintenance and Security Center", the shortcut "`msc`" allows typing "msc" to select this action. You can put several words in a row: ie. "FolderDossier"
	
### • <a name="formula">formula</a>
The formula to be executed. 
	
> 📌 If the formula calls one of your methods, there is no need to declare them as "shared by components and host database" since when called, the formula object is evaluated within the context of the database or component that created it. See [Formula documentation](https://developer.4d.com/docs/en/API/FunctionClass.html#formula)
	
### • <a name="form">form</a>
The name of a folder containing the form definition to be displayed. This folder must be in a folder named `quickAction` located in the `Resources` folder of the database.
	
> 📌 If both `formula` and `form` are defined, `form` will be ignored
	
### • condition
This optional property allows to provide a formula that will be evaluated to propose or not an action. 
<br/>The formula must return a boolean. ie. the formula `Formula(Application type=4D Remote mode)` will not display the action in a database executed in local mode.

### • icon
Optional. Allows you to provide a custom icon to use in the list.
	
### • <a name="modal">modal</a>
By default the code is executed in a new process. If the optional property `modal`is True, the code will be executed into the design process.

