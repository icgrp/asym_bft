module t_switch_rand_top # (
	parameter num_leaves= 256,
	parameter payload_sz= 43,
	parameter p_sz= 52, //packet size
	parameter addr= 0,
	parameter level= 7
	)(
	input clk,
	input reset,
	input [p_sz-1:0] l_bus_i_top,
	input [p_sz-1:0] r_bus_i_top,
	input [p_sz-1:0] u_bus_i_top,
	output reg [p_sz-1:0] l_bus_o_top,
	output reg [p_sz-1:0] r_bus_o_top,
	output reg [p_sz-1:0] u_bus_o_top

);
	reg [p_sz-1:0] l_bus_i;
	reg [p_sz-1:0] r_bus_i;
	reg [p_sz-1:0] u_bus_i;
	wire [p_sz-1:0] l_bus_o;
	wire [p_sz-1:0] r_bus_o;
	wire [p_sz-1:0] u_bus_o;

	always@(posedge clk) begin
		if(reset) begin
			l_bus_o_top <= 0;
			r_bus_o_top <= 0;
			u_bus_o_top <= 0;
			l_bus_i <= 0;
			r_bus_i <= 0;
			u_bus_i <= 0;
		end else begin
			l_bus_o_top <= l_bus_o;
			r_bus_o_top <= r_bus_o;
			u_bus_o_top <= u_bus_o;
			l_bus_i <= l_bus_i_top;
			r_bus_i <= r_bus_i_top;
			u_bus_i <= u_bus_i_top;
		end
	end 


	t_switch_rand #(
	.num_leaves(num_leaves),
	.payload_sz(payload_sz),
	.addr(8),
	.level(level), // only change if level == 0
	.p_sz(p_sz) //packet size
	) t_switch_rand_1(
		.clk(clk),
		.reset(reset),
		.l_bus_i(l_bus_i),
		.r_bus_i(r_bus_i),
		.u_bus_i(u_bus_i),
		.l_bus_o(l_bus_o),
		.r_bus_o(r_bus_o),
		.u_bus_o(u_bus_o)
	);
	

endmodule