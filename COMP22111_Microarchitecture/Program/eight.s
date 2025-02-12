org 0

ld r1, start_point
ld r2, display_start
bal init_led

start_point    DEFW 0xFF00
display_start  DEFW 0xFF40
display_end    DEFW 0xFF8F

init_led
	ld r3, display_end

	st r0, [r2]
	add r2, r2, #1
	subs r0, r3, r2
	bne init_led

	bal write

P         DEFW   0xFF50
display   DEFW   0xFF55

write
	
	; P
	ld r2, P
	ld r3, display
	st r2, [r3]

	; I
	sub r2, r2, #7
	add r3, r3, #1
	st r2, [r3]

	; X
	add r2, r2, #15
	add r3, r3, #1
	st r2, [r3]

	; E
	sub r2, r2, #10
	sub r2, r2, #9
	add r3, r3, #1
	st r2, [r3]

	; L
	add r2, r2, #7
	add r3, r3, #1
	st r2, [r3]

	; A
	sub r2, r2, #11
	add r3, r3, #1
	st r2, [r3]

	; T
	add r2, r2, #10
	add r2, r2, #9
	add r3, r3, #1
	st r2, [r3]

	; E
	sub r2, r2, #10
	sub r2, r2, #5
	add r3, r3, #1
	st r2, [r3]

	; D
	sub r2, r2, #1
	add r3, r3, #1
	st r2, [r3]

	bal clear

end_point   DEFW 0xFF40

; reset the board before starting
clear
	mov r2, r0
	ld r4, end_point

	st r2, [r1]
	add r1, r1, #1
	subs r0, r4, r1
	bne clear
	bal level_one

white DEFW 0xFFFF
start DEFW 0xFF00

level_one
	;set player start
	mov r3, r0
	ld r1, start
	ld r2, white
	st r2, [r1, #9]

	ld r1, player_start
	add r1, r1, #9
	bal move_poll

player_start DEFW 0xFF00

; do not change from this point
; r1 - current location
; r2 - write value
; r3 - isWrite

switches_read DEFW 0xFF95
compare_init  DEFW 0x0080
pc_store      DEFW 0x0000

; delay because clock is faster than human
delay_limit
	subs r5, r5, #1
	bne delay_limit

	; return to caller + 1
	ld r5, pc_store
	add pc, r5, #1

delay_val DEFW 0xF000

; poll the switches
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

	; rotate and check for g -> right
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_right

	; rotate and check for f -> clear
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne clear

	; rotate and check for e -> left
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_left

	; rotate and check for d -> up
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_up

	bal col_poll

sound_1         DEFW 0xF13F
buzz_add_1		DEFW 0xFF92

; adjust the movement
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

; erase to simulate movement
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
keypad_read     DEFW 0xFF94
compare_col     DEFW 0x0008

; poll for colour to draw
col_poll

	ld r6, keypad_read
	ld r4, compare_col

	; read from switches
	ld r6, [r6]

	; rotate and check for 3
	ands r0, r4, r6
	bne paint_green

	; rotate and check for 2
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne paint_red

	; rotate and check for 1
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne paint_blue

	; rotate and check for 0
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne paint_white

	bal move_poll

green           DEFW 0xFF1C
sound_5         DEFW 0xF13F
buzz_add_5		DEFW 0xFF92

paint_green
	; sound
	ld r2, buzz_add_5
	ld r3, sound_5
	st r3, [r2]

	ld r3, green
	st r3, [r1]
	add r3, r0, #1

	bal move_poll

red           DEFW 0xFFE0

paint_red
	; sound
	ld r2, buzz_add_4
	ld r3, sound_4
	st r3, [r2]

	ld r3, red
	st r3, [r1]
	add r3, r0, #1

	bal move_poll

blue           DEFW 0xFF03

paint_blue
	; sound
	ld r2, buzz_add_4
	ld r3, sound_4
	st r3, [r2]

	ld r3, blue
	st r3, [r1]
	add r3, r0, #1

	bal move_poll

sound_4         DEFW 0xF13F
buzz_add_4		DEFW 0xFF92

paint_white
	; sound
	ld r2, buzz_add_4
	ld r3, sound_4
	st r3, [r2]

	ld r3, white_paint
	st r3, [r1]
	add r3, r0, #1

	bal move_poll

white_paint     DEFW 0xFFFF