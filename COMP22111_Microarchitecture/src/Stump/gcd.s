		org	0

		ld   r1, op_A
		ld   r2, op_B
		bra  loop

A_greater	sub  r1, r1, r2

loop		cmp  r1, r2
		bgt  A_greater
		beq  stop

		sub  r2, r2, r1		; B_greater
		bra  loop
stop
st   r1, result				

		bra  .


op_A		defw 66
op_B		defw 39
result		defw  0