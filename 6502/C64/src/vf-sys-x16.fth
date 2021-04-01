
include vf-lbls-cbm.fth

7f fthpage

\ X16 labels

0c28c >label ConOut
 0286 >label IOStatus
 028c >label MsgFlg
 028b >label OutDev
 028a >label  InDev
09f2c >label BrdCol
 0266 >label BkgCol
 0284 >label PenCol
   8a >label PrgEnd  \ aka eal; seems unused
 0292 >label IOBeg   \ aka stal; seems unused
 0381 >label CurFlg  \ aka qtsw
 0385 >label InsCnt  \ aka insrt


\ C64 labels that X16 doesn't have:

\ 028a >label KeyRep  \ aka rptflg


\ *** Block No. 129, Hexblock 81
81 fthpage

\ X16 c64key? getkey

Code c64key? ( -- flag)
 9f61 ldx
 0 # lda  9f61 sta
 0a00a lda
 0<> ?[  0FF # lda  ]? pha
 9f61 stx
 Push jmp  end-code

Code getkey  ( -- 8b)
 9f61 lda  N sta
 0 # lda  9f61 sta
 0a00a lda  0<>
 ?[  sei  0a000 ldy
  [[  0a000 1+ ,X lda  0a000 ,X sta  inx
      0a00a cpx  0= ?]
  0a00a dec
  N lda  9f61 sta
  tya  cli  0A0 # cmp
  0= ?[  bl # lda  ]?
 ]?
 Push0A jmp   end-code


\ *** Block No. 130, Hexblock 82
82 fthpage

\ X16 curon curoff

  037B >label blnsw  \ C64: $cc
\   037C >label blnct  \ C64: $cd
\   037D >label gdbln  \ C64: $ce
\   037E >label blnon  \ C64: $cf
\   0262 >label pnt    \ C64: $d1
\   0380 >label pntr   \ C64: $d3
\   0373 >label gdcol

09f60 >label via1pb

Code curon   ( --)
  blnsw stx  Next jmp  end-code

Code curoff   ( --)
  blnsw sty  Next jmp  end-code


include vf-sys-cbm.fth


\ *** Block No. 143, Hexblock 8f
\ ... continued
8f fthpage

Create ink-pot
\ border bkgnd pen  0
  6 c,   6 c,  3 c, 0 c,  \ Forth
 0E c,   6 c,  3 c, 0 c,  \ Edi
  6 c,   6 c,  3 c, 0 c,  \ User


\ *** Block No. 144, Hexblock 90
90 fthpage

\ X16 restore

Label restore   pha txa pha tya pha cld
\ TODO: Replace with phx phy once 65c02 asm is available
  $ffe1 jsr ( stop )  0<> ?[ $e01f jmp ( prend ) ]?
' restart @ jmp  end-code


\ *** Block No. 145, Hexblock 91
91 fthpage

\ X16:Init

: init-system  \ TODO(pzembrod): Check if this works and is needed
 [ restore ] Literal $318 ! ;  \ NMI-Vector

Label first-init
 sei cld
 via1pb lda  $f8 # and  via1pb sta \ map in KERNAL ROM
 IOINIT jsr  CINT jsr  RESTOR jsr  \ init. and set I/O-Vectors
 ink-pot    lda BrdCol sta \ border
 ink-pot 1+ lda BkgCol sta \ backgrnd
 ink-pot 2+ lda PenCol sta \ pen
 $0e # lda  ConOut jsr  \ lower/uppercase
 cli rts end-code
first-init dup bootsystem 1+ !
               warmboot   1+ !
Code c64init first-init jsr
 xyNext jmp end-code

| CODE (bye  $FFFC ) jmp  end-code
