\ *** Block No. 0 Hexblock 0 
\\ *** Volksforth System - Sourcecode ***              cas201301
                                                                
This file contains the full sourcecode for the volksFORTH-83    
kernal.                                                         
                                                                
The source is compiled using the volksForth target compiler. The
source contains instructions for the target compiler that will  
not end up in the final Forth system.                           
                                                                
                                                                
See the documentation on http://fossil.forth-ev.de/volksforth   
for information on how to compile a new Forth kernel from       
the source.                                                     
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ Atari 520 ST    Forth loadscreen                     cas201301
\ volksFORTH-83 was developed by K. Schleisiek, B. Pennemann    
\ G. Rehfeld & D. Weineck                                       
\ Atari ST - Version by D. Weineck                              
\ Atari ST/STE/TT/Falcon/FireBee Version by C. Strotmann        
                                                                
Onlyforth                                                       
                                                                
        0 dup displace !                                        
Target definitions here!                                        
                                                                
   $82 +load                                                    
 1 $76 +thru                                                    
                                                                
cr .unresolved  ' .blk is .status                               
                                                                
\ *** Block No. 2 Hexblock 2 
\ FORTH Preamble and ID                                cas202007
                                                                
Assembler                                                       
0 FP D) jmp   here 2- >label >cold                              
0 FP D) jmp   here 2- >label >restart                           
here dup origin!                                                
\ Initial cold-start values for user variables                  
                                                                
0 # D6 move   D6 reg) jmp   \ for multitasker                   
$100 allot                                                      
                                                                
| Create logo    ," volksFORTH-83  rev. 3.85.2"                 
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 3 Hexblock 3 
\ Assembler Labels & Macros  Next                      cas201301
                                                                
Compiler  Assembler also definitions                            
                                                                
H : Next       .w IP )+ D7 move      \ D7 contains cfa          
                  D7 reg) D6 move    \ D6 contains cfa@         
                  D6 reg) jmp  .w    \ jump to cfa@             
               there Tnext-link H @  T ,  H Tnext-link !  ;     
                                                                
Target                                                          
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 4 Hexblock 4 
\ recover noop                                         06sep86we
                                                                
Create recover   Assembler                                      
   .l A7 )+ D7 move   FP IP suba   .w IP RP -) move             
   .l D7 IP move   0 D7 moveq   Next end-code                   
                                                                
Compiler Assembler also definitions                             
                                                                
H : ;c:   0 T recover R#) jsr  end-code   ] H ;                 
                                                                
Target                                                          
                                                                
Code noop  Next end-code                                        
                                                                
                                                                
                                                                
\ *** Block No. 5 Hexblock 5 
\ User Variables                                       14sep86we
                                                                
Constant origin   &10 uallot drop  \ For multitasker            
User s0                                                         
User r0                                                         
User dp                                                         
User offset            0 offset !                               
User base              $10 base !                               
User output                                                     
User input                                                      
User errorhandler       \ pointer for abort" -code              
User voc-link                                                   
User udp                \ points to next free addr in User      
User next-link          \ points to next Next                   
                                                                
                                                                
\ *** Block No. 6 Hexblock 6 
\ end-trace                                            11sep86we
                                                                
Variable UP                                                     
                                                                
Label fnext  IP )+ D7 move   D7 reg) D6 move   D6 reg) jmp      
                                                                
Code end-trace                                                  
   fnext # D6 move   .l D6 reg) A0 lea    A0 D5 move            
   .w UP R#) D6 move   .l user' next-link D6 FP DI) D6 .w move  
   BEGIN   .l D6 reg) A1 lea   .w D6 tst  0<>                   
   WHILE   .w &10 # A1 suba   .l D5 A0 move                     
              A0 )+ A1 )+ move   A0 )+ A1 )+ move               
              .w 2 A1 addq   A1 ) D6 move                       
   REPEAT  fnext bra   end-code                                 
                                                                
                                                                
\ *** Block No. 7 Hexblock 7 
\ manipulate system pointers                           09sep86we
                                                                
Code sp@   ( -- addr )    .l SP D6 move   FP D6 sub             
                          .w D6 SP -) move   Next end-code      
                                                                
Code sp!   ( addr -- )    SP )+ D6 move   $FFFE D6 andi         
                          D6 reg) SP lea  Next end-code         
                                                                
Code up@   ( -- addr )    UP R#) SP -) move   Next end-code     
                                                                
Code up!   ( addr -- )    SP )+ D0 move   $FFFE D0 andi         
                          D6 UP R#) move  Next end-code         
                                                                
Code forthstart  ( -- laddr )   .l FP SP -) move   Next end-code
                                                                
                                                                
\ *** Block No. 8 Hexblock 8 
\ manipulate returnstack                               05sep86we
                                                                
Code rp@   ( -- addr )    .l RP D6 move   FP D6 sub             
                          .w D6 SP -) move   Next end-code      
                                                                
Code rp!   ( addr -- )    SP )+ D6 move   $FFFE D6 andi         
                          D6 reg) RP lea  Next end-code         
                                                                
Code >r    ( 16b -- )     SP )+ RP -) move                      
                          Next end-code restrict                
                                                                
Code r>    ( -- 16b )     RP )+ SP -) move                      
                          Next end-code restrict                
                                                                
                                                                
                                                                
\ *** Block No. 9 Hexblock 9 
\ r@ rdrop  exit  unnest ?exit                         04sep86we
                                                                
Code r@    ( -- 16b )      RP ) SP -) move   Next end-code      
                                                                
Code rdrop                 2 RP addq   Next end-code restrict   
                                                                
Code exit                  RP )+ D7 move   .l D7 IP move        
                           FP IP adda   Next end-code           
                                                                
Code unnest                RP )+ D7 move   .l D7 IP move        
                           FP IP adda   Next end-code           
                                                                
Code ?exit ( flag -- )     SP )+ tst   0<> IF   RP )+ D7 move   
                           .l D7 IP move   FP IP adda  THEN     
                           Next end-code                        
\\ : ?exit ( flag -- )     IF rdrop THEN ;                      
\ *** Block No. 10 Hexblock A 
\ execute  perform                                     04sep86we
                                                                
Code execute   ( cfa -- )                                       
   SP )+ D7 move   D7 reg) D6 move   .l D6 reg) jmp   end-code  
                                                                
: perform   ( addr -- )      @ execute ;                        
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 11 Hexblock B 
\ c@   c! ctoggle                                      04sep86we
                                                                
Code c@   ( addr -- 8b )                                        
   SP )+ D6 move   D6 reg) A0 lea   0 D0 moveq                  
   .b A0 ) D0 move   .w D0 SP -) move    Next end-code          
                                                                
Code c!   ( 16b addr -- )                                       
   SP )+ D6 move   D6 reg) A0 lea                               
   SP )+ D0 move   .b D0 A0 ) move    Next end-code             
                                                                
: ctoggle   ( 8b addr --)      under c@ xor swap c! ;           
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 12 Hexblock C 
\ @ ! 2@ 2!                                            04sep86we
                                                                
Code @   ( addr -- 16b )                                        
   SP )+ D6 move   D6 reg) A0 lea                               
   .b 1 A0 D) SP -) move   A0 ) SP -) move                      
   Next  end-code                                               
                                                                
Code !   ( 16b addr -- )                                        
   SP )+ D6 move   D6 reg) A0 lea                               
   .b SP )+ A0 )+ move   SP )+ A0 )+ move                       
   Next end-code                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 13 Hexblock D 
\ 2@ 2!                                                04sep86we
                                                                
Code 2@    ( addr -- 32b )                                      
   SP )+ D6 move   D6 reg) A0 lea                               
   .b 3 A0 D) SP -) move   2 A0 D) SP -) move                   
      1 A0 D) SP -) move   A0 ) SP -) move   Next end-code      
                                                                
Code 2!   ( 32b addr -- )                                       
   SP )+ D6 move   D6 reg) A0 lea                               
   .b SP )+ A0 )+ move   SP )+ A0 )+ move                       
      SP )+ A0 )+ move   SP )+ A0 )+ move   Next end-code       
                                                                
\\                                                              
: 2@            ( adr -- 32b)   dup 2+ @   swap @ ;             
: 2!            ( 32b adr --)   rot over 2+ ! ! ;               
                                                                
\ *** Block No. 14 Hexblock E 
\ lc@  lc!  l@  l!                                     24may86we
                                                                
Code lc@   ( laddr -- 8b )                                      
   .l SP )+ A0 move   0 D0 moveq   .b A0 ) D0 move              
   .w D0 SP -) move      Next end-code                          
Code lc!   ( 8b laddr -- )                                      
   .l SP )+ A0 move   .w SP )+ D0 move  .b D0 A0 ) move         
   Next end-code                                                
                                                                
Code l@   ( laddr -- n )                                        
   .l SP )+ A0 move   .b A0 )+ D0 move  .w 8 # D0 lsl           
   .b A0 ) D0 move   .w D0 SP -) move   Next end-code           
Code l!   ( n laddr -- )                                        
   .l SP )+ A0 move  .w SP )+ D0 move   .b D0 1 A0 D) move      
   .w 8 # D0 lsr   .b D0 A0 ) move    Next end-code             
                                                                
\ *** Block No. 15 Hexblock F 
\ lcmove                                               10sep86we
                                                                
Code lcmove   ( fromladdr toladdr count -- )                    
   SP )+ D0 move   .l SP )+ A0 move   SP )+ A1 move             
   .w D0 tst 0<> IF  1 D0 subq                                  
       D0 DO  .b A1 )+ A0 )+ move  LOOP  THEN  Next end-code    
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 16 Hexblock 10 
\ l2@ l2!                                              cas201301
                                                                
Code l2@   ( laddr -- 32bit )                                   
  .l SP )+ A0 move   .b A0 )+ D0 move  .l 8 # D0 lsl            
  .b A0 )+ D0 move .l 8 # D0 lsl  .b A0 )+ D0 move .l 8 # D0 lsl
  .b A0  ) D0 move  .l D0 SP -) move  Next end-code             
                                                                
Code l2!   ( 32bit laddr -- )                                   
  .l SP )+ A0 move   SP )+ D0 move                              
  .l 8 # D0 rol .b D0 A0 )+ move  .l 8 # D0 rol .b D0 A0 )+ move
  .l 8 # D0 rol .b D0 A0 )+ move  .l 8 # D0 rol .b D0 A0 )+ move
 Next end-code                                                  
                                                                
Code ln+!   ( n laddr -- )      \ only even addresses allowed   
   .l SP )+ A0 move   A0 ) A1 move   .w SP )+ A1 adda           
   .l A1 A0 ) move   Next end-code                              
\ *** Block No. 17 Hexblock 11 
\ +! drop swap                                         05sep86we
                                                                
Code +!   ( n addr -- )                                         
   SP )+ D6 move   D6 reg) A0 lea   2 A0 addq   2 SP addq       
   4 # move>ccr   .b SP -) A0 -) addx   SP -) A0 -) addx        
   .w 2 SP addq   Next end-code                                 
                                                                
                                                                
Code drop   ( 16b -- )       2 SP addq    Next end-code         
                                                                
Code swap   ( 16b1 16b2 -- 16b2 16b1 )                          
   .l SP ) D0 move   D0 swap   D0 SP ) move    Next end-code    
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 18 Hexblock 12 
\ dup  ?dup                                            20mar86we
                                                                
Code dup    ( 16b -- 16b 16b )    SP ) SP -) move  Next end-code
                                                                
Code ?dup   ( 16b -- 16b 16b / false )                          
   SP ) tst   0<> IF   SP ) SP -) move   THEN      Next end-code
                                                                
                                                                
                                                                
