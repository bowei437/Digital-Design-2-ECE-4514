// Filename:    myfpadd.v
// Author:      Bowei Zhao
// Date:        28 February 2017
// Project:     Project 5
// Version:     1
// Description: Replacement megafunction for add for p5

module myfpadd(add_sub, clock, dataa, datab, result);
	input clock, add_sub;
	input [31:0] dataa, datab;
	output [31:0] result;
	reg [31:0] tempresult, outres;

	reg done;

	reg [6:0] exp_a, exp_b, shiftamount;
	reg [23:0] mant_a, mant_b, tmant_a, tmant_b, mant_comb, mant_comb2, mant_comb3;



   always @* begin
   		done = 1'b0;
		if (exp_a > exp_b) begin

			while (exp_a > exp_b) begin
				tmant_b = mant_b >> 4; // shift right by 4
				exp_b = exp_b + 1; // increment loop
			end

			if (dataa[31] == 1'b1) begin // if A is negative
				mant_comb = mant_a - tmant_b;
				tempresult = {dataa[31], exp_a[6:0], mant_comb};
			end
			else if (datab[31] == 1'b1) begin // if B is negative
				mant_comb = mant_a - tmant_b;
				tempresult = {dataa[31], exp_a[6:0], mant_comb};
			end
			else begin
				mant_comb = mant_a + tmant_b;
				tempresult = {dataa[31], exp_a[6:0], mant_comb};
			end
			done = 1'b1;
				//exp_a = 7'b0;
				//exp_b = 7'b0;
			
		end
		else if (exp_b > exp_a) begin // When exponent of B greater than A

			while (exp_b > exp_a) begin
				tmant_a = mant_a >> 4; // shift A to right by 4 to normalize
				exp_a = exp_a + 1; // increment so it loops
			end

			if (dataa[31] == 1'b1) begin
				mant_comb2 = mant_b - tmant_a;
				tempresult = {datab[31], exp_b[6:0], mant_comb2};
			end
			else if (datab[31] == 1'b1) begin
				mant_comb2 = mant_b - tmant_a;
				tempresult = {datab[31], exp_b[6:0], mant_comb2};
			end
			else begin
				mant_comb2 = tmant_a + mant_b;
				tempresult = {datab[31], exp_b[6:0], mant_comb2};
			end
			done = 1'b1;
				//exp_a = 7'b0;
				//exp_b = 7'b0;
		end
		else if (exp_a == exp_b) begin
			if (dataa[31] == 1'b1) begin
				mant_comb3 = mant_a - mant_b;
				tempresult = {dataa[31], exp_a[6:0], mant_comb3};
			end
			else if (datab[31] == 1'b1) begin
				mant_comb3 = mant_a - mant_b;
				tempresult = {dataa[31], exp_a[6:0], mant_comb3};
			end
			else begin
				mant_comb3 = mant_a + mant_b;
				tempresult = {dataa[31], exp_a[6:0], mant_comb3};
			end
			
			done = 1'b1;
				//exp_a = 7'b0;
				//exp_b = 7'b0;
			
		end
   end

	always @(posedge clock) begin

			outres <= tempresult;

			exp_a <= dataa[30:24];
			exp_b <= datab[30:24];
			mant_a <= dataa[23:0];
			mant_b <= datab[23:0];
			//outres <= 32'b0;

	end
	assign result = (done == 1'b1) ? outres : 32'b0;
	//assign shiftamount = ex ;

endmodule