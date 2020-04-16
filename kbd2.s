            ORG $6000

START       LDX XPOS          ; X-COORD
            LDY YPOS          ; Y-COORD
TYPEWRITER  JSR KEYIN         ; GET INPUT CHARACTER
            JSR COUT1         ; ECHO CHARACTER THAT'S IN THE ACCUMULATOR
            
            CMP EXIT
            BEQ :EXIT         ; IF SO, WE'RE DONE

            CMP MOVE_UP
            BEQ :UP

            CMP MOVE_DOWN
            BEQ :DOWN

            CMP MOVE_LEFT
            BEQ :LEFT

            CMP MOVE_RIGHT
            BEQ :RIGHT

            JMP TYPEWRITER    ; CONTINUE
            RTS

:UP         DEY
            TYA
            JSR PRBYTE
            JMP TYPEWRITER    ; CONTINUE

:DOWN       INY
            TYA
            JSR PRBYTE
            JMP TYPEWRITER    ; CONTINUE

:LEFT       DEX
            TXA
            JSR PRBYTE
            JMP TYPEWRITER    ; CONTINUE

:RIGHT      INX
            TXA
            JSR PRBYTE
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

* VARIABLES

MOVE_UP     HEX C1            ; "A"
MOVE_DOWN   HEX DA            ; "Z"
MOVE_LEFT   HEX AC            ; "," (the "<" character without SHIFT)
MOVE_RIGHT  HEX AE            ; "." (the ">" character without SHIFT)
EXIT        HEX D8            ; "X"
XPOS        HEX 00
YPOS        HEX 00

* INCLUDES

            PUT Includes/equates
