org $00CD4D    ; Routine to hack

LDX #$A698     ; Corneria's landing zone
STX $1721      ; Place the airship at the landing zone
skip 2         ; Skip to $00CD55
STA $1720      ; Make the airship visible