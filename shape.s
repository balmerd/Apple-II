          ORG   $6000

* ENTRY POINT

START     JSR   CLRHGR1     ; CLEAR PAGE 1 (DO IT NOW SO WE DON'T SEE IT HAPPEN)
          LDA   GRAPHICS    ; SWITCH TO GRAPHICS MODE
          LDA   HIRES       ; ENABLE HI-RES
          LDA   PAGE1       ; DISPLAY PAGE 1
          LDA   FULLSCRN    ; DISPLAY FULL SCREEN
          JSR   DRAWSHAPE
          RTS

* SHAPE VARIABLES (DS RESERVES n BYTES WITH INITIAL VALUE OF ZERO)

LINE      DFB   #$05        ; STARTING LINE NUMBER
COL       DFB   #$04        ; STARTING COLUMN NUMBER
HEIGHT    DFB   #$08        ; HEIGHT OF SHAPE (IN LINES)
XCOUNT    DFB   $#00        ; INDEX TO SHAPE WIDTH, SHAPE[0] IS THE FIRST (AND ONLY) BYTE IN EACH LINE
DEPTH     DS    1           ; COMPUTED BELOW

* DRAW SHAPE

DRAWSHAPE LDA   LINE
          CLC               ; ALWAYS NEED TO CLEAR CARRY BEFORE ADC
          ADC   HEIGHT
          STA   DEPTH       ; DEPTH = STARTING LINE NUMBER + SHAPE HEIGHT
:NEXTLINE LDY   COL
          LDX   LINE
          LDA   HI,X        ; GET LINE ADDRESS
          STA   HIGH
          LDA   LO,X
          STA   LOW
          LDX   XCOUNT      ; LOAD X WITH XCOUNT
          LDA   SHAPE,X     ; FIRST SHAPE BYTE
          STA   (LOW),Y     ; PLOT
          INC   XCOUNT      ; INC XCOUNT FOR EACH BYTE IN SHAPE LINE
          INC   LINE        ; NEXT LINE
          LDA   LINE
          CMP   DEPTH       ; IS SHAPE DONE?
          BLT   :NEXTLINE   ; IF NO, CONTINUE DRAW
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

* INCLUDES

          PUT   Includes/equates
          PUT   Includes/hires-utils
          PUT   Includes/hires-lookup
