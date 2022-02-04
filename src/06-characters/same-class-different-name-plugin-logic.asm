org $00FD56     ; Routine to hack

; Original code
STA $1000,y     ; Stores the ROM character data (name, level, stats, etc.) into RAM...

; Change character name pointer for new ones "based" on the value of the original ones
TXA             ; Transfer X into Accumulator for AND operator
AND #$1F        ; Is Character name property (multiple of 20)?
BNE $26         ; If not equal, jump to original code

;LDA $1000,y     ; Reloads the value stored

CPY #$0000      ; Is character in middle spot?
BNE $02         ; If not equal, skip to next check
LDA #$8D        ; Change character name pointer to 8D

CPY #$0040      ; Is character in top spot?
BNE $02         ; If not equal, skip to next check
LDA #$8E        ; Change character name pointer to 8E

CPY #$0080      ; Is character in bottom spot?
BNE $02         ; If not equal, skip to next check
LDA #$8F        ; Change character name pointer to 8F

CPY #$00C0      ; Is character in top-mid spot?
BNE $02         ; If not equal, skip to next check
LDA #$90        ; Change character name pointer to 90

CPY #$0100      ; Is character in bot-mid spot?
BNE $02         ; If not equal, skip to next check
LDA #$91        ; Change character name pointer to 91

STA $1000,y     ; Overwrites the character name pointer

; Copy character name
; LDX $1000,y     ; Reloads the value stored

JMP $E62A       ; Jump back to the rest of the normal routine
