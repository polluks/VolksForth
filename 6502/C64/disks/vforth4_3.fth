
\ *** Block No. 0, Hexblock 0

\\ Directory ultraFORTH 3of4   26oct87re

.                   &0
..                  &0
rom-ram-sys         &2
Transient-Assembler &4
Assembler-6502      &5
2words             &14
unlink             &15
scr<>cbm           &16
(search            &17
Editor             &19
.blk               &46
Tracer/Tools       &47
Multi-Tasker       &57
EpsonRX80          &63
VC1526             &75
CP-80              &78








\ *** Block No. 1, Hexblock 1

\\ Content volksForth 3.81.02 cas16aug06


rom ram sys          2 - 3
Transient Assembler  4
Assembler-6502       5 - 12
                    13       free
2words              14
unlink              15
scr<>cbm            16
(search             17
Editor              19
.blk                46
Tracer Tools        47
Multi-Tasker        57
Printer: EpsonRX80  63
Printer: VC1526     75
Printer: CP-80      78

Shadows             85 ...






\ *** Block No. 2, Hexblock 2

\ rom ram sys                 cas16aug06
\              Shadow with Ctrl+W--->

\ needed for jumps
\ in the ROM Area

Assembler also definitions
(16 \ Switch Bank 8000-FFFF
: rom here 9 + $8000 u> abort" not here"
       $ff3e sta ;
: ram  $ff3f sta ;
: sys rom jsr ram ;
\  if suffering from abort" not here"
\  see next screen Screen --> C)


(64 \ Switch Bank A000-BFFF
: rom here 9 + $A000 u> abort" not here"
      $37 # lda 1 sta ;
: ram $36 # lda 1 sta ;
C)





\ *** Block No. 3, Hexblock 3

\ sysMacro Long               cas16aug06

(64  .( not for C64 !) \\ C)

\ for advanced users, use macros

here $8000 $20 - u> ?exit \ not possible


' 0 | Alias ???

Label long   ROM
Label long1  ??? jsr  RAM  rts end-code

| : sysMacro ( adr -- )
 $100 u/mod  pha  # lda  long1 2+ sta
 # lda  long1 1+ sta  pla  long jsr ;

: sys ( adr -- ) \ for Jsr to ROM
 here 9 + $8000 u>
 IF  sysMacro  ELSE  sys  THEN ;





\ *** Block No. 4, Hexblock 4

\ transient Assembler         clv10oct87

\ Basis: Forth Dimensions VOL III No. 5)

\ internal loading         04may85BP/re)

here   $800 hallot  heap dp !

         1  +load

dp !

Onlyforth













\ *** Block No. 5, Hexblock 5

\ Forth-6502 Assembler        clv10oct87

\ Basis: Forth Dimensions VOL III No. 5)

Onlyforth  Assembler also definitions

1 7  +thru
 -3  +load \ Makros: rom ram sys

Onlyforth
















\ *** Block No. 6, Hexblock 6

\ Forth-83 6502-Assembler      20oct87re

: end-code   context 2- @  context ! ;

Create index
$0909 , $1505 , $0115 , $8011 ,
$8009 , $1D0D , $8019 , $8080 ,
$0080 , $1404 , $8014 , $8080 ,
$8080 , $1C0C , $801C , $2C80 ,

| Variable mode

: Mode:  ( n -)   Create c,
  Does>  ( -)     c@ mode ! ;

0   Mode: .A        1    Mode: #
2 | Mode: mem       3    Mode: ,X
4   Mode: ,Y        5    Mode: X)
6   Mode: )Y       $F    Mode: )







\ *** Block No. 7, Hexblock 7

\ upmode  cpu                  20oct87re

| : upmode ( addr0 f0 - addr1 f1)
 IF mode @  8 or mode !   THEN
 1 mode @  $F and ?dup IF
 0 DO  dup +  LOOP THEN
 over 1+ @ and 0= ;

: cpu  ( 8b -)   Create  c,
  Does>  ( -)    c@ c, mem ;

 00 cpu brk $18 cpu clc $D8 cpu cld
$58 cpu cli $B8 cpu clv $CA cpu dex
$88 cpu dey $E8 cpu inx $C8 cpu iny
$EA cpu nop $48 cpu pha $08 cpu php
$68 cpu pla $28 cpu plp $40 cpu rti
$60 cpu rts $38 cpu sec $F8 cpu sed
$78 cpu sei $AA cpu tax $A8 cpu tay
$BA cpu tsx $8A cpu txa $9A cpu txs
$98 cpu tya






\ *** Block No. 8, Hexblock 8

\ m/cpu                        20oct87re

: m/cpu  ( mode opcode -)  Create c, ,
 Does>
 dup 1+ @ $80 and IF $10 mode +! THEN
 over $FF00 and upmode upmode
 IF mem true Abort" invalid" THEN
 c@ mode @ index + c@ + c, mode @ 7 and
 IF mode @  $F and 7 <
  IF c, ELSE , THEN THEN mem ;

$1C6E $60 m/cpu adc $1C6E $20 m/cpu and
$1C6E $C0 m/cpu cmp $1C6E $40 m/cpu eor
$1C6E $A0 m/cpu lda $1C6E $00 m/cpu ora
$1C6E $E0 m/cpu sbc $1C6C $80 m/cpu sta
$0D0D $01 m/cpu asl $0C0C $C1 m/cpu dec
$0C0C $E1 m/cpu inc $0D0D $41 m/cpu lsr
$0D0D $21 m/cpu rol $0D0D $61 m/cpu ror
$0414 $81 m/cpu stx $0486 $E0 m/cpu cpx
$0486 $C0 m/cpu cpy $1496 $A2 m/cpu ldx
$0C8E $A0 m/cpu ldy $048C $80 m/cpu sty
$0480 $14 m/cpu jsr $8480 $40 m/cpu jmp
$0484 $20 m/cpu bit



\ *** Block No. 9, Hexblock 9

\ Assembler conditionals       20oct87re

| : range?   ( branch -- branch )
 dup abs  $7F u> Abort" out of range " ;

: [[  ( BEGIN)  here ;

: ?]  ( UNTIL)  c, here 1+ - range? c, ;

: ?[  ( IF)     c,  here 0 c, ;

: ?[[ ( WHILE)  ?[ swap ;

: ]?  ( THEN)   here over c@  IF swap !
 ELSE over 1+ - range? swap c! THEN ;

: ][  ( ELSE)   here 1+   1 jmp
 swap here over 1+ - range?  swap c! ;

: ]]  ( AGAIN)  jmp ;

: ]]? ( REPEAT) jmp ]? ;




\ *** Block No. 10, Hexblock a

\ Assembler conditionals       20oct87re

$90 Constant CS     $B0 Constant CC
$D0 Constant 0=     $F0 Constant 0<>
$10 Constant 0<     $30 Constant 0>=
$50 Constant VS     $70 Constant VC

: not    $20 [ Forth ] xor ;

: beq    0<> ?] ;   : bmi   0>= ?] ;
: bne    0=  ?] ;   : bpl   0<  ?] ;
: bcc    CS  ?] ;   : bvc   VS  ?] ;
: bcs    CC  ?] ;   : bvs   VC  ?] ;













\ *** Block No. 11, Hexblock b

\ 2inc/2dec   winc/wdec        20oct87re

: 2inc  ( adr -- )
 dup lda  clc  2 # adc
 dup sta  CS ?[  swap 1+ inc  ]?  ;

: 2dec  ( adr -- )
 dup lda  sec  2 # sbc
 dup sta  CC ?[  swap 1+ dec  ]?  ;

: winc  ( adr -- )
 dup inc  0= ?[  swap 1+ inc  ]?  ;

: wdec  ( adr -- )
 dup lda  0= ?[  over 1+ dec  ]?  dec  ;

: ;c:
 recover jsr  end-code ]  0 last !  0 ;








\ *** Block No. 12, Hexblock c

\ ;code Code code>          bp/re03feb85

Onlyforth

: Assembler
 Assembler   [ Assembler ] mem ;

: ;Code
 [compile] Does>  -3 allot
 [compile] ;      -2 allot   Assembler ;
immediate

: Code  Create here dup 2- ! Assembler ;

: >label  ( adr -)
 here | Create  immediate  swap ,
 4 hallot heap 1 and hallot ( 6502-alig)
 here 4 - heap  4  cmove
 heap last @ count $1F and + !  dp !
  Does>  ( - adr)   @
  state @ IF  [compile] Literal  THEN ;

: Label
 [ Assembler ]  here >label Assembler ;


\ *** Block No. 13, Hexblock d

\ free                        cas16aug06

























\ *** Block No. 14, Hexblock e

\ 2! 2@ 2variable 2constant clv20aug87re

Code 2!  ( d adr --)
 tya  setup jsr  3 # ldy
 [[  SP )Y lda  N )Y sta  dey  0< ?]
 1 # ldy  Poptwo jmp  end-code

