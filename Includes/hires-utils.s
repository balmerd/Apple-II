
**
* CLEAR PAGE TO BLACK
**

CLRHGR1   LDA   #$00        ; LOW BYTE OF PAGE1 ADDRESS
          STA   LOW         ; STORE IN ZERO-PAGE POINTER
          LDA   #$20        ; HIGH BYTE OF PAGE1 ADDRESS
          STA   HIGH        ; STORE IN ZERO-PAGE POINTER
:CLR1     LDA   #$00        ; BLACK PIXELS
          LDY   #$00        ; START AT $2000
:CLR      STA   (LOW),Y     ; REFERENCE ROW[COL]
          INY               ; NEXT COLUMN
          BNE   :CLR        ; IF ZERO THAT MEANS WE WENT PAST $FF (END OF ROW) TO $00 (START OF NEW ROW)
          INC   HIGH        ; NEXT ROW
          LDA   HIGH        ; LOAD FOR COMPARISON BELOW
          CMP   #$40        ; CHECK NEXT ROW WOULD BE PAGE2 $4000
          BLT   :CLR1       ; IF NOT, CONTINUE
          RTS 
