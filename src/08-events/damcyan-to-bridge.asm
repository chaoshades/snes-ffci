org $15C6FA     ; Routine to hack

skip 19         ; Skip to $15C70D
CMP #$97        ; Check if map is on row 97

skip 2          ; Skip to $15C711
LDA #$3F        ; Load 1A (bridge)
STA $7F5D09,x   ; Store new tile into 7F:9898

nop #5          ; Delete code until $15C71C

skip 1          ; Skip to $15C71D
CMP #$98        ; Check if map is on row 98

skip 2          ; Skip to $15C723
LDA #$3F        ; Load 1A (bridge)
STA $7F5D09,x   ; Store new tile into 7F:9898

nop #5          ; Delete code until $15C72C