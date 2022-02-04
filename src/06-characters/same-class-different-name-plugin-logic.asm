org $00FD56     ; Routine to hack

; Original code
STA $1000,y     ; Stores the ROM character data (name, level, stats, etc.) into RAM...

; Change character name only if processing the good property
TXA             ; Transfer X into Accumulator for AND operator
AND #$1F        ; Is Character name property (multiple of 20)?
BNE Return      ; If not equal, jump to original code

; Skip name change for Dummy character
LDA $1000,y     ; Load the Character name value
CMP #$95        ; Is Character a dummy one (Golbez)?
BEQ Return      ; If equal, jump to original code

CLC             ; Clear carry from past BEQ operator
PHA             ; Make sure Accumulator is not affected by the custom code, it will be used later on

; Change character name pointer for new ones "based on" the number of party members
REP #$20        ; Make Accumulator 16-bit (because the value with five character needs it)

LDA $063D       ; Load data that contains number of party members
ORA $063E       ; Add the remaining bit [It follows this: 00 40 80 C0 100 and the first bit of the last value having five characters is into $063E]
ROR A           ; Rotate bit Right Accumulator and...
LSR A           ; ...Shift-right Accumulator...
LSR A           ; ...
LSR A           ; 5 times
LSR A           ; ...
LSR A           ; ...to get number of party members (copy-pasted from there: 00E58C)

SEP #$20        ; Make Accumulator 8-bit

ADC #$8D        ; Add the smaller Character name Pointer value (8D) [ex.: 2 members+8D=8F]
STA $1000,y     ; Overwrites the Character name pointer (ex.: new-> 8DC4 <-old)

PLA              ; Restore the Accumulator as it was before the custom code

; Copy character name
REP #$20        ; Make Accumulator 16-bit (because following addresses calculations needs it)

PHY             ; Make sure registers Y...     
PHX             ; ...and X are not affected by the custom code, they're important

AND #$000F      ; Keep only the Character ID (first 4 bits) from the original Character name pointer value and remove the rest
LSR A           ; Shift-right Accumulator... (Divide by 2) 
ADC #$0000      ; ...and Add Carry...
SBC #$0000      ; ...and Substract Carry? (seems to be from previous ADC operator) to fit that the default names are reused between characters (ex.: 01 02 -> 0, 03 04 -> 1)
TAX             ; Initialize loop counter into register X
LDA #$A710      ; Load the minimum address for Character name from ROM
CPX #$0000      ; Is first character (00)
BEQ SkipLoopROM ; If equal, skip to next check

LoopROM:
ADC #$0005      ; Add Character name max length (6) -1 [because of Carry from loop BNE operator]
DEX             ; Decrement X
CPX #$0000      ; Loop completed?
BNE LoopROM     ; If not equal, loop again

SkipLoopROM:
TAX             ; Transfer source address into X (which will be from where to copy from ROM)

LDA $1000,y     ; Load the Character name pointer value
AND #$00FF      ; Keep only the Character name pointer value and remove the rest (the value is originally 8-bits)
PHA             ; Make sure Accumulator is not affected by the custom code, it will be used later on
SBC #$008D      ; Subtract the smaller Character name Pointer value to get number of party members from Accumulator
TAY             ; Initialize loop counter into register Y
LDA #$1524      ; Load the minimum address for Character name from RAM
CPY #$0000      ; Is first character (00)
BEQ SkipLoopRAM ; If equal, skip to next check

LoopRAM:
ADC #$0005      ; Add Character name max length (6) -1 [because of Carry from loop BNE operator]
DEY             ; Decrement Y
CPY #$0000      ; Loop completed?
BNE LoopRAM     ; If not equal, loop again

SkipLoopRAM:
TAY             ; Transfer destination address into Y (which will be where to copy into RAM)

LDA #$0005      ; Set A to name length-1 [6]
MVN $00,$0F     ; Block move bytes (or copy the Character name) from ROM into RAM [ex.: adding Cecil as the first character: $07:A710-A715 -> $7E:1524-1529]

PLA             ; Unstack the Accumulator
PLX             ; ...and registers X...     
PLY             ; ...and Y after the custom code

SEP #$20        ; Make Accumulator 8-bit

Return:
JMP $E62A       ; Jump back to the rest of the normal routine