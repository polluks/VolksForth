
\ *** Block No. 0, Hexblock 0

\\ Directory 1of4 26oct87re   cas17aug06

.                     0
..                    0
Content               1
Editor-Intro          2
First-Indo            3
Load-System           4
Load-Demo             5
loadfrom              6
simple File           8
help                &10
FORTH-Group         &11
Number Game         &12
buffers             &13
dump                &14
Disassembler        &16
TEST.DIR            &23
savesystem          &26
formatdisk          &27
copydisk            &28
copy2disk           &29




\ *** Block No. 1, Hexblock 1

\\ Content volksForth 1of4    cas17aug06

Directory             0
Content               1
Editor Short Info     2
First Info            3
Load System           4
simple File           8
help                &10
Forth Group         &11
Number-Game         &12
relocate the system &13
dump                &14 -  &15
6502-Disassembler   &16 -  &22
 Test-Folder        &23 -  &25
savesystem          &26
bamallot formatdisk &27
copydisk            &28
2disk copy2disk     &29 -  &30
  free              &31 -  &36
  prg-files         &37 -  &84
Shadows             &85 - &121
  prg-files        &122 - &169

FORTH-GESELLSCHAFT(c)

\ *** Block No. 2, Hexblock 2

  *** volksFORTH  EDITOR Commands
 special Functions:
    Ctrl o  Overwrite   Ctrl i  Insmode
    Ctrl $  .stamp      Ctrl #  .scr#
    Ctrl '  search
 Cursor Control:
    normal Functions, other:
    F7      +tab        F8      -tab
    CLR     >text-end   RETURN  CR
 Char-Editing:
    F5      buf>char    F6      char>buf
    DEL     backspace   INST    insert
    Ctrl d  Delete      Ctrl @  copychar
 Line-Editing:
    F1      newline     F2      killine
    F3      buf>line    F4      line>buf
    Ctrl e  Eraseline   Ctrl r  clrRight
    Ctrl ^  copyline
 Pageing:
    Ctrl n  >Next       Ctrl b  >Back
    Ctrl a  >Alternate  Ctrl w  >shadoW
 Leaving the Editor:
    Ctrl c  Canceled    Ctrl x  updated
    Ctrl f  Flushed     Ctrl l  Loading
FORTH-GESELLSCHAFT (c) 1985-2006

\ *** Block No. 3, Hexblock 3

  You are in Editormode  Screen # 3
     Back to FORTH with RUN/STOP


        *** volksFORTH-83 ***

      Call Editor with
   "l ( n -- )" or with "r ( -- )"

    WARNING! Without FORTH Experience
    work with backup copies of the
    Disks or with write protected Disks

   Some FORTH Words to try outside the
               Editor:
            WORDS   ORDER
              VIEW HELP
          and the C= -Key

       Turn Page back with "Ctrl b"




FORTH-GESELLSCHAFT   (c) bp/ks/re/we/clv

\ *** Block No. 4, Hexblock 4

\ Load a work system           05nov87re

Onlyforth

     2 +load       \ loadfrom
&46 c: loadfrom    \ .blk
  4 c: loadfrom    \ Transient Assemb
&19 c: loadfrom    \ Editor
&26 a: loadfrom    \ savesystem
oldsave
     2 +load       \ loadfrom
  5 c: loadfrom    \ Assembler
&47 c: loadfrom    \ Tracer + Tools
&13 a: loadfrom    \ Buffers








oldsave   \\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 5, Hexblock 5

\ Load C64 Demo                21oct87re

(16 .( Nicht fuer C16!) \\ C)

Onlyforth

1 +load   \ loadfrom

limit first @ -   b/buf 8 * -
?\ 8 buffers

\needs demostart : demostart ; 90 allot
\needs tasks        $39 C: loadfrom
\needs help         $A  A: loadfrom
\needs slide        &6  D: loadfrom

1 scr !  0 r# !

Onlyforth

oldsave

\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 6, Hexblock 6

\ getdisk loadfrom             20oct87re

here   $200 hallot  heap dp !

: getdisk  ( drv -- )
 cr  ." Please Insert Disk "
 1+ .
 key drop  .status  cr ;

: loadfrom  ( blk drv -- )
 ?dup 0= IF  load exit  THEN
 flush  getdisk  load
 flush  0 getdisk ;

0 Constant A:       1 Constant B:
2 Constant C:       3 Constant D:

: ?\  ( f -- )   ?exit  [compile] \ ;

                              -->




FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 7, Hexblock 7

\ New save empty clear         20oct87re

' save  Alias oldsave
' clear Alias oldclear
' empty Alias oldempty

: save  state @ IF  compile save  THEN ;
  immediate

: clear state @ IF  compile clear THEN ;
  immediate

: empty state @ IF  compile empty THEN ;
  immediate

dp !






\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 8, Hexblock 8

\ simple filesystem            20oct87re

