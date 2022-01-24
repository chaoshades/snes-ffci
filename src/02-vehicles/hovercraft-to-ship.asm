org $009F62     ; Routine to hack

nop             ; Remove "dust" animation

skip 18         ; Skip to $009F75
CMP #$D001      ; Reduce height it rises (can't go lower)

skip 90         ; Skip to $009FD2
CMP #$D001      ; Reduce height from which it lands (can't go lower)