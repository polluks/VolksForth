\ Block No. 0
\\ Directory ultraFORTH 2of4   26oct87re

.                    0
..                   0
diverses           $08
C64/C16            $09
System             $0F
C64interface       $7d
C16init            $94
















\ Block No. 1
\\ Inhalt ultraFORTH 2of4      26oct87re

Directory            0
Inhalt               1
diverses           $08
C64 oder C16       $09
System             $0F
C64/C16interface   $7d
                   $95-a9 free
















\ Block No. 2

























\ Block No. 3

























\ Block No. 4

























\ Block No. 5

























\ Block No. 6

























\ Block No. 7

























\ Block No. 8
\ ram rom jsr NormJsr f.C16+ clv12.4.87)


Assembler also definitions

(c16+ \ C16+Makros fuer Bankswitch.

: ram $ff3f sta ;   : rom $ff3e sta ;

' Jsr Alias NormJsr   Defer Jsr

: C16+Jsr dup $c000 u>
 IF rom NormJsr ram ELSE NormJsr THEN ;

' C16+Jsr Is Jsr
)









\ Block No. 9
\ Target-Machine               20dec91pz

Onlyforth


cr .( Host is: )
    (64  .( C64) C)
    (16  .( C16) C)
cr

       : )     ; immediate
       : (C    ; immediate

       : (C64  ; immediate
\      : (C16  ; immediate
\      : (C16+ ; immediate
\      : (C16- ; immediate

\      : (C64  [compile] ( ; immediate
       : (C16  [compile] ( ; immediate
       : (C16+ [compile] ( ; immediate
       : (C16- [compile] ( ; immediate



\ Block No. 10
\ Jsr-Makros laden/loeschen  clv14.4.87)

Assembler also definitions

(C16+ \needs C16+Jsr          -2 +load )
(C16+ ' C16+Jsr Is Jsr .( JSR Is:C16+  )
(C16+ \\ ignoriert den Rest des Screen )

\ alle andern brauchen keine Makros
\ Wenn Makros nicht geladen,
\      dann Rest ignorieren:

\needs C16+Jsr \\

\ Wenn Makros vorhanden: redefinieren:

' NormJsr Is Jsr .( JSR Is:Norm )








\ Block No. 11
\ print target machine         11apr91pz

cr .( Target is: )


(C    .( CBM )
(C64  .( C64 )
(C16  .( C16 with )
(C16+ .( 64kb )
(C16- .( 32kb )

cr .( Target is not: )

(C    \ )      .( CBM, )
(C64  \ )      .( C64, )
(C16  \ )      .( C16, )
(C16+ \ )      .( C16+64kb, )
(C16- \ )      .( C16-32kb, )

cr





\ Block No. 12
\ ramfill                             3:

Onlyforth

Code ramfill   ( adr n 8b -)
 sei  34 # lda  1 sta
 3 # lda setup jsr
 N 3 + ldx txa  N 2+ ora 0<>
  ?[ N lda 0 # ldy
    [[ 0 # cpx 0<>
      ?[[ [[ N 4 + )Y sta iny 0= ?]
          N 5 + inc dex ]]?
   N 2+ ldx 0<> ?[
   [[ N 4 + )Y sta iny N 2+ cpy CS ?] ]?
  ]?
 36 # lda  1 sta cli
 0 # ldx 1 # ldy Next jmp
end-code

$C000 $4000 (16 $300 - C)  0 ramfill

forget ramfill



\ Block No. 13
( Deleting Assembler Labels bp27jun85we)

: delete   Assembler name find
 IF  >name count $1F and
   bounds ?DO $1F I c! LOOP
 ELSE  count type space THEN ;

delete setup     delete xyNext
delete Puta      delete SP
delete Pop       delete Next
delete N         delete UP
delete Poptwo    delete W
delete IP        delete RP
delete Push      delete Push0A
delete PushA     delete ;c:

forget delete Onlyforth








\ Block No. 14
( Definition fuer .status     28jun85we)

: status
 blk @ ?dup IF
  ."  blk " u.
  ." here "  here u.
  ." there " there u.
  ." heap "  heap u.  cr
  THEN ;

' status is .status














\ Block No. 15
\ C64    Forth loadscree      clv14oct87

Onlyforth hex
  -3    +load   \ clear memory and
  -2 -1 +thru   \ clr labels  .status
  -6 -4 +thru   \ Target-Machine
Onlyforth

(C64 $801 ) (C16 $1001 ) dup displace !

Target definitions   here!

$1 $6E +thru

Assembler nonrelocate

.unresolved

' .blk is .status

    -4 +load    \ Print Target-Machine

cr .( save-target ultraforth83)
91 con! ( Cursor up) quit

\ Block No. 16
\ FORTH Preamble and ID        20dec91pz

(C64  $D c, $8 c, $A c, 00 c, 9E c,
28 c, 32 c, 30 c, 36 c, 34 c, 29 c,
00 c, 00 c, 00 c, 00 c, ) \ SYS(2064)
(C16  $D c, 10 c, $A c, 00 c, 9E c,
28 c, 34 c, 31 c, 31 c, 32 c, 29 c,
00 c, 00 c, 00 c, 00 c, ) \ SYS(4112)

Assembler
  nop  0 jmp  here 2- >label >cold
  nop  0 jmp  here 2- >label >restart

here dup origin!
\ Hier beginnen die Kaltstartwerte der
\ Benutzervariablen
0 jmp  0 jsr  here 2- >label >wake
 end-code
$100 allot

| Create logo
 (C64  ," ultraFORTH-83 3.82-C64  " )
 (C16+ ," ultraFORTH-83 3.82-C16+ " )
 (C16- ," ultraFORTH-83 3.82-C16- " )

\ Block No. 17
( Zero page Variables & Next  03apr85bp)

02 dup     >label RP     2+
   dup     >label UP     2+

   dup     >label Puta   1+
   dup     >label SP     2+
   dup     >label Next
   dup 5 + >label IP
      13 + >label W

     W 8 + >label N













\ Block No. 18
( Next, moved into Zero page  08apr85bp)

Label Bootnext
   -1 sta              \ -1 is dummy SP
   IP )Y lda  W 1+  sta
   -1 lda     W sta    \ -1 is dummy IP
   clc IP lda  2 # adc  IP sta
     CS not ?[ Label Wjmp -1 ) jmp ]?
   IP 1+ inc  Wjmp bcs
end-code

here Bootnext - >label Bootnextlen

Code end-trace  ( Patch Next for trace )
 $A5 # lda  Next $A + sta
  IP # lda  Next $B + sta
 $69 # lda  Next $C + sta
   2 # lda  Next $D + sta
 Next jmp   end-code






\ Block No. 19
\ ;c:  noop                    02nov87re

Create recover  ( -- adr )   Assembler
 pla  W sta  pla  W 1+ sta
 W wdec  0 jmp   end-code

here 2- >label >recover
\ handgestrickte vorwaerts Referenz fuer
\ den jmp-Befehl

Compiler Assembler also definitions
 H : ;c:   0 T recover jsr
 end-code  ] H ;
Target

Code noop   Next here 2- !  end-code









\ Block No. 20
\ User variables              clv14oct87

Constant origin  8 uallot drop
                 \ For multitasker

User s0       $7CFA s0 !
User r0       $7FFE r0 !
User dp
User offset      0 offset !
User base      &10 base !
User output
User input
User errorhandler
     \ pointer for  Abort" -code
User voc-link
User udp
     \ points to next free addr in User








\ Block No. 21
( manipulate system pointers  29jan85bp)

Code sp@   ( -- addr)
 SP lda  N sta  SP 1+ lda  N 1+ sta
 N # ldx
Label Xpush
 SP 2dec  1 ,X lda  SP )Y sta
 0 ,X lda  0 # ldx  Puta jmp   end-code

Code sp!   ( addr --)
 SP X) lda  tax  SP )Y lda
 SP 1+ sta  SP stx   0 # ldx
 Next jmp   end-code

Code up@   ( -- addr)
 UP # ldx  Xpush jmp  end-code

Code up!   ( addr --)      UP # ldx
Label Xpull     SP )Y lda  1 ,X sta
            dey SP )Y lda  0 ,X sta
Label (xydrop   0 # ldx  1 # ldy
Label (drop     SP 2inc  Next jmp
end-code restrict


\ Block No. 22
( manipulate returnstack   16feb85bp/ks)

Code rp@ ( -- addr )
 RP # ldx  Xpush jmp  end-code

Code rp! ( addr -- )
 RP # ldx  Xpull jmp  end-code restrict

Code >r  ( 16b --  )
 RP 2dec  SP X) lda   RP X) sta
 SP )Y lda   RP )Y sta (drop jmp
end-code restrict

Code r>  ( -- 16b)
 SP 2dec  RP X) lda  SP X) sta
          RP )Y lda  SP )Y sta
Label (rdrop     2 # lda
Label (nrdrop    clc  RP adc  RP sta
    CS ?[  RP 1+ inc  ]?
 Next jmp  end-code  restrict





\ Block No. 23
\ r@ rdrop  exit  ?exit       clv12jul87

Code r@      ( -- 16b)
 SP 2dec  RP )Y lda  SP )Y sta
          RP X) lda  Puta jmp
end-code

Code rdrop    (rdrop here 2- !
end-code   restrict

Code exit
 RP X) lda  IP sta
 RP )Y lda  IP 1+ sta
 (rdrop jmp   end-code
Code unnest
 RP X) lda  IP sta
 RP )Y lda  IP 1+ sta
 (rdrop jmp   end-code

Code ?exit     ( flag -- )
 SP X) lda  SP )Y ora
 php  SP 2inc  plp
 ' exit @ bne  Next jmp
end-code

\ Block No. 24
( execute  perform            08apr85bp)

Code execute  ( addr --)
 SP X) lda   W sta
 SP )Y lda   W 1+ sta
 SP 2inc     W 1- jmp   end-code

: perform ( addr -- )   @ execute ;

















\ Block No. 25
( c@   c! ctoggle             10jan85bp)

Code c@ ( addr -- 8b)
 SP X) lda  N sta   SP )Y lda  N 1+ sta
Label (c@    0 # lda  SP )Y sta
 N X)  lda   Puta jmp   end-code

Code c!  ( 16b addr --)
 SP X) lda   N sta   SP )Y lda  N 1+ sta
 iny  SP )Y lda  N X) sta dey
Label (2drop
 SP lda  clc  4 # adc  SP sta
   CS ?[  SP 1+ inc  ]?
 Next jmp   end-code

: ctoggle   ( 8b addr --)
 under c@ xor swap c! ;








\ Block No. 26
( @ ! +!                      08apr85bp)

Code @  ( addr -- 16b)
 SP X) lda  N sta  SP )Y lda  N 1+ sta
 N )Y lda  SP )Y sta
 N X) lda Puta jmp   end-code

Code !   ( 16b addr --)
 SP X) lda  N sta  SP )Y lda  N 1+ sta
 iny SP )Y lda  N X) sta
 iny SP )Y lda   1 # ldy
Label (!
 N )Y sta  (2drop jmp   end-code

Code +!  ( n addr --)
 SP X) lda  N sta  SP )Y lda  N 1+ sta
 iny  SP )Y lda  clc  N X) adc N X) sta
 iny  SP )Y lda  1 # ldy  N )Y adc
 (! jmp   end-code






\ Block No. 27
( drop swap                   24may84ks)

Code drop  ( 16b --)
 (drop here 2- !  end-code

Code swap  ( 16b1 16b2 -- 16b2 16b1 )
 SP )Y lda  tax
 3 # ldy  SP )Y lda  N sta
 txa  SP )Y sta
 N lda  1 # ldy  SP )Y sta
 iny  0 # ldx
 SP )Y lda  N sta  SP X) lda  SP )Y sta
 dey
 N lda Puta jmp   end-code











