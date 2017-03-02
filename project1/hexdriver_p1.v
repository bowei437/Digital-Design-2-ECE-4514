//  File         : hexdriver_p1.v
//  Author       : B. Zhao
//  Date         : 01/26/17
//  Version      : 1
//  Description  : This is the hexdriver that takes in a 4-bit input and outputs the
//					correct signals for the HEX displays.
      

module hexdriver_p1(i, uhex, lhex);
	input [3:0] i;
	output [6:0] uhex;
	output [6:0] lhex;

	wire [3:0] upOut;
	wire [3:0] downOut;

	bcd_bowei FirstD(i, downOut, upOut); // My bcd_bowei is declared as:    module bcd_bowei(i, lower, upper);
	//																	    	input [3:0] i;
	//																	    	output [3:0] lower;
	//																	    	output [3:0] upper;

	hexdecoder_bowei Upper(upOut, uhex); // my hexdecoder_bowei is declared as:     module hexdecoder_bowei(i, hex);
	//																			     	input [3:0] i;
	//																			     	output [6:0] hex;
	hexdecoder_bowei Down(downOut, lhex);

endmodule