\ *** Block No. 0 Hexblock 0 
\\             *** Graphic - Demonstrationen ***       26may86we
                                                                
Dieses File enth�lt einige Graphic-Demos, die von den Line-A    
Routinen Gebrauch machen.                                       
                                                                
Hier bietet sich auch dem Anf�nger ein weites Feld f�r eigene   
Versuche. Mit  CHECKING ON  kann man die gr�bsten Fehler abfan- 
gen, alledings auf Kosten der Geschwindigkeit.                  
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ Demo Loadscreen                                      21sep86we
                                                                
\needs Graphics include line_a.scr                              
                                                                
Onlyforth   Graphics also definitions                           
 1 &11 +thru                                                    
                                                                
moire                                                           
kaleidos                                                        
lines                                                           
boxes                                                           
rechtecke                                                       
rechtecke1                                                      
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ patterns                                             18sep86we
                                                                
1 ?head !                                                       
: !pattern   ( d -- )           Create   , , ;                  
                                                                
$C000.C000 !pattern p1          $CCCC.3333 !pattern p2          
$C0C0.3030 !pattern p3          $0303.0C0C !pattern p4          
$C003.300C !pattern p5          $C3C3.3C3C !pattern p6          
$FFFF.8001 !pattern p7          $40A0.8040 !pattern p8          
$4444.0000 !pattern p9          $FFFF.2222 !pattern p10         
$4444.8282 !pattern p11         $8080.8888 !pattern p12         
$0000.1010 !pattern p13         $0101.8080 !pattern p14         
$7777.8888 !pattern p15         $7E7E.8181 !pattern p16         
$E640.FFFF !pattern p17         $3838.C6C6 !pattern p18         
                                                                
0 ?head !                                                       
\ *** Block No. 3 Hexblock 3 
\ patterns                                             21may86we
                                                                
Create patterns   p1 ,  p2 ,  p3 ,  p4 ,  p5 ,  p6 ,            
                  p7 ,  p8 ,  p9 , p10 , p11 , p12 ,            
                 p13 , p14 , p15 , p16 , p17 , p18 ,            
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 4 Hexblock 4 
\ diamonds                                             20sep86we
                                                                
| : yscale        &400 &640 */  ;                               
                                                                
: diamond   ( size -- )                                         
   >r  cur_x @   cur_y @                                        
   2dup  swap  r@ -  swap   2swap 2over     set                 
   2dup  r@ yscale -  draw                                      
   2dup  swap r@ + swap  draw                                   
   2dup  r> yscale + draw                                       
   2swap draw   set ;                                           
                                                                
: big_diamond       2 wr_mode !                                 
   &319 0  &639 &200  &319 &399  0 &200  4  polygon ;           
                                                                
                                                                
\ *** Block No. 5 Hexblock 5 
\ some usefull definitions                             20sep86we
                                                                
: overwrite  0 wr_mode ! ;                                      
: exorwrite  2 wr_mode ! ;                                      
                                                                
| : home        get_res scr_res !  0 0 set ;                    
| : center      &320 &200 set ;                                 
                                                                
| : wait        BEGIN  pause key?  UNTIL  &25 0 at              
                getkey $FF and #esc = abort" stopped" ;         
                                                                
| : logo        &117 0 DO  ." volksFORTH 83    "  LOOP ;        
                                                                
| : titel                                                       
     &21 &24 at ."  ***  v o l k s F O R T H  *** "             
     &22 &31 at        ."  Line-A Graphic " ;                   
\ *** Block No. 6 Hexblock 6 
\ patterns example                                     18sep86we
                                                                
: muster                                                        
   page   overwrite    1 pat_mask !                             
   $10 0 DO  patterns I 2* + @  pattern !                       
             $10 I $10 * + dup  $80 $80  rectangle  LOOP        
   6 pat_mask !                                                 
   $10 0 DO  patterns I 2* + @  pattern !                       
       $110 I $10 * dup >r + $110 r> - $80 $80  rectangle  LOOP 
   1 pat_mask ! wait  ;                                         
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 7 Hexblock 7 
\ kaleidoskop                                          20sep86we
                                                                
| : kaleid    exorwrite   home center                           
              patterns &30 + @  pattern !                       
              2 0 DO                                            
                $40 1 DO  $140 0 DO  I diamond  J +LOOP   LOOP  
              LOOP ;                                            
                                                                
: kaleidos    page  big_diamond  kaleid wait ;                  
: kaleid1     page  logo  kaleid wait ;                         
                                                                
: diamonds    1 pat_mask !                                      
              $10 0 DO  patterns I 2* + @  pattern !            
                    page big_diamond  wait  LOOP ;              
                                                                
                                                                
