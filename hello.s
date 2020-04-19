                  ORG $6000

* ENTRY POINT

START             JSR CLRTXT          ; CLEAR SCREEN
                  LDX #<MSG           ; STORE LOW BYTE OF STRING ADDRESS IN X-REGISTER
                  LDY #>MSG           ; STORE HIGH BYTE OF STRING ADDRESS IN Y-REGISTER
                  JSR PRINTLN         ; CALL SUBROUTINE TO PRINT STRING
                  RTS

* SUBROUTINE USING INDIRECT ZERO-PAGE ADDRESSING

PRINTLN           STX PTR             ; STORE THE LOW BYTE OF STRING ADDRESS PASSED IN X-REGISTER TO LOW BYTE OF STRING POINTER
                  STY PTR+1           ; STORE THE HIGH BYTE OF STRING ADDRESS PASSED IN Y-REGISTER TO HIGH BYTE OF STRING POINTER
                  LDY #0              ; START AT THE FIRST CHAR
LOOP              LDA (PTR),Y         ; LOAD CHAR USING ZERO-PAGE INDIRECT INDEXING (REQUIRES Y-REGISTER AS OFFSET)
                  BEQ DONE            ; EXIT IF WE HIT THE STRING ZERO-TERMINATOR
                  JSR COUT1           ; OTHERWISE WRITE THE CHAR
                  INY                 ; ON TO THE NEXT CHAR
                  BNE LOOP            ; REPEAT UNTIL WE HIT THE STRING ZERO-TERMINATOR
                  JSR CROUT           ; PRINT A RETURN CHARACTER
DONE              RTS

* ZERO-PAGE POINTERS

PTR               EQU $FE             ; POINTER TO OUR MESSAGE STRING

* VARIABLES

* Using single quotes, the high bit is set to 0 (standard ASCII)
* Using double quotes, the high bit is set to 1 (for Text Screen encoding)

MSG               ASC "HELLO, APPLE ]["
                  HEX 00              ; ZERO-BYTE TERMINATOR

* INCLUDES

                  PUT Includes/equates
