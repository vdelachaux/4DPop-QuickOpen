//%attributes = {}
Si (Non:C34(Mode compile:C492))
	
	TABLEAU TEXTE:C222($componentsArray; 0)
	LISTE COMPOSANTS :C1001($componentsArray)
	
	Si (Chercher dans tableau :C230($componentsArray; "4DPop QuickOpen")>0)
		
		// Installing quickOpen
		EXECUTER METHODE:C1007("quickOpenInit"; *; Formule:C1597(MODIFIERS); Formule:C1597(KEYCODE))
		APPELER SUR EVENEMENT :C190("quickOpenEventHandler"; "$quickOpenListener")
		
	Fin de si 
Fin de si 
