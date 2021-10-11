//%attributes = {}
var $o : Object

$o:=New object:C1471
$o.name:="Test formula"
$o.formula:=Formula:C1597(ALERT:C41("hello world"))

quickOpenPushAction($o)

$o:=New object:C1471
$o.name:="test form"
$o.form:="TEST"

quickOpenPushAction($o)