\needs (search  .( (search missing) \\

' word >body 2+ @ Alias (word

0 Constant folder

' folder >body | Constant >folder

: root   >folder off ; folder

  : directory ( -- addr len )
 folder block  b/blk ;

  : (fsearch ( adr len -- n )
 directory (search
 0= abort" not found"
 folder block -  >in push  >in !
 BEGIN  bl directory (word capitalize
        dup c@ 0= abort" exhausted"
        number? ?dup not
 WHILE  drop  REPEAT  0< ?exit  drop ;

-->

\ *** Block No. 9, Hexblock 9

\ simple Filesystem            20oct87re

: split
 ( adr len char -- adr2 len2 adr1 len1 )
 >r 2dup r@ scan  r>
 over >r  skip  2swap  r> - ;

: read  ( -- n ) \ /path/file
 bl word count dup 0= abort" What?"
 pad place  pad count
 BEGIN  Ascii / split
  dup IF    (fsearch
      ELSE  nip root    THEN  over
 WHILE  >folder +!  REPEAT
 -rot 2drop folder + ;

: ld  read load ;      \ LoaD
: sh  read list ;      \ SHow
: ed  read l ;         \ EDit
: cd  read >folder ! ; \ Change Dir
: ls  folder list ;    \ LiSt Dir



FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 10, Hexblock a

\ help                        14oct85re)

Onlyforth

: help  ( --)
 3 l                \ list Scr # 3

 cr ." Additional Help can be"
 cr ." found on the Net"
 cr ." or in a local FORTH User Group"
 cr ." FORTH-Gesellschaft"
 cr ." www.forth-ev.de" cr ;

       \ print silly text








\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 11, Hexblock b



























\ *** Block No. 12, Hexblock c

\ numbers                     05jul85re)

decimal             \ sorry, but this
                    \ is for YOU !

: alphabetic  ( --)  &36 base ! ;

hex                 \ Ah, much better


\ Look at this:


31067E6.  alphabetic d.       hex
19211D5.  alphabetic d.       hex
   -123.  alphabetic d.       hex


\ Try to explain !



\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 13, Hexblock d

\ relocating the system        20oct87re

| : relocate-tasks  ( newUP -- )
 up@ dup
 BEGIN  1+ under @ 2dup -
 WHILE  rot drop  REPEAT  2drop ! ;

: relocate  ( stacklen rstacklen -- )
 swap  origin +
 2dup + b/buf + 2+  limit u>
  abort" buffers?"
 dup   pad  $100 +  u< abort" stack?"
 over  udp @ $40 +  u< abort" rstack?"
 flush empty
 under  +   origin $A + !        \ r0
 dup relocate-tasks
 up@ 1+ @   origin   1+ !        \ task
       6 -  origin  8 + ! cold ; \ s0

: bytes.more  ( n -- )
 up@ origin -  +  r0 @ up@ - relocate ;

: buffers  ( +n -- )
 b/buf * 2+  limit r0 @ -
 swap - bytes.more ;

\ *** Block No. 14, Hexblock e

\ dump utility                30nov85re
\ adapted from F83 Laxen/Perry

| : .2  ( n --)
 0 <# # # #> type space ;

| : D.2  ( adr len --)
 bounds ?DO  I c@ .2  LOOP ;

: dln  ( adr --)  \ DumpLiNe
 cr  dup 4 u.r  space  dup 8 D.2
 ." z "  8 bounds DO  I c@ emit  LOOP ;

| : ?.n  ( n0 n1 -- n0)
 2dup = IF  rvson  THEN
 2 .r  rvsoff  space ;

| : ?.a  ( n0 n1 -- n0)
 2dup = IF  rvson  THEN  1 .r rvsoff ;

-->



FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 15, Hexblock f

\ dump utility                30nov85re
\ adapted from F83 Laxen/Perry

| : .head  ( adr len -- adr' len')
 swap  dup $FFF0 and  swap $F and
 2 0 DO  cr 5 spaces
  I 8 * 8 bounds DO I ?.n LOOP 2 spaces
  I 8 * 8 bounds DO I ?.a LOOP
 LOOP  rot + ;

: dump  ( adr len --)
 base push  hex  .head
 bounds ?DO  I dln  stop? IF LEAVE THEN
             8 +LOOP cr ;

: z  ( adr n0 ... n7 --)
 row 2- >r  unlink
 8 pick 7 + -7 bounds
 DO  I c!  -1 +LOOP r> 0 at dln  quit ;


clear




\ *** Block No. 16, Hexblock 10

\ disassembler 6502 loadscr    06mar86re

Onlyforth

\needs Tools Vocabulary Tools

Tools also definitions hex

| : table    ( +n -- )
 Create     0 DO
 bl word number drop , LOOP
 Does> ( 8b1 -- 8b2 +n )
 + count swap c@ ;

-->











\ *** Block No. 17, Hexblock 11

\ dis shortcode0               20oct87re

base @  hex

$80 | table shortcode0
0B10 0000 0000 0341 2510 0320 0000 0332
0AC1 0000 0000 03A1 0E10 0000 0000 0362
1D32 0000 0741 2841 2710 2820 0732 2832
08C1 0000 0000 28A1 2D10 0000 0000 2862
2A10 0000 0000 2141 2410 2120 1C32 2132
0CC1 0000 0000 21A1 1010 0000 0000 2162
2B10 0000 0000 2941 2610 2920 1CD2 2932
0DC1 0000 0000 29A1 2F10 0000 0000 2962
0000 0000 3241 3141 1710 3610 3232 3132
04C1 0000 32A1 31B1 3810 3710 0000 0000
2051 1F51 2041 1F41 3410 3310 2032 1F32
05C1 0000 20A1 1FB1 1110 3510 2062 1F72
1451 0000 1441 1541 1B10 1610 1432 1532
09C1 0000 0000 15A1 0F10 0000 0000 1562
1351 0000 1341 1941 1A10 2210 1332 1932
06C1 0000 0000 19A1 2E10 0000 0000 1962

base !

-->

\ *** Block No. 18, Hexblock 12

\ dis scode adrmode            20oct87re

| Create scode
 $23 c, $02 c, $18 c, $01 c,
 $30 c, $1e c, $12 c, $2c c,

| Create adrmode
 $81 c, $41 c, $51 c, $32 c,
 $91 c, $a1 c, $72 c, $62 c,

| : shortcode1 ( 8b1 - 8b2 +n)
 2/ dup 1 and
 IF  0= 0  exit  THEN
 2/ dup $7 and adrmode + c@
 swap 2/ 2/ 2/ $7 and scode + c@ ;

| Variable mode

| Variable length

-->





\ *** Block No. 19, Hexblock 13

\ dis shortcode texttab        06mar86re

| : shortcode ( 8b1 -- +n )
 dup 1 and         ( odd codes)
 IF  dup $89 =
  IF  drop 2  THEN  shortcode1
 ELSE  shortcode0  ( evend codes)
 THEN
 swap dup 3 and length !
 2/ 2/ 2/ 2/ mode ! ;

| : texttab   ( char +n 8b -- )
 Create
 dup c, swap 0 DO >r dup word
 1+ here r@ cmove r@ allot r>
 LOOP 2drop
 Does>  ( +n -- )
 count >r swap r@ * + r> type ;

-->






\ *** Block No. 20, Hexblock 14

\ dis text-table               06mar86re

bl $39 3 | texttab .mnemonic
*by adc and asl bcc bcs beq bit bmi bne
bpl brk bvc bvs clc cld cli clv cmp cpx
cpy dec dex dey eor inc inx iny jmp jsr
lda ldx ldy lsr nop ora pha php pla plp
rol ror rti rts sbc sec sed sei sta stx
sty tax tay tsx txa txs tya
( +n -- )

Ascii / $E 1 | texttab .before
   / /a/ /z/#/ / /(/(/z/z/ /(/


Ascii / $E 3 | texttab .after
     /   /   /   /   /   /,x
 /,y /,x)/),y/,x /,y /   /)  /

-->






\ *** Block No. 21, Hexblock 15

\ dis 2u.r 4u.r                06mar86re

: 4u.r ( u -)
  0 <# # # # # #> type ;

: 2u.r ( u -)
  0 <# # # #> type ;

-->

















\ *** Block No. 22, Hexblock 16

\ dis                          20oct87re

Forth definitions

: dis   ( adr -- ) base push hex
BEGIN
 cr dup 4u.r space dup c@ dup 2u.r space
 shortcode >r length @ dup
 IF over 1+ c@ 2u.r space THEN dup 2 =
 IF over 2+ c@ 2u.r space THEN
 2 swap - 3 * spaces
 r> .mnemonic space 1+
 mode @ dup .before $C =
 IF dup c@ dup $80 and IF $100 - THEN
  over + 1+ 4u.r
 ELSE length @ dup 2 swap - 2* spaces
  ?dup
  IF 2 =
   IF   dup  @ 4u.r
   ELSE dup c@ 2u.r
 THEN THEN THEN mode @ .after length @ +
 stop?  UNTIL drop ;


Onlyforth clear

\ *** Block No. 23, Hexblock 17

\\ Subdirectory test.dir       26oct87re

.                    0
..                -&23
all-words            1
free                 2




















\ *** Block No. 24, Hexblock 18

\ pretty words                 26oct87re

: .type  ( cfa -- )   dup @ swap 2+
             case? IF ." Code" exit THEN
 ['] :     @ case? IF ."    :" exit THEN
 ['] base  @ case? IF ." User" exit THEN
 ['] first @ case? IF ."  Var" exit THEN
 ['] limit @ case? IF ."  Con" exit THEN
 ['] Forth @ case? IF ."  Voc" exit THEN
 ['] r/w   @ case? IF ."  Def" exit THEN
 drop ." ????" ;

: (words  ( link -- )
 BEGIN  stop? abort" stopped"  @ dup
 WHILE  cr dup 2- @ 3 .r space
        dup 2+  dup name> .type space
        .name  REPEAT drop ;

: all-words ( -- )
 voc-link
 BEGIN  @ ?dup
 WHILE  dup 6 - >name
        cr cr .name ."  words:" cr
        ." Blk Type Name "
        dup 4 - (words  REPEAT ;

\ *** Block No. 25, Hexblock 19



























\ *** Block No. 26, Hexblock 1a

\ savesystem                   23oct87re

| : (savsys ( adr len -- )
 [ Assembler ] Next  [ Forth ]
 ['] pause  dup push  !  \ singletask
 i/o push  i/o off  bustype ;

: savesystem   \ name must follow
    \ prepare Forth Kernal
 scr push  1 scr !  r# push  r# off
    \ prepare Editor
 [ Editor ]
 stamp$ dup push off
 (pad   dup push off
    \ now we save the system
 save
 8 2 busopen  0 parse bustype
 " ,p,w" count bustype  busoff
 8 2 busout  origin $17 -
 dup  $100 u/mod  swap bus! bus!
 here over - (savsys  busoff
 8 2 busclose
 0 (drv ! derror? abort" save-error" ;

Onlyforth

\ *** Block No. 27, Hexblock 1b

\ bamallocate, formatdisk      20oct87re

: bamallocate ( --)
 diskopen ?exit
 pad &18 0 readsector 0=
  IF pad 4 + $8C erase
     pad &18 0 writesector drop
  THEN  diskclose
 8 &15 busout " i0" count bustype
 busoff ;

: formatdisk ( --)  \ name must follow
 8 &15 busout " n0:" count bustype
 0 parse bustype busoff
 derror? ?exit
 bamallocate ;

\ example: formatdisk volksFORTH,id






FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 28, Hexblock 1c

\ copydisk                    06jun85we)

| Variable distance

limit first @ - b/buf /  | Constant bufs

| : backupbufs  ( from count --)
 cr ." Insert Source-Disk" key drop cr
 bounds 2dup DO  I block drop  LOOP
 cr ." Insert Destination-Disk"
 key drop cr
 distance @ ?dup
 IF    >r  swap 1- over  r> +  convey
 ELSE  DO  I block drop update  LOOP
       save-buffers THEN ;

: copydisk  ( blk1 blk2] [to.blk --)
 2 pick - distance !  1+ over -
 dup 0> not Abort" RANGE ERROR!"
 bufs /mod ?dup
 IF swap >r 0
    DO dup bufs backupbufs bufs +  LOOP
    r> THEN
 ?dup IF backupbufs ELSE drop THEN ;


\ *** Block No. 29, Hexblock 1d

\ 2disk copy2disk..           clv14jul87


$165 | Constant 1.t
$1EA | Constant 2.t
$256 | Constant 3.t


| : (s#>s+t ( sector# -- sect track)
      dup 1.t u< IF $15 /mod exit THEN
( 3+) dup 2.t u< IF 1.t - $13 /mod $11 +
                            exit THEN
      dup 3.t u< IF 2.t - $12 /mod $18 +
                            exit THEN
                    3.t - $11 /mod $1E +
 ;


| : s#>t+s  ( sector# -- track sect )
 (s#>s+t  1+ swap ;




-->

\ *** Block No. 30, Hexblock 1e

\ ..2disk copy2disk           clv04aug87


| : ?e ( flag--)
  ?dup IF ." Drv " (drv @ . diskclose
          abort" " THEN ;

| : op ( drv#--) (drv ! diskopen ?e ;

: copysector \ adr sec# --
  2dup
  0 op s#>t+s readsector  ?e diskclose
  1 op s#>t+s writesector ?e diskclose ;

: copy2disk \ -- \ for 2 Floppys
 pad dup $110 + sp@ u> abort" no room"
 cr ." Source=0, Dest=1" key drop cr
 base push decimal      0 &682
 DO I . I s#>t+s . . cr $91 con!
    dup I copysector   -1 +LOOP drop ;

: 2disk1551 \ -- switch 1551 to #9
 flush 8 &15 busopen " %9" count bustype
 busoff derror? drop ;


\ *** Block No. 31, Hexblock 1f

\ nothing special here

























\ *** Block No. 32, Hexblock 20



























\ *** Block No. 33, Hexblock 21



























\ *** Block No. 34, Hexblock 22



























\ *** Block No. 35, Hexblock 23



























\ *** Block No. 36, Hexblock 24



























\ *** Block No. 37, Hexblock 25

   F � � � H� � � l  o �# VARIABLER#A!F �
 \ p |# UALLOTR#� 0 " �
  �[ �+
Userarea
full0 " � 0 [ \ p �# USERR#A!F �#  � � 8�
 � � F � �  E � �HE � � l  p )$ ALIASR#A!
~ " � J    1 �   / ��� B      Z S"; \ q ]
$ VP."  |%K%K% FK%    q �$ CURRENT."K%q �
$ CONTEXTR  " �$; \ R#" � �" #\ s �% ORDE
RR#R$I   % K%/ ��� � F _,�$K%\ s Y% WORDS
R#D$" " � �6� 1 �   �6� a  #�,B ��� \ t
& (FIND;&� � �$ � ��&) �(� �$�H�$�%�$ $P
� � l� H�$) E(P� � E$�)� E%�*_(�&Q)PK�P��
 �*� ��)� �� l� �&� �$� �%�$�&) 8E$�$� �%
�&) P �$� �%lB&�$� �
�$" "     J � �
� � �+ invalid nameX ~ ; # � �!^!" �   �
^![ �  !  �    Z  !L ; B   &!� � �   � l
 3"� �(� �)�  I � � � � �&� �' &P l� �&�
�%�&� �$ %P l  �$ I �$� �%�$h8) E$�$� �%H
) � �$h�$�$H�%�$E(P��%E)P�lc n �! >NAMER#
% " � �   �
Z I � 1"} �   z
~
  ' NOTFOUN
DI('x �'
NO.EXTENSIONSR#�+ Haeh?\ x O' I
NTERPRETR#�'\  R#�)  �&} �   � 1 �   � �'
�+ compile only�'S p � �   I'�'\ R#�)  �&
} �   < �   � �'  �'�'S p } �   < �   � ^
 ^ B   I'�'\ y �'a[R#/  (�(�'1 � \ y {( ]
R#/ ;(�(�'1 � \ R#� �+ Crash\ z �( DEFER

\ *** Block No. 38, Hexblock 26

  RSIVER#� \ R#� �   |
J   � � � \ h H  I
MMEDIATER#  @Z \ h �  RESTRICTR#  �Z \ i
   CLEARSTACK. � � � H� � � l  i    HALLO
TR#� " � I � ; a �
I � � ; F �
� I , ,
� ; \ i @  HEAPR#� " z \ i Y  HEAP?R#� }
� \ R#� X � I � i � � D � � I ~ [ � \ � 8
� � � F �    � E H� � � � l   � � �+ stac
k empty\ \ �) .STATUSI(Nb."� � ; \ \ �)�P
USHR#� � � P " P �)P P \ \ �) LOADR#} � S
 D  *D ; �  *� � �)�'\ ]  * +LOADR#D " �

#*\ ] c* THRUR## � I   % #*J � \ ] y* +TH
RUR## � I   % k*J � \ ] V*c-->R#� D [ � �
 �)\ ] �* RDEPTHR#B   VERTR## L J �   � B
 ��G \ R#� " � \ R#L � � [ \ R#G L \ f M
 DPL."��R#�   9 ~
� 9 � \ R#�   9 � � �
 �
�   " # } S � � \ R#  &@ �      � d
  $@ �      � d   H@ �      � d   %@ �
F � d � \ R#  ,� I �   .I   \ R#  " � I S
 �   [ \ ."  g
  NUMBER?R#�    ,�6D " }
�   �+; � " �+; 3+\ _ �+�(ABORT"R#X � �
 P , �   � d � \ R#X � �     � d � \ _ V+
FABORT"R#6 �+\ \ _  ,FERROR"R#6 �+\ \ ` %
, BL�#  ` :, -TRAILINGs,� S � �& � E%�'_$
 � ��&I � HP �%�h�%l  �P�F'F% �l  A e, S
PACER#?,
7\ A �, SPACESR#� |   �,J � \ R

\ *** Block No. 39, Hexblock 27

  C _- .R#  �-\ C �- U.R#� �-\ D C- .SR#;
 � " � I      � |   % " H-F � � \ D R- C/
L�#) D �- L/S�#  D  . LISTR#�+; �  Scr �+
" �  <x H-�  Dr x<�- .� I . �6�   �  7% F
 �-�,�+" �1%  .$ �
 .G q,#7J �  7\ E  . P
AUSE  E Z. LOCKR#� " } I �   � d � " �
�.B ��} �   /�(�(� /�)� /lC/J  / (DISKERR
R#�  error !  r to retry �7�   rI �   RI
  � �+ aborted\ J A/ DISKERRI(L/J  0 R/WI
(�?R#� z " � � j a � " # � 3    *�  *q+�
z � a " F �
" �  0�   �  write  0B {�  ��
 t #   � \ R#a � � t � \ R#� {0   *�  *q+
P � Z " �
�      �
z  #�$� " �
a \ R#�$a
D$\ q �$ ALSOR#�$"    - �+ Vocabulary sta
ck fullD$" F �$[ D$; \ q ~$ TOSSR#/ ���$[
 \ r  % VOCABULARYR#A!�   �   X % "   % ;
 � l@ D$; \ r /% FORTHv%v{v{  r A% ONLY�%
!8!8O%� l@ � �$; D$; �$\ r S% ONLYFORTHR#
Z%I%�$�%\ s �% DEFINITIONSR#D$  $� � 8� �
 � F �&  H 0 �i��H��   ��$�� � l  v 1& FI
NDR#D$� " � � " I �   � |
" 9&�   J
�&d �
 �$a [ �   � � B ~�J
� \ v �& 'R#  �&� �+
 Haeh?\ v 7'I[COMPILE]R#;'  \ v o'C[']R#;
'^ \ v E' NULLSTRING?R#� J � � �   J
\ H
� I � H� I � � l  w U' >INTERPRET�' (x �

\ *** Block No. 40, Hexblock 28

  d B ��J
\ R#L    1 �
\ n �" NAME>R#� S"
� J    1 �   " \ n �" >BODYR#a \ n  # .NA
MER#} �   � � �   �  |L    1 #7B   �  ???
�,\ o  # CREATE:R#A!� �$" D$; �(� \ o h#
:R#r#� � 8� � � F � � � � �  I � �E � l
o H#A;R#� � 6 \ (� \ o �# CONSTANTR#A!
� � 8� � �  R#A!/ �(  � � � hH� � H� � l
 z �( (ISR#� � a P " ; \ R#" / I'" � I �
/ �'" I   � �+ not deferred\ z }(bISR#;'�
 �( #1 " �   6 �(  d ; \ ." R#O*   - �+ t
ight stacke)J � �   � e)� � �+ dictionary
 full�  still full \ [ ") ?STACK�)� 8� �
H� � P �  � h)\ �g)�  � � �  � I � �Q � �
  E h�E l  R#� ~ " �"; \ j � EDOES>R#6 �
  l  6 @ \ R#�   �1   �I I \ R#X   �1   �
I �   � � # X � I # � � ~ [ � � \ k �  ?H
EAD."  k v! |R#^!" S � ^!; \ l D! WARNING
."  R#�!" S ~ " �$" 9&J
�   �,~ "  #�  ex
ists �6\ l Z! CREATER#X D "     " � a I
 \ ] �* DEPTHR#; � " � I   \ R#1 " �   �
  compilingd �   ok\ ^ G* (QUITR#�) 7� �'
*B ��\ ^  + 'QUITI( +^  + QUITR#B " B (
&+\ ^ ,+ STANDARDI/OR#/ * � Z D \ ^ c+ 'A
BORTI(� ^ A+ ABORTR#, C J+q+3+\ _ P+ SCR.
"  _ �+ R#."  _ �+ (ERRORR#q+�,X  #L #7�

\ *** Block No. 41, Hexblock 29

  *� L � ;   � � P � �
�   �   -@ �   9
 � P �   � o �   � ; �   � J �   � � � )
� J � � ��  � �     � � ) � B T�\ g B  'N
UMBER?I(L g e  NUMBERR#p } � �+ ?� �
\ h v  LAST."  R#~ " } \ h W  HIDER#� �
 � " �$" ; \ h �  REVEALR#� �   � �$" ; \
 h � IRECU  #� � \ B �, HOLDR#� �,[ �," �
 \ B �, <#R#�,�,; \ B W, #>R#~
�," �,� I
\ B �, SIGNR#� �     -E,\ B �, #R#� " _

   � U �     ��
  0�
E,\ B  - #SR# -�
Y
� ��\ C @- D.RR#z
|
) |,e-
 -�,
� } � I
 _,#7\ C u- .RR#�
[-\ C - U.RR#� � [
-\ C �- D.R#� [-�,\   ; \ E �. UNLOCKR#�
�.� \ H8� � H� � �l� � � � H� � � � � � �
 �  I � � � � l� F �. FILE<$ F  / PREV."P
�."  F  / B/BUF�#  � �(Y" P H@ P�`:/� � �
$ � ��  � E&�&H� E'�'� /�(� /�) )/P �  I
� � � � �  E(� �)I � lf �(�*�)�+�*�(� �*�
) (P l   )/P�(�*� �(�*� /�(�
�  0�
�  read  0B Y�� \ R# /� " �   " � a " � I
 � �� /�.� !0\ R#a P �
  ; Z " �
  a ; �
t �  /@.\ R# /" � �   � z " � � ��\ R# /"
 � " � � ��z " � \ L  0 CORE?R#8/~
� \ M
f1 (BUFFERR#8/H0�0B ��\ M z1 (BLOCKR#8/H0
�0�0B ��\ �1� � hH� l  M T1 BUFFERR#�1D1

\ *** Block No. 42, Hexblock 2a

   0�� E$� �%l� ' Q  U<  � �$� �%�  I � �
 � � E$� �%� l� l� ( �  >R#� U \ ( )  0>R
#_ � \ ( 7  0<>R#� � \ ( f  U>R#�   \ ( v
  =R#I � \ ( E  D0=R#  � \ ( S  D=R#� � Y
 \ ( �  D<R#
�
I �   - J
J
B   ~
  \ R#9
 �   � � \ ) �  MINR#�
- � \ ) E  MAXR#�

U � \ ) W     D+� �  S H�  E&� H� E'� � E
$� � � E%� l  # �  1+% �  A � l  � � I �
l  #    2+c � P�# <  3+p � PSv � PM\ � PG
# i  1-I 8� � � l  � � � � l  # B  2-�  �
�$ �  TRUE�#��$ �  FALSE�#  $ � "-1� $ �
!0� $ �  1�#  $ �  2�#  $ B  3�#  $ L  4�
#  $ V  ONR#� � ; \   IBR#\ " \ ; W  QUER
YR#}   pW7Q " o ; � � D � \ < �  SCANR#P
� �   � J   I �   G � # � B ��9 \ <    SK
IPR#P � �   � J   I �   G � # � B ��9 \ <
 ;  /STRINGR#�
� �
z
I \ Ia� I{� IB�
)I[�  �`= J  CAPITAL� �  � � l  > �  CAP
ITALIZED � �$� �%�$�&�D&P � l
 � 8� � �
 F � � � H� � � l    �  ROT
� � �%� � �
� � � �$�%� � �$� H� �%� � � � � �%� � l

 -ROTR#

\   s
 NIPR#� � \   D
 UN
DERR#� � \   T
 PICKR## 3 ; �
" \   �
 RO
LLR#� P �
; � a � # 3 � � \   �
 2SWAPR#

P
� \   @
 2DROP�   V
 2DUPR#� � \

\ *** Block No. 43, Hexblock 2b

  ��)�'lL 7 �  CMOVE>� �  S  �%E'�' �%E)�
)�%_$ � ��(�&�P�F'F)F%P� l  7 �  MOVER#P
 �
  �   � � d � D \ 8 %  PLACER#� P
�
# � , � \ 8 f  COUNTN � �$ I � � �%I � �
8� � � F lT 8 D  ERASER#� � \ 9 �  FILL�
�  S ��$�'� �(HP��)JP��&� �(HJP�� l  : �
 HERER#L "   F � � � � �  E � � � l    �
 R@  � 8� � � F � � � l      �RDROP    1
 EXITf � � � � l    =  UNNEST^ � � � � l
   s  ?EXITU �    �  I � � � (P�l    K  E
XECUTE� � � � � �  I � � � l    �  PERFOR
MR#" � \   �  C@L � �$� �%� � �$l    E  C
!� � �$� �%H� �$��    %� l  3 �  M*R#� �
� P �   _ � � � �   _ � � P � � �   � \ 3
 �  *R#� � \ 3    2*5 �  � � *� l  R#� �+
 division overflow\ 4 .  UM/MODI � �)� �(
�  I � � � � �%� �$H� �'H� �&�  F*8�%�)��
$�(� &*� �$�%&'&&&%&$JP� F$F%�  � b \ �&
� H�%� H�$� � �'l  5 ^  M/MODR
                        ." ultraFORTH-83
3.80-C64  ���� � ����  � I � � L��� ��
  END-TRACEE ��� � � �I� � � l    w  RECO
VER."H� H� � P F F lR#  Z  NOOP    �  ORI
GIN�#    _  S0<$   �  R0<$   �  DP<$   G
 OFFSET<$   Q  BASE<$     OUTPUT<$   �

\ *** Block No. 44, Hexblock 2c

  ER#X I   \ . }  ?PAIRSR#I �+ unstructur
ed\ I   h��l  h� �� 8� � � F �� � H� l  /
 �  CASE?b �  S �$A P �%Q P l� �l  0 8 BI
FR#6 � � � \ 0 \ DTHENR#= � � � \ 0 O DEL
SER#� � 6 B � � � � \ 0 � EBEGINR#U F \ 0
 � EWHILER#F � F 6 � � / ��H
\ R#� � / ��
I �   � �   DR#� � \ b Q  PARSER#P � � "
T � � �   P � I � � l I � [ \ b �  NAMER#
?,X B d \ c    STATE."  c ) eASCIIR#?,X #
 J 1 " �   ^ \ c 7  ,"R#  "� X � # � n \
c w �"LITR#� � |
L �
P P \ c Q �("R#X \ c
 � A"R#6 � \ \ d � �(."R#X L #7\ d � B."R
#6 � \ \ d � a(R#  )   UMAXR#�
  � \ ) �
 UMINR#�
[ � \ ) �  EXTENDR#� � \ )    DA
BSR#  �   � \ ) "  ABSR#  �   _ \ R#9 � a
 � P
P � P P \ * 7 �(DOR#� I i \ * C �(
?DOR#� I } �   i � � " �
P � \ * U  BOUND
SR#� �
� \ * � �ENDLOOP� � l  + � �(LOOPL
  � A � � � I � � l  � � � ��   $ �  OFFR
#� � ; \ % � �CLIT  � 8� � � F � � �� � P
 � l  %   �LIT1 � 8� � � F � � � � �  I �
 � � l  % ) GLITERALR#� /  �1 �   6 /   d
 6     \ & t  0<� �   ��$�� l  & ~  0=� �
   ��P�& �  UWITHIN� �  S � � E$� �%� � E
&� �'��l� ' �  <W � �$� �%�  I � � � �%q

\ *** Block No. 45, Hexblock 2d

   H�$ � �$lQ � �*� � �$ � ��  �� E&�&��
E'�'8�$� �$�%� �%�
� �� � �� lY � �$ %�
=�&Q P �&P �'�$P F%F$l$ �&�(�'�)�&Q  �&P
�'�$P F%F$(� �*�$ %P�8� �&� �� H�'� ��  �
 E � � � � � � �$H� � � �%��*�$�(HF* �� �
$� l  b �  SOURCER#D " } �   �1�;d } o "
\ b �  WOR  �
 +�
 H� Q � �� � Q � l�   �

 OR  H�   � �� �   � l�      AND3 H� 1 �
 �� � 1 � l�   +  XORp H� q � �� � q � l�
 ! h  -K H� 8� � H� � � � � l� ! E  NOT�
 �� � �� � l  ! �  NEGATE� 8��" �  DNEGAT
E� H8�� � H�� � �� � � �� � l   ���� �$ �
 �� E � � � � � `" �   \ : Q  PADR#X   b�

\ : �  ALLOTR#L [ \ : �  ,R#X ; F � \ :
   C,R#X � � � \ :   �COMPILER#� � a P "
  \ ; ,  #TIB."  ; h  >TIB."` savesystem
@:c64demo
                            ; u  >IN."  ;
 �  BLK."  ; �  SPAN."  ; J  T  I � � � l
      CTOGGLER#|
J n � � \      @$ � �$�
 �%�$� �$l       != � �$� �%H� �$H� � �$l
�   7  +!] � �$� �%H�  A$�$H� � Q$lo   v
 DROP�   Y  SWAP� � �� � �$�� �$� � H� �
�$� � ��$l    �  DUP� � 8� � � F � � � �
H� �l    �  ?DUP �   P l  l�   V  OVER�

\ *** Block No. 46, Hexblock 2e

  #� P = � � �   |
�
� G   � �   _ � �
�   �
� G 9 \ 5 X  2/  �  � J� � Jl  6
 /MODR#P   � � \ 6 /  /R#6 J
\ 6 d  MODR#
6 � \ 6 r  */MODR#P � � � \ 6 B  */R#J J

\ 6 X  U/MODR#� � G \ 6 �  UD/MODR#P �
G � � P G � \ 7 �  CMOVEF �  S �D$P F%  �
 l  �(�&HP   INPUT<$   �  ERRORHANDLER<$
     VOC-LINK<$      UDP<$   *  SP@= � �$
� �%�$� 8� � � F � � � � l    5  SP!G � �
� � � � l    _  UP@ � lg   W �UP!� � � �
 �� � � � �  I � � � l    �  RP@� � lg
� �RP!D � l�   � �>RR � 8� � � F � � � �
l�   K �R>� � 8� � �  B ��\ 0 � FREPEATR#
F � 6 B Q \ 0 � EUNTILR#F � 6 � Q \ 1   B
DOR#6 I � P \ 1   C?DOR#6 | � P \ 1 1 DLO
OPR#P � 6 J 6 � � \ 1 e E+LOOPR#P � 6 � 6
 � � \ 1 ` �LEAVER#� � � � " �
P \ 2 |  U
M*� � �$� �%H�&�'�  '&&&%&$�  � E'�'H� �E
&�&� �%P �$JP|�'� H�&� � �$� �  � ~
\ d L
 b.(R#  )� #7\ d } a\R#� "  .h #  .$ � ;
\ d � b\\R#�;� ; \ d    \NEEDSR#  �&J
�
 � \ d    HEXR#   � ; \ d 7  DECIMALR#
� ; \ e j  DIGIT?R#  0I �    [ �     �I �
    [ �   � " � [ } S � � \ e A  ACCUMULA
TER#� P � � " � �
� " � � � \ e �  CON

\ *** Block No. 47, Hexblock 2f

  � � l  + B �(+LOOP�  � A � � Q � Jq  �
 I � � � ( Dl  , � �I' � � 8� � � F  � HH
Q � �� HHQ � � l  , ! �Js � PR- m �BRANCH
D  � A �$� Q � �$� l  - y �?BRANCH� �
�  I � � � (�Kld . Z  >MARKR#X �   \ . �
 >RESOLVER#X � I � ; \ . �  <MARKR#X \ .
M  <RESOLV



















\ *** Block No. 48, Hexblock 30



























\ *** Block No. 49, Hexblock 31



























\ *** Block No. 50, Hexblock 32



























\ *** Block No. 51, Hexblock 33



























\ *** Block No. 52, Hexblock 34













                       �  E(� �)I � lr �(
�*�)�+�*�(� �*�) (P l   I/P�(�*� �(�*�i/
�(�j/�(�(�i/�)�j/l�/J ]/ (DISKERR�#�  err
or !  r to retry  8D   rU �   RU   �  , a
bortedH J  0 DISKERR�( 0J g0 R/W�(0@�#D F
 . � � j m D . / � 3
 8*  8*�+D F
m .
R �
. � ]0�   �  write q0N {�    �
` /
 � H �#m D � `   H �#D �0
 8*  8*�+|
�
.
%      F
H ]0�   �  read q0N Y�� H
�#g/D . �   . D m . � U � ��w/A.D A0H �#m
 | �
% g � .   % m g � `   w/�.H �#g/. D
�   D F . � � ��H �#g/. D . � � ��F . � H
 L w0 CORE?�#X/�
� H M �1 (BUFFER�#X/ 1.

\ *** Block No. 53, Hexblock 35

  1N ��H M �1 (BLOCK�#X/ 1I0.1N ��H O1� �
 hH� l+ M �1 BUFFER�#M1_1H M |1 BLOCK�#M1
�1H N �1 UPDATE�#  �g/. F / � H N  2 SAVE
-BUFFERS�#w/A.r1� �   A0N ��w/�.H N  2
EM
PTY-BUFFERS�#w/A.g/. � �   D �0N ��w/�.H
N h2 FLUSH�#,2x2H O X2 (COPY�#D M1�1�   g
/. �0L1�     ,2� .   � �1� � g  2H O �2 B
LKMOVE�#,2|
%
G | �
  � = � $ % %
 � � �   � ; ��  �
�2V E N   � � �   �
�2
H H   V E ,2�
H O B2 COPY�#H L2H O *3 CON
VEY�#� / R �
U D h �  , no!!L2H P ;3 LIMI
T�# @P C3 FIRSTz"  P Q3 ALLOTBUFFER�#Y3.
M . U E/m    E/� Y3  G Y3. D �0g/.
g g
/g H P 3 FREEBUFFER�#Y3. K3E/U   � . Y3.
 A0g/D . Y3. U �   . N ��Y3. . � g E/Y3G
H P A3 ALL-BUFFERS�#Y3. �3Y3. U � ��H �#V
    = H �# #�
/   � @   H �#� 1 . | � . �
 � ^ D | � U | � . |
S D %   � % m  #
= � . % @ � Z�% m 24�
% m   =4�   % m
  #m � N ��e N ��H C4� � �$ � ��  � I �*H
� I �+� �$�,�$�- ,�5�,E*�-�+� �,E&�-�'l 5
�(E,�)�-� �,�$�,�$l 5�,�$�-�%l4l� �#1 .
� �   D | � U A4� N ��H �#� / D . � U � (
 �
. � � � �   D . / .
g S N   . N N��

H �#1 A4 %U   �
1 . F
� �   ; �%1 g ; ��

\ *** Block No. 54, Hexblock 36

    E �
�$. F
� �   ; �%�$g H S  4
CUSTOM
-REMOVE�(� �#
a5}5#5Q5� � U U W g � � g
H  T A5 CLEAR�#� D � U5W g H T �5 (FORGET
�#D @  , is symbolo4U5H T  6 FORGET�#P'D
; $ .    , protected~"D @ �    #N   � �
6H T 66 EMPTY�#; $ . � U5; 2 . < g H U S6
 SAVE�#� �   U51 . D � � .
� g . � � �
��� � ;   P H U �6 BYE�#,2:<H �# 8| U �
 � e H U N6 STOP?�# 8�   |6|6� H U �6 ?CR
�#A78.   U G �   N7H �#�!D * m  !l� V   .
   G H V  7 OUTPUT:�#�# !l�   g H V b7 EM
IT17 V ]7 CR17 V I7 TYPE17 V S7 DEL17 V 
7 PAGE17 V �7 AT17 V   �7 AT?17 V �7 ROW�
#�7� H V �7 COL�#�7V
H �#�!D * m  !l� V

 .   G H V �7 INPUT:�#�# !l�
 g H V �7 K
EYU7 V  8 KEY?U7 V  8 DECODEU7 V  8 EXPEC
TU7 W    SEAL�#� ; �%@#g H W 38$ONLY�%W j
8%FORTH�%W u8%WORDS>&W A8$ALSO %W M8+DEFI
NITIONS�%�#1 . D � .
� U g .   � � � ��
H �#� g/g K3Y3g  4H X %8 'COLD�(� �#�8�8X
%D8�7' X Z7N7�8H X �8 'RESTART�(� �#; >+
)\+H<�8; . . ! g ; �  )�+�+H � �d �  � �
�  I � �! I � � � � H� � � � � H� � � � �
� � `Z �8 COLDz9��� Ja �  I �$�! I �%� �
 �$HP�  9 � �aH8H Z q9 RESTART�9��� Ja

\ *** Block No. 55, Hexblock 37

  9 � �a�8H � � l  � �9 C64KEY?�9�F� ��hl
+ � �9 GETKEYQ9�F� X�W �X �W ��FP�FF�xI�P
 � l( � F9 CURON�9_S�Q�N�Ll�9� �9 CUROFF
:H�L�M�O�N_S�Q� l  �  : C64KEY�#�9�.�9� �
� :O9H � ): #BS�#  � f: #CR�#
 � r: C64DE
CODE�#l:l �   D �   �7S p x:l �   D } g p
 | �
  % �   � � D7/ H � ^: C64EXPECT�#}
g � D } .   �    8 8N ���
E,H � �: KEYBOA
RD�72:�9J:�:H � V: CON!�:�   �  I � � �
�T�X�  � �.H I�� I `I� I@` `� �: PRINTAB
LE?6;�   ;� J�l  � '; C64EMITp;�   ;� �.l
�:� d; C64CR�#x:�:H � ^; C64DEL�#  ��:E,
 ��:H � P; C64PAGE�#
  ��:H � �; C64AT�;
�   �&_$  ��_S�Q�Nl�9� �; C64AT?M;� 8� �
 � F �� 8 ��@(�� �(h�� � Hl( � B; C64TYPE
�;�   � D$� �&  ;� �.  �Hl <l ;� �; DISP
LAYr7n;F;�;Y;�;�;K;H ���  < B/BLK�#  � ><
 BLK/DRV�#� � l< (DRVz"  �#C<.      H � \
< DRIVE�#v<0 � g H � V< >DRIVE  �#v<0   �
 . U H � �< DRV?�#� .   v<t H � �< DRVINI
T�#� H � �< I/Oz"  � P< BUSOFF�< L�� �  �
 V<�.H � �  � �<w/�.�  , no deviceH �� ��
�` �� ����� HHl�<`� |< (?DEVICE:=�   =�
I � � � l�<� -= ?DEVICE�#V<A.8=H � o= (BU
SOUTQ=���   �&  =�& ���$ ` ���&��l�9� E

\ *** Block No. 56, Hexblock 38

  = BUSOUT�#V<A.O=H � �= BUSOPEN�#  �  �=
H � �= BUSCLOSE�#  �  �=�<H � �= (BUSIN�=
���   �&  =�& ���$ ` ���&��l�9� X= BUSIN
�#V<A.�=H �  > BUS!!>�  ��l� �  > BUSTYPE
�#� �   1 V  >V E �.H � +> BUS@v> ��l( �
m> BUSINPUT�#� �   t>1 � V E �.H � ^> DER
ROR?�#G<      >t>D   0U �   D7t>D x:U � �
�� N7� �<H �#E �#� �#v �#D �>  �      b p
 |   D �>  �   �>U    b      p D A>  �
�>U    b      p A>U    b      H �#E>/ � H
 �#� 8*A �  -Y-�   ,�,Y-!-H �#  � �> READ
SECTOR�#G<   �=�  u1:13,0,X 5>*?5>�<�.�>
 G<
 >e?I>�<� H �   k? WRITESECTOR�#%
G
<   �=�  b-p:13,0X 5>�<G<
�=e?5>�<G<
�=�  u2:13,0,X 5>*?5>�<�.�>H � �? DISKOPE
N�#G<
�=  # >�<�>H � �? DISKCLOSE�#G<

I=�<H �  @ 1541R/W�#�  , no fileF
v<b D
C<g | G �   �-�  beyond capacityV
p �?�
 � V
p � � ? ? � � U . � �
1 %
�    ?x?
N    ?�?| e?  � D �   � V E F
�
 @H � &@
INDEX�#/ � U ! N71 R �-1 �1/   %Z7�6�   �
 V E H � �@ FINDEX�#�?�   �
p / � U 1 N71
 R �-� D 1 ? ?  ?x?| /   %Z7� �6  �   � V
 E  @H � �@ INK-POTz"              h�\a�
H@X�[a�ah�]h �[ah�h�h� �\a�6� ��
}�
}

\ *** Block No. 57, Hexblock 39

  lR� �� ��P�l�9� ca INIT-SYSTEM�#; @�D
 @P ; EaD ; ��g ;   g H XX �� �� ���6� �o
a� P�pa�!P�qa�� ���� � � P� � P� � P� ��
x`� �a C64INIT b Jal�9{  bc(16�#' X �  ,
C) missing. ; C)U � ��H {  bbC)�#H { gbc(
64�#H { rb FORTH-83�#H | ^b ASSEMBLER�%
5c�%|    P
   �(2064)    �l 9�l<9l4Y
J. {����E{    S;!r�+ F




                     �USHA�#  | �b PUSH0A
�#( | �b PUSH�#+ | �b RP�#  | �b UP�#  |
�b SP�#  | Eb IP�#  | Pb N�#$ | {b PUTA�#
  | �b W�#  | �b SETUP�# | �b NEXT�#  |
 c XYNEXT�#�9|  c POPTWO�#  | &c POP�#� �
�H {  bbC)�#H { gbc(64�#H { rb FORTH-83�#
H | ^b ASSEMBLER�%  5c�%|    P  $�&�D&P �
 l  H�$ � �$l} � �*� � �$ � ��  �F E&�&�G
 E'�'8�$�F �$�%�G �%�
� �F � �G l� � �$ %
�=�&Q P �&P �'�$P F%F$l0 �&�(�'�)�&Q  �&P
 �'�$P F%F$(� �*�$ %P�8� �&� �F H�'� �G
� E � � � � � � �$H� � � �%��*�$�(HF* ��
�$� l  b A  SOURCE�#P . � �   �1f<p � [

\ *** Block No. 58, Hexblock 3a

  . H b �  WORD�#A � H b }  PARSE�#| A D
. �
� �   |
U D � x U D G H b �  NAME
�#S,� N p H c    STATEz"  c 5 eASCII�#S,�
 / V = . �   J H c c  ,"�#  "� �
/   z
H c C �"LIT�#� � �
X   | | H c } �("�#� H
 c � A"�#b � H H d � �(."�#� X Z7H d � B.
"�#b � H H   d G a(�#  )� �
H d X b.(�#
)� Z7H  d � a\�#D . 8.t / 8.0 D g H d � b
\\�#f<D g H d    \NEEDS�#' *'V
�     H d
)  HEX�#   � g H d d  DECIMAL�#   � g H e
 w  DIGIT?�#  0U D    G �     �U D    G �
   � .
G �  � � H e N  ACCUMULATE�#� |
 � � . � � %
� . �     � H e �  CONVERT�#
/ X W �   � N ��S H e Z  END?�#� . � H e
�  CHAR�#X � � G H e    PREVIOUS�#S X H f
 $  DPLz"���#�   e �
� e � H �#�   e � �
�   A %
� ? . / �  � � H �#  &l �      �
 p   $l �      � p   Hl �      � p   %l �
   R � p � H �#  ,
U �   .U     H �#? .
� U  H ? G H z"  g 9  NUMBER?�#� 8*D X �
 g ? � � | � � %
  c     -l �   e � |   c
   { �   � g   c   W � c � T   u   W � �
��/ @ � c ?     u   N T�H g �  'NUMBER?�(
� g Q  NUMBER�#| � �  , ?� �   $ H h �  L
ASTz"  �#� . � H h �  HIDE�#� �   � . �$

\ *** Block No. 59, Hexblock 3b

  . g H h �  REVEAL�#� �   � �$. g H h W
IRECURSIVE�#� H �#� �   �
V
� � H h �
  IMMEDIATE�#  @  H h    RESTRICT�#  �  H
 i 5  CLEARSTACKz � � � H� � � l  i k  HA
LLOT�#C .
U � g m D %
U D C g R �

U 8
 x C g H i L  HEAP�#C . F H i �  HEAP?�#�
 � � H �#D   �
U D U � � P �
U � G �
H � 8� � � F � � � �  � I � �Q � �  E h�E
 l+ �#� � .  #g H j � EDOES>�#b  !  l* b
� H �#D   �=   �U U H �#�   �=   �U �   D
 D / �
U / � H � G H   H k '! ?HEADz"
k �! |�#�!.  � �!g H l �! WARNINGz"  �#�
!.  � . �$. N&V
�     E,� . p#�  exists
 7H l �! CREATE�#� P .   �$. .   ' V D H
   � �  , invalid name� � g /   �!�!. �
 H �!G D @!  J      @!W g N   r!� � �
!l !m �! NFA?H"� �(� �)�  I � � � � �&� �
' &P l� �&� �%�&� �$ %P l  �$ I �$� �%�$h
8) E$�$� �%H) � �$h�$�$H�%�$E(  P��%E)P�l
o n _" >NAME�#1 . D �   �
� U � F"� �   F

�
p N ��V
H �#X    =   H n V" NAME>�#D
#� V    = �   . H n  # >BODY�#m H n 8# .N
AME�#� �   D @ �   �  |X    = Z7N   �  ??
?E,H o h# CREATE:�#�!A �$. �$g I(� H o }#
 :�#�# !� 8� � � F � � � � �  I � �E � l

\ *** Block No. 60, Hexblock 3c

    o �#A;�#�   b H �(� H o K# CONSTANT�#
�!   !� 8� � � F � � � H� � � l  o �# VAR
IABLE�#�!R   H p  $ UALLOT�#D < .     �G
 ,
Userarea full< . � < G H p ($ USER�#�!
R 1$*  !� 8� � � F � �  E � �HE � � l  p
^$ ALIAS�#�!� . D V    = �   ; ��  N
    #g H q   �$ VPz"                q F$
CURRENTz"  q $ CONTEXT�#K$D .   m H �#K$
m �$H q �$ ALSO�#K$.    9 ., Vocabulary s
tack full�$. R K$G �$g H q  % TOSS�#; ��K
$G H r o% VOCABULARY�#�!�   �   � 1 .   1
 g  !l� �$g H r D% FORTH�%  Ob  r �% ONLY
�%  X8_% !l� � K$g �  $g  %H r �% ONLYFOR
TH�#�%�% %�%H s L% DEFINITIONS�#�$. �$g H
 �#. � ~"p#H s �% ORDER�# %U   1  &; ��
E R X,�$ &H s  & WORDS�#�$. . D �6� = �
  7D m p#E,N ��� H t 6& (FINDP&� � �$ � �
�&) �(� �$�H�$�%�$ $P � � l� H�$) E(P� �
E$�)� E%�*_(�&Q)PK�P�� �*� ��)
� �� l� K
&� �$� �%�$�&) 8E$�$� �%�&) P �$� �%l�&�$
� �$� � 8� � � F �&  H 0 �i��H��   ��$��
� l  v F& FIND�#�$D .
� . U �   � �
. N
&�   V
I&p
K$m G �   � � N ~�V
� H v #'
 '�#' *'�  , What?H v L'I[COMPILE]�#P'  H
 v �'C[']�#P'J H v �' NULLSTRING?�#D V �

\ *** Block No. 61, Hexblock 3d

   D �   V
H H � I � H� I � � l  w �' >IN
TERPRETJ'4(x �' NOTFOUND�( (x �'
NO.EXTEN
SIONS�#., Haeh?H x  ( INTERPRET�#�'H �#R)
' *'� �   H = �   � �' , compile only�'
| � �   �'�'H �#R)' *'� �   h �   � �'  �
'�' | � �   h �   � J J N   �'�'H y "(a[
�#; 4( )�'  =   H y �( ]�#; O( )�'= � H �
#�  , CrashH z E( DEFER�#�!; Y(   !� � hH
� � H� � l  z �( (IS�#� D m | . g H �#. ;
 �'.
U � ; �'. U   �  , not deferredH z
  )bIS�#P'D ')@#= . �   b  )  p g H z" �#
 +   9  , tight stackY)V � �   � Y)� �  ,
 dictionary full�  s  till full H [ v) ?S
TACKT)� 8� � H� � P �  � |)H �{)� � E H�
� � � l   � �  , stack emptyH \ I) .STATU
S�(� z"� � g H \  *�PUSH�#� � D | . | %*|
 | H \ 1* LOAD�#� �  P 8*P g D 8*D   !*.
(H ] p* +LOAD�#P .   w*H ] W* THRU�#/ � U
   1 w*V E H ] �* +THRU�#/ � U     1 *V
E H ] �*c-->�#H P G D   !*H ] H* RDEPTH�#
M . � m U ) H ] �* DEPTH�#g C . � U ) H �
#= . �   �   compilingp �   okH ^ �* (QUI
T�#!*N7� .( +N ��H ^ 6+ 'QUIT�(>+^ r+ QUI
T�#M . N �(z+H ^ `+ STANDARDI/O�#; *   �
P H ^ W+ 'ABORT�(� ^ �+ ABORT�#x N �+�+G

\ *** Block No. 62, Hexblock 3e

  +H _ _+ SCRz"  _ �+ R#z"  _ H+ (ERROR�#
�+E,� p#X Z7E, 7P . � �   B+g D . M+g G+H
 _ S+�(ABORT"�#� � �   | x � ! G p � H �#
� � �   ! G p � H _  ,FABORT"�#b  ,H H _
d,FERROR"�#b .,H H ` y, BL�#  ` N, -TRAIL
ING�,�  � �& � E%�'_$ � ��&I � HP �%�h�%
l+ �P�F'F%   �l( A Y, SPACE�#S,D7H A �,
SPACES�#� �   E,V E H �#� � H B O, HOLD�#
� �,G �,. � H B �, <#�#�,�,g H B  - #>�#�

�,. �,
U H B  - SIGN�#� �     -�,H B 3-
 #�#� . � %

� �     �    0  �,H B k-
 #S�#o-�
� � ��H C T- D.R�#F
�
5  -Y-%
:-
!-%

�
U X,Z7H C   �- .R�#� $ %
�-H C
�- U.R�#� � �-H C F- D.�#� �-E,H C X- .�#
$ }-H C �- U.�#� }-H D �- .S�#g C .
U
    � �   1 . �-R   E H D  . C/L�#) D 2.
L/S�#  D >. LIST�#B+g �  Scr B+. D v<D �-
�  Dr �<�-d.� U . �6�   � N71 R �-E,B+. �
11 8.0   8.S �,Z7V E N7H E j.   PAUSE  E
�. LOCK�#D . � U �   � p D . �   �.N ���
� g H E �. UNLOCK�#D A.  H H8� � H� � �l�
 � � � H� � � � � � � �  I � � � � l� F �
. FILEQ$ F 4/ PREVz"  F @/ BUFFERSz"  F m
/ B/BUF�#  � �(Y" P H@ P�`Z/� � �$ � ��
� E&�&H� E'�'�i/�(�j/�) I/P �  I � � � �

\ *** Block No. 63, Hexblock 3f


  E HhH � bi INK-POTz*��  ��  ��  � �i I
NIT-SYSTEM�i���l�a�>��Yi�{i�ih�h��  h� �
 l���?�@X�>��i����D��� �� ����i� ���i� ��
�i�@ ���@ � �  � ��?�x`� �i C64INIT)j �il
�a          ���������  j C64FKEYSpj� J0 �
/j�] lrjl�a{ cjc(64�+'$X �  4 C) missing.
 ; C)U � � ��H { CjbC)�+H { �jc(16�+H { �
j FORTH-83�+H | �j ASSEMBLER�-  |k�-|
PUSHA�+  | Lj PUSH0A�+( | Zj PUSH�++ | �j
 RP�+  | �j UP�+  |  k SP�+  |  k IP�+  |
  k N�+$ | "k PUTA�+  | ,k W�+  | 9k SETU
P�+ | ck NEXT�+  | qk XYNEXT�+�a| ^k POP
TWO�+  | Mk POP�+� �

   �(2064)    �l
z9�l�9l { �. { { ?c    *<�:|+�b






                             LOGOz" volks
FORTH-83 3.80.1-C64  ���� � ����  � I � �
 L��� ��     END-TRACEP ��� � � �I� � � l
    B  RECOVERz"H� H� � P F F l�#  �  NOO
P    _  ORIGIN�#    �  S0Q$   �  R0Q$   H
  DPQ$   R  OFFSETQ$   |  BASEQ$    �  O

\ *** Block No. 64, Hexblock 40


 UTPUTQ$   �  INPUTQ$      ERRORHANDLERQ
$      VOC-LINKQ$   &  UDPQ$   6  SP@i �
�$� �%�$� 8� � � F � � � � l    a  SP!S �
 �� � � � l    K  UP@� � ls   � �UP!� � �
 � �� � � � �  I � � � l    �  RP@A � ls
  � �RP!P � l�   H �>R~ � 8� � � F � � �
� l�   W �
 R>� � 8� � � F � � � � �  E �
 � � l    �  R@' � 8� � � F � � � l
�RDROP    =  EXITr � � � � l    i  UNNEST
J � � � � l    _  ?EXIT� �    �  I � � �
(P�l    W  EXECUTE� � � � � �  I � � � l
   �  PERFORM�#. � H   �  C@X � �$� �%� �
 �$l    Q  C!� � �$�
  �%H� �$��  I � � �
 l    �  CTOGGLE�#�
V z � � H      @0 � �
$� �%�$� �$l    *  !i � �$� �%H� �$H� � �
$l    c  +!I � �$� �%H�  A$�$H� � Q$l[
B  DROP�   �  SWAP� � �� � �$�� �$� � H�
� �$� � ��$l    �  DUPF � 8� � � F � � �
� H� �l    �  ?DUP� �   P l  l
 F   �  OV
ER
� 8� � � F � � � H� � � l    �  ROT'

� � �%� � � � � � �$�%� � �$� H� �%� � �
� � �%� � l
 -ROT�#%
%
H   _
 NIP�#�
 � H   P
 UNDER�#�
H   �
 PICK�#/ ? g
 . H   �
 ROLL�#D | �
g D m � / ? � � H
 �
 2SWAP�#%
| %
� H   L
 2DROP    �
 2D

\ *** Block No. 65, Hexblock 41


 UP�#

H   �
 +   H� Q � �� � Q � l�
 �
 OR" H�   � �� �   � l�      AND? H� 1
 � �� � 1 � l�   7  XOR\ H� q � �� � q �
l� ! t  -W H� 8� � H� � � � � l� ! Q  NOT
�  �� � �� � l  ! �  NEGATE� 8��" �  DNEG
ATEC H8�� � H�� � �� � � �� � l   ���� �$
 � �� E �
 � � � � `" �  D+  �   H�  E&
� H� E'� � E$� � � E%� l  # �  1+1 �  A �
 l  � � I � l  # *  2+o � P�# h  3+\ � PS
B � PMH � PG# u  1-U 8� � � l  � � � � l
 # N  2-�  ��$ �  TRUE�#��$ �  FALSE�#  $
 � "-1� $ � !0� $ �  1�#  $ D  2�#  $ N
3�#  $ X  4�#  $ �
 ON�#� � g H $ �  OF
F�#� � g H % � �CLIT  � 8� � � F � � �� �
 P � l  %   �LIT= � 8� � � F � � � � �  I
 � � � l  % 5 GLITERAL�#D ;  �= �   b ;
 p b   * H & `  0<� �   ��$�� l  & �  0=�
 �   ��P�& �  UWITHIN� �   � � E$� �%� �
 E&� �'��l� ' �  <� � �$� �%�
  I � � �
�%q 0�� E$� �%l� ' }  U<  � �$� �%�  I �
� � � E$� �%� l� l� (    >�#� � H ( 5  0>
�#� � H ( c  0<>�#� � H ( r  U>�#�   H (
B  =�#U � H ( Q  D0=�#  � H (   D=�#A
� H ( �  D<�#%
�
U �   9 V
V
N   �
  H �#
e �   � � H ) �  MIN�#�
9 A H ) Q  MAX�#

\ *** Block No. 66, Hexblock 42



�
� A H ) �  UMAX�#�
  A H ) �  UMIN�#�

G A H )    EXTEND�#D � H )    DABS�#$ �
  A H ) .  ABS�#$ �   � H �#e � m D | %
|
 � | | H * c �(DO�#
U u H * O �(?DO�#
U
 � �   u � D .   | � H * �  BOUNDS�#
  �
 H * � �ENDLOOPG � l  + � �(LOOPX  � A �
� � I � �
 l  � � � �� � � l  + N �(+LOO
P   � A � � Q � Jq  �  I � � � ( Dl  , �
�I3 � � 8� � � F  � HHQ � �� HHQ � � l  ,
 - �J_ � PR- y �BRANCHP  � A �$� Q � �$�
l  - E �?BRANCH� �    �  I � � � (�Klp .
�  >MARK�#� �   H . �  >RESOLVE�#�
U �
g H . �  <MARK�#� H
 . Y  <RESOLVE�#� U
  H . �  ?PAIRS�#U  , unstructuredH I   h
��l+ h� �� 8� � � F �� � H� l  /    CASE?
n �   �$A P �%Q P l� �l( 0 d BIF�#b � �
H H 0 H DTHEN�#i H   I H 0 { DELSE�#H   b
 N � � I � H 0 � EBEGIN�#� R H 0 � EWHILE
�#R   R b � � ; ��T
H �#� D ;
 ��U �   �
 I N ��H 0 � FREPEAT�#R   b N } H 0 � EUN
TIL�#R   b � } H 1   BDO�#b U � | H 1 * C
?DO�#b � � | H 1 = DLOOP�#|   b V b E I H
 1 q E+LOOP�#|   b   b E I H 1 L �LEAVE�#
E � � D .   | H 2 �  UM*� � �$� �%H�&�'�
 '&&&%&$�  � E'�'H� �E&�&� �%P �$JP|�'�

\ *** Block No. 67, Hexblock 43


 H�&� � �$� �%� l  3 _  M*�#D � D | �
� � D � �   � � � | � � �   A H 3 �  *�#�
 � H 3 ,  2*a �  � � *� l  �#�  , divisio
n overflowH 4 :  UM/MODU � �)� �(�  I � �
 � � �%� �$H� �'H� �&�  F*8�%�)��$�(� &*�
 �$�%&'&&&%&$JP� F$F%�  � n H �&� H�%� H
�$� � �'l
  5 J  M/MOD�#D | i
� �   �

  � S % � �   �
�   � %   � S e H 5 �
2/+ �  � J� � Jl  6 $  /MOD�#| $ � � H 6
;  /�#b V
H 6 p  MOD�#b � H 6 ^  */MOD�#|
 � � � H 6 N  */�#V V
H 6 �  U/MOD�#� � S
 H 6 �  UD/MOD�#| � % S � � | S � H 7 �
CMOVER �   �D$P F%
  � l  �(�&HP��)�'lX
 7 H  CMOVE>  �    �%E'�' �%E)�)�%_$ � �
�(�&�P�F'F)F%P� l  7 �  MOVE�#| �
  �
� � p � P H 8 1  PLACE�#
| %

/ � 8 � H
 8 r  COUNTZ � �$ I � � �%I � � 8� � � F
l� 8 P  ERASE�#� � H 9 �  FILL� �   ��$�
'� �(HP��)JP��&� �(HJP�� l  :
 �  HERE�#
W . H : }  PAD�#�   b  H : �  ALLOT�#W G
H :    ,�#� g R   H :    C,�#� � H   H :
% �COMPILE�#� D m | .   H ; 8  #TIBz"  ;
t  >TIBz"L

         ; A  >INz"  ; �  BLKz"  ; J  SP

\ *** Block No. 68, Hexblock 44

  ANz"  ; V  TIB�#H . H ; �  QUERY�#�   p
.8} . [ g D   P   H < �  SCAN�#| D �

V % U �   S � / � N ��e H <    SKIP�#| D
�
V % U �   S � / � N ��e H < g  /STR
ING�#
  %

  F
U H Ia� I{� IB� )I[�  �
`= V  CAPITAL� �  � � l  > �  CAPITALIZEP
 � �$� �%�   �l( A Y4 SPACE�+S4D?H A �4
SPACES�+� �   E4V E H �+� � H B O4 HOLD�+
� �4G �4. � H B �4 <#�+�4�4g H B  5 #>�+�
 �4. �4  U H B  5 SIGN�+� �     -�4H B 35
 #�+� . � %      � �     �    0  �4H B k5
 #S�+o5� � � ��H C T5 D.R�+F � 5  5Y5% :5
!5%   �   U X4Z?H C   �5 .R�+� $ % �5H C
�5 U.R�+� � �5H C F5 D.�+� �5E4H C X5 .�+
$ }5H C �5 U.�+� }5H D �5 .S�+g C .   U
    � �   1 . �5R   E H D  6 C/L�+) D 26
L/S�+  D >6 LIST�+B3g �$ Scr B3. D FdD �5
�$ Dr �d�5d6� U . �>�   � N?1 R �5E4B3. �
91 860   86S �4Z?V E N?H E j6   PAUSE  E
�6 LOCK�+D . � U �   � p D . �   �6N ���
� g H E �6 UNLOCK�+D A6  H H8� � H� � �l�
 � � � H� � � � � � � �  I � � � � l� F �
6 FILEQ, F 47 PREVz*  F @7 BUFFERSz*  F m
7 B/BUF�+  � �(Y" P H@ P�`Z7� � �$ � ��
� E&�&H� E'�'�i7�(�j7�) I7P �  I � � � �

\ *** Block No. 69, Hexblock 45

   �  E(� �)I � lr �(�*�)�+�*�(� �*�) (P
l   I7P�(�*� �(�*�i7�(�j7�(�(�i7�)�j7l�7
J ]7 (DISKERR�+�$ error !  r to retry  @D
   rU �   RU   �  4 abortedH J  8 DISKERR
�0 8J g8 R/W�0�h�+D F . � � j m D . / � 3

 82  82�3D F   m . R � . � ]8�   �$ wri
te q8N {�    �  ` /   � H �+m D � `   H �
+D �8
 82  82�3|   � .     %      F H ]8�
   �$ read q8N Y�� H �+g7D . �   . D m .
� U � ��w7A6D A8H �+m | � % g � .   % m g
 � `   w7�6H �+g7. D �   D F . � � ��H �+
g7. D . � � ��F . � H L w8 CORE?�+X7� � H
 M �9 (BUFFER�+X7 9.  9N ��H M �9 (BLOCK�
+X7 9I8.9N ��H O9� � hH� l+ M �9 BUFFER�+
M9_9H M |9 BLOCK�+M9�9H N �9 UPDATE�+  �g
7. F / � H N  : SAVE-BUFFERS�+w7A6r9� �
 A8N ��w7�6H N  :
EMPTY-BUFFERS�+w7A6g7.
� �   D �8N ��w7�6H N h: FLUSH�+,:x:H O X
: (COPY�+D M9�9�   g7. �8L9�     ,:� .
� �9� � g  :H O �: BLKMOVE�+,:|   %     G
 | �   � = � $ % %   � � �   � ; ��  � �:
V E N   � � �   � �:H H   V E ,:� H O B:
COPY�+H L:H O *; CONVEY�+� / R � U D h �
 4 no!!L:H P ;; LIMIT�+ �P C; FIRSTz*  P
Q; ALLOTBUFFER�+Y;. M . U E7m    E7� Y;

\ *** Block No. 70, Hexblock 46

  G Y;. D �8g7.   g g7g H P ; FREEBUFFER
�+Y;. K;E7U   � . Y;. A8g7D . Y;. U �   .
 N ��Y;. . � g E7Y;G H P A; ALL-BUFFERS�+
Y;. �;Y;. U � ��H �+V    = H �+ +� /   �
@(  H �+�(1 . | � . � � ^ D | � U | � . |
   S D %   � % m  +  = � . % @(� Z�% m 2<
�     % m   =<�   % m  +m � N ��e N ��H C
<� � �$ � ��  � I �*H� I �+� �$�,�$�- ,�5
�,E*�-�+� �,E&�-�'l =�(E,�)�-� �,�$�,�$l
=�,�$�-�%l<l� �+1 . � �   D | � U A<� N
��H �+� / D . � U � ( � . � � � �   D . /
 .   g S N   . N N�� H �+1 A< -U   � 1 .
F � �   ; �-1 g ; ��    E � �,. F � �   ;
 �-�,g H S  <
CUSTOM-REMOVE�0� �+  a=}=#=
Q=�(� U U(W g � �'g H  T A= CLEAR�+� D �
U=W g H T �= (FORGET�+D @( 4 is symbolo<U
=H T  > FORGET�+P/D ; $ .    4 protected~
*D @(�    +N   � �  >H T 6> EMPTY�+; $ .
� U=; 2 . < g H U S> SAVE�+� �   U=1 . D
� � .   � g . � � � ��� � ;   P H U �> BY
E�+,:ddH �+ @| U �   � e H U N> STOP?�+ @
�   |>|>� H U �> ?CR�+A?86   U G �   N?H
�+�)D *!m  )l�(V   .   G H V  ? OUTPUT:�+
�+ )l�(  g H V b? EMIT1? V ]? CR1? V I? T
YPE1? V S? DEL1? V ? PAGE1? V �? AT1? V

\ *** Block No. 71, Hexblock 47

   �? AT?1? V �? ROW�+�?� H V �? COL�+�?V
 H �+�)D *!m  )l�(V
 .   G H V �? INPUT:
�+�+ )l�(
 g H V �? KEYU? V  @ KEY?U? V
@ DECODEU? V  @ EXPECTU? W    SEAL�+� ; �
-@+g H W 3@$ONLY�-W j@%FORTH�-W u@%WORDS>
.W A@$ALSO -W M@+DEFINITIONS�-�+1 . D � .
   � U g .
 � � � ��H �+� g7g K;Y;g  <H
X %@ 'COLD�0� �+�@�@X-D@�?' X Z?N?�@H X �
@ 'RESTART�0� �+; >3 1\3Xd�@; . . ! g ; �
  1�3�3H � �d �  � � �  I � �! I � � � �
H� � � � � H� � � � �� � `Z �@ COLDza���
�i �  I �$�! I �%� �  �$HP�  a � �iH@H Z
qa RESTART�a��� �i    a � �i�@H � � l  �
�a C64KEY?�a��
] � ��hl+ � �a GETKEYTa�>�
 }�?�I�P � l( � Ia CURON�a�J EH�
��II �
� �l  � �a CUROFF b��� ��
�l  �  b C64KEY
�+�a�6�a� �� bRaH �  b #BS�+  � =b #CR�+

 � ib C64DECODE�+cbl �   D �   �?S p obl
�   D }!g p | �   % � � � D?/   H � ub C6
4EXPECT�+}!g � D }!.   �    @ @N ��� E4H
� �b KEYBOARD�?)b�aAb�bH � Mb CON!�b� �>�
 l��?��  I � � � �K�O�  � �6H I�� I `I�
I@` `� �b PRINTABLE?3c�   c� J�l  � $c C6
4EMITmc�   c� �.l�b� ac C64CR�+ob�bH � [c
 C64DEL�+  ��bE4  ��bH � Mc C64PAGE�+  �

\ *** Block No. 72, Hexblock 48

  �bH � �c C64AT�c�   �&_$ �>� ���?�l�a�
 �c C64AT?Jc� 8� � � F �� 8�>� ���?�@(��
�(h�� � Hl(  � �c C64TYPE d�   � D$� �&
 c� �.�>� l��?�Hl dl c� �c DISPLAYr?kcCc
dVc�c�cHcH fd�>�lr�� (d B/BLK�+  � nd BLK
/DRV�+� � \d (DRVz*  �+Sd.      H � Ld DR
IVE�+Fd0 �   g H � �d >DRIVE�+Fd0   � . U
 H � �d DRV?�+� .   Fdt H � �d DRVINIT�+�
 H � Nd I/Oz*  � �d BUSOFF�d�>� L��?�� �
 � �d�6H � �  � �dw7�6�  4 no deviceH ���
��>� ���?��`�>� ���?��>� ���?���� HHl
e`�
 �d (?DEVICEDe�  *e�  I � � � l e� we ?DE
VICE�+�dA6BeH � Ye (  BUSOUT�e���   �& *
e�&�>� ���?��$ `�>� ���?��&��l�a� �e BUSO
UT�+�dA6�eH � He BUSOPEN�+  �  QeH  � }e
BUSCLOSE�+  �  Qe�dH � �e (BUSIN f���  
�& *e�&�>� ���?��$ `���>� ���?��&��l�a�
f BUSIN�+�dA6 fH � if BUS!Ff� �>� ���?�l�
 � ]f BUSTYPE�+� �   1 V DfV E   �6H � Vf
 BUS@�f�>� ���?�l( � �f BUSINPUT�+� �   �
f1 � V E �6H � �f DERROR?�+Wd   qf�fD   0
U �   D?�fD obU � ��� N?� �dH �+E �+� �+v
 �+D  g  �      b p |   D  g  �    gU
b      p D  g  �    gU    b      p  gU
 b      H �+ g/ � H �+� 82A%�  5Y5�   ,�

\ *** Block No. 73, Hexblock 49

  4Y5!5H �+  � Rf READSECTOR�+Wd   Qe�$ u
1:13,0,X �f{g�f�d�6|f Wd
qf�g�f�d� H �
 �g WRITESECTOR�+% Wd   Qe�$ b-p:13,0X �f
�dWd
Qe�g�f�dWd   Qe�$ u2:13,0,X �f{g�f
�d�6|fH � �g DISKOPEN�+Wd
�e  #Df�d|fH
� ;h DISKCLOSE�+Wd
 f�dH � \h 1541R/W�+
�  4 no fi
 leF Fdb D Sdg | G �   �5�$ be
yond capacityV p fh�   � V p � � ? ? � �
U . � � 1 % �   Qg�gN   Qg�g| �g  � D �
 � V E F � HhH � Wh INDEX�+/ � U ! N?1 R
�51 �9/   %Z?�>�   � V E H �
i FINDEX�+f
h�   � p / � U 1 N?1 R �5� D 1 ? ? Qg�g|
/   %Z?� �>  �   � V   � l  �(�&HP��)�'lX
 7 H  CMOVE>  �    �%E'�' �%E)�)�%_$ � �
�(�&�P�F'F)F%P� l  7 �  MOVE�+| �   �
� � p � P H 8 1  PLACE�+  | %   / � 8 � H
 8 r  COUNTZ � �$ I � � �%I � � 8� � � F
l� 8 P  ERASE�+� � H 9 �  FILL� �   ��$�
'� �(HP��)JP��&� �(HJP�� l  :   �  HERE�+
W . H : }  PAD�+�   b  H : �  ALLOT�+W G
H :  ! ,�+� g R  !H :  ! C,�+� � H  !H :
%!�COMPILE�+� D m | .  !H ; 8! #TIBz*  ;
t! >TIBz*L!

         ; A! >INz*  ; �! BLKz*  ; J! SP

\ *** Block No. 74, Hexblock 4a

  ANz*  ; V! TIB�+H!. H ; �! QUERY�+�!  p
.@}!. [!g D!  P!  H < �! SCAN�+| D �
V % U �   S � / � N ��e H <  " SKIP�+| D
�     V % U �   S � / � N ��e H < g" /STR
ING�+    %     F U H Ia� I{� IB� )I[�  �
`= V" CAPITAL�"�  �"� l  > �" CAPITALIZEP
"� �$� �%�  $�&�D&P � l  H�$ �"�$l}"�"�*�
 � �$ � ��  �F!E&�&�G!E'�'8�$�F!�$�%�G!�%
�
� �F!� �G!l�#� �$ %�=�&Q P �&P �'�$P F%
F$l0#�&�(�'�)�&Q  �&P �'�$P F%F$(� �*�$ %
P�8� �&� �F!H�'� �G! � E � � � � � � �$H�
 � � �%��*�$�(HF* �� �$� l  b A" SOURCE�+
P!. � �   �9vdp �![!  . H b �# WORD�+A#�"
H b }# PARSE�+| A#D!. �"  � �  "|   U D �
 x U D!G H b �# NAME�+S4�#N"p H c  $ STAT
Ez*  c 5$eASCII�+S4�#/ V =$. �   J H c c$
 ,"�+  "�#�   /  !z H c C$�"LIT�+� � � X
  | | H c }$�("�+�$H c �$A"�+b!�$H$H d �$
�(."�+�$X Z?H d �$B."�+b!�$H$H   d G$a(�+
  )�#� H d X$b.(�+  )�#Z?H  d �$a\�+D!. 8
6t / 860 D!g H d �$b\\�+vdD!g H d  % \NEE
DS�+'$*/V �    %H d )% HEX�+   � g H d d%
 DECIMAL�+   � g H e w% DIGIT?�+  0U D
 G �     �U D    G �   � .   G �  � � H
e N% ACCUMULATE�+� | � � . � � % � . �

\ *** Block No. 75, Hexblock 4b

   � H e �% CONVERT�+/ X W%�   �%N ��S H
e Z% END?�+�&. � H e �% CHAR�+X � �&G H e
  & PREVIOUS�+S X H f $& DPLz*���+�   e �
 � e � H �+�   e � � �   A % � ?&. / � 
� � H �+  &l �      � p   $l �      � p
 Hl �      � p   %l �   R � p � H �+  ,
U �   .U     H �+?&. � U  H ?&G H z*  g
9& NUMBER?�+� 82D X �&g ?&� � | � � %  &c
& &  -l �   e � |  &c& &{&�   � g  &c& &W
%� c&�%T& &u& &W%� � ��/&@&� c&?&   &u& &
N T�H g �& 'NUMBER?�0�&g Q' NUMBER�+|'� �
  4 ?� �   $ H h �' LASTz*  �+�'. � H h �
' HIDE�+�'�   � . �,  . g H h �' REVEAL�+
�'�   � �,. g H h W'IRECURSIVE�+�'H �+�'�
   � V     � � H h �' IMMEDIATE�+  @ (H h
  ( RESTRICT�+  � (H i 5( CLEARSTACKz(� �
 � H� � � l  i k( HALLOT�+C .   U � g m D
 % U D C g R �   U 8 x(C g H i L( HEAP�+C
 . F H i �( HEAP?�+�(� � H �+D   �   U D
U(�(� P �(  U �'G �'H � 8� � � F � � � �
 � I � �Q � �  E h�E l+ �+� �'.  +g H j �
(EDOES>�+b! )  l*!b!�(H �+D   �=   �U U H
 �+�   �=   �U �   D D / �   U / � H �'G
H  !H k ') ?HEADz*  k �) |�+�).  � �)g H
 l �) WARNINGz*  �+�).  �'. �,. N.V �

\ *** Block No. 76, Hexblock 4c

   E4�'. p+�$ exists  ?H l �) CREATE�+� P
!.  !�,. .  !'$V D H    � �  4 invalid na
me� �'g /  !�)�). �   H �)G D @) !J(    (
@)W g N   r)� �'�  ! )l )m �) NFA?H*� �(�
 �)�  I � � � � �&� �' &P l� �&� �%�&� �$
 %P l  �$ I �$� �%�$h8) E$�$� �%H) � �$h�
$�$H�%�$E(  P��%E)P�lo n _* >NAME�+1 . D
�   � � U � F*� �   F � p N ��V H �+X
=   H n V* NAME>�+D  +� V    = �   . H n
 + >BODY�+m H n 8+ .NAME�+� �   D @(�   �
$ |X    = Z?N   �$ ???E4H o h+ CREATE:�+�
)A'�,. �,g I0� H o }+ :�+�+ )� 8� � � F �
 � � � �  I � �E � l
  o �+A;�+�   b!H �
0�'H o K+ CONSTANT�+�) ! )� 8� � � F � �
� H� � � l  o �+ VARIABLE�+�)R  !H p  , U
ALLOT�+D < .     �G  4
Userarea full< . �
 < G H p (, USER�+�)R 1,*! )� 8� � � F �
�  E � �HE � � l  p ^, ALIAS�+�)�'. D V
  = �   ; �� !N       ( +g H q   �, VPz*
               q F, CURRENTz*  q , CONTE
XT�+K,D .   m H �+K,m �,H q �, ALSO�+K,.
   9 .4 Vocabulary stack full�,. R K,G �,
g H q  - TOSS�+; ��K,G H r o- VOCABULARY�
+�)�  !�  !� 1 .  !1 g  )l�(�,g H r D- FO
RTH�-  �j  r �- ONLY�-  X@_- )l�(� K,g �

\ *** Block No. 77, Hexblock 4d

  ,g  -H r �- ONLYFORTH�+�-�- -�-H s L- D
EFINITIONS�+�,. �,g H �+. � ~*p+H s �- OR
DER�+ -U   1  .; ��  E R X4�, .H s  . WOR
DS�+�,. . D �>� = �    ?D m p+E4N ��� H t
 6. (FINDP.� � �$ � ��&) �(� �$�H�$�%�$ $
P � � l� H�$) E(P� � E$�)� E%�*_(�&Q)PK�P
�� �*� ��)  � �� l� K.� �$� �%�$�&) 8E$�$
� �%�&) P �$� �%l�.�$� �$� � 8� � � F �&
 H 0 �i��H��   ��$�� � l  v F. FIND�+�,D
.   � . U �   � � . N.�   V I.p   K,m G �
   � � N ~�V � H v #/ '�+'$*/�  4 What?H
v L/I[COMPILE]�+P/ !H v �/C[']�+P/J H v �
/ NULLSTRING?�+D V �   D �   V H H � I �
H� I � � l  w �/ >INTERPRETJ/40x �/ NOTFO
UND�0 0x �/
NO.EXTENSIONS�+.4 Haeh?H x  0
 INTERPRET�+�/H �+R1'$*/� �   H = �   � �
/ 4 compile only�/ |'� �   �/�/H �+R1'$*
/� �   h �   � �/ !�/�/ |'� �   h �   �
J J N   �/�/H y "0a[�+; 40 1�/  =$  H y �
0 ]�+; O0 1�/=$� H �+�  4 CrashH z E0 DEF
ER�+�); Y0 ! )� � hH� � H� � l  z �0 (IS�
+� D m | . g H �+. ; �/.   U � ; �/. U
�  4 not deferredH z  1bIS�+P/D '1@+=$. �
   b! 1 !p g H z* �+ 3   9  4 tight stack
Y1V � �   � Y1� �  4 dictionary full�$ s

\ *** Block No. 78, Hexblock 4e

  till full H [ v1 ?STACKT1� 8� � H� � P
�  � |1H �{1� � E H� � � � l   � �  4 sta
ck emptyH \ I1 .STATUS�0� z*� � g H \  2�
PUSH�+� � D | . | %2| | H \ 12 LOAD�+� �
 P!82P!g D!82D!  !2.0H ] p2 +LOAD�+P!.
 w2H ] W2 THRU�+/ � U   1 w2V E H ] �2 +T
HRU�+/ � U     1 2V E H ] �2c-->�+H P!G
D!  !2H ] H2 RDEPTH�+M . � m U ) H ] �2 D
EPTH�+g C . � U ) H �+=$. �   �$  compili
ngp �$  okH ^ �2 (QUIT�+!2N?�!.0 3N ��H ^
 63 'QUIT�0>3^ r3 QUIT�+M . N �0z3H ^ `3
STANDARDI/O�+; *   � P H ^ W3 'ABORT�0� ^
 �3 ABORT�+x(N �3�3G  3H _ _3 SCRz*  _ �3
 R#z*  _ H3 (ERROR�+�3E4� p+X Z?E4 ?P!. �
 �   B3g D!. M3g G3H _ S3�(ABORT"�+�$� �
  | x(� ! G p � H �+�$� �   ! G p � H _
4FABORT"�+b! 4H$H _ d4FERROR"�+b!.4H$H `
y4 BL�+  ` N4 -TRAILING�4�  � �& � E%�'_
$ � ��&I � HP �%�h�%l+ �P�F'F%     | �" D
isk 3  --  Forth-Sourcecodes 5 � �" - 650
2-Assembler q � �" - Full-Screen-Editor J
 � �" - Debugging Tools  _ �" - Multitas
ker � � �" - Printer Driver � � �:�:� � B
 �" Disk 4 --  Grafic/Tape � L �" - Grafi
c    (only for C64) � V �" - Tape-Versio

\ *** Block No. 79, Hexblock 4f

  n
� �" - Supertape (only for C16/+4)
%
� �640 b
� �" Hardwarerequirements: h
�
 � G
  �" C64/SX64    with Floppy �
  �"
            or   Cassetterecorder _
  �:�
"      or":� I
& �" C16/C116    with min.
32kB RAM �
0 �"             and Floppy Dr
ive   : �:  �"      or":� & d �" C16/C116
/Plus4  with 64kB RAM k n �"
with Floppy Drive Q x �"             or C
assettrecorder Y B �:� � L �" Have Fun wi
th volksFORTH-83 /cas18aug06 � V � E � �
**************** Z � � ende der seite � �
 � ****************   � � � " � �"
            ":� positionieren p � �"*** (
C)1985-2006 Forth Gesellschaft *** ~ � �"
*volksForth Website:                  * �
 � �"* http://volksforth.sf.net
  * Z F �"* http://www.forth-ev.de
       *   Z �">>>>press key t �o continu
e   <<<<*******   � � e$: � e$�"" �740 6
� � **************** j � � start of page
A   � **************** J   �"�" �   �"
     volksFORTH 83 - rev 3.80.1 � * �:� �
 4 �        * Z F �"* http://www.forth-ev
.de              *   Z �">>>>press key t

\ *** Block No. 80, Hexblock 50


   �(4112)    �lza�l�al W �6 W W {�k
    4dZb|3Hj





         LOGOz* volksFORTH-83 3.80.1-C16+
 ���� � ����  � I � � L��� ��     END-TRA
CEP ��� � � �I� � � l    B  RECOVERz*H� H
� � P F F l�+  �  NOOP    _  ORIGIN�+
�  S0Q,   �  R0Q,   H  DPQ,   R  OFFSETQ,
   |  BASEQ,    �  O  UTPUTQ,   �  INPUTQ
,      ERRORHANDLERQ,      VOC-LINKQ,   &
  UDPQ,   6  SP@i � �$� �%�$� 8� � � F �
� � � l    a  SP!S � �� � � � l    K  UP@
� � ls   � �UP!� � � � �� � � � �  I � �
� l    �  RP@A � ls   � �RP!P � l�   H �>
R~ � 8� � � F � � � � l�   W �  R>� � 8�
� � F � � � � �  E � � � l    �  R@' � 8�
 � � F � � � l      �RDROP    =  EXITr �
� � � l    i  UNNESTJ � � � � l    _  ?EX
IT� �    �  I � � � (P�l    W  EXECUTE� �
 � � � �  I � � � l    �  PERFORM�+. � H
  �  C@X � �$� �%� � �$l    Q  C!� � �$�

\ *** Block No. 81, Hexblock 51

   �%H� �$��  I � � � l    �  CTOGGLE�+�
V z � � H      @0 � �$� �%�$� �$l    *  !
i � �$� �%H� �$H� � �$l    c  +!I � �$� �
%H�  A$�$H� � Q$l[   B  DROP�   �  SWAP�
� �� � �$�� �$� � H� � �$� � ��$l    �  D
UPF � 8� � � F � � � � H� �l    �  ?DUP�
�   P l  l  F   �  OVER  � 8� � � F � � �
 H� � � l    �  ROT' � � �%� � � � � � �$
�%� � �$� H� �%� � � � � �%� � l       -R
OT�+% % H   _  NIP�+� � H   P  UNDER�+�
 H   �  PICK�+/ ? g   . H   �  ROLL�+D |
� g D m � / ? � � H   �  2SWAP�+% | % � H
   L  2DROP    �  2D  UP�+    H   �  +
H� Q � �� � Q � l�   �  OR" H�   � �� �
 � l�      AND? H� 1 � �� � 1 � l�   7  X
OR\ H� q � �� � q � l� ! t  -W H� 8� � H�
 � � � � l� ! Q  NOT�  �� � �� � l  ! �
NEGATE� 8��" �  DNEGATEC H8�� � H�� � ��
� � �� � l   ���� �$ � �� E �
� � � � `
" �  D+  �   H�  E&� H� E'� � E$� � � E%
� l  # �  1+1 �  A � l  � � I � l  # *  2
+o � P�# h  3+\ � PSB � PMH � PG# u  1-U
8� � � l  � � � � l  # N  2-�  ��$ �  TRU
E�+��$ �  FALSE�+  $ � "-1� $ � !0� $ �
1�+  $ D  2�+  $ N  3�+  $ X  4�+  $ �

\ *** Block No. 82, Hexblock 52

  ON�+� � g H $ �  OFF�+� � g H % � �CLIT
  � 8� � � F � � �� � P � l  %   �LIT= �
8� � � F � � � � �  I � � � l  % 5 GLITER
AL�+D ;  �= �   b!;  !p b!  *!H & `  0<�
�   ��$�� l  & �  0=� �   ��P�& �  UWITHI
N� �   � � E$� �%� � E&� �'��l� ' �  <�
� �$� �%�    I � � � �%q 0�� E$� �%l� ' }
  U<  � �$� �%�  I � � � � E$� �%� l� l�
(    >�+� � H ( 5  0>�+� � H ( c  0<>�+�
� H ( r  U>�+�   H ( B  =�+U � H ( Q  D0=
�+  � H (   D=�+A   � H ( �  D<�+% � U �
   9 V V N   �   H �+e �   � � H ) �  MIN
�+� 9 A H ) Q  MAX�+  � � A H ) �  UMAX�+
�   A H ) �  UMIN�+� G A H )    EXTEND�+D
 � H )    DABS�+$ �   A H ) .  ABS�+$ �
 � H �+e � m D | % | � | | H * c �(DO�+
U u H * O �(?DO�+  U � �   u � D .   | �
H * �  BOUNDS�+    � H * � �ENDLOOPG � l
 + � �(LOOPX  � A � � � I � �   l  � � �
�� � � l  + N �(+LOOP   � A � � Q � Jq  �
  I � � � ( Dl  , � �I3 � � 8� � � F  � H
HQ � �� HHQ � � l  , - �J_ � PR- y �BRANC
HP  � A �$� Q � �$� l  - E �?BRANCH� �
 �  I � � � (�Klp . �  >MARK�+� �  !H . �
  >RESOLVE�+�   U � g H . �  <MARK�+� H

\ *** Block No. 83, Hexblock 53

  . Y  <RESOLVE�+� U  !H . �  ?PAIRS�+U
4 unstructuredH I   h��l+ h� �� 8� � � F
�� � H� l  /    CASE?n �   �$A P �%Q P l
� �l( 0 d BIF�+b!� � H H 0 H DTHEN�+i H
 I H 0 { DELSE�+H   b!N � � I � H 0 � EBE
GIN�+� R H 0 � EWHILE�+R   R b!� � ; ��T
H �+� D ;   ��U �   � I N ��H 0 � FREPEAT
�+R   b!N } H 0 � EUNTIL�+R   b!� } H 1
 BDO�+b!U � | H 1 * C?DO�+b!� � | H 1 = D
LOOP�+|   b!V b!E I H 1 q E+LOOP�+|   b!
 b!E I H 1 L �LEAVE�+E � � D .   | H 2 �
 UM*� � �$� �%H�&�'�  '&&&%&$�  � E'�'H�
�E&�&� �%P �$JP|�'�   H�&� � �$� �%� l  3
 _  M*�+D � D | �   � � D � �   � � � | �
 � �   A H 3 �  *�+� � H 3 ,  2*a �  � �
*� l  �+�  4 division overflowH 4 :  UM/M
ODU � �)� �(�  I � � � � �%� �$H� �'H� �&
�  F*8�%�)��$�(� &*� �$�%&'&&&%&$JP� F$F
%�  � n H �&� H�%� H�$� � �'l    5 J  M/M
OD�+D | i   � �   �   � S % � �   �   �
 � %   � S e H 5 �  2/+ �  � J� � Jl  6 $
  /MOD�+| $ � � H 6 ;  /�+b V H 6 p  MOD�
+b � H 6 ^  */MOD�+| � � � H 6 N  */�+V V
 H 6 �  U/MOD�+� � S H 6 �  UD/MOD�+| � %
 S � � | S � H 7 �  CMOVER �   �D$P F%

\ *** Block No. 84, Hexblock 54

    #   �G(14):� switch to lower case 3
 �750:� page v   �" volksFORTH 83 is a co
mplete Y   �" FORTH-83 System for C64,C16
 � ( �" and Plus4 � 2 � � < �" Versions f
or Atari XL, Apple2 V f �" MS-DOS, CP/M a
nd Atari ST � p �" exists.   z �" Please
read file   COPYING in ( D �" Distributio
n Package for > E �" License Detail o N �
 640:� page S X �" volksForth can be down
loaded � � �" for all platforms from � �
�" http://volksforth.sf.net or R � �" htt
p://www.forth-ev.de X � �   � �" PDF Hand
books are also avail  able   � � / � �" F
orth is using its own filesystem [ H �" s
o please copy always the whole disk Z R �
" and not only the files! � | � � � � � �
 � 640:� pageskip � � �" The Disks contai
n: �   � Y   �" Disk 1 --  System-Disk
  �" - File c16ultraforth83 -   Systemker
nal 3 " �" - File c64ultraforth83 - Syste
mkernal ` , �" - File c16demo - Worksyste
m with Tape � 6 �" - File c64demo -
''         Grafic � @ �" - Help Screens �
 j �" - Diskutilities B t � � ^ �" Disk 2
 --  Sourcecode of Forth Kernal � H �640

\ *** Block No. 85, Hexblock 55

\\   Dies ist der Shadow-Screen
          zum Screen # 0

 Der Screen # 0 laesst sich nicht laden
  (ist der Inhalt von BLK gleich 0, so
   wird der Quelltext von der Tastatur
  geholt, ist BLK von 0 verschieden, so
   wird der entsprechende BLOCK von der
      Diskette geladen), der Editor
  unterstuetzt deshalb auch nicht das
  Shadow-Konzept fuer den Screen # 0.













FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 86, Hexblock 56

Shadow for Scr# 1

Screen # 1 should always contain
a directory listing
a good Rule is:

 FIRST  edit the entry in screen 1

 THEN   edit the sourcecode

If needed screens 2-4 can also be used
for the directory listing








            BTW, have you done

          A BACKUP OF YOUR DISKS?

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 87, Hexblock 57

Shadow for Scr# 2

The Editor is designed to prevent
accidently deletion of text, neither
at the end of a line nor at the end
of a screen will txt disappear


If you like to clear a whole screen,
use HOME to jump to line 0 and press
SHIFT F1 (=F2) to move all lies up
untill the whole screen is filled with
new empty lines


If this is too much work, define:

: wipe  ( -- )   \  fill block with
 scr @ block     \  spaces
 b/blk bl fill ; \\

and use WIPE after LISTing the screen
to be cleared

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 88, Hexblock 58

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

























\ *** Block No. 89, Hexblock 59



























\ *** Block No. 90, Hexblock 5a



























\ *** Block No. 91, Hexblock 5b



























\ *** Block No. 92, Hexblock 5c



























\ *** Block No. 93, Hexblock 5d

\\ simple file system          20oct87re

A FOLDER is a single connected screen
Area, containing a Directory Screen
with File- and Folder-Names and
their relative screen numbers:

..     -&150        .            0
FILENAME  $D        FOLDERNAME &13

The ROOT-ORDNER is the whole Disk
with a Diretory in Screen 0. All Screen-
Numbers in ROOT are absolute.

All Screen-Numbers must be maintained
manually.

When moving a complete folder, only the
Screen offsets in the Parent-Folder
needs to be adjusted


.. and . are not mandatory, but without
then the user cannot access the parent
directory

\ *** Block No. 94, Hexblock 5e

\\ simple Filesystem           20oct87re

SPLIT cuts a String at first occurance
 of CHAR. The first part will be stored
 above, the remainder below.
 The Rest$ can contain CHAR again.

READs Path and Filenames. Syntax:

 cd /
     Current DIR becomes ROOT-Directory
 cd /Sub1/
            DIR becomes SUB1 from ROOT
 cd Sub2/
        DIR becomes Sub2 from current
 cd ../
        DIR becomes parent DIR
 ld /File1
        Load File1 from root
 ld File2
        Load File2 from current DIR
 ld /Sub3/File3
     Load File3 in Sub3 from ROOT
 ld Sub4/File4
     Load File4 in Sub4 from curr. DIR

\ *** Block No. 95, Hexblock 5f





  HELP  !!!










       Hummel, Hummel - Forth, Forth










\ *** Block No. 96, Hexblock 60



























\ *** Block No. 97, Hexblock 61

\ Comment to numbers          14oct85re)




alphabetic - not HEX or DECIMAL
  09 follows 08, 0A follow 09
  next 0B etc. until 0Z, 10 follows 0Z
  then 11  ...  19, 1A, 1B, 1C, ...




hex-Zahl  alphabetic display
hex-Zahl  alphabetic display
hex-Zahl  alphabetic display


The other way is also possible
 (this is how we created the hex
  numbers of "numbers" )

Do you need BINARY or OCTAL ?
 : binary  ( --)   2 base ! ;
 : octal  ( --)   8 base ! ;

\ *** Block No. 98, Hexblock 62

\\ relocating the system    bp 19 9 84 )

up@ origin -   is stacklen
r0 @ up@ -     is rstacklen

symbolic map of system

FUNKTION     TOP          BOTTOM

disk-buffer  limit        first @
 unused area
rstack       r0 @         rp@

 free area

user, warm   up@ udp @ +  up@
(heap)       up@          heap
stack        s0 @         sp@

 free area

system       here         origin 0FE +
user, cold   origin 100 + origin
screen       0800         0400
page 0-3     0400         0000

\ *** Block No. 99, Hexblock 63



























\ *** Block No. 100, Hexblock 64



























\ *** Block No. 101, Hexblock 65

\\ disassembler 6502 loadscr







+n Values will be placed inside an
Array
















\ *** Block No. 102, Hexblock 66

\\ dis shortcode0

Table for the complicated even opcodes



Table-Solution



















\ *** Block No. 103, Hexblock 67

\\ dis scode adrmode

Helptable for odd Opcodes



Helptable for odd Opcodes
 Addressmodes


calculates from Opcode 8b1
the addressingmode 8b2
and commandlength +n
for odd Opcodes












\ *** Block No. 104, Hexblock 68

\\ dis shortcode texttab

calulates Commandlength (length)
and Addressingmode (mode)
from Opcode (8b1)






defining word for Text-Tables

Datastructure:

count text1 text2 ... text+n-1 text+n










\ *** Block No. 105, Hexblock 69

\\ text-tabellen

the Mnemonic-Table








the BEFORE Table



the AFTER Table










\ *** Block No. 106, Hexblock 6a

\\ dis 4u.r 2u.r

4u.r print address with leading zeros


2u.r prints byte with leading zeros




















\ *** Block No. 107, Hexblock 6b

\\ dis shadow

"dis" is an ugly word. Better
names for this word are welcome






















\ *** Block No. 108, Hexblock 6c



























\ *** Block No. 109, Hexblock 6d



























\ *** Block No. 110, Hexblock 6e



























\ *** Block No. 111, Hexblock 6f

\\ savesystem shadow          clv04aug87


Usage: SAVESYSTEM name
Example: SAVESYSTEM MY-FORTH
        --creates a loadable File
        --with Name MEIN-FORTH.

  A complex program can contain it own
  SAVESYSTEM buildng on top of the
  generic one, preparing it's own
  Datastructures for later loading.














\ *** Block No. 112, Hexblock 70

Comment for  bamallocate, formatdisk

Creates Entry "0 blocks free"
 open Disk
 read BAM
  IF clear BAM (almost)
     writes back BAM
  THEN  closes disk
 initialize again
 and finish!

CLEAR   (formatted) Disk
 send clear command
 send name
  sucessfull?
 pretent the disk is full










\ *** Block No. 113, Hexblock 71

???

  This page unintentionaly left blank.













copies no dictionary. cannot be used
for Files, only for FORTH Screens








\ *** Block No. 114, Hexblock 72

\\ zu:2disk copy2disk..       clv04aug87


this calculates the cunmber
[0..&682] out of track and sector





















\ *** Block No. 115, Hexblock 73

\\ zu:..2disk copy2disk       clv04aug87


Checks for Disk error



Abbreviation for OPen. 40 Chars are too

copies a secotr (using adr)





 Check if there is Space at PAD
 Status messages

 Loops over allsectors
 prints out some numbers


 switches only(!!) 1551-Floppys.
 For 1541 its too complicated.


\ *** Block No. 116, Hexblock 74



























\ *** Block No. 117, Hexblock 75



























\ *** Block No. 118, Hexblock 76



























\ *** Block No. 119, Hexblock 77



























\ *** Block No. 120, Hexblock 78



























\ *** Block No. 121, Hexblock 79



























\ *** Block No. 122, Hexblock 7a

   �
h2J � B   � � |   �
h2� � � J � �1~

\ O 82 COPYR#� V2\ O T2 CONVEYR#� # F �
I
 � < � �+ neinV2\ P �2 LIMIT�# @P
3 FIRS
T."@�P  3 ALLOTBUFFERR##3" B " I %/a   S
%/_ #3[ #3" � {0 /" � ;  /; \ P )3 FREEBU
FFERR##3"  3%/I   � . #3" !0 /� " #3" I �
   " B ��#  �'l�4�(E,�)�-� �,�$�,�$lG4�,�
$�-�%l�4l� R#% " } �   � P Z I K4� B ��\
R#} # � " } I � ( �
" � X � �   � " # " �
 ; G B   " B N�~
\ R#% K4R$I   �
% " z
�
�   / K%% ; / ��� � �
�$" z
� �   / K%�$;
 \ S �3
CUSTOM-REMOVEI(� R#� �4'5M4{5� �
I i L ; � ~ ; \ T K5
R#�7�   �6�6� \ U �
6 ?CRR#J7 .   I [ �    7\ R#A!�   a � l@
J � " �
� \ V �6 OUTPUT:R#r#� l@ � ; \ V
�6 EMITZ6 V  7 CRZ6 V  7 TYPEZ6 V  7 DELZ
6 V (7 PAGEZ6 V 37 ATZ6 V ?7 AT?Z6 V i7 R
OWR#o7� \ V t7 COLR#o7J
\ R#A!�   a � l@
J   " �
� \ V D7 INPUT:R#r#� l    +�((+R<
�8/ . "   ; / � �(L+X+\ � �9 �  � � �  I
� �! I � � � � H� � � � � H� � � � �� � `
Z �8 COLD 9��� pa �  I �$�! I �%� �  �$HP
� �8 � /aQ8\ Z �8 RESTART<9��� pa �8 � /a
�8\ � � l  � 09 C64KEY?C9�F� ��hl  � w9 G
ETKEYZ9�F� X�W �X �W ��FP�FF�xI�P � l  �

\ *** Block No. 123, Hexblock 7b

  : CON!�:�   �  I � � � �T�X�  � �.\ I�
� I `I� I@` `� �: PRINTABLE?:�  �:� J�l
  � P: C64EMIT�:�  �:� �.l�:� �: C64CRR#
:�:\ �  ; C64DELR#  ��:�,  ��:\ �  ; C64P
AGER#  ��:\ � 4; C64ATs;�  S �&_$  ��_S�Q
�Nln9� i; C64AT?V;� 8� � � F �� 8 ��@(��
�(h�� � Hl   �  � �<@.\ � �  � �< /@.� �+
 no device\ �� ���` �� ����� HHl�<`W<�  �
<�  I � � � l�<� �< ?DEVICER#�<�.U<\  =��
�  S �& �<�& ���$ ` ���&��ln9� �< BUSOUTR
#�<�. =\ � #= BUSOPENR#  �  ,=\ � 8= BUSC
LOSER#  �  ,=�<\ I=���  S �& �<�& ���$ `
���&��ln9� o= BUSINR   �
d g>I    6    �

\ R#k># � \ R#�  *t � |,e-�   ,E,e-�,\ �#
  �  > READSECTORR# <   ,=�  u1:13,0,L �=
�>�=�<�. >S  <
�=K>�=�<� \ � Q> WRITESE
CTORR#
 <   ,=�  b-p:13,0L �=�< <
,=K>
�=�< <   ,=�  u2:13,0,L �=�>�=�<�. >\ �
? DISKOPENR# <
b=  #�=�< >\    � I 1  7
% F �-� � % 3 3 �>~>P #   %#7� �6  �   �
J � �?\ � W@ INK-POT."              h��@�
 H@X��@�@h��h ��@h�h�h� ��@�6� ��
}�
}
lR� �� ��P�l<9� I@ INIT-SYSTEMR#/ @��   @
D / �@� / ��; /   ; \ XX �� �� ���6� �U@�
 P�V@�!P�W@�� ���� � � P� � P� � P� �� x

\ *** Block No. 124, Hexblock 7c

  `� !a C64INIT�a paln9{ �ac(16R#  L � �+
 C) missing" / C)I � ��\ { �abC)R#\ { Mac
(64R#\ { Xa FORTH-83R#\ | �a ASSEMBLERv%
z z�%|    PUSHA�#  |  b PUSH0A�#  |  b PU
SH�#  | (b RP�#  | 5b UP�#  | @b SP�#  |
kb IP�#  | vb N�#$ | Ab PUTA�#  | Kb W�#
 | Xb SETU  \ M �1 BLOCKR#�1}1\ N �1 UPDA
TER#  � /" z # � \ N A1 SAVE-BUFFERSR# /�
. 1} �   !0B �� /@.\ N }1
EMPTY-BUFFERSR#
 /�. /" } �   � {0B �� /@.\ N  2 FLUSHR#�
1 2\ R#� �1n1�    /" {0,1�   �1Z " �
� �1
� � ; J1\ R#�1P �   �
� [ P �
  � 1 � $
   � � � |   � / ���  3" " � ; %/#3[ \ P
K3 ALL-BUFFERSR##3" 73#3" I � ��\ R#J
1 \ R#�"|
#   � �   \ R#� % " P � " } � ^
 � P Z I P � " P � G �     �   a �"  1 �
.   � � Z�  a |3�   �   a �3�     a S"a �
 B ��9 B ��\ M4� � �$ � ��  � I �*H� I �+
� �$�,�$�- ,�5�,E*�-�+� �,E&�-   CLEARR#X
 � } 5L ; \ T �5 (FORGETR#� � �+ is symb
ol�35\ T �5 FORGETR#;'� / $ "   �+ prote
cted�"� � �   �"B   � � E5\ T 5 EMPTYR#/
 $ " } 5/ 2 " 0 ; \ U  6 SAVER#X } 5% "
 � � � " � � ; " } � � ��} � /   D \ U >6
 BYER#�1�;\ R#�7P I �   � 9 \ U W6 STOP?

\ *** Block No. 125, Hexblock 7d

  @   ; \ V �7 KEY~7 V �7 KEY?~7 V �7 DEC
ODE~7 V @7 EXPECT~7 W    SEALR#� / Z% #;
\ W |7$ONLYZ%W �7%FORTHI%W �7%WORDS &W  8
$ALSO�$W  8+DEFINITIONS�%R#% " � � " � Z
I ; " } � � ��\ R#�  /;  3#3; H3\ X N7 'C
OLDI(F{R#18q8�%M8:7  L #7 7�8\ X E8 'REST
ARTI(�ZR#/   O9 CURON�9_S�Q�N�Lln9� �9 CU
ROFF�9H�L�M�O�N_S�Q� l  � �9 C64KEYR#_9�.
A9� ���9X9\ � R9 #BS�#  � �9 #CR�#
 � �9
C64DECODER#�9@ �   � �   .7G d  :@ �   �
Q ; d P �
�
  � � �
7# \ �  : C64EXPECTR
#Q ; � � Q "   �   �7I7B ��~
�,\ � o: KEY
BOARD�7{9A9 :[:\ �     � K; C64TYPE�;�
S � D$� �& �:� �.  �Hl�;l�:� �; DISPLAY�6
�: ;�;";>;q;T;\ ��� G; B/BLK�#   � �; BLK
/DRV�#� � �; (DRV."  R#
<"    �
\ �  < DR
IVER# <$ Z ; \ �  < >DRIVER# <$ �
Z " I \
 � 6< DRV?R#Z " �
 <h \ � q< DRVINITR#� \
 � H< I/O."  � Z< BUSOFF�< L��  #�<�.G=\
� �= BUS!�=�  ��l� � �= BUSTYPER#� |   %
J �=J � �.\ � �= BUS@|= ��l  � S= BUSINPU
TR#� |   Z=% � J � �.\ � �= DERROR?R# <
 �=Z=�   0I �
7Z=�  :I � ���  7� �<\ �
#E �#� �#v R#� ?>  �      6 d P �
� c>  �
   ?>I    6    �
d � g>  �   c>I    6

\ *** Block No. 126, Hexblock 7e

  � P? DISKCLOSER# <
z=�<\ � �? 1541R/W
R#� �+ no filez
 <6 �
<; P [ �   �-�  be
yond capacityJ
d {?�   � J
d � � 3 3 Z �
I . � �
%
�   �>~>B   �>#?P K>�
� � �
 � J � z
~
�?\ � �? INDEXR## � I !  7% F
�-% �1#   %#7�6�   � J � \ � b@ FINDEXR#{
?�   ~
d #  P�#S | �b NEXT�#  | �b XYNEXT
�#n9| �b POPTWO�#� | �b POP�#� . �a .BLKR
#D " } �   �   Blk H-�6\   Gb (SEARCH�b�
� �$ � ��( )�I�$ %�C�&A*� �$P F%F$�&P �'l
 c� �$ � � ��&P �'�*P �+�$P F%F$�(P F)F(�
( )P �  I � � � � �'� �&�� �l� �$ %P �  I
 � � � � l� �&A*�     $d CBM>SCR�d�  Md
� l    �d SCR>CBM�d�  \d� l    �d EDITORv
% r r b�#( �#  �#�      SHADOW."u ."  ."
 ."o ."��."  ."�|  ."�|  ."  w|."  |�#Q
�#S �# P�#� �#!P�$ I)�$� �%�& I(�&� �'`<e
� S �&�� �'� �'�$ Md�&� � #eJP � X� Y�
 Z� {�P�ludRe� S �&�� �'� � �&  1 )f� 1 �
 S   ��:\ R#cf} S �d" �   Gf} S [f\ R#�d"
 � z7Ld� [ 1 � S    �:\ R#cf� S    �:\ R#
�ePdq,J
PdG K Hd6 � �c� \ R#�    � I   �
Kf� �   � J � \ R#   � I     ��:J � � \ R
#z7� �c-d�d� �f\ R#�eHd?,� � \ R#
fHdJ7I
?,� � \ R#�e� Hd�
� �e/ @ �
� P � I D �

\ *** Block No. 127, Hexblock 7f


dD \ R#�da " � } S �g� S Hh\ R#�d� � \
R#�d� � \   �d RVSONR#   �:\   �h RVSOFFR
#  ��:\   Ch ***ULTRAFORTH83***    WhrFOR
TH-GESELLSCHAFTR#  \   Vd STAMP$."    06n
ov87re     R# i# L �eHd�
� I � �e� \
i
 GETSTAMPR#   *�: i�  7�  your stamp: �h
  _,z7   �   � Hd# x HdI I �;G K Hd# 6 �
�c\ R#-d   `j\ R#�j�+" �1�e�   *i� �+" �1
PeJ1     \ R#�j     \ R#Jj     \ R#�+" �1
:e�d� -dTj� \ R#�j� � �+[ �j\ R#�j� � �+[
 �j\ R#�j� d" � �iJ
[ � �   _ �+[ �j\ R#
�j� �d" �+" �d; �+; �j\ " �h DIGDECODER#�
9@ �   � �   .7G d     P �kW7Q " } �   X
|
� _ � �d; �c�d" P �-�:�
�c ea " Hd� J7I
 W7Q " } �    e; �c eJc�k�
�c ea " Hd� J7
I W7Q " } �    e; �c eJc�kLh�i�c\ R#�j�
eJc�+" �+" �1�
�;�+" I �b� �   � B   �+"
�1I �+; Tj\ R#�j�  l�l�+" � ' �7�   rI �
  Ak} �   J
d P I } S B S��iJ
  � � I �
 wn� \ ( fi (PAD."  R#� � �n; Hd3 �
�  ea
 ; Hd�
�  ea ; Hd�
� �d; Hd3 �
�d; �da �
�da � / YhL P  ea "   D �  e; / �hL    1
P  ea "   D �  e; \ R#� �n" I S �n\ �##
o_S�Q�Ni��Qln9.o�N_S�Qln9R#/ d  o; Lh,o\
R#D " } � �   7od � " G �+; Lh,o�h�+" �

\ *** Block No. 128, Hexblock 80

  F 1 � �   �  not �  changed� Z 1 �   �1
�    1    I �   �  , saved   1 �   �  , l
oading 7�+" �+" @o\ , =p LR#�+� dp\ , Sp
RR#�+" dp\ , �p +LR#�+" �
Wp\ , �p VR#;'�
"} �   Z I " \ ,  q VIEWR# q} �   WpB   �

from keyboard\ , �n CURLINR# e"   UJ q,
�   S� \ -  i�  *� �n�  *� e6   F b=� � �
=�  ,p,wL �=�<   F ,=�    I � /   � � �=�
=X � I +r�<   F z=�
<;  >�+ save-error\
  �b END-CODER#D$� " D$; \   Zr INDEX."
     � �
  ����    �����   ��,."    �r MO
DE:R#A!  � l@ J  s; \   %s .A5s   bs #5s
5s   ls ,X5s   xs ,Y  5s   Bs X)5s   Ls )
Y5s   Vs )5s R#�    s"       s; �  s"
1 } �   � I   � �
J � � # " 1 � \   �s CP
UR#A!  � l@ J   ss\   Gs BRKUs   �s CLCUs
   �s CLDUsX  �s CLIUsx   t CLVUs�   t DE
XUsJ   t DEYUs�  $t INXUs�  /t INYUsH  :t
 NOPUs�  et PHAUsh  pt PHPUs    � �$ � ��
$P F%F$�&P �'l cR#d7�9\   �b 2!�c� S � �
�$� �� l�   �c 2@Lc� �$� �%� 8� � � F � �
$� � �ln9  Ec 2VARIABLER#A!Z � \   �c 2CO
NSTANTR#A!    � l@ Jc\    d UNLINK/d��  �
���Y I(� H�� P�SI(� �(�S_S�V  ��� � l  �
*)? *$*   �P  @`�*)I �
I@� ) $*   @`�.`

\ *** Block No. 129, Hexblock 81

   \d�$H@(��J� � �$ #elelud�e�  S �D$P l
ud�( Md�&HP�e� S �&�� �'� �'�$ MdQ&� ��l
  � � #eJP�l  R#; Hd3 I \ �e�h�� l  �e�S
I(�� �'EQh�RI l   f �SEQh�RI l   f�UI(� J
�l  R#�e/ @ �
Hdq,J
� �d"   \ R#
f�ePd�
G
 I �d" � 1 \ R#�dJ �:� \ R#cf} S  f�eHd�

G J ?,I �   Hd?,� � \ R#)f� } S �e� Hd�
�
ePd�
� I � ?g\ R#Kf� S    �:\ R#�dJc�
# �
d" �eK [ � S
fJ �dJc�
� � �da [ \ R#�g}
S Kf\ R#�g} S �g\ R#�da " � } S Gf� S � �
da [ �dJc�
J
f� \ R#�dJc�
�e[ � S �e�dJc
�
HdD Hd�da [ \ R#*h} S �f\ R#*h} S _g\ R
#Hd_ �da [ �dJc�
�eH  c ia    W7LhQ "  i#
 � \ R# iJ S qi\ R#�e� Hd3 D �eHd3   �� \
 R#� �eHd3 D \ R#�1� " \ R#_9�.�7� ���9\
R#�+" Z " �
 <� � \ R#o7�i�h� � �c�i�  Sc
r # �-�  Drv �-�+" Fi� �   �  not �  upda
ted� � �c/ YhL #7F _,/ �hL    1 #7Lh�cPi�
i� \ R#o7� Hd# $ �
�+; \ R#�+"  :@ �   �
Q ; d � � J �   � P �
�
  � � �
7# d � \
 " tk DIGITS�7{9A9`k[:\ R# e" � I   �9�:J
 � �  e" � I   Gf  J � � S  eJc
f� �e�j�
\ R##7  <
7HdG J7I _,\ R#   *-d�io7�h� �
�c�  replace with: o7 eJc�k� � �c�  >
 search: o7 eJc�k� F �
�c�d" P �-�
�cX #

\ *** Block No. 130, Hexblock 82

  �d" I �6� 1 } �   � �   �j� B    k� B �
�� \ R#?   @I \ ."
�    �����  ����
  �� ��      �."�j k k8k8mph-g-g�j�jJjUj�
g_g�h\h*i�i�g�g h�f gKf�f[f[f[fZfGf[f�g?g
mg�h_h�f n�  S _$�H��mI�� E&P�� ��Smh�Tml
  R# e� �.  �� I   J � \ R# e *� @n� @n�
@n� @n\ R#  I �   �+; �j� � �c�)Tj o� \ *
 �k (LOADR#�  *� ; } � S D  *D ; �)�'\ *
�o SHOWLOADR#�+ *�+� �+ */ go o; �o7o\ R#
S@�
� J  e� � # J  e� a J  e� \ R#Z |o  �
�:�j� �d� �7� �d� �  n� On} � ��� � �c_g�
 �d� � |o\ + �o EDITR#�+; �i o�o   � �c�i
�  Scr �-�  Drv �-�    kq EDIDECODER#  �@
 �   �d�  7d  :@ � < �d� tq� Q " [ �   �
Q " � |   �
�
% J �d� � # J � � Q ; d � �
d�     n� On� \ - Lq EDIEXPECTR# oQ ; � �
 Q "   �   �7I7B ��~
�,\ - �q EDIBOARD�7{
9A9Xq�q\ R#�b/ �.�  *; �< *�<� �=\    q S
AVESYSTEMR#�+ *� �+; �+ *�+�     [t PLAUs
H  Ft PLPUs(  Qt RTIUs@  |t RTSUs`  �t SE
CUs8  �t SEDUs�  �t SEIUsX  �t TAXUs�  �t
 TAYUs�  �t TSXUs�  It TXAUs�  Tt TXSUs�
 t TYAUs�  �t M/CPUR#A!    � l@ � # "
�1 �       s[ � /  �1 �s�s�   ss� �+ inva
lidJ  s" �r�
J �
   s"    1 �    s"    1

\ *** Block No. 131, Hexblock 83

  �   xv LDY u��   Ev STY u��   Rv JSR u
�   v JMP u@��  �v BIT u � R#� =   [ �+

out of range \   �v [[R#X \   Cv ?]R#  X
 # I _v  \   Pv ?[R#  X �   \   �v ?[[R#�
v� \   �v ]?R#X � J �   � ; B   � # I _v�
 � \    w ][R#X # � �v� X � # I _v� � \
 3w ]]R#�v   nx 2INCR#� �u�sF ps�u� |uXw�
v� #  v w\   ^x 2DECR#� �u�tF psOu� |u�w�
v� # �u w\   �x WINCR#�  v�w�v� #  v w\
 �x WDECR#� �u�w�v� # �u w�u\   Mx ;C:R#�
 �v�r�(� ~ ; � \   gr ASSEMBLERR# bss\
 ye;CODER# !/ ��� �#/ ���  y\    y CODER#
A!X � � ;  y\   >y >
L �
�
B � � D \ 1
  CPUSHR#� z
� P � � # I � B n uzP P \ R#
  r� �:Q;�)�,� �'/ ��� 9 \ 1 Kz RANGER#az
� � =z; # � " / \ I � ��n az; \ �z���kz�l
z� � � � �  I � � � �;z� �<z� l  ."~z\ �
 I � � � �kz��gzP � M?z� �@z�V� Mcz� �dz
�Jla[�gz�kz�lz� �;z� �<z � ez"  d /  0" @
 �    #"  \d " / l@I �   " P �
d �" #�  c
an't be DEBUGged3+\ 5 �z NESTR#mz" "  \�
ez� \ 5 �\ UNNESTR#=z� az� \ 5 �\ ENDLOOP
R#mz" Z �
=z; \ 5 O\%UNBUGC 5 �\ (DEBUGR#
 \�zez� iz� qz�  z�[\ 5  z DEBUGR#;' ]\ 5
  ] TRACE'R#;'�  ]� C \ R#�6� Z �-�  :\

\ *** Block No. 132, Hexblock 84

  ] RELOCATER#� � �
�
�
%/�
a  3[ �+ buff
ers?� � /   �
  �+ stack?� 0 "   @�
  �+
rstack?@2$6|
�
�    �
; � ,^} # " � # ;
  I �    �
;  9\
 p^ BYTES.MORER#} � I �

B " } I [^\
 }^ BUFFERSR#%/$ a  3B " I
� I �^\    _ DEMOSTARTR#\  ALLOT MPTY  ��
\  TEST T    � � � ; � � |   % ; F � � \
;  `�ACTIVATER#� B ��; L` SLEEPR#  l� � \
 ; �` WAKER#  ,� � \ R#q+�_�
Task error
: L #7 `�_\ < �` TASKR#� X   �1   �I �
� � } X /   D X   l  } # "   � } # ; P �
�    I �     �
�
  |
�
X I a � / �`�    �

; �#\ = J` RENDEZVO  aft 7�  bleibt FORT
H ein ADVENTURE! 7\ a ~A >BYTE|B� h�� � 8
� � � F �� Hl  a RB HBYTER#ZBJ
\ a �B LBY
TER#ZB� \ R#A!� I     J � � �  I  �� � H�
 � � l  JB  � ]   � H   C P   H T   J S
 D L   � \
  � c � �   � w � �   � f X H
� �
 �   � # _ # �   �   { �   � � � F �
'� �&� � 8� � � F �%� �$� l  ] -D DU<R#/
 ��

/  ��


� \ R#� I . P 3D3D  I � �
 �     �
� 3 G B   � 3 P �
J � \ R#P 3D�
� �   3D  I � # B   3D  �
  �   � � G B
 I � # \ R#P � � �   ~
� # B   3D/  �  SD
� _ � �
\ ^ MD SQRTR#� �    �D
�    �DA

\ *** Block No. 133, Hexblock 85

  D�D\ _ 'E 100*sE� �$� �% $&% $&%�$�&�%�
' &&' &&' &&' �$E&�$�%E'�% &&' �$E&� �%E'
� l  f+F*F)F(f+F*F)F( �$E(�$�%E)�%� E*� �
 E+� `` jE 100U/NE�$�(�  �%�)� *� �*�*� �
+ �Ef+F*F)F( �El  @ DE GRAPHICv%2Q2Q z�#�
 �# �# X�# D�# @�#  �#  �#  �#  1FX�2� �
� �$�&�X�%      U �     B     ss\   �t AD
C u`N   {u AND u N   �u CMP u@N   �u EOR
u@N   �u LDA u�N   �u ORA u N   �u SBC u�
N   Iu STA u�L   Vu ASL u

  �u DEC uA
  �u INC u�    �u LSR ua

   v ROL u!


 v ROR uA

  $v STX u�    1v CPX u��   >v
 CPY u@�   kv LDX u�  \   vw ]]?R#�v w\
 Cw CS�#�   Sw CC�#�   ~w 0=�#P   �w 0<>�
#�   �w 0<�#    �w 0>=�#0   �w VS�#p   �w
 VC�#P   Bw NOTR#   n \   Mw BEQR#�wUv\
 ~w BMIR#�wUv\   �w BNER#�wUv\   �w BPLR#
�wUv\    x BCCR#XwUv\    x BVCR#�wUv\   .
x BCSR#�wUv\   >x BVSR#GwUv\    LABELR#X
H!A!� �   Z i � � 1 i X Z I � Z D � ~ " L
    1 �
; L ; � l@ " 1 " �   ^ \   wy LAB
ELR#X `y y\   �x ROMR#X    �
/  �[ �+ not
 here  7ps�u� |u\   Dy RAMR#  6ps�u� |u\
/ �y TOOLSv% ^ ^Fd0 �y WCMPR#� �u� �u� #
�u# Ou\ ."  ."PX."FX."�X."�X."_X."�X."�

\ *** Block No. 134, Hexblock 86

   � " ez� � az *=z *� � �zqz *� qz[ P
 [P    *�  *� � mz;  7qz" _,� Z �-" �
�-�,�" #   J7I � } _,W-1  *D  *�  */ (+ *
/ �' *o  *} o " SzB  *� B ; / �z�((+3+\ �
[�[� � � �l� l  R#� " / L#" @ �    #d / �
7" @ �    #J   " �
"  \d / #7" @ �    #J
� " �
"  \  R#� "    �-\ R#� J P �-\ R#
$J7I � } _,\ 6 �\ SR#c]�,`]Z _,� L #7� J
�
# L]\ 6 ] NR#c]s]F _,� " �" #a L]\ 6 �
] KR#c]s]a L]\ 7 A] DR#�
� c]P _,� � I
`]# J � Z _,z
#7L]\ 7 S] CR#� W]\ 7  ^ BR
#c]s]� " � �
   �-a L]\ R#} � # |
" �
I �

� B ��~
; \
 ,   Z   �$" x   �$"312
,6A_  � J �    � � -11053U_.Gname�113�_J
# � N: &_ STOP�_� 8� � � F � � � � � 8� �
 � F � � � � � � � H� � � � E � �E � l  .
"�,� l�_: �_ SINGLETASKR#   / �.; \ : �_
MULTITASKR#|_/ �.; \ ;  `�PASSR#�   ,� �
� z
   �
P   a " � a 3   " � I  USR#� @.�
.�.\ R#1 " �   ^ \ = @Ab'SR#;' #J �
yA\ =
 IA TASKSR#�  MAIN  7} � # " �
I � 8 �
 �
"    �
�"�" #� J   lI �
 �  sleeping
7# " B D�~
\   ~A HELPR#P Wp 7�  Probier'
 ruhig weiter! 7 7�  Aber ohne Handbuch 7
�  und die Hilfe der 7�  FORTH-Gesellsch

\ *** Block No. 135, Hexblock 87

  [ H 2 �   B C  !|!T!*"}"N" #G#�#�#8$X$�
$�$'%[%�%�%�% &5&x&X&�&�&E&Y&�&�& ' ' ' '
R#�   z- �     �� I B\ \ �B SINR#/ H x �
 � �   / H �
�   �- �     �I �C_ B   �C\
\ �C COSR#/ H x   z�
�C\ \ �C TANR#� �C�
�C} �
   D� } B   P $ \ ]  D D2*5D�  S
&&'&$&%� 8  �X�'�$�&HP��%�'JP�6� xHl  c
   CLRSCREENR# F/ @ � \ ."TG." �."��."(�.
"P ." �� � P� � P��F� P`�;� P� � P��F� P`
��F8�0jjj8� EV� `�� �L�M�N_S�Q� �O  ���
�Q�N�L`�� ) P l1� ���� P�LXF� P� P� JP��$
��Fi ��F�P  �Fl G �F��F� P �F�
|) P�l��X�
F�  ���  ��� P���
|x
   �(4112)    �l
 a�l9al Z J6 W Z�{GU    Vc�C�3YH




                                J ~F� / P
 �F; �G\ h  H NOGRAPHICR#�%@G   /  P�
/  P� Z  F� ~FJ /  P� /  }J P   /  }� \ i
 �G BLK�#  i �H WHT�#  i �H RED�#  i �H C
YN�#  i �H PUR�#  i IH GRN�#  i UH BLU�#
 i �H YEL�#  ii �H ORA�#  i �H BRN�#  i
I LRE�#  i  I GR1�#  i  I GR2�#  i *I LG

\ *** Block No. 136, Hexblock 88

                                   .* ult
raFORTH-83 3.80-C16+ ���� � ����  � I � �
 L��� ��     END-TRACEE ��� � � �I� � � l
    w  RECOVER.*H� H� � P F F lR+  Z  NOO
P    �  ORIGIN�+    _  S0<,   �  R0<,   �
  DP<,   G  OFFSET<,   Q  BASE<,     OUT
PUT<,   �   � �9  8&9 8&9HE8�8� �9 8&9 8&
9 8&9�$)  8�8 �&)�E8�8�'E9�9�� 9�9�&) ���
I�  `l
J PLOT�J  J�9���  8�8� xln9l �J F
LIP�J  J�9��� q8�8l�Jl _J UNPLOTJJ  J�9��
� i�18�8l�Jm �J LINE�J�  S � �$�`J ��G8�(
�(�G8�$�$�5�4�2��7�6�3��*E&�+�'� 8�&�*�0�
'�+�1�5l9K�*�&�0�+�'   INPUT<,   �  ERROR
HANDLER<,      VOC-LINK<,      UDP<,   *
 SP@= � �$� �%�$� 8� � � F � � � � l    5
  SP!G � �� � � � l    _  UP@ � lg   W �
UP!� � � � �� � � � �  I � � � l    �  RP
@� � lg   � �RP!D � l�   � �>RR � 8� � �
F � � � � l�   K �R>� � 8� � �    / �K� \
 p  L SPRBUF�# H�# P�# Pp aL SPRITE�# P�#
 Pp xL 3COLORED�# P�# P�#%P�#'P."      @�
�L�  S ��(��L�$P i�1&l�L &�&ln9q KL SETR#
� �L\ q �L RESETR#� �L\ q AL GETFORMR#  @
$ jL�
  @D \ R#/ � �
�
� \ q SL FORMSPRIT
ER#P jL/  ?1   @h �
�    F�L�  F�L\ r �L

\ *** Block No. 137, Hexblock 89

   F � � � � �  E � � � l    �  R@  � 8�
� � F � � � l      �RDROP    1  EXITf � �
 � � l    =  UNNEST^ � � � � l    s  ?EXI
TU �    �  I � � � (P�l    K  EXECUTE� �
� � � �  I � � � l    �  PERFORMR+" � \
 �  C@L � �$� �%� � �$l    E  C!� � �$� �
%H� �$��  "  XMOVER#�
3 nL�
� rL
  �- �L
\ r 1M YMOVER#3 # nL�
� \ r tM MOVER#|
9M
\M\ r LM SPRPOSR#� P 3 # nL�
J   3 nL�
J
� �L�
J rLJ 1 �   /   �
\ s M HIGHR#EL�L
\ s �M LOWR#ELIL\ s OM WIDER#ZL�L\ s M S
LIMR#ZLIL\ s �M BIGR#� EM�M\ s  N SMALLR#
� UM�M\ s  N BEHINDR  I � � � l      CTO
GGLER+| J n � � \      @$ � �$� �%�$� �$l
       != � �$� �%H� �$H� � �$l�   7  +!]
 � �$� �%H�  A$�$H� � Q$lo   v  DROP�   Y
  SWAP� � �� � �$�� �$� � H� � �$� � ��$l
    �  DUP� � 8� � � F � � � � H� �l    �
  ?DUP �   P l  l�   V  OVER�  `bGX��
�1�  ��� P���
|xl  �F�  ���  ��
|�� P�|
F��Fl�Fg ^F TEXT�G� �|F )G �Fl  g ZG HIRE
S�G� �|F )G �Fl  �GX [Gxln9g �G WINDOWR#
  $   0�
�F� �G\ �|FP
�|F )G �Fl1�� P
�
|F )G �Fl1� �|F [Gl1�h �E GRAPHICR# F/F/
  }J   �1  F  /  }�  F�B F�  FJ �F� /  P

\ *** Block No. 138, Hexblock 8a


 � 8� � � F � � � H� � � l    �  ROT  �
 � �%� � � � � � �$�%� � �$� H� �%� � � �
 � �%� � l       -ROTR+    \   s  NIPR+�
� \   D  UNDERR+� � \   T  PICKR+# 3 ; �
" \   �  ROLLR+� P � ; � a � # 3 � � \
�  2SWAPR+  P   � \   @  2DROP�   V  2DUP
R+� � \     R�#
 i 6I LBL�#  i bI GR3�#
i nI BORDERR#� ~F� /  P� \ i zI SCREENR#/
 !P� \ i UI COLORSR#� �F�    $    F/ �

� \ i �I BACKGROUNDR# FJ    h �I\ i �I PE
NCOLORR# FJ    1 � �I\ �@      R#� `y�
\
j NI POINTY�#` j �I POINTX�#B �  S � �$�`
J ��G8�$�$XF �$)�h�8  �  +�  H� Q � �� �
Q � l�   �  OR  H�   � �� �   � l�      A
ND3 H� 1 � �� � 1 � l�   +  XORp H� q � �
� � q � l� ! h  -K H� 8� � H� � � � � l�
! E  NOT�  �� � �� � l  ! �  NEGATE� 8��"
 �  DNEGATE� H8�� � H�� � �� � � �� � l
 ���� �$ � �� E � � � � � `" �  �1�(E$� 8
�$�(�.�4loK�$�.�1P �0E.� �.�.�0�5�6�4�7H�
5�4�1j�-�0J�,8�D�5� 0 �&P �'l�K�&P F'F& �
$E7�$ �,E.�,� �-�2P �3�0E,�1�-�+8�,�0�,�-
�1�-�6� 0 �&P �'lVK�&P F'F& �$E4�$ /J�9��
�  8�8� x�0E2�1�3��ln9o ~J DRAWTO L� �` �
( � ��  S l�Jo �K FLIPLINER#  q/ �K� �J

\ *** Block No. 139, Hexblock 8b

    D+� �  S H�  E&� H� E'� � E$� � � E%�
 l  # �  1+% �  A � l  � � I � l  #    2+
c � P�# <  3+p � PSv � PM\ � PG# i  1-I 8
� � � l  � � � � l  # B  2-�  ��$ �  TRUE
�+��$ �  FALSE�+  $ � "-1� $ � !0� $ �  1
�+  $ �  2�+  $ B  3�+  $ L  4�+  $ V  ON
R+� � ; \   $ �  OFFR+� � ; \ % � �CLIT
� 8� � � F � � �� � P � l  %   �LIT1 � 8�
 � � F � � � � �  I � � � l  % ) GLITERAL
R+� /  �1 �   6!/  !d 6!   !\ & t  0<� �
  ��$�� l  & ~  0=� �   ��P�& �  UWITHIN�
 �  S � � E$� �%� � E&� �'��l� ' �  <W �
�$� �%�  I � � � �%q   0�� E$� �%l� ' Q
U<  � �$� �%�  I � � � � E$� �%� l� l� (
�  >R+� U \ ( )  0>R+_ � \ ( 7  0<>R+� �
\ ( f  U>R+�   \ ( v  =R+I � \ ( E  D0=R+
  � \ ( S  D=R+� � Y \ ( �  D<R+  � I �
 - J J B   ~   \ R+9 �   � � \ ) �  MINR+
� - � \ ) E  MAXR+� U � \ ) W   IBR+\!" \
 ; W! QUERYR+}!  pW?Q!" o!; �!� D!� \ < �
! SCANR+P � �   � J   I �   G � # � B ��9
 \ <  " SKIPR+P � �   � J   I �   G � # �
 B ��9 \ < ;" /STRINGR+�     � � z I \ Ia
� I{� IB� )I[�  �`= J" CAPITAL�"�  �"� l
  > �" CAPITALIZED"� �$� �%�$�&�D&P � l

\ *** Block No. 140, Hexblock 8c

   \ : Q  PADR+X   b� \ : �  ALLOTR+L [ \
 : �  ,R+X ; F � \ :  ! C,R+X � � � \ :
!�COMPILER+� � a P "  !\ ; ,! #TIB.*  ; h
! >TIB.*`!savesystem c16neu

        ; u! >IN.*  ; �! BLK.*  ; �! SPAN
.*  ; J! T  d B ��J \ R+L    1 � \ n �* N
AME>R+� S*� J    1 �   " \ n �* >BODYR+a
\ n  + .NAMER+} �   � �(�   �$ |L    1 #?
B   �$ ???�4\ o  + CREATE:R+A)�'�," D,; �
0� \ o h+ :R+r+�(� 8� � � F � � � � �  I
� �E � l  o H+A;R+� � 6!\ 0�'\ o �+ CONS
TANTR+A) !�(� 8� � �  ��)�'lL 7 �  CMOVE>
� �  S  �%E'�' �%E)�)�%_$ � ��(�&�P�F'F)F
%P� l  7 �  MOVER+P �   �   � � d � D \
8 %  PLACER+� P   � # � , � \ 8 f  COUNTN
 � �$ I � � �%I � � 8� � � F lT 8 D  ERAS
ER+� � \ 9 �  FILL� �  S ��$�'� �(HP��)JP
��&� �(HJP�� l  : �  HERER+L "  �," "  !
$J � �    � � �3 invalid nameX ~'; # � �)
^)" �   � ^)[ �  ) !�(   Z' )L ; B   &)�
�'�  !�(l(3*� �(� �)�  I � � � � �&� �'
&P l� �&� �%�&� �$ %P l  �$ I �$� �%�$h8)
 E$�$� �%H) � �$h�$�$H�%�$E(P��%E)P�lc n
�) >NAMER+% " � �   � Z I � 1*} �   z ~

\ *** Block No. 141, Hexblock 8d

  +� P = � � �   | � � G   � �   _ � �
�   � � G 9 \ 5 X  2/  �  � J� � Jl  6
 /MODR+P   � � \ 6 /  /R+6 J \ 6 d  MODR+
6 � \ 6 r  */MODR+P � � � \ 6 B  */R+J J
\ 6 X  U/MODR+� � G \ 6 �  UD/MODR+P �
G � � P G � \ 7 �  CMOVEF �  S �D$P F%  �
 l  �(�&HP  � � �  � I � �Q � �  E h�E l
 R+� ~'" �*; \ j �(EDOES>R+6!�(  l !6!@(\
 R+�   �1   �I I \ R+X   �1   �I �   � �
# X � I # � � ~'[ � � \ k �( ?HEAD.*  k v
) |R+^)" S � ^); \ l D) WARNING.*  R+�)"
S ~'" �," 9.J �   �4~'"  +�$ exists �>\ l
 Z) CREATER+X D!"  !  %� l  3 �  M*R+� �
� P �   _ � � � �   _ � � P � � �   � \ 3
 �  *R+� � \ 3    2*5 �  � � *� l  R+� �3
 division overflow\ 4 .  UM/MODI � �)� �(
�  I � � � � �%� �$H� �'H� �&�  F*8�%�)��
$�(� &*� �$�%&'&&&%&$JP� F$F%�  � b \ �&
� H�%� H�$� � �'l  5 ^  M/MODR  RSIVER+�'
\ R+�'�   | J   � � � \ h H' IMMEDIATER+
 @Z'\ h �' RESTRICTR+  �Z'\ i  ( CLEARSTA
CK.(� � � H� � � l  i  ( HALLOTR+� " � I
� ; a �   I � � ; F � � I , ,(� ; \ i @(
HEAPR+� " z \ i Y( HEAP?R+�(} � \ R+� X �
 I � i(�(� D �(� I ~'[ �'\ � 8� � � F �

\ *** Block No. 142, Hexblock 8e

  B ��\ 0 � FREPEATR+F � 6!B Q \ 0 � EUNT
ILR+F � 6!� Q \ 1   BDOR+6!I � P \ 1   C?
DOR+6!| � P \ 1 1 DLOOPR+P � 6!J 6!� � \
1 e E+LOOPR+P � 6!� 6!� � \ 1 ` �LEAVER+�
 � � � " � P \ 2 |  UM*� � �$� �%H�&�'�
'&&&%&$�  � E'�'H� �E&�&� �%P �$JP|�'� H�
&� � �$� �  2� L �&;  &� � P � �   �% &�%
  -@ �   9 � P �% &�%o&�   � ; �% &�%J%�
 &�%�&�%)&�%J%� � �� &�&�  & &� �%)&�%B T
�\ g B& 'NUMBER?I0L&g e' NUMBERR+p'} � �3
 ?� �     \ h v' LAST.*  R+~'" } \ h W' H
IDER+�'�   � " �," ; \ h �' REVEALR+�'�
 � �," ; \ h �'IRECU  ER+X I  !\ . }  ?PA
IRSR+I �3 unstructured\ I   h��l  h� �� 8
� � � F �� � H� l  / �  CASE?b �  S �$A P
 �%Q P l� �l  0 8 BIFR+6!� � � \ 0 \ DTHE
NR+= � � � \ 0 O DELSER+� � 6!B � � � � \
 0 � EBEGINR+U F \ 0 � EWHILER+F � F 6!�
� / ��H \ R+� � / ��I �   � �   VERTR+# L
 J%�   �%B ��G \ R+�&" � \ R+L � �&[ \ R+
G L \ f M% DPL.*��R+�   9 ~ � 9 � \ R+�
 9 � � �   �   �  &" # } S � � \ R+  &@ �
      � d   $@ �      � d   H@ �      � d
   %@ �   F � d � \ R+  ,� I �   .I   \ R
+ &" � I S �  &[ \ .*  g
& NUMBER?R+�

\ *** Block No. 143, Hexblock 8f

  � � l  + B �(+LOOP�  � A � � Q � Jq  �
 I � � � ( Dl  , � �I' � � 8� � � F  � HH
Q � �� HHQ � � l  , ! �Js � PR- m �BRANCH
D  � A �$� Q � �$� l  - y �?BRANCH� �
�  I � � � (�Kld . Z  >MARKR+X �  !\ . �
 >RESOLVER+X � I � ; \ . �  <MARKR+X \ .
M  <RESOLV  �#~ \ d L$b.(R+  )�##?\ d }$a
\R+�!"  6h #  6$ �!; \ d �$b\\R+�c�!; \ d
  % \NEEDSR+ $�.J �   �$\ d  % HEXR+   �
; \ d 7% DECIMALR+   � ; \ e j% DIGIT?R+
 0I �    [ �     �I �    [ �   � " � [ }
S � � \ e A% ACCUMULATER+� P � � " � �
� " � � � \ e �% CON
 UMAXR+�   � \ ) �
 UMINR+� [ � \ ) �  EXTENDR+� � \ )    DA
BSR+  �   � \ ) "  ABSR+  �   _ \ R+9 � a
 � P   P � P P \ * 7 �(DOR+� I i \ * C �(
?DOR+� I } �   i � � " � P � \ * U  BOUND
SR+� � � \ * � �ENDLOOP� � l  + � �(LOOPL
  � A � � � I � � l  � � � ��   DR+�#�"\
b Q# PARSER+P �#�!" T"� � �  "P � I � � l
 I �![ \ b �# NAMER+?4X#B"d \ c  $ STATE.
*  c )$eASCIIR+?4X## J 1$" �   ^ \ c 7$ ,
"R+  "�#X � # � n \ c w$�"LITR+� � | L �
P P \ c Q$�("R+X$\ c �$A"R+6!�$\$\ d �$�(
."R+X$L #?\ d �$B."R+6!�$\$\ d �$a(R+  )

\ *** Block No. 144, Hexblock 90

   H�$ �"�$lQ"�"�*� � �$ � ��  ��!E&�&��!
E'�'8�$�!�$�%�!�%�
� ��!� ��!lY#� �$ %�
=�&Q P �&P �'�$P F%F$l$#�&�(�'�)�&Q  �&P
�'�$P F%F$(� �*�$ %P�8� �&� ��!H�'� ��! �
 E � � � � � � �$H� � � �%��*�$�(HF* �� �
$� l  b �" SOURCER+D!" } �   �9�cd }!o!"
\ b �# WOR   F � � � H� � � l  o �+ VARIA
BLER+A)F � \ p |+ UALLOTR+� 0 " �   �[ �3

Userarea full0 " � 0 [ \ p �+ USERR+A)F
�+ !�(� 8� � � F � �  E � �HE � � l  p ),
 ALIASR+A)~'" � J    1 �   / ��� B      Z
'S*; \ q ], VP.*  |-K-K-ajaj    q �, CURR
ENT.*K-q �, CONTEXTR  +� � \ B �4 HOLDR+�
 �4[ �4" � \ B �4 <#R+�4�4; \ B W4 #>R+~
�4" �4� I \ B �4 SIGNR+� �     -E4\ B �4
#R+� " _      � U �     ��   0� E4\ B  5
#SR+ 5� Y � ��\ C @5 D.RR+z | ) |4e5   5�
4  � } � I _4#?\ C u5 .RR+�     [5\ C 5
U.RR+� � [5\ C �5 D.R+� [5�4\   C _5 .R+
 �5\ C �5 U.R+� �5\ D C5 .SR+; � " � I
   � |   % " H5F � � \ D R5 C/L�+) D �5 L
/S�+  D  6 LISTR+�3; �$ Scr �3" �  dx H5�
$ Dr `d�5 6� I . �>�   �  ?% F �5�4�3" �9
%  6$ �  6G q4#?J �  ?\ E  6 PAUSE  E Z6
LOCKR+� " } I �   � d � " �   �6B ��} �

\ *** Block No. 145, Hexblock 91

  4�>D!" } �   �3; �!" �3; 33\ _ �3�(ABOR
T"R+X$� �   P ,(�   � d � \ R+X$� �     �
 d � \ _ V3FABORT"R+6!�3\$\ _  4FERROR"R+
6!�3\$\ ` %4 BL�+  ` :4 -TRAILINGs4� S �
�& � E%�'_$ � ��&I � HP �%�h�%l  �P�F'F%
�l  A e4 SPACER+?4
?\ A �4 SPACESR+� |
 �4J � \ R  ; \ E �6 UNLOCKR+� �6� \ H8�
� H� � �l� � � � H� � � � � � � �  I � �
� � l� F �6 FILE<, F  7 PREV.*�{.*  F  7
B/BUF�+  � �(Y" P H@ P�`:7� � �$ � ��  �
E&�&H� E'�'� 7�(� 7�) )7P �  I � � � � �
 E(� �)I � lf �(�*�)�+�*�(� �*�) (P l   )
7P�(�*� �(�*� 7�(�   " � a I   \ ] �2 DE
PTHR+; � " � I   \ R+1$" �   �$  compilin
gd �$  ok\ ^ G2 (QUITR+�1 ?�!�/2B ��\ ^
 3 'QUITI0 3^  3 QUITR+B " B 0&3\ ^ ,3 S
TANDARDI/OR+/ * � Z D \ ^ c3 'ABORTI0� ^
A3 ABORTR+,(C J3q333\ _ P3 SCR.*  _ �3 R#
.*  _ �3 (ERRORR+q3�4X  +L #?�  7�(�(� 7�
)� 7lC7J  7 (DISKERRR+�$ error !  r to re
try �?�   rI �   RI   � �3 aborted\ J A7
DISKERRI0L7J  8 R/WI00LR+� z " � � j a �
" # � 3    2�  2q3� z � a " F � " �  8�
 �$ write  8B {�  �� t #   � \ R+a � � t
� \ R+� {8   2�  2q3P � Z " � �      � z

\ *** Block No. 146, Hexblock 92

   � E H� � � � l   � � �3 stack empty\ \
 �1 .STATUSI0Ct.*� � ; \ \ �1�PUSHR+� � �
 P " P �1P P \ \ �1 LOADR+} � S D! 2D!; �
! 2�!� �1�/\ ]  2 +LOADR+D!" � #2\ ] c2 T
HRUR+# � I   % #2J � \ ] y2 +THRUR+# � I
  % k2J � \ ] V2c-->R+� D![ �!� �1\ ] �2
RDEPTHR+B    �  8�   �$ read  8B Y�� \ R+
 7� " �   " � a " � I � �� 7�6� !8\ R+a P
 �   ; Z " �   a ; � t �  7@6\ R+ 7" � �
  � z " � � ��\ R+ 7" � " � � ��z " � \ L
  8 CORE?R+87~ � \ M f9 (BUFFERR+87H8�8B
��\ M z9 (BLOCKR+87H8�8�8B ��\ �9� � hH�
l  M T9 BUFFERR+�9D9  R+A)/ �0 !�(� � hH�
 � H� � l  z �0 (ISR+� � a P " ; \ R+" /
I/" � I � / �/" I   � �3 not deferred\ z
}0bISR+;/� �0 +1$" �   6!�0 !d ; \ .* R+O
2   - �3 tight stacke1J � �   � e1� � �3
dictionary full�$ still full \ [ "1 ?STAC
K�1� 8� � H� � P �  � h1\ �g1�  \ M �9 BL
OCKR+�9}9\ N �9 UPDATER+  � 7" z # � \ N
A9 SAVE-BUFFERSR+ 7�6 9} �   !8B �� 7@6\
N }9
EMPTY-BUFFERSR+ 7�6 7" } �   � {8B �
� 7@6\ N  : FLUSHR+�9 :\ R+� �9n9�    7"
{8,9�   �9Z " � � �9� � ; J9\ R+�9P �   �
 � [ P �   � 1 � $     � � � |   � / ���

\ *** Block No. 147, Hexblock 93

  / NOTFOUNDI0/x �/
NO.EXTENSIONSR+�3 Ha
eh?\ x O/ INTERPRETR+�/\  R+�1 $�.} �   �
 1 �   � �/�3 compile only�/S p'� �   I/�
/\ R+�1 $�.} �   < �   � �/ !�/�/S p'} �
  < �   � ^ ^ B   I/�/\ y �/a[R+/  0�0�/1
$� \ y {0 ]R+/ ;0�0�/1$� \ R+� �3 Crash\
z �0 DEFER   � h:J � B   � � |   � h:� �
� J � �9~ \ O 8: COPYR+� V:\ O T: CONVEYR
+� # F � I � < � �3 neinV:\ P �: LIMIT�+
�P
; FIRST.*�{P  ; ALLOTBUFFERR+#;" B "
I %7a   S %7_ #;[ #;" � {8 7" � ;  7; \ P
 ); FREEBUFFERR+#;"  ;%7I   � . #;" !8 7�
 " #;" I �   " B ��#  $� � 8� � � F �&  H
 0 �i��H��   ��$�� � l  v 1. FINDR+D,� "
� � " I �   � | " 9.�   J �.d � �,a [ �
 � � B ~�J � \ v �. 'R+ $�.� �3 Haeh?\ v
7/I[COMPILE]R+;/ !\ v o/C[']R+;/^ \ v E/
NULLSTRING?R+� J � � �   J \ H � I � H� I
 � � l  w U/ >INTERPRET�/ 0x �  ;" " � ;
%7#;[ \ P K; ALL-BUFFERSR+#;" 7;#;" I � �
�\ R+J    1 \ R+�*| #   � �(  \ R+�(% " P
 � " } � ^ � P Z I P � " P � G �     �
a �*  1 � .   �(� Z�  a |;�   �   a �;�
   a S*a � B ��9 B ��\ M<� � �$ � ��  � I
 �*H� I �+� �$�,�$�- ,�5�,E*�-�+� �,E&�-

\ *** Block No. 148, Hexblock 94


" �,; \ R+" � �* +\ s �- ORDERR+R,I   %
 K-/ ��� � F _4�,K-\ s Y- WORDSR+D," " �
�>� 1 �   �>� a  +�4B ��� \ t  . (FIND;.�
 � �$ � ��&) �(� �$�H�$�%�$ $P � � l� H�$
) E(P� � E$�)� E%�*_(�&Q)PK�P�� �*� ��)�
�� l� �.� �$� �%�$�&) 8E$�$� �%�&) P �$�
�%lB.�$� �  �'l�<�(E,�)�-� �,�$�,�$lG<�,�
$�-�%l�<l� R+% " } �   � P Z I K<� B ��\
R+} # � " } I � ( � " � X � �   � " # " �
 ; G B   " B N�~ \ R+% K<R,I   � % " z �
�   / K-% ; / ��� � � �," z � �   / K-�,;
 \ S �;
CUSTOM-REMOVEI0� R+� �<'=M<{=�(�
I i(L ; � ~'; \ T K=  +�,� " � a \ R+�,a
D,\ q �, ALSOR+�,"    - �3 Vocabulary sta
ck fullD," F �,[ D,; \ q ~, TOSSR+/ ���,[
 \ r  - VOCABULARYR+A)�  !�  !X % "  !% ;
 �(l@(D,; \ r /- FORTHv-,U,U  r A- ONLY�-
!@!@O-�(l@(� �,; D,; �,\ r S- ONLYFORTHR+
Z-I-�,�-\ s �- DEFINITIONSR+D,  mo�k TAPE
INIT� 0d�k FLOPPY ?�$ Type 'help' to get
help ?�$ Type '64kb' to use 64kb\ R+/  �/
  �/  @�kI-�$ CODE   P 3kI-�$ EDITOR   P
3kI-�$ DEBUG  /P 3kI-�$ HELP   � 3kI-�$ T
APEINIT   Z 3k/ � �0O@/ Xl�0�@�k EDITOR�k
 EDIBOARD� �3; � �3; e>/  Z/ �{/  ��k\

\ *** Block No. 149, Hexblock 95

   ???\ R+�  ;I F � �    � " I 1 P � �
 � " I 1 �   � � � d /  ; +; �    � ; �
  � � # ; �    � ;  a\ R+X$B"�.�   � B
L #?�$  unsatisfied33\ R+6!�k\$\   3j 64K
BR+/ 3 " /  �I } �    ?H5�$ too smalld  ;
/  �I �   /  �/  �/  ��k\   #l C16DEMOR+
?�$ c16-De  ~j SP�+  | �j IP�+  | �j N�+$
 | �j PUTA�+  | �j W�+  | �j SETUP�+S | @
j NEXT�+  | Nj XYNEXT�+ha| {j POPTWO�+�
| �j POP�+� R+ ?B"� �.J | � �   �$ not �$
 found: L #?\ .*  R+F �  k�   � � � d � /
k" I �   @:�$  Insert #� �5�?� � /k; � �$
  scr#� �5 ?#2 k� �3  � �  � ��?�x`� +i C
64INIT�i `ilha          ��������� �i C64F
KEYSMi� J0 ��i�] lOilha{ @ic(64R+ $L � �3
 C) missing" / C)I � ��\ { �ibC)R+\ {  jc
(16R+\ {  j FORTH-83R+\ | "j ASSEMBLERv-
D D�-|    PUSHA�+  | ij PUSH0A�+  | wj PU
SH�+  | Fj RP�+  | Sj UP�+  |   INDEXR+#
� I !  ?% F �5% �9#   %#?�>�   � J � \ �
�h FINDEXR+Cg�   ~ d # � I 1  ?% F �5� �
% 3 3 �f&gP #   %#?� �>  �   � J � �g\ �
�h INK-POT.*��  ��  ��  �  i INIT-SYSTEM;
i���lha�>��vi�xi�ih�\h��  h� � l���?�@X�>
��i����a��� �� ��� i� �� i� �� i�@ ���@

\ *** Block No. 150, Hexblock 96

  g�e�d d   ze�$ u2:13,0,L �e�f�e�d�6yf\
� ]g DISKOPENR+ d
Pe  #�e�dyf\ � �g DIS
KCLOSER+ d
�e�d\ � Yg 1541R/WR+� �3 no
filez  d6 �  d; P [ �   �5�$ beyond capac
ityJ d Cg�   � J d � � 3 3 Z � I . � � %
  �   �f&gB   �fKgP  g� � � �   � J � z ~
 �g\ � �g   v R+� �f  �      6 d P � � �f
  �   �fI    6    � d � �f  �   �fI    6
   � d �fI    6    � \ R+�f# � \ R+�  2t%
� |4e5�   ,E4e5�4\ �+  � of READSECTORR+
d   ze�$ u1:13,0,L �e�f�e�d�6yfS  d
Ne
g7f�d� \ �  g WRITESECTORR+   d   ze�$ b-
p:13,0L �e�d d
ze   \ �e���  S �& Ld�&�
>� ���?��$ `���>� ���?��&��lha� }e BUSINR
+�d�6�e\ � Fe BUS!�e� �>� ���?�l� � Ze BU
STYPER+� |   % J �eJ � �6\ � �e BUS@ f�>�
 ���?�l  �  f BUSINPUTR+� |    f% � J � �
6\ � ,f DERROR?R+ d   Ne f�   0I �
? f
� �aI � ���  ?� �d\ �+E �+� �+  FF�d�>� L
��?�� �  � �d@6\ � �  � �d 7@6� �3 no dev
ice\ �����>� ���?��`�>� ���?��>� ���?����
 HHl�d`�d�  Ld�  I � � � l�d� �d ?DEVICER
+�d�6�d\ $e���  S �& Ld�&�>� ���?��$ `�>�
 ���?��&��lha�  e BUSOUTR+�d�6"e\ � qe BU
SOPENR+  �  ze\ � Fe BUSCLOSER+  �  ze�d

\ *** Block No. 151, Hexblock 97

   Bc C64TYPE_c�  S � D$� �& �b� �.�>� l�
�?�Hl�cl�b� �c DISPLAY�>�b c�c c5chcKc\ �
c�>�lr�� Jc B/BLK�+  � �c BLK/DRV�+� � �c
 (DRV.*  R+ d"    � \ �  d DRIVER+ d$ Z ;
 \ � (d >DRIVER+ d$ � Z " I \ � >d DRV?R+
Z " �  dh \ � yd DRVINITR+� \ � Pd I/O.*
 � �d BUSO  ��?��  I � � � �K�O�  � �6\ I
�� I `I� I@` `� �b PRINTABLE?Vb�  �b� J�
l  � Gb C64EMIT�b�  �b� �.l�b� �b C64CRR+
�a�b\ � �b C64DELR+  ��b�4  ��b\ �  c C64
PAGER+  ��b\ � +c C64ATjc�  S �&_$ �>� ��
�?�lha� @c C64AT?Mc� 8� � � F �� 8�>� ���
?�@(�� �(h�� � Hl  �
��II � � �l  � �a
CUROFF�a��� ��
�l  � �a C64KEYR+�a�6[a� �
��aUa\ � Ca #BS�+  � �a #CR�+
 � �a C64DE
CODER+�a@ �   � �   .?G d �a@ �   � Q!; d
 P � �   � � �
?# \ � �a C64EXPECTR+Q!;
� � Q!"   �   �?I?B ��~ �4\ � @b KEYBOARD
�?La[a blb\ � Pb CON!�b� �>� l    3�0(3Zd
�@/ . "   ; / � �0L3X3\ � �9 �  � � �  I
� �! I � � � � H� � � � � H� � � � �� � `
Z �@ COLD a `i �  I �$�! I �%� �  �$HP� �
@ � 9iQ@\ Z �@ RESTART9a `i �@ � 9i�@\ �
� l  � -a C64KEY?]a��
] � ��hl  � qa GETK
EYWa�>� }�?�I�P � l  � La CURON�a�J EH�

\ *** Block No. 152, Hexblock 98

  @(  ; \ V �? KEY~? V �? KEY?~? V �? DEC
ODE~? V @? EXPECT~? W    SEALR+� / Z- +;
\ W |?$ONLYZ-W �?%FORTHI-W �?%WORDS .W  @
$ALSO�,W  @+DEFINITIONS�-R+% " � � " � Z
I ; " } � � ��\ R+�  7;  ;#;; H;\ X N? 'C
OLDI0� R+1@q@�-M@:?  L #? ?�@\ X E@ 'REST
ARTI0XlR+/
R+�?�   �>�>� \ U �> ?CRR+J?
6   I [ �    ?\ R+A)�  !a �(l@(J � " � �
\ V �> OUTPUT:R+r+�(l@(� ; \ V �> EMITZ>
V  ? CRZ> V  ? TYPEZ> V  ? DELZ> V (? PAG
EZ> V 3? ATZ> V ?? AT?Z> V i? ROWR+o?� \
V t? COLR+o?J \ R+A)�  !a �(l@(J   " � �
\ V D? INPUT:R+r+�(l   CLEARR+X � } =L ;
 \ T �= (FORGETR+� �(�3 is symbol�;=\ T
�= FORGETR+;/� / $ "   �3 protected�*� �(
�   �*B   � � E=\ T = EMPTYR+/ $ " } =/
 2 " 0 ; \ U  > SAVER+X } =% " � � � " �
 � ; " } � � ��} � /   D \ U >> BYER+�9�c
\ R+�?P I �   � 9 \ U W> STOP?   �j END-C
ODER+D,� " D,; \   �m INDEX.*       � �

 ����    �����   ��,.*    �m MODE:R+A) !�
(l@(J Im; \   Om .Am   �m #m m   �m ,X
m    n ,Ym    n X)m    n )Ym    n )m
 R+�   Im"      Im; � Im"    1 } �   � I
  � � J � � # " 1 � \   *n CPUR+A) !�(l@

\ *** Block No. 153, Hexblock 99

   �
?# d � \ "  ] DIGITS�?La[a&]lb\ R+V
v" � I   �a�bJ � � |v" � I   -x  J � � S
|v�u�w� PwK\� \ R+#?  <
?�vG J?I _4\ R+
 2 vE[o?~z� � d?�$ replace with: o?|v�uC]
� � d?�$ >     search: o?Vv�uC]� F � d?Fv
" P �5� d?X # P {]W?Q!" } �   X | � _'� F
v; d?Fv" P    &\\ R+`\�3" �9�w�   �z� �3"
 �9cwJ9     \ R+K\     \ R+�\     \ R+�3"
 �9
w�v�  v:\� \ R+K\� � �3[ �\\ R+K\� �
�3[ �\\ R+K\� �v" � �[J [ � �   _ �3[ �\\
 R+K\� �v" �3" �v; �3; �\\ " �z DIGDECODE
R+�a@ �   � �   .?G d �a@ �   � Q!; d �"�
 J%�   � P � �   � �  Aw� �v3 D Aw�v3   �
� \ R+� Aw�v3 D \ R+�9� " \ R+�a�6�?� ���
a\ R+�3" Z " �  d� � \ R+o?E[~z� � d?�[�$
 Scr # �5�$ Drv �5�3" �[� �   �$ not �$ u
pdated� � d?/ �zL #?F _4/ �zL    1 #?�zd?
�[~[� \ R+o?� �v# $ � �3; \ R+�3" � �v# x
 �vI I �cG K �v# 6 � d?\ R+ v    R+�v� �
\   �v RVSONR+   �b\   Vz RVSOFFR+  ��b\
  �z ***ULTRAFORTH83***    �zrFORTH-GESEL
LSCHAFTR+ %\   �v STAMP$.*
   R+|z# L Aw�v� � I � Pw� \   Sz GETSTAM
PR+   2{b|z�  ?�$ your stamp: ~z   _4z?
 d?|za    W?�zQ!" |z# � \ R+|zJ S  [\ R+

\ *** Block No. 154, Hexblock 9a

  �  y\ R+�x� S    �b\ R+Jv�u� # Pv" �wK
[ � S �wJ Jv�u� � � Jva [ \ R+�y} S �x\ R
+�y} S Qy\ R+Jva " � } S -x� S � Jva [ Jv
�u� J �w� \ R+Pv�u� �w[ � S KwPv�u� �vD �
vPva [ \ R+�y} S Tx\ R+�y} S %y\ R+�v_ Pv
a [ Pv�u� Kw�vD \ R+Pva " � } S oy� S .z\
 R+�v� � \   S !x\ R+Bv" � z?�v� [ 1 � S
   �b\ R+ x� S    �b\ R+Aw�vq4J �vG K �v6
 � d?� \ R+�    � I   � �x� �   � J � \ R
+   � I     ��bJ � � \ R+z?� d? v�v� Tx\
R+Kw�v?4� � \ R+�w�vJ?I ?4� � \ R+Kw� �v�
 � Aw/ @ � � P � I D � �v?4� � \ R+�w� }
S Kw� �v� Aw�v� � I   vRw�  S �D$P l(v�(
@v�&HP�w� S �&�> �'� �'�$ @vQ&� ��l  � �
 �vJP�l  R+; �v3 I \ Cw�h�> l  Mw�JI(��
�'EHh�II l  �w �JEHh�II l  R+Aw/ @ � �vq4
J � Bv"   \ R+�wAw�v� G I Bv" � 1 \ R+�vJ
 �b� \ R+ x} S � Kw�v� G J ?4I � 1 �w� 1
� S   ��b\ R+ x} S �v" �   -x}   zv SCR>C
BM~v�  /v� l    Rv EDITORv-�C�Cej�+( �+
�+�      SHADOW.*u .*  .*  .*u .*��.*  .*
iV  .*�V  .*  �U.*  !V�+H �+J �+ ��+; �+
��$ I)�$� �%�& I(�&� �'` w� S �&�> �'� �'
�$ @v�&� � �vJP�; �  �  �  �  �P�l(vew�
S �&�> �'� � �& /v�$H@(��J� � �$ �vlrwl(

\ *** Block No. 155, Hexblock 9b

   �&A*� � �$ � ��$P F%F$�&P �'l�t  t
2!�u� S � � �$� �� l�   �u 2@�u� �$� �%�
8� � � F � �$� � �lha  �u 2VARIABLER+A)Z
� \   Zu 2CONSTANTR+A) ! !�(l@(�u\   �u U
NLINKR+� � / � �u\ � � l  �*)? *$*   �P
@`�*)I �
I@� ) $*   @`�.`   v CBM>SCRFv�
  @v� l     +X    � /  �[ �3 not here/ >�
�p\   Nt RAMR+/ ?��p\   �t SYSR+Tt/q�t\ .
 zt .BLKR+D!" } �   �$  Blk H5�>\   �t (S
EARCH�t� � �$ � ��( )�I�$ %�C�&A*� �$P F%
F$�&P �'l�t� �$ � � ��&P �'�*P �+�$P F%F$
�(P F)F(�( )P �  I � � � � �'� �&�� �l� �
$ %P �  I � � � � l�  zs WDECR+� _p8r�q�
# �p�q�p\   Ws ;C:R+� /q�m�0� ~'; � \   N
l ASSEMBLERR+?j�m\   �se;CODER+ )/ ��� �+
/ ��� �s\   Hs CODER+A)X � � ; �s\   �s >
LABELR+X H)A)�'�  !Z i(�(� 1 i(X Z I �(Z
D �(~'" L    1 � ; L ; �(l@(" 1$" �   ^ \
    t LABELR+X  t�s\   �s ROMR   NOTR+
n \   Wr BEQR+drq\   �r BMIR+[rq\   �r
BNER+8rq\   �r BPLR+orq\   �r BCCR+"rq
\   Hr BVCR+Frq\   Xr BCSR+-rq\   �r BV
SR+Qrq\   �r 2INCR+� _p�nF �m+p� �p"r�q�
 # �p�q\    s 2DECR+� _pboF �mYp� �p-r�q�
 # �p�q\   1s WINCR+� �p8r�q� # �p�q\

\ *** Block No. 156, Hexblock 9c

  q ?]R+ !X # I nq !\   Zq ?[R+ !X �  !\
  �q ?[[R+�q� \   _q ]?R+X � J �   � ; B
  � # I nq� � \   �q ][R+X # � <q� X � #
I nq� � \   }q ]]R+<q\    r ]]?R+<q�q\

r CS�+�    r CC�+�   (r 0=�+P   3r 0<>�+
�   >r 0<�+    jr 0>=�+0   ur VS�+p   Ar
VC�+P   Lr     Sp STA�o�L   �p ASL�o


�p DEC�oA    �p INC�o�    �p LSR�oa

  �p
 ROL�o!

  Ap ROR�oA

  Np STX�o�    {p C
PX�o��   �p CPY�o@�   �p LDX�o��    q LDY
�o��    q STY�o��    q JSR�o �   )q JMP�o
@��  6q BIT�o � R+� =   [ �3
out of rang
e \   cq [[R+X \   M
o TXAn�  ~o TXSn�
  �o TYAn�  �o M/CPUR+A) ! !�(l@(� # "
 �1 �      Im[ � /  �1 1n1n�   �m� �3 inv
alidJ Im" �m� J �  !Im"    1 �   Im"    1
    U �    !B    !�m\   �o ADC�o`N   %p A
ND�o N   2p CMP�o@N   ?p EOR�o@N   lp LDA
�o�N   yp ORA�o N   Fp SBC�o�N  (J  !�m\
  Qn BRKn   �n CLCn   �n CLDnX  �n CLI
nx  �n CLVn�  �n DEXnJ  Cn DEYn�  Nn
INXn�  Yn INYnH  �n NOPn�  �n PHAnh
�n PHPn    o PLAnH   o PLPn(   o RTIn
@  &o RTSn`  1o SECn8  <o SEDn�  go SE
InX  ro TAXn�  ]o TAYn�  Ho TSXn�  S

\ *** Block No. 157, Hexblock 9d

!  �5{b� d?Vva " �v� J?I W?Q!" } �   Vv;
d?Vv�uC]� d?|va " �v� J?I W?Q!" } �   |v;
 d?|v�uC]�z~[d?\ R+�\� Vv�u�3" �3" �9� �c
�3" I �t� �   � B   �3" �9I �3; :\\ R+K\�
 X]B^�3" � ' �?�   rI �   �]} �   J d P I
 } S B S��[J Fv" I �>� 1 } �   � �   �\�
B   L\� B !  ���*_+`� � h��)��?�l    �M C
SAVEDN�   N�, X�liN  zN CLOAD}N�   N�  U�
 h�h�h� � 8� � � F H� HH� H(liN  SN .ERR�
N� 0 �J�>� t��H�$ ) R�( �?�lha  �N DERR
?R+� �    ?� H5�N�$ error�   �1    I �  d
" � - 1 �   yf   d" � }  d; \ .*� � ; \
 RN�STORER+� � � P "! + ;� CH  \    M RDN
EWR+bM� bM� � /   I [ �3 range!� �H� ;  M
� I     I; (M� � IL\ R+�   �$ error \   p
M RDCHECKR+�LpI� " � � �c   � � � �M� �
?H5� " � P �5�4� + � a "  d� � �5�$ :F �5
� Z �    #?�>S B ���II �M\  S �>��� ��� �
��$8� � d� J� d�$_%�  ���(_)�&! 3 no file
� SJ/J�cI �   � �   �IB   �I� �cD B $ � �
   lJ J�I�c�K�KB   � �I� /JhK L� \   'L .
RDR+�H" H5pI� �IH5   #IH5TIL #?\   �L ID!
R+   TI� TIL ?4�      TIP � n �$ RD.L TI#
 � D \   CL ID"R+  "�#IL\   �L RDUSER+�H;
 \    M RDDELR+pI" � F  I; Z  I; �I� \ R

\ *** Block No. 158, Hexblock 9e

! DjK  K�(  )��� �&� �H8�E&�&� �'lUK J�
&�&P �'�(P �)F$PNF%PJl0K  ?K COMPRESS�K
K�(I P �P J��&�&P �'��lLK��0
h��&�&P �'�
H LJ�&�&P �'�(P �)F$PBF%P���0 ��&�&P �'l0
KR+�I| � G � J   [ �   � [ � ��# � I  J\
 R+| � �c  I ?4� \   �K RAMR/WR+F � �J�
 �gB x � �! ETER+YI� " | � YI�I� I D _ �I
\   cJ SEARCHR+pI� " � � " �   � a " I �
��EIDI; \ R+ d  \   IH BINARYR+� Z " � �J
S � �9� J9lJ J�c J\ I�  `I@� I� I�`) `I`
� `�`  �J C>7�J�  LJl    �J 7>C K�  Jl
 �  S �&�*�'�+���$P �%P HH� l  l/K�%`8�&
�*h�'�+l    �J EXPAN! /I RDR+5I� �3 no Ra
mdisk\ R+�HF  I; \   kI ADRR+F #I\   SI D
ATAR+YIZ � \ R+Z #I\   �I BEHINDR+�IZ � \
 R+Z  I[ \   �I BLK#R+    I\   �I IDR+
 I\ R+�I   #I�cI Z I [ �3 Ramdisk full\ R
+�IEI}I\ R+} � S DI" �Ia ; Z � � �I; �I�I
� \ R+YI" � � S Z I \   OI DEL! ! ? ?�$ A
ber ohne Handbuch ?�$ und die Hilfe der ?
�$ FORTH-Gesellschaft ?�$ bleibt FORTH ei
n ADVENTURE! ?\   &H MEMTOP�+ �  �H RAMDI
SKv-JJJJ D     (RD.*    }H PLEN�+1   �H A
DR>R+�H" I \   �H >ADRR+�H" � \    I ADR@
R+ I"  I\    I RD?R+�H" � � " �HI 1 \

\ *** Block No. 159, Hexblock 9f

! "    �5\ R+� J P �5\ R+  $J?I � } _4\ 6
 �F SR+;G�4xGZ _4� L #?� J � # DG\ 6 WG N
R+;GkGF _4� " �* +a DG\ 6 �G KR+;GkGa DG\
 7 �G DR+� � ;GP _4� � I   xG# J � Z _4z
#?DG\ 7 KG CR+� OG\ 7 �G BR+;GkG� " � �
  �5a DG\   $G HELPR+P �B ?�$ Probier' ru
hig weiter!  8" @ �    +"  Fd " / l@I �
 " P � d �* +�$ can't be DEBUGged33\ 5 �D
 NESTR+dD" "  F� <D� \ 5 �F UNNESTR+4D� 8
D� \ 5 �F ENDLOOPR+dD" Z � 4D; \ 5 GF%UNB
UGC 5 �F (DEBUGR+ F�D<D� @D� hD�  D�E\ 5
 D DEBUGR+;/�F\ 5  G TRACE'R+;/� �F� C \
R+�>� Z �5�$ :\ R+� !  <D� � 8D 24D 2� �
�DhD 2� hD[ P    EP    2�  2� � dD;  ?hD"
 _4� Z �5" �    �5�4�* +   J?I � } _4W51$
 2D! 2�! 2/ (3 2/ �/ 2o! 2}!o!" JDB  2� B
 ; / �D�0(333\ �E�E� � � �l� l  R+� " / L
+" @ �    +d / �?" @ �    +J   " � "  Fd
/ #?" @ �    +J � " � "  Fd / !  B � � D
\ 1    CPUSHR+� z � P � � # I � B n lDP P
 \ R+  r� {bTc�1�4�!�// ��� 9 \ 1 BD RANG
ER+8D� � 4D; # � " / \ I � ��n 8D; \ WD��
�bD�cD� � � � �  I � � � �2D� �3D� l  2.*
UD\ �  I � � � �bD��>DP � M6D� �7D�U� M:
D� �;D�Il9E�>D�bD�cD� �2D� �3D � <D" � "

\ *** Block No. 160, Hexblock a0

! �v�  ?d �a@ � < �v�  C� Q!" [ �   � Q!"
 � |   � � % J |v� � # J � � Q!; d � �v�
   �_� 5`� \ - @C EDIEXPECTR+O`Q!; � � Q!
"   �   �?I?B ��~ �4\ - �C EDIBOARD�?La[a
lCBC\ / VB TOOLSv- H H�v0 �t WCMPR+� _p�
ep� # _p# Yp\ .*  .*��.*��.*�.*�.*S�.*G
�.*� L � �!  �$ , saved   1 �   �$ , load
ing ?�3" �3" LA\ , �A LR+�3� �A\ , �B RR+
�3" �A\ , �B +LR+�3" � �B\ , �B VR+;/�*}
�   Z I " \ , �B VIEWR+@B} �   �BB   �$
f
rom keyboard\ ,R+�v" �vJ � \ , i` CURLINR
+   �b  j�b C   �b  k�b   �b C� I \ -  C
EDIDECODER+  �@ �   ! �/\ * 9A SHOWLOADR+
�3 2�3� �3 2/ �``; aA�`\ R+ i� � J �v� �
 # J �v� a J �v� \ R+Z �A  ��b�\� Bv� �?�
 �v� � �_� 5`} � ��� � d?%y� Bv� � �A� /
� � \ + AA EDITR+Ki�3; y[O`�A   � d?�[�$
Scr �5�$ Drv �5� F 1 � �   �$ not �$ chan
ged� Z 1 �   �9�    1    I �  !
 �v3 � �
Vva ; �v� � |va ; �v� � Jv; �v3 � Pv; Jva
 � Pva � / �zL P Vva "   D � Vv; / �zL
 1 P |va "   D � |v; \ R+� p`" I S t`\ �+
#$R+/ d `; �z�a\ R+D!" } � �   �`d �!" G
 �3; �z�a~z�3" � I �   �3; �\� � d?�1:\�a
� \ * R] (LOADR+�! 2�!; } � S D! 2D!; �1

\ *** Block No. 161, Hexblock a1

! ��� \ R+?$  @I \ .*     �
�    �����  �
���  �� ��      �.*�\L\|\�\�^ z�x�x`\K\�\
�\oy%yhz"z�z�[�y�yFy�x{x�xTx!x!x!x�x-x!xQ
y y y`zJzzx�_�  S _$�H�R_I�� E&P�� ���_h�
�_l  R+�v� �6  �� I   J � \ R+�v 2�  `�
`�  `�  `\ R+� � I �    `� \ (  [ (PAD.*
 R+� � p`;"  P  OP P \ R+� �2�   �  OI �
  � � ; B ��P \   ,O�(RESTORE"R+X$� �   P
 ,(� jO  � d � \   NOHRESTORE"R+6!ZO\$\
 �O DEVICE.*    �O COMMODORER+� �O; \   �
O FLOPPYR+   �O; \   VO BLOADR+�O" {NZNZO
 load\   �O BSAVER+�O" BNZNZO save\    P
N"R+  "�#\   &P SAVE" #/  P�L\ s 'N INFRO
NTR#/  PIL\ s <N COLOREDR#� �L�
� \ t rN
SPRCOLORSR#~L# � ~L� \ t JN SETSPRITER#|

P \N  SM  |
 M N  VLIL� AL�L\ ."�N."��."�
�."��R#  D} \ u �N HEADINGR#�N" \ u ON SE
THEADINGR#�N; \ u �N RIGHTR#�N" � I / H x
 �N; \ u �N LEFTR#�N" �
/ H x " "BK�Pw )Q
"TS QR#X L  .� I   _,#7 7\ R#6 9Q\ \ R#9Q
 Forth Gesellschaft e.V.\ R#9Q *** ultraF
ORTH-83 ***\ R#9Q (c) 1985/86/879Q!Bernd
Pennemann  Klaus Schleisiek9Q Georg Rehfe
ld  Dietrich Weineck9Q Claus Vogt\ R#9Q r
ainer mertins9Q antilopenstieg 6 79Q 200

\ *** Block No. 162, Hexblock a2

" 0  hamburg 54\ R#�7P I � ��\   qH .MESS
AGE1R#�_:7WQ 7�Q 79Q Das Kopieren und Ver
schenken9Q"dieses Programms ist ausdrueck
lich 79Q
* erlaubt ! * 79Q Jeglichen Miss
brauch zum9Q Zwecke der Bereicherung9Q we
rden wir nach besten Kraeften9Q verfolgen
 und verhi" ndern. 79Q Die Mitglieder der
yQ `8R\   hR .MESSAGE2R#:79Q Du hast jetz
t ein9Q arbeitsfaehiges System mit9Q Edit
or, Debugger und Assembler!9Q Nach Einleg
en einer formatierten9Q Diskette kannst D
u es mit9Q SAVESYSTEM <name> (z.B. FORTH)
9Q als Programmfile " abspeichern. 7WQ 79
Q Bezug und Mitgliedschaft in deryQ9Q ueb
er: 7�Q8R\   nS LINIENR#JF�H�H�I�G/ @ � I
 % / @ � I   %   Fq � �J  #� �   #� � \
 NT MOIRER#JF I�H�I�G/ @ � I   %   F/ ? %
 I � �JP � �   G� I   / ?   F% I � % �JF
� � \ � �T SHAPES."����uv�uv��" ��� �� ��
��u`�u`����� �� �� �� �� �� �� ��
  � �� u`%ux�Iv��v��v��v��v��v��v��v��v��
v��v�Iv%ux u` ��         �����u`�ux��v��v
��v��v�ux�u`��`��`��x��x��v��v��v��v���
       �����uv�uv�v� v  v  v  v  v  v  v
 v  v  v  v  v  v  �          ������v��v

\ *** Block No. 163, Hexblock a3

" ��v��v��v��v�uv�uv��v��v��v��v��v��v��v
��v���         ��
U INITR# H:7�HCI�H�I
 � I    U%   @$ �
% }LJ � {H�HVN   � I
% � � �H% �NJ �    � I   %  N% EM% VL�L%
0NJ � \ � zV YPOSR#�M� \ � MV XPOSR#�MJ
\
 � ~V DISTANCE�#  � �V 1+0-1R#� � � � � 3
 # 1 \ �  " W
FOLLOW-SPRITER#P   �V  G �V
�V�
� I  W�
/ x K   9M�.  TV  G TV� I  W�

� \M�.\ �  W
FOLLOW-CURSORR#P   �VJ7   $
   !�
� I  W�
  9M�.  TVz7   $   ;�
� I
W�
� \M�.\ � PW FOLLOWR#�.� �   .WB   �W\
 � DW KILLSPRITESR#� AL� \ � �W
SLIDE-SPR
ITESR#   � I   % MW%"  NODRAWR#�G:7\ v +P
"LT!Ov >P"RT Ov gP$SETH�Nv pP"PD}Ov [P"PU
�Ow DP TLINER#P P P LE� LE� LE� LE�J\ w M
P FORWARDR#P �N" �N" � �N" �C  DN�
� �N;
� �N" �C� DN�
� �N; @N" �   UPB   ~
~
\ w
 �P BACKR#_ �P\ w �P TURTLESTATER#@NJ  FJ
 �    1 �    h \ w �P"FD�Pw  Q#  # � I
% MWJ � J � \  TASK   XETNEXT4X2 [X(NEXTS
TEP [�y [[2 EXCW1-tX2 �z$STEP~z134,13OXLI
NE�z1 �X%CPULLuz0 �X'#SPACESqz0 _X%LAST'm
z0 �X%TRAP?iz0 �X%NEST?ez0 FX#IP>az0 PX#<
IP=z0   "(W9z  �v&RANGE?_vb b  {�< {���Z
 �Z�X {$_D�� MODE s   _ GETDISKR# 7�  Bi

\ *** Block No. 164, Hexblock a4

 5INITR+ ? ?�$ Tape2.00 �S/ 0L�0 8� 0d&U"
 �   &U� BP\  ���d 8��岍e ��峍f � �g �h
 �i �j � �� �`�B�2�_�k�A���Y�X�X� �� � ��
* XR �P$�  �X�Y�4�X� ����_���`���A���B�?�
�E XR �Pl�P2 R SUPERTAPER+   �O; / �Q/ .
 ; / =S/ 0 ; �$ ST2.20 \ R+�!4O+P\ 2 �S B
TLR+/ �P/ " }R\ R+�    ?4�  T     � � D �
RL �    � � D �    \ 2 'T STSAVSYSR+�O4O�
 �O; -T9T P   �O; �    I -T�  T P-TJ X +P
 P\   ITc\IFR+ $�.� �   �$� \   �T SAVESY
STEMR+�34O� �3; �34O� �3; |z4O|z� p`4Op`�
 e>�O"    I �   TTd �    I X +P P\   DT A
UTOLOAD.*     U TAPE" .S�>�`��I � 8) P  l
_�Z  S   ��X D� �� �P���b ���c ���d 8�
�岍e ��峍f � �g �h �i �j � �� �`�B�2�_�
k�A���Y�X�X� �� � ��* XR �P$�  �X�Y�4�X�
����_���`���A���B�?��E XR �Pl�P2 R SUPER
TAPER+   �O; / �Q/ . ; / =S/ 0 ; �$ ST2.2
0 \ R+�!4O+P\ 2 �S BTLR+/ �P/ " � �c �_�d
 �` �e E_�A�f E`�B�o�H �b 0 ���H �?��E �P
l�P �Q�   �Q�  l  , tP G----.*
g726e �R�
 fw� �Y�H � , ��� �P� i � � � , ��� �P� i
 � lTR�]I �]�^I �^�X�H �P�`h�@� �w �RJP�H
�w �R� �]�^�_�w �R�_P �` �R�_EAP�`EBP�]
�^�w �R��w �Rl�R� � �2 �P�_��?��0 ���2 l

\ *** Block No. 165, Hexblock a5

"
^�  QP�P����]�C�^�D QP QP��P ���_ QP QP
��Q_� � QP QP�_P �` QP QP���`EBPC�_EAP���
EC� �� `��l�P�  QP�P�EDP�� � � ��l�P`���
����I � lp�Z  ��X��h� �� `� �� �P D� �
P���H �* �P�C J� �2  R�H@ P���HD��(�?���
�>�Y2 ��I?��b ) � ����l�P X�lRQl�QH�� ��
���_���`��" RAMDISKR+pI�ITIL  P\   6P LOA
DRAMDISKR+5I� �   bMCHxMpI�$ RD.L �O� \ �
 �`�B�2�_�k�A`�H � �� � �� � �`� � JP��P�
`� ,� ,� ,� ,� �>�h �� X�ZH��__`I x`� ,
���� ) Ex�  �xFw�w  �]P �^� ) Ex���x �P�w
`�y�  QPI P�� �  QP�P�I P�JP�  QP�P�I ��
Ey� IE�T� ��l�P� �]�" �N; \ u  O"CSJFu 7O
"PCYIu @O"BG�Iu iO*FULLSCREEN�Gu rO+SPLIT
SCREEN@Gv CO XCORR#�N" LE\ v UO YCORR#�N"
 LE\ v �O SETXR#qE�N; \ v �O SETYR#qE�N;
\ v �O SETXYR#�O�O\ v AO PENDOWNR#@N� \ v
 SO PENUPR#@N� \ v �O HOMER#  �  `IO  z�N
}O\ v �O DRAWR#JF P   @G\ v  P#
   �(2
064)    �l 9�l99l { J. { { �b    M;�:�+�
a





\ *** Block No. 166, Hexblock a6

# tte Diskette # �-�  einlelD� J..Y.Y4Z4Y
    S;!r�` F




          #  INPUT<$   �  ERRORHANDLER<$
     VOC-LINK<$      UDP<$   *  SP@= � �$
� �%�$� 8� � � F � � � � l    5  SP!G � �
� � � � l    _  UP@ � lg   W �UP!� � � �
 �� � � � �  I � � � l    �  RP@� � lg
� �RP!D � l�   � �>RR � 8� � � F � � � �
l�   K �R>� � 8� � � �� 3 �  7�  Kill the
 Demo? n/y �7�   YI � � �   .7.7.7� ���Z\
   |Z
DEMONSTRATIONR#�% H/ BZ�( 0/ �Z�(O8
mZ `�.Z VZ; / �Z�((+/ �+  ; / � �(L+tRWT�
G�7� �T�G�7� �  helpz7G � d7X+\

                              # I � � � l
      CTOGGLER#|
J n � � \      @$ � �$�
 �%�$� �$l       != � �$� �%H� �$H� � �$l
�   7  +!] � �$� �%H�  A$�$H� � Q$lo   v
 DROP�   Y  SWAP� � �� � �$�� �$� � H� �
�$� � ��$l    �  DUP� � 8� � � F � � � �
H� �l    �  ?DUP �   P l  l�   V  OVER�

\ *** Block No. 167, Hexblock a7

#  0�� E$� �%l� ' Q  U<  � �$� �%�  I � �
 � � E$� �%� l� l� ( �  >R#� U \ ( )  0>R
#_ � \ ( 7  0<>R#� � \ ( f  U>R#�   \ ( v
  =R#I � \ ( E  D0=R#  � \ ( S  D=R#� � Y
 \ ( �  D<R#
�
I �   - J
J
B   ~
  \ R#9
 �   � � \ ) �  MINR#�
- � \ ) E  MAXR#�

U � \ ) W # �
 +�
 H� Q � �� � Q � l�   �

 OR  H�   � �� �   � l�      AND3 H� 1 �
 �� � 1 � l�   +  XORp H� q � �� � q � l�
 ! h  -K H� 8� � H� � � � � l� ! E  NOT�
 �� � �� � l  ! �  NEGATE� 8��" �  DNEGAT
E� H8�� � H�� � �� � � �� � l   ���� �$ �
 �� E � � � � � `" �# � � l  + B �(+LOOP�
  � A � � Q � Jq  �  I � � � ( Dl  , � �I
' � � 8� � � F  � HHQ � �� HHQ � � l  , !
 �Js � PR- m �BRANCHD  � A �$� Q � �$� l
 - y �?BRANCH� �    �  I � � � (�Kld . Z
 >MARKR#X �   \ . �  >RESOLVER#X � I � ;
\ . �  <MARKR#X \ . M  <RESOLV# $ �  OFFR
#� � ; \ % � �CLIT  � 8� � � F � � �� � P
 � l  %   �LIT1 � 8� � � F � � � � �  I �
 � � l  % ) GLITERALR#� /  �1 �   6 /   d
 6     \ & t  0<� �   ��$�� l  & ~  0=� �
   ��P�& �  UWITHIN� �  S � � E$� �%� � E
&� �'��l� ' �  <W � �$� �%�  I � � � �%q

\ *** Block No. 168, Hexblock a8

#
ER#X I   \ . }  ?PAIRSR#I �+ unstructur
ed\ I   h��l  h� �� 8� � � F �� � H� l  /
 �  CASE?b �  S �$A P �%Q P l� �l  0 8 BI
FR#6 � � � \ 0 \ DTHENR#= � � � \ 0 O DEL
SER#� � 6 B � � � � \ 0 � EBEGINR#U F \ 0
 � EWHILER#F � F 6 � � / ��H
\ R#� � / ��
I �   � � #
    ." ultraFORTH-83 3.80-C64  ���� � ���
�  � I � � L��� ��     END-TRACEE ��� � �
 �I� � � l    w  RECOVER."H� H� � P F F l
R#  Z  NOOP    �  ORIGIN�#    _  S0<$   �
  R0<$   �  DP<$   G  OFFSET<$   Q  BASE<
$     OUTPUT<$   � #
        M�_ �W DEMO�#4Y_ 8Z SLIDER#?ZW`AV

XB ��\ _ eZ ENDSLIDER#�W?ZW`�_\ ."_Z  _Z
 KILLDEMOR#�WJZ�_zS/ �?�( 0/ � �(O8/ � �(
�8/  +�((+]H/ $_E5e6    _\ R#VZ" � } �  N
�H\N� VZ[ AL *�W�?\ R#�) 7� �'1 " �   �
 compilingB   �   uF83VZ" � � #  F � � �
� �  E � � � l    �  R@  � 8� � � F � � �
 l      �RDROP    1  EXITf � � � � l    =
  UNNEST^ � � � � l    s  ?EXITU �    �
I � � � (P�l    K  EXECUTE� � � � � �  I
� � � l    �  PERFORMR#" � \   �  C@L � �
$� �%� � �$l    E  C!� � �$� �%H� �$��

\ *** Block No. 169, Hexblock a9

# g�e�d d   ze�$ u2:13,0,L �e�f�e�d�6yf\
� ]g DISKOPENR+ d
Pe  #�e�dyf\ � �g DIS
KCLOSER+ d
�e�d\ � Yg 1541R/WR+� �3 no
filez  d6 �  d; P [ �   �5�$ beyond capac
ityJ d Cg�   � J d � � 3 3 Z � I . � � %
  �   �f&gB   �fKgP  g� � � �   � J � z ~
 �g\ � �g #  � 8� � � F � � � H� � � l
 �  ROT
� � �%� � � � � � �$�%� � �$� H�
 �%� � � � � �%� � l
 -ROTR#

\
s
 NIPR#� � \   D
 UNDERR#� � \   T
 PICK
R## 3 ; �
" \   �
 ROLLR#� P �
; � a � #
3 � � \   �
 2SWAPR#
P
� \   @
 2DROP�
   V
 2DUPR#� � \   #  UMAXR#�
  � \ ) �
 UMINR#�
[ � \ ) �  EXTENDR#� � \ )    DA
BSR#  �   � \ ) "  ABSR#  �   _ \ R#9 � a
 � P
P � P P \ * 7 �(DOR#� I i \ * C �(
?DOR#� I } �   i � � " �
P � \ * U  BOUND
SR#� �
� \ * � �ENDLOOP� � l  + � �(LOOPL
  � A � � � I � � l  � � � �� #   D+� �
S H�  E&� H� E'� � E$� � � E%� l  # �  1+
% �  A � l  � � I � l  #    2+c � P�# <
3+p � PSv � PM\ � PG# i  1-I 8� � � l  �
� � � l  # B  2-�  ��$ �  TRUE�#��$ �  FA
LSE�#  $ � "-1� $ � !0� $ �  1�#  $ �  2�
#  $ B  3�#  $ L  4�#  $ V  ONR#� � ; \
