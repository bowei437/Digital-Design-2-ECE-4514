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
   reg [31:0] tempresult, outres;

   reg done;

   reg [6:0] exp_a, exp_b, texp_a, texp_b, exp_comb, shift, shift2;
   reg [23:0] mant_a, mant_b, tmant_a, tmant_b;
   reg [63:0] mant_mult;
   reg [27:0] mant_comb;
   reg [7:0] sig_a, sig_b;
   reg [15:0] sig_comb;


   always @* begin
      shift = 7'b0;
      shift2 = 7'b0;
      done = 1'b1;
      
      if (exp_a > exp_b) begin
         exp_comb = exp_a + exp_b;
         texp_a = exp_a;

         while (exp_a > exp_b) begin
            mant_a = mant_a >> 4;
            exp_a = exp_a - 1;
            shift = shift + 1;
         end
         mant_mult = mant_a * mant_b;

         while (mant_mult[27:24] != 4'b0) begin
            shift2 = shift2 + 1;
            mant_mult = mant_mult >> 4;
            //exp_a = exp_a + 1;
         end

         if (shift2 <= 4) begin
            exp_comb = exp_comb - 1;
         end
         else if (shift2 > 4) begin
            exp_comb = exp_comb;
         end

         //exp_comb = shift2 - exp_comb;

         mant_comb[27:0] = mant_mult[27:0];


         tempresult = {dataa[31], exp_comb[6:0], mant_comb[23:0]};

      end
      else if (exp_b > exp_a) begin
         tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
      end
      else begin
         exp_comb = exp_a + exp_b;
         /*
         while ((exp_a > 7'b0) && (exp_b > 7'b0)) begin
            mant_a = mant_a >> 4;
            exp_a = exp_a - 1;

            mant_b = mant_b >> 4;
            exp_b = exp_b - 1;

            shift = shift + 1;
         end
         */
         //shift = shift * 4;

         mant_mult = mant_a * mant_b;
         while (shift > 7'b0) begin
            mant_mult = mant_mult >> 4;
            shift = shift - 1;
         end
         mant_comb[27:0] = mant_mult[27:0];
         if ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
            mant_comb = mant_comb << 4;
            exp_comb = exp_comb - 1; 
         end
         
         tempresult = {dataa[31], exp_comb[6:0], mant_comb[23:0]}; // write result out

      end
      
   end

   always @(posedge clock) begin
         outres <= tempresult;
         
         exp_a <= dataa[30:24];
         exp_b <= datab[30:24];
         mant_a <= dataa[23:0];
         mant_b <= datab[23:0];
   end

   assign result = (done == 1'b1) ? outres : 32'b0;

endmodule

      /*
      if (exp_a > exp_b) begin
         exp_comb = exp_a + exp_b;
         while (exp_a > exp_b) begin
            tmant_a = mant_a >> 4;
            exp_a = exp_a - 1;
         end

         mant_mult = tmant_a * mant_b;
         while (mant_mult[27:24] != 4'b0) begin
            mant_mult = mant_mult >> 4;
         end
         mant_comb[27:0] = mant_mult[27:0];
         tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};

      end
      else if (exp_b > exp_a) begin
         tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]};
      end
      else begin
         exp_comb = exp_a + exp_b;
         while ((exp_a > 7'b0) && (exp_b > 7'b0)) begin
            mant_a = mant_a >> 4;
            exp_a = exp_a - 1;

            mant_b = mant_b >> 4;
            exp_b = exp_b - 1;

            shift = shift + 1;
         end
         shift = shift * 4;

         mant_mult = mant_a * mant_b;
         while (shift > 7'b0) begin
            mant_mult = mant_mult >> 4;
            shift = shift - 1;
         end
         mant_comb[27:0] = mant_mult[27:0];
         if ((mant_comb[23] == 1'b0) && (mant_comb[22] == 1'b0) && (mant_comb[21] == 1'b0) && (mant_comb[20] == 1'b0)) begin
            mant_comb = mant_comb << 4;
            exp_comb = exp_comb - 1; 
         end
         
         tempresult = {dataa[31], exp_comb[6:0], mant_comb[23:0]}; // write result out

      end
      */
      /*
      sig_a = mant_a[23:20];
      sig_b = mant_b[23:20];
      sig_comb = sig_a * sig_b;
      if ((sig_comb[7] == 1'b1) || (sig_comb[6] == 1'b1) || (sig_comb[5] == 1'b1) || (sig_comb[4] == 1'b1)) begin
         exp_comb = exp_a + exp_b;
         mant_comb[23:0] = {sig_comb[7:0], mant_a[15:0]};
         tempresult = {dataa[31], exp_comb[6:0], mant_comb[23:0]}; // write result out
      end
      else begin
         mant_comb = mant_a * mant_b;
         tempresult = {dataa[31], exp_a[6:0], mant_comb[23:0]}; // write result out
         //tempresult = {dataa[31], exp_a[6:0], sig_comb[3:0], mant_a[19:0]}; // write result out
      end
      */







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