\\                                                              
: ?dup ( 16b -- 16b 16b / false) dup IF dup THEN ;              
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 19 Hexblock 13 
\ over rot nip under                                bp 11 oct 86
                                                                
Code over   ( 16b1 16b2 - 16b1 16b3 16b1 )                      
   2 SP D) SP -) move   Next end-code                           
Code rot    ( 16b1 16b2 16b3 - 16b2 16b3 16b1 )                 
   SP )+ D1 move   SP )+ D2 move   SP  ) D0 move                
   D2 SP  ) move   D1 SP -) move   D0 SP -) move                
   Next end-code                                                
Code nip    ( 16b1 16b2 -- 16b2 )                               
   SP )+ SP )  move    Next end-code                            
Code under  ( 16b1 16b2 - 16b2 16b1 16b2 )                      
   .l SP ) D0 move   D0 swap   D0 SP ) move   .w D0 SP -) move  
   Next end-code                                                
\\                                                              
: nip       ( 16b1 16b2 -- 16b2)              swap drop ;       
: under     ( 16b1 16b2 -- 16b2 16b1 16b2)    swap over ;       
\ *** Block No. 20 Hexblock 14 
\ -rot nip pick roll                                bp 11 oct 86
                                                                
Code -rot   ( 16b1 16b2 16b3 -- 16b3 16b1 16b2 )                
   SP )+ D2 move   SP )+ D0 move   SP  ) D1 move                
   D2 SP  ) move   D1 SP -) move   D0 SP -) move                
   Next end-code                                                
Code pick   ( n -- 16b.n )                                      
   .l D0 clr   .w SP )+ D0 move   D0 D0 add                     
   0 D0 SP DI) SP -) move    Next end-code                      
: roll   ( n -- )                                               
   dup >r   pick   sp@ dup 2+   r> 1+  2*  cmove>  drop ;       
: -roll   ( n -- )    >r dup   sp@ dup 2+                       
   dup 2+  swap  r@  2*  cmove   r> 1+ 2* +  ! ;                
\\                                                              
: pick    ( n -- 16b.n )                        1+ 2* sp@ + @ ; 
: -rot    ( 16b1 16b2 16b3 -- 16b3 16b1 16b2 )  rot rot ;       
\ *** Block No. 21 Hexblock 15 
\ double word stack manip.                            bp 12oct86
                                                                
Code 2swap    ( 32b1 32b2 -- 32b2 32b1 )                        
      .l SP )+ D0 move   SP ) D1 move   D0 SP ) move            
         D1 SP -) move  Next end-code                           
Code 2dup     ( 32b -- 32b 32b )                                
      .l SP ) SP -) move   Next end-code                        
Code 2over   ( 32b1 32b2  -- 32b1 32b2 32b1 )                   
     .l 4 SP D) SP -) move   Next end-code                      
                                                                
Code 2drop    ( 32b -- )        4 SP addq  Next end-code        
                                                                
\\  : 2swap ( 32b1 32b2 -- 32b2 32b1) rot >r rot r> ;           
    : 2drop ( 32b -- ) drop drop ;                              
    : 2dup ( 32b -- 32b 32b) over over ;                        
                                                                
\ *** Block No. 22 Hexblock 16 
\ + and or xor not                                     19mar86we
                                                                
Code +     ( n1 n2 -- n3 )                                      
   SP )+ D0 move   D0 SP ) add    Next end-code                 
                                                                
Code or    ( 16b1 16b2 -- 16b3 )                                
   SP )+ D0 move   D0 SP ) or     Next end-code                 
                                                                
Code and   ( 16b1 16b2 -- 16b3 )                                
   SP )+ D0 move   D0 SP ) and    Next end-code                 
                                                                
Code xor   ( 16b1 16b2 -- 16b3 )                                
   SP )+ D0 move   D0 SP ) eor    Next end-code                 
                                                                
Code not   ( 16b1 -- 16b2 )       SP ) not    Next end-code     
                                                                
\ *** Block No. 23 Hexblock 17 
\ -  negate                                            19mar86we
                                                                
Code -    ( n1 n2 -- n3 )                                       
   SP )+ D0 move   D0 SP ) sub   Next end-code                  
                                                                
Code negate ( n1 -- n2 )     SP ) neg   Next end-code           
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 24 Hexblock 18 
\ double arithmetic                                    cas201301
                                                                
Code dnegate   ( d1 -- -d1 )     .l SP ) neg   Next end-code    
                                                                
Code d+        ( d1 d2 -- d3 )                                  
   .l SP )+ D0 move   D0 SP ) add   Next end-code               
                                                                
Code d-   ( d1 d2 -- d1-d2 )                                    
   .l SP )+ D0 move   D0 SP ) sub   Next  end-code              
                                                                
Code d*   ( d1 d2 -- d1*d2 )                                    
   .l SP )+ D0 move   SP )+ D1 move                             
   D0 D2 move   D0 D3 move   D3 swap   D1 D4 move   D4 swap     
   D1 D0 mulu   D3 D1 mulu   D4 D2 mulu                         
   D0 swap   .w D1 D0 add   .w D2 D0 add   .l D0 swap           
   D0 SP -) move   Next end-code                                
\ *** Block No. 25 Hexblock 19 
\ 1+ 2+ 3+ 4+ 6+    1- 2- 4-                           18nov86we
                                                                
Code 1+     ( n1 -- n2 )      1 SP ) addq  Next end-code        
Code 2+     ( n1 -- n2 )      2 SP ) addq  Next end-code        
Code 3+     ( n1 -- n2 )      3 SP ) addq  Next end-code        
Code 4+     ( n1 -- n2 )      4 SP ) addq  Next end-code        
| Code 6+   ( n1 -- n2 )      6 SP ) addq  Next end-code        
Code 1-     ( n1 -- n2 )      1 SP ) subq  Next end-code        
Code 2-     ( n1 -- n2 )      2 SP ) subq  Next end-code        
Code 4-     ( n1 -- n2 )      4 SP ) subq  Next end-code        
                                                                
                                                                
: on   ( addr -- )   true  swap ! ;                             
: off  ( addr -- )   false swap ! ;                             
                                                                
                                                                
\ *** Block No. 26 Hexblock 1A 
\ number Constants                                  bp 18nov86we
                                                                
Code true  ( -- -1 )   -1 # SP -) move  Next end-code           
Code false ( -- 0 )     0 # SP -) move  Next end-code           
Code 1     ( -- 1 )     1 # SP -) move  Next end-code           
Code 2     ( -- 2 )     2 # SP -) move  Next end-code           
Code 3     ( -- 3 )     3 # SP -) move  Next end-code           
Code 4     ( -- 4 )     4 # SP -) move  Next end-code           
                                                                
' true Alias -1              ' false Alias 0                    
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 27 Hexblock 1B 
\ words for number literals                            19mar86we
                                                                
Code lit   ( -- 16b )    IP )+ SP -) move    Next end-code      
                                                                
: Literal  ( 16b -- )    compile lit   , ; immediate restrict   
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 28 Hexblock 1C 
\ comparision code words                               19mar86we
                                                                
Label yes   true # SP ) move Next    Label no   SP ) clr Next   
                                                                
Code 0<    ( n -- flag )     SP ) tst  yes bmi  no bra  end-code
                                                                
Code 0=    ( 16b -- flag )   SP ) tst  yes beq  no bra  end-code
                                                                
Code <     ( n1 n2 -- flag ) SP )+ D0 move   SP ) D0 cmp        
                             yes bgt   no bra   end-code        
                                                                
Code u<    ( u1 u2 -- flag ) SP )+ D0 move   SP ) D0 cmp        
                             yes bhi   no bra   end-code        
                                                                
: uwithin  ( u1 [low up[ -- flag )                              
                             rot under u> -rot u> not and ;     
\ *** Block No. 29 Hexblock 1D 
\ comparision code words                               25mar86we
                                                                
Code >    ( n1 n2 -- flag )     SP )+ D0 move   SP ) D0 cmp     
                                yes blt   no bra   end-code     
                                                                
Code 0>   ( n -- flag )         SP ) tst   yes bgt   no bra     
                                end-code                        
                                                                
Code 0<>  ( n -- flag )         SP ) tst   yes bne   no bra     
                                end-code                        
                                                                
Code u>   ( u1 u2 -- flag )     SP )+ D0 move   SP ) D1 move    
                                D0 D1 cmp   yes bhi   no bra    
                                end-code                        
Code =    ( n1 n2 -- flag )     SP )+ D0 move   SP ) D0 cmp     
                                yes beq   no bra   end-code     
\ *** Block No. 30 Hexblock 1E 
\ comparision words                                    20mar86we
                                                                
: d0=   ( d -- flag )        or  0= ;                           
: d=    ( d1 d2 -- flag )    dnegate d+  d0= ;                  
: d<    ( d1 d2 -- flag )    rot 2dup - IF    > nip nip         
                                        ELSE  2drop u<  THEN ;  
                                                                
                                                                
\\                                                              
: 0<                        8000 and 0<> ;                      
: >    ( n1 n2 -- flag )    swap < ;                            
: 0>   ( n -- flag )        negate 0< ;                         
: 0<>  ( n -- flag )        0= not ;                            
: u>   ( u1 u2 -- flag )    swap u< ;                           
: =    ( n1 n2 -- flag )    - 0= ;                              
                                                                
\ *** Block No. 31 Hexblock 1F 
\ min max umax umin extend dabs abs                    18nov86we
                                                                
| Code minimax    ( n1 n2 f -- n )                              
    SP )+ tst   0<> IF  SP ) 2 SP D) move  THEN   2 SP addq     
    Next  end-code                                              
                                                                
: min      ( n1 n2 -- n3 )      2dup  > minimax ;               
: max      ( n1 n2 -- n3 )      2dup  < minimax ;               
: umax     ( u1 u2 -- u3 )      2dup u< minimax ;               
: umin     ( u1 u2 -- u3 )      2dup u> minimax ;               
: extend   ( n -- d )           dup 0< ;                        
: dabs     ( d -- ud )          extend IF dnegate THEN ;        
: abs      ( n -- u)            extend IF  negate THEN ;        
\\                                                              
: minimax  ( n1 n2 flag -- n3 )                                 
   rdrop   IF  swap  THEN   drop ;                              
\ *** Block No. 32 Hexblock 20 
\ loop primitives                                      19mar86we
                                                                
| : dodo              rdrop r> 2+ dup >r rot >r swap >r >r ;    
                                                                
: (do  ( limit start -- )  over -  dodo ;           restrict    
: (?do ( limit start -- )  over -  ?dup IF  dodo  THEN          
                           r> dup  @ +  >r drop ;   restrict    
                                                                
: bounds ( start count -- limit start )     over + swap ;       
                                                                
Code endloop               6 RP addq   Next end-code   restrict 
                                                                
                                                                
                                                                
\\ dodo puts "index | limit | adr.of.DO" on return-stack        
                                                                
\ *** Block No. 33 Hexblock 21 
\ (loop (+loop                                         04sep86we
                                                                
Code (loop                                                      
   1 RP ) addq                                                  
    CC IF  4 RP D) D6 move  D6 reg) IP lea  THEN                
   Next end-code   restrict                                     
                                                                
Code (+loop                                                     
   SP )+ D0 move   D0 D1 move   D0 RP ) add                     
   1 # D1 roxr   D0 D1 eor                                      
     0>=  IF 4 RP D) D6 move  D6 reg) IP lea  THEN              
   Next end-code   restrict                                     
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 34 Hexblock 22 
\ loop indices                                         20mar86we
                                                                
