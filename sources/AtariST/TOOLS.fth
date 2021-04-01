\ *** Block No. 0 Hexblock 0 
\\                       *** Tools ***                 25may86we
                                                                
In diesem File sind die wichtigsten Debugging-Tools enthalten.  
                                                                
Dazu geh�ren ein einfacher Decompiler, ein Speicherdump und     
der Tracer (s. Kapitel im Handbuch)                             
Vor allem der Tracer hat sich als sehr sinnvolles Werkzeug bei  
der Fehlerbek�mpfung entwickelt. Normalerweise sind Fehlerquel- 
len beim Tracen sofort auffindbar, manchmal allerdings auch     
nicht ganz so schnell ...                                       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ Loadscreen for simple decompiler                     26oct86we
                                                                
Onlyforth    Vocabulary Tools  Tools also definitions           
                                                                
1 5 +thru                                                       
  6 +load     \ Tracer                                          
                                                                
Onlyforth                                                       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ Tools for decompiling                                26oct86we
                                                                
| : ?:     dup 4 u.r ." :" ;                                    
| : @?     dup @ 6 u.r ;                                        
| : c?     dup c@ 3 .r ;                                        
                                                                
: s   ( adr - adr+ )                                            
   ?: space  c? 3 spaces  dup 1+ over c@ type                   
   dup c@ + 1+ even ;                                           
                                                                
: n   ( adr - adr+2 )    ?: @? 2 spaces  dup @ >name .name 2+ ; 
: k   ( adr - adr+2 )    ?: 5 spaces @? 2+ ;                    
: b   ( adr - adr+1)     ?: @? dup @ over + 5 u.r 2+ ;          
                                                                
                                                                
                                                                
\ *** Block No. 3 Hexblock 3 
\ Tools for decompiling                                26oct86we
                                                                
: d   ( adr n - adr+n)                                          
   2dup swap ?:  swap  0 DO c? 1+ LOOP  2 spaces  -rot type ;   
                                                                
: c   ( adr - adr+1)     1 d ;                                  
                                                                
                                                                
\\                                                              
: dump ( adr n -) bounds ?DO cr I 10 d drop stop? IF LEAVE      
THEN 10 +LOOP ;                                                 
                                                                
                                                                
                                                                
\ dekompiliere  String Name Konstant Char Branch Dump           
\               =      =    =        =    =      =              
\ *** Block No. 4 Hexblock 4 
\ General Dump Utility - Output                        26oct86we
                                                                
| : .2      ( n -- )       0  <#   # #   #>   type  space ;     
| : .6      ( d -- )       <#  # # # # # #  #>  type ;          
| : d.2     ( addr len -- )      bounds ?DO  I c@  .2  LOOP ;   
| : emit.   ( char -- )     $7F and                             
         dup bl $7E uwithin not IF drop Ascii . THEN  emit ;    
                                                                
| : dln   ( addr --- )                                          
     cr  dup 6 u.r  2 spaces  8 2dup d.2  space                 
     over + 8 d.2  space   $10 bounds ?DO  I c@ EMIT.  LOOP  ;  
| : ?.n    ( n1 n2 -- n1 )                                      
     2dup = IF  ." \/"  drop  ELSE  2 .r  THEN   space ;        
| : ?.a    ( n1 n2 -- n1 )                                      
     2dup = IF  ." v"  drop   ELSE  1 .r  THEN ;                
                                                                
\ *** Block No. 5 Hexblock 5 
\ Longdump  basics                                     24aug86we
                                                                
| : ld.2   ( hiaddr loaddr len -- hiaddr )                      
     bounds ?DO  I over lc@ .2  LOOP  ;                         
                                                                
| : ldln   ( hiaddr loaddr  -- )                                
     cr  dup >r  over   .6  2 spaces                            
     r@ 8 ld.2 space   r@ 8 + 8 ld.2 space                      
     r> $10 bounds ?DO  I over lc@ emit.  LOOP drop ;           
                                                                
| : .head   ( addr len -- addr' len' )                          
      swap  dup -$10 and  swap  $0F and  cr 8 spaces            
      8 0 DO  I ?.n  LOOP  space  $10 8 DO  I ?.n  LOOP         
      space  $10 0 DO  I ?.a  LOOP  rot + ;                     
                                                                
                                                                
\ *** Block No. 6 Hexblock 6 
\ Dump and Fill Memory Utility                         10sep86we
                                                                
Forth definitions                                               
                                                                
: ldump   ( laddr len -- )                                      
   base push hex   >r swap r>  .head                            
   bounds ?DO  dup I ldln  stop? IF  LEAVE  THEN                
               I $FFF0 = IF  1+  THEN  $10 +LOOP drop ;         
                                                                
: dump   ( addr len -- )                                        
   base push  hex    .head                                      
   bounds ?DO  I dln  stop? IF  LEAVE  THEN  $10 +LOOP ;        
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 7 Hexblock 7 
\ Trace Loadscreen                                     26oct86we
                                                                
Onlyforth       \needs Tools    Vocabulary Tools                
Tools also definitions                                          
                                                                
\needs cpush   1 +load                                          
\needs >absaddr                 : >absaddr   0  forthstart d+ ; 
                                                                
2 8 +thru                                                       
                                                                
Onlyforth                                                       
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 8 Hexblock 8 
\ throw status on Return-Stack                         26oct86we
                                                                
