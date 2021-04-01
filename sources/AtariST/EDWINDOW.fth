\ *** Block No. 0 Hexblock 0 
\\                     *** EDWINDOW.SCR ***            14sep86we
                                                                
Dieses File enth�lt das Editorfenster. Es kann als Beispiel f�r 
die Programmierung eines eigenen Fensters benutzt werden.       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ Window-Handling Loadscreen                           30oct86we
                                                                
Onlyforth   Gem also definitions                                
                                                                
1 7 +thru                                                       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ VDI-Functions for window                             24aug86we
                                                                
: bar    ( x1 y1 x2 y2 -- )                                     
   ptsin 4 array!   1 function !   &11 2 0 VDI ;                
                                                                
: swr_mode   ( mode -- )         intin !   &32 0 1 VDI  ;       
                                                                
: sf_interior   ( style  -- )    intin !    &23 0 1 VDI  ;      
: sf_style   ( styleindex -- )   intin !    &24 0 1 VDI  ;      
: sf_color   ( color -- )        intin !    &25 0 1 VDI  ;      
: sf_perimeter   ( pervis -- )   intin !   &104 0 1 VDI  ;      
                                                                
: fbox  ( x1 y1 x2 y2 -- )                                      
   1 swr_mode  1 sf_interior  0 sf_color  0 sf_perimeter  bar ; 
                                                                
                                                                
\ *** Block No. 3 Hexblock 3 
\ save and restore the screen                          10sep86we
                                                                
?head @    1 ?head !                                            
                                                                
Create memMFDB2  7 , 0 , &640 , &400 , &40 , 0 , 1 ,            
                 0 , 0 , 0 ,                                    
                                                                
memMFDB2 scr>mem scr>mem2  ( Xleft Ytop Width Heigth -- )       
memMFDB2 mem>scr mem2>scr  ( Xleft Ytop Width Heigth -- )       
                                                                
: save_screen       0 0 cwidth &80 *  cheight &25 *             
                    scr>mem2 ;                                  
: restore_screen    0 0 cwidth &80 *  cheight &25 *             
                    mem2>scr ;                                  
                                                                
                                                                
\ *** Block No. 4 Hexblock 4 
\ Windowcomponents and Windowsize                      30aug86we
                                                                
:name  :move +  :info +  :uparrow +  :dnarrow +  :vslide +      
Constant wi_components                                          
                                                                
: wi_x       ( -- n )      dx cwidth  * ;                       
: wi_y       ( -- n )      dy cheight * ;                       
: wi_width   ( -- n )     c/l cwidth  * ;                       
: wi_height  ( -- n )     l/s cheight * ;                       
                                                                
: wi_size   ( -- wx wy wwidth wheight )                         
   0  wi_components                                             
   wi_x 1-  wi_y 1-  wi_width 2+  wi_height 2+  wind_calc       
   intout 2+ 4@ ;                                               
                                                                
                                                                
\ *** Block No. 5 Hexblock 5 
\ Window's title and sliders                           25sep86we
                                                                
Variable wi_handle                                              
                                                                
