          ORG   $6000

* ENTRY POINT

START     JSR   CLRHGR1         ; CLEAR PAGE 1 (DO IT NOW SO WE DON'T SEE IT HAPPEN)
          LDA   GRAPHICS        ; SWITCH TO GRAPHICS MODE
          LDA   HIRES           ; ENABLE HI-RES
          LDA   PAGE1           ; DISPLAY PAGE 1
          LDA   FULLSCRN        ; DISPLAY FULL SCREEN
          JSR   DRAWSHAPE
          ;LDA   #$FF           ; WAIT FOR ??? MS
          ;JSR   WAIT
          RTS

* DRAW SHAPE

; FOREACH LINE OF THE SHAPE
; GET CURRENT LINE/COLUMN POSITION
DRAWSHAPE LDA   SCREEN_X
          STA   SHAPE_X
          LDA   SCREEN_Y
          STA   SHAPE_Y
          CLC                     ; ALWAYS NEED TO CLEAR CARRY BEFORE ADC
          ADC   SHAPE_HEIGHT
          STA   SHAPE_DEPTH
          LDA   #$00              ; RESET SHAPE BYTE OFFSET
          STA   SHAPE_BYTE_OFFSET
:LINE     LDY   SHAPE_X
          LDX   SHAPE_Y
          LDA   HI,X              ; GET LINE ADDRESS
          STA   HIGH
          LDA   LO,X
          STA   LOW
          LDA   (LOW),Y           ; GET CURRENT BYTE AT THAT POSITION
          LDX   SHAPE_BYTE_OFFSET ; GET SHAPE BYTE OFFSET
          EOR   SHAPE,X           ; EXCLUSIVE-OR WITH SHAPE BYTE
                                  ; (FIRST TIME WILL DRAW, SECOND TIME WILL ERASE)
          STA   (LOW),Y           ; PLOT SHAPE BYTE
          INC   SHAPE_BYTE_OFFSET ; INC FOR EACH BYTE IN A SHAPE LINE
          INC   SHAPE_Y           ; NEXT LINE
          LDA   SHAPE_Y
          CMP   SHAPE_DEPTH       ; IS SHAPE DONE?
          BLT   :LINE             ; IF NO, DRAW NEXT LINE
          RTS                     ; IF YES, STOP

* SHAPE DATA

* SHAPE VARIABLES

SCREEN_Y          DFB   #$05      ; CURRENT LINE NUMBER
SCREEN_X          DFB   #$04      ; CURRENT COLUMN NUMBER
SHAPE_BYTE_OFFSET DS    1         ; INDEX TO SHAPE BYTE
SHAPE_DEPTH       DS    1         ; COMPUTED AS SHAPE_Y + SHAPE_HEIGHT (SO WE KNOW WHEN TO STOP)

; KEEP TRACK OF LINE/COLUMN WITHIN SHAPE
SHAPE_Y           DS    1
SHAPE_X           DS    1
SHAPE_HEIGHT      DFB #$08        ; HEIGHT OF SHAPE (IN LINES)
SHAPE_LINE_BYTES  DFB #$00        ; ZERO INDEXED SO 1 BYTE WIDE SHAPE WOULD BE ZERO

; EACH SHAPE LINE IS ONE BYTE OF 7 BITS
SHAPE     HEX   08                ; 0001000 ...X...
          HEX   14                ; 0010100 ..X.X..
          HEX   08                ; 0001000 ...X...
          HEX   3E                ; 0111110 .XXXXX.
          HEX   5D                ; 1011101 X.XXX.X
          HEX   1C                ; 0011100 ..XXX..
          HEX   14                ; 0010100 ..X.X..
          HEX   22                ; 0100010 .X...X.

* ZERO-PAGE ADDRESSES

LOW       EQU   $1A               ; HGR LINE FROM LOOKUP TABLE
HIGH      EQU   $1B

* INCLUDES

          PUT   Includes/equates
          PUT   Includes/hires-utils
          PUT   Includes/hires-lookup
