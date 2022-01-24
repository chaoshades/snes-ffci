org $00FD31     ; Routine to hack

PHY             ; Make sure registers Y...     
PLX             ; ...and X are not affected by the custom code, in case they're important (They're not used here)

; Vehicle encounter tables
LDA $1704       ; Observe the mode of transport

CMP #$01        ; If in canoe (01)
BNE $0D         ; If not equal, skip to next check
LDA $061B       ; Observe current position
CMP #$80        ; Is on the southern part of the overworld? 
BCS $02 
LDA #$11        ; If not, load encounter set 17 into A
LDA #$12        ; else, load encounter set 18 into A
BRA $08         ; Jump to end

CMP #$03        ; If in ship (03)
BNE $04         ; If not equal, skip to next check
LDA #$10        ; If so, load encounter set 16 into A
BRA $04         ; Jump to end
;BRA $31         ; Jump to end

; Uncomment to use
; Event based encounter tables 
;LDA $129E         
;AND #$3F        ; Observe (only) flags 240 through 245

;CMP #$20        ; Is flag 245 set?
;BCC $04         ; If not, skip to next check
;LDA #$06        ; If so, load encounter set 6 into A
;BRA $24         ; Jump to end

;CMP #$10        ; Is flag 244 set?
;BCC $04         ; If not, skip to next check
;LDA #$05        ; If so, load encounter set 5 into A
;BRA $1C         ; Jump to end

;CMP #$08        ; Is flag 243 set?
;BCC $04         ; If not, skip to next check
;LDA #$04        ; If so, load encounter set 4 into A
;BRA $14         ; Jump to end

;CMP #$04        ; Is flag 242 set?
;BCC $04         ; If not, skip to next check
;LDA #$03        ; If so, load encounter set 3 into A
;BRA $0C         ; Jump to end

;CMP #$02        ; Is flag 241 Set?
;BCC $04         ; If not, skip to next check
;LDA #$02        ; If so, load encounter set 2 into A
;BRA $04         ; Jump to end

LDA $0EC542,x   ; Load the appropriate encounter set into A

JMP $899A       ; Jump back to the rest of the normal routine
