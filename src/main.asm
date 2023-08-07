;-----------------------------------------------
;
; TI-84 Addition Edition Source Code - main.asm
; By RoccoLox Programs and TIny_Hacker
; Copyright 2023
; License: GPL-3.0
; Last Built: August 4, 2023
;
;-----------------------------------------------

include 'include/ez80.inc'
include 'include/tiformat.inc'
format ti archived executable protected program 'ADDSETUP'
include 'include/ti84pceg.inc'

hookBackUp := ti.cursorImage + 6

    jp install
    db $01 ; icon byte

icon:
    db $10, $10
    db $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $6C, $00, $6C, $6C, $00, $6C, $6C, $6C, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $6C, $00, $6C, $00, $00, $00, $6C, $6C, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $6C, $00, $6C, $6C, $00, $6C, $6C, $6C, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $4A, $4A, $00, $00, $00, $00, $4A, $4A, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $4A, $B5, $4A, $B5, $4A, $B5, $B5, $4A, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $4A, $B5, $4A, $B5, $4A, $B5, $B5, $4A, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $00, $4A, $B5, $4A, $2A, $4A, $2A, $2A, $4A, $00, $5B, $5B, $5B
    db $5B, $5B, $5B, $5B, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5B, $5B, $5B
    db $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B

description:
    db "Channel the inner power of addition", 0

install:
    ld hl, appvarName
    call ti.Mov9ToOP1
    call ti.ChkFindSym
    jr c, appvarNotFound
    call ti.ChkInRam
    jr nz, notInRam
    call ti.Arc_Unarc
    jr install

notInRam:
    ld hl, 12
    add hl, de
    ld a, c
    ld bc, 0
    ld c, a
    add hl, bc
    bit ti.rawKeyHookActive, (iy + ti.hookflags2)
    jr z, noHookInstalled
    ld de, (ti.rawKeyHookPtr)
    push hl
    or a, a
    sbc hl, de
    pop hl
    ret z
    ld (hookBackUp), de
    jr installHook

noHookInstalled:
    ld de, 0
    ld (hookBackUp), de

installHook:
    jp ti.SetGetKeyHook

appvarNotFound:
    call ti.ClrScrn
    call ti.HomeUp
    ld hl, notFoundStr
    call ti.PutS
    call ti.GetKey
    call ti.ClrScrn
    jp ti.HomeUp

notFoundStr:
    db "Requires AdEdHook AppVar.", 0

appvarName:
    db ti.AppVarObj, "AdEdHook", 0