| Create: cpull                                                 
      rp@ count  2dup + even rp!  r> swap cmove ;               
                                                                
: cpush  ( addr len --)   r> -rot  over >r                      
      rp@ over 2+ -  even dup rp!  place  cpull >r  >r ;        
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 9 Hexblock 9 
\ Variables do-trace                                   10sep86we
                                                                
| Variable (W           \ Variable for saving W                 
| Variable <ip          \ start of trace trap range             
| Variable ip>          \ end of trace trap range               
| Variable nest?        \ True if NEST shall performed          
| Variable newnext      \ Address of new Next for tracing       
| Variable last'        \ holds adr of position in traced word  
| Variable #spaces      \ for indenting nested trace            
| Variable trap?        \ True if trace is allowed              
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 10 Hexblock A 
\ install Tracer                                       11sep86we
                                                                
Label trnext   0 # D6 move   .l 0 D6 FP DI) jmp  end-code       
                                                                
Label (do-trace      newnext R#) D0 move  D0 trnext 2+ R#) move 
   .w trnext # D6 move   .l D6 reg) A0 lea    A0 D5 move        
   .w UP R#) D6 move                                            
   .l ' next-link >body c@ D6 FP DI) D6 .w move                 
   BEGIN   .l D6 reg) A1 lea   .w D6 tst  0<>                   
   WHILE   .w &10 # A1 suba   .l D5 A0 move                     
              A0 )+ A1 )+ move   A0 )+ A1 )+ move               
              .w 2 A1 addq   A1 ) D6 move                       
   REPEAT  rts   end-code                                       
                                                                
  Code do-trace  \ opposite of end-trace                        
     (do-trace bsr   Next end-code                              
\ *** Block No. 11 Hexblock B 
\ reenter tracer                                       04sep86we
                                                                
| : oneline   .status space query interpret  -&82 allot         
              rdrop  ( delete quit from tracenext ) ;           
                                                                
| Code (step                                                    
      RP )+ D7 move   .l D7 IP lmove   FP IP adda               
      .w (W R#) D7 move    -1 # trap? R#) move                  
Label fnext                                                     
      D7 reg) D6 move  D6 reg) jmp  end-code                    
                                                                
| Create: nextstep   (step ;                                    
                                                                
: (debug  ( addr -- )   \ start tracing at addr                 
 dup  <ip !  BEGIN  1+ dup @   ['] unnest =  UNTIL  2+ ip> ! ;  
                                                                
\ *** Block No. 12 Hexblock C 
\ check trace conditions                               10sep86we
                                                                
Label tracenext   tracenext newnext !                           
   IP )+ D7 move                                                
   trap? R#) tst    fnext beq                                   
   .b nest? R#) D0 move  \ byte order!!                         
   0= IF    .l IP D0 move   FP D0 sub                           
            .w <ip R#) D0 cmp  fnext bcs                        
               ip> R#) D0 cmp  fnext bhi                        
      ELSE  .b 0 # nest? R#) move  THEN  \ low byte still set   
                                                                
                            \ one trace condition satisfied     
  .w D7 (W R#) move     trap? R#) clr                           
                                                                
                                                                
                                                                
\ *** Block No. 13 Hexblock D 
\ tracer display                                       26oct86we
                                                                
;c:  nest? @                                                    
     IF  nest? off   r>  ip> push  <ip push  dup 2- (debug      
         #spaces push  1 #spaces +!  >r   THEN                  
 r@  nextstep >r  input push  output push  standardi/o          
 2-   dup last' !                                               
 cr #spaces @ spaces    dup 5 u.r   @ dup 6 u.r   2 spaces      
 >name .name    $1C col -  0 max spaces       .s                
 state push    blk push    >in push    ['] 'quit >body push     
 [ ' >interpret >body ] Literal push                            
 #tib push    tib #tib @ cpush    r0 push    rp@ r0 !           
 &82 allot    ['] oneline Is 'quit    quit ;                    
                                                                
                                                                
                                                                
\ *** Block No. 14 Hexblock E 
\ DEBUG with errorchecking                             11sep86we
                                                                
| : traceable  ( cfa -- adr)                                    
 recursive  dup @                                               
 ['] : @    case? ?exit                                         
 ['] key @  case? IF  >body c@  Input @ + @  traceable exit THEN
 ['] type @ case? IF  >body c@ Output @ + @  traceable exit THEN
 ['] r/w  @ case? IF  >body  @               traceable exit THEN
 drop dup @ @ $4EAB =  IF  @ 4+  exit  THEN \ 68000 voodoo code 
 >name .name ." can't be DEBUGged" quit ;                       
                                                                
: nest                  \ trace next high-level word executed   
    last' @ @ traceable drop  nest? on ;                        
                                                                
: unnest                \ ends tracing of actual word           
    <ip on  ip> off ;   \ clears trap range                     
\ *** Block No. 15 Hexblock F 
\ misc. words for tracing                              bp 9Mar86
                                                                
: endloop               \ sets trap range next current word     
    last' @ 4+ <ip ! ;  \ used to skip LOOPs, REPEATs, ...      
                                                                
' end-trace  Alias unbug                                        
                                                                
Forth definitions                                               
                                                                
: debug  ( --)          \ reads a word                          
      '  traceable  Tools   (debug                              
      nest? off  trap? on  #spaces off  do-trace ;              
                                                                
: trace' (  --)         \ traces fol. word                      
    debug  <ip perform  end-trace ;                             
                                                                
