\ *** Block No. 0 Hexblock 0 
\\                  *** VDI -Funktionen ***            12aug86we
                                                                
Dieses File enth�lt alle VDI-Funktionen.                        
                                                                
Zur genaueren Beschreibung verweisen wir auf die Dokumentation  
von Digital Research.                                           
Dieser Hinweis ist nicht zynisch gemeint, aber wir sind nicht   
in der Lage, das, was ATARI nicht zu leisten vermag, hier       
nachzuholen. Mit geeigneten Unterlagen (wo gibts die ??) sollte 
es aber m�glich sein, die Funktionen zu nutzen.                 
Beispiele findet man im Editor.                                 
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ VDI Loadscreen                                       09sep86we
                                                                
Onlyforth                                                       
\needs GEM     include gem\basics.scr                           
Onlyforth                                                       
\needs 2over   include double.scr                               
                                                                
Onlyforth  GEM also definitions                                 
                                                                
  1 +load            cr .( Output Functions loaded) cr          
  7 +load            cr .( Attribute Functions loaded) cr       
$0F +load            cr .( Raster Operations loaded) cr         
$15 +load            cr .( Input Functions loaded) cr           
$1B +load            cr .( Inquire Functions loaded) cr         
$1F +load            cr .( Escapes loaded) cr                   
                                                                
\ *** Block No. 2 Hexblock 2 
\ Output Functions Loadscreen                          27jan86we
                                                                
Onlyforth  GEM also definitions                                 
                                                                
01 05 +thru                                                     
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 3 Hexblock 3 
\  pline pmarker gtext                              26f09sep86we
                                                                
: pline   ( x1 y1 x2 y2 ... xn yn count -- )                    
 >r  ptsin r@ 2* array!   6 r> 0 VDI ;                          
                                                                
: pmarker  ( x1 y1 x2 y2 ... xn yn count -- )                   
 >r  ptsin r@ 2* array!   7 r> 0 VDI ;                          
                                                                
| Code 1:2move  ( from to count -- )   SP )+ D0 move            
   SP )+ D6 move   D6 reg) A0 lea                               
   SP )+ D6 move   D6 reg) A1 lea                               
   D0 tst  0<> IF  1 D0 subq  D1 clr   D0 DO                    
   .b A1 )+ D1 move  .w D1 A0 )+ move  LOOP  THEN  Next end-code
                                                                
: gtext    ( addr count x y -- )                                
 ptsin 2 array!   >r intin r@ 1:2move  8 1 r> VDI ;             
\ *** Block No. 4 Hexblock 4 
\  fillarea contourfill                                01feb86we
                                                                
: fillarea  ( x1 y1 x2 y2 ... xn yn count -- )                  
 >r  ptsin r@ 2* array!   9 r> 0 VDI ;                          
                                                                
: contourfill  ( color x y -- )                                 
 ptsin 2 array!  intin !   &103 1 1 VDI ;                       
                                                                
: r_recfl    ( x1 y1 x2 y2 -- )                                 
 ptsin 4 array!  &114 2 0 VDI ;                                 
                                                                
                                                                
\\ cellarray                                                    
                                                                
                                                                
                                                                
\ *** Block No. 5 Hexblock 5 
\  GDP bar arc pie                                     03aug86we
                                                                
