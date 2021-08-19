[![language](https://img.shields.io/static/v1?label=language&message=4d&color=blue)](https://developer.4d.com/)
[![language](https://img.shields.io/github/languages/top/vdelachaux/4DPop-QuickOpen.svg)](https://developer.4d.com/)
![code-size](https://img.shields.io/github/languages/code-size/vdelachaux/4DPop-QuickOpen.svg)
[![license](https://img.shields.io/github/license/vdelachaux/4DPop-QuickOpen)](LICENSE)
[![release](https://img.shields.io/github/v/release/vdelachaux/4DPop-QuickOpen?include_prereleases)](https://github.com/vdelachaux/4DPop-QuickOpen/releases/latest)

# Overview

`4DPop QuickOpen` is entirely inspired by the excellent [`DevQuickOpen`](https://github.com/cannonsmith/DevQuickOpen) shared on Github by [`Cannon Smith`](https://discuss.4d.com/u/smith.cannon/summary). The goal of this reinterpretation is to make it a component and to use to the maximum the new possibilities of the project mode and the language of 4D.

So the description is consistent with that of the inspiration 😉 :

> *(4DPop)* Quick Open is a development tool with the major goal of quickly opening forms, methods, classes, etc. in 4D and is inspired by Xcode's Quickly Open or macOS' Spotlight features. Beyond that, it also handles the creation and opening of documentation and a few smaller things.

The Quick Open window can be opened in two ways:

1. By pressing Option-Space. This means that an event manager must be running (see [Installation](# Installation) below).

2. By clicking on its icon in the 4DPop palette.
<img src="./Documentation/4DPop.png">

# Installation
 

### 1 - Create a `ON_EVENT_CALL` method & paste this code:

```4D
var $caught : Boolean// Only if the component is loadedARRAY TEXT($components; 0)COMPONENT LIST($components)If (Find in array($components; "4DPop QuickOpen")>0)		If (MODIFIERS ?? Option key bit)  // ⌥				If (KEYCODE=202)  // Space						// Only for the design process			var $t : Text			var $i : Integer			PROCESS PROPERTIES(Frontmost process(*); $t; $i; $i; $i; $i; $i)						$caught:=($i=Design process)					End if 	End if End if If ($caught)		FILTER EVENT	EXECUTE METHOD("QUICK_OPEN")	Else 		// <THE DATABASE EVENT HANDLER CODE, IF ANY>	End if
```
 
> **Note**: It's in this method that you can change the shortcut to invoke the quick search dialog.

 
### 2 - Create, if any the database method `On startup` and install the event handler:

```4D
If (Not(Is compiled mode(*)))		// Install the event manager	ON EVENT CALL("ON_EVENT_CALL"; "$eventListener")	End if
```
 
> **Note**: If an event handler is already used in your database, you should use this code to modify your method

 
### 3 - Restart the database and hit Option-Space in design mode to display the UI

The QuickOpen dialog box should appear

<img src="./Documentation/empty.png">

# Features

> **Note**: These are the same as in the original Cannon development…

* The search starts from 3 characters entered (if "@" is the only character entered, all objects in the project are displayed)
* You can enter for "class" or "form" or "method" to display all objects of this type.
* You can enter a folder name to see all the objects it contains.
* No need for @, the search is a "contains" search.
* A list of entries will appear, sorted by relevance
 
<img src="./Documentation/quick.png">

* You can keep typing or use the up/down arrow keys to select an item to open it.
* You can right-click on an item for additional options (create/edit/delete documentation, show file, edit,…).

<img src="./Documentation/menu.png" width="184">
 
* The list will show a paperclip on left for items that have documentation.
* The list shows the name of the object's folder (which is useful for finding the folder of an item if it is misplaced).


# Shortcuts
|||
|:----:|----|
|`⏎` or `⌤`|Open the selected item|
|`⌥ + ⏎`|Open or create the item's documentation|
|`⌥ + ⌫`|Clear the search|
|`Esc`|Close the dialog|







