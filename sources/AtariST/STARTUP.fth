\ *** Block No. 0 Hexblock 0 
\\         ***  Loadscreen f�r Arbeitssystem ***      bp 12oct86
                                                                
Der folgenden Screens wird benutzt, um aus    FORTHKER.PRG      
 ein Arbeitssystem zusammenzustellen.                           
                                                                
Alle Files, die zum Standardsystem geh�ren sollen, werden mit   
 INCLUDE  dazugeladen. Nicht ben�tigte Teile k�nnen mit  \      
 weggelassen werden. Nat�rlich kann man auch die entsprechenden 
 Zeilen ganz l�schen. Beachten Sie aber, da� bestimmte Files    
 Grundlage f�r andere sind. So wird zum Beispiel der Assembler  
 sehr h�ufig gebraucht, der hier "Intern" geladen wird.         
                                                                
F�r eigene Applikationen erstellen Sie sich einen Loadscreen    
 nach dem Muster, der dann das oder die Files beinhaltet, die   
 zu Ihrer Applikation geh�ren.                                  
                                                                
\ *** Block No. 1 Hexblock 1 
\ Loadscreen for Standard System                     cas20130105
                                                                
Onlyforth include misc.fb                                       
Onlyforth 2 loadfrom assemble.fb                                
\ Onlyforth include assemble.fb                                 
Onlyforth include strings.fb                                    
Onlyforth include allocate.fb                                   
Onlyforth include gem\aes.fb                                    
Onlyforth include editor.fb                                     
Onlyforth include index.fb                                      
Onlyforth include tools.fb                                      
Onlyforth include relocate.fb                                   
\ Onlyforth include printer.fb                                  
\ Onlyforth include line_a.fb                                   
\ Onlyforth include demo.fb                                     
Onlyforth    cr cr .( May the volksFORTH be with you ...)  cr   
