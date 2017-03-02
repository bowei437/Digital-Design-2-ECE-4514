//  File         : state_p1.v
//  Author       : B. Zhao
//  Date         : 01/26/17
//  Version      : 1
//  Description  : This is the finite state machine for project 1

module state_p1(clock, reset, up, down, toggle, outval);
	input clock, reset;
	input [1:0]  up, down, toggle;
	output [3:0] outval;
	reg [3:0] state, intensityval;

	localparam s_reset = 4'd0, s_upbright = 4'd1, s_downdim = 4'd2, s_wait = 4'd3;

///////////////////////////
	always @(posedge clock or posedge reset) begin
		if (reset == 1'b1) begin
			state <= s_reset;
		end
		else if (up == 2'b01) begin
			case (state)
				s_reset: state <= s_upbright;
				s_wait: state <= s_upbright;
				s_upbright: state <= s_upbright;
				default: state <= s_reset;
			endcase
		end
		else if (up == 2'b11) begin
			case (state)

			endcase
		end
		else if (down == 2'b01) begin
			case (state)
				s_reset: state <= s_downdim;
				s_wait: state <= s_downdim;
				s_upbright: state <= s_downdim;
				default: state <= s_reset;
			endcase
		end
		else if (down == 2'b11) begin
			
		end
		else if (toggle == 2'b01) begin
			
		end
		else begin
			state <= s_wait;
			//state <= state;
		end
	end
////////////////////////////////////////////////

	always @* begin
		case (state)
			s_reset: begin
				intensityval = 4'd0;
			end
			s_upbright: begin
				if (intensityval >= 4'd15) begin
					intensityval = 4'd15;
				end
				else begin
					intensityval = intensityval + 4'd1;
				end
			end
			s_downdim: begin
				if (intensityval <= 4'd0) begin
					intensityval = 4'd0;
				end
				else begin
					intensityval = intensityval - 4'd1;
				end
			end
			s_wait: begin
				intensityval = intensityval;
			end
			default: state <= s_reset;
		endcase
		
	end

	assign outval[3:0] = intensityval[3:0];

endmodule      