: GDP   ( #ptsin #intin functionno -- )                         
   function !   &11 -rot  VDI ;                                 
                                                                
: bar    ( x1 y1 x2 y2 -- )     ptsin 4 array!      2 0 1 GDP  ;
                                                                
: arc   ( startwinkel endwinkel x y radius -- )                 
  ptsin under  &12 + !   2 array!   intin 2 array!  4 2 2 GDP  ;
                                                                
: pie   ( startwinkel endwinkel x y radius -- )                 
  ptsin under  &12 + !   2 array!   intin 2 array!  4 2 3 GDP  ;
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 6 Hexblock 6 
\  circle ellpie ellarc ellipse                        01feb86we
                                                                
: circle   ( x y radius -- )                                    
 ptsin under 8 + !   2 array!   3 0 4 GDP ;                     
                                                                
: ellarc   ( startwinkel endwinkel x y xradius yradius -- )     
 ptsin 4 array!   intin 2 array!   2 2 6 GDP ;                  
                                                                
: ellpie   ( startwinkel endwinkel x y xradius yradius -- )     
 ptsin 4 array!   intin 2 array!   2 2 7 GDP ;                  
                                                                
: ellipse   ( x y xradius yradius -- )                          
 ptsin 4 array!   2 0 5 GDP ;                                   
                                                                
                                                                
                                                                
\ *** Block No. 7 Hexblock 7 
\  rbox rfbox justified                                01feb86we
                                                                
: rbox    ( x1 y1 x2 y2 -- )    ptsin 4 array!   2 0 8 GDP  ;   
                                                                
: rfbox   ( x1 y1 x2 y2 -- )    ptsin 4 array!   2 0 9 GDP  ;   
                                                                
: justified   ( string x y length wordspace charspace -- )      
 intin 2 array!   ptsin 3 array!   4 swap  count dup >r         
 bounds DO  I c@  over intin + !  2+  LOOP drop                 
 2 r> 2+ &10 GDP  ;                                             
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 8 Hexblock 8 
\ Attribute Functions Loadscreen                       27jan86we
                                                                
Onlyforth  GEM also definitions                                 
                                                                
01 07 +thru                                                     
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 9 Hexblock 9 
\  swr_mode Setmode                                    12aug86we
                                                                
: swr_mode   ( mode -- )        intin !   &32 0 1 VDI  ;        
                                                                
                                                                
| : Setmode   ( n -- )          Create ,   Does>  @ swr_mode  ; 
                                                                
1 Setmode overwrite             2 Setmode transparent           
3 Setmode exor                  4 Setmode revtransparent        
                                                                
                                                                
\\                                                              
: scolor                                                        
                                                                
                                                                
                                                                
\ *** Block No. 10 Hexblock A 
\  sl_type Settype sl_udsty                            31jan86we
                                                                
: sl_type   ( style -- )        intin !   &15 0 1 VDI ;         
                                                                
| : Settype   ( n -- )          Create ,    Does>  @ sl_type  ; 
                                                                
1 Settype solid                 2 Settype longdash              
3 Settype dot                   4 Settype dashdot               
5 Settype dash                  6 Settype dashdotdot            
7 Settype userdef                                               
                                                                
: sl_udsty    ( pattern -- )     intin !   &113 0 1 VDI ;       
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 11 Hexblock B 
\  sl_width sl_color sl_ends                           01feb86we
                                                                
: sl_width   ( width -- )        ptsin !   &16 1 0 VDI  ;       
                                                                
: sl_color   ( color -- )        intin !   &17 0 1 VDI  ;       
                                                                
: sl_ends    ( begstyle endstyle -- )                           
 intin 2 array!   &108 0 2 VDI  ;                               
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 12 Hexblock C 
\  sm_type sm_height sm_color                          01feb86we
                                                                
: sm_type   ( symbol -- )       intin !   &18 0 1 VDI  ;        
                                                                
| : Setmtype   ( n -- )         Create ,   Does>  @ sm_type  ;  
                                                                
1 Setmtype point                2 Setmtype plus                 
3 Setmtype asterisk             4 Setmtype square               
5 Setmtype cross                6 Setmtype diamond              
                                                                
: sm_height  ( height -- )                                      
 0 ptsin 2!  &19 1 0 VDI  ;                                     
                                                                
: sm_color   ( color -- )       intin !   &20 0 1 VDI  ;        
                                                                
                                                                
\ *** Block No. 13 Hexblock D 
\  st_height  st_point  st_rotation  st_color          01feb86we
                                                                
: st_height   ( height  -- )                                    
 0 ptsin 2!   &12 1 0 VDI  ;                                    
                                                                
: st_point       ( point -- )    intin !   &107 0 1 VDI  ;      
                                                                
: st_rotation    ( winkel -- )   intin !    &13 0 1 VDI  ;      
                                                                
: st_font        ( font -- )     intin !    &21 0 1 VDI  ;      
                                                                
: st_color       ( color -- )    intin !    &22 0 1 VDI  ;      
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 14 Hexblock E 
\  st_effects  st_alignement                           01feb86we
                                                                
: st_effects   ( effect -- )     intin !   &106 0 1 VDI  ;      
                                                                
: st_alignement   ( horin vertin -- )                           
 intin 2 array!   &39 0 2 VDI  ;                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 15 Hexblock F 
\  sf_interior sf_style sf_color sf_perimeter          31jan86we
                                                                
: sf_interior   ( style  -- )    intin !    &23 0 1 VDI  ;      
                                                                
: sf_style   ( styleindex -- )   intin !    &24 0 1 VDI  ;      
                                                                
: sf_color   ( color -- )        intin !    &25 0 1 VDI  ;      
                                                                
: sf_perimeter   ( pervis -- )   intin !   &104 0 1 VDI  ;      
                                                                
                                                                
\\  sf_udpat                                                    
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 16 Hexblock 10 
\ Raster Operations Loadscreen                         21nov86we
                                                                
Onlyforth  GEM also definitions                                 
                                                                
\needs malloc   include allocate.scr                            
                                                                
                                                                
Create scrMFDB  0 , 0 ,                                         
                                                                
Variable >memMFDB                                               
                                                                
| $4711 Constant magic                                          
                                                                
1 5 +thru                                                       
                                                                
                                                                
\ *** Block No. 17 Hexblock 11 
\ ?allocate onscreen                                   11sep86we
                                                                
| Code ?allocate    >memMFDB R#) D6 move   D6 reg) A0 lea       
   .l A0 ) A0 move   .w magic A0 -) cmpi                        
        0= IF  Next  Assembler  THEN  ;c:                       
   $0.8004 malloc  swap even swap                               
   2dup magic -rot l!  2 extend  d+  >memMFDB @   2! ;          
                                                                