\ *** Block No. 8 Hexblock 8 
\ polygon example                                      18sep86we
                                                                
| : (poly   ( x y -- )                                          
   2dup  >r &100 +  r> &10 +                                    
   2dup  >r  &10 +  r> &90 +                                    
   2dup  >r  &30 -  r> &20 +                                    
   2dup  >r  &50 -  r> &35 -                                    
   2dup  >r  &30 -  r> &85 -  6  polygon ;                      
                                                                
: poly   page                                                   
   &10 0  DO  patterns I 5 + 2* + @  pattern !                  
              I I * &5 * I &30 * (poly  LOOP                    
   &10 0  DO  patterns I 5 + 2* + @  pattern !                  
         &510 I I * &5 * -  I &30 * (poly  LOOP                 
   wait  ;                                                      
                                                                
\ *** Block No. 9 Hexblock 9 
\ moire                                                         
                                                                
: moire    page  curoff  exorwrite  titel                       
    &400 1 DO                                                   
       &640 0 DO  I  &399  &639 I - 0  line   J +LOOP           
       &400 0 DO  &639  &398 I -  0 I  line   J +LOOP           
           LOOP                                                 
    1 &399 DO                                                   
       &640 0 DO  I  &399  &639 I - 0  line   J +LOOP           
       &400 0 DO  &639  &398 I -  0 I  line   J +LOOP           
       -1 +LOOP  wait ;                                         
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 10 Hexblock A 
\ boxes                                                17sep86we
                                                                
: boxes    exorwrite  page                                      
   &162 0 DO      I           I      set  I dup box             
             &639 I 2* -      I      set  I dup box             
                  I      &399 I 2* - set  I dup box             
             &639 I 2* - &399 I 2* - set  I dup box  2 +LOOP    
   wait   ;                                                     
                                                                
| Code a>r     4 SP D) D0 move   D0   SP  ) sub                 
               6 SP D) D0 move   D0 2 SP D) sub   Next end-code 
                                                                
: abox   ( x1 y1 x2 y2 -- )     a>r  2swap  set box ;           
                                                                
                                                                
                                                                
\ *** Block No. 11 Hexblock B 
\ Rechtecke                                            17sep86we
                                                                
: rechtecke    exorwrite page                                   
    0 BEGIN  stop? not WHILE                                    
             8 + dup >r   r@ &640 mod   r@ &400 mod             
             &639 r@ - &640 mod   &399 r> - &400 mod            
             abox  REPEAT drop ;                                
                                                                
: rechtecke1      page exorwrite   fullpattern pattern !        
    BEGIN  stop? not WHILE                                      
      &99 3 DO   &300 0 DO                                      
          I dup  dup J + dup  a>r rectangle   J +LOOP           
            LOOP                                                
      3 &98 DO   &300 0 DO                                      
          I dup  dup J + dup  a>r rectangle   J +LOOP           
        -1  +LOOP    REPEAT ;                                   
\ *** Block No. 12 Hexblock C 
\ linien punkte                                        18sep86we
                                                                
| : (lines ( abstand -- )      exorwrite                        
      &640 0 DO   &640 0 DO  I &399  J 0  line   dup +LOOP      
         dup +LOOP drop ;                                       
                                                                
: lines       page home  curoff     &45 (lines &90 (lines       
              BEGIN  &45 (lines stop? UNTIL    &25 0 at ;       
                                                                
: kreis_moire    page     &320 0 DO                             
      &199 0 DO  I dup *  J dup *  +  &300 /  1 and             
       IF  &320 J +  &200 I +  1  put_pixel                     
           &320 J -  &200 I +  1  put_pixel                     
           &320 J -  &200 I -  1  put_pixel                     
           &320 J +  &200 I -  1  put_pixel                     
       THEN  2 +LOOP  LOOP       wait   ;                       
\ *** Block No. 13 Hexblock D 
\ Sprites                                              20sep86we
                                                                
\needs q    : q ;                                               
forget q    : q ;                                               
                                                                
: Sprite:     Create  5 0 DO            4 I - roll , LOOP       
                    $10 0 DO  $FFFF , $0F I - roll , LOOP  ;    
                                                                
                                                                
Create spritebuf   &74 allot                                    
                                                                
                                                                
                                                                
                                                                
                                                                
-->                                                             
\ *** Block No. 14 Hexblock E 
%0000000000000000   \                                  20sep86we
%0111111111111100                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0111111111110000                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0100000000000000                                               
%0000000000000000      0 0 1 0 1 Sprite: test                   