Code I   ( -- n )                                               
   RP ) D0 move      2 RP D) D0 add   D0 SP -) move             
   Next end-code                                                
                                                                
Code J   ( -- n )                                               
   6 RP D) D0 move   8 RP D) D0 add   D0 SP -) move             
   Next end-code                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 35 Hexblock 23 
\ branch ?branch                                       06sep86we
                                                                
Code branch                                                     
Label bran1    IP ) IP adda    Next end-code                    
                                                                
Code ?branch   ( fl -- )   SP )+ tst   bran1 beq   2 IP addq    
                             Next  end-code                     
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 36 Hexblock 24 
\ resolve loops and branches                           19mar86we
                                                                
: >mark     ( -- addr )          here  0 , ;                    
: >resolve  ( addr -- )          here  over - swap ! ;          
: <mark     ( -- addr )          here ;                         
: <resolve  ( addr -- )          here -  , ;                    
: ?pairs    ( n1 n2 -- )         - abort" unstructured" ;       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 37 Hexblock 25 
\ case?                                                19mar86we
                                                                
Code case? ( 16b1 16b2 -- 16b1 false / true )                   
   SP )+ D0 move   SP ) D0 cmp   yes beq   SP -) clr            
   Next   end-code                                              
                                                                
                                                                
\\                                                              
: case? ( 16b1 16b2 -- 16b1 false / true )                      
 over = dup  IF nip THEN ;                                      
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 38 Hexblock 26 
\ Branching                                            24nov85we
                                                                
: IF             compile ?branch >mark 1 ; immediate restrict   
: THEN           abs 1 ?pairs >resolve ;   immediate restrict   
: ELSE           1 ?pairs compile branch >mark swap             
                 >resolve -1 ;             immediate restrict   
: BEGIN          <mark 2 ;                 immediate restrict   
: WHILE          2 ?pairs 2 compile ?branch >mark               
                 -2 2swap ;                immediate restrict   
| : (reptil      <resolve                                       
                 BEGIN dup -2 = WHILE drop >resolve REPEAT ;    
: REPEAT         2 ?pairs compile branch (reptil ;              
                                           immediate restrict   
: UNTIL          2 ?pairs compile ?branch (reptil ;             
                                           immediate restrict   
                                                                
\ *** Block No. 39 Hexblock 27 
\ Loops                                                24nov85we
                                                                
: DO        compile  (do >mark 3 ;       immediate restrict     
: ?DO       compile (?do >mark 3 ;       immediate restrict     
: LOOP      3 ?pairs compile  (loop compile endloop >resolve ;  
                                         immediate restrict     
: +LOOP     3 ?pairs compile (+loop compile endloop >resolve ;  
                                         immediate restrict     
: LEAVE     endloop r> 2- dup @ + >r ;             restrict     
                                                                
                                                                
\\ Returnstack: calladr | index limit | adr of DO               
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 40 Hexblock 28 
\ Multiplication                                       18nov86we
                                                                
Code um* ( u1 u2 -- ud )                                        
   SP )+ D0 move   SP )+ D0 mulu   .l D0 SP -) move             
   Next end-code                                                
                                                                
Code *   ( n1 n2 -- n )                                         
   SP )+ D0 move   SP )+ D0 mulu   D0 SP -) move                
   Next end-code                                                
                                                                
: m*  ( n1 n2 -- d )    dup 0<   dup >r   IF  negate  THEN      
   swap dup   0< IF  negate r> not >r  THEN                     
   um*   r> IF  dnegate  THEN ;                                 
                                                                
Code 2*  ( n -- 2*n )   SP ) asl   Next end-code                
Code 2/  ( n -- n/2 )   SP ) asr   Next end-code                
\ *** Block No. 41 Hexblock 29 
\ Division                                             cas201301
                                                                
label divovl    ;c: true abort" division overflow" ;            
                                                                
Label (m/mod    \ d(D2) n(D0)  -- mod quot                      
  .l A7 )+ A0 move   \ get addr from stack                      
  .w D0 D1 move    D0 D3 move                                   
  .l D1 ext                                                     
     D2 D1 eor   0< IF  D2 neg   .w D0 neg  THEN                
     D0 D2 divs   divovl bvs                                    
  .w D2 D0 move   D2 swap   .l D1 tst                           
     0< IF  .w D2 tst   0<> IF   1 D0 subq    \ quot = quot - 1 
                         D3 D2 sub   D2 neg    \ rem = n - rem  
        THEN   THEN                                             
  .w D2 SP -) move   D0 SP -) move                              
  .l A0 ) jmp        \ adr. from /0-TRAPS leads to a GEM crash  
\ *** Block No. 42 Hexblock 2A 
\ um/mod m/mod /mod                                    18nov86we
                                                                
Code um/mod   ( d1 n1 -- rem quot )                             
   SP )+ D0 move   .l SP )+ D1 move   D0 D1 divu                
   divovl bvs                                                   
   D1 swap   D1 SP -) move   Next end-code                      
                                                                
Code m/mod     ( d n -- mod quot )                              
   SP )+ D0 move  .l SP )+ D2 move  (m/mod bsr   Next end-code  
                                                                
Code /mod      ( n1 n2 -- mod quot )                            
   SP )+ D0 move   SP )+ D2 move  .l D2 ext                     
   (m/mod bsr   Next end-code                                   
                                                                
                                                                
                                                                
\ *** Block No. 43 Hexblock 2B 
\ / mod                                                18nov86we
                                                                
Code /        ( n1 n2 -- quot )                                 
   SP )+ D0 move   SP )+ D2 move   .l D2 ext                    
   .w D0 D1 move   D2 D1 eor         \ SHORT way !              
   0< IF  (m/mod bsr   SP )+ SP ) move   Next    THEN           
   D0 D2 divs   divovl bvs  D2 SP -) move   Next end-code       
                                                                
Code mod       ( n1 n2 -- mod )                                 
   SP )+ D0 move   SP )+ D2 move   .l D2 ext                    
   .w D0 D1 move   D2 D1 eor          \ SHORT way !             
   0<  IF  (m/mod bsr   2 SP addq   Next   THEN                 
   D0 D2 divs   divovl bvs                                      
   D2 swap   D2 SP -) move   Next end-code                      
                                                                
                                                                
\ *** Block No. 44 Hexblock 2C 
\ */mod */ u/mod  ud/mod                               18nov86we
                                                                
: */mod  ( n1 n2 n3 -- rem quot )   >r  m*  r>   m/mod ;        
: */     ( n1 n2 n3 -- quot )       */mod nip ;                 
: u/mod  ( u1 u2 -- urem uquot )    0 swap   um/mod ;           
: ud/mod ( ud1 u2 -- urem udquot )  >r  0 r@ um/mod  r> swap >r 
                                    um/mod   r> ;               
                                                                
\\                                                              
: /mod   ( n1 n2 -- rem quot )      >r  extend  r>   m/mod ;    
: /      ( n1 n2 --     quot )      /mod nip ;                  
: mod    ( n1 n2 -- rem )           /mod drop ;                 
: m/mod ( d n -- mod quot )                                     
   dup >r   abs over   0< IF  under + swap  THEN   um/mod  r@ 0<
       IF  negate  over IF  swap  r@ +  swap 1-  THEN  THEN     
   rdrop ;                                                      
\ *** Block No. 45 Hexblock 2D 
\ cmove cmove>                                         04sep86we
                                                                
Code cmove    ( from to count -- )                              
   SP )+ D0 move   SP )+ D6 move   D6 reg) A0 lea               
                   SP )+ D6 move   D6 reg) A1 lea               
   D0 tst   0<> IF   1 D0 subq                                  
     D0 DO   .b A1 )+ A0 )+ move   LOOP   THEN                  
   Next end-code                                                
                                                                
Code cmove>   ( from to count -- )                              
   SP )+ D0 move                                                
   SP )+ D6 move   D0 D6 add   D6 reg) A0 lea                   
   SP )+ D6 move   D0 D6 add   D6 reg) A1 lea                   
   D0 tst   0<> IF   1 D0 subq                                  
     D0 DO   .b A1 -) A0 -) move   LOOP   THEN                  
   Next end-code                                                
\ *** Block No. 46 Hexblock 2E 
\ move place count                                  bp 11 oct 86
                                                                
: move   ( from to quan -- )                                    
   >r   2dup u< IF  r> cmove>  exit  THEN   r> cmove ;          
                                                                
: place  ( addr len to --)                                      
   over >r  rot over 1+  r> move   c! ;                         
                                                                
Code count ( adr -- adr+1 len )                                 
   SP ) D6 move   D6 reg) A0 lea                                
   D0 clr  .b A0 )+ D0 move   .w 1 SP ) addq   D0 SP -) move    
   Next  end-code                                               
                                                                
                                                                
\\                                                              
: count    ( adr -- adr+1 len )      dup 1+ swap c@ ;           
\ *** Block No. 47 Hexblock 2F 
\ fill erase                                        bp 11 oct 86
                                                                
Code fill   ( addr quan 8b -- )                                 
   SP )+ D0 move   SP )+ D1 move                                
   SP )+ D6 move   D6 reg) A0 lea                               
   D1 tst   0<> IF                                              
     1 D1 subq   D1 DO  .b D0 A0 )+ move   LOOP   THEN          
   Next end-code                                                
                                                                
: erase   ( addr quan --)            0 fill ;                   
                                                                
                                                                
\\                                                              
: fill    ( addr quan 8b -- )                                   
   swap ?dup IF  >r over c! dup 1+ r> 1- cmove exit  THEN       
   2drop ;                                                      
\ *** Block No. 48 Hexblock 30 
\ , c,                                                 08sep86we
                                                                
Code ,     ( 8b -- )            UP R#) D6 move                  
   .l user' dp D6 FP DI) D6 .w move   D6 reg) A0 lea            
   .b SP )+ A0 )+ move   SP )+ A0 )+ move                       
   .w UP R#) D6 move   .l 2 user' dp D6 FP DI) .w addq          
   Next end-code                                                
                                                                
Code c,    ( 8b -- )            UP R#) D6 move                  
   .l user' dp D6 FP DI) D6 .w move   D6 reg) A0 lea            
   SP )+ D0 move   .b D0 A0 )+ move                             
   .w UP R#) D6 move   .l 1 user' dp D6 FP DI) .w addq          
   Next end-code                                                
\\                                                              
: ,      ( 16b -- )              here  !  2 allot ;             
: c,     ( 8b -- )               here c!  1 allot ;             
\ *** Block No. 49 Hexblock 31 
\ allot pad compile                                    08sep86we
                                                                
Code here   ( -- addr )                                         
   UP R#) D6 move   .l user' dp D6 FP DI) SP -) .w move         
   Next end-code                                                
                                                                
Code allot    ( n -- )      UP R#) D6 move   SP )+ D0 move      
   D0 .l user' dp D6 FP DI) .w add   Next end-code              
                                                                
: pad    ( -- addr )            here $42 + ;                    
                                                                
: compile                       r>  dup 2+  >r   @ , ; restrict 
\\                                                              
: here   ( -- addr )             dp @ ;                         
: allot  ( n -- )                                               
   dup  here +  up@  u> abort" Dictionary full"  dp +! ;        
\ *** Block No. 50 Hexblock 32 
\ input strings                                        25mar86we
                                                                
Variable #tib     0 #tib !                                      
Variable >tib     here >tib !  &80 allot                        
Variable >in      0 >in !                                       
Variable blk      0 blk !                                       
Variable span     0 span !                                      
                                                                
: tib ( -- addr )        >tib @ ;                               
                                                                
: query           tib &80 expect  span @ #tib !                 
                  >in off  blk off ;                            
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 51 Hexblock 33 
\ scan skip /string                                    16nov85we
                                                                