\ Block No. 28
( dup  ?dup                   08may85bp)

Code dup   ( 16b -- 16b 16b)
 SP 2dec
 3 # ldy  SP )Y lda  1 # ldy  SP )Y sta
 iny  SP )Y lda  dey
 Puta jmp   end-code

Code ?dup     ( 16b -- 16b 16b / false)
 SP X) lda  SP )Y ora
   0= ?[  Next jmp  ]?
 ' dup @ jmp end-code


\\ : ?dup   ( 16b -- 16b 16b / false)
    dup  IF  dup  THEN ;

   : dup    Sp@  @  ;







\ Block No. 29
( over rot                    13jun84ks)

Code over  ( 16b1 16b2 - 16b1 16b3 16b1)

 SP 2dec  4 # ldy  SP )Y lda  SP X) sta
 iny  SP )Y lda  1 # ldy  SP )Y sta
 Next jmp   end-code

Code rot
    ( 16b1 16b2 16b3 -- 16b2 16b3 16b1)
 3 # ldy  SP )Y lda  N 1+ sta
 1 # ldy  SP )Y lda  3 # ldy  SP )Y sta
 5 # ldy  SP )Y lda  N sta
 N 1+ lda  SP )Y sta
 1 # ldy  N lda  SP )Y sta
 iny  SP )Y lda  N 1+ sta
 SP X) lda  SP )Y sta
 4 # ldy  SP )Y lda  SP X) sta
 N 1+ lda  SP )Y sta
 1 # ldy  Next jmp   end-code

\\ : rot   >r swap r> swap ;
   : over  >r dup r> swap ;


\ Block No. 30
( -rot nip under pick roll    24dec83ks)

: -rot
    ( 16b1 16b2 16b3 -- 16b3 16b1 16b2)
 rot rot ;

: nip   ( 16b1 16b2 -- 16b2)
 swap drop ;

: under ( 16b1 16b2 -- 16b2 16b1 16b2)
 swap over ;

: pick  ( n -- 16b.n )   1+ 2* sp@ + @ ;

: roll  ( n --)
 dup >r pick sp@ dup 2+ r> 1+ 2* cmove>
 drop ;

\\ : -roll ( n --)
 >r dup sp@  dup 2+ dup 2+ swap
 r@ 2* cmove r> 1+ 2* + ! ;




\ Block No. 31
( double word stack manip.    21apr83ks)

: 2swap ( 32b1 32b2 -- 32b2 32b1)
 rot >r rot r> ;

Code 2drop ( 32b -- )
 (2drop here 2- !   end-code

\  : 2drop ( 32b -- )    drop drop ;

: 2dup  ( 32b -- 32b 32b)
 over over ;













\ Block No. 32
( + and or xor                08apr85bp)

Compiler  Assembler also definitions

H : Dyadop ( opcode --)  T
   iny  SP X) lda  dup c, SP c,
   SP )Y sta
   dey  SP )Y lda  3 # ldy  c, SP c,
   SP )Y sta
   (xydrop jmp  H ;

Target

Code +     ( n1 n2 -- n3)
 clc $71 Dyadop   end-code

Code or    ( 16b1 16b2 -- 16b3)
     $11 Dyadop   end-code

Code and   ( 16b1 16b2 -- 16b3)
     $31 Dyadop   end-code

Code xor   ( 16b1 16b2 -- 16b3)
     $51 Dyadop   end-code

\ Block No. 33
( -  not  negate              24dec83ks)

Code -    ( n1 n2 -- n3)
 iny SP )Y lda  sec SP X) sbc SP )Y sta
 iny SP )Y lda
 1 # ldy  SP )Y sbc  3 # ldy  SP )Y sta
 (xydrop jmp   end-code

Code not   ( 16b1 -- 16b2)   clc
Label (not
 txa  SP X) sbc  SP X) sta  txa
      SP )Y sbc  SP )Y sta
 Next jmp   end-code

Code negate   ( n1 -- n2 )
 sec  (not bcs   end-code

\ : -       negate + ;







\ Block No. 34
( dnegate setup d+            14jun84ks)

Code dnegate ( d1 -- -d1)
 iny  sec
 txa  SP )Y sbc  SP )Y sta  iny
 txa  SP )Y sbc  SP )Y sta
 txa  SP X) sbc  SP X) sta  1 # ldy
 txa  SP )Y sbc  SP )Y sta
 Next jmp  end-code

Label Setup  ( quan  in A)
 .A asl tax tay  dey
    [[ SP )Y lda  N ,Y sta  dey  0< ?]
 txa  clc  SP adc  SP sta
    CS ?[  SP 1+ inc  ]?
 0 # ldx  1 # ldy   rts   end-code

Code d+      ( d1 d2 -- d3)
 2 # lda  Setup jsr  iny
 SP )Y lda  clc N 2+  adc SP )Y sta iny
 SP )Y lda      N 3 + adc SP )Y sta
 SP X) lda  N    adc SP X) sta  1 # ldy
 SP )Y lda  N 1+ adc SP )Y sta
 Next jmp   end-code

\ Block No. 35
\ 1+ 2+ 3+    1- 2-::::        11apr91pz

Code 1+   ( n1 -- n2)   1 # lda
Label n+  clc  SP X) adc
 CS not   ?[  Puta jmp  ]?
 SP X) sta  SP )Y lda  0 # adc SP )Y sta
 Next jmp  end-code

Code 2+   ( n1 -- n2)
 2 # lda   n+ bne     end-code
Code 3+   ( n1 -- n2)
 3 # lda   n+ bne     end-code
Code 4+ ( n1 -- n2)
 4 # lda   n+ bne     end-code
| Code 6+ ( n1 -- n2)
 6 # lda   n+ bne     end-code

Code 1-   ( n1 -- n2)   sec
Label (1-     SP X) lda  1 # sbc
   CS ?[ Puta jmp ]?
 SP X) sta  SP )Y lda  0 # sbc SP )Y sta
 Next jmp  end-code

Code 2-   ( n1 -- n2)
 clc (1- bcc  end-code
\ Block No. 36
( number Constants            24dec83ks)

-1 Constant true    0 Constant false

' true Alias -1     ' false Alias 0

1 Constant 1        2 Constant 2
3 Constant 3        4 Constant 4

: on    ( addr -- )  true  swap ! ;
: off   ( addr -- )  false swap ! ;














\ Block No. 37
( words for number literals   24may84ks)

Code clit  ( -- 8b)
 SP 2dec  IP X) lda  SP X) sta
  txa   SP )Y sta  IP winc
 Next jmp   end-code restrict

Code lit   ( -- 16b)
 SP 2dec  IP )Y lda  SP )Y sta
          IP X) lda  SP X) sta
Label (bump   IP 2inc
 Next jmp  end-code restrict

: Literal   ( 16b --)
 dup $FF00 and
   IF  compile lit   , exit THEN
       compile clit c,  ;
immediate restrict


\\ : lit     r> dup 2+ >r  @  ;
   : clit    r> dup 1+ >r  c@ ;



\ Block No. 38
( comparision code words      13jun84ks)

Code 0<   ( n -- flag)
 SP )Y lda  0< ?[
Label putTrue    $FF # lda  $24 c, ]?
Label putFalse   txa  SP )Y sta
 Puta jmp   end-code

Code 0=   ( 16b -- flag)
 SP X) lda  SP )Y ora
 putTrue  beq
 putFalse bne  end-code

Code uwithin  ( u1 [low up[  -- flag)
 2 # lda  Setup jsr
 1 # ldy  SP X) lda  N cmp
          SP )Y lda  N 1+ sbc
  CS not ?[ ( N>SP) SP X) lda N 2+  cmp
                    SP )Y lda N 3 + sbc
           putTrue bcs ]?
 putFalse jmp  end-code




\ Block No. 39
( comparision code words      13jun84ks)

Code <    ( n1 n2 -- flag)
 SP X) lda  N sta  SP )Y lda  N 1+ sta
 SP 2inc
 N 1+ lda  SP )Y eor  ' 0< @  bmi
 SP X) lda  N cmp  SP )Y lda  N 1+ sbc
 ' 0< @ 2+ jmp    end-code

Code u<   ( u1 u2 -- flag)
 SP X) lda  N sta  SP )Y lda  N 1+ sta
 SP 2inc
 SP X) lda  N cmp  SP )Y lda  N 1+ sbc
   CS not ?[  putTrue jmp  ]?
              putFalse jmp  end-code










\ Block No. 40
( comparision words           24dec83ks)

\ : 0<   $8000 and  0<> ;

: >   ( n1 n2 -- flag)  swap < ;

: 0>  ( n --     flag)  negate 0<  ;

: 0<> ( n --     flag)  0= not ;

: u>  ( u1 u2 -- flag)  swap u< ;

: =   ( n1 n2 -- flag)  - 0= ;

: d0= ( d --     flag)  or 0= ;

: d=  ( d1 d2 -- flag)  dnegate d+ d0= ;

: d<  ( d1 d2 -- flag)  rot 2dup -
 IF > nip nip  ELSE 2drop u< THEN ;





\ Block No. 41
( min max umax umin extend dabs abs  ks)

| : minimax  ( n1 n2 flag -- n3)
   rdrop  IF swap THEN drop ;

: min   ( n1 n2 -- n3)
 2dup  > minimax ;

: max   ( n1 n2 -- n3)
 2dup  < minimax ;

: umax  ( u1 u2 -- u3)
 2dup u< minimax ;

: umin  ( u1 u2 -- u3)
 2dup u> minimax ;


: extend  ( n -- d)     dup 0< ;

: dabs    ( d -- ud)
 extend IF  dnegate THEN ;

: abs     ( n -- u)
 extend IF   negate THEN ;
\ Block No. 42
\ loop primitives              02nov87re

| : dodo
 rdrop r> 2+ dup >r rot >r swap >r >r ;

: (do  ( limit star -- )
 over - dodo ;      restrict

: (?do ( limit start -- )
 over - ?dup  IF dodo THEN
 r> dup @ +  >r drop ;       restrict

: bounds  ( start count -- limit start )
 over + swap ;

Code endloop  ( -- )
 6 # lda (nrdrop jmp   end-code restrict

\\ dodo puts  "index | limit |
 adr.of.DO"  on return-stack





\ Block No. 43
\ (loop (+loop                 02nov87re

Code (loop
 clc  1 # lda  RP X) adc RP X) sta
   CS ?[  RP )Y lda  0 # adc RP )Y sta
      CS ?[ Next jmp ]? ]?
Label doloop  5 # ldy
 RP )Y lda  IP 1+ sta  dey
 RP )Y lda  IP    sta  1 # ldy
 Next jmp    end-code restrict

Code (+loop  ( n -- )
 clc SP X) lda  RP X) adc  RP X) sta
     SP )Y lda  RP )Y adc  RP )Y sta
 .A ror  SP )Y eor
 php  SP 2inc  plp doloop bpl
 Next jmp    end-code restrict








\ Block No. 44
( loop indices                08apr85bp)

Code I  ( -- n)    0 # ldy
Label loopindex    SP 2dec   clc
 RP )Y lda  iny  iny
 RP )Y adc  SP X) sta  dey
 RP )Y lda  iny  iny
 RP )Y adc  1 # ldy  SP )Y sta
 Next jmp   end-code restrict

Code J  ( -- n)
 6 # ldy  loopindex bne
            end-code  restrict












\ Block No. 45
\ branching                    02nov87re

Code branch
 clc  IP    lda  IP X) adc  N sta
      IP 1+ lda  IP )Y adc  IP 1+ sta
 N lda IP sta
 Next jmp     end-code restrict

Code ?branch  ( flag -- )
 SP X) lda  SP )Y ora
 php  SP 2inc  plp
 ' branch @ beq    (bump jmp
