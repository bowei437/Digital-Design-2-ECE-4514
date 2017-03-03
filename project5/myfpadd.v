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
		///////////if Input exponent A > B  /////////////////
		if (exp_a > exp_b) begin
			// Normalizes exponents by shifting left by 4 for every 1 value difference
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
			else if ((dataa[31] == 1'b1) && (datab[31] == 1'b1)) begin // IF A and B BOTH NEGATIVE
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
		///////////if Input exponent B > A  /////////////////
		else if (exp_b > exp_a) begin // When exponent of B greater than A

			// Normalizes exponents by shifting left by 4 for every 1 value difference
			while (exp_b > exp_a) begin
				tmant_a = mant_a >> 4; // shift A to right by 4 to normalize
				exp_a = exp_a + 1; // increment so it loops
			end

			if ((dataa[31] == 1'b1) && (datab[31] == 1'b0)) begin // if A is negative ONLY
				// can subtract B from A to get the same result as addition
				mant_comb = mant_b - tmant_a;
				// While loop is to check if result of "addition" is still normalized or if the exponents shifted

				while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
					// if it is not normalized. We shift it left 4 until those 4 arrays are no longer NON zero
					mant_comb = mant_comb << 4;
					exp_b = exp_b - 1; // subtract the base exponent for the result output
				end
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
			end
			else if ((dataa[31] == 1'b0) && (datab[31] == 1'b1)) begin // if B is negative ONLY
				mant_comb = mant_b - tmant_a;
				while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
					mant_comb = mant_comb << 4;
					exp_b = exp_b - 1; 
				end
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
			end
			else if ((dataa[31] == 1'b1) && (datab[31] == 1'b1)) begin /// IF A and B BOTH NEGATIVE
				mant_comb = tmant_a + mant_b;
				while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
					mant_comb = mant_comb << 4;
					//exp_a = exp_a - 1; 
				end
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
			end
			else begin
				mant_comb = tmant_a + mant_b;
				while (mant_comb[27:24] != 4'b0) begin
					mant_comb = mant_comb >> 4;
					exp_b = exp_b + 1;
				end
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
			end
			done = 1'b1;
				//exp_a = 7'b0;
				//exp_b = 7'b0;
		end
		///////////if Input exponent A == B  /////////////////
		else if (exp_a == exp_b) begin
			if ((dataa[31] == 1'b1) && (datab[31] == 1'b0)) begin // if A is negative ONLY
				if (mant_a > mant_b) begin
					mant_comb = mant_a - mant_b;
					while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
						mant_comb = mant_comb << 4;
						exp_a = exp_a - 1; 
					end
					tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
				end
				else begin
					mant_comb = mant_b - mant_a;
					while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
						mant_comb = mant_comb << 4;
						exp_a = exp_a - 1; 
					end
					tempresult = {datab[31], exp_a[6:0], mant_comb[23:0]};
				end
				
			end
			else if ((dataa[31] == 1'b0) && (datab[31] == 1'b1)) begin // if B is negative ONLY
				if (mant_a > mant_b) begin
					mant_comb = mant_a - mant_b;
					while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
						mant_comb = mant_comb << 4;
						exp_a = exp_a - 1; 
					end
					tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
				end
				else begin
					mant_comb = mant_b - mant_a;
					while ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
						mant_comb = mant_comb << 4;
						exp_a = exp_a - 1; 
					end
					tempresult = {datab[31], exp_a[6:0], mant_comb[23:0]};
				end

			end
			else if ((dataa[31] == 1'b1) && (datab[31] == 1'b1)) begin // IF A and B BOTH NEGATIVE
				mant_comb = mant_a + mant_b;
				while (mant_comb[27:24] != 4'b0) begin
					mant_comb = mant_comb >> 4;
					exp_b = exp_b + 1;
				end
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
				
			end
			else begin
				mant_comb = mant_a + mant_b;
				while (mant_comb[27:24] != 4'b0) begin
					mant_comb = mant_comb >> 4;
					exp_b = exp_b + 1;
				end
				tempresult = {datab[31], exp_b[6:0], mant_comb[23:0]};
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