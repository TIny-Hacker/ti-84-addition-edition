include 'include/ez80.inc'
include 'include/tiformat.inc'
format ti archived executable protected program 'ADDSETUP'
include 'include/ti84pceg.inc'

	jp	_install
	db	$01
_icon:
	db	$10, $10
	db	$5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $6C, $00, $6C, $6C, $00, $6C, $6C, $6C, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $6C, $00, $6C, $00, $00, $00, $6C, $6C, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $6C, $00, $6C, $6C, $00, $6C, $6C, $6C, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $4A, $4A, $00, $00, $00, $00, $4A, $4A, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $4A, $B5, $4A, $B5, $4A, $B5, $B5, $4A, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $4A, $B5, $4A, $B5, $4A, $B5, $B5, $4A, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $4A, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $00, $4A, $B5, $4A, $2A, $4A, $2A, $2A, $4A, $00, $5B, $5B, $5B
	db	$5B, $5B, $5B, $5B, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5B, $5B, $5B
	db	$5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B
_description:
	db	"Channel the inner power of addition", 0
_install:
    bit 0, (iy + $34) ; check if the hook is installed
    jr nz, _failedHook
    call ti.ClrScrn
    call ti.HomeUp
    ld hl, appvarName
    call ti.Mov9ToOP1
    call ti.ChkFindSym
    jr c, _failedNotFound
    call ti.ChkInRam
    call z, _notInRAM
    ld hl, 10
    add hl, de
    ld a, c
    ld bc, 0
    ld c, a
    add hl, bc
    inc hl
    inc hl
    call ti.SetGetCSCHook
    ret

_notInRAM: ; hooks in RAM are very not safe
    call ti.ArchiveVar
    ld hl, appvarName
    call ti.Mov9ToOP1
    call ti.ChkFindSym
    ret

_failedHook:
    ld hl, hookInstalledStr
    call ti.PutS
    jr _wait

_failedNotFound:
    ld hl, notFoundStr
    call ti.PutS

_wait:
    call ti.GetCSC
    cp a, ti.skClear
    ret z
    cp a, ti.skEnter
    ret z
    jr _wait

notFoundStr:
    db "Error: AdEdHook AppVar    does not exist on the     calcuator.", 0

hookInstalledStr:
    db "Error: A GetCSC hook is   already installed.", 0

appvarName:
    db ti.AppVarObj, "AdEdHook", 0