end-code   restrict



\\  : branch   r> dup @ + >r ; restrict

    : ?branch  ( flag -- )
     0= r> over not over 2+  and -rot
     dup @ + and or >r ;       restrict




\ Block No. 46
( resolve loops and branches  03feb85bp)

: >mark     ( -- addr)  here   0 , ;

: >resolve  ( addr --)
 here over -   swap !  ;

: <mark     ( -- addr)  here ;

: <resolve  ( addr --) here - ,  ;

: ?pairs  ( n1 n2 -- )
 -  Abort" unstructured" ;












\ Block No. 47
( case?                       04may85bp)

Label  PushA
 0 # cmp  0< ?[ pha  $FF # lda ][
Label  Push0A   pha   0  # lda  ]?
Label  Push     tax   SP 2dec
 txa  1 # ldy  SP )Y sta
 pla  0 # ldx   Puta jmp

Code case?
 ( 16b1 16b2 -- 16b1 false / true )
 1 # lda  Setup jsr
 N lda  SP X) cmp
  0= ?[   N 1+ lda  SP )Y cmp
    0= ?[ putTrue jmp ]?  ]?
 txa  Push0A jmp   end-code



\\ : case?
 ( 16b1 16b2 -- 16b1 false / true )
 over = dup  IF  nip  THEN ;



\ Block No. 48
( Branching                   03feb85bp)

: IF     compile ?branch >mark  1 ;
         immediate restrict

: THEN   abs 1   ?pairs  >resolve ;
         immediate restrict

: ELSE   1 ?pairs  compile branch >mark
         swap >resolve  -1 ;
         immediate restrict

: BEGIN  <mark 2 ; immediate restrict

: WHILE  2 ?pairs  2   compile ?branch
         >mark -2  2swap  ;
         immediate restrict

| : (reptil   <resolve   BEGIN dup -2
    = WHILE  drop >resolve  REPEAT  ;

: REPEAT 2 ?pairs  compile branch
         (reptil ; immediate restrict
: UNTIL  2 ?pairs  compile ?branch
         (reptil ; immediate restrict
\ Block No. 49
\ Loops                        02mar91pz

: DO     compile (do  >mark  3 ;
         immediate restrict

: ?DO    compile (?do >mark  3 ;
         immediate restrict

: LOOP   3 ?pairs  compile (loop
         compile endloop  >resolve ;
         immediate restrict

: +LOOP  3 ?pairs  compile (+loop
         compile endloop  >resolve ;
         immediate restrict

: LEAVE  endloop r> 2- dup @ + >r ;
         restrict

code UNLOOP  clc rp lda 6 # adc rp sta
 cs ?[ rp 1+ inc ]?  Next jmp  end-code

\\ Returnstack: calladr | index
                  limit | adr of DO

\ Block No. 50
( um*                      bp/ks13.2.85)

Code um*  ( u1 u2 -- ud)
 SP )Y lda N sta  SP X) lda  N 1+ sta
 iny N 2 + stx N 3 + stx  $10 # ldx
  [[ N 3 + asl N 2+ rol N 1+ rol N rol
   CS ?[ clc
         SP )Y lda  N 3 + adc  N 3 + sta
         iny  SP )Y lda dey
         N 2 + adc   N 2 + sta
           CS ?[  N 1+ inc
              0= ?[  N   inc  ]? ]? ]?
    dex  0= ?]
 N 3 + lda   SP )Y sta   iny
 N 2 + lda   SP )Y sta   1 # ldy
 N     lda   SP )Y sta
 N 1+ lda    SP X) sta
 Next jmp   end-code


\\ : um*   ( u1 u2 -- ud3)
 >r 0 0 0 r>  $10 0
  DO  dup 2/ >r  1 and IF 2over d+ THEN
      >r >r 2dup d+ r> r> r>  LOOP
 drop 2swap 2drop ;
\ Block No. 51
( m* 2*                       04jul84ks)

: m*     ( n1 n2 -- d)
 dup 0< dup >r IF negate THEN
 swap dup  0<  IF negate r> not >r THEN
 um*  r> IF dnegate THEN ;

: *      ( n n -- prod)   um* drop ;

Code 2*  ( n1 -- n2)
 SP X) lda  .A asl  SP X) sta
 SP )Y lda  .A rol  SP )Y sta
 Next jmp    end-code


\ : 2*   dup + ;









\ Block No. 52
( um/mod                      04jul84ks)

| : divovl
   true Abort" division overflow" ;

Code um/mod  ( ud u -- urem uquot)
 SP X) lda  N 5 + sta
 SP )Y lda  N 4 + sta   SP 2inc
 SP X) lda  N 1+  sta
 SP )Y lda  N     sta   iny
 SP )Y lda  N 3 + sta   iny
 SP )Y lda  N 2+  sta   $11 # ldx  clc
  [[ N 6 + ror  sec  N 1+ lda  N 5 + sbc
     tay  N lda  N 4 + sbc
    CS not ?[  N 6 + rol ]?
      CS ?[ N sta  N 1+ sty ]?
     N 3 + rol N 2+ rol N 1+ rol N rol
  dex  0= ?]
 1 # ldy  N ror  N 1+ ror
   CS ?[ ;c: divovl ; Assembler ]?
 N 2+  lda SP )Y sta iny
 N 1+  lda SP )Y sta iny
 N     lda SP )Y sta 1 # ldy
 N 3 + lda
 Puta jmp    end-code
\ Block No. 53
( 2/ m/mod                    24dec83ks)

: m/mod  ( d n -- mod quot)
 dup >r abs  over
   0< IF  under + swap  THEN
 um/mod r@
 0< IF negate over IF swap r@ + swap 1-
 THEN THEN rdrop ;

Code 2/  ( n1 -- n2)
 SP )Y lda  .A asl
 SP )Y lda  .A ror  SP )Y sta
 SP X) lda  .A ror
 Puta jmp      end-code











\ Block No. 54
( /mod / mod */mod */ u/mod  ud/mod  ks)

: /mod  ( n1 n2 -- rem quot)
 >r extend r> m/mod ;

: /     ( n1 n2 -- quot)     /mod nip ;

: mod   ( n1 n2 -- rem)      /mod drop ;

: */mod ( n1 n2 n3 -- rem quot)
 >r m*  r> m/mod ;

: */    ( n1 n2 n3 -- quot)  */mod nip ;

: u/mod  ( u1 u2  -- urem uquot)
 0 swap um/mod ;

: ud/mod ( ud1 u2 -- urem udquot)
 >r  0  r@  um/mod  r>
   swap >r  um/mod  r>  ;





\ Block No. 55
( cmove cmove> (cmove>       bp 08apr85)

Code cmove  ( from to quan --)
 3 # lda Setup jsr  dey
 [[ [[  N cpy  0= ?[  N 1+ dec  0< ?[
                1 # ldy  Next jmp  ]? ]?
     N 4 + )Y lda  N 2+ )Y sta iny 0= ?]
     N 5 + inc N 3 + inc  ]]  end-code

Code cmove> ( from to quan --)
 3 # lda Setup jsr
 clc N 1+ lda  N 3 + adc  N 3 + sta
 clc N 1+ lda  N 5 + adc  N 5 + sta
 N 1+ inc  N ldy  clc CS ?[
Label (cmove>
 dey  N 4 + )Y lda  N 2+ )Y sta ]?
 tya  (cmove> bne
 N 3 + dec  N 5 + dec  N 1+ dec
 (cmove> bne  1 # ldy
 Next jmp   end-code

: move   ( from to quan --)
 >r 2dup u<  IF r> cmove> exit THEN
 r> cmove ;

\ Block No. 56
( place count  erase       16feb85bp/ks)

: place ( addr len to --)
 over >r rot over 1+ r> move c! ;

Code count ( addr -- addr+1 len)
 SP X) lda N sta clc 1 # adc SP X) sta
 SP )Y lda N 1+ sta  0 # adc SP )Y sta
 SP 2dec  (c@ jmp   end-code

\  : count ( adr -- adr+1 len )
\   dup 1+  swap c@ ;

: erase ( addr quan --)      0 fill ;











\ Block No. 57
( fill                        11jun85bp)

Code fill  ( addr quan 8b -- )
 3 # lda Setup jsr  dey
 N lda  N 3 + ldx
  0<> ?[  [[ [[ N 4 + )Y sta iny 0= ?]
                N 5 + inc    dex 0= ?]
      ]?  N 2+ ldx
  0<> ?[  [[ N 4 + )Y sta iny dex 0= ?]
      ]? 1 # ldy
 Next jmp   end-code


\\
: fill  ( addr quan 8b --)   swap ?dup
       IF  >r over c! dup 1+ r> 1- cmove
  exit  THEN  2drop  ;








\ Block No. 58
( here Pad allot , c, compile 24dec83ks)

: here  ( -- addr)   dp @ ;

: pad   ( -- addr)   here $42 + ;

: allot ( n --)      dp +! ;

: ,     ( 16b --)    here !  2  allot ;

: c,    ( 8b --)     here c! 1  allot ;

: compile            r> dup 2+ >r @ , ;
                     restrict











\ Block No. 59
( input strings               24dec83ks)

Variable #tib   0 #tib !
Variable >tib   here >tib !   $50 allot
Variable >in    0 >in !
Variable blk    0 blk !
Variable span   0 span !

: tib   ( -- addr )    >tib @ ;

: query
 tib  $50 expect
 span @ #tib !  >in off  blk off ;












\ Block No. 60
( scan skip /string           12oct84bp)

: scan  ( addr0 len0 char -- addr1 len1)
 >r
     BEGIN  dup  WHILE  over c@ r@ -
     WHILE  1- swap 1+ swap  REPEAT
 rdrop ;

: skip  ( addr len del -- addr1 len1)
 >r
     BEGIN  dup  WHILE  over c@ r@ =
     WHILE  1- swap 1+ swap  REPEAT
 rdrop ;

: /string  ( addr0 len0 +n - addr1 len1)
 over umin rot over + -rot - ;









\ Block No. 61
\ capital                     clv06aug87

Label (capital  \ for commodore only
                \ for Ascii: next scr
 Ascii a             # cmp  CS
 ?[ Ascii z    $21 + # cmp  CC
    ?[ Ascii a $21 + # cmp  CS
       ?[ $df # and ]? \ 2nd up to low
     Ascii z      1+ # cmp  CC
     ?[ $80 # ora      \ low to up
 ]? ]? ]? rts end-code

Code capital  ( char -- char' )
 SP X) lda  (capital jsr  SP X) sta
 Next jmp    end-code

\\ The new (capital does:

No  00-40,5b-60,7b-c1-da-dc-ff no change
==    -@ , [-� ,  -A -Z -| -      ..

No  41-5a,61-7a        changes to:c1-da
==   a-z , A-Z                     A-Z


\ Block No. 62
\ capitalize                  clv06aug87

Code capitalize  ( string -- string )
 SP X) lda N    sta  SP )Y lda  N 1+ sta
  N X) lda N 2+ sta   dey
 [[ N 2+ cpy  0= ?[ 1 # ldy  Next jmp ]?
   iny N )Y lda  (capital jsr  N )Y sta
 ]]   end-code

\\ : capitalize  ( string -- string )
 dup  count  bounds
  ?DO  I c@  capital  I c!  THEN  LOOP ;

\\ capital ( char -- char )
   Ascii a  Ascii z 1+  uwithin
   IF  I c@  [ Ascii a  Ascii A - ]
 Literal -  ;

\\ Label (capital  \ for Ascii only
 Ascii a # cmp
 CS ?[  Ascii z  1+ # cmp
    CC ?[      sec
           Ascii a Ascii A - # sbc
  ]? ]?  rts  end-code

\ Block No. 63
( (word                       08apr85bp)

| Code (word   ( char adr0 len0 -- adr)
       \ N   : length of source
       \ N+2 : ptr in source / next char
       \ N+4 : string start adress
       \ N+6 : string length
 N 6 + stx        \ 0 =: string_length
 3 # ldy
  [[ SP )Y lda  N ,Y sta dey  0< ?]
 1 # ldy  clc
 >in    lda  N 2+  adc  N 2+  sta
                  \ >in+adr0 =: N+2
 >in 1+ lda  N 3 + adc  N 3 + sta
 sec  N lda  >in    sbc  N    sta
                  \ len0->in =: N
   N 1+ lda  >in 1+ sbc  N 1+ sta
  CC ?[ SP X) lda  >in    sta
                  \ stream exhausted
        SP )Y lda  >in 1+ sta





\ Block No. 64
( (word                       08apr85bp)

][ 4 # ldy  [[  N lda  N 1+ ora
                  \ skip char's
       0= not ?[[ N 2+ X) lda SP )Y cmp
                  \ while count <>0
       0=     ?[[ N 2+ winc  N wdec ]]?
    N 2+  lda  N 4 + sta
              \ save string_start_adress
    N 3 + lda  N 5 + sta
    [[  N 2+ X) lda  SP )Y cmp php
              \ scan for char
        N 2+ winc  N wdec plp
    0= not ?[[ N 6 + inc
              \ count string_length
       N lda N 1+ ora
    0= ?]  ]? ]?
              \ from count = 0 in skip)
 sec 2 # ldy
       \ adr_after_string - adr0 =: >in)
 N 2+  lda  SP )Y sbc  >in    sta  iny
 N 3 + lda  SP )Y sbc  >in 1+ sta



\ Block No. 65
( (word                       08apr85bp)

]? \ from 1st ][, stream was exhausted
   \ when word called)
 clc  4 # lda  SP adc  SP sta
  CS ?[ SP 1+ inc ]?  \ 2drop
 user' dp # ldy  UP )Y lda
 SP X) sta N    sta  iny
 UP )Y lda 1 # ldy
 SP )Y sta N 1+ sta        \ dp @
 dey N 6 + lda  \ store count byte first
 [[  N )Y sta  N 4 + )Y lda  iny
     N 6 + dec  0< ?]
 $20 # lda  N )Y sta       \ add a blank
 1 # ldy   Next jmp   end-code










