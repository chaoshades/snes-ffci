org $808B74     ; Hack directly into ROM

skip 1          ; Skip to $808B75
db $0D          ; Change music of canoe (Overworld)
skip 1          ; Skip to $808B77
db $06          ; Change music of ship (Underworld)