: wi_string  ( 0string function# -- )       swap  >r            
   wi_handle @  swap  r> >absaddr swap  0 0  wind_set ;         
                                                                
: wi_title   ( 0string -- )    :wf_name wi_string ;             
: wi_status  ( 0string -- )    :wf_info wi_string ;             
                                                                
: vslide_size                                                   
   wi_handle @  :wf_vslize  &1000 capacity /  0 0 0  wind_set ; 
                                                                
: vslide   ( scr# -- )      wi_handle @  :wf_vslide             
   rot  &1000  capacity dup 1-  IF 1- THEN   */                 
   0 0 0  wind_set ;                                            
\ *** Block No. 6 Hexblock 6 
\ Draw window on screen                                30aug86we
                                                                
: small_big  ( -- sx sy sw sh  bx by bw bh )                    
   little 4@  wi_size ;                                         
                                                                
: growbox       small_big graf_growbox ;                        
: shrinkbox     small_big graf_shrinkbox ;                      
                                                                
: wi_clear     wi_x 1-   wi_y 1-                                
   over wi_width 1+ +    over wi_height 1+ +  fbox ;            
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 7 Hexblock 7 
\ Open and close window                                30aug86we
                                                                
: wi_open    ( -- )        save_screen   growbox                
   wi_components wi_size wind_create   dup wi_handle !          
   pad  dup off  dup wi_title  wi_status                        
   wi_size wind_open   wi_clear ;                               
                                                                
: wi_close   ( -- )                                             
   wi_handle @  dup wind_close  wind_delete                     
   shrinkbox  restore_screen ;                                  
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 8 Hexblock 8 
\ redrawing the rest of screen                         10sep86we
                                                                
: restore_rect    ( x y w h -- )      1- >r  1-  r>  mem2>scr ; 
                                                                
: rect_update   ( function# -- x y w h )                        
   0  swap  wind_get  intout 2+  4@  ;                          
                                                                
: redraw_screen      :wf_firstxywh rect_update                  
   BEGIN  2dup or                                               
   WHILE  restore_rect  :wf_nextxywh rect_update  REPEAT        
   2drop 2drop ;                                                
                                                                
?head !                                                         
                                                                
                                                                
                                                                
\ *** Block No. 9 Hexblock 9 
                                                       14sep86we
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 10 Hexblock A 
\ Window-Handling Loadscreen                           14sep86we
                                                                
Suchreihenfolge: Zuerst GEM, dann FORTH                         
                                                                
Gebraucht werden die Definitionen aus GEMDEFS.SCR               
                                                                
Dieses Vokabular wird als erstes durchsucht.                    
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 11 Hexblock B 
\ VDI-Functions for window                             14sep86we
                                                                
F�r das Fenster werden einige Funktionen aus VDI gebraucht,     
 die auf diesem Screen zusammengestellt sind. Beschreibung siehe
 Beschreibung VDI (hoffentlich haben wir die schon!)            
                                                                
Im Grunde wird nur eine Routine benutzt, mit der man ein wei�es 
 Rechteck zum L�schen des Fensterinhaltes erzeugen kann. Dies   
 erledigt fbox                                                  
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 12 Hexblock C 
\ save and restore the screen                          14sep86we
                                                                
alle folgenden Funktionen sollen headerless kompiliert werden.  
                                                                
Ein zweiter Speicherbereich wird gebraucht, um den Bildschirm   
 beim Verlassen des Editors zu restaurieren. Dieses Verfahren   
 ren ist erheblich schneller als die Neuausgabe des Bildschirms,
 braucht aber Speicherplatz  (Wir hams ja!)                     
                                                                
                                                                
Der gesamte Bildschirm wird in den daf�r vorgesehenen Speicher- 
 bereich gerettet (au�erhalb des FORTH-Systems, versteht sich)  
Das Ganze umgekehrt stellt den Bildschirm wieder her. Diese     
 Funktionen sind recht n�tzlich, weil man Werte noch sehen kann,
 die z.B. bei LIST weggescrollt w�rden.                         
                                                                
\ *** Block No. 13 Hexblock D 
\ Windowcomponents and Windowsize                      14sep86we
                                                                
Die Bestandteile des Fensters werden einfach aufaddiert und     
als Konstante zur Verf�gung gestellt.                           
                                                                
linke obere Ecke des Fensters in Bildschirmkoordinaten          
                                                                
Breite des Fensters in Bildschirmkoordinaten                    
H�he des Fensters in Bildschirmkoordinaten                      
                                                                
berechnet die Ausma�e des Fensters f�r alle weiteren Funktionen 
 unter Zuhilfenahme von WIND-CALC. Leider liefert diese Funktion
 bei Breite und H�he ein Pixel zu wenig. Digital Research allein
 mag wissen, warum ...                                          
                                                                
                                                                
\ *** Block No. 14 Hexblock E 
\ Window's title and sliders                           14sep86we
                                                                
Window-Handle des Fensters                                      
                                                                
zur Ausgabe eines Textes in Titel- oder Infozeile               
 Der String mu� mit einer Null abgeschlossen sein.              
                                                                
gibt 0string in der Titelzeile aus.                             
gibt 0string in der Infozeile aus.                              
                                                                
Die Gr��e des vertikalen Sliders wird aus der Gesamtgr��e des   
 Files, das editiert wird, berechnet.                           
                                                                
Die Position des vertikalen Sliders wird relativ zur Gesamtgr��e
 des Files eingestellt.                                         
                                                                
\ *** Block No. 15 Hexblock F 
\ Draw window on screen                                14sep86we
                                                                
gibt die Gr��e eines kleinen Rechtecks sowie des ganzen Fensters
                                                                
                                                                
zeichnet ein wachsendes Rechteck (nur f�rs Auge ...)            
zeichnet ein schrumpfendes Rechteck ( s.o.)                     
                                                                
l�scht den Innenraum des Fenster durch �berschreiben mit einem  
 wei�en Rechteck.                                               
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 16 Hexblock 10 
\ Open and close window                                14sep86we
                                                                
�ffnet das Editorfenster:  Bildschirminhalt merken              
 Fenster erzeugen mit entsprechender Gr��e und Attributen       
 Titel- und Infozeile l�schen                                   
 Fenster auf dem Bildschirm ausgeben und Inhalt l�schen         
                                                                
schlie�t das Editorfenster:                                     
 Fenster vom Bildschirm und �berhaupt entfernen                 
 Bildschirm restaurieren.                                       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 17 Hexblock 11 
\ redrawing the rest of screen                         14sep86we
                                                                
Rechteck per Pixelmove restaurieren                             
                                                                
liefert die Koordinaten eines neu zu zeichnenden Rechtecks.     
                                                                
Der Screenmanager stellt eine Liste von Rechtecken zurVerf�gung,
 die nach einer Aktion ge�ndert worden sind.                    
 Durch diese Liste hangelt sich die Routine hindurch und        
 erzeugt die Rechtecke per Pixelmove (schnell) neu.             
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