: /string ( addr0 len0 +n - addr1 len1 )                        
   over umin  rot over +  -rot  - ;                             
                                                                
                                                                
                                                                
                                                                
\\                                                              
: scan ( addr0 len0 char -- addr1 len1 )    >r                  
   BEGIN   dup WHILE  over c@  r@ - WHILE  1-  swap  1+  swap   
   REPEAT   rdrop ;                                             
                                                                
: skip ( addr len del -- addr1 len1 )       >r                  
   BEGIN   dup WHILE  over c@  r@ = WHILE  1-  swap  1+  swap   
   REPEAT   rdrop ;                                             
\ *** Block No. 52 Hexblock 34 
\ skip scan                                            04sep86we
                                                                
Label done  .l FP A0 suba  .w A0 SP -) move  D1 SP -) move Next 
Code skip   ( addr len del -- addr1 len1 )                      
   SP )+ D0 move   SP )+ D1 move   1 D1 addq                    
   SP )+ D6 move   D6 reg) A0 lea                               
   BEGIN   1 D1 subq  0<>                                       
   WHILE   .b A0 ) D2 move   D2 D0 cmp   done bne   .w 1 A0 addq
   REPEAT  done bra   end-code                                  
                                                                
Code scan   ( addr len chr -- addr1 len1 )                      
   SP )+ D0 move   SP )+ D1 move   1 D1 addq                    
   SP )+ D6 move   D6 reg) A0 lea                               
   BEGIN   1 D1 subq  0<>                                       
   WHILE   .b A0 ) D2 move   D2 D0 cmp   done beq   .w 1 A0 addq
   REPEAT  done bra   end-code                                  
\ *** Block No. 53 Hexblock 35 
\ convert to upper case                                04sep86we
                                                                
Label umlaut                                                    
   Ascii  c,   Ascii  c,   Ascii  c,                         
   Ascii  c,   Ascii  c,   Ascii  c,                         
                                                                
Label (capital   ( D1 -> D1 )                                   
   D1 7 # btst   0= IF                                          
                    .b Ascii a D1 cmpi   >= IF   Ascii z D1 cmpi
                       <= IF   bl D1 subi   THEN  THEN   rts    
                    THEN   umlaut R#) A1 lea                    
   2 D2 moveq   D2 DO  .b A1 ) D1 cmp                           
               0= IF  .w 3 A1 addq   .b A1 ) D1 move  rts  THEN 
          .w 1 A1 addq   LOOP  rts   end-code                   
                                                                
                                                                
\ *** Block No. 54 Hexblock 36 
\ capital capitalize                                bp 11 oct 86
                                                                
Code capital    ( char -- char' )                               
   SP ) D1 move    (capital bsr   D1 SP ) move   Next end-code  
                                                                
Code capitalize ( string -- string )                            
   SP ) D6 move   D6 reg) A0 lea                                
   D0 clr   .b A0 )+ D0 move                                    
   0<> IF   1 D0 subq   D0 DO                                   
                    A0 ) D1 move  (capital bsr   D1 A0 )+ move  
                             LOOP  THEN   Next end-code         
                                                                
                                                                
\\                                                              
: capitalize    ( string -- string)                             
   dup count bounds ?DO  I c@  capital  I c!  LOOP ;            
\ *** Block No. 55 Hexblock 37 
\ (word                                             bp 11 oct 86
                                                                
Code (word     ( char adr0 len0 -- addr )                       
   D1 clr   SP )+ D0 move   D0 D4 move                          
   SP )+ D6 move   D6 reg) A0 lea   SP ) D2 move                
   >in R#) D3 move   D3 A0 adda   D3 D0 sub                     
      <= IF    D4 >in R#) move                                  
         ELSE  1 D0 addq  BEGIN  1 D0 subq 0<>                  
                   WHILE  .b A0 ) D2 cmp 0=                     
                   WHILE  .l 1 A0 addq   REPEAT   THEN          
              A0 A1 move  .w 1 D0 addq                          
                   BEGIN  .w 1 D0 subq 0<>                      
                   WHILE  .b A0 ) D2 cmp 0<>                    
                   WHILE  .w 1 A0 addq  1 D1 addq   REPEAT  THEN
       .w D1 tst  0<> IF  1 A0 addq  THEN                       
       .l FP A0 suba   D6 A0 suba   .w A0 >in R#) move   THEN   
\ *** Block No. 56 Hexblock 38 
\ (word Part2                                       bp 11 oct 86
                                                                
   UP R#) D6 move   .l user' dp D6 FP DI) D6 .w move            
   D6 reg) A0 lea   D6 SP ) move                                
   .b D1 A0 )+ move   .w 1 D1 subq                              
     0>= IF  D1 DO  .b A1 )+ A0 )+ move   LOOP   THEN           
   bl # A0 ) move    Next end-code                              
                                                                
                                                                
\\                                                              
: word    ( char -- addr)                                       
   >r  source over swap   >in @ /string                         
   r@ skip   over swap   r> scan >r                             
   rot over swap -  r>  0<> -                                   
   >in !  over -  here dup >r   place                           
   bl r@ count + c!   r> ;                                      
\ *** Block No. 57 Hexblock 39 
\ even source word parse name                         bp 11oct86
                                                                
: even     ( addr -- addr1 )      dup 1 and + ;                 
                                                                
Variable loadfile      0 loadfile !                             
                                                                
: source   ( -- addr len )        blk @  ?dup                   
    IF  loadfile @ (block  b/blk   exit  THEN   tib #tib @ ;    
                                                                
: word     ( char -- addr )       source (word ;                
                                                                
: parse    ( char -- addr len )                                 
    >r   source   >in @  /string   over swap  r> scan >r        
    over -  dup r>  0<> -   >in +! ;                            
                                                                
: name     ( -- addr )             bl word capitalize exit ;    
\ *** Block No. 58 Hexblock 3A 
\ state Ascii ,"  ("  "                                15jun86we
                                                                
Variable state        0 state !                                 
                                                                
: Ascii  ( char -- n )                                          
   bl word  1+ c@  state @ IF  [compile] Literal  THEN ;        
                                         immediate              
                                                                
: ,"       Ascii " parse  here over 1+  allot  place ;          
: "lit     r> r>  under  count +  even  >r >r ;    restrict     
: ("       "lit ;                                  restrict     
: "        compile (" ,"  align ;        immediate restrict     
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 59 Hexblock 3B 
\ ." ( .( \ \\ hex decimal                             25mar86we
                                                                
: (."      "lit count type ;                       restrict     
: ."       compile (." ,"  align ;       immediate restrict     
: (        ascii ) parse 2drop ;         immediate              
: .(       ascii ) parse type ;          immediate              
: \        >in @ c/l / 1+ c/l * >in ! ;  immediate              
: \\       b/blk >in ! ;                 immediate              
: \needs   name find nip IF  [compile] \  THEN ;                
                                                                
: hex      $10 base ! ;                                         
: decimal  &10 base ! ;                                         
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 60 Hexblock 3C 
\ number conversion: digit?                            cas201301
                                                                
| Variable ptr       \ points into string                       
                                                                
Label   fail     SP ) clr  Next                                 
Code digit?    ( char -- n true : false )                       
   UP R#) D6 move   .l user' base D6 FP DI) D0 .w move          
   SP ) D1 move   .b Ascii 0 D1 subi   fail bmi    &10 D1 cmpi  
     0>= IF   $11 D1 cmpi   fail bmi   7 D1 subq   THEN         
   D0 D1 cmp   fail bpl   .w D1 SP ) move   true # SP -) move   
   Next  end-code                                               
\\                                                              
: digit? ( char -- digit true/ false )                          
   Ascii 0 -  dup 9 u> IF  [ Ascii A Ascii 9 - 1- ] Literal -   
   dup   9 u> IF [ 2swap ( unstructured ) ] THEN                
   base @   over u> ?dup  ?exit  THEN   drop false ;            
\ *** Block No. 61 Hexblock 3D 
\ number conversion:  accumulate  convert              11sep86we
                                                                
Code accumulate   ( +d0 addr digit -- +d1 addr )                
   0 D0 moveq   SP )+ D0 move                                   
   2 SP D) D1 move   4 SP D) D2 move                            
   UP R#) D6 move   .l user' base D6 FP DI) D3 .w move          
   D3 D2 mulu   D3 D1 mulu   .l D1 swap   .w D1 clr             
   .l D2 D1 add   D0 D1 add   D1 2 SP D) move    Next end-code  
                                                                
: convert ( +d1 addr0 -- +d2 addr2 )                            
   1+  BEGIN   count  digit? WHILE   accumulate   REPEAT   1- ; 
                                                                
                                                                
\\                                                              
: accumulate ( +d0 adr digit - +d1 adr )                        
   swap >r swap  base @  um* drop rot  base @  um* d+ r> ;      
\ *** Block No. 62 Hexblock 3E 
\ number conversion: end? char previous                25mar86we
                                                                
| : end?   ( -- flag )                   ptr @ 0= ;             
| : char       ( addr0 -- addr1 char )   count -1 ptr +! ;      
| : previous   ( addr0 -- addr0 char )   1- count ;             
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 63 Hexblock 3F 
\ number conversion: ?nonum punctuation?               25mar86we
                                                                
| : ?nonum    ( flag -- exit if true )                          
     IF  rdrop 2drop drop rdrop   false  THEN ;                 
                                                                
| : punctuation?   ( char -- flag )                             
     Ascii , over =   swap   Ascii . =   or ;                   
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 64 Hexblock 40 
\ number conversion: fixbase?                          25mar86we
                                                                
| : fixbase?  ( char - char false / newbase true )              
     Ascii & case? IF  &10 true exit  THEN                      
     Ascii $ case? IF  $10 true exit  THEN                      
     Ascii H case? IF  $10 true exit  THEN                      
     Ascii % case? IF    2 true exit  THEN     false ;          
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 65 Hexblock 41 
\ number conversion: ?num ?dpl                         25mar86we
                                                                
Variable dpl      -1 dpl !                                      
                                                                
| : ?num      ( flag -- exit if true )                          
     IF  rdrop drop   r> IF  dnegate  THEN                      
         rot drop   dpl @ 1+ ?dup ?exit   drop  true  THEN ;    
                                                                
| : ?dpl     dpl @   -1 = ?exit   1 dpl +! ;                    
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 66 Hexblock 42 
\ (number  number                                      11sep86we
                                                                
: number?   ( string - string false / n 0< / d 0> )             
   base push   dup count ptr !   dpl on                         
   0 >r ( +sign)   0 0 rot   end? ?nonum   char                 
   Ascii - case?  IF  rdrop   true >r   end? ?nonum   char  THEN
   fixbase?       IF  base !            end? ?nonum   char  THEN
   BEGIN   digit? 0= ?nonum                                     
     BEGIN   accumulate  ?dpl end? ?num  char  digit?  0=  UNTIL
    previous   punctuation?  0= ?nonum  dpl off  end? ?num  char
   REPEAT ;                                                     
                                                                
: number ( string -- d )                                        
   number? ?dup 0= abort" ?"   0< IF  extend  THEN ;            
                                                                
                                                                
\ *** Block No. 67 Hexblock 43 
\ hide reveal immediate restrict                       24nov85we
                                                                
Variable last     0 last !                                      
| : last?   ( -- false / acf true)    last @ ?dup ;             
: hide                     last?  IF  2- @ current @ !  THEN ;  
: reveal                   last?  IF  2-   current @ !  THEN ;  
: Recursive                reveal ; immediate restrict          
                                                                
| : flag!    ( 8b --)                                           
   last?  IF  under c@ or over c!  THEN   drop  ;               
                                                                
: immediate     $40 flag! ;                                     
: restrict      $80 flag! ;                                     
                                                                
                                                                
                                                                
\ *** Block No. 68 Hexblock 44 
\ clearstack hallot heap heap?                      bp 11 oct 86
                                                                
Code clearstack                                                 
   UP R#) D6 move  .l user' s0 D6 FP DI) D6 .w move             
   $FFFE D6 andi   D6 reg) SP lea   Next end-code  \ mu Code   
                                                                