\ Block No. 66
( source word parse name      08apr85bp)

: source   ( -- addr len)
 blk @  ?dup IF  block b/blk exit THEN
 tib #tib @  ;

: word  ( char -- addr)   source (word ;

: parse ( char -- addr len)
 >r source  >in @  /string over swap
 r> scan >r over - dup r> 0<> - >in +! ;

: name   ( -- addr)
 bl word  capitalize  exit  ;


\\
: word  ( char -- addr)        >r
 source  over swap  >in @  /string
 r@ skip  over  swap  r> scan
 >r  rot over swap  - r> 0<> -  >in !
 over - here place  bl here count + c!
 here ;


\ Block No. 67
\ state Ascii ,"  ("  "        02nov87re

Variable state    0 state !

: Ascii  ( -- char )  ( -- )
 bl word 1+ c@ state @
 IF [compile] Literal THEN ; immediate

: ,"       Ascii "  parse
 here over 1+  allot place  ;

: "lit  ( -- adr )
 r> r> under count + >r >r ; restrict

: ("    ( -- adr )   "lit ; restrict

: "        compile ("  ,"  ;
                immediate restrict







\ Block No. 68
( ." ( .( \ \\ hex decimal    08sep84ks)

: (."    "lit count type ; restrict

: ."     compile (." ," ;
                    immediate restrict

: (      Ascii )  parse 2drop ;
                    immediate

: .(     Ascii )  parse type ;
                    immediate

: \      >in @  c/l /  1+ c/l *  >in ! ;
                    immediate

: \\        b/blk >in ! ;  immediate

: \needs
 name find nip  IF  [compile] \  THEN ;

: hex       $10 base ! ;
: decimal    $A base ! ;


\ Block No. 69
( number conv.:  digit?  accumulate  ks)

: digit?  ( char -- digit true/ false )
 Ascii 0 -   dup 9 u>
 IF [ Ascii A Ascii 9 - 1- ]
   Literal -  dup 9 u>
     IF [ 2swap ( unstrukturiert) ] THEN
   base @  over  u>  ?dup  ?exit
 THEN drop  false ;

: accumulate ( +d0 adr digit - +d1 adr)
 swap >r swap  base @ um*  drop  rot
 base @ um*  d+  r>  ;

: convert  ( +d1 addr0 -- +d2 addr2)
 1+  BEGIN  count digit?
     WHILE  accumulate    REPEAT  1- ;

| : end?   ( -- flag )  ptr @  0= ;

| : char   ( addr0 -- addr1 char )
 count   -1 ptr +!  ;

| : previous  ( addr0 -- addr0 char)
 1-  count ;
\ Block No. 70
( ?nonum ?num fixbase?        13feb85ks)

Variable dpl   -1 dpl !

| : ?nonum  ( flag -- exit if true )
 IF rdrop 2drop drop rdrop false THEN ;

| : ?num    ( flag -- exit if true )
 IF rdrop drop r> IF  dnegate  THEN
    rot drop  dpl @ 1+  ?dup ?exit
    drop true THEN ;

| : fixbase?
 ( char - char false /  newbase true )
 Ascii & case?  IF $A true exit THEN
 Ascii $ case?  IF 10 true exit THEN
 Ascii H case?  IF 10 true exit THEN
 Ascii % case?  IF  2 true exit THEN
 false  ;

| : punctuation?   ( char -- flag)
   Ascii , over = swap Ascii . =  or ;

| : ?dpl   dpl @ -1 = ?exit  1 dpl +! ;

\ Block No. 71
( number? number 'number  01oct87clv/re)

| Variable ptr      \ points into string

: number?
 ( string - string false / n 0< / d 0> )
 base push  dup count  ptr !  dpl on
 0 >r  ( +sign)
 0 0 rot           end? ?nonum char
 Ascii - case?
 IF rdrop true >r  end? ?nonum char THEN
 fixbase?
 IF  base !        end? ?nonum char THEN
 BEGIN   digit?  0= ?nonum
   BEGIN  accumulate  ?dpl  end? ?num
          char digit?  0= UNTIL
   previous  punctuation?  0= ?nonum
   dpl off   end? ?num char REPEAT ;

Defer 'number?     ' number? Is 'number?

: number  ( string -- d )
 'number?  ?dup 0= Abort" ?"
 0< IF extend THEN ;

\ Block No. 72
( hide reveal immediate restrict     ks)

Variable last     0 last !

| : last?   ( -- false / acf true)
 last @ ?dup ;

: hide
 last?  IF 2- @ current @ ! THEN ;

: reveal
 last?  IF 2-   current @ ! THEN ;

: Recursive   reveal  ;
 immediate restrict

| : flag!    ( 8b --)
   last? IF under c@ or over c! THEN
   drop ;

: immediate  $40 flag! ;
: restrict   $80 flag! ;



\ Block No. 73
( clearstack hallot heap heap?11feb85bp)

Code clearstack
 user' s0 # ldy
 UP )Y lda  SP    sta  iny
 UP )Y lda  SP 1+ sta
 1 # ldy  Next jmp   end-code

: hallot ( quan -- )
 s0 @ over - swap
 sp@ 2+  dup rot -  dup s0 !
 2 pick over -  move  clearstack  s0 ! ;

: heap   ( -- addr)        s0 @  6+ ;

: heap?  ( addr -- flag)
 heap up@ uwithin ;

| : heapmove   ( from -- from)
   dup here  over -
   dup hallot  heap swap cmove
   heap over - last +!  reveal ;



\ Block No. 74
( Does>  ;                 30dec84ks/bp)

Label (dodoes>   RP 2dec
IP 1+ lda RP )Y sta  IP lda  RP X) sta
                          \ put IP on RP
clc  W X) lda  3 # adc IP sta
txa  W )Y adc  IP 1+ sta  \ W@ + 3 -> IP

Label docreate
 2 # lda  clc W adc pha txa W 1+ adc
 Push jmp end-code

| : (;code    r> last @  name>  ! ;

: Does>
 compile (;code  $4C c,
 compile (dodoes> ;  immediate restrict








\ Block No. 75
( 6502-align  ?head  |        08sep84bp)

| : 6502-align/1   ( adr -- adr' )
   dup  $FF and  $FF =  - ;

| : 6502-align/2   ( lfa -- lfa )
   here  $FF and $FF =
   IF  dup dup 1+  here over - 1+
       cmove>  \ lfa now invalid
       1 last +! 1 allot  THEN  ;


Variable ?head    0 ?head !

: |     ?head @   ?exit   -1 ?head  ! ;










\ Block No. 76
( warning   Create            30dec84bp)

Variable warning  0 warning !

| : exists?
 warning @ ?exit
 last @  current @  (find  nip
 IF space  last @ .name ." exists " ?cr
 THEN  ;

: Create
 here blk @ ,  current @ @ ,
 name  c@ dup 1 $20
 uwithin not  Abort" invalid name"
 here  last ! 1+ allot
 exists? ?head @
 IF 1 ?head +!  dup  6502-align/1 ,
                    \ Pointer to code
    heapmove $20 flag! 6502-align/1 dp !
 ELSE  6502-align/2  drop
 THEN  reveal  0 ,
 ;Code  docreate jmp end-code



\ Block No. 77
( nfa?                        30dec84bp)

| Code nfa?
 ( vocabthread  cfa -- nfa / false)
 SP X) lda  N 4 + sta
 SP )Y lda  N 5 + sta   SP 2inc
 [[ [[ SP X) lda  N 2+  sta
       SP )Y lda  N 3 + sta
      N 2+ ora  0= ?[ putFalse jmp ]?
      N 2+ )Y lda SP )Y sta  N 1+ sta
      N 2+ X) lda SP X) sta  N sta
      N 1+ ora  0= ?[  Next jmp  ]?
                               \ N=link
      N 2inc N X) lda pha sec $1F # and
      N adc  N sta  CS ?[ N 1+ inc ]?
      pla  $20 # and  0= not
       ?[ N )Y lda  pha
          N X) lda N sta pla N 1+ sta ]?
      N lda     N 4 + cmp  0= ?]
      N 1+ lda  N 5 + cmp  0= ?]
 ' 2+ @ jmp       end-code

\\ vocabthread=0 d.h. leeres Vocabulary
 in nfa? ist erlaubt

\ Block No. 78
( >name name> >body .name     03feb85bp)

: >name   ( cfa -- nfa / false)
 voc-link
 BEGIN @ dup WHILE 2dup 4 - swap
      nfa? ?dup IF -rot 2drop exit THEN
 REPEAT nip ;

| : (name>  ( nfa -- cfa)
   count $1F  and + ;

: name>     ( nfa -- cfa)
 dup (name> swap c@ $20 and IF @ THEN ;

: >body   ( cfa -- pfa)   2+ ;

: .name   ( nfa --)
 ?dup IF dup heap?  IF ." |" THEN
         count $1F and type
      ELSE  ." ???"
      THEN  space  ;




\ Block No. 79
\ : ; Constant Variable       clv16jul87

: Create: Create hide
 current @ context ! ] 0 ;

: :  Create: ;Code here >recover !
               \ resolve fwd. reference
 RP 2dec IP    lda  RP X) sta
         IP 1+ lda  RP )Y sta
 W lda  clc  2 # adc  IP sta
      txa   W 1+ adc  IP 1+ sta
 Next jmp   end-code

