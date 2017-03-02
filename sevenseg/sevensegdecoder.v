//  File         : sevensegdecoder.v
//  Author       : B. Zhao
//  Date         : 01/20/17
//  Version      : 1
//  Description  : This file models the functional behavior of an seven
//					segment display

module sevensegdecoder(d3, d2, d1, d0, a, b, c, d, e, f, g);
   input d3, d2, d1, d0;
   output a, b, c, d, e, f, g;
   reg [3:0] inbit;

// 
//  I N S E R T   Y O U R   C O D E   H E R E
  always @(*) begin
  		inbit = {d3, d2, d1, d0};
  end

    assign a = (inbit == 4'b0000) ? 1'b1 : // if equal to 0
    				(inbit == 4'b0010) ? 1'b1 : // if equal to 2
    				(inbit == 4'b0011) ? 1'b1 : // if equal to 3
    				(inbit == 4'b0101) ? 1'b1 : // if equal to 5
    				(inbit == 4'b0110) ? 1'b1 : // if equal to 6
    				(inbit == 4'b0111) ? 1'b1 : // if equal to 7
    				(inbit == 4'b1000) ? 1'b1 : // if equal to 8
    				(inbit == 4'b1001) ? 1'b1 : // if equal to 9
    				(inbit == 4'b1010) ? 1'b1 : // if equal to A
    				(inbit == 4'b1100) ? 1'b1 : // if equal to C
    				(inbit == 4'b1110) ? 1'b1 : // if equal to E
    				(inbit == 4'b1111) ? 1'b1 : 1'b0;  // if equal to F else, set to 1

    assign b = (inbit == 4'b0000) ? 1'b1 : // if equal to 0
    				(inbit == 4'b0001) ? 1'b1 : // if equal to 1
    				(inbit == 4'b0010) ? 1'b1 : // if equal to 2
    				(inbit == 4'b0011) ? 1'b1 : // if equal to 3
    				(inbit == 4'b0100) ? 1'b1 : // if equal to 4
    				(inbit == 4'b0111) ? 1'b1 : // if equal to 7
    				(inbit == 4'b1000) ? 1'b1 : // if equal to 8
    				(inbit == 4'b1001) ? 1'b1 : // if equal to 9
    				(inbit == 4'b1010) ? 1'b1 : // if equal to A
    				(inbit == 4'b1101) ? 1'b1 : 1'b0; // if equal to D else, set to 1

   	assign c = (inbit == 4'b0000) ? 1'b1 : // if equal to 0
   					(inbit == 4'b0001) ? 1'b1 : // if equal to 1
   					(inbit == 4'b0011) ? 1'b1 : // if equal to 3
   					(inbit == 4'b0100) ? 1'b1 : // if equal to 4
   					(inbit == 4'b0101) ? 1'b1 : // if equal to 5
   					(inbit == 4'b0110) ? 1'b1 : // if equal to 6
   					(inbit == 4'b0111) ? 1'b1 : // if equal to 7
   					(inbit == 4'b1000) ? 1'b1 : // if equal to 8
   					(inbit == 4'b1001) ? 1'b1 : // if equal to 9
   					(inbit == 4'b1010) ? 1'b1 : // if equal to A
   					(inbit == 4'b1011) ? 1'b1 : // if equal to B
   					(inbit == 4'b1101) ? 1'b1 : 1'b0; // if equal to D else, set to 1

   	assign d = (inbit == 4'b0000) ? 1'b1 : // if equal to 0
   					(inbit == 4'b0010) ? 1'b1 : // if equal to 2
   					(inbit == 4'b0011) ? 1'b1 : // if equal to 3
   					(inbit == 4'b0101) ? 1'b1 : // if equal to 5
   					(inbit == 4'b0110) ? 1'b1 : // if equal to 6
   					(inbit == 4'b1000) ? 1'b1 : // if equal to 8
   					(inbit == 4'b1001) ? 1'b1 : // if equal to 9
   					(inbit == 4'b1011) ? 1'b1 : // if equal to B
   					(inbit == 4'b1100) ? 1'b1 : // if equal to C
   					(inbit == 4'b1101) ? 1'b1 : // if equal to D
   					(inbit == 4'b1110) ? 1'b1 : 1'b0; // if equal to E else, set to 1
   

   	assign e = (inbit == 4'b0000) ? 1'b1 : // if equal to 0
   					(inbit == 4'b0010) ? 1'b1 : // if equal to 2
   					(inbit == 4'b0110) ? 1'b1 : // if equal to 6
   					(inbit == 4'b1000) ? 1'b1 : // if equal to 8
   					(inbit == 4'b1010) ? 1'b1 : // if equal to A
   					(inbit == 4'b1011) ? 1'b1 : // if equal to B
   					(inbit == 4'b1100) ? 1'b1 : // if equal to C
   					(inbit == 4'b1101) ? 1'b1 : // if equal to D
   					(inbit == 4'b1110) ? 1'b1 : // if equal to E
   					(inbit == 4'b1111) ? 1'b1 : 1'b0; // if equal to F else, set to 1

   					

   	assign f = (inbit == 4'b0000) ? 1'b1 : // if equal to 0
   					(inbit == 4'b0100) ? 1'b1 : // if equal to 4
   					(inbit == 4'b0101) ? 1'b1 : // if equal to 5
   					(inbit == 4'b0110) ? 1'b1 : // if equal to 6
   					(inbit == 4'b1000) ? 1'b1 : // if equal to 8
   					(inbit == 4'b1001) ? 1'b1 : // if equal to 9
   					(inbit == 4'b1010) ? 1'b1 : // if equal to A
   					(inbit == 4'b1011) ? 1'b1 : // if equal to B
   					(inbit == 4'b1100) ? 1'b1 : // if equal to C
   					(inbit == 4'b1110) ? 1'b1 : // if equal to E
   					(inbit == 4'b1111) ? 1'b1 : 1'b0; // if equal to F else, set to 1

   	assign g = (inbit == 4'b0010) ? 1'b1 : // if equal to 2
   					(inbit == 4'b0011) ? 1'b1 : // if equal to 3
   					(inbit == 4'b0100) ? 1'b1 : // if equal to 4
   					(inbit == 4'b0101) ? 1'b1 : // if equal to 5
   					(inbit == 4'b0110) ? 1'b1 : // if equal to 6
   					(inbit == 4'b1000) ? 1'b1 : // if equal to 8
   					(inbit == 4'b1001) ? 1'b1 : // if equal to 9
   					(inbit == 4'b1010) ? 1'b1 : // if equal to A
   					(inbit == 4'b1011) ? 1'b1 : // if equal to B
   					(inbit == 4'b1101) ? 1'b1 : // if equal to D
   					(inbit == 4'b1110) ? 1'b1 : // if equal to E
   					(inbit == 4'b1111) ? 1'b1 : 1'b0; // if equal to F else, set to 1

//  E N D   I N S E R T

endmodule