
// vsim -c sinc_tester -pli sinc_checker.sl -L 220model_ver -L altera_mf_ver -do wave3.do
module sinc_latency (clk_clk, reset_reset_n, x_export, start_export, sinc_out_export, done_export);
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
	//integer i, s_count, out_count;
	reg [31:0] i, s_count, out_count;
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

	// multi_l m5_l3 (.clock(clk_clk), .dataa(), .datab(), .result());
	// divi_L d (.clock(clk_clk), .dataa(), .datab(), .result());

	multi_l m1_l1 (.clock(clk_clk), .dataa(inx), .datab(inx), .result(x2_1)); // x2 // #6
	multi_l m2_l1 (.clock(clk_clk), .dataa(inx), .datab(inx), .result(x2_2)); // x2 // #6

	multi_l m3_l2 (.clock(clk_clk), .dataa(VALONE), .datab(x2_1), .result(x2_3)); // x2 * 1 // #12
	multi_l m4_l2 (.clock(clk_clk), .dataa(x2_1), .datab(x2_2), .result(x4_1)); // x2 * x2 = x4 // #12

	multi_l m5_l3 (.clock(clk_clk), .dataa(VALONE), .datab(x2_3), .result(x2_4)); // # 18
	multi_l m6_l3 (.clock(clk_clk), .dataa(x2_3), .datab(x4_1), .result(x6_1)); // x2 * x4 = x6 // #18
	multi_l m7_l3 (.clock(clk_clk), .dataa(VALONE), .datab(x4_1), .result(x4_2)); // #18

	multi_l m8_l4 (.clock(clk_clk), .dataa(x2_4), .datab(VALONE), .result(x2_5)); // #24
	multi_l m9_l4 (.clock(clk_clk), .dataa(x2_4), .datab(x6_1), .result(x8_1)); // x8 // #24
	multi_l m10_l4 (.clock(clk_clk), .dataa(x6_1), .datab(VALONE), .result(x6_2)); // x6 // #24
	multi_l m11_l4 (.clock(clk_clk), .dataa(VALONE), .datab(x4_2), .result(x4_3));// x4 

	/*
	
	divi_L d1_l5 (.clock(clk_clk), .dataa(x2_5), .datab(FACT3), .result(d1)); // x^2 / 3! // #30
	divi_L d2_l5 (.clock(clk_clk), .dataa(x4_3), .datab(FACT5), .result(d2)); // x^4 / 5!
	divi_L d3_l5 (.clock(clk_clk), .dataa(x6_2), .datab(FACT7), .result(d3)); // x^6 / 7!
	divi_L d4_l5 (.clock(clk_clk), .dataa(x8_1), .datab(FACT9), .result(d4)); // x^8 / 9!
	*/
	
	
	multi_l t1 (.clock(clk_clk), .dataa(x2_5), .datab(DFACT3), .result(d1)); // x^2 / 3! // #30
	multi_l t2 (.clock(clk_clk), .dataa(x4_3), .datab(DFACT5), .result(d2)); // x^4 / 5!
	multi_l t3 (.clock(clk_clk), .dataa(x6_2), .datab(DFACT7), .result(d3)); // x^6 / 7!
	multi_l t4 (.clock(clk_clk), .dataa(x8_1), .datab(DFACT9), .result(d4)); // x^8 / 9!
	

	addsubi_l a1_l6 (.add_sub(1'b0), .clock(clk_clk), .dataa(VALONE), .datab(d1), .result(ad1)); // 1 - (x^2/3!)
	addsubi_l a2_l6 (.add_sub(1'b0), .clock(clk_clk), .dataa(d2), .datab(d3), .result(ad2)); // (x^4 / 5!) - (x^6 / 7!)
	addsubi_l a3_l6 (.add_sub(1'b1), .clock(clk_clk), .dataa(32'h0), .datab(d4), .result(ad3)); // (x^8 / 9!)

	addsubi_l a4_l7 (.add_sub(1'b1), .clock(clk_clk), .dataa(ad2), .datab(ad3), .result(ad4)); // (x^4 / 5!) - (x^6 / 7!) + (x^8 / 9!)
	addsubi_l a5_l7 (.add_sub(1'b1), .clock(clk_clk), .dataa(32'h0), .datab(ad1), .result(ad5)); // 1 - (x^2/3!)

	addsubi_l a6_l8 (.add_sub(1'b1), .clock(clk_clk), .dataa(ad5), .datab(ad4), .result(adres)); // (1 - (x^2/3!)) + (x^4 / 5!) - (x^6 / 7!) + (x^8 / 9!)


	always @(posedge clk_clk) begin
		if (start_export == 1'b1) begin//
			s_count <= s_count + 32'd1;
			inx <= x_export;
					
		end
	end

	always @(posedge clk_clk) begin
		if (reset_reset_n == 1'b0) begin
			tempdone <= 1'b0;
			//tempout <= 32'b0;
			i <= 32'd0;
			s_count <= 32'd0;
			out_count <= 32'd0;
		end
		else begin

				//tempdone <= 1'b0;

 //
			
				if (adres != 32'b0) begin
					//fcompare <= adres;
					i <= i + 32'd1;
					/*
					if (fcompare != adres) begin //
						out_count <= 32'd1;
					end //
					*/

					if (i >= 1) begin //
						if (out_count >= s_count) begin
							tempdone <= 1'b0;
							tempout <= 32'b0;
						end
						else begin
							out_count <= out_count + 32'd1;
							tempdone <= 1'b1;
							tempout <= adres;	
							
						end
						
									

						//s_count <= s_count - 32'd1;
							
						
					end //
					
				
				end // else end
				//tempdone <= 1'b0;
		end
	end

	assign sinc_out_export = tempout;
	assign done_export = tempdone;


endmodule