| Code onscreen                                                 
   scrMFDB # D6 move   D6 reg) A0 lea                           
   .l A0 contrl &14 + R#) move   A0 contrl &18 + R#) move       
   Next   end-code                                              
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 18 Hexblock 12 
\ onscreen >screen screen>                             09sep86we
                                                                
| Code >screen                                                  
   >memMFDB R#) D6 move   D6 reg) A0 lea                        
   .l A0 contrl &14 + R#) move                                  
   .w scrMFDB # D6 move   D6 reg) A0 lea                        
   .l A0 contrl &18 + R#) move  ;c:  ?allocate ;                
                                                                
| Code screen>                                                  
   >memMFDB R#) D6 move   D6 reg) A0 lea                        
   .l A0 contrl &18 + R#) move                                  
   .w scrMFDB # D6 move   D6 reg) A0 lea                        
   .l A0 contrl &14 + R#) move  ;c:  ?allocate ;                
                                                                
                                                                
                                                                
\ *** Block No. 19 Hexblock 13 
\ copyraster                                           23aug86we
                                                                
: copyopaque  ( Xfr Yfr width height Xto Yto mode --)           
 intin !  2over 2over d+  ptsin 8 +  4 array!                   
                2over d+  ptsin      4 array!   &109 4 1 VDI ;  
                                                                
: scr>mem    ( addr_of_memMFDB -- )                             
   Create ,  Does>  @ >memMFDB !  screen>  2over 3 copyopaque ; 
                                                                
: mem>scr    ( addr_of_memMFDB -- )                             
   Create ,  Does>  @ >memMFDB !  >screen  2over 3 copyopaque ; 
                                                                
                                                                
\\ scr>mem und mem>scr sind Defining-Words f�r Rasteroperationen
Um mit verschiedenen memMDFBs arbeiten zu k�nnen, m�ssen jeweils
eigene Worte definiert werden. Beispiel: s. n�chster Screen     
\ *** Block No. 20 Hexblock 14 
\  r_trnfm get_pixel                                   09sep86we
                                                                
: scr>scr  ( Xfr Yfr width heigth Xto Yto --)                   
   onscreen 3 copyopaque ;                                      
                                                                
Create memMFDB1  7 , 0 , &640 , &400 , &40 , 0 , 1 ,            
                 0 , 0 , 0 ,                                    
                                                                
memMFDB1 scr>mem scr>mem1  ( Xleft Ytop Width Heigth -- )       
                                                                
memMFDB1 mem>scr mem1>scr  ( Xleft Ytop Width Heigth -- )       
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 21 Hexblock 15 
\  r_trnfm get_pixel                                   26feb86re
                                                                
