org 0

; r1 led pointer
; r2 led write value
; r3
; r4
; r5 return address

ld r1, led
ld r2, try
ld r4, endLine

bal write_to_clear

led 		DEFW 0xFF00
try 		DEFW 0xFFFF
endLine 	DEFW 0xFF40
delay_val 	DEFW 0x5000
pc_store	DEFW 0x0000

delay_limit
	subs r5, r5, #1
	bne delay_limit

	; return to caller + 1
	ld r5, pc_store
	add pc, r5, #1

write_to_clear
	st r2, [r1]
	add r1, r1, #1
	subs r3, r4, r1
	beq stop

	; call program delay
	ld r5, delay_val
	st pc, pc_store
	bal delay_limit

	; clear back pixel
	st r0, [r1, #-1]

	; loop
	bal write_to_clear

stop
	st r0, [r1, #-1]