Code 2@  ( adr -- d)
 SP X) lda  N sta  SP )Y lda  N 1+ sta
 SP 2dec  3 # ldy
 [[  N )Y lda  SP )Y sta  dey  0< ?]
 xyNext jmp  end-code

: 2Variable  ( --)   Create 4 allot ;
             ( -- adr)

: 2Constant  ( d --)   Create , ,
  Does> ( -- d)   2@ ;

\ 2dup  exists
\ 2swap exists
\ 2drop exists




\ *** Block No. 15, Hexblock f

\ unlink                    clv20aug87re

$FFF0 >label plot

(64

Code unlink  ( -- )
  $288 lda  $80 # ora  tay  txa
  [[  $D9 ,X sty  clc  $28 # adc
   CS ?[  iny  ]?  inx  $1A # cpx  0= ?]
  $D3 lda  $28 # cmp
  CS ?[  $28 # sbc  $D3 sta  ]?
  $D3 ldy  $D6 ldx  clc  plot jsr C)

(16 : unlink  0 0  $7EE 2! ; C)

Label setptrs
 0 # ldx  1 # ldy  Next jmp  end-code








\ *** Block No. 16, Hexblock 10

\ changing codes              cas16aug06

( mapping commodore screen codes       )


Label (scr>cbm
 N 6 + sta $3F # and  N 6 + asl
 N 6 + bit  0< ?[ $80 # ora  ]?
            VC ?[ $40 # ora  ]?  rts

Label (cbm>scr
 N 6 + sta $7F # and $20 # cmp
 CS ?[ $40 # cmp
    CS ?[ $1F # and  N 6 + bit
       0< ?[ $40 # ora  ]?  ]?  rts  ]?
 Ascii . # lda  rts

Code cbm>scr  ( 8b1 -- 8b2)
 SP X) lda  (cbm>scr jsr  SP X) sta
 Next jmp  end-code

Code scr>cbm  ( 8b1 -- 8b2)
 SP X) lda  (scr>cbm jsr  SP X) sta
 Next jmp  end-code


\ *** Block No. 17, Hexblock 11

\ fast search                 cas16aug06

\needs Code -$D +load \ Trans Assembler

Onlyforth

 ' 0< @ 4 +  >label puttrue
puttrue 3 +  >label putfalse

Code (search
( text tlen buffer blen -- adr tf / ff)
 7 # ldy
 [[  SP )Y lda  N ,Y sta dey  0< ?]
 [[ N 4 + lda  N 5 + ora  0<> ?[
 [[ N     lda   N 1+ ora  0<> ?[
    N 2+ X) lda  N 6 + X) cmp  swap
    0<> ?[[  N wdec  N 2+ winc  ]]?

-->







\ *** Block No. 18, Hexblock 12

\ Edior fast search           cas16aug06

 7 # ldy
 [[  N ,Y lda  SP )Y sta  dey  0< ?]
 [[  N 2+ winc  N 6 + winc  N wdec
 N 4 + wdec  N 4 + lda  N 5 + ora
 0= ?[  SP lda  clc  4 # adc  SP sta
        CS ?[  SP 1+ inc  ]?
        3 # ldy  N 3 + lda  SP )Y sta
        N 2+ lda  dey  SP )Y sta  dey
        puttrue jmp  ]?
 N lda  N 1+ ora  0= ?[
 3 roll  3 roll ]? ]?
 SP lda  clc  6 # adc  SP sta
 CS ?[  SP 1+ inc ]?   1 # ldy
 putfalse jmp  ]?
 N 2+ X) lda  N 6 + X) cmp  0= not ?]
 7 # ldy
 [[ SP )Y lda  N ,Y sta  dey  0< ?]
 N wdec  N 2+ winc
 ( next char as first )  ]]  end-code





\ *** Block No. 19, Hexblock 13

\ Editor loadscreen           clv13jul87
\ Idea and first implementation:  WE/re

Onlyforth
\needs .blk       $1B +load \ .blk
\needs Code       -$F +load \ Assembl
\needs (search     -2 +load \ (search

Onlyforth
(64 | : at  at curoff ; C) \ sorry

\needs 2variable  -5 +load
\needs unlink     -4 +load  \ unlink
\needs scr>cbm    -3 +load  \ cbm><scr

Vocabulary Editor
Editor also definitions

                1 $17 +thru  \ Editor
              $18 $19 +thru  \ edit-view
                  $1A +load  \ Ediboard

Onlyforth  1 scr !  0 r# !

save

\ *** Block No. 20, Hexblock 14

\ Edi Constants Variables     clv15jul87

$28 | Constant #col $19 | Constant #row
#col  #row  *           | Constant b/scr
  Variable shadow   $55 shadow !
| Variable ascr     1 ascr !
|  Variable imode   imode off
| Variable char     #cr char !
| Variable scroll   scroll on
| Variable send     1 send !
| 2variable chars   | 2variable lines
| 2variable fbuf    | 2variable rbuf

(64 $288 C)  (16 $53e C)  >Label scradr
(64 $d800 C) (16 $800 C)  >Label coladr

$d1  (16 drop $c8 C) | Constant linptr
$d3  (16 drop $ca C) | Constant curofs

(64 $D020 C) (16 $ff19 C)
 | Constant border
(64 $286  C) (16 $53b C) | Constant pen
(64 $d021 C) (16 $ff15 C)
 | Constant bkgrnd


\ *** Block No. 21, Hexblock 15

\ Edi special cmoves          cas16aug06
( thanks to commodore....          )

Label incpointer
 N    lda  clc  #col 1+ # adc
 N    sta  CS ?[  N 1+  inc  ]?
 N 2+ lda  clc  #col    # adc
 N 2+ sta  CS ?[  N 3 + inc  ]?  rts

| Code b>sc   ( blkadr --)
 tya  setup jsr
 N 2+ stx  scradr lda  N 3 + sta
 #row # ldx
 [[  #col 1- # ldy
     [[  N    )Y lda  (cbm>scr jsr
         N 2+ )Y sta  dey  0< ?]
     incpointer jsr  dex
 0= ?]
 pen lda
 [[ coladr        ,X sta
    coladr $100 + ,X sta
    coladr $200 + ,X sta
    coladr $300 + ,X sta
    inx  0= ?]  setptrs jmp   end-code


\ *** Block No. 22, Hexblock 16

\ Edi special cmoves cont.    cas16aug06
( ... for screen format                )

| Code sc>b   ( blkadr --)
 tya  setup jsr
 N 2+ stx  scradr lda  N 3 + sta
 #row # ldx
 [[  0 # ldy
     [[  N 2+ )Y lda  (scr>cbm jsr
         N )Y sta  iny  #col # cpy CS ?]
     dex
 0<> ?[[
     bl # lda  N )Y sta
     incpointer jsr
 ]]?  setptrs jmp  end-code

| Code >scrmove  ( from to 8bquan --)
 3 # lda  setup jsr  dey
 [[  N cpy  0= ?[  setptrs jmp  ]?
     N 4 + )Y lda  (cbm>scr jsr
     N 2+  )Y sta  iny  0= ?]  end-code





\ *** Block No. 23, Hexblock 17

\ Edi changed?                cas16aug06

| Code changed?   ( blkadr -- f)
 tya  setup jsr
 N 2+ stx  scradr lda  N 3 + sta
 #row # ldx
 [[  #col 1- # ldy
     [[  N )Y lda  (cbm>scr jsr
         N 2+ )Y cmp
         0<> ?[  $FF # lda  PushA jmp ]?
         dey 0<  ?]
     incpointer jsr  dex
 0= ?]
 txa  PushA jmp  end-code

| : memtop  sp@ #col 2* - ;










\ *** Block No. 24, Hexblock 18

\ Edi c64-specials           clv2:jull87

| Code scrstart  ( -- adr)
 txa pha scradr lda  Push jmp end-code


| Code rowadr  ( -- adr)
 curofs lda  #col # cmp  txa
 CS ?[  #col 1- # lda  ]?
 linptr adc pha linptr 1 + lda  0 # adc
 Push jmp  end-code

| Code curadr  ( -- adr)
 clc curofs lda linptr adc  pha
 linptr 1 + lda 0 # adc Push jmp
 end-code
(64
| Code unlinked?     \ -- f
 $D5 lda  #col # cmp  CC ?[  dex  ]?
 txa  PushA jmp  end-code C)






\ *** Block No. 25, Hexblock 19

\ Edi scroll? put/insert/do  clv2:jull87

| : blank.end?  ( -- f)
 scrstart [ b/scr #col - ] Literal +
 #col -trailing nip  0=  scroll @ or ;

| : atlast?  ( -- f)
 curadr  scrstart b/scr + 1-  =
 scroll @ 0=  and ;

| : putchar  ( -- f)
 char c@ con! false ;

| : insert  ( -- f)
 atlast?  ?dup ?exit
(64  unlinked? C) (16 true C)
 rowadr #col + 1- c@  bl = not  and
 blank.end? not  and  dup ?exit
 $94 con! ;

| : dochar  ( -- f)
 atlast?  ?dup ?exit
 imode @ IF insert ?dup ?exit
 THEN putchar ;


\ *** Block No. 26, Hexblock 1a

\ Edi cursor control          cas16aug06

| : curdown  ( -- f)
 scroll @ 0=  row  #row 2-  u>  and
 dup ?exit $11 con! ;

| : currite  ( -- f)
 atlast? dup ?exit $1D con! ;

' putchar | Alias curup
' putchar | Alias curleft
' putchar | Alias home
' putchar | Alias delete

| : >""end  ( -- ff)
 scrstart b/scr -trailing nip
 b/scr 1- min #col /mod swap at false ;

| : +tab  ( -- f)
 0  $a 0 DO  drop currite dup
            IF LEAVE THEN  LOOP ;

| : -tab  ( -- f)
 5 0 DO $9D con!  LOOP  false ;


\ *** Block No. 27, Hexblock 1b

\ Edi cr, clear/newline       cas16aug06

| : <cr>  ( -- f)
 row 0 at  unlink  imode off  curdown ;

| : clrline  ( -- ff)
 rowadr #col bl fill false ;

| : clrright  ( -- ff)
 curadr #col col - bl fill false ;

| : killine  ( -- f)
 rowadr dup #col + swap
 scrstart $3C0 + dup >r
 over - cmove
 r> #col bl fill false ;

| : newline  ( -- f)
 blank.end? not  ?dup ?exit
 rowadr dup #col + scrstart b/scr +
 over - cmove>  clrline ;





\ *** Block No. 28, Hexblock 1c

\ Edi character handling      cas16aug06

| : dchar  ( -- f)
 currite  dup ?exit $14 con! ;

| : @char  ( -- f)
 chars 2@ + 1+  lines @ memtop min
 u>  dup ?exit
 curadr c@  chars 2@ +  c!
 1 chars 2+ +! ;

| : copychar  ( -- f)
 @char  ?dup ?exit  currite ;

| : char>buf  ( -- f)
 @char  ?dup ?exit  dchar ;

| : buf>char  ( -- f)
 chars 2+ @ 0=  ?dup ?exit
 insert        dup ?exit
 -1 chars 2+ +!
 chars 2@ +  c@  curadr c! ;




\ *** Block No. 29, Hexblock 1d

\ Edi line handling, imode    cas16aug06

| : @line  ( -- f)
 lines 2@ +  memtop  u>  dup ?exit
 rowadr  lines 2@ +  #col  cmove
 #col lines 2+ +! ;

| : copyline  ( -- f)
 @line  ?dup ?exit  curdown ;

| : line>buf  ( -- f)
 @line  ?dup ?exit  killine ;

| : !line  ( --)
 #col negate lines 2+ +!
 lines 2@ +  rowadr  #col  cmove  ;

| : buf>line  ( -- f)
 lines 2+ @ 0=  ?dup ?exit
 newline  dup ?exit  !line ;

| : setimd  ( -- f)   imode on false ;

| : clrimd  ( -- f)   imode off false ;


\ *** Block No. 30, Hexblock 1e

\ Edi the stamp               cas16aug06

Forth definitions
: rvson $12 con! ;  : rvsoff $92 con! ;

Code ***volksFORTH83***
     Next here 2- !  end-code
: Forth-Gesellschaft   [compile] \\ ;
immediate

Editor definitions
Create stamp$ $12 allot stamp$ $12 erase

| : .stamp  ( -- ff)
 stamp$ 1+ count  scrstart #col +
 over -   swap >scrmove false ;

: getstamp  ( --)
 input push  keyboard  stamp$ on
 cr ." your stamp: "  rvson $10 spaces
 row $C at  stamp$ 2+ $10 expect
 rvsoff  span @ stamp$ 1+ c! ;

| : stamp?  ( --)
 stamp$ c@ ?exit getstamp ;

\ *** Block No. 31, Hexblock 1f

\ Edi the screen#             cas16aug06

| : savetop  ( --)
 scrstart pad #col 2* cmove
 scrstart #col 2* $A0 fill ;
| : resttop  ( --)
 pad scrstart #col 2* cmove ;
| : updated?  ( scr# -- n)
 block 2- @ ;
| : special  ( --)
 curon BEGIN pause key? UNTIL curoff ;

| : drvScr ( --drv scr')
 scr @ offset @ + blk/drv u/mod swap ;

| : .scr#  ( -- ff) at? savetop  rvson
 0 0 at drvScr ." Scr # " . ." Drv " .
 scr @ updated? 0=
 IF ." not " THEN ." updated"  1 1 at
 [ ' ***volksFORTH83*** >name ] Literal
 count type 2 spaces
 [ ' Forth-Gesellschaft >name ] Literal
 count $1F and type
 rvsoff at special resttop false ;


\ *** Block No. 32, Hexblock 20

\ Edi exits                   cas16aug06

| : at?>r#  ( --)
 at? swap #col 1+ * + r# ! ;

| : r#>at  ( --)
 r# @  dup  #col 1+  mod  #col =  -
 b/blk 1- min  #col 1+  /mod  swap at ;

| : cancel  ( -- n)
 unlink  %0001  at?>r# ;

| : eupdate ( -- n)
 cancel  scr @ block changed?
 IF .stamp drop  scr @ block sc>b
    update %0010 or THEN ;

| : esave   ( -- n)   eupdate %0100 or ;

| : eload   ( -- n)   esave   %1000 or ;






\ *** Block No. 33, Hexblock 21

\ leaf thru Edi               clv01aug87

| : elist  ( -- ff)
 scr @ block b>sc  imode off  unlink
 r#>at  false ;

| : next    ( -- ff)
 eupdate drop  1 scr +!  elist ;

| : back    ( -- ff)
 eupdate drop -1 scr +!  elist ;

| : >shadow  ( -- ff)
 eupdate drop  shadow @ dup drvScr nip
 u> not IF negate THEN  scr +!  elist ;

| : alter  ( -- ff)
 eupdate drop  ascr @  scr @
 ascr !  scr !  elist ;







\ *** Block No. 34, Hexblock 22

\ Edi digits                    2oct87re

Forth definitions

: digdecode  ( adr cnt1 key -- adr cnt2)
 #bs case?   IF  dup  IF
                 del 1- THEN exit THEN
 #cr case?   IF  dup span !  exit THEN
 capital dup digit?
 IF  drop >r 2dup + r@ swap c!
     r> emit  1+  exit  THEN  drop ;

Input: digits
 c64key c64key? digdecode c64expect ;

Editor definitions

| : replace  ( -- f)
 fbuf @ 0 DO  #bs con!  LOOP
 false rbuf @ 0 DO insert or LOOP
 dup ?exit
 rbuf 2@ curadr swap >scrmove
 eupdate drop ;



\ *** Block No. 35, Hexblock 23

\ Edi >bufs                   cas16aug06

| : .buf  ( adr count --)
 type Ascii < emit
 #col 1- col - spaces ;

| : >bufs  ( --)
 input push
 unlink savetop at?  rvson
 1 0 at ." replace with: "
 at? rbuf 2@ .buf
 0 0 at ." >     search: "
 at? fbuf 2@ .buf
 0 2  2dup at  send @ 3 u.r  2dup at
 here 1+ 3 digits expect  span @ ?dup
 IF  here under c!  number drop send !
     THEN  at  send @ 3 u.r  keyboard
 2dup at fbuf 2+ @  #col 2- col - expect
 span @ ?dup IF  fbuf !  THEN
 at fbuf 2@ .buf
 2dup at rbuf 2+ @  #col 2- col - expect
 span @ ?dup IF  rbuf !  THEN
 at rbuf 2@ .buf
 rvsoff resttop at ;


\ *** Block No. 36, Hexblock 24

\ Edi esearch                 clv06aug87

| : (f      elist drop
 fbuf 2@  r# @  scr @ block  +
 b/blk r# @ - (search 0=
 IF  0  ELSE  scr @ block -  THEN
 r# !  r#>at ;

| : esearch  ( -- f)
 eupdate drop  >bufs
 BEGIN BEGIN  (f  r# @
       WHILE  key  dup Ascii r =
              IF replace ?dup
                 IF nip exit THEN THEN
              3 = ?dup ?exit
       REPEAT  drvScr nip send @ -
       stop? 0= and ?dup
 WHILE 0< IF   next drop
          ELSE back drop THEN
 REPEAT true ;






\ *** Block No. 37, Hexblock 25

\ Edi keytable                cas16aug06
| : Ctrl  ( -- 8b)
 [compile] Ascii $40 - ; immediate
| Create keytable
Ctrl n c, Ctrl b c, Ctrl w c, Ctrl a c,
$1F c, (64 Ctrl ^ C)      (16 $92 C) c,
$0D c,   $8D c,
Ctrl c c, Ctrl x c, Ctrl f c, Ctrl l c,
$85 c,   $89 c,    $86 c,    $8A c,
$9F c,   $1C c, (64 00 C) (16 $1e C) c,
$8B c,   $87 c,    $88 c,    $8C c,
$1D c,   $11 c,    $9D c,    $91 c,
$13 c,   $93 c,    $94 c,
$14 c,    Ctrl d c, Ctrl e c, Ctrl r c,
Ctrl i c, Ctrl o c,
                             $ff c,










\ *** Block No. 38, Hexblock 26

\ Edi actiontable             cas16aug06


| Create actiontable ]
next      back      >shadow   alter
esearch   copyline
<cr>      <cr>
cancel    eupdate   esave     eload
newline   killine   buf>line  line>buf
.stamp    .scr#           copychar
char>buf  buf>char  +tab      -tab
currite   curdown   curleft   curup
home      >""end    insert
delete    dchar     clrline   clrright
setimd    clrimd
                              dochar  [
| Code findkey  ( key n -- adr)
 2 # lda  setup jsr  N ldy  dey
 [[  iny  keytable ,Y lda  $FF # cmp
     0<> ?[  N 2+ cmp  ]?  0= ?]
 tya  .A asl  tay
 actiontable    ,Y lda  pha
 actiontable 1+ ,Y lda  Push jmp
end-code


\ *** Block No. 39, Hexblock 27

\ Edi show errors             cas16aug06


' 0   | Alias dark

' 1   | Alias light

| : half  ( n --)
 border c!  pause $80 0 DO LOOP ;

| : blink ( --)
 border push  dark half light half
              dark half light half ;

| : ?blink ( f1 -- f2)
 dup true = IF  blink 0=  THEN ;










\ *** Block No. 40, Hexblock 28

\ Edi init                    cas16aug06

' Literal | Alias Li  immediate

Variable (pad       0 (pad !

| : clearbuffer  ( --)
 pad       dup  (pad  !
 #col 2* + dup  fbuf  2+ !
 #col    + dup  rbuf  2+ !
 #col    + dup  chars !
 #col 2* +      lines !
 chars 2+ off  lines 2+ off
 [ ' ***volksFORTH83*** >name ] Li
 count >r fbuf 2+ @ r@ cmove r> fbuf !
 [ ' Forth-Gesellschaft >name ] Li
 count $1F and >r
 rbuf 2+ @ r@ cmove r> rbuf ! ;

| : initptr ( --)
 pad (pad @ = ?exit clearbuffer ;





\ *** Block No. 41, Hexblock 29

\ Edi show                    cas16aug06

' name >body 6 +  | Constant 'name
(16 \ c16 is using standard C)

(64
| Code curon
 $D3 ldy    $D1 )Y lda  $CE sta
 $80 # eor  $D1 )Y sta
 xyNext jmp  end-code

| Code curoff
 $CE lda  $D3 ldy  $D1 )Y sta
 xyNext jmp  end-code

C)










\ *** Block No. 42, Hexblock 2a

\ Edi show                    cas16aug06

| : showoff
 ['] exit 'name !  rvsoff  curoff ;

| : show  ( --)
 blk @ ?dup 0= IF  showoff exit  THEN
 >in @ 1-  r# !  rvsoff curoff rvson
 scr @  over - IF  scr !  elist
 1 0 at .status THEN r#>at curon drop ;

Forth definitions

: (load  ( blk pos --)
 >in push  >in !  ?dup 0= ?exit
 blk push  blk !  .status interpret ;

: showload  ( blk pos -)
 scr push  scr off  r# push
 ['] show 'name ! (load showoff ;

Editor definitions




\ *** Block No. 43, Hexblock 2b

\ Edi edit                    clv01aug87
| : setcol ( 0 / 4 / 8 --)
 ink-pot +
 dup c@ border c! dup 1+ c@ bkgrnd c!
  2+ c@ pen c! ;
| : (edit  ( -- n)
 4 setcol $93 con!
 elist drop  scroll off
 BEGIN key dup char c!
   0 findkey execute ?blink ?dup UNTIL
 0 0 at killine drop  scroll on
 0 setcol (16 0 $7ea c! C) \ Append-Mode
;
Forth definitions
: edit ( scr# -) (16 c64fkeys C)
 scr !  stamp?  initptr  (edit
 $18 0 at  drvScr ." Scr " . ." Drv " .
 dup 2 and 0=  IF ." not "     THEN
                  ." changed"
 dup 4 and     IF save-buffers THEN
 dup 6 and 6 = IF ." , saved"  THEN
     8 and     IF ." , loading" cr
       scr @  r# @  showload   THEN ;



\ *** Block No. 44, Hexblock 2c

\ Editor Forth83             clv2:jull87

: l  ( scr -)   r# off  edit ;
: r  ( -)       scr @ edit ;
: +l ( n -)     scr @ + l ;

: v  ( -) ( text)
 '  >name  ?dup IF  4 - @  THEN  ;

: view  ( -) ( text)
 v ?dup
 IF  l  ELSE  ." from keyboard"  THEN ;

Editor definitions

(16 | : curaddr \ --Addr
     linptr @ curofs c@ + ; C)

: curlin  ( --curAddr linLen) \ & EOLn
(64 linptr @ $D5 c@ -trailing
     dup $d3 c! C)
(16 $1b con! ascii j con! curaddr
    $1b con! ascii k con! $1d con!
     curaddr  over - C) ;


\ *** Block No. 45, Hexblock 2d

\ Edidecode                  ccas16aug06

: edidecode  ( adr cnt1 key -- adr cnt2)
 $8D case? IF  imode off cr exit  THEN
 #cr case? IF  imode off
curlin dup span @ u> IF drop span @ THEN
  bounds ?DO
  2dup +  I c@ scr>cbm  swap c!  1+ LOOP
  dup span !  exit  THEN
 dup char c!
 $12 findkey execute ?blink drop ;


: ediexpect ( addr len1 -- )
 initptr  span !
 0 BEGIN  dup span @  u<
   WHILE  key decode  REPEAT
 2drop space ;

Input: ediboard
 c64key c64key? edidecode ediexpect ;

ediboard



\ *** Block No. 46, Hexblock 2e

\ .status                     cas16aug06

' noop Is .status

: .blk  ( -)
 blk @ ?dup IF  ."  Blk " u. ?cr  THEN ;

' .blk Is .status


















\ *** Block No. 47, Hexblock 2f

\ tracer: loadscreen          cas16aug06

Onlyforth

\needs Code -$2B +load \ Trans Assembler

\needs Tools   Vocabulary Tools

Tools also definitions

   1 6  +thru  \ Tracer
   7 8  +thru  \ Tools for decompiling

Onlyforth

\\

This nice Forth Tracer has been
developed by B. Pennemann and co
for Atari ST. CL Vogt has ported it
back to the volksForth 6502 C-16 and
C-64




\ *** Block No. 48, Hexblock 30

\ tracer: wcmp variables      clv04aug87

Assembler also definitions

: wcmp ( adr1 adr2--) \ Assembler-Macro
 over lda dup cmp swap  \ compares word
 1+   lda 1+  sbc ;


Only Forth also Tools also definitions

| Variable (W
| Variable <ip      | Variable ip>
| Variable nest?    | Variable trap?
| Variable last'    | Variable #spaces











\ *** Block No. 49, Hexblock 31

\ tracer:cpush oneline        cas16aug06

| Create cpull    0  ]
 rp@ count 2dup + rp! r> swap cmove ;

: cpush  ( addr len -)
 r> -rot   over  >r
 rp@ over 1+ - dup rp!  place
 cpull >r  >r ;

| : oneline  &82 allot keyboard display
 .status  space  query  interpret
 -&82 allot  rdrop
 ( delete quit from tnext )  ;

: range ( adr--) \ gets <ip ip>
 ip> off  dup <ip !
 BEGIN 1+ dup @
   [ Forth ] ['] unnest = UNTIL
 3+ ip> ! ;






\ *** Block No. 50, Hexblock 32

\ tracer:step tnext           clv04aug87

| Code step
 $ff # lda trap? sta trap? 1+ sta
           RP X) lda  IP sta
 RP )Y lda  IP 1+ sta  RP 2inc
 (W lda  W sta   (W 1+ lda   W 1+ sta
Label W1-  W 1- jmp  end-code

| Create: nextstep step ;

Label  tnext IP 2inc
 trap? lda  W1- beq
 nest? lda 0=  \ low(!)Byte test
 ?[ IP <ip wcmp W1- bcc
    IP ip> wcmp W1- bcs
 ][ nest? stx  \ low(!)Byte clear
 ]?
  trap? dup stx 1+ stx \ disable tracer
  W lda  (W sta    W 1+ lda   (W 1+ sta






\ *** Block No. 51, Hexblock 33

\ tracer:..tnext              clv12oct87

 ;c: nest? @
 IF nest? off r> ip> push <ip push
    dup 2- range
    #spaces push 1 #spaces +! >r THEN
 r@  nextstep >r
 input push    output push
 2- dup last' !
 cr #spaces @ spaces
 dup 4 u.r @ dup 5 u.r space
 >name .name  $10 col - 0 max spaces .s
 state push  blk push  >in push
 [ ' 'quit      >body ] Literal  push
 [ ' >interpret >body ] Literal  push
 #tib push  tib #tib @ cpush  r0 push
 rp@ r0 !
 ['] oneline Is 'quit  quit ;








\ *** Block No. 52, Hexblock 34

\ tracer:do-trace traceable   cas16aug06

| Code do-trace \ installs TNEXT
 tnext 0 $100 m/mod
     # lda  Next $c + sta
     # lda  Next $b + sta
 $4C # lda  Next $a + sta  Next jmp
end-code

| : traceable ( cfa--<IP ) recursive
 dup @
 ['] :    @ case? IF >body     exit THEN
 ['] key  @ case? IF >body c@ Input  @ +
                   @ traceable exit THEN
 ['] type @ case? IF >body c@ Output @ +
                   @ traceable exit THEN
 ['] r/w  @ case? IF >body
                   @ traceable exit THEN
 @  [ ' Forth @ @ ] Literal =
                  IF @ 3 + exit THEN
 \ for defining words with DOES>
 >name .name ." can't be DEBUGged"
 quit ;



\ *** Block No. 53, Hexblock 35

\ tracer:User-Words           cas16aug06

: nest   \ trace into current word
 last' @ @ traceable drop nest? on ;

: unnest \ proceeds at calling word
 <ip on ip> off ; \ clears trap range

: endloop last' @ 4 + <ip ! ;
\ no trace of next word to skip LOOP..

' end-trace Alias unbug \ cont. execut.

: (debug  ( cfa-- )
 traceable range
 nest? off trap? on #spaces off
 Tools do-trace ;

Forth definitions

: debug  ' (debug ; \ word follows

: trace'            \ word follows
 ' dup (debug execute end-trace ;


\ *** Block No. 54, Hexblock 36

\ tools for decompiling,      clv12oct87

( interactive use                      )

Onlyforth Tools also definitions

| : ?:  ?cr dup 4 u.r ." :"  ;
| : @?  dup @ 6 u.r ;
| : c?  dup c@ 3 .r ;
| : bl  $24 col - 0 max spaces ;

: s  ( adr - adr+)
 ( print literal string)
 ?:  space c? 4 spaces dup count type
 dup c@ + 1+ bl  ;  ( count + re)

: n  ( adr - adr+2)
 ( print name of next word by its cfa)
 ?: @? 2 spaces
 dup @ >name .name 2+ bl ;

: k  ( adr - adr+2)
 ( print literal value)
 ?: @? 2+ bl ;


\ *** Block No. 55, Hexblock 37

( tools for decompiling, interactive   )

: d  ( adr n - adr+n) ( dump n bytes)
 2dup swap ?: 3 spaces  swap 0
 DO  c? 1+ LOOP
 4 spaces -rot type bl ;

: c  ( adr - adr+1)
 ( print byte as unsigned value)
 1 d ;

: b  ( adr - adr+2)
 ( print branch target location )
 ?: @? dup @  over + 6 u.r 2+ bl  ;

( used for : )
( Name String Literal Dump Clit Branch )
( -    -      -       -    -    -      )








\ *** Block No. 56, Hexblock 38

( debugging utilities      bp 19 02 85 )


: unravel   \  unravel perform (abort"
 rdrop rdrop rdrop
 cr ." trace dump is "  cr
 BEGIN  rp@   r0 @ -
 WHILE   r>  dup  8 u.r  space
         2- @  >name .name  cr
 REPEAT (error ;

' unravel errorhandler !














\ *** Block No. 57, Hexblock 39

\ Multitasker               BP 13.9.84 )

Onlyforth

\needs multitask  1 +load  save

  2  4 +thru        \ Tasker
\    5 +load        \ Demotask


















\ *** Block No. 58, Hexblock 3a

\ Multitasker               BP 13.9.84 )

\needs Code -$36 +load  \ transient Ass

Code stop
 SP 2dec  IP    lda  SP X) sta
          IP 1+ lda  SP )Y sta
 SP 2dec  RP    lda  SP X) sta
          RP 1+ lda  SP )Y sta
 6 # ldy  SP    lda  UP )Y sta
     iny  SP 1+ lda  UP )Y sta
 1 # ldy  tya  clc  UP adc  W sta
 txa  UP 1+ adc  W 1+ sta
 W 1- jmp   end-code

| Create taskpause   Assembler
 $2C # lda  UP X) sta  ' stop @ jmp
end-code

: singletask
 [ ' pause @ ] Literal  ['] pause ! ;

: multitask   taskpause ['] pause ! ;



\ *** Block No. 59, Hexblock 3b

\ pass  activate           ks 8 may 84 )

: pass  ( n0 .. nr-1 Tadr r -- )
 BEGIN  [ rot ( Trick ! ) ]
  swap  $2C over c! \ awake Task
  r> -rot           \ IP r addr
  8 + >r            \ s0 of Task
  r@ 2+ @  swap     \ IP r0 r
  2+ 2*             \ bytes on Taskstack
                    \ incl. r0 & IP
  r@ @ over -       \ new SP
  dup r> 2- !       \ into ssave
  swap bounds  ?DO  I !  2 +LOOP  ;
restrict

: activate ( Tadr --)
 0 [ -rot ( Trick ! ) ]  REPEAT ;
-2 allot  restrict

: sleep  ( Tadr --)
 $4C swap c! ;       \ JMP-Opcode

: wake  ( Tadr --)
 $2C swap c! ;       \ BIT-Opcode


\ *** Block No. 60, Hexblock 3c

\ building a Task           BP 13.9.84 )

| : taskerror  ( string -)
 standardi/o  singletask
 ." Task error : " count type
 multitask stop ;

: Task ( rlen  slen -- )
 allot              \ Stack
 here $FF and $FE =
 IF 1 allot THEN     \ 6502-align
 up@ here $100 cmove \ init user area
 here  $4C c,       \ JMP opcode
                    \     to sleep Task
 up@ 1+ @ ,
 dup  up@ 1+ !      \ link Task
 3 allot            \ allot JSR wake
 dup  6 -  dup , ,  \ ssave and s0
 2dup +  ,          \ here + rlen = r0
 under  + here - 2+ allot
 ['] taskerror  over
 [ ' errorhandler >body c@ ] Literal + !
 Constant ;



\ *** Block No. 61, Hexblock 3d

\ more Tasks           ks/bp  26apr85re)

: rendezvous  ( semaphoradr -)
 dup unlock pause lock ;

| : statesmart
 state @ IF [compile] Literal THEN ;

: 's  ( Tadr - adr.of.taskuservar)
 ' >body c@ + statesmart ; immediate

\ Syntax:   2  Demotask 's base  !
\ makes Demotask working binary

: tasks  ( -)
 ." MAIN " cr up@ dup 1+ @
 BEGIN  2dup - WHILE
  dup [ ' r0 >body c@ ] Literal + @
  6 + name> >name .name
  dup c@ $4C = IF ." sleeping" THEN cr
 1+ @ REPEAT  2drop ;





\ *** Block No. 62, Hexblock 3e

\ Taskdemo                    clv12aug87

: taskmark ; \needs cbm>scr : cbm>scr ;

: scrstart  ( -- adr)
  (64 $288 C) (16 $53e C) c@ $100 * ;

Variable counter  counter off

$100 $100 Task Background

: >count  ( n -)
 Background 1 pass
 counter !
 BEGIN  counter @  -1 counter +! ?dup
 WHILE  pause 0 <# #s #>
  0 DO  pause  dup I + c@  cbm>scr
        scrstart I +  c!  LOOP  drop
 REPEAT
 BEGIN stop REPEAT ; \ stop's forever
: wait  Background sleep ;
: go    Background wake ;

multitask       $100 >count  page


\ *** Block No. 63, Hexblock 3f

\ printer loadscreen          27jul85re)

Onlyforth hex

Vocabulary Print
Print definitions also

Create Prter 2 allot  ( Semaphor)
Prter off

  : ) ; immediate
  : (u ; immediate  \ for user-port
  : (s  [compile] ( ; immediate
\ : (s ; immediate  \ for serial bus
\ : (u  [compile] ( ; immediate

(s  1 +load )

 2 $A +thru

Onlyforth

clear



\ *** Block No. 64, Hexblock 40

\ Buffer for the ugly SerBus  28jul85re)

$100 | Constant buflen

| Variable Prbuf  buflen allot Prbuf off

| : >buf  ( char --)
 Prbuf count + c!  1 Prbuf +! ;

| : full?  ( -- f)   Prbuf c@ buflen = ;

| : .buf  ( --)
 Prbuf count -trailing
 4 0 busout bustype busoff Prbuf off ;

: p!  ( char --)
 pause  >r
 r@ $C ( Formfeed  ) =
 IF  r> >buf .buf exit  THEN
 r@ $A ( Linefeed  ) =
 r@ $D ( CarReturn ) = or  full? or
 IF  .buf  THEN  r> >buf ;




\ *** Block No. 65, Hexblock 41

\ p! ctrl: ESC esc:           28jul85re)

(u
: p!  \ char --
 $DD01 c!  $DD00 dup c@ 2dup
 4 or swap c!  $FB and swap c!
  BEGIN  pause  $DD0D c@ $10 and
  UNTIL ;  )

| : ctrl:  ( 8b --)   Create c,
  does>  ( --)   c@ p! ;

   7 ctrl: BEL    | $7F ctrl: DEL
| $d ctrl: CRET   | $1B ctrl: ESC
  $a ctrl: LF       $0C ctrl: FF

| : esc:   ( 8b --)   Create c,
  does>  ( --)   ESC c@ p! ;

 $30 esc: 1/8"       $31 esc: 1/10"
 $32 esc: 1/6"
 $54 esc: suoff
 $4E esc: +jump      $4F esc: -jump



\ *** Block No. 66, Hexblock 42

\ printer controls            28jul85re)

| : ESC2   ESC  p! p! ;

  : gorlitz  ( 8b --)   BL ESC2 ;

| : ESC"!"  ( 8b --)   $21 ESC2 ;

| Variable Modus  Modus off

| : on:  ( 8b --)  Create c,
  does>  ( --)
  c@ Modus c@ or dup Modus c! ESC"!" ;

| : off:  ( 8b --)   Create $FF xor c,
  does>  ( --)
  c@ Modus c@ and dup Modus c! ESC"!" ;

 $10 on: +dark    $10 off: -dark
 $20 on: +wide    $20 off: -wide
 $40 on: +cursiv  $40 off: -cursiv
 $80 on: +under   $80 off: -under
|  1 on: (12cpi
|  4 on: (17cpi     5 off: 10cpi


\ *** Block No. 67, Hexblock 43

\ printer controls            28jul85re)

: 12cpi   10cpi (12cpi ;
: 17cpi   10cpi (17cpi ;
: super   0 $53 ESC2 ;
: sub     1 $53 ESC2 ;
: lines  ( #lines --)  $43 ESC2 ;
: "long  ( inches --)   0 lines p! ;
: american   0 $52 ESC2 ;
: german     2 $52 ESC2 ;

: prinit
(s  Ascii x gorlitz  Ascii b gorlitz
    Ascii e gorlitz  Ascii t gorlitz
    Ascii z gorlitz  Ascii l gorlitz )
(u  $FF $DD03 c!
    $DD02 dup c@  4 or swap c! ) ;

| Variable >ascii  >ascii on

: normal   >ascii on
  Modus off  10cpi  american  suoff
  1/6"  $c "long  CRET ;



\ *** Block No. 68, Hexblock 44

\ Epson printer interface     08sep85re)

| : c>a  ( 8b0 -- 8b1)
 >ascii @ IF
dup $41 $5B uwithin IF $20 or  exit THEN
dup $C1 $DB uwithin IF $7F and exit THEN
dup $DC $E0 uwithin IF $A0 xor THEN
 THEN ;

| Variable pcol  pcol off
| Variable prow  prow off

| : pemit  c>a p!  1 pcol +! ;
| : pcr   CRET LF  1 prow +!  0 pcol ! ;
| : pdel   DEL  -1 pcol +! ;
| : ppage  FF  0 prow !  0 pcol ! ;
| : pat    ( zeile spalte -- )
  over   prow @ < IF  ppage  THEN
  swap prow @ - 0 ?DO pcr LOOP
  dup  pcol < IF  CRET  pcol off  THEN
  pcol @ - spaces ;
| : pat?   prow @  pcol @ ;
| : ptype  ( adr count --)  dup pcol +!
 bounds ?DO  I c@ c>a p!  LOOP ;


\ *** Block No. 69, Hexblock 45

\ print  pl                    02oct87re

| Output: >printer
 pemit pcr ptype pdel ppage pat pat? ;


: bemit   dup  c64emit  pemit ;
: bcr          c64cr    pcr   ;
: btype   2dup c64type  ptype ;
: bdel         c64del   pdel  ;
: bpage        c64page  ppage ;
: bat     2dup c64at    pat   ;

| Output: >both
 bemit bcr btype bdel bpage bat pat? ;

Forth definitions

: Printer
  normal  (u prinit )  >printer ;
: Both
  normal  >both ;




\ *** Block No. 70, Hexblock 46

\ 2scr's nscr's thru      ks  28jul85re)

Forth definitions

| : 2scr's  ( blk1 blk2 --)
 cr LF  17cpi  +wide +dark $15 spaces
 over 3 .r $13 spaces dup 3 .r
 -dark -wide cr  b/blk 0 DO
  cr I c/l / $15 .r  4 spaces
  over block I +  C/L 1- type  5 spaces
  dup  block I +  C/L 1- -trailing type
 C/L +LOOP  2drop  cr ;

| : nscr's  ( blk1 n -- blk2)   2dup
 bounds DO I  over I + 2scr's LOOP + ;

: pthru  ( from to --)
 Prter lock  Output push Printer  1/8"
 1+ over - 1+ -2 and 6 /mod
 ?dup IF swap >r
 0 DO 3 nscr's 2+ 1+ page LOOP  r> THEN
 ?dup IF 1+ 2/ nscr's page THEN drop
 Prter unlock ;



\ *** Block No. 71, Hexblock 47

\ Printing with shadows       28jul85re)

Forth definitions

| : 2scr's  ( blk1 blk2 --)
 cr LF  17cpi  +wide +dark $15 spaces
 dup  3 .r
 -dark -wide cr  b/blk 0 DO
  cr I c/l / $15 .r  4 spaces
  dup  block I +  C/L 1- type  5 spaces
  over block I +  C/L 1- -trailing type
 C/L +LOOP  2drop  cr ;

| : nscr's  ( blk1 n -- blk2)
 0 DO dup [ Editor ]  shadow @   2dup
 u> IF negate THEN
 + over 2scr's 1+ LOOP ;

: dokument  ( from to --)
 Prter lock  Output push  Printer
 1/8"  1+ over - 3 /mod
 ?dup IF swap >r
 0 DO 3 nscr's page LOOP  r> THEN
 ?dup IF nscr's page THEN drop
 Prter unlock ;

\ *** Block No. 72, Hexblock 48

\ 2scr's nscr's thru      ks  28jul85re)

Forth definitions  $40 | Constant C/L

| : 2scr's  ( blk1 blk2 --)
 pcr LF LF 10cpi +dark  $12 spaces
 over 3 .r  $20 spaces dup 3 .r
 cr 17cpi -dark
 $10 C/L * 0 DO cr over block I + C/L
 6 spaces type 2 spaces
 dup block I + C/L -trailing type
 C/L  +LOOP  2drop cr ;

| : nscr's ( blk1 n -- blk2)   under 0
 DO 2dup dup rot + 2scr's 1+ LOOP nip ;

: 64pthru  ( from to --)
 Prter lock  >ascii push  >ascii off
 Output push  Printer
 1/6" 1+ over - 1+ -2  and 6 /mod
 ?dup IF swap >r
 0 DO 3 nscr's 2+ 1+ page LOOP  r> THEN
 ?dup IF 1+ 2/ nscr's page THEN drop
 Prter unlock  ;


\ *** Block No. 73, Hexblock 49

\ pfindex                      02oct87re

Onlyforth Print also

: pfindex  ( from to --)
 Prter lock  Printer  &12 "long
 +jump  findex  cr page  -jump
 Prter unlock  display  ;


















\ *** Block No. 74, Hexblock 4a

\ Printspool                   02oct87re

\needs tasks  .( Tasker?!) \\

$100 $100 Task Printspool

: spool  ( from to --)
 Printspool 2 pass

 pthru
 stop ;

: endspool  ( --)
 Printspool activate
 stop ;











\ *** Block No. 75, Hexblock 4b

\ Printer Routine C1526       cas16aug06

( not useable for Printspool!!   re)

Onlyforth  Vocabulary Print

Print also Definitions

: prinit   4 7 busout ;
\needs FF  : FF noop ;
: CRET     $d bus! ;

: pspaces  ( n -)
  0 ?DO  BL bus! LOOP ;

1 2 +thru

Only Forth also Definitions

( save )






\ *** Block No. 76, Hexblock 4c

\ Printer interface 1526       02oct87re

Variable Pcol   Variable Prow

| : pemit  bus!    1 Pcol +! ;
| : pcr    CRET    1 Prow +!  0 Pcol ! ;
| : pdel   ;
| : ppage  FF  0 Prow !  0 Pcol ! ;
| : pat    ( zeile spalte -- )
  over   Prow @ < IF  ppage  THEN
  0 rot  Prow @ - bounds ?DO pcr LOOP
  dup  Pcol @ - pspaces  Pcol ! ;
| : pat?   Prow @  Pcol @ ;
| : ptype  ( adr count -)  dup Pcol +!
 bounds ?DO  I c@ bus! LOOP ;

| Output: >printer
 pemit pcr ptype pdel ppage pat pat? ;

Forth definitions

: printer   prinit >printer ;

: display   cr busoff display ;


\ *** Block No. 77, Hexblock 4d

\ printer routinen             20oct87re

Only Forth also definitions

4 Constant B/scr

: .line  ( line# scr# --)
  block swap c/l * + c/l 1- type ;

: .===
 c/l 1- 0 DO  Ascii = emit  LOOP ;

: prlist ( scr# --)
 dup block drop    printer
 $E emit ." Screen Nr. " dup . $14 emit
 cr .===
 l/s 0 DO I over .line cr LOOP drop
 .=== cr cr cr  display ;








\ *** Block No. 78, Hexblock 4e

\ CP-80 Printer loadscreen    clv14oct87

Onlyforth hex

Vocabulary Print  Print definitions also

Create Prter 2 allot  ( Semaphor)

0 Prter !   \ Prter unlock /clv

1 6 +thru

Only Forth also definitions

(  clear   )











\ *** Block No. 79, Hexblock 4f

\ p! ctrl: ESC esc:         07may85mawe)

Print definitions

: p!  ( 8b -)
 BEGIN  pause  $DD0D c@  $10 and  UNTIL
 $DD01 c! ;

| : ctrl:  ( B -)   Create c,
  does>  ( -)   c@ p! ;

   07 ctrl: BEL    | $7F ctrl: DEL
| $0D ctrl: CRET   | $1B ctrl: ESC
  $0A ctrl: LF       $0C ctrl: FF

| : esc:   ( B -)   Create c,
  does>  ( -)   ESC c@ p! ;

 $30 esc: 1/8"       $31 esc: 1/10"
 $32 esc: 1/6"       $20 esc: gorlitz

| : ESC2   ESC  p! p! ;




\ *** Block No. 80, Hexblock 50

( printer controls          07may85mawe)

 $0e esc: +wide  $14 esc: -wide
 $45 esc: +dark  $46 esc: -dark
 $47 esc: +dub   $48 esc: -dub
 $0f esc: +comp  $12 esc: -comp

: +under 1 $2D esc2 ;
: -under 0 $2D esc2 ;

















\ *** Block No. 81, Hexblock 51

( printer controls          07may85mawe)

  $54 esc: suoff

: super   0 $53 ESC2 ;

: sub     1 $53 ESC2 ;

: lines  ( lines -)   $43 ESC2 ;

: "long  ( inches -)   0 lines p! ;

: american   0 $52 ESC2 ;

: german     2 $52 ESC2 ;

: pspaces  ( n -)
  0 swap bounds ?DO  BL p!  LOOP ;

| : initport  0 $DD01 c! $FF $DD03 c! ;

: prinit   initport
  american  suoff  1/6"
  &12 "long  CRET ;


\ *** Block No. 82, Hexblock 52

( CP80  printer interface     26mar85re)

| Variable unchanged?  unchanged? off

| : c>a  ( 8b0 - 8b1)
 unchanged? @ ?exit
 dup $41 $5B uwithin
                IF  $20 or  exit THEN
 dup $C1 $DB uwithin
                IF  $7F and exit THEN
 dup $DC $E0 uwithin
                IF  $A0 xor      THEN ;














\ *** Block No. 83, Hexblock 53

( print  pl                   06may85we)

Variable Pcol   Variable Prow

| : pemit  c>a p!  1 Pcol +! ;
| : pcr    CRET    1 Prow +!  0 Pcol ! ;
| : pdel   DEL  -1 Pcol +! ;
| : ppage  FF  0 Prow !  0 Pcol ! ;
| : pat    ( zeile spalte -- )
  over   Prow @ < IF  ppage  THEN
  0 rot  Prow @ - bounds ?DO pcr LOOP
  dup  Pcol @ - pspaces  Pcol ! ;
| : pat?   Prow @  Pcol @ ;
| : ptype  ( adr count -)  dup Pcol +!
 bounds ?DO  I c@ c>a p!  LOOP ;

| Output: >printer
 pemit pcr ptype pdel ppage pat pat? ;

Forth definitions

: Printer   prinit  >printer ;




\ *** Block No. 84, Hexblock 54

( 3scr's nscr's thru      ks07may85mawe)
Forth definitions

| : 3scr's  ( blk  -)
 cr  -comp +dark
  $B spaces dup    3 .r
 $19 spaces dup 1+ 3 .r
 $19 spaces dup 2+ 3 .r
 cr  +comp  -dark  L/S C/L *  0 DO
  cr 5 spaces dup  block I + C/L 1- type
   8 spaces dup 1+ block I + C/L 1- type
   8 spaces dup 2+ block I + C/L 1- type
 C/L +LOOP  drop  cr LF ;

| : nscr's ( blk1 n - blk2)  under 0
 DO dup 3scr's over + LOOP nip ;

: pthru  ( from to -)
 Output @ -rot  Printer Prter lock 1/8"
 1+ over - 1+ 9 /mod
 ?dup IF swap >r
 0 DO 3 nscr's  page LOOP  r> THEN
 ?dup IF 1- 3 / 1+ 0
   DO dup 3scr's 3 + LOOP  THEN drop
 Prter unlock  Output ! ;

\ *** Block No. 85, Hexblock 55



























\ *** Block No. 86, Hexblock 56



























\ *** Block No. 87, Hexblock 57

\\ LongJsr for C16            cas16aug06


Memory model

$0000 - $8000 : LowRAM
$8000 - $ffff : HighRAM  & ROM

switch to RAM      Switch to ROM
sys can be used like jsr


ROM-Call like       '0ffd2 sys'

 rom jsr ram  == $ff3e sta jsr $ff3f sta

not possible if HERE > $8000
Guess why?

--- On the C64 BASIC and OS can be
 banked seperatly. This macros are
 only needed for the basic ROM




\ *** Block No. 88, Hexblock 58

\\  LongJsr for  C16          cas16aug06

WARNING! Systemcrash if used incorrect



this makro must be under $8000

a call like ' $ffd2 sysMacro'
will generate
   pha
   $ff # lda  LONG1 2+ sta
   $d2 # lda  LONG1 1+ sta
   pla  LONG jsr
call in ROM will be done with a detour


sys decided if direct or indirect call



WARNING! Zero-Flag will be destroyed!




\ *** Block No. 89, Hexblock 59

( transient Forth-6502 Assemclcas16aug06
( Basis: Forth Dimensions VOL III No. 5)

The Assembler will be loaded completely
into the HEAP and is only usable till
the next 'clear' or 'save', after that
he is complete removed from the memory.
You cannot use it, but it also don't
eats up valuable memory.

















\ *** Block No. 90, Hexblock 5a



























\ *** Block No. 91, Hexblock 5b



























\ *** Block No. 92, Hexblock 5c



























\ *** Block No. 93, Hexblock 5d



























\ *** Block No. 94, Hexblock 5e



























\ *** Block No. 95, Hexblock 5f



























\ *** Block No. 96, Hexblock 60



























\ *** Block No. 97, Hexblock 61



























\ *** Block No. 98, Hexblock 62

\ free                        cas16aug06

























\ *** Block No. 99, Hexblock 63



























\ *** Block No. 100, Hexblock 64



























\ *** Block No. 101, Hexblock 65



























\ *** Block No. 102, Hexblock 66



























\ *** Block No. 103, Hexblock 67



























\ *** Block No. 104, Hexblock 68



























\ *** Block No. 105, Hexblock 69



























\ *** Block No. 106, Hexblock 6a



























\ *** Block No. 107, Hexblock 6b



























\ *** Block No. 108, Hexblock 6c



























\ *** Block No. 109, Hexblock 6d



























\ *** Block No. 110, Hexblock 6e



























\ *** Block No. 111, Hexblock 6f



























\ *** Block No. 112, Hexblock 70



























\ *** Block No. 113, Hexblock 71



























\ *** Block No. 114, Hexblock 72



























\ *** Block No. 115, Hexblock 73



























\ *** Block No. 116, Hexblock 74



























\ *** Block No. 117, Hexblock 75



























\ *** Block No. 118, Hexblock 76



























\ *** Block No. 119, Hexblock 77



























\ *** Block No. 120, Hexblock 78



























\ *** Block No. 121, Hexblock 79



























\ *** Block No. 122, Hexblock 7a



























\ *** Block No. 123, Hexblock 7b



























\ *** Block No. 124, Hexblock 7c



























\ *** Block No. 125, Hexblock 7d



























\ *** Block No. 126, Hexblock 7e



























\ *** Block No. 127, Hexblock 7f



























\ *** Block No. 128, Hexblock 80



























\ *** Block No. 129, Hexblock 81



























\ *** Block No. 130, Hexblock 82



























\ *** Block No. 131, Hexblock 83



























\ *** Block No. 132, Hexblock 84

\\ for tracer:loadscreen      cas16aug06


ToDo
***For the next volks4th version ****

Sync <IP IP>-handling with Atari and
CPM
here some examples to test


| : aa dup drop ;
| : bb aa ;
\\
debug bb
trace' aa

trace' Forth



IP 2inc is done on CBM-Atari before or
after



\ *** Block No. 133, Hexblock 85

\\ for tracer:wcmp variables  cas16aug06



used like this       adr1 adr2 wcmp
compares whole word, result is
     Carry=1  : (adr1) >= (adr2)
     Carry=0  : (adr1) <  (adr2)
all other flags are not defined


Temporary storage for W
area to be traced
Flag: trace word     Flag: trace yes?no
unknown              level of nesting











\ *** Block No. 134, Hexblock 86

\ for tracer:cpush oneline    cas16aug06




saves LEN bytes from ADDR on the return
stack. the next UNNEST or EXIT will
place them back


Main loop
command can be entered



gets area to trace










\ *** Block No. 135, Hexblock 87

\ for tracer:step tnext       cas16aug06

will be used at the end of TNEXT,
 to enable TRAP? again and to fix the
 broken NEXT-Routine





This Routine will be patched on NEXT
and is the key part of the tracer
 if no traced:
 trace current WORD?
    no:   is IP inside the debug area?
          no: then go
    yes:  delete half! part

 disable trap? ( the tracer shouldn't
 trace itself )






\ *** Block No. 136, Hexblock 88

\ tracer:..tnext              cas16aug06

Forth-Part of TNEXT
 trace into current WORD?
   yes: push DEBUG area, increment new
        nestinglevel
 STEP should be executed later
 PUSHed all important data

 print information line



 PUSHed more data

 PUSHed the Return-Stack-Pointer !!
 and pretends an empty Return-Stack
 connects ONELINE into the
 MAIN-COMMAND-LOOP and calls it







\ *** Block No. 137, Hexblock 89

\ tracer:do-trace traceable   cas16aug06

installs (patched) TNEXT into NEXT
 (NEXT is the innerst Routine,
  that ends every word definition)




checks, wethr a word can be traced
  and looks up its address
 :      -def.  <IP=cfa+2
 INPUT: -def.  <IP from input-Vektor

 OUTPUT:-def.  <IP from output-Vektor

 DEFER  -def.  <IP from  [cfa+2]

 DOES>  -def.  <IP=[cfa]+3

 all other definitions won't work





\ *** Block No. 138, Hexblock 8a

\ tracer:user words           cas16aug06

NEST enters a word for tracing


UNNEST continues program execution to
     the end of traced word

ENDLOOP start tracing after next word
     (usable inside loops)

UNBUG disables tracing






DEBUG <word> marks the word to be
     traced. If <word> is called, the
     tracer kicks in


TRACE' will call <word> and start trace.


\ *** Block No. 139, Hexblock 8b

\\ tools for decompil         cas16aug06

\ if the word


: test 5   0   DO    ." do you like me?"
    key Ascii y =
    IF   ." your fault " leave
    ELSE ." yes sure! " THEN LOOP
  ." !" ;

\\ should be inspected,


  please turn page..>











\ *** Block No. 140, Hexblock 8c

\  tools for decompil         cas16aug06

cr
tools
trace' test





















\ *** Block No. 141, Hexblock 8d



























\ *** Block No. 142, Hexblock 8e



























\ *** Block No. 143, Hexblock 8f



























\ *** Block No. 144, Hexblock 90



























\ *** Block No. 145, Hexblock 91



























\ *** Block No. 146, Hexblock 92



























\ *** Block No. 147, Hexblock 93



























\ *** Block No. 148, Hexblock 94

\                             cas16aug06

set order to FORTH FORTH ONLY   FORTH




for multitasking



Centronics-Interface on User-Port
(s Text till ) will be skipped
serial Interface (commented out)
(u Text till ) will be skipped

load next screen only for serial bus





remove unneded word headers



\ *** Block No. 149, Hexblock 95

\ When using the serial       cas16aug06
bus, sendind chars one by one is too
slow

Buffer for chrs to send to printer

add char to buffer


Buffer full?

print buffer and clean



Mainroutine to send to serial bus
store char
is Formfeed?
  yes, print buffer incl. Formfeed
is Linefeed?
or CR, or is the buffer filled?
  yes, print buffer and CR/LF marked




\ *** Block No. 150, Hexblock 96

\                             cas16aug06


Mainroutine for centronics intrface
send char to port , emit Strobe-Edge

wait for Busy-Signal to disappear


send controlcodes to printr


Controlcodes for Printer in Hex
representation

Adjust if needed!

send ESC-Sequence to printer


Linefeed in Inch

disable Superscript and Subscript
skip perforation on/off


\ *** Block No. 151, Hexblock 97

\                             cas16aug06

Escape + 2 Chars

 only for Goerlitz-Interface

special Epson-Controlmode

  Copy of Printer-Control-Register

switch Bit in control register on



switch Bit in control register off



These Controlcodes need to be adjusted
for other printers with ctrl: ESC2
and prn

Linewidth in characters per inch
replace with Elite, Pica or Compress if
needed

\ *** Block No. 152, Hexblock 98

\                             cas16aug06

adjust these if needed



Call as        66 lines
Call as        11 "long
Fonts, can be extended


Initializing ...
 . for Goerlitz-Interface


 . for Centronics:  Port B on send
            PA2 on send for Strobe

Flag for char-convert

enable printer with standardvalues





\ *** Block No. 153, Hexblock 99

                              cas16aug06

convert Commodore's Special-Ascii in
standard ASCII






Routines for printing            command


send chr to printer              emit
CR and LF to printer             cr
delete char          (?!)        del
emit formfeed                    page
position proterhead on column    at
and row, new page if necessary



get printhead position           at?
emit string                      type


\ *** Block No. 154, Hexblock 9a

                              cas16aug06

create outputtable  >printer

Routines for printer and screen
(both)

Output first on Screen
( Routines from DISPLAY )
and on printer
( Routines from >PRINTER )



create outputtable >both



words are avalable from Forth

switch output to printer

switch output to screen and printer



\ *** Block No. 155, Hexblock 9b

                              cas16aug06



print two screen side by side
screennumber in bold and 17cpi


formatted output of both Screens




will print screen this:    1    3
way                        2    4

prints scrren from to
store Outputdevice and enable printer
calculate printposition for each
Screen and print according to layout






\ *** Block No. 156, Hexblock 9c

                              cas16aug06



like 2scr's (with Shadow)








like nscr's (with Shadow)
                           screen Shadow
                           scr+1  Sh+1


like pthru  (with Shadow)







\ *** Block No. 157, Hexblock 9d

                              cas16aug06



same again for standard forth screens
with 16 lines and 64 chars







see above


like pthru, but for standard screens









\ *** Block No. 158, Hexblock 9e

                              cas16aug06



print fast index on printer
                      12" Papiersize
 skip perforation



















\ *** Block No. 159, Hexblock 9f

Background print              cas16aug06

Multitasker is needed

Create workarea for task

enable backgroud printing
 from to will be passed to task
 on next PAUSE the task will execute
 pthru and will go to sleep


abort background task
 task will be activated to go to sleep
 again immeditaly











\ *** Block No. 160, Hexblock a0

\\    Printer interface 1526  cas16aug06

This driver also works with:

 C16 & CITIZEN-100DM \ see Handbook





FF : Formfeed is missing here















\ *** Block No. 161, Hexblock a1

                              clv14oct87

























\ *** Block No. 162, Hexblock a2



























\ *** Block No. 163, Hexblock a3



























\ *** Block No. 164, Hexblock a4



























\ *** Block No. 165, Hexblock a5



























\ *** Block No. 166, Hexblock a6



























\ *** Block No. 167, Hexblock a7



























\ *** Block No. 168, Hexblock a8



























\ *** Block No. 169, Hexblock a9


