: r_trnfm  ( -- )   >screen  &110 0 0 VDI ;                     
                                                                
: get_pixel  ( x y -- color flag )                              
 ptsin 2 array!  &105 1 0 VDI  intout 2@ swap ;                 
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 22 Hexblock 16 
\ Input Functions Loadscreen                           12aug86we
                                                                
Onlyforth   GEM also definitions                                
                                                                
 1  5 +thru                                                     
                                                                
\\                                                              
Alle Input-Funktionen sollten von FORTH aus grunds�tzlich im    
Sample-Mode arbeiten, da sonst kein Multitasking m�glich ist.   
Daher sind nur die Sample-Funktionen implementiert. Die Opcodes 
der Request-Funktionen sind aber dieselben, soda� durch Aufruf  
von  sin_mode  auch Request-Funktionen erreichbar sind.         
Zu Beginn eines Programms sollten ansonsten alle Device-Typen   
einmal mit  sin_mode  auf Sample geschaltet werden.             
Werden mehrere Werte zur�ckgegeben, m�ssen dies aus den diversen
Arrays geholt werden.                                           
\ *** Block No. 23 Hexblock 17 
\  sm_locater sm_valuator sm_choice                    12aug86we
                                                                
: sin_mode   ( devtype mode -- )  intin 2 array!  &33 0 2 VDI ; 
                                                                
: sm_locater   ( x y -- status )                                
 ptsin 2 array!  &28 1 0 VDI  #ptsout @  #addrout @ 2*  + ;     
\ status: 0 -> no input         1 -> pos changed                
\         2 -> key pressed      3 -> key pressed and pos changed
                                                                
: sm_valuator  ( val_in -- status )                             
 intin !  &29 0 1 VDI  #addrout @ ;                             
\ status: 0 -> no action;1 -> valuator changed;2 -> key pressed 
                                                                
: sm_choice    ( -- status )                                    
 &30 0 0 VDI  #addrout @ ;                                      
\ status: 0 -> no action        1 -> key pressed                
\ *** Block No. 24 Hexblock 18 
\  sm_string sc_form                                   01feb86we
                                                                
: sm_string   ( addr max_len echomode x y -- status )           
 ptsin 2 array!  intin 2 array!  &31 1 2 VDI                    
 #addrout @ over c!                                             
 #addrout @ 0 ?DO  intout I 2* + 1+ c@  over I + 1+ c!  LOOP    
 drop #addrout @ ;                                              
\ status: 0 -> function aborted  n -> count of string           
\ string wird als counted string bei addr abgelegt              
                                                                
: sc_form   ( addr -- )                                         
 intin &74 cmove  &111 0 &37 VDI  ;                             
\ addr is the adress of a data structure.                       
\ See description in VDI-Manual.                                
                                                                
                                                                
\ *** Block No. 25 Hexblock 19 
\  ex_time show_c hide_c                               02nov86we
                                                                
| : exchange_vecs    ( pusrcode functionno -- long_psavcode )   
     swap >absaddr contrl &14 + 2!    0 0 VDI                   
     contrl &18 + 2@  ;                                         
                                                                
: ex_time   ( tim_addr -- long_otim_addr )                      
   &118 exchange_vecs ;                                         
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 26 Hexblock 1A 
\  q_mouse ex_butv ex_motv ex_curv                     09sep86we
                                                                
: q_mouse   ( -- x y status )                                   
   &124 0 0 VDI  ptsout 2@  intout @ ;                          
                                                                
: ex_butv   ( pusrcode -- long_psavcode )                       
   &125 exchange_vecs ;                                         
                                                                
: ex_motv   ( pusrcode -- long_psavcode )                       
   &126 exchange_vecs ;                                         
                                                                
: ex_curv   ( pusrcode -- long_psavcode )                       
   &127 exchange_vecs ;                                         
                                                                
                                                                
                                                                
\ *** Block No. 27 Hexblock 1B 
\  q_key_s                                             31jan86we
                                                                
: q_key_s   ( -- status )                                       
 &128 0 0 VDI  intout @ ;                                       
\ status: Bit 0 -> Right Shift Key   Bit 1 -> Left Shift Key    
\         Bit 2 -> Control Key       Bit 3 -> Alt Key           
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 28 Hexblock 1C 
\ Inquire Functions Loadscreen                         31jan86we
                                                                
