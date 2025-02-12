org 0

ld r1, start_point

bal clear

; r1 - write pointer
; r2 - color
; r3 - sub result
; r4 - end pointer
; r5 - pc push
; r6 - read pointer

start_point DEFW 0xFF00
white       DEFW 0xFFFF
blue		DEFW 0x0003
end_point   DEFW 0xFF40

clear
	mov r2, r0
	ld r4, end_point

	st r2, [r1]
	add r1, r1, #1
	subs r3, r4, r1
	bne clear

level_one
	;set player start
	ld r2, white
	st r2, [r1]

	; set target
	ld r1, start_point
	st r2, [r1, #14]

	; set bar
	ld r2, blue
	add r1, r1, #4
	st r2, [r1]
	add r1, r1, #8
	st r2, [r1]
	add r1, r1, #8
	st r2, [r1]
	add r1, r1, #8
	st r2, [r1]
	add r1, r1, #8
	st r2, [r1]
	add r1, r1, #8
	st r2, [r1]
	add r1, r1, #8
	st r2, [r1]
	add r1, r1, #8

	; caller save
	ld r1, prev_loc
	add r5, pc, r0
	st r5, return_addr
	st r1, prev_loc
	
	; return
	bal move_poll

prev_loc      DEFW 0x0000
return_addr   DEFW 0
switches_read DEFW 0xFF95
compare_init  DEFW 0x0080     

move_poll
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

	; rotate and check for e
	add r4, r4, r0, ror
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_left

	; rotate and check for d
	add r4, r4, r0, ror
	ands r0, r4, r6
	bne add_up

	bal level_one
	

add_down
	add r1, r1, #8
	mov pc, r5

add_right
add_left
add_up