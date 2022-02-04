org $15B441    ; Routine to hack

BNE $0A        ; If not equal, skip to next check
LDA $7A        ; Base value used to swap tile when animating vehicle
AND #$0A02     ; Add bits to stabilize the value to find the good charset 
ASL #2         ; Same looping animation effect as the hovercraft
nop #3         ; Delete code until $15B44D
