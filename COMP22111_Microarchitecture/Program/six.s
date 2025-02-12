org 0

ld r1, start_point
bal clear

start_point DEFW 0xFF00
end_point   DEFW 0xFF40

clear
	mov r2, r0
	ld r4, end_point

	st r2, [r1]
	add r1, r1, #1
	subs r3, r4, r1
	bne clear
	bal level_one

white DEFW 0xFFFF
blue  DEFW 0x0003

level_one
	;set player start
	ld r1, start_point
	ld r2, white
	st r2, [r1, #9]

	ld r1, player_start
	add r1, r1, #9
	bal move_poll

player_start DEFW 0xFF00

; r1 - current location
; r2 - write value

switches_read DEFW 0xFF95
compare_init  DEFW 0x0080
pc_store      DEFW 0x0000

delay_limit
	subs r5, r5, #1
	bne delay_limit

	; return to caller + 1
	ld r5, pc_store
	add pc, r5, #1

delay_val DEFW 0xC000

move_poll
	; call delay
	ld r5, delay_val
	st pc, pc_store
	bal delay_limit

	ld r6, switches_read
	ld r4, compare_init

	; read from switches
	ld r6, [r6]

	; check for h
	ands r0, r4, r6
	bne add_down

	; rotate and check for g
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_right

	; rotate and check for f-color
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne paint

	; rotate and check for e
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_left

	; rotate and check for d
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_up

	bal move_poll

sound_1         DEFW 0xF13F
buzz_add_1		DEFW 0xFF92

add_down
	; check if need to erase
	subs r0, r3, r0
	mov r6, pc
	beq erase

	; sound
	ld r2, buzz_add_1
	ld r3, sound_1
	st r3, [r2]

	; move
	add r1, r1, #8

	ld r2, white_down
	st r2, [r1]
	add r3, r0, r0

	bal move_poll
	
add_right
	; check if need to erase
	subs r0, r3, r0
	mov r6, pc
	beq erase

	; sound
	ld r2, buzz_add_2
	ld r3, sound_2
	st r3, [r2]

	; move
	add r1, r1, #1

	ld r2, white_down
	st r2, [r1]
	add r3, r0, r0

	bal move_poll

white_down      DEFW 0xFFFF
sound_2         DEFW 0xF13F
buzz_add_2		DEFW 0xFF92

erase
	st r0, [r1]
	add pc, r6, #1

add_left
	; check if need to erase
	subs r0, r3, r0
	mov r6, pc
	beq erase

	; move
	sub r1, r1, #1

	; sound
	ld r2, buzz_add_2
	ld r3, sound_2
	st r3, [r2]

	ld r2, white_up
	st r2, [r1]
	add r3, r0, r0

	bal move_poll

white_up        DEFW 0xFFFF

add_up
	; check if need to erase
	subs r0, r3, r0
	mov r6, pc
	beq erase

	; move
	sub r1, r1, #8

	; sound
	ld r2, buzz_add_3
	ld r3, sound_3
	st r3, [r2]

	ld r2, white_up
	st r2, [r1]
	add r3, r0, r0

	bal move_poll

sound_3         DEFW 0xF13F
buzz_add_3		DEFW 0xFF92
green           DEFW 0xFF1C

paint
	; sound
	ld r2, buzz_add_3
	ld r3, sound_3
	st r3, [r2]

	ld r3, green
	st r3, [r1]
	add r3, r3, #1

	bal move_poll