Onlyforth  GEM also definitions                                 
                                                                
01 03 +thru                                                     
                                                                
\\                                                              
Die Werte, die die Inquire-Funktionen zur�ckliefern, m�ssen aus 
den entsprechenden Arrays ausgelesen werden.                    
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 29 Hexblock 1D 
\  q_extnd q_color q_attributes                        01feb86we
                                                                
: q_extnd   ( info_flag -- )    intin !  &102 0 1 VDI ;         
                                                                
: q_color   ( color_index info_flag )                           
 intin 2 array!  &26 0 2 VDI  ;                                 
                                                                
                                                                
| : q_attributes  ( n -- )      0 0 VDI ;                       
                                                                
: ql_attributes   ( -- )        &35 q_attributes ;              
: qm_attributes   ( -- )        &36 q_attributes ;              
: qf_attributes   ( -- )        &37 q_attributes ;              
: qt_attributes   ( -- )        &38 q_attributes ;              
                                                                
                                                                
\ *** Block No. 30 Hexblock 1E 
\  qt_extent qt_width qt_name                          31jan86we
                                                                
: qt_extent   ( string -- )                                     
 0 swap   count dup >r  bounds                                  
    DO  I c@  over intin + !  2+  LOOP drop                     
 &116 0 r> VDI ;                                                
                                                                
: qt_width   ( char -- status )                                 
 intin !  &117 0 1 VDI  intout @ ;                              
\ status: -1 -> char invalid    n -> ADE-Value of char          
                                                                
: qt_name   ( element_num -- )                                  
 intin !  &130 0 1 VDI ;                                        
                                                                
                                                                
                                                                
\ *** Block No. 31 Hexblock 1F 
\  q_cellarray qin_mode qt_fontinfo                    01feb86we
                                                                
: q_cellarray   ( cols rows x1 y1 x2 y2 -- )                    
 ptsin 4 array!  contrl &14 + 2 array!  &27 2 0 VDI ;           
                                                                
: qin_mode   ( dev_type -- mode )                               
 intin !  &115 0 1 VDI  intout @ ;                              
                                                                
: qt_fontinfo   ( -- )          &131 0 0 VDI ;                  
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 32 Hexblock 20 
\ Escapes Loadscreen                                   31jan86we
                                                                
Onlyforth  GEM also definitions                                 
                                                                
01 07 +thru                                                     
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 33 Hexblock 21 
\  ESC normal_ESC                                      31jan86we
                                                                
