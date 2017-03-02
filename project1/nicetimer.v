//  File         : nicetimer.v
//  Author       : B. Zhao
//  Date         : 01/26/17
//  Version      : 1
//  Description  : This file models the a nicetimer for Project1 of ECE4514
// 			This is the top-level module for ECE 4514 Project 1.  Do not
// 			modify the module declaration or ports in this file.  When
// 			synthesizing to the DE1-SoC, this file should be used with the
//			provided Quartus project so that the FPGA pin assignments are made
// 			correctly.

module nicetimer(clock_50, reset_n, toggle_n, up_n, down_n, hex5, hex4, hex3, hex2, hex1, hex0);
	input clock_50, reset_n, toggle_n, up_n, down_n;
	output [6:0] hex5, hex4, hex3, hex2, hex1, hex0;

	wire [1:0] key_up, key_down, key_toggle; 
	wire [3:0] fsm_out;

	keypresseddd2 bright (.clock(clock_50),
						 .reset(reset_n),
						 .key_in(up_n),
						 .key_out(key_up));

	keypresseddd2 dim (.clock(clock_50),
						.reset(reset_n),
						.key_in(down_n),
						.key_out(key_down));

	keypresseddd2 toggle (.clock(clock_50),
							.reset(reset_n),
							.key_in(toggle_n),
							.key_out(key_toggle));

	state_p1 fsm (.clock(clock_50),
					.reset(reset_n),
					.up(key_up),
					.down(key_down),
					.toggle(key_toggle),
					.outval(fsm_out));


endmodule