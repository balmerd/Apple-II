          ORG  $6000

* ENTRY POINT

START     JSR   CLRHGR1     ; CLEAR PAGE (DO IT NOW SO WE DON'T SEE IT HAPPEN)         
          LDA   GRAPHICS    ; SWITCH TO GRAPHICS MODE
          LDA   HIRES       ; ENABLE HI-RES
          LDA   PAGE1       ; DISPLAY PAGE 1
          LDA   FULLSCRN    ; DISPLAY FULL SCREEN
          RTS

* ZERO-PAGE POINTERS

HIGH      EQU  $1B 
LOW       EQU  $1A

* INCLUDES

          PUT   Includes/equates
          PUT   Includes/hires-utils
          PUT   Includes/hires-lookup
