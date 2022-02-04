org $15B2FA     ; Routine to hack

skip 3          ; Skip to $15B2FD
db $01          ; Apply second palette to character in Tellah position
db $01          ; Apply second palette to character in Edward position
db $00          ; Apply second palette to character in Rosa position
db $02          ; Apply third palette to character in Yang position
db $02          ; Apply third palette to character in Palom position
db $02          ; Apply third palette to character in Porom position
db $02          ; Apply third palette to character in Cecil (Paladin) position
db $03          ; Apply fourth palette to character in Cid position
db $03          ; Apply fourth palette to character in Rydia (Adult) position
