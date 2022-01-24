org $00A9FE     ; Routine to hack

LDA $1281 
AND #$04        ; check if "Yang Destroyed Cannon" flag is set
BEQ $23         ; If equal, skip to next check

LDA $1704       ; Load the current vehicle
                ; Is in no vehicle (00)
BNE $0B         ; If not equal, skip to next check

LDA $A1,x       ; Load traversability value of the target tile
AND #$02        ; check that it is traversable with chocobo
BEQ $18         ; If not equal, skip to next check

LDA #$01
JMP $AA21       ; Jump back to the rest of the normal routine

CMP #$01        ; Is in canoe (01)
BNE $0F         ; If not equal, skip to next check

LDA $A1,x       ; Load traversability value of the target tile
AND #$41        ; check that it is traversable with no vehicle
BEQ $09         ; If not equal, skip to next check

LDA #$00 
STA $1704       ; Store canoe or clear vehicle
JMP $AA2D       ; Jump back to the rest of the normal routine

nop             ; Delete code until $00AA28