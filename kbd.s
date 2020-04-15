            ORG $6000

START       LDX XPOS          ; X-COORD
            LDY YPOS          ; Y-COORD
TYPEWRITER  JSR KEYIN         ; GET INPUT CHARACTER
            JSR COUT1         ; ECHO CHARACTER THAT'S IN THE ACCUMULATOR
            ;JSR PRBYTE
            
            CMP EXIT
            BEQ :EXIT         ; IF SO, WE'RE DONE

            JMP TYPEWRITER    ; CONTINUE

:UP         INY
            JSR PRINTY
            JMP TYPEWRITER    ; CONTINUE

:DOWN       DEY
            JSR PRINTY
            JMP TYPEWRITER    ; CONTINUE

:LEFT       DEX
            JSR PRINTX
            JMP TYPEWRITER    ; CONTINUE

:RIGHT      INX
            JSR PRINTX
            JMP TYPEWRITER    ; CONTINUE

:EXIT       RTS

KEYIN       LDA READKBD       ; READ CHARACTER
            BPL KEYIN         ; LOOP UNTIL BIT 7 IS SET (see docs/keyboard.txt)
            STA RESETKBD      ; OTHERWISE CLEAR KEYBOARD BEFORE RETURNING
            RTS

PRINTX      TXA
            JSR PRBYTE
            RTS

PRINTY      TYA
            JSR PRBYTE
            RTS

STASHED     NOP

            CMP UP
            BEQ :UP

            CMP DOWN
            BEQ :DOWN

            CMP LEFT
            BEQ :LEFT

            CMP RIGHT
            BEQ :RIGHT
            RTS

* VARIABLES

UP          HEX C1            ; "A"
DOWN        HEX DA            ; "Z"
LEFT        HEX AC            ; "," (the "<" character without SHIFT)
RIGHT       HEX AE            ; "." (the ">" character without SHIFT)
EXIT        HEX D8            ; "X"
XPOS        HEX 00
YPOS        HEX 00

* INCLUDES

            PUT Includes/equates
