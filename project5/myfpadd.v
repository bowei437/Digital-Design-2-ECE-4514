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
	reg [23:0] mant_a, mant_b, tmant_a, tmant_b;
	reg [27:0] mant_comb;



   always @* begin
   		done = 1'b0;
		if (exp_a > exp_b) begin

			while (exp_a > exp_b) begin
				tmant_b = mant_b >> 4; // shift right by 4
				exp_b = exp_b + 1; // increment loop
			end

			if ((dataa[31] == 1'b1) && (datab[31] == 1'b0)) begin // if A is negative ONLY
				mant_comb = mant_a - tmant_b;
				while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
					mant_comb = mant_comb << 4;
					exp_a = exp_a - 1; 
				end
				tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
			end
			else if ((dataa[31] == 1'b0) && (datab[31] == 1'b1)) begin // if B is negative ONLY
				mant_comb = mant_a - tmant_b;
				while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
					mant_comb = mant_comb << 4;
					exp_a = exp_a - 1; 
				end
				tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
			end
			else if ((dataa[31] == 1'b1) && (datab[31] == 1'b1)) begin // BOTH NEGATIVE
				mant_comb = mant_a + tmant_b;
				while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
					mant_comb = mant_comb << 4;
					//exp_a = exp_a - 1; 
				end
				tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
			end
			else begin
				mant_comb = mant_a + tmant_b;
				while (mant_comb[27:24] != 4'b0) begin
					mant_comb = mant_comb >> 4;
					exp_a = exp_a + 1;
				end

				tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
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
				mant_comb = mant_b - tmant_a;
				while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
					mant_comb = mant_comb << 4;
					exp_b = exp_b - 1; 
				end
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
			end
			else if (datab[31] == 1'b1) begin
				mant_comb = mant_b - tmant_a;
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
			end
			else begin
				mant_comb = tmant_a + mant_b;
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
			end
			done = 1'b1;
				//exp_a = 7'b0;
				//exp_b = 7'b0;
		end
		else if (exp_a == exp_b) begin
			if (dataa[31] == 1'b1) begin
				mant_comb = mant_b - mant_a;
				tempresult = {datab[31], exp_a[6:0], mant_comb[23:0]};
			end
			else if (datab[31] == 1'b1) begin
				mant_comb = mant_a - mant_b;
				tempresult = {datab[31], exp_a[6:0], mant_comb[23:0]};
			end
			else begin
				mant_comb = mant_a + mant_b;
				tempresult = {datab[31], exp_a[6:0], mant_comb[23:0]};
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