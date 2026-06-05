property type : Integer
property tableNumber : Integer
property name : Text
property desc : Text
property folder:=""
property doc : 4D:C1709.File
property icon : Picture
property attributes : Object

//-----------------------------------------------------------
Class constructor
	
	//
	
	//-----------------------------------------------------------
Function get isTrigger() : Boolean
	
	return This:C1470.type=Path trigger:K72:4
	
	//-----------------------------------------------------------
Function get isProjectForm() : Boolean
	
	return This:C1470.type=Path project form:K72:3
	
	//-----------------------------------------------------------
Function get isTableForm() : Boolean
	
	return This:C1470.type=Path table form:K72:5
	
	//-----------------------------------------------------------
Function get isClass() : Boolean
	
	return This:C1470.type=Path class:K72:19
	
	//-----------------------------------------------------------
Function get isProjectMethod() : Boolean
	
	return This:C1470.type=Path project method:K72:1
	
	//-----------------------------------------------------------
Function get isDatabaseMethod() : Boolean
	
	return This:C1470.type=Path database method:K72:2