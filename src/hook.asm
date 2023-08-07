;-----------------------------------------------
;
; TI-84 Addition Edition Source Code - hook.asm
; By RoccoLox Programs and TIny_Hacker
; Copyright 2023
; License: GPL-3.0
; Last Built: August 4, 2023
;
;-----------------------------------------------

include 'include/ez80.inc'
include 'include/tiformat.inc'
format ti archived appvar 'AdEdHook'
include 'include/ti84pceg.inc'

hookBackUp := ti.appData + 253

additionEdition:
    db $83
    ld b, a
    cp a, ti.kClear
    jr z, removeAddition
    cp a, ti.kAdd
    jr z, allowKey
    cp a, ti.kEnter
    jr z, allowKey
    cp a, ti.k0
    jr c, return
    cp a, ti.k9 + 1
    jr nc, return

allowKey:
    or a, 1
    ld a, b
    ret

removeAddition:
    call ti.ClrRawKeyHook
    ld hl, (hookBackUp)
    call ti.ChkHLIs0
    call nz, ti.SetGetKeyHook
    jr allowKey

return:
    xor a, a
    ret
