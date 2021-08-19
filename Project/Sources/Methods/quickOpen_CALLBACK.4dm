//%attributes = {"invisible":true}
// Call back from quickOpen_WORKER when the list refresh is finished.
#DECLARE($design : cs:C1710.design)

COMPILER_quickOpen

design:=$design

Form:C1466.list:=design.sources

// Update UI
Form:C1466.weWork.hide().stop()

// Restart the search in case
Form:C1466.quickOpen.search()