: ;        0 ?pairs  compile unnest
 [compile] [ reveal ; immediate restrict


: Constant  ( 16b --)  Create ,
 ;Code  SP 2dec  2 # ldy
 W )Y lda  SP X) sta  iny
 W )Y lda   1 # ldy   SP )Y sta
 Next jmp   end-code

: Variable   Create  2 allot ;

\ Block No. 80
( uallot User Alias        10jan85ks/bp)

: uallot ( quan -- offset)
 dup udp @ +  $FF
   u> Abort" Userarea full"
 udp  @ swap udp +! ;

: User  Create   2 uallot c,
 ;Code  SP 2dec  2 # ldy
 W )Y lda  clc UP    adc  SP X) sta
      txa  iny UP 1+ adc  1 # ldy
 SP )Y sta   Next jmp   end-code

: Alias  ( cfa --)
 Create last @ dup c@ $20 and
 IF   -2 allot  ELSE  $20 flag! THEN
 (name> ! ;








\ Block No. 81
( voc-link vp current context also   bp)

Create   vp       $10 allot
Variable current

: context ( -- adr  )  vp dup @ + 2+ ;

| : thru.vocstack  ( -- from to )
   vp 2+ context ;
\ "Only Forth also Assembler" gives vp :
\  countword = 6 |Only|Forth|Assembler

: also     vp @
 $A > Error" Vocabulary stack full"
 context @   2 vp +!  context ! ;

: toss   -2 vp +! ;








\ Block No. 82
(  Vocabulary Forth Only Forth-83 ks/bp)

: Vocabulary
 Create  0 , 0 ,
 here voc-link @ ,  voc-link !
 Does>  context ! ;

\ Name | Code | Thread | Coldthread |
\ Voc-link

Vocabulary Forth

Vocabulary Only
] Does>  [ Onlypatch ]  0 vp !
 context !  also  ;  ' Only !

: Onlyforth
 Only Forth also definitions ;







\ Block No. 83
( definitions order words  13jan84bp/ks)

: definitions   context @ current ! ;

| : .voc  ( adr -- )
 @ 2- >name .name ;

: order
 thru.vocstack  DO  I .voc  -2  +LOOP
 2 spaces  current .voc ;

: words      context @
 BEGIN  @ dup stop? 0= and
 WHILE  ?cr dup 2+ .name space
 REPEAT drop ;










\ Block No. 84
( (find                       08apr85bp)

Code (find  ( string thread
       -- string false / namefield true)
 3 # ldy [[ SP )Y lda N ,Y sta dey 0< ?]
 N 2+ X) lda $1F # and N 4 + sta

Label findloop   0 # ldy
 N )Y lda   tax   iny
 N )Y lda  N 1+ sta  N stx  N ora
  0= ?[ 1 # ldy 0 # ldx putFalse jmp ]?
 iny N )Y lda  $1F # and  N 4 + cmp
  findloop bne       \ countbyte match
 clc 2 # lda N    adc N 5 + sta
     0 # lda N 1+ adc N 6 + sta
 N 4  + ldy
  [[ N 2+ )Y lda N 5 + )Y cmp
     findloop bne   dey  0= ?]
 3 # ldy N 6 + lda  SP )Y sta   dey
         N 5 + lda  SP )Y sta
 dey  0 # ldx    putTrue jmp   end-code




\ Block No. 85
( found                       29jan85bp)

