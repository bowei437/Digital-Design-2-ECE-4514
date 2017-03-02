// Filename:    myfpmult.v
// Author:      Bowei Zhao
// Date:        28 February 2017
// Project:     Project 5
// Version:     1
// Description: Replacement megafunction for mult for p5

module myfpmult(clock, dataa, datab, result);
	input clock;
	input [31:0] dataa, datab;
	output [31:0] result;
	reg [31:0] tempresult;
	reg [7:0] ie_exp_a, ie_exp_b;

   reg [6:0] exp_a, exp_b;
   reg [23:0] mant_a, mant_b;

	//reg [31:0] ie_man_a, ie_man_b; //22bits

	reg [31:0] c_man_a, c_man_a2, c_man_b; // 23bits

	// 7.3849

	// IEE 0 10000001 11011000101000100011010
   // CUS 0 0000001 011101100010100010001100

   //8.88996
   // IEE 00011100011110101000111
/*
   assign exp_a = dataa[30:24];
   assign exp_b = datab[30:24];

   assign mant_a = dataa[23:0];
   assign mant_b = datab[23:0];


   always @(posedge clock) begin
      c_man_a <= dataa[23:0];
      c_man_a2 <= c_man_a;



         
   end


   assign result = tempresult;
*/



endmodule

   /*
   always @(posedge clock) begin
         ie_exp_a[7:0] <= dataa[30:23] - 127;
         ie_exp_b[7:0] <= datab[30:23] - 127;

         ie_man_a[31:9] <= dataa[22:0];
         ie_man_b[31:9] <= datab[22:0];

         c_man_a <= ie_man_a >> 1;
         c_man_a[31] <= 1'b1;
         
   end
   */