| : ESC   ( #intin #ptsin functionno -- )                       
   function !  5 -rot VDI ;                                     
                                                                
| : normal_ESC   ( functionno -- )                              
 0 0 rot ESC ;                                                  
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 34 Hexblock 22 
\  q_chcells exit_cur enter_cur cur_primitives         31jan86we
                                                                
: q_chcells   ( -- rows cols )  1 normal_ESC  intout 2@ ;       
                                                                
: exit_cur    ( -- )            2 normal_ESC ;                  
: enter_cur   ( -- )            3 normal_ESC ;                  
                                                                
: curup       ( -- )            4 normal_ESC ;                  
: curdown     ( -- )            5 normal_ESC ;                  
: curright    ( -- )            6 normal_ESC ;                  
: curleft     ( -- )            7 normal_ESC ;                  
: curhome     ( -- )            8 normal_ESC ;                  
                                                                
: eeos        ( -- )            9 normal_ESC ;                  
: eeol        ( -- )          &10 normal_ESC ;                  
                                                                
\ *** Block No. 35 Hexblock 23 
\  s_curaddress curtext rvon rvoff                  26feb86we/re
                                                                
: s_curaddress   ( row col -- )                                 
 intin 2 array!  0 2 &11 ESC ;                                  
                                                                
: curtext  ( addr count -- )                                    
 >r  intin r@  1:2move  0 r> &12 ESC ;                          
                                                                
: rvon    ( -- )                &13 normal_ESC ;                
                                                                
: rvoff   ( -- )                &14 normal_ESC ;                
                                                                
: q_curaddress   ( -- row col )                                 
 &15 normal_ESC  intout 2@ ;                                    
                                                                
                                                                
\ *** Block No. 36 Hexblock 24 
\  q_tabstatus hardcopy dspcur rmcur form_adv          01feb86we
                                                                
: q_tabstatus   ( -- status )   &16 normal_ESC  intout @ ;      
                                                                
: hardcopy      ( -- )          &17 normal_ESC  ;               
                                                                
: dspcur        ( x y -- )      ptsin 2 array!  1 0 &18 ESC  ;  
                                                                
: rmcur         ( -- )          &19 normal_ESC  ;               
                                                                
: form_adv      ( -- )          &20 normal_ESC  ;               
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 37 Hexblock 25 
\  output_window clear_disp_list bit_image s_palette   01feb86we
                                                                
: output_window    ( x1 y1 x2 y2 -- )                           
 ptsin 4 array!  2 0 &21 ESC ;                                  
                                                                
: clear_disp_list  ( -- )       &22 normal_ESC  ;               
                                                                
: bit_image   ( string aspect scaling num_pts x1 y1 x2 y2 -- )  
 ptsin 4 array!  >r  intin 2 array!  4 swap  count dup >r       
 bounds DO  I c@  over intin + !  2+  LOOP drop                 
 r>  r> 2+  &23  VDI ;                                          
                                                                
: s_palette   ( palette -- selected )                           
 intin !  0 1 &60 ESC  intout @ ;                               
                                                                
                                                                
\ *** Block No. 38 Hexblock 26 
\  s_palette qp_films qp_state sp_state sp_save etc.   31jan86we
                                                                
: qp_films   ( -- )             &91 normal_ESC  ;               
: qp_state   ( -- )             &92 normal_ESC  ;               
                                                                
: sp_state   ( addr -- )                                        
 intin &40 cmove  0 &20 &93 ESC  ;                              
\ adr is the adress of a data structure                         
                                                                
: sp_save    ( -- )             &94 normal_ESC  ;               
                                                                
: sp_message   ( -- )           &95 normal_ESC  ;               
                                                                
: qp_error     ( -- )           &96 normal_ESC  ;               
                                                                
                                                                
\ *** Block No. 39 Hexblock 27 
\  meta_extents write_meta m_filename                  31jan86we
                                                                
: meta_extents   ( x1 y1 x2 y2 -- )                             
 ptsin 4 array!  2 0 &98 ESC ;                                  
                                                                
: write_meta     ( intin num_intin ptsin num_ptsin -- )         
 dup 2/ >r  ptsin swap cmove    dup >r  intin swap cmove        
 r> r> swap  &99 ESC ;                                          
                                                                
: m_filename     ( string -- )                                  
 0 swap  count dup >r                                           
 bounds DO  I c@  over intin + !  2+  LOOP  0 swap intin + !    
 0 r> &100 ESC  ;                                               
                                                                
                                                                
                                                                
\ *** Block No. 40 Hexblock 28 
\ Demo fuer VDI                                        02feb86we
                                                                
Onlyforth  GEM also definitions                                 
                                                                
Create logo   ," volksFORTH 83"                                 
                                                                
: textdemo    clrwk  exor  1 st_font   1 st_color               
              &0 st_rotation     &13 st_effects                 
              80 0 DO  2 0 DO  J 4 / st_height                  
                  logo $80 20 J + 80 J 2* + 1 1 justified  LOOP 
              4 +LOOP  logo $80 $A0 180 1 1 justified ;         
                                                                
: rahmen      0 0 sl_ends   10 sl_width                         
              60 70  210 70  210 $C0  60 $C0  60 70  5 pline ;  
                                                -->             
                                                                
\ *** Block No. 41 Hexblock 29 
\ Kreis mit Mustern                                    02feb86we
                                                                
: torte                                                         
 2 sf_interior   1 sf_perimeter   1 sf_color                    
   9 sf_style      0 &450 &100 &300  &80 pie                    
 &07 sf_style  &450 &1000 &100 &300  &80 pie                    
 &12 sf_style &1000 &2400 &100 &300  &80 pie                    
 &19 sf_style &2400 &3600 &100 &300  &80 pie  ;                 
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
: tdemo         grinit  page  textdemo rahmen torte  grexit ;   
                                                                
