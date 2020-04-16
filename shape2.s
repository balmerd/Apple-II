b          ORG   $6000

* ENTRY POINT

START     JSR   CLRHGR1     ; CLEAR PAGE 1 (DO IT NOW SO WE DON'T SEE IT HAPPEN)
          LDA   GRAPHICS    ; SWITCH TO GRAPHICS MODE
          LDA   HIRES       ; ENABLE HI-RES
          LDA   PAGE1       ; DISPLAY PAGE 1
          LDA   FULLSCRN    ; DISPLAY FULL SCREEN
:SETUP    LDA   INITIAL_COLUMN
          STA   COLUMN
          LDA   INITIAL_LINE
          STA   LINE
          CLC
          ADC   HEIGHT
          STA   DEPTH
:LOOP     JSR   DRAWSHAPE
          LDA   #$00        ; RESET BYTE POSITION
          STA   XCOUNT
          INC   LINE        ; MOVE TO THE NEXT LINE
          LDA   LINE
          CLC
          ADC   HEIGHT      ; ADJUST THE DEPTH
          STA   DEPTH
          LDA   #$FF        ; DELAY
          JSR   WAIT
          JMP   :LOOP
          RTS

* SHAPE VARIABLES

INITIAL_LINE      DFB   #$05        ; STARTING LINE NUMBER
INITIAL_COLUMN    DFB   #$04        ; STARTING COLUMN NUMBER
HEIGHT    DFB   #$08        ; HEIGHT OF SHAPE (IN LINES)
XCOUNT    DFB   $#00        ; INDEX TO SHAPE WIDTH, SHAPE[0] IS THE FIRST (AND ONLY) BYTE IN EACH LINE
DEPTH     DS    1           ; COMPUTED BELOW (DS RESERVES n BYTES WITH INITIAL VALUE OF ZERO)

* DRAW SHAPE

; FOREACH LINE OF THE SHAPE
; GET CURRENT LINE/COLUMN POSITION
DRAWSHAPE LDY   COLUMN
          LDX   LINE
          LDA   HI,X        ; GET LINE ADDRESS
          STA   HIGH
          LDA   LO,X
          STA   LOW
          LDX   XCOUNT      ; LOAD X WITH XCOUNT
          LDA   (LOW),Y     ; GET CURRENT VALUE
;   GET CURRENT SCREEN BYTE AT CURRENT/INITIAL ADDRESS
          EOR   SHAPE,X     ; EXCLUSIVE-OR WITH SHAPE BYTE
;   EOR CURRENT SCREEN BYTE WITH SHAPE BYTE (FIRST TIME WILL DRAW, SECOND TIME WILL ERASE)
          STA   (LOW),Y     ; PLOT
          INC   XCOUNT      ; INC XCOUNT FOR EACH BYTE IN SHAPE LINE
          INC   LINE        ; NEXT LINE
          LDA   LINE
          CMP   DEPTH       ; IS SHAPE DONE?
          BLT   DRAWSHAPE   ; IF NO, CONTINUE DRAW
          RTS               ; IF YES, STOP

* SHAPE DATA

SHAPE     HEX   08          ; 0001000 ...X...
          HEX   14          ; 0010100 ..X.X..
          HEX   08          ; 0001000 ...X...
          HEX   3E          ; 0111110 .XXXXX.
          HEX   5D          ; 1011101 X.XXX.X
          HEX   1C          ; 0011100 ..XXX..
          HEX   14          ; 0010100 ..X.X..
          HEX   22          ; 0100010 .X...X.

* ZERO-PAGE ADDRESSES

LOW       EQU   $1A
HIGH      EQU   $1B
LINE      EQU   $26         ; CURRENT POSITION
COLUMN    EQU   $27

* INCLUDES

          PUT   Includes/equates
          PUT   Includes/hires-utils
          PUT   Includes/hires-lookup
