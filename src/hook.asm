include 'include/ez80.inc'
include 'include/tiformat.inc'
format ti archived appvar 'AdEdHook'
include 'include/ti84pceg.inc'

_additionEdition:
    db $83
    cp a, $1b ; make sure a key has been pressed
    ret nz
    ld a, ti.sk0 ; there has got to be a better way to do these keys but I'm too lazy to figure it out for a joke program
    cp a, b
    jr z, _allowKey
    ld a, ti.sk1
    cp a, b
    jr z, _allowKey
    ld a, ti.sk2
    cp a, b
    jr z, _allowKey
    ld a, ti.sk3
    cp a, b
    jr z, _allowKey
    ld a, ti.sk4
    cp a, b
    jr z, _allowKey
    ld a, ti.sk5 ; I'm sure that there's something better
    cp a, b
    jr z, _allowKey
    ld a, ti.sk6
    cp a, b
    jr z, _allowKey
    ld a, ti.sk7
    cp a, b
    jr z, _allowKey
    ld a, ti.sk8 ; please enlighten me
    cp a, b
    jr z, _allowKey
    ld a, ti.sk9
    cp a, b
    jr z, _allowKey
    ld a, ti.skAdd ; nevermind this works so who cares
    cp a, b
    jr z, _allowKey
    ld a, ti.skEnter
    cp a, b
    jr z, _allowKey
    ld hl, $f0202c
	ld (hl), l
	ld l, h
	bit 0, (hl) ; on button removes the hook
    jr nz, _removeAddition
    or a, a
    ld a, 0 ; DO NOT ALLOW THIS KEY
    ret

_allowKey:
    or a, a
    ret

_removeAddition:
    call ti.ClrGetKeyHook ; who cares about chaining >:)
    or a, a
    ld a, 0
    ret
