.ORG  $6000
.CPU  "65C02"
.SETTING "OutputFileType", "SBIN"
.INCLUDE "Includes/equates.inc"

// ADDRESS RANGES
// HARDWARE           $BFFF TO $FFFF
// DOS                $9600 TO HARDWARE
// USER2              $9000 TO DOS
// PAGE2              $6000 TO USER2
// PAGE1              $2000 TO PAGE2
// USER1              $0800 TO PAGE1
// TEXT SCREEN AND OS $0000 TO USER1

// HI-RES SCREEN COORDINATES
// WIDTH: 40 BYTES WITH 7 PIXELS PER BYTE
// HEIGHT: 192 LINES
// RESOLUTION: 7 * 40 (280) X 192

// ENTRY POINT

START     LDA   GRAPHICS  ; SWITCH TO GRAPHICS MODE
          LDA   HIRES     ; ENABLE HI-RES
          LDA   PAGE1     ; DISPLAY PAGE 1
          LDA   FULLSCRN  ; DISPLAY FULL SCREEN
          JSR   CLRHGR    ; CLEAR PAGE 1
          RTS

// CLEAR PAGE 1
CLRHGR    LDA   #$00      ; LOW BYTE OF PAGE1
          STA   $26       ; STORE IN ZERO-PAGE SAFE LOCATION
          LDA   #$20      ; HIGH BYTE OF PAGE1
          STA   $27       ; STORE IN ZERO-PAGE SAFE LOCATION
CLR1      LDY   #$00      ; FIRST COLUMN
          LDA   #$00      ; BLACK PIXELS
CLR       STA   ($26),Y   ; REFERENCE ROW[COL]
          INY             ; NEXT COLUMN
          BNE   CLR       ; IF ZERO THAT MEANS WE WENT PAST $FF (END OF ROW) TO $00 (START OF NEW ROW)
          INC   $27       ; NEXT ROW
          LDA   $27       ; LOAD FOR COMPARISON BELOW
          CMP   #$40      ; CHECK NEXT ROW WOULD BE PAGE2 $4000
          BLT   CLR1      ; IF NOT, CONTINUE
          RTS