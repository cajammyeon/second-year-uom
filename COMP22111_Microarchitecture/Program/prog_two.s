org 0

bal poll_read

; r1 poll pointer (destructible outside poll)
; r2 value from poll (destructible outside poll)
; r3 compare value (destructible outside poll)
; r4 value after comparison (destructible outside poll)
; r5 
; r6 pc address at time (destructible until input_process)

nincompare     DEFW 0x0200
keypad 	       DEFW 0xFF94

poll_read
	ld r1, keypad
	ld r2, [r1]
	
	; check value 9
	ld r3, nincompare
	and r4, r2, r3
	subs r4, r4, r3
	mov r6, pc
	beq input_process

	; check value 8
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	mov r6, pc
	beq input_process

	; check value 7
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	; check value 6
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	; check value 5
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	; check value 4
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	; check value 3
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	; check value 2
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	; check value 1
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	; check value 0
	or r3, r3, r0, ror
	and r4, r2, r3
	subs r4, r4, r3
	beq input_process

	bal poll_read

keypad_val DEFW 0

input_process

input 	   DEFW 0
jump_back  DEFW 0x0000