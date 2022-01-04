//%attributes = {}
var $error; $input; $message; $output; $root : Text
var $i : Integer
var $buildSettings; $dmg; $lib4d; $log : 4D:C1709.File

var $appleID : Text
$appleID:="vdl@mac.com"

var $certificate : Text
$certificate:="Vincent de Lachaux (DYRKW64QA9)"

var $publicID : Text
$publicID:="ad963670-a233-4090-a45f-ceca3bd61c9b"

$buildSettings:=File:C1566(Build application settings file:K5:60)

If ($buildSettings.exists)
	
	BUILD APPLICATION:C871($buildSettings.platformPath)
	
	$log:=File:C1566(Build application log file:K5:46)
	
	If (Bool:C1537(OK))
		
		$root:=DOM Parse XML source:C719($log.platformPath)
		
		If (OK=1)
			
			ARRAY TEXT:C222($nodes; 0x0000)
			$nodes{0}:=DOM Find XML element:C864($root; "Log/Message"; $nodes)
			
			If (OK=1)
				
				$nodes{0}:=""
				
				For ($i; 1; Size of array:C274($nodes); 1)
					
					DOM GET XML ELEMENT VALUE:C731($nodes{$i}; $message)
					
					If ($message="Signed file:@")
						
						$nodes{0}:=$nodes{$i}
						$i:=MAXLONG:K35:2-1
						
					End if 
					
					If (Length:C16($nodes{0})>0)
						
						ARRAY LONGINT:C221($pos; 0x0000)
						ARRAY LONGINT:C221($len; 0x0000)
						
						If (Match regex:C1019("(?m-si)(/[^:]*):"; $message; 1; $pos; $len))
							
							$lib4d:=File:C1566(Substring:C12($message; $pos{1}; $len{1}))
							
							If ($lib4d.exists)
								
								var $lib4dPath : Text
								$lib4dPath:="'"+$lib4d.path+"'"
								
								// * Remove signature
								SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
								LAUNCH EXTERNAL PROCESS:C811("codesign --remove-signature "+$lib4dPath; $input; $output; $error)
								
								If (Bool:C1537(OK))
									
									// * Sign it
									SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
									LAUNCH EXTERNAL PROCESS:C811("codesign --verbose --deep --timestamp --force --sign \"Developer ID Application: "+$certificate+"\" "+$lib4dPath; $input; $output; $error)
									
									// RESULT IS ON ERROR STREAM
									
									If (Bool:C1537(OK))
										
										// * Archive it
										var $dmgPath : Text
										$dmg:=$lib4d.parent.parent.parent.file("lib4d-arm64.dmg")
										$dmgPath:="'"+$dmg.path+"'"
										
										SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
										LAUNCH EXTERNAL PROCESS:C811("xcrun altool --notarize-app -u "+$appleID+" -p \"@keychain:altool\" --primary-bundle-id lib4d-arm64 -f "+$dmgPath+" --asc-public-id "+$publicID; $input; $output; $error)
										
										If (Bool:C1537(OK))
											
											// Get RequestUUID
											If (Match regex:C1019("(?m-si)RequestUUID = ([[:xdigit:]]{8}-(?:[[:xdigit:]]{4}-){3}[[:xdigit:]]{12})"; $output; 1; $pos; $len))
												
												var $requestUUID : Text
												$requestUUID:=Substring:C12($output; $pos{1}; $len{1})
												
												var $notarized : Boolean
												
												While (Not:C34($notarized))
													
													DELAY PROCESS:C323(Current process:C322; 30*60)  // Check twice a minute
													
													SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
													LAUNCH EXTERNAL PROCESS:C811("xcrun altool --notarization-info  "+$requestUUID+" -u "+$appleID+" -p \"@keychain:altool\""; $input; $output; $error)
													
													If (Bool:C1537(OK))
														
														Case of 
																
																//______________________________________________________
															: (Match regex:C1019("(?m-si)Status: in progress"; $output; 1))
																
																OK:=0
																
																//______________________________________________________
															: (Match regex:C1019("(?m-si)Status Message: Package Approved"; $output; 1))
																
																$notarized:=True:C214
																
																//______________________________________________________
															: ($error#"")
																
																$notarized:=True:C214
																OK:=0
																
																//______________________________________________________
															Else 
																
																// A "Case of" statement should never omit "Else"
																
																//______________________________________________________
														End case 
														
														If ($notarized & Bool:C1537(OK))
															
															// * Staple it
															SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
															LAUNCH EXTERNAL PROCESS:C811("xcrun stapler staple "+$dmgPath; $input; $output; $error)
															
														Else 
															
														End if 
														
													Else 
														
													End if 
													
												End while 
												
											Else 
												
												// A "If" statement should never omit "Else"
												
											End if 
											
										End if 
										
									End if 
								End if 
								
							Else 
								
								// A "If" statement should never omit "Else"
								
							End if 
							
						Else 
							
						End if 
						
					Else 
						
						// A "If" statement should never omit "Else"
						
					End if 
					
				End for 
			End if 
			
			DOM CLOSE XML:C722($root)
			
		End if 
		
	Else 
		
		ALERT:C41($log.getText())
		
	End if 
	
Else 
	
	ALERT:C41("File not found: "+$buildSettings.path)
	
End if 