: hallot ( quan -- )    s0 @  over -  swap    sp@ 2+  dup rot   
       dup 1 and   ?dup  IF  over  0< IF  negate  THEN +  THEN  
   - dup s0 !  2 pick  over -  move  clearstack    s0 ! ;       
                                                                
: heap    ( -- addr )        s0 @ 6 + ;                         
: heap?   ( addr -- flag )   heap up@ uwithin ;                 
                                                                
| : heapmove   ( from -- from )                                 
     dup  here over -  dup hallot                               
     heap swap cmove   heap over - last +!  reveal ;            
\ *** Block No. 69 Hexblock 45 
\ Does>  ;                                             24sep86we
                                                                
Label (dodoes>                                                  
   .l FP IP suba    .w IP RP -) move    A7 )+ IP lmove          
   2 D7 addq   D7 SP -) move   Next end-code                    
                                                                
| : (;code          r> last @ name> ! ;                         
                                                                
: Does>                                                         
   compile (;code  $4EAB ,   compile (dodoes> ;                 
   immediate restrict                                           
                                                                
\ Does> compiles (;code and JSR (doedoes> FP D)                 
                                                                
                                                                
                                                                
\ *** Block No. 70 Hexblock 46 
\ ?head  | alignments  warning exists?                 15jun86we
                                                                
Variable ?head     0 ?head !                                    
                                                                
: |                ?head @  ?exit  -1 ?head ! ;                 
                                                                
                                                                
: align        here  1 and  allot ;                             
: halign       heap  1 and  hallot ;                            
                                                                
Variable warning    0 warning !                                 
| : exists?         warning @ ?exit   last @   current @        
     (find nip IF  space last @ .name ." exists " ?cr  THEN ;   
                                                                
                                                                
                                                                
\ *** Block No. 71 Hexblock 47 
\ Create                                               06sep86we
                                                                
: blk@     blk @ ;                                              
Defer makeview          ' blk@ Is makeview                      
                                                                
: Create                                                        
   align      here  makeview ,  current @ @ ,                   
   name c@   dup 1 $20 uwithin  not abort" invalid name"        
   here last !    1+ allot   align                              
   exists?   ?head @                                            
    IF  1 ?head +!   dup ,            \ Pointer to Code         
        halign   heapmove $20 flag! dp !                        
    ELSE  drop  THEN   reveal 0 ,                               
   ;Code  2 D7 addq    D7 SP -) move  Next end-code             
                                                                
                                                                
\ *** Block No. 72 Hexblock 48 
\ nfa?                                                 04sep86we
                                                                
Code nfa?   ( thread cfa -- nfa | false )                       
   SP )+ D2 move   SP )+ D6 move   D6 reg) A0 lea  .w           
   BEGIN  A0 ) D6 move   0= IF  SP -) clr   Next  THEN          
          .l D6 reg) A0 lea   2 D6 addq   D6 reg) A1 lea        
          .b A1 ) D0 move   .w $1F D0 andi  1 D0 addq           
             D0 D1 move  1 D1 andi  D1 D0 add  D0 D6 add        
          .b A1 ) D0 move   .w $20 D0 andi  0<>                 
             IF  D6 reg) D6 move  THEN                          
             D2 D6 cmp  0= UNTIL                                
   .l FP A1 suba   .w A1 SP -) move   Next end-code             
                                                                
\\ : nfa?    ( thread cfa -- nfa / false)                       
      >r   BEGIN @ dup 0= IF  rdrop exit  THEN                  
             dup 2+ name> r@ = UNTIL  2+ rdrop ;                
\ *** Block No. 73 Hexblock 49 
\ >name name> >body .name                              14sep86we
                                                                
: >name   ( cfa -- nfa / false )        voc-link                
   BEGIN   @ dup WHILE   2dup 4- swap nfa?                      
           ?dup IF  -rot 2drop  exit  THEN   REPEAT   nip ;     
                                                                
| : (name>   ( nfa -- cfa )      count  $1F and  +  even ;      
                                                                
: name>   ( nfa -- cfa )                                        
   dup  (name> swap  c@ $20 and IF  @  THEN  ;                  
                                                                
: >body   ( cfa -- pfa )       2+ ;                             
                                                                
: .name   ( nfa -- )                                            
   ?dup IF  dup heap?  IF ." |" THEN                            
            count $1F and type   ELSE   ." ???"  THEN  space ;  
\ *** Block No. 74 Hexblock 4A 
\ : ; Constant Variable                               bp 12oct86
                                                                
: Create:   Create  hide  current @ context ! ] 0  ;            
                                                                
: :    Create:                                                  
       ;Code  .l FP IP suba   .w IP RP -) move                  
              .l 2 D7 FP DI) IP lea    Next end-code            
                                                                
: ;        0 ?pairs   compile unnest   [compile] [   reveal ;   
           immediate restrict                                   
                                                                
: Constant      Create   ,                                      
       ;Code   .l 2 D7 FP DI) .w SP -) move  Next end-code      
                                                                
: 2Constant     Create , ,  does>  2@ ;                         
                                                                
\ *** Block No. 75 Hexblock 4B 
\ uallot User Alias                                   bp 12oct86
                                                                
: Variable         Create 2 allot ;                             
: 2Variable        Create 4 allot ;                             
                                                                
: uallot   ( quan -- offset )                                   
   dup   udp @ +   $FF u> abort" Userarea full"                 
   udp @ swap udp +! ;                                          
                                                                
: User     Create   udp @ 1 and udp +!   2 uallot   c,          
   ;Code   UP R#) D0 move  0 D1 moveq  .l 2 D7 FP DI) .b D1 move
          .w D1 D0 add   D0 SP -) move   Next end-code          
                                                                
: Alias ( cfa -- )                                              
   Create   last @  dup c@ $20 and                              
   IF  -2 allot  ELSE  $20 flag!  THEN   (name> ! ;             
\ *** Block No. 76 Hexblock 4C 
\ vp current context also toss                         19mar86we
                                                                
Create vp  $10 allot             Variable current               
                                                                
: context   ( -- addr )             vp dup @ + 2+ ;             
                                                                
| : thru.vocstack ( -- from to )    vp 2+ context ;             
\ "Only Forth also Assembler" gives                             
\ vp:  countword = 6 | Only | Forth | Assembler |               
                                                                
: also          vp @   &10 > error" Vocabulary stack full"      
                context @  2 vp +!  context ! ;                 
                                                                
: toss          vp @ IF  -2 vp +!  THEN ;                       
                                                                
                                                                
\ *** Block No. 77 Hexblock 4D 
\ Vocabulary Forth Only Onlyforth                      24nov85we
                                                                
: Vocabulary                                                    
   Create    0 , 0 ,   here   voc-link @ ,   voc-link !         
   Does>   context ! ;                                          
\  | Name | Code | Thread | Coldthread | Voc-link |             
                                                                
Vocabulary Forth                                                
Vocabulary Only                                                 
] Does>  [ Onlypatch ]  0 vp !  context !  also ;  ' Only !     
                                                                
: Onlyforth        Only Forth also definitions ;                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 78 Hexblock 4E 
\ definitions order words                              24nov85we
                                                                
: definitions            context @ current ! ;                  
| : .voc   ( adr -- )    @ 2-   >name .name ;                   
: order                  thru.vocstack   DO   I .voc   -2 +LOOP 
                         2 spaces   current .voc ;              
                                                                
: words          context @                                      
   BEGIN   @ dup stop? 0= and                                   
   WHILE   ?cr dup 2+ .name space   REPEAT   drop ;             
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 79 Hexblock 4F 
\ found -text                                       bp 11 oct 86
                                                                
| : found ( nfa -- cfa n )                                      
     dup c@ >r   (name> r@ $20 and  IF  @       THEN            
                     -1 r@ $80 and  IF  1-      THEN            
                        r> $40 and  IF  negate  THEN  ;         
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 80 Hexblock 50 
\ (find                                             bp 11 oct 86
     \ A0: thread  A1: string  A2: nfa in thread  D0: count     
     \ D1: act. char   D3: act. nfa    D4: string               
Label notfound    SP -) clr   Next                              
                                                                
Code (find ( str thr - str false/ NFA true )                    
  .w SP )+ D6 move   D6 reg) A0 lea                             
     SP )  D6 move   D6 reg) A1 lea                             
  .b A1 ) D0 move   .w $1F D0 andi   A1 D4 lmove                
     D4 0 # btst   0= IF   1 D0 addq                            
Label findloop    D4 A1 lmove                                   
  BEGIN    A0 ) D6 move   notfound beq   D6 reg) A0 lea         
     .w A1 ) D1 move                                            
     .l 2 D6 FP DI) D1 .w sub  $1FFF D1 andi  0= UNTIL          
     .l 2 D6 FP DI) A2 lea   A2 D3 move                         
        2 A1 addq   2 A2 addq                                   
\ *** Block No. 81 Hexblock 51 
\ (find part 2                                         09sep86we
                                                                
   .w 0 D2 moveq  BEGIN   2 D2 addq   D2 D0 cmp >               
                WHILE   A1 )+ A2 )+ cmpm   findloop bne   REPEAT
   ELSE                                                         
Label findloop1   A0 ) D6 move  notfound beq                    
   .l D6 reg) A0 lea   2 D6 FP DI) A2 lea                       
      A2 D3 move    D4 A1 move                                  
   .b A1 )+ D1 move   A2 )+ D1 sub   $1F D1 andi  findloop1 bne 
   D0 D1 move  BEGIN   1 D1 subq   0>=                          
               WHILE   A1 )+ A2 )+ cmpm   findloop1 bne   REPEAT
   THEN                                                         
   .l FP D3 sub   .w D3 SP ) move                               
   true # SP -) move   Next end-code                            
                                                                
                                                                
\ *** Block No. 82 Hexblock 52 
\ find  ' [']                                          cas201301
                                                                
: find    ( string -- cfa n / string false )                    
   context dup @   over 2- @   = IF  2-  THEN                   
   BEGIN   under @ (find IF  nip found   exit  THEN             
     over  vp 2+  u> WHILE  swap  2-  REPEAT   nip false ;      
                                                                
: '    ( -- cfa )      name find 0= abort" ?" ;                 
                                                                
: [compile]            ' , ;                 immediate restrict 
                                                                
: [']                  ' [compile] Literal ; immediate restrict 
                                                                
: nullstring?   ( string -- string false / true )               
                       dup c@  0= dup IF  nip  THEN  ;          
                                                                
\ *** Block No. 83 Hexblock 53 
\ >interpret                                           24sep86we
                                                                
Label jump                                                      
   .l 2 D7 FP DI) .w D6 move   D6 reg) IP lea   2 IP addq       
   Next end-code                                                
                                                                
Create >interpret   2 allot     jump ' >interpret !             
                                                                
\ make >interpret to special Defer                              
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 84 Hexblock 54 
\ interpret interactive                                cas201301
                                                                
Defer notfound                                                  
: no.extensions  ( string -- )   error" ?" ; \ string not 0     
' no.extensions Is notfound                                     
                                                                
: interpret       >interpret ;                                  
                                                                