| Code found  ( nfa -- cfa n )
 SP X) lda N sta  SP )Y lda N 1+ sta
  N X) lda N 2+ sta  $1F # and
 sec N adc N sta
  CS ?[ N 1+ inc ]?
 N 2+ lda $20 # and
 0= ?[ N    lda  SP X) sta   N 1+ lda
    ][ N X) lda  SP X) sta
       N )Y lda   ]?  SP )Y sta
  SP 2dec   N 2+ lda   0< ?[  iny  ]?
 .A asl
  0< not ?[ tya $FF # eor tay iny  ]?
  tya SP X) sta
  0< ?[ $FF # lda  24 c, ]?
 txa  1 # ldy  SP )Y sta
 Next jmp  end-code

\\ | : found  ( nfa -- cfa n )
      dup   c@ >r   (name>
            r@ $20 and  IF @ THEN
        -1  r@ $80 and  IF 1- THEN
            r> $40 and  IF negate THEN ;

\ Block No. 86
( find  ' [']                 13jan85bp)

: find ( string -- cfa n / string false)
 context dup @ over 2- @ = IF 2- THEN
 BEGIN  under @ (find
                IF nip found exit THEN
   over vp 2+ u>
 WHILE  swap 2-
 REPEAT nip false ;

: '  ( -- cfa )
 name find 0= Abort" Haeh?"  ;

: [compile]   ' , ;   immediate restrict

: [']     ' [compile] Literal ;
                      immediate restrict

: nullstring?
 ( string -- string false  / true)
 dup c@ 0=  dup  IF nip THEN ;




\ Block No. 87
( >interpret                  28feb85bp)

Label jump
 iny clc W )Y lda 2 # adc IP    sta
 iny     W )Y lda 0 # adc IP 1+ sta
 1 # ldy  Next jmp   end-code

Variable >interpret

jump  ' >interpret !

\\ make Variable >interpret to special
   Defer












\ Block No. 88
( interpret interactive   01oct87clv/re)

Defer  notfound

: no.extensions  ( string -- )
 Error" Haeh?"   ;  \ string not 0

' no.extensions  Is  notfound

: interpret     >interpret ;

| : interactive
 ?stack  name find  ?dup
 IF 1 and IF execute >interpret THEN
   Abort" compile only"  THEN
 nullstring? ?exit   'number?
 0= IF  notfound  THEN  >interpret ;


' interactive  >interpret !





\ Block No. 89
( compiling [ ]           01oct87clv/re)

| : compiling
 ?stack  name find   ?dup
 IF   0> IF  execute >interpret  THEN
  , >interpret THEN
 nullstring? ?exit  'number?   ?dup
   IF 0> IF swap [compile] Literal THEN
    [compile] Literal
   ELSE  notfound THEN    >interpret ;


: [    ['] interactive  Is >interpret
 state off ;  immediate

: ]    ['] compiling    Is >interpret
 state on ;








\ Block No. 90
\ perfom  Defer Is             02nov87re

| : crash   true Abort" Crash" ;

: Defer   Create  ['] crash ,
 ;Code  2 # ldy
  W )Y lda  pha iny W )Y lda
  W 1+ sta  pla W sta  1 # ldy
  W 1- jmp  end-code

: (is  ( cfa -- )  r>  dup  2+ >r @ ! ;

| : def?  ( cfa -- )
    @ ['] notfound   @ over =
 swap ['] >interpret @      =  or
 not  Abort" not deferred" ;

: Is      ( cfa -- )  ( -- )
 ' dup  def?  >body
 state  @  IF  compile (is , exit  THEN
 !  ; immediate




\ Block No. 91
( ?stack                  01oct87clv/re)

| Create alarm  1 allot  0 alarm c!

| : stackfull   ( -- )
 depth $20 > abort" tight stack"
 alarm c@ 0= IF  -1 alarm c!
    true abort" dictionary full"  THEN
 ." still full " ;

Code ?stack
 user' dp # ldy
 sec SP    lda  UP )Y sbc
 iny SP 1+ lda  UP )Y sbc
 0= ?[ 1 # ldy ;c: stackfull ;
       Assembler ]?  alarm stx
 user' s0 # ldy
 UP )Y lda SP    cmp iny
 UP )Y lda SP 1+ sbc
 1 # ldy  CS ?[  Next jmp ]?
 ;c: true Abort" stack empty" ;

\\ : ?stack
 sp@  here - $100 u< IF stackfull THEN
 sp@  s0 @ u> Abort" stack empty" ;
\ Block No. 92
( .status push load           08sep84ks)

Defer .status    ' noop Is .status

| Create pull  0  ] r> r> ! ;

: push ( addr -- )
 r> swap dup >r @ >r  pull >r >r  ;
 restrict

: load   ( blk --)
 ?dup 0= ?exit blk push  blk !
 >in push  >in off
 .status interpret ;











\ Block No. 93
( +load thru +thru --> rdepth depth  ks)

: +load  ( offset --)  blk @  + load ;

: thru  ( from to --)
 1+  swap  DO  I load  LOOP ;

: +thru  ( off0 off1 --)
 1+  swap  DO  I +load LOOP ;

: -->
 1 blk +! >in off .status  ;  immediate

: rdepth  ( -- +n)  r0 @  rp@ 2+ - 2/ ;

: depth   ( -- +n)  sp@ s0 @ swap - 2/ ;









\ Block No. 94
( quit (quit abort            07jun85bp)

| : prompt
 state @  IF ."  compiling"  exit  THEN
 ."  ok" ;

: (quit
 BEGIN .status cr query interpret prompt
 REPEAT ;

Defer 'quit    ' (quit  Is 'quit

: quit     r0 @ rp! [compile] [ 'quit ;


: standardi/o
 [ output ] Literal output 4 cmove ;

Defer 'abort   ' noop Is 'abort

: abort
 clearstack  end-trace  'abort
 standardi/o  quit   ;


\ Block No. 95
\ (error Abort" Error"         02nov87re

Variable scr 1 scr !  Variable r# 0 r# !

: (error  ( string -- )
 standardi/o space here .name count type
 space ?cr  blk @  ?dup
 IF  scr !  >in @  r# !  THEN quit ;

' (error  errorhandler  !

: (abort"  ( flag -- )   "lit swap
 IF    >r clearstack r>
       errorhandler perform  exit
 THEN  drop ;  restrict

| : (err"  ( flag -- )   "lit swap
 IF    errorhandler perform  exit
 THEN  drop ;  restrict

: Abort"  ( flag -- )   compile (abort"
 ," ; immediate  restrict

: Error"  ( flag -- )   compile (err"
 ," ; immediate  restrict
\ Block No. 96
( -trailing                   08apr85bp)

020 Constant bl

Code -trailing  ( addr n1 -- adr  n2 )
 tya   Setup jsr
 SP X) lda  N 2+ sta   clc
 SP )Y lda  N 1+ adc  N 3 + sta
 N ldy  clc   CS ?[
Label (-trail
 dey  N 2+ )Y lda  bl # cmp
  0<> ?[ iny  0= ?[ N 1+ inc ]?
         tya pha  N 1+ lda Push jmp ]?
 ]?   tya   (-trail bne
 N 3 + dec N 1 + dec  (-trail bpl
 tya Push0A jmp   end-code









\ Block No. 97
( space spaces             29jan85ks/bp)

: space            bl emit ;

: spaces  ( u --)  0  ?DO space LOOP ;


\\
: -trailing  ( addr n1 -- addr n2)
 2dup  bounds
    ?DO 2dup + 1- c@ bl -
      IF LEAVE THEN  1- LOOP  ;













\ Block No. 98
( hold <# #> sign # #s        24dec83ks)

| : hld  ( -- addr)    pad 2- ;

: hold  ( char -- )
 -1 hld +! hld @ c! ;

: <#                   hld hld ! ;

: #>    ( 32b -- addr +n )
 2drop hld @  hld over - ;

: sign  ( n -- )
 0< IF Ascii  - hold THEN ;

: #     ( +d1 -- +d2)
 base @ ud/mod rot 09 over <
  IF  [ Ascii A  Ascii 9  - 1- ]
      Literal  +
  THEN  Ascii 0  +  hold ;

: #s    ( +d -- 0 0 )
 BEGIN # 2dup  d0= UNTIL ;


\ Block No. 99
( print numbers               24dec83ks)

: d.r  -rot under dabs <# #s rot sign #>
        rot over max over - spaces type
 ;

: .r    swap extend rot d.r ;

: u.r   0 swap d.r ;

: d.    0 d.r space ;

: .     extend d. ;

: u.    0 d. ;










\ Block No. 100
\ .s list c/l l/s             clv4:jul87

: .s   sp@  s0 @  over - 020 umin
 bounds ?DO I @ u.  2 +LOOP ;

40 (C drop 29 ) Constant c/l
   \ Screen line length
10 (C drop 19 ) Constant l/s
   \ lines per screen

: list   ( blk --)
 scr ! ." Scr " scr @ dup blk/drv mod u.
       ." Dr "  drv? .
 l/s 0 DO stop? IF leave THEN
   cr I 2 .r space scr @  block
      I c/l * + c/l  (C 1- )
   -trailing type  LOOP cr ;








\ Block No. 101
( multitasker primitives      bp03nov85)

Code pause   Next here 2- !  end-code

: lock  ( addr --)
 dup @  up@ =  IF  drop exit  THEN
 BEGIN  dup @  WHILE  pause  REPEAT
 up@ swap ! ;

: unlock  ( addr --)   dup lock off ;

Label wake    wake >wake !
 pla  sec  5 # sbc  UP    sta
 pla       0 # sbc  UP 1+ sta
 04C # lda  UP X) sta
 6 # ldy  UP )Y lda SP    sta
     iny  UP )Y lda SP 1+ sta 1 # ldy
 SP X) lda  RP sta
 SP )Y lda  RP 1+ sta   SP 2inc
 IP  # ldx  Xpull jmp
end-code




\ Block No. 102
( buffer mechanism            15dec83ks)

User file           0 file !
        \ adr of file control block
Variable prev       0 prev !
        \ Listhead
| Variable buffers  0 buffers !
        \ Semaphor
0408 Constant b/buf
        \ Physikalische Groesse

\\ Struktur eines buffers:
 0 : link
 2 : file
 4 : blocknr
 6 : statusflags
 8 : Data .. 1 KB ..

Statusflag bits: 15   1 -> updated

file = -1 empty buffer
     = 0 no fcb , direct access
     = else  adr of fcb
     ( system   dependent )

\ Block No. 103
( search for blocks in memory 11jun85bp)

Label thisbuffer?        2 # ldy
   [[  N 4 + )Y lda N 2- ,Y cmp
 0= ?[[  iny  6 # cpy 0= ?] ]? rts
              \ zero if this buffer )

| Code (core?
 ( blk file -- addr / blk  file )
 \ N-Area : 0 blk 2 file 4 buffer
 \          6 predecessor
 3 # ldy
   [[ SP )Y lda  N ,Y sta  dey  0< ?]
 user' offset # ldy
 clc  UP )Y lda  N 2+  adc  N 2+  sta
 iny  UP )Y lda  N 3 + adc  N 3 + sta
 prev    lda  N 4 + sta
 prev 1+ lda  N 5 + sta
 thisbuffer? jsr    0= ?[






\ Block No. 104
(   "                         11jun85bp)

Label blockfound     SP 2inc
 1 # ldy
 8 #   lda  clc N 4 + adc SP X) sta
 N 5 + lda        0 # adc SP )Y sta
 ' exit @ jmp  ]?
 [[ N 4 + lda  N 6 + sta
    N 5 + lda  N 7 + sta
    N 6 + X) lda  N 4 + sta  1 # ldy
    N 6 + )Y lda  N 5 + sta  N 4 + ora
     0= ?[ ( list empty )  Next jmp ]?
   thisbuffer? jsr 0= ?] \ found, relink
 N 4 + X) lda  N 6 + X) sta  1 # ldy
 N 4 + )Y lda  N 6 + )Y sta
 prev    lda  N 4 + X) sta
 prev 1+ lda  N 4 + )Y sta
 N 4 + lda  prev    sta
 N 5 + lda  prev 1+ sta
 blockfound jmp    end-code





\ Block No. 105
\ (core?                       23sep85bp

\\

| : this?   ( blk file bufadr -- flag )
   dup 4+ @  swap 2+ @  d= ;

| : (core?
   ( blk file -- dataaddr / blk file )
  BEGIN  over offset @ + over  prev @
    this? IF rdrop 2drop prev @ 8 + exit
          THEN
    2dup >r offset @ + >r prev @
    BEGIN  dup @ ?dup
       0= IF rdrop rdrop drop exit THEN
      dup r> r> 2dup >r >r  rot this? 0=
    WHILE  nip  REPEAT
    dup @ rot !  prev @ over !  prev !
    rdrop rdrop
  REPEAT ;





\ Block No. 106
( (diskerr                    11jun85bp)

: (diskerr   ." error !  r to retry "
 key dup Ascii r =  swap Ascii R =
 or not  Abort" aborted"  ;


Defer diskerr  ' (diskerr  Is diskerr

Defer r/w















\ Block No. 107
( backup emptybuf readblk     11jun85bp)

| : backup   ( bufaddr --)
 dup 6+ @  0<
 IF  2+  dup @ 1+
            \ buffer empty if file = -1
  IF input push output push standardi/o
   BEGIN dup 6+ over 2+ @ 2 pick @ 0 r/w
   WHILE ." write " diskerr
   REPEAT   THEN
  080 over 4+ 1+ ctoggle  THEN
 drop ;

| : emptybuf  ( bufaddr --)
   2+ dup on 4+ off ;

| : readblk
   ( blk file addr -- blk file addr)
 dup emptybuf  input push  output push
 standardi/o   >r
 BEGIN over offset @ + over
       r@ 8 +  -rot   1  r/w
 WHILE ." read " diskerr
 REPEAT  r>  ;

\ Block No. 108
( take mark updates? full? core?     bp)

| : take   ( -- bufaddr)    prev
 BEGIN  dup @  WHILE  @  dup 2+ @ -1 =
 UNTIL
 buffers lock   dup backup ;

| : mark
 ( blk file bufaddr -- blk file )
 2+ >r 2dup r@ !  offset @ +  r@ 2+ !
 r> 4+ off  buffers unlock ;

| : updates?  ( -- bufaddr / flag)
 prev  BEGIN  @ dup  WHILE  dup 6+ @
   0<  UNTIL ;

| : full?   ( -- flag)
 prev BEGIN @ dup @ 0= UNTIL  6+ @ 0< ;

: core?  ( blk file -- addr /false)
 (core? 2drop false ;




\ Block No. 109
( block & buffer manipulation 11jun85bp)

: (buffer ( blk file -- addr)
 BEGIN  (core? take mark
 REPEAT ;

: (block  ( blk file -- addr)
 BEGIN  (core? take readblk mark
 REPEAT ;

| Code file@  ( -- n )
 user' file # ldy
 UP )Y lda  pha  iny  UP )Y lda
 Push jmp  end-code

: buffer  ( blk -- addr )
 file@  (buffer ;

: block   ( blk -- addr )
 file@  (block ;





\ Block No. 110
( block & buffer manipulation 09sep84ks)

: update   080 prev @  6+ 1+ c! ;

: save-buffers
 buffers lock BEGIN   updates? ?dup
              WHILE backup REPEAT
 buffers unlock  ;

: empty-buffers
 buffers lock  prev
 BEGIN @ ?dup
 WHILE dup emptybuf
 REPEAT  buffers unlock ;

: flush    save-buffers empty-buffers ;









\ Block No. 111
( moving blocks               15dec83ks)

| : (copy   ( from to --)
 dup file@
 core? IF prev @ emptybuf THEN
 full? IF  save-buffers   THEN
 offset @ + swap block 2- 2- !  update ;

| : blkmove  ( from to quan --)
 save-buffers >r
 over r@ + over u> >r  2dup u< r> and
  IF  r@ r@ d+  r> 0 ?DO -1 -2 d+
                         2dup (copy LOOP
  ELSE          r> 0 ?DO 2dup (copy 1
                             1 d+   LOOP
  THEN  save-buffers 2drop ;

: copy    ( from to --)   1 blkmove ;

: convey  ( [blk1 blk2] [to.blk --)
 swap  1+  2 pick -   dup 0> not
 Abort" nein"  blkmove ;



\ Block No. 112
\ Allocating buffers          clv12jul87

E400 Constant limit     Variable first

: allotbuffer   ( -- )
 first @  r0 @ -  b/buf 2+ u< ?exit
 b/buf negate first +!
 first @ dup emptybuf
 prev  @ over !  prev !   ;

: freebuffer    ( -- )
 first @   limit b/buf - u<
  IF first @ backup prev
    BEGIN  dup @ first @  -
    WHILE  @  REPEAT
  first @  @ swap ! b/buf first +!
  THEN ;

: all-buffers
 BEGIN  first @ allotbuffer
        first @  = UNTIL ;




\ Block No. 113
\ endpoints of forget          02mar91pz

| : |? ( nfa -- flag )   c@  020  and ;

| : forget?  ( adr nfa -- flag )
     \ code in heap or above adr ?
 name> under 1+ u< swap  heap?  or ;

|  : endpoints  ( addr -- addr symb)
 heap   voc-link >r
 BEGIN r> @ ?dup    \ through all Vocabs
 WHILE dup >r 4 - >r \ link on returnst.
  BEGIN r> @ >r over 1- dup r@  u<
                    \ until link  or
             swap  r@ 2+ name> u< and
                    \ code under adr
  WHILE  r@ heap?  [ 2dup ] UNTIL
             \ search for a name in heap
    r@ 2+ |?  IF  over r@ 2+ forget?
               IF r@ 2+ (name> 2+ umax
               THEN \ then update symb
              THEN
  REPEAT rdrop
 REPEAT  ;

\ Block No. 114
\ remove                       23jul85we

| Code remove ( dic symb thr - dic symb)
 5 # ldy [[ SP )Y lda N ,Y sta dey 0< ?]
 user' s0 # ldy
 clc UP )Y lda 6 # adc N 6 + sta
 iny UP )Y lda 0 # adc N 7 + sta
 1 # ldy
 [[ N X) lda N 8 + sta
    N )Y lda N 9 + sta N 8 + ora  0<>
 ?[[ N 8 + lda N 6 + cmp
     N 9 + lda N 7 + sbc CS
   ?[ N 8 + lda N 2 + cmp
      N 9 + lda N 3 + sbc
   ][ N 4 + lda N 8 + cmp
      N 5 + lda N 9 + sbc
   ]? CC
   ?[ N 8 + X) lda N X) sta
      N 8 + )Y lda N )Y sta
   ][ N 8 + lda    N    sta
      N 9 + lda N 1+ sta ]?
 ]]? (drop jmp   end-code



\ Block No. 115
( remove-     forget-words    29apr85bp)

| : remove-words ( dic symb -- dic symb)
 voc-link  BEGIN  @ ?dup
  WHILE  dup >r 4 - remove r>  REPEAT  ;

| : remove-tasks  ( dic --)
 up@  BEGIN  1+ dup @ up@ -
 WHILE  2dup @ swap here uwithin
  IF dup @ 1+ @ over ! 1-  ELSE  @ THEN
 REPEAT  2drop ;

| : remove-vocs  ( dic symb -- dic symb)
 voc-link remove thru.vocstack
  DO  2dup I @  -rot  uwithin
    IF   [ ' Forth 2+ ] Literal I ! THEN
  -2 +LOOP
 2dup   current @  -rot   uwithin
  IF [ ' Forth 2+ ] Literal current !
  THEN ;

Defer custom-remove
' noop Is custom-remove


\ Block No. 116
( deleting words from dict.   13jan83ks)

| : forget-words    ( dic symb --)
 over remove-tasks remove-vocs
      remove-words custom-remove
 heap swap - hallot dp !  0 last ! ;

: clear
 here  dup up@ forget-words   dp ! ;

: (forget ( adr --)
 dup  heap? Abort" is symbol"
 endpoints forget-words ;

: forget  ' dup [ dp ] Literal @
 u<  Abort" protected"
 >name dup heap?
 IF  name>  ELSE  2- 2-  THEN
 (forget   ;

: empty  [ dp ] Literal @
 up@ forget-words
 [ udp ] Literal @  udp ! ;


\ Block No. 117
\ save bye stop? ?cr         clv2:jull87

: save
 here up@ forget-words
 voc-link @  BEGIN  dup 2- 2-  @  over
               2- !  @ ?dup 0=  UNTIL
 up@ origin $100 cmove   ;

: bye save-buffers (bye ;
\ : bye       flush empty (bye ;

| : end?    key ( #cr ) (C 3 ) =
            IF true rdrop THEN ;

: stop?   ( -- flag)
 key? IF end? end? THEN false ;

: ?cr   col  c/l $A -  u> IF cr THEN ;







\ Block No. 118
( in/output structure         02mar85bp)

| : Out:  Create dup c,  2+
          Does> c@ output @ +  perform ;

  : Output:  Create:
             Does>  output ! ;

0  Out: emit   Out: cr     Out: type
   Out: del    Out: page   Out: at
   Out: at?
drop

: row   ( -- row)  at? drop ;
: col   ( -- col)  at? nip ;

| : In:    Create dup c, 2+
           Does> c@ input @ + perform ;

  : Input:  Create:
            Does> input ! ;

0  In: key   In: key?   In: decode
   In: expect
drop
\ Block No. 119
( Alias  only definitionen    29jan85bp)

Only definitions Forth

: seal  0 ['] Only  >body  ! ;
        \ kill all words in Only)

      ' Only  Alias Only
      ' Forth Alias Forth
      ' words Alias words
      ' also  Alias also
' definitions Alias definitions

Host Target











\ Block No. 120
\ 'cold                   01oct87clv/re)

| : init-vocabularys   voc-link @
 BEGIN  dup  2- @  over 4 - !
        @ ?dup 0= UNTIL ;

| : init-buffers
 0 prev !  limit first !  all-buffers ;

Defer 'cold    ' noop Is 'cold

| : (cold
 init-vocabularys  init-buffers
 Onlyforth 'cold
 page logo count type cr
 (restart ;

Defer 'restart  ' noop Is 'restart

| : (restart
 ['] (quit Is 'quit
 drvinit 'restart  [ errorhandler ]
 Literal @ errorhandler !
 [']  noop Is 'abort abort ;

\ Block No. 121
\ forth-init              01oct87clv/re)

Label forth-init
 Bootnextlen 1- # ldy
 [[ Bootnext ,Y lda PutA ,Y sta
    dey 0< ?]
 clc s0 lda 6 # adc UP sta
  s0 1+ lda 0 # adc UP 1+ sta
 user' s0 # ldy  UP )Y lda SP sta
            iny  UP )Y lda SP 1+ sta
 user' r0 # ldy  UP )Y lda RP sta
            iny  UP )Y lda RP 1+ sta
 0 # ldx 1 # ldy txa RP X) sta RP )Y sta
Label donothing rts











\ Block No. 122
\ cold restart                 06nov87re

Code cold        here >cold !
 $FF # ldx  txs
Label bootsystem
 donothing jsr \ patch for first-init
 clc s0 lda 6 # adc N sta
  s0 1+ lda 0 # adc N 1+ sta  0 # ldy
 [[ origin ,Y lda N )Y sta iny 0= ?]
 forth-init jsr
 ;c: init-system  (cold ;

Code restart     here >restart !
 $FF # ldx  txs
Label warmboot
 donothing jsr \ patch for first-init
 forth-init jsr
 ;c: init-system  (restart ;

Label xyNext
 0 # ldx 1 # ldy Next jmp end-code




\ Block No. 123
\ System-Loadscreen            20dec91pz

 3 $19 +thru          \ CBM-Interface
(c16+   $1a +load )   \ c16init RamIRQ


Host  ' Transient 8 + @
  Transient  Forth  Context @ 6 + !
Target     \ kotz wuerg !

Forth also definitions

(C16 : (64 ) \ springt hinter C)
(C64 : (16 )
 BEGIN name count dup 0=
 abort" C) missing"  2 = >r
 @ [ Ascii C Ascii ) $100 * + ] Literal
 = r> and UNTIL ; immediate

: C)  ; immediate

(C16 : (16 ) (C64 : (64 ) ; immediate

: forth-83 ;  \ last word in Dictionary

\ Block No. 124
( System dependent Constants      bp/ks)

Vocabulary Assembler
Assembler definitions
Transient  Assembler

PushA  Constant PushA
       \ put A sign-extended on stack
Push0A Constant Push0A
       \ put A on stack
Push   Constant Push
       \ MSB in A and LSB on jsr-stack

RP     Constant RP
UP     Constant UP
SP     Constant SP
IP     Constant IP
N      Constant N
Puta   Constant Puta
W      Constant W
Setup  Constant Setup
Next   Constant Next
xyNext Constant xyNext
(2drop Constant Poptwo
(drop  Constant Pop
\ Block No. 125
\ System patchup              clv06aug87

Forth definitions

(C64  C000 ' limit >body !
      7B00 s0 !  7F00 r0 ! )

(C16  8000 ' limit >body !
      7700 s0 !  7b00 r0 ! )

\ (C16+ fd00 ' limit >body !
\       7B00 s0 !  7F00 r0 ! )

s0 @ dup s0 2- !      6 + s0 7 - !
here dp !

Host  Tudp @          Target  udp !
Host  Tvoc-link @     Target  voc-link !
Host  move-threads






\ Block No. 126
\ CBM-Labels                   05nov87re

$FFA5 >label ACPTR
$FFC6 >label CHKIN
$FFC9 >label CHKOUT
$FFD2 >label CHROUT
$FF81 >label CINT
$FFA8 >label CIOUT
$FFC3 >label CLOSE
$FFCC >label CLRCHN
$FFE4 >label GETIN
$FF84 >label IOINIT
$FFB1 >label LISTEN
$FFC0 >label OPEN
$FFF0 >label PLOT
$FF8A >label RESTOR
$FF93 >label SECOND
$FFE1 >label STOP
$FFB4 >label TALK
$FF96 >label TKSA
$FFEA >label UDTIM
$FFAE >label UNLSN
$FFAB >label UNTLK
$FFCF >label CHRIN
$FF99 >label MEMTOP
\ Block No. 127
\ C64-Labels                 clv13.4.87)

(C64

0E716 >label ConOut
  09d >label MsgFlg
  09a >label OutDev
  099 >label  InDev
0d020 >label BrdCol
0d021 >label BkgCol
 0286 >label PenCol
  0ae >label PrgEnd
  0c1 >label IOBeg
  0d4 >label CurFlg
  0d8 >label InsCnt
 028a >label KeyRep





)



\ Block No. 128
\ C16-Labels                   02mar91pz

(C16

0ff4c >label ConOut
  09a >label MsgFlg
  099 >label OutDev
  098 >label  InDev
0ff19 >label BrdCol
0ff15 >label BkgCol
 053b >label PenCol
  09d >label PrgEnd
  0b2 >label IOBeg
  0cb >label CurFlg
  0cf >label InsCnt
 0540 >label KeyRep




 055d >label PKeys
)



\ Block No. 129
\ c64key? getkey              clv12jul87

Code c64key? ( -- flag)
(C64  0C6 lda            ( )
(c16  0ef lda  055d ora  ( )
 0<> ?[  0FF # lda  ]? pha
 Push jmp  end-code

Code getkey  ( -- 8b)
(C64 0C6 lda  0<>
 ?[  sei  0277 ldy
  [[  0277 1+ ,X lda  0277 ,X sta  inx
      0C6 cpx  0= ?]
  0C6 dec  tya  cli  0A0 # cmp
  0= ?[  bl # lda  ]?
 ]? ( )
(C16 0ebdd jsr
  0A0 # cmp 0= ?[  bl # lda  ]? ( )
 Push0A jmp   end-code






\ Block No. 130
( curon curoff               clv12.4.87)

(C16  Code curon \ --
0ca lda clc 0c8 adc 0ff0d sta
0c9 lda     0 # adc 0b # sbc 0ff0c sta
next jmp end-code

Code curoff \ --
0ff # lda ff0c sta 0ff0d sta Next jmp
end-code )

(C16 \\ )

Code curon   ( --)
 0D3 ldy  0D1 )Y lda  0CE sta  0CC stx
 xyNext jmp   end-code

Code curoff   ( --)
 iny  0CC sty  0CD sty  0CF stx
 0CE lda  0D3 ldy  0D1 )Y sta
 1 # ldy  Next jmp   end-code




\ Block No. 131
( #bs #cr ..keyboard         clv12.4.87)


: c64key  ( -- 8b)
 curon BEGIN pause c64key?  UNTIL
 curoff getkey ;

14 Constant #bs   0D Constant #cr

: c64decode
 ( addr cnt1 key -- addr cnt2)
  #bs case?  IF  dup  IF del 1- THEN
                            exit  THEN
  #cr case?  IF  dup span ! exit THEN
  >r  2dup +  r@ swap c!  r> emit  1+ ;

: c64expect ( addr len1 -- )
 span !  0
 BEGIN  dup span @  u<
 WHILE  key  decode
 REPEAT 2drop space ;

Input: keyboard   [ here input ! ]
 c64key c64key? c64decode c64expect ;

\ Block No. 132
( con! printable?            clv11.4.87)

Code con!  ( 8b --)   SP X) lda
Label (con!     ConOut jsr    SP 2inc
Label (con!end  CurFlg stx InsCnt stx
 1 # ldy ;c:  pause ;

Label (printable?   \ fuer CBM-Code !
                    \ CS is printable
  80 # cmp  CC ?[   bl # cmp  rts  ]?
 0E0 # cmp  CC ?[  0C0 # cmp  rts  ]?
 clc  rts  end-code

Code printable? ( 8b -- 8b flag)
 SP X) lda  (printable? jsr CS ?[ dex ]?
 txa  PushA jmp     end-code









\ Block No. 133
( emit cr del page at at?    clv11.4.87)

Code c64emit  ( 8b -- )
 SP X) lda  (printable? jsr
    CC ?[  Ascii . # lda ]?
 (con! jmp   end-code

: c64cr     #cr con! ;

: c64del    9D con!  space  9D con! ;

: c64page   93 con! ;

Code c64at  ( row col --)
 2 # lda  Setup jsr
 N 2+ ldx  N ldy  clc  PLOT jsr
(C16 \ ) 0D3 ldy  0D1 )Y lda   0CE sta
 xyNext jmp  end-code

Code c64at?  ( -- row col)
 SP 2dec txa  SP )Y sta
 sec  PLOT jsr
 28 # cpy  tya  CS ?[ 28 # sbc ]?
 pha  txa  0 # ldx  SP X) sta  pla
 Push0A jmp  end-code
\ Block No. 134
( type display (bye          clv11.4.87)

Code  c64type  ( adr len -- )
 2 # lda  Setup jsr  0 # ldy
  [[  N cpy  0<>
  ?[[  N 2+ )Y lda  (printable? jsr
         CC ?[  Ascii . # lda  ]?
 ConOut jsr  iny  ]]?
 (con!end jmp   end-code

Output: display   [ here output ! ]
 c64emit c64cr c64type c64del c64page
 c64at c64at? ;

(C64  | Create (bye  $FCE2  here 2- ! )

(C16- | Create (bye  $FF52  here 2- ! )

(C16+ | CODE   (bye  rom $FF52 jmp
                             end-code )





\ Block No. 135
\ b/blk drive >drive drvinit  clv14:2x87

400 Constant b/blk

0AA Constant blk/drv

Variable (drv    0 (drv !

| : disk ( -- dev.no )   (drv @ 8 + ;

: drive  ( drv# -- )
 blk/drv *  offset ! ;

: >drive ( block drv# -- block' )
 blk/drv * +   offset @ - ;

: drv?    ( block -- drv# )
 offset @ + blk/drv / ;

: drvinit  noop ;





\ Block No. 136
( i/o busoff                  10may85we)

Variable i/o  0 i/o !  \ Semaphor

Code busoff  ( --)   CLRCHN jsr
Label unlocki/o  1 # ldy  0 # ldx
 ;c:  i/o unlock ;

Label nodevice     0 # ldx  1 # ldy
 ;c:  busoff   buffers unlock
      true Abort" no device" ;














\ Block No. 137
\ ?device                     clv12jul87

Label (?dev
 90 stx (C16 $ae sta ( ) LISTEN jsr
        \ wg. Fehler im Betr.syst.
 60 # lda  SECOND jsr  UNLSN jsr
 90 lda  0<> ?[ pla pla nodevice jmp ]?
 rts    end-code

| Code (?device  ( dev --)
 SP X) lda  (?dev jsr  SP 2inc
 unlocki/o jmp  end-code

: ?device  ( dev -- )
 i/o lock  (?device ;

| Code (busout  ( dev 2nd -- )
 MsgFlg stx  2 # lda  Setup jsr
 N 2+ lda  (?dev jsr
 N 2+ lda  LISTEN jsr
 N lda  60 # ora SECOND jsr
 N 2+ ldx  OutDev stx
 xyNext jmp  end-code


\ Block No. 138
\ busout/open/close/in        clv12jul87

: busout    ( dev 2nd -- )
 i/o lock (busout ;

: busopen   ( dev 2nd -- )
 0F0 or busout ;

: busclose  ( dev 2nd -- )
 0E0 or busout busoff ;

| Code (busin  ( dev 2nd -- )
 MsgFlg stx  2 # lda  Setup jsr
 N 2+ lda  (?dev jsr
 N 2+ lda  TALK jsr
 N lda  60 # ora (C16 $ad sta ( )
 TKSA jsr
\ wg. Fehler im C16Betr.sys-alte Vers.
 N 2+ ldx  InDev stx
 xyNext jmp end-code

: busin  ( dev 2nd -- )
 i/o lock  (busin ;


\ Block No. 139
\ bus-!/type/@/input/read      20dec91pz

Code bus!  ( 8b --)
 SP X) lda  CIOUT jsr  (xydrop jmp
 end-code

: bustype  ( adr n --)
 bounds  ?DO  I c@ bus!  LOOP pause ;

Code bus@  ( -- 8b)
 ACPTR jsr Push0A jmp  end-code

: businput  ( adr n --)
 bounds  ?DO  bus@ I c! LOOP pause ;

: i/o-status?  $90 c@ ;

: busread ( adr1 u -- adr2 true )
          ( adr1 u --      false )
     pause  i/o-status? $40 and
        IF drop true exit THEN
     bounds ?DO bus@ I c!
     i/o-status? $40 and
       IF I 1+ UNLOOP true exit THEN
     LOOP false ;
\ Block No. 140
\ derror?                      20dec91pz

: derror?  ( -- flag )
   disk $F busin bus@  dup Ascii 0 -
   IF  BEGIN emit bus@ dup #cr =  UNTIL
   0= cr ELSE BEGIN bus@ #cr = UNTIL
   THEN   0=  busoff ;


















\ Block No. 141
( s#>s+t  x,x                 28may85re)

165 | Constant 1.t
1EA | Constant 2.t
256 | Constant 3.t

| : (s#>s+t ( sector# -- sect track)
      dup 1.t u< IF 15 /mod exit THEN
 3 +  dup 2.t u< IF 1.t - 13 /mod 11 +
                            exit THEN
      dup 3.t u< IF 2.t - 12 /mod 18 +
                            exit THEN
 3.t - 11 /mod 1E + ;

| : s#>t+s  ( sector# -- track sect )
 (s#>s+t  1+ swap ;

| : x,x ( sect track -- adr count)
 base push  decimal
 0 <# #s drop Ascii , hold #s #> ;





\ Block No. 142
( readsector writesector      28may85re)

100 | Constant b/sek

: readsector  ( adr tra# sect# -- flag)
 disk 0F busout
 " u1:13,0," count   bustype
 x,x bustype busoff pause
 derror? ?exit
 disk 0D busin b/sek businput busoff
 false ;

: writesector  ( adr tra# sect# -- flag)
 rot disk 0F busout
 " b-p:13,0" count bustype busoff
 disk 0D busout b/sek bustype busoff
 disk 0F busout
 " u2:13,0," count  bustype
 x,x bustype busoff pause  derror? ;






\ Block No. 143
( 1541r/w                     28may85re)

: diskopen  ( -- flag)
 disk 0D busopen  Ascii # bus! busoff
 derror? ;

: diskclose ( -- )
 disk 0D busclose  busoff ;

: 1541r/w  ( adr blk file r/wf -- flag)
 swap Abort" no file"
 -rot  blk/drv /mod  dup (drv ! 3 u>
 IF . ." beyond capacity" nip exit  THEN
 diskopen  IF  drop nip exit  THEN
 0 swap   2* 2* 4 bounds
 DO  drop  2dup I rot
     IF    s#>t+s readsector
     ELSE  s#>t+s writesector THEN
     >r b/sek + r> dup  IF  LEAVE  THEN
 LOOP   -rot  2drop  diskclose  ;

' 1541r/w  Is   r/w



\ Block No. 144
\ index findex ink-pot         02mar91pz

: index ( from to --)
 1+ swap DO
   cr  I 3 .r  I block ( 1+ 25) 28 type
   stop?  IF LEAVE THEN  LOOP ;

: findex ( from to --)
 diskopen  IF  2drop  exit  THEN
 1+ swap DO  cr  I 3 .r
   pad dup I 2* 2* s#>t+s readsector
   >r ( 1+ 25) 28 type
   r> stop? or IF LEAVE THEN
 LOOP  diskclose  ;

Create ink-pot
    \ border bkgnd pen  0
(C64  6 c,   6 c,  3 c, 0 c,   \ Forth
     0E c,   6 c,  3 c, 0 c,   \ Edi
      6 c,   6 c,  3 c, 0 c, ) \ User
(C16 f6 c, 0f6 c, 03 c, 0 c,   \ Forth
    0eE c, 0f6 c, 03 c, 0 c,   \ Edi
    0f6 c, 0f6 c, 03 c, 0 c, ) \ User


\ Block No. 145
\ restore                      05nov87re

(C16 \\ )

Label asave 0 c,    Label 1save 0 c,

Label continue
 pha  1save lda  1 sta  pla  rti

Label restore   sei  asave sta
 continue $100 /mod
 # lda pha  # lda pha  php  \ for RTI
 asave lda pha  txa pha  tya pha
 1 lda 1save sta
 $36 # lda   1 sta  \ Basic off ROM on
 $7F # lda  $DD0D sta
 $DD0D ldy  0< ?[
Label 6526-NMI $FE72 jmp  ]?
 UDTIM jsr STOP jsr  \ RUN/STOP ?
 6526-NMI bne        \ not >>-->
 ' restart @ jmp  end-code




\ Block No. 146
\ C64:Initialisierung          06nov87re
(C16 \\ )

: init-system   $FF40 dup $C0 cmove
 [ restore ] Literal  dup
 $FFFA ! $318 ! ;  \ NMI-Vector ins RAM

Label first-init
 sei cld
 IOINIT jsr  CINT jsr  RESTOR jsr
  \ init. and set I/O-Vectors
 $36 # lda   01 sta        \ Basic off
 ink-pot    lda BrdCol sta \ border
 ink-pot 1+ lda BkgCol sta \ backgrnd
 ink-pot 2+ lda PenCol sta \ pen
$80 # lda KeyRep sta  \ repeat all keys
$17 # lda  $D018 sta  \ low/upp +
  0 # lda  $D01A sta  \ VIC-IRQ off
$1B # lda  $D011 sta  \ Textmode on
  4 # lda   $288 sta  \ low screen
 cli rts end-code
first-init dup bootsystem 1+ !
               warmboot   1+ !
Code c64init first-init jsr
 xyNext jmp end-code
\ Block No. 147
\ C16:Initialisierung..   01oct87clv/re)

(C64 \\ )

Code init-system $F7 # ldx  txs
 xyNext jmp end-code

$fcb3 >label IRQ   \ normaler Interrupt
$fffe >label >IRQ  \ 6502-Ptr auf Int.

\ selbstmodifizierend:
Label RAMIRQ       \ der neue Interrupt
   rom RAMIRQ $15 + sta RAMIRQ $17 + stx
(  +9) RAMIRQ $1b + $100 u/mod # lda pha
                               # lda pha
(  +f) tsx $103 ,x lda pha   \ flags
( +14) 0 # lda 0 # ldx IRQ jmp
( +1b) ram rti end-code







\ Block No. 148
\ C16:..Initialisierung   01oct87clv/re)

(C64 \\ )

Label first-init
   \ wird beim ersten Mal
   \ aus ROM,spaeter aus RAM aufgerufen
 sei rom
 RAMIRQ $100 u/mod    \ neuen IRQ
   # lda >IRQ 1+ sta  \ .. installieren
   # lda >IRQ sta
 $FF84 normJsr  $FF8A normJsr
    \ CIAs init. and set I/O-Vectors
 ink-pot    lda BrdCol sta \ border
 ink-pot 1+ lda BkgCol sta \ backgrnd
 ink-pot 2+ lda PenCol sta \ pen
 $80 # lda KeyRep sta \ repeat all keys
 $FF13 lda 04 # ora $FF13 sta \ low/upp
 ram cli rts end-code

first-init dup bootsystem 1+ !
               warmboot   1+ !

Code c64init first-init jsr
 xyNext jmp end-code
\ Block No. 149
\ C16-Pushkeys C64-like   01oct87clv/re)


(C16

Label InitPKs \ Pushkeys: Daten
00 c, 00 c,  \ akt. Zeichenzahl, aktPtr.
01 c, 01 c, 01 c, 01 c, \ StrLaengen
01 c, 01 c, 01 c, 01 c, \   "

85 c, 86 c, 87 c, 89 c, \ Inhalt
8a c, 8b c, 8c c, 88 c, \   "


here InitPKs - >label InitPKlen


Code C64fkeys \ Pushkeys a la C64
  InitPKlen # ldx
  [[ dex  0>= ?[[
    InitPKs ,X lda PKeys ,x sta ]]?
  xyNext jmp end-code

)

\ Block No. 150

























\ Block No. 151

























\ Block No. 152

























\ Block No. 153
( restart param.-passing     clv12.4.87)

Code restart       here >restart !
 ' (restart >body 100 u/mod
 # lda  pha  # lda pha
 warmboot jmp   end-code

\ Code for parameter-passing to Forth


      03 18 +thru     \ CBM-Interface
(c16+ 19 1a +thru )   \ c16init RamIRQ

Host  ' Transient 8 + @
  Transient  Forth  Context @ 6 + !
Target     \ kotz wuerg !

Forth also definitions
         : )     ; immediate
(C64     : (C64  ; immediate )
(C16     : (C16  ; immediate )
(C64 \ ) : (C64  [compile] ( ; immediate
(C16 \ ) : (C16  [compile] ( ; immediate
: forth-83 ;  \ last word in Dictionary

\ Block No. 154

























\ Block No. 155

























\ Block No. 156

























\ Block No. 157

























\ Block No. 158

























\ Block No. 159

























\ Block No. 160

























\ Block No. 161

























\ Block No. 162

























\ Block No. 163

























\ Block No. 164

























\ Block No. 165

























\ Block No. 166

























\ Block No. 167

























\ Block No. 168

























\ Block No. 169

























