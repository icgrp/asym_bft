`include "common/direction_params.vh"
module pi_switch (
	input clk,
	input reset,
	input [p_sz-1:0] l_bus_i,
	input [p_sz-1:0] r_bus_i,
	input [p_sz-1:0] ul_bus_i,
	input [p_sz-1:0] ur_bus_i,
	output reg [p_sz-1:0] l_bus_o,
	output reg [p_sz-1:0] r_bus_o,
	output reg [p_sz-1:0] ul_bus_o,
	output reg [p_sz-1:0] ur_bus_o
	);
	// Override these values in top modules
	parameter num_leaves= 2;
	parameter payload_sz= 1;
	parameter addr= 1'b0;
	parameter level= 0; // only change if level == 0
	parameter p_sz= 1+$clog2(num_leaves)+payload_sz; //packet size
	
	// bus has following structure: 1 bit [valid], logN bits [dest_addr],
	// M bits [payload]
	
	wire [1:0] d_l;
	wire [1:0] d_r;
	wire [1:0] d_ul;
	wire [1:0] d_ur;
	wire [1:0] sel_l;
	wire [1:0] sel_r;
	wire [1:0] sel_ul;
	wire [1:0] sel_ur;
	reg random;
	wire rand_gen;

	direction_determiner #(.num_leaves(num_leaves), 
							.addr(addr),
							.level(level)) 
							dd_l(
							.valid_i(l_bus_i[p_sz-1]),
							.addr_i(l_bus_i[p_sz-2:payload_sz]), 
							.d(d_l));

	direction_determiner #(.num_leaves(num_leaves), 
							.addr(addr),
							.level(level)) 
							dd_r(
							.valid_i(r_bus_i[p_sz-1]),
							.addr_i(r_bus_i[p_sz-2:payload_sz]), 
							.d(d_r));

	direction_determiner #(.num_leaves(num_leaves), 
							.addr(addr),
							.level(level))
						   	dd_ul(
							.valid_i(ul_bus_i[p_sz-1]),
							.addr_i(ul_bus_i[p_sz-2:payload_sz]),
							.d(d_ul));

	direction_determiner #(.num_leaves(num_leaves), 
							.addr(addr),
							.level(level))
						   	dd_ur(
							.valid_i(ur_bus_i[p_sz-1]),
							.addr_i(ur_bus_i[p_sz-2:payload_sz]),
							.d(d_ur));
	always @(posedge clk)
		if (reset)
			random <= 1'b0;
		else if (rand_gen)
			random <= ~random;
						
	pi_arbiter #(
				.level(level))
				pi_a(
					.d_l(d_l),
					.d_r(d_r),
				   	.d_ul(d_ul),
				   	.d_ur(d_ur),
				   	.sel_l(sel_l),
				   	.sel_r(sel_r),
				   	.sel_ul(sel_ul),
				   	.sel_ur(sel_ur),
					.random(random),
					.rand_gen(rand_gen));

	always @(posedge clk)
		if (reset)
			{l_bus_o, r_bus_o, ul_bus_o, ur_bus_o} <= 0;
		else begin
			case (sel_l)
				`LEFT: l_bus_o<= l_bus_i;
				`RIGHT: l_bus_o<= r_bus_i;
				`UPL: l_bus_o<= ul_bus_i;
				`UPR: l_bus_o<= ur_bus_i;
			endcase
		
			case (sel_r)
				`LEFT: r_bus_o<= l_bus_i;
				`RIGHT: r_bus_o<= r_bus_i;
				`UPL: r_bus_o<= ul_bus_i;
				`UPR: r_bus_o<= ur_bus_i;
			endcase
			
			case (sel_ul)
				`LEFT: ul_bus_o <= l_bus_i;
				`RIGHT: ul_bus_o <= r_bus_i;
				`UPL: ul_bus_o <= ul_bus_i;
				`UPR: ul_bus_o <= ur_bus_i;
			endcase

			case (sel_ur)
				`LEFT: ur_bus_o <= l_bus_i;
				`RIGHT: ur_bus_o <= r_bus_i;
				`UPL: ur_bus_o <= ul_bus_i;
				`UPR: ur_bus_o <= ur_bus_i;
			endcase

		end
endmodule	