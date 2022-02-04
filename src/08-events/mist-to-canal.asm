org $15C72D     ; Routine to hack

; First canal row
skip 9          ; Skip to $15C736
CMP #$A4        ; Check if map is on row A4

skip 2          ; Skip to $15C73A
LDA #$1A        ; Load 1A (middle right sea coast)
STA $7F5CD6,x   ; Store new tile into 7F:65A4

LDA #$16        ; Load 16 (grass field)
STA $7F5CD7,x   ; Store new tile into 7F:65A4

LDA #$18        ; Load 18 (middle left sea coast)
STA $7F5CD8,x   ; Store new tile into 7F:65A4

nop #4          ; Delete code until $15C750

; Second canal row
skip 1          ; Skip to $15C751
CMP #$A5        ; Check if map is on row A4

skip 2          ; Skip to $15C755
LDA #$2A        ; Load 1A (bottom right sea coast)
STA $7F5CD6,x   ; Store new tile into 7F:65A4

LDA #$16        ; Load 16 (grass field)
STA $7F5CD7,x   ; Store new tile into 7F:65A4

LDA #$18        ; Load 18 (middle left sea coast)
STA $7F5CD8,x   ; Store new tile into 7F:65A4

nop #8          ; Delete code until $15C769

skip 1          ; Skip to $15C770
nop #26         ; Delete code until $15C78B
