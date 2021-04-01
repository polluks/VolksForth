\ *** Block No. 0 Hexblock 0 
\\                   *** GEM - Basics ***              26may86we
                                                                
Die Routinen in dieser Library entsprechen dem, was auch dem    
Pascal-, C- oder Modula-Programmierer zur Verf�gung steht.      
F�r eine genaue Beschreibung der einzelnen Routinen verweisen   
wir auf die GEM-Dokumentation des ST-Entwicklungspaketes bzw.   
entsprechende Literatur.                                        
                                                                
Aus diesem Grunde wurden die - teilweise kryptischen - Namen    
von Digital Research beibehalten; auch die �bergabeparameter    
der einzelnen Funktionen sind unver�ndert geblieben.            
Der Aufbau einer FORTH-Library mit 'Super-Befehlen' ist in      
Arbeit.                                                         
                                                                
Die Worte in diesem File werden sowohl f�r VDI- als auch f�r    
AES-Funktionen ben�tigt.                                        
\ *** Block No. 1 Hexblock 1 
\ VDI GEM Arrays and Controls Loadscreen               02nov86we
                                                                
Onlyforth                                                       
                                                                
\needs >absaddr     : >absaddr   0 forthstart d+ ;              
\needs Code         2 loadfrom assemble.scr                     
                                                                
Vocabulary GEM   GEM definitions also                           
                                                                
 1  8 +thru                                                     
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\  VDI GEM Arrays                                      05aug86we
                                                                
Create intin   &60 allot        Create ptsin   &256 allot       
Create intout  &90 allot        Create ptsout  &24  allot       
Create addrin    8 allot        Create addrout   4  allot       
Variable grhandle                                               
                                                                
| : gemconstant  ( addr n -- addr+n)      over Constant + ;     
                                                                
Create contrl   $16 allot                                       
contrl 2 gemconstant opcode                                     
       2 gemconstant #intin                                     
       2 gemconstant #intout     ' #intout Alias #ptsout        
       2 gemconstant #addrin                                    
       2 gemconstant #addrout                                   
       2 gemconstant function     drop                          
\ *** Block No. 3 Hexblock 3 
\  global array, Parameter blocks                      02nov86we
                                                                
Create global   $20 allot                                       
global &10 + Constant ap_ptree                                  
                                                                
| : gemarray   ( n0 ... nk-1 k --)    Create 0 ?DO  , LOOP ;    
                                                                
addrout addrin intout intin global contrl 6 gemarray (AESpb     
        ptsout intout ptsin intin  contrl 5 gemarray (VDIpb     
                                                                
Create AESpb  &24 allot         Create VDIpb  &20 allot         
                                                                
: setarrays                                                     
   6 0 DO  (AESpb I 2* + @ >absaddr  AESpb I 2* 2* + 2!  LOOP   
   5 0 DO  (VDIpb I 2* + @ >absaddr  VDIpb I 2* 2* + 2!  LOOP ; 
                                                                
\ *** Block No. 4 Hexblock 4 
\  Array-Handling                                      09sep86we
                                                                
Code array!   ( n0 ... nk-1 adr k --)                           
   SP )+ D0 move  SP )+ D6 move  D6 reg) A0 lea                 
   D0 A0 adda  D0 A0 adda  1 D0 subq                            
   D0 DO  SP )+ A0 -) move  LOOP    Next end-code               
                                                                
Code 4!   ( n1 .. n4 addr -- )                                  
   SP )+ D6 move  8 D6 addq  D6 reg) A0 lea   3 # D0 move       
     D0 DO  SP )+ A0 -) move  LOOP     Next end-code            
                                                                
Code 4@   ( addr -- n1 .. n4 )                                  
   SP )+ D6 move  D6 reg) A0 lea   3 # D0 move                  
     D0 DO  A0 )+ SP -) move  LOOP     Next end-code            
                                                                
                                                                
\ *** Block No. 5 Hexblock 5 
\  AES-Aufruf                                          09sep86we
                                                                
Code AES   ( opcode #intin #intout #addrin -- intout@ )         
   SP )+ contrl 6 + R#) move                    \ #addrin       
   SP )+ contrl 4 + R#) move                    \ #intout       
   SP )+ contrl 2+  R#) move                    \ #intin        
   SP ) D0 move   SP )+ contrl R#) move         \ opcode        
   contrl 8 + R#) clr                           \ #addrout      
   &112 D0 cmpi              \ Funktions-Nr. von rsrc_gaddr     
        0= IF  1 # contrl 8 + R#) move  THEN                    
   AESpb # D6 move   D6 reg) A0 lea   A0 D1 lmove               
   .w $C8 # D0 move   2 trap                                    
   intout R#) SP -) move   Next   end-code                      
                                                                
                                                                
                                                                
\ *** Block No. 6 Hexblock 6 
\  VDI-Aufruf                                          09sep86we
                                                                
Code VDI  ( opcode #ptsin #intin --)                            
   SP )+ contrl 6 + R#) move                                    
   SP )+ contrl 2+  R#) move   SP )+ contrl  R#) move           
   grhandle R#)  contrl &12 + R#) move                          
   VDIpb # D6 move   D6 reg) A0 lea   A0 D1 lmove               
   $73 D0 moveq  2 trap                                         
   Next   end-code                                              
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 7 Hexblock 7 
\  appl_init appl_exit graf_handle                    bp 12oct86
                                                                
: appl_init    global &14 + $10 erase   &10 0 1 0 AES drop ;    
: appl_exit    &19 0 1 0 AES drop ;                             
                                                                
                                                                
| : sizeconstant  ( addr n -- addr+n@ )                         
     over Create , +   Does>  @ @ ;                             
                                                                
Create sizes 8 allot       $08 $10 $13 $13  sizes 4!            
sizes 2 sizeconstant cwidth     2 sizeconstant cheight          
      2 sizeconstant bwidth     2 sizeconstant bheight   drop   
                                                                
: graf_handle       &77 0 5 0 AES grhandle !                    
   intout 2+ sizes 8 cmove ;                                    
                                                                
\ *** Block No. 8 Hexblock 8 
\  opnvwk clrwk clsvwk updwk                           02nov86we
                                                                
: opnvwk                                                        
   intin &10 0 DO  1 over I 2* + !  LOOP  drop                  
   2 intin &20 + !   &100 0 &11 VDI                             
   contrl &12 + @  grhandle ! ;                                 
                                                                
: clrwk        3 0 0 VDI ;                                      
: clsvwk    &101 0 0 VDI ;                                      
                                                                
: updwk      4 0 0 VDI  ;                                       
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 9 Hexblock 9 
\  s_clip grinit grexit show_c hide_c                  02nov86we
                                                                
: s_clip      ( x1 y1 x2 y2 clipflag -- )                       
   intin !  ptsin 4 array!   &129 2 1 VDI  ;                    
                                                                
: grinit    setarrays  appl_init  graf_handle  opnvwk ;         
: grexit    clsvwk appl_exit ;                                  
                                                                
2Variable objc_tree             0. objc_tree 2!                 
                                                                
Variable c_flag       c_flag off                                
: show_c   ( -- )     c_flag @ intin !  &122 0 1 VDI  ;         
: hide_c   ( -- )     &123 0 0 VDI  ;                           
                                                                
\\ st_load_fonts  st_unload_fonts                               
   w�r auch ganz h�bsch, hamse aber nich!                       
