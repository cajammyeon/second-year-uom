// Stump ALU
// Implement your Stump ALU here
//
// Created by Paul W Nutter, Feb 2015
//
// ** Update this header **
//

`include "Stump_definitions.v"

// 'include' definitions of function codes etc.
// e.g. can use "`ADD" instead of "'h0" to aid readability
// Substitute your own definitions if you prefer by
// modifying Stump_definitions.v

/*----------------------------------------------------------------------------*/

/** 
	!!! DO NOT augment the interface for the Stump_ALU module        		  !!!
	!!! Altering the interface could cause compilation and synthesis errors.  !!!
*/
module Stump_ALU (input  wire [15:0] operand_A,		// First operand
                                 input  wire [15:0] operand_B,		// Second operand
		                          input  wire [ 2:0] func,		// Function specifier
		                          input  wire        c_in,		// Carry input
		                          input  wire        csh,  		// Carry from shifter
		                          output reg  [15:0] result,		// ALU output
		                          output reg  [ 3:0] flags_out);	// Flags {N, Z, V, C}


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* Declarations of any internal signals and buses used                        */


// use this for storing temporary results, to check flags
reg [16:0] temp_result;
reg [14:0] carry_zero;
reg [15:0] carry_extended;

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* Verilog code */
                                                         
always @ (*) begin

	// calculate the result
	case(func)
		`ADD    : temp_result = operand_A + operand_B;
		`ADC    : temp_result = operand_A + operand_B + c_in;
		`SUB    : temp_result = operand_A + ~operand_B + 1;
		`SBC    : temp_result = operand_A + ~operand_B + 1 + ~{16'b0, c_in} + 1;
		`AND    : temp_result = operand_A & operand_B;
		`OR     : temp_result = operand_A | operand_B;
		`LDST   : temp_result = operand_A + operand_B;
		`BCC    : temp_result = operand_A + operand_B;
		default : temp_result = 17'hXXXXX;
	endcase
	
	// determine flags
	case (func)
		// basic functionalities
		`ADD, `ADC, `SUB, `SBC, `AND, `OR : begin

			// check for negative
			flags_out[3] = temp_result[15];

			// check for zero
			if (temp_result[15:0] == 0) flags_out[2] = 1; 
			else flags_out[2] = 0;

			// check for overflow
			if (overFlow(func) == 1) flags_out[1] = 1;
			else flags_out[1] = 0;

			// check for carry
			case(func)
				`ADD, `ADC, `SUB, `SBC : flags_out[0] = temp_result[16];
				`AND, `OR : flags_out[0] = csh;
				default : flags_out[0] = 1'bX;
			endcase

		end

		// ignore flags for load store and branch
		`LDST, `BCC : flags_out = 4'bXXXX;
		default	    : flags_out = 4'bXXXX;
	endcase

	// return proper result
	result = temp_result[15:0]; 
end

function overFlow (input [2:0] func); 
begin
	case (func)
		`ADD, `ADC : begin
			if ((operand_A[15] == operand_B[15]) & (temp_result[15] != operand_A[15])) overFlow = 1;
			else overFlow = 0;
		end
		`SUB, `SBC : begin
			if ((operand_A[15] != operand_B[15]) & (temp_result[15] != operand_A[15])) overFlow = 1;
			else overFlow = 0;
		end
		`AND, `OR : overFlow = 1'b0;
		default   : overFlow = 1'b0;
	endcase
end
endfunction

// given implementation
/*
wire [16:0] U;
wire [15:0] W, T, D, E,F ;
wire X;

or   I1[15:0] (E, operand_A, W);
and I2[15:0] (D, operand_A, W);
xor I3[15:0] (T, operand_A,W, U[15:0]);
and I4 (flags_out[1], ~func[2], X);
or   I5[15:0] (U[16:1], F, D);
buf I6 (flags_out[3], result[15]);
buf I7 (flags_out[2], ~|result);
xor I8 (X, U[16], U[15]);
and I9[15:0] (F, E, U[15:0]);

assign W = (func[2:1] == 1) ? ~operand_B : operand_B;
assign flags_out[0] = (func[2:1]==0) ? U[16] : (func[2:1]==1) ? ~U[16] : csh;
assign U[0] = (func==1) ? c_in : (func==2) ? 1 : (func==3) ? ~c_in : 0;
assign result = (func==4) ? D : (func==5) ? E : T;
*/

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

/*----------------------------------------------------------------------------*/

endmodule

/*============================================================================*/