| : interpreter      ?stack name find ?dup                      
     IF  1 and  IF execute   >interpret THEN                    
       abort" compile only" THEN                                
     nullstring? ?exit                                          
     number? 0= IF  notfound  THEN >interpret ;                 
                                                                
' interpreter  >interpret !                                     
                                                                
\ *** Block No. 85 Hexblock 55 
\ compiling [ ]                                        22mar86we
                                                                
| : compiler         ?stack name find ?dup                      
     IF  0> IF  execute >interpret  THEN    , >interpret THEN   
     nullstring? ?exit                                          
     number? ?dup                                               
     IF  0> IF  swap [compile] Literal  THEN  [compile] Literal 
     >interpret   THEN                                          
     notfound  >interpret ;                                     
                                                                
: [      ['] interpreter Is >interpret  state off ; immediate   
: ]      ['] compiler    Is >interpret  state on ;              
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 86 Hexblock 56 
\  Defer Is                                            24sep86we
                                                                
| : crash           true abort" crash" ;                        
                                                                
: Defer     Create   ['] crash ,                                
   ;Code    .l 2 D7 FP DI) .w D7 move                           
            D7 reg) D6 move   .l D6 reg) jmp  end-code          
                                                                
: (is      r> dup 2+ >r   @  ! ;                                
                                                                
| : def?  ( cfa -- )    @  ['] notfound @ over =                
                     swap  ['] >interpret @    =   or           
       not abort" not deferred" ;                               
                                                                
: Is   ( adr -- )     ' dup def? >body                          
   state @ IF  compile (is  ,  exit  THEN   ! ; immediate       
\ *** Block No. 87 Hexblock 57 
\ ?stack                                               08sep86we
                                                                
| : stackfull ( -- )                                            
     depth $20 > abort" tight stack"    reveal   last?          
        IF  dup heap? IF  name>  ELSE 4-  THEN  (forget  THEN   
     true abort" Dictionary full" ;                             
                                                                
Code ?stack                                                     
    UP R#) D6 move   .l user' dp D6 FP DI) D0 .w move           
    .l SP D1 move   FP D1 sub   .w D0 D1 sub   $100 D1 cmpi     
       $6200 ( u<= )   IF  ;c: stackfull ;   Assembler  THEN    
  .l user' s0 D6 FP DI) D0 .w move   .l SP D1 move   FP D1 sub  
  .w D1 D0 cmp  0>= IF Next THEN ;c: true abort" Stack empty" ; 
                                                                
\\ : ?stack     sp@ here - $100 u< IF stackfull THEN            
             sp@ s0 @ u> abort" Stack empty" ;                  
\ *** Block No. 88 Hexblock 58 
\ .status push load                                    28aug86we
                                                                
Defer .status   ' noop Is .status                               
                                                                
| Create: pull         r> r> ! ;                                
                                                                
: push   ( addr -- )   r> swap dup >r  @ >r   pull >r >r ;      
                       restrict                                 
                                                                
                                                                
: (load   ( blk offset -- )     over 0= IF  2drop exit  THEN    
   isfile push  loadfile push  fromfile push  blk push  >in push
   >in !  blk !   isfile @ loadfile !   .status   interpret ;   
                                                                
: load    ( blk -- )      0 (load ;                             
                                                                
\ *** Block No. 89 Hexblock 59 
\ +load thru +thru --> rdepth depth                    19mar86we
                                                                
: +load    ( offset -- )        blk @ + load ;                  
                                                                
: thru     ( from to -- )       1+ swap DO  I  load   LOOP ;    
                                                                
: +thru    ( off0 off1 -- )     1+ swap DO  I +load   LOOP ;    
                                                                
: -->                           1 blk +!  >in off  .status ;    
                                immediate                       
                                                                
: rdepth   ( -- +n )            r0 @  rp@ 2+  -  2/ ;           
: depth    ( -- +n )            sp@  s0 @  swap  -  2/ ;        
                                                                
                                                                
                                                                
\ *** Block No. 90 Hexblock 5A 
\ quit (quit abort                                     cas201301
                                                                
| : prompt    state @ IF ."  [ "   exit  THEN   ."  ok" ;       
                                                                
: (quit       BEGIN   .status  cr  query  interpret  prompt     
              REPEAT ;                                          
                                                                
Defer 'quit       ' (quit Is 'quit                              
: quit            r0 @ rp!   [compile] [   'quit ;              
                                                                
: standardi/o     [ output ] Literal output 4 cmove ;           
                                                                
Defer 'abort     ' noop Is 'abort                               
: abort          clearstack   end-trace                         
                 'abort   standardi/o   quit ;                  
                                                                
\ *** Block No. 91 Hexblock 5B 
\ (error abort" error"                                 29mar86we
                                                                
Variable scr    1 scr !       Variable r#    0 r# !             
                                                                
: (error ( string -- )                                          
   standardi/o   space here .name   count type space ?cr        
   blk @ ?dup IF  scr !   >in @ r# !   THEN   quit ;            
' (error errorhandler !                                         
                                                                
: (abort"     "lit swap IF  >r clearstack r>                    
               errorhandler perform  exit  THEN  drop ; restrict
                                                                
| : (err"      "lit swap IF  errorhandler perform  exit  THEN   
               drop ; restrict                                  
: abort"       compile (abort"  ,"  align ;  immediate restrict 
: error"       compile (err"    ,"  align ;  immediate restrict 
\ *** Block No. 92 Hexblock 5C 
\ -trailing                                         bp 11 oct 86
                                                                
Code -trailing   ( addr n1 -- addr n2 )                         
   SP )+ D0 move   0<> IF                                       
   SP  ) D6 move   D6 reg) A0 lea   D0 A0 adda                  
Label -trail    .b A0 -) D1 move   $20 D1 cmpi   -trail D0 dbne 
   .w -1 D0 cmpi   0= IF   D0 clr   THEN                        
   THEN   D0 SP -) move    Next end-code                        
                                                                
                                                                
                                                                
                                                                
\\                                                              
: -trailing      ( addr n1 -- addr n2)     2dup bounds          
   ?DO  2dup + 1- c@ bl -                                       
        IF  LEAVE  THEN    1-  LOOP ;                           
\ *** Block No. 93 Hexblock 5D 
\ space spaces                                      bp 11 oct 86
                                                                
$20 Constant bl                                                 
                                                                
: space                      bl emit ;                          
                                                                
: spaces   ( u -- )          0 ?DO  space  LOOP ;               
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 94 Hexblock 5E 
\ hold <# #> sign # #s                                 02may86we
                                                                
| : hld   ( -- addr )           pad 2- ;                        
                                                                
: hold    ( char -- )           -1 hld +! hld @ c! ;            
                                                                
: <#                            hld hld ! ;                     
                                                                
: #>      ( 32b -- addr +n )    2drop hld @ hld over - ;        
                                                                
: sign    ( n -- )              0< IF  Ascii - hold  THEN ;     
                                                                
: #       ( +d1 -- +d2 )        base @ ud/mod  rot 9 over <     
  IF [ ascii A ascii 9 - 1- ] Literal +  THEN  Ascii 0 + hold ; 
                                                                
: #s      ( +d -- 0 0 )         BEGIN  # 2dup d0=  UNTIL ;      
\ *** Block No. 95 Hexblock 5F 
\ print numbers                                        24dec83ks
                                                                
: d.r      -rot under  dabs  <# #s rot sign #>                  
           rot over  max  over - spaces  type ;                 
                                                                
: .r       swap extend rot d.r ;                                
                                                                
: u.r      0 swap d.r ;                                         
                                                                
: d.       0 d.r space ;                                        
                                                                
: .        extend d. ;                                          
                                                                
: u.       0 d. ;                                               
                                                                
                                                                
\ *** Block No. 96 Hexblock 60 
\ .s list c/l l/s                                     bp 18May86
                                                                
: .s                                                            
   sp@  s0 @  over -  $20 umin bounds ?DO  I @ u.  2 +LOOP ;    
                                                                
$40 Constant c/l        \ Screen line length                    
$10 Constant l/s        \ lines per screen                      
                                                                
: list ( blk -- )                                               
   scr !   ." Scr " scr @ dup u.   ." Dr "  drv? .              
   l/s 0 DO                                                     
     cr I 2 .r  space  scr @ block I c/l * + c/l -trailing type 
   LOOP cr ;                                                    
                                                                
                                                                
                                                                
\ *** Block No. 97 Hexblock 61 
\ multitasker primitives                               14sep86we
                                                                
Code pause   Next end-code                                      
                                                                
: lock ( addr -- )                                              
   dup @  up@  = IF  drop  exit  THEN                           
   BEGIN   dup @ WHILE   pause   REPEAT  up@  swap  ! ;         
                                                                
: unlock   ( addr -- )        dup lock off ;                    
                                                                
Label wake   .l 2 A7 addq   A7 )+ A0 move   2 A0 subq           
   A0 A1 move   FP A1 suba   .w A1 UP R#) move                  
   $3C3C ( # D6 move ) # A0 ) move                              
   8 A0 D) D6 move   D6 reg) SP lea                             
     SP )+ D6 move   D6 reg) RP lea                             
     SP )+ D6 move   D6 reg) IP lea   Next end-code             
\ *** Block No. 98 Hexblock 62 
\ buffer mechanism                                     cas201301
                                                                
User isfile          0 isfile !   \ addr of file control block  
Variable fromfile    0 fromfile !                               
Variable prev        0 prev !     \ Listhead                    
| Variable buffers   0 buffers !  \ Semaphore                   
$408 Constant b/buf               \ physical size               
                                                                
\\ Structure of buffer:       0 : link                          
                              2 : file                          
                              4 : blocknumber                   
                              6 : statusflags                   
                              8 : Data ... 1 Kb ...             
Statusflag bits : 15   1 -> updated                             
file :  -1 -> empty buffer,  0 -> no fcb, direct acces          
        else addr of fcb  ( system dependent )                  
\ *** Block No. 99 Hexblock 63 
\ search for blocks in memory with (CORE?              cas201301
\ D0:blk   D1:file   A0:bufadr  A1:previous                     
Label thisbuffer?                                               
   2 A0 D) D1 cmp   0= IF  4 A0 D) D0 cmp   THEN  rts           
Code (core?  ( blk file -- adr\blk file )                       
   2 SP D) D0 move   SP ) D1 move                               
   UP R#) D6 move   .l user' offset D6 FP DI) D0 .w add         
   prev R#) D6 move   D6 reg) A0 lea                            
   thisbuffer? bsr  0= IF   .l FP A0 suba                       
Label blockfound    2 SP addq   8 A0 addq   .w A0 SP ) move     
                     .l ' exit @ R#) jmp  .w  THEN              
    BEGIN    A0 A1 lmove   A1 ) D6 move    0= IF   Next   THEN  
          D6 reg) A0 lea   thisbuffer? bsr   0= UNTIL           
   A0 ) A1 ) move   prev R#) A0 ) move                          
   .l FP A0 suba   .w A0 prev R#) move                          
   blockfound bra   end-code                                    
