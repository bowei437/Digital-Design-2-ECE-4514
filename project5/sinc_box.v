// Filename:    sinc_box.v
// Author:      Bowei Zhao
// Date:        21 February 2017
// Project:     Project 24
// Version:     1
// Description: Main implementation of sinc function for project 5

module sinc_box (clk_clk, reset_reset_n, x_export, start_export, sinc_out_export, done_export);
	input clk_clk, reset_reset_n, start_export;
	input [31:0] x_export;
	output done_export;
	output [31:0] sinc_out_export;

	wire [31:0] x2_1, x2_2, x2_3, x2_4, x2_5;
	wire [31:0] x4_1, x4_2, x4_3;
	wire [31:0] x6_1, x6_2;
	wire [31:0] x8_1;

	wire [31:0] d1, d2, d3, d4;
	wire [31:0] ad1, ad2, ad3, ad4, ad5, adres; 

	//wire [31:0] FACT3, FACT5, FACT7, FACT9, VALONE;

	reg [31:0] tempout, fcompare;
	reg tempdone;
	//integer i, s_count, change;
	reg [31:0] i, s_count, change;
	reg [31:0] inx;

	reg [31:0] multarray [0:11];

	localparam VALONE = 32'h3f800000; // 1 
	localparam FACT3 = 32'h40c00000; // 3! = 6
	localparam FACT5 = 32'h42f00000; // 5! = 120
	localparam FACT7 = 32'h459d8000; // 7! = 5040
	localparam FACT9 = 32'h48b13000; // 9! = 362880

	localparam DFACT3 = 32'h3e2aaaab; // 1/6 = 0.16666667. 
	localparam DFACT5 = 32'h3c088889; // 1/5! = 0.0083333
	localparam DFACT7 = 32'h39500cfa; // 1/7! = 0.000198412
	localparam DFACT9 = 32'h3638ef1e; // 1/9! = 2.75573E-6

	// multp5 m5_l3 (.clock(clk_clk), .dataa(), .datab(), .result());
	// divp4 d (.clock(clk_clk), .dataa(), .datab(), .result());

	multp5 m1_l1 (.clock(clk_clk), .dataa(inx), .datab(inx), .result(x2_1)); // x2 // #6
	multp5 m2_l1 (.clock(clk_clk), .dataa(inx), .datab(inx), .result(x2_2)); // x2 // #6

	multp5 m3_l2 (.clock(clk_clk), .dataa(VALONE), .datab(x2_1), .result(x2_3)); // x2 * 1 // #12
	multp5 m4_l2 (.clock(clk_clk), .dataa(x2_1), .datab(x2_2), .result(x4_1)); // x2 * x2 = x4 // #12

	multp5 m5_l3 (.clock(clk_clk), .dataa(VALONE), .datab(x2_3), .result(x2_4)); // # 18
	multp5 m6_l3 (.clock(clk_clk), .dataa(x2_3), .datab(x4_1), .result(x6_1)); // x2 * x4 = x6 // #18
	multp5 m7_l3 (.clock(clk_clk), .dataa(VALONE), .datab(x4_1), .result(x4_2)); // #18

	multp5 m8_l4 (.clock(clk_clk), .dataa(x2_4), .datab(VALONE), .result(x2_5)); // #24
	multp5 m9_l4 (.clock(clk_clk), .dataa(x2_4), .datab(x6_1), .result(x8_1)); // x8 // #24
	multp5 m10_l4 (.clock(clk_clk), .dataa(x6_1), .datab(VALONE), .result(x6_2)); // x6 // #24
	multp5 m11_l4 (.clock(clk_clk), .dataa(VALONE), .datab(x4_2), .result(x4_3));// x4 

	multp5 t1 (.clock(clk_clk), .dataa(x2_5), .datab(DFACT3), .result(d1)); // x^2 / 3! // #30
	multp5 t2 (.clock(clk_clk), .dataa(x4_3), .datab(DFACT5), .result(d2)); // x^4 / 5!
	multp5 t3 (.clock(clk_clk), .dataa(x6_2), .datab(DFACT7), .result(d3)); // x^6 / 7!
	multp5 t4 (.clock(clk_clk), .dataa(x8_1), .datab(DFACT9), .result(d4)); // x^8 / 9!
	
	addsubp5 a1_l6 (.add_sub(1'b0), .clock(clk_clk), .dataa(VALONE), .datab(d1), .result(ad1)); // 1 - (x^2/3!)
	addsubp5 a2_l6 (.add_sub(1'b0), .clock(clk_clk), .dataa(d2), .datab(d3), .result(ad2)); // (x^4 / 5!) - (x^6 / 7!)
	addsubp5 a3_l6 (.add_sub(1'b1), .clock(clk_clk), .dataa(32'h0), .datab(d4), .result(ad3)); // (x^8 / 9!)

	addsubp5 a4_l7 (.add_sub(1'b1), .clock(clk_clk), .dataa(ad2), .datab(ad3), .result(ad4)); // (x^4 / 5!) - (x^6 / 7!) + (x^8 / 9!)
	addsubp5 a5_l7 (.add_sub(1'b1), .clock(clk_clk), .dataa(32'h0), .datab(ad1), .result(ad5)); // 1 - (x^2/3!)

	addsubp5 a6_l8 (.add_sub(1'b1), .clock(clk_clk), .dataa(ad5), .datab(ad4), .result(adres)); // (1 - (x^2/3!)) + (x^4 / 5!) - (x^6 / 7!) + (x^8 / 9!)


	always @(posedge clk_clk) begin
		if (reset_reset_n == 1'b0) begin
			tempdone <= 1'b0;
			//tempout <= 32'b0;
			i <= 32'd0;
			s_count <= 32'd0;
			change <= 32'd0;
		end
		else begin
			
				
				tempdone <= 1'b0;
				
				if (start_export == 1'b1) begin
					inx <= x_export;
					s_count <= s_count + 32'd1;
				end


				if (adres != 32'b0) begin

					fcompare <= adres;
					i <= i + 32'd1;
					if (fcompare != adres) begin
						change <= 32'd1;
					end
					if (i >= 32'd3 ) begin
						
						if (s_count >= 32'd1) begin
							
							if (change == 32'd1) begin
								tempdone <= 1'b1;
								tempout <= adres;	
								change <= 32'd0;
								
								s_count <= s_count - 32'd1;
							end
						end
						
						//tempdone <= 1'b1;
						
					end	

				end


		end
	end

	assign sinc_out_export = tempout;
	assign done_export = tempdone;


endmodule
