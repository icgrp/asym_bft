`ifndef DIRECTION_PARAMS_H
`define DIRECTION_PARAMS_H
`define VOID 2'b00
`define LEFT 2'b01
`define RIGHT 2'b10
`define UP 2'b11
// Used for pi switch
`define UPL 2'b11
`define UPR 2'b00 // replaces VOID in t_switch
`endif

module pi_switch #(
	parameter num_leaves= 256,
	parameter payload_sz= 43,
	parameter addr= 8,
	parameter level= 7, // only change if level == 0
	parameter p_sz= 52 //packet size
	)(
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

module direction_determiner #(
	parameter num_leaves= 0,
	parameter addr= 0,
	parameter level= 0  //level = $bits(addr) 
	)(
	input valid_i,
	input [$clog2(num_leaves)-1:0] addr_i,
	output reg [1:0] d
	);

	// override these values in top modules
	// parameter num_leaves= 0;
	// parameter addr= 0;
	// parameter level= 0;  //level = $bits(addr) 

	generate
		if (level == 0) begin
			always @*
				if (valid_i) begin
					if (addr_i[$clog2(num_leaves)-1])
						d= `RIGHT;
					else
						d= `LEFT;
				end
				else
					d= `VOID;
			end
		else begin
			wire [level-1:0]  addr_xnor_addr_i= 
				~(addr ^ addr_i[$clog2(num_leaves)-1:$clog2(num_leaves) - level]);

			always @*
				if (valid_i == 1'b0)
					d= `VOID;
				else if (&addr_xnor_addr_i == 1'b1) begin
					if (addr_i[$clog2(num_leaves)-1 - level] == 1'b0)
						d= `LEFT;
					else
						d= `RIGHT;
				end
				else if (&addr_xnor_addr_i == 1'b0)
					d= `UP;
				else
					d= `VOID;
		end
	endgenerate
endmodule

module pi_arbiter #(
	parameter level=0
	)(
	input [1:0] d_l,
	input [1:0] d_r,
	input [1:0] d_ul,
	input [1:0] d_ur,
	input random,
	output reg rand_gen,
	output reg [1:0] sel_l,
	output reg [1:0] sel_r,
	output [1:0] sel_ul,
	output [1:0] sel_ur
	);
	
	// parameter level= 1;
	/*
	*	d_l, d_r, d_u designate where the specific packet from a 
	*	certain direction would like to (ideally) go.
	*	d_{l,r,u{l,r}}=00, non-valid packet. 
	*   d_{l,r,u{l,r}}=01, packet should go left.
	*	d_{l,r,u{l,r}}=10, packet should go right.
   	*	d_{l,r,u{l,r}}=11, packet should go up.
	*/

	reg [1:0] sel_u1;
	reg [1:0] sel_u2;

	assign sel_ul= random ? sel_u1 : sel_u2;
	assign sel_ur= random ? sel_u2 : sel_u1;

		
	// temp var just used to determine how to route non-valid packets
	reg [3:0] is_void; 

	always @* begin
		is_void= 4'b1111; // local var, order is L, R, U1, U2;
	
		rand_gen= 0;
		sel_l  = `VOID;
		sel_r  = `VOID;
		sel_u1 = `VOID;
		sel_u2 = `VOID;



		// First Priority: Turnback Packets
		if (d_l == `LEFT)
			{sel_l, is_void[3]}= {`LEFT, 1'b0};
		if (d_r == `RIGHT)
			{sel_r, is_void[2]}= {`RIGHT, 1'b0};
		if (d_ul == `UP)
			{sel_u1, is_void[1]}= {`UPL, 1'b0};
		if (d_ur == `UP)
			{sel_u2, is_void[0]}= {`UPR, 1'b0};

		// Second Priority: Downlinks
		// Left Downlink
		if (d_ul == `LEFT || d_ur == `LEFT) begin
			if (is_void[3]) begin
				is_void[3]= 1'b0;
				if (d_ul == `LEFT && d_ur != `LEFT)
					sel_l= `UPL;
				else if (d_ul != `LEFT && d_ur == `LEFT)
					sel_l= `UPR;
				else if (d_ul == `LEFT && d_ur == `LEFT) begin
					is_void[1]= 1'b0;
					{sel_l, sel_u1}= {`UPL, `UPR};
				end
			end
			else begin
				if (d_ul == `LEFT) begin
					is_void[1]= 1'b0;
					sel_u1= `UPL;
				end
				if (d_ur == `LEFT) begin
					is_void[0]= 1'b0;
					sel_u2= `UPR;
				end
			end
		end

		// Right Downlink
		if (d_ul == `RIGHT || d_ur == `RIGHT) begin
			if (is_void[2]) begin
				is_void[2]= 1'b0;
				if (d_ul == `RIGHT && d_ur != `RIGHT)
					sel_r= `UPL;
				else if (d_ul != `RIGHT && d_ur == `RIGHT)
					sel_r= `UPR;
				else if (d_ul == `RIGHT && d_ur == `RIGHT) begin
					is_void[1]= 1'b0;
					{sel_r, sel_u1}= {`UPL, `UPR};
				end
			end
			else begin
				if (d_ul == `RIGHT) begin
					is_void[1]= 1'b0;
					sel_u1= `UPL;
				end
				if (d_ur == `RIGHT) begin
					is_void[0]= 1'b0;
					sel_u2= `UPR;
				end
			end
		end


		// Third Priority: Side Link
		// Left to Right (Left has priority over Right)
		if (d_l == `RIGHT) begin
			if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `LEFT;
			end
			else if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `LEFT;
			end
			else if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `LEFT;
			end
			else if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `LEFT;
			end
		end

		// Right to Left
		if (d_r == `LEFT) begin
			if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `RIGHT;
			end
			else if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `RIGHT;
			end
			else if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `RIGHT;
			end
			else if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `RIGHT;
			end
		end
		// Fourth Priority: Uplinks
		// Left to Up
		if (d_l == `UP) begin
			if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `LEFT;
			end
			else if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `LEFT;
			end
			else if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `LEFT;
			end
			else if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `LEFT;
			end
		end
		// Right to UP
		if (d_r == `UP) begin
			if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `RIGHT;
			end
			else if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `RIGHT;
			end
			else if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `RIGHT;
			end
			else if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `RIGHT;
			end
		end

		// Before taking care of void case, determine whether or not a new
		// random/toggle bit should be generated
		if (is_void[1] == 1'b0 || is_void[0] == 1'b0)
			rand_gen= 1;

		// Final Priority: Void 
		if (d_l == `VOID) begin
			if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `LEFT;
			end
			if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `LEFT;
			end
			if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `LEFT;
			end
			if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `LEFT;
			end
		end
		if (d_r == `VOID) begin
			if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `RIGHT;
			end
			if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `RIGHT;
			end
			if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `RIGHT;
			end
			if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `RIGHT;
			end
		end
		if (d_ul == `VOID) begin
			if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `UPL;
			end
			if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `UPL;
			end
			if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `UPL;
			end
			if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `UPL;
			end
		end
		if (d_ur == `VOID) begin
			if (is_void[3]) begin
				is_void[3]= 1'b0;
				sel_l= `UPR;
			end
			if (is_void[2]) begin
				is_void[2]= 1'b0;
				sel_r= `UPR;
			end
			if (is_void[1]) begin
				is_void[1]= 1'b0;
				sel_u1= `UPR;
			end
			if (is_void[0]) begin
				is_void[0]= 1'b0;
				sel_u2= `UPR;
			end
		end
	end

endmodule