\ *** Block No. 100 Hexblock 64 
\ (core?                                               17nov85we
                                                                
\\                                                              
| : this? ( blk file bufadr -- flag )                           
     dup 4+ @  swap 2+ @  d= ;                                  
                                                                
| : (core? ( blk file -- dataaddr / blk file )                  
     BEGIN   over  offset @ +  over  prev @ this?               
             IF  rdrop 2drop  prev @ 8 +  exit  THEN            
       2dup >r   offset @ + >r   prev @                         
       BEGIN   dup @ ?dup 0= IF  rdrop rdrop drop exit  THEN    
         dup   r> r> 2dup >r >r   rot this?  0=                 
       WHILE nip REPEAT                                         
       dup @ rot !   prev @ over !   prev !   rdrop rdrop       
     REPEAT ;                                                   
                                                                
\ *** Block No. 101 Hexblock 65 
\ r/w                                                  11sep86we
                                                                
Defer r/w                                                       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 102 Hexblock 66 
\ backup emptybuf readblk                              11sep86we
                                                                
: backup ( bufaddr -- )       dup 6+ @ 0<                       
     IF 2+ dup @ 1+           \ buffer empty if file = -1       
       IF  input push   output push   standardi/o               
           dup 6+   over 2+ @   2 pick @  0 r/w                 
              abort" write error"                               
       THEN   4+ dup  @ $7FFF and  over !  THEN  drop ;         
                                                                
: emptybuf ( bufaddr -- )      2+ dup on   4+ off ;             
                                                                
| : readblk ( blk file addr -- blk file addr )                  
     dup emptybuf                                               
     input push   output push   standardi/o   >r                
     over  offset @ +   over   r@ 8 +  -rot  1 r/w              
        abort" read error"    r> ;                              
\ *** Block No. 103 Hexblock 67 
\ take mark updated? full? core?                     cas20130105
                                                                
| : take ( -- bufaddr)    prev                                  
     BEGIN   dup @ WHILE   @ dup   2+ @   -1 = UNTIL            
     buffers lock    dup backup ;                               
                                                                
| : mark ( blk file bufaddr -- blk file )                       
     2+ >r   2dup r@ !   offset @ +   r@ 2+ !  r> 4+ off        
     buffers unlock ;                                           
                                                                
| : updates? ( -- bufaddr / flag )                              
     prev  BEGIN   @ dup WHILE   dup 6+ @ 0<  UNTIL ;           
: updated? ( blk -- flg ) block 2- @ 0< ;                       
: full? ( -- flag )  prev  BEGIN  @ dup @  0= UNTIL  6+ @ 0< ;  
                                                                
: core? ( blk file -- addr /false )     (core? 2drop false ;    
\ *** Block No. 104 Hexblock 68 
\ block & buffer manipulation                         b08sep86we
                                                                
: (buffer ( blk file -- addr )                                  
   BEGIN   (core?  take  mark   REPEAT ;                        
                                                                
: (block ( blk file -- addr )                                   
   BEGIN   (core?  take  readblk  mark   REPEAT ;               
                                                                
Code isfile@   ( -- addr )                                      
   UP R#) D6 move   .l user' isfile D6 FP DI) SP -) .w move     
   Next end-code                                                
                                                                
: buffer ( blk -- addr )   isfile@ (buffer ;                    
                                                                
: block  ( blk -- addr )   isfile@ (block ;                     
                                                                
\ *** Block No. 105 Hexblock 69 
\ block & buffer manipulation                        cas20130501
                                                                
: update          $80 prev @ 6+ c! ;                            
                                                                
: save-buffers    buffers lock                                  
                  BEGIN  updates? ?dup WHILE  backup  REPEAT    
                  buffers unlock ;                              
                                                                
: empty-buffers   buffers lock  prev                            
                  BEGIN  @ ?dup WHILE  dup emptybuf  REPEAT     
                  buffers unlock ;                              
                                                                
: flush           save-buffers empty-buffers ;                  
                                                                
                                                                
                                                                
\ *** Block No. 106 Hexblock 6A 
\ moving blocks                                        cas201301
| : fromblock  ( blk -- adr ) fromfile @ (block ;               
| : (copy      ( from to -- )                                   
     dup isfile@  core? IF   prev @ emptybuf   THEN             
                  full? IF  save-buffers  THEN                  
     offset @ +   isfile@  rot  fromblock 6 - 2!   update  ;    
                                                                
| : blkmove ( from to quan --)    save-buffers  >r              
     over r@ +   over u> >r   2dup u< r>   and                  
     IF    r@ r@ d+   r> 0 ?DO  -1 -2 d+  2dup (copy  LOOP      
     ELSE   r> 0 ?DO  2dup (copy  1 1 d+  LOOP                  
     THEN    save-buffers 2drop ;                               
                                                                
: copy ( from to --)                1 blkmove ;                 
: convey ( [blk1 blk2] [to.blk --)                              
   swap 1+  2 pick -  dup  0> not abort" No!"   blkmove ;       
\ *** Block No. 107 Hexblock 6B 
\ Allocating buffers                                  bp 18May86
                                                                
$FFFE Constant limit            Variable first                  
                                                                
: allotbuffer ( -- )                                            
   first @  r0 @  -  b/buf 2+  u< ?exit                         
   b/buf negate first +!  first @ dup emptybuf                  
   prev @ over !  prev ! ;                                      
                                                                
: freebuffer ( -- )                                             
   first @   limit b/buf - u<                                   
    IF  first @ backup   prev                                   
      BEGIN   dup @  first @ -  WHILE  @  REPEAT                
    first @ @  swap !   b/buf first +!  THEN ;                  
                                                                
: all-buffers    BEGIN  first @ allotbuffer  first @ = UNTIL ;  
\ *** Block No. 108 Hexblock 6C 
\ endpoints of forget                                  14sep86we
                                                                
| : |? ( nfa -- flag )   c@ $20 and ;                           
| : forget? ( adr nfa -- flag )   \ code in heap or above adr ? 
     name>  under  1+ u<  swap  heap?  or ;                     
                                                                
| : endpoints ( addr -- addr symb )                             
     heap  voc-link >r                                          
     BEGIN   r> @ ?dup       \ through all Vocabs               
     WHILE  dup >r 4- >r     \ link on returnstack              
       BEGIN  r> @ >r over 1- dup r@ u<      \ until link or    
                    swap r@ 2+ name> u< and  \ code under adr   
       WHILE  r@ heap? [ 2dup ] UNTIL  \ search for name in heap
       r@ 2+ |? IF  over r@ 2+ forget?                          
              IF  r@ 2+ (name> 2+ umax  THEN  \ then update symb
       THEN  REPEAT   rdrop   REPEAT ;                          
\ *** Block No. 109 Hexblock 6D 
\ remove, -words, -tasks                          bp/ks14sep86we
                                                                
: remove ( dic sym thread - dic sym )                           
     BEGIN dup @ ?dup      \ unlink forg. words                 
     WHILE dup heap?                                            
        IF  2 pick over u>  ELSE  3 pick over 1+ u<  THEN       
     IF  @ over ! ( unlink word)  ELSE  nip  THEN  REPEAT drop ;
                                                                
| : remove-words ( dic sym -- dic sym )                         
     voc-link BEGIN  @ ?dup                                     
              WHILE  dup >r  4- remove  r> REPEAT ;             
                                                                
| : remove-tasks ( dic -- )       up@                           
     BEGIN  2+  dup @  up@ -  WHILE  2dup @ swap here uwithin   
            IF  dup @ 2+ @  over ! 2-                           
            ELSE  @  THEN  REPEAT  2drop ;                      
\ *** Block No. 110 Hexblock 6E 
\ remove-vocs forget-words                            bp 11oct86
                                                                
| : remove-vocs ( dic symb -- dic symb )                        
     voc-link remove       thru.vocstack                        
      DO  2dup I @  -rot uwithin                                
         IF  [ ' Forth 2+ ] Literal  I !  THEN   -2 +LOOP       
      2dup  current @   -rot  uwithin                           
      IF  [ ' Forth 2+ ] Literal  current !  THEN ;             
                                                                
| : remove-codes   ( dic symb -- dic symb )                     
     next-link remove  ;                                        
                                                                
Defer custom-remove        ' noop Is custom-remove              
| : forget-words ( dic symb -- )                                
     over  remove-tasks  remove-vocs  remove-words  remove-codes
           custom-remove  heap swap - hallot   dp !  last off ; 
\ *** Block No. 111 Hexblock 6F 
\ deleting words from dict.                           bp 11oct86
                                                                
: clear        here  dup up@  forget-words  dp ! ;              
                                                                
: (forget ( adr -- )    dup heap? abort" is symbol"             
                        endpoints  forget-words ;               
                                                                
: forget   ' dup  [ dp ] Literal @  u< abort" protected"        
            >name  dup  heap?                                   
            IF  name>  ELSE  4-  THEN (forget ;                 
                                                                
: empty   [ dp ] Literal @ up@ forget-words                     
          [ udp ] Literal @  udp ! ;                            
                                                                
                                                                
                                                                
\ *** Block No. 112 Hexblock 70 
\ save bye stop? ?cr                                   cas201301
                                                                
: save      here  up@ forget-words                              
   voc-link @  BEGIN   dup 4- @   over 2-  !  @ ?dup 0= UNTIL   
   up@ origin $100 cmove ;                                      
                                                                
: bye       flush empty (bye ;                                  
                                                                
| : end?    key $FF and dup 3 =   \ Stop key                    
                  swap $1B = or   \ Escape key                  
                IF true rdrop THEN ;                            
                                                                
: stop? ( -- flag )     key? IF end? end? THEN false ;          
                                                                
: ?cr                   col c/l u> IF cr THEN ;                 
                                                                
\ *** Block No. 113 Hexblock 71 
\ in/output structure                                  25mar86we
                                                                
| : Out:   Create dup c, 2+ Does> c@ output @ + perform ;       
                                                                
: Output:  Create:   Does> output ! ;                           
0   Out: emit   Out: cr   Out: type   Out: del                  
    Out: page   Out: at   Out: at?    drop                      
                                                                
: row ( -- row )     at? drop ;                                 
: col ( -- col )     at? nip ;                                  
                                                                
| : In:    Create dup c, 2+ Does> c@ input @ + perform ;        
                                                                
: Input:   Create:   Does> input ! ;                            
0   In: key   In: key?   In: decode   In: expect  drop          
                                                                
\ *** Block No. 114 Hexblock 72 
\ Alias  only definitionen                             29jan85bp
                                                                
Only definitions Forth                                          
                                                                
: seal 0 ['] Only >body ! ;  \ kill all words in Only           
                                                                
' Only        Alias Only                                        
' Forth       Alias Forth                                       
' words       Alias words                                       
' also        Alias also                                        
' definitions Alias definitions                                 
                                                                
Host Target                                                     
                                                                
                                                                
                                                                
\ *** Block No. 115 Hexblock 73 
\ 'cold 'restart                                       19mar86we
                                                                
| : init-vocabularys        voc-link @                          
     BEGIN   dup 2- @   over 4-  !    @ ?dup 0= UNTIL ;         
| : init-buffers     0 prev !   limit first !   all-buffers ;   
                                                                
Defer 'cold    ' noop Is 'cold                                  
| : (cold      origin up@ $100 cmove                            
     init-vocabularys   init-buffers   'cold   page  wrap       
     Onlyforth   cr &27 spaces   logo count type cr  (restart ; 
                                                                
Defer 'restart  ' noop Is 'restart                              
| : (restart    ['] (quit Is 'quit   drvinit   'restart         
 [ errorhandler ] Literal @  errorhandler !                     
 ['] noop Is 'abort   abort ;                                   
                                                                
\ *** Block No. 116 Hexblock 74 
\ cold bootsystem restart                              16oct86we
                                                                
Label buserror  &14 # A7 adda ;c: true abort" Bus Error !" ;    
Label adrerror  &14 # A7 adda ;c: true abort" Adress Error !" ; 
Label illegal     6 A7 addq                                     
                       ;c: true abort" Illegal Instruction !" ; 
Label div0        6 A7 addq  ;c: true abort" Division by 0 !" ; 
                                                                
                                                                
                                                                
| Create save_ssp  4 allot                                      
                                                                
Code cold      here >cold !                                     
   $A00A ,                    \ hide mouse                      
   ' (cold >body FP D) IP lea                                   
                                                                
\ *** Block No. 117 Hexblock 75 
\ restart                                              16oct86we
                                                                
Label bootsystem    .l 0 D7 moveq                               
   .w user' s0 # D7 move   origin D7 FP DI) D6 move             
   .l D6 reg) SP lea    .w 6 D6 addq    D6 UP R#) move          
   .w user' r0 # D7 move   origin D7 FP DI) D6 move             
   .l D6 reg) RP lea   RP ) clr   0 D6 moveq                    
   .w D0 move<sr   D0 $0D # btst  ( src<>dst)  0= IF            
         .l A7 -) clr  .w $20 # A7 -) move   1 trap             
         .l D0 save_ssp R#) move    6 A7 addq THEN              
   .w buserror # D6 move   .l D6 reg) A0 lea   A0   8 #) move   
   .w adrerror # D6 move   .l D6 reg) A0 lea   A0 $0C #) move   
   .w illegal  # D6 move   .l D6 reg) A0 lea   A0 $10 #) move   
   .w div0     # D6 move   .l D6 reg) A0 lea   A0 $14 #) move   
   .w wake     # D6 move   .l D6 reg) A0 lea   A0 $8C #) move   
    Next end-code                                               
\ *** Block No. 118 Hexblock 76 
\ System dependent load screen                        bp 11oct86
                                                                
Code restart      here >restart !                               
   ' (restart >body FP D) IP lea   bootsystem bra   end-code    
                                                                
2 $0C +thru        \ Atari 520 ST Interface                     
                                                                
Host    ' Transient 8 + @  Transient Forth context @ 6 + !      
\ Tlatest aus Transient wird Tlatest in Forth                   
                                                                
Target Forth also definitions                                   
: forth-83 ;     \ last word in Dictionary                      
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 119 Hexblock 77 
\ System patchup                                       14sep86we
                                                                
Forth definitions                                               
                                                                
$D3AA s0 !    $D7AA r0 !   \ gives &10 Buffers                  
s0 @ dup s0 2- !         6 + s0 8 - !                           
here dp !                                                       
                                                                
Host  Tudp @         Target  udp !                              
Host  Tvoc-link @    Target  voc-link !                         
Host  Tnext-link @   Target  next-link !                        
Host  move-threads                                              
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 120 Hexblock 78 
\ BIOS - Calls                                         09sep86we
                                                                
Code bconstat  ( dev -- fl )                                    
   SP )+ D0 move   D0 A7 -) move   1 # A7 -) move   $0D trap    
   4 A7 addq   D0 SP -) move   Next end-code                    
Code bcostat   ( dev -- fl )                                    
   SP )+ D0 move   D0 A7 -) move   8 # A7 -) move   $0D trap    
   4 A7 addq   D0 SP -) move   Next end-code                    
                                                                
Code bconin   ( dev -- char )                                   
   SP )+ D0 move   D0 A7 -) move   2 # A7 -) move   $0D trap    
   4 A7 addq   .w D0 D1 move   .l 8 # D0 lsr   .b D1 D0 move    
   .w D0 SP -) move   Next end-code                             
Code bconout  ( char dev -- )                                   
   SP )+ D0 move   SP )+ A7 -) move   D0 A7 -) move             
   3 # A7 -) move    $0D trap   6 A7 addq   Next end-code       
\ *** Block No. 121 Hexblock 79 
\ STkey? getkey                                        cas201301
                                                                
$08 Constant #bs         $0D Constant #cr                       
$0A Constant #lf         $1B Constant #esc                      
                                                                
: con!     ( 8b -- )     2 bconout ;                            
: curon              #esc con!  Ascii e con! ;                  
: curoff             #esc con!  Ascii f con! ;                  
: wrap               #esc con!  Ascii v con! ;                  
: cur<               #esc con!  Ascii D con!   -1 out +!  ;     
: cur>               #esc con!  Ascii C con!    1 out +!  ;     
                                                                
: STkey?   ( -- fl )     2 bconstat ;                           
: getkey   ( -- char )   STkey? IF  2 bconin  ELSE  0  THEN ;   
: STkey    ( -- char )   curon                                  
   BEGIN  pause STkey?  UNTIL curoff getkey ;                   
\ *** Block No. 122 Hexblock 7A 
\ (ins (del                                            cas201301
                                                                
| Variable maxchars                                             
                                                                
| : (del   ( addr pos1 -- addr pos2 )    2dup cur<              
     at? >r >r   2dup +  over span @ - negate under   type space
       r> r> at                                                 
     >r + dup 1- r> cmove   -1 span +!   1-    ;                
                                                                
| : (ins   ( addr pos1 -- addr pos2 )    2dup                   
     +   over span @ - negate >r   dup   dup 1+ r@ cmove>       
     bl over c!   r> 1+   at? >r >r   type   r> r> at           
     1 span +! ;                                                
                                                                
                                                                
                                                                
\ *** Block No. 123 Hexblock 7B 
\ decode                                               cas201301
                                                                
: STdecode   ( addr pos1 key -- addr pos2 )                     
  $4D00 case?  IF dup  span @ <  IF  cur>  1+  THEN  exit THEN  
  $4B00 case?  IF dup            IF  cur<  1-  THEN  exit THEN  
  $5200 case?  IF dup  span @ -  IF  (ins      THEN  exit THEN  
  $FF and   dup 0= IF  drop exit  THEN                          
    #bs case?  IF  dup    IF  (del  THEN  exit THEN             
    $7F case?  IF  span @   2dup <  and                         
               IF  cur>    1+ (del  THEN  exit THEN             
    #cr case?  IF span @  maxchars !                            
                  dup  at?  rot span @ -  - at  exit THEN       
  >r  2dup + r@ swap c!  r> emit                                
  dup span @ = IF  1 span +!  THEN  1+ ;                        
                                                                
                                                                
\ *** Block No. 124 Hexblock 7C 
\ expect keyboard                                      25mar86we
                                                                
: STexpect   ( addr len -- )       maxchars !                   
   span off  0                                                  
      BEGIN   span @  maxchars @  u< WHILE   key decode   REPEAT
   2drop space ;                                                
                                                                
                                                                
Input:  keyboard    [ here input ! ]                            
    STkey STkey? STdecode STexpect ;                            
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 125 Hexblock 7D 
\ emit cr del page at at? type                         cas201301
                                                                
| Variable out    0 out !         | &80 Constant c/row          
                                                                
: STemit   ( 8b -- )    5 bconout   1 out +!   pause ;          
: STcr                  #cr con!   #lf con!                     
                        out @  c/row /  1+  c/row *  out ! ;    
: STdel                 #bs con!  space  #bs con!   -2 out +! ; 
: STpage                #esc con!  Ascii E con!   out off ;     
: STat  ( row col -- )  #esc con!  Ascii Y con!                 
                        over $20 + con!   dup $20 + con!        
                        swap  c/row * + out ! ;                 
: STat? ( -- row col )  out @  c/row /mod swap ;                
                                                                
\\                                                              
: STtype ( addr len --) 0 ?DO count emit LOOP drop ;            
\ *** Block No. 126 Hexblock 7E 
\ Output                                               16oct86we
                                                                
Code STtype   ( addr len -- )                                   
   SP )+ D3 move   SP )+ D6 move   D3 tst  0<>                  
   IF   D3 out R#) add   1 D3 subq                              
     D3 DO   D6 reg) A0 lea  0 D1 moveq  .b A0 ) D1 move        
FP A7 -) lmove .w  D1 A7 -) move  5 # A7 -) move  3 # A7 -) move
        $0D trap   6 A7 addq    1 D6 addq   A7 )+ FP lmove  LOOP
   THEN   ;c:  pause ;                                          
                                                                
Output: display    [ here output ! ]                            
   STemit STcr STtype STdel STpage STat STat? ;                 
                                                                
| Code term    .l save_ssp R#) A7 -) move   .w $20 # A7 -) move 
               1 trap  6 A7 addq   A7 -) clr  1 trap   end-code 
| : (bye        curoff term ;                                   
\ *** Block No. 127 Hexblock 7F 
\ b/blk drive >drive drvinit                           10sep86we
                                                                
$400 Constant b/blk                                             
| Variable (drv    0 (drv !                                     
Create (blk/drv                                                 
  4 allot      $15F (blk/drv !      $15F (blk/drv 2+ !          
                                                                
: blk/drv   ( -- n )                (blk/drv (drv @ 2* + @ ;    
                                                                
: drive   ( drv# -- )               $1000 * offset ! ;          
: >drive  ( block drv# -- block' )  $1000 * + offset @ - ;      
: drv?    ( block -- drv# )         offset @ + $1000 / ;        
                                                                
: drvinit noop ;                                                
: drv0               0 drive ;    : drv1               1 drive ;
                                                                
\ *** Block No. 128 Hexblock 80 
\ readsector writesector                               cas201301
                                                                
Code rwabs   ( r/wf adr rec# -- flag )                          
   .l FP A7 -) move                                             
   .w SP )+ D0 move   SP )+ D6 move   D6 reg) A0 lea            
      SP )+ D1 move   2 D1 addq                                 
           (drv R#) A7 -) move      \ Drivenumber               
                 D0 A7 -) move      \ rec#                      
                2 # A7 -) move      \ number sectors            
              .l A0 A7 -) move      \ Address                   
              .w D1 A7 -) move      \ r/w flag                  
                4 # A7 -) move      \ function number           
    $0D trap    $0E # A7 adda   .l A7 )+ FP move                
                   .w D0 SP -) move \ error flag                
    Next end-code                                               
                                                                
\ *** Block No. 129 Hexblock 81 
\ diskchange?                                          09nov86we
                                                                
| Code mediach?  ( -- flag )                                    
   .w (drv R#) A7 -) move   9 # A7 -) move   $0D trap  4 A7 addq
   D0 SP -) move    Next end-code                               
                                                                
| Code getblocks    ( -- n )                                    
   .w (drv R#) A7 -) move   7 # A7 -) move   $0D trap  4 A7 addq
   D0 A0 move   .w $0E # A0 adda   A0 ) D0 move   D0 SP -) move 
   Next end-code                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 130 Hexblock 82 
\ STr/w                                                10sep86we
                                                                
: STr/w   ( adr blk file r/wf -- flag )                         
   swap abort" no file"                                         
   1 xor -rot   $1000 /mod   dup (drv !                         
   1 u> IF   . ." beyond capacity"  nip  exit   THEN            
   mediach? IF  getblocks  (blk/drv (drv @ 2* + !  THEN         
   dup  blk/drv >  IF    drop 2drop true                        
                   ELSE  9 + 2*  rwabs  THEN ;                  
                                                                
' STr/w Is r/w                                                  
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 131 Hexblock 83 
\ Basepage (TOS PRG Header)                            cas201301
                                                                
$601A ,                               \ BRA to start of PGM     
                                                                
here $1A allot   $1A erase            \ clear basepage info     
                                                                
Assembler                                                       
                                                                
.l A7 A5 move   4 A5 D) A5 move       \ start basepage          
   $1.0600 # D0 move   D0 D1 move     \ store size of forth and 
   A5 D1 add   .w $FFFE D1 andi   .l D1 A7 move  \ stack        
   D0 A7 -) move   A5 A7 -) move   .w A7 -) clr                 
   $4A # A7 -) move   1 trap   $0C # A7 adda   \ mshrink        
   $100 $1C - # A5 adda   A5 FP lmove   \ FP to start of Forth  
                                                                
                                                                
\ *** Block No. 132 Hexblock 84 
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
