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

module t_switch #(
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
	input [p_sz-1:0] u_bus_i,
	output reg [p_sz-1:0] l_bus_o,
	output reg [p_sz-1:0] r_bus_o,
	output reg [p_sz-1:0] u_bus_o
	);
	
	// bus has following structure: 1 bit [valid], logN bits [dest_addr],
	// M bits [payload]
	
	wire [1:0] d_l;
	wire [1:0] d_r;
	wire [1:0] d_u;
	wire [1:0] sel_l;
	wire [1:0] sel_r;
	wire [1:0] sel_u;

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
						   	dd_u(
							.valid_i(u_bus_i[p_sz-1]),
							.addr_i(u_bus_i[p_sz-2:payload_sz]),
							.d(d_u));

						
	t_arbiter #(.level(level))
	t_a(d_l, d_r, d_u, sel_l, sel_r, sel_u);

	always @(posedge clk)
		if (reset)
			{l_bus_o, r_bus_o, u_bus_o} <= 0;
		else begin
			case (sel_l)
				`VOID: l_bus_o<= 0;
				`LEFT: l_bus_o<= l_bus_i;
				`RIGHT: l_bus_o<= r_bus_i;
				`UP: l_bus_o<= u_bus_i;
			endcase
		
			case (sel_r)
				`VOID: r_bus_o<= 0;
				`LEFT: r_bus_o<= l_bus_i;
				`RIGHT: r_bus_o<= r_bus_i;
				`UP: r_bus_o<= u_bus_i;
			endcase
			
			case (sel_u)
				`VOID: u_bus_o <= 0;
				`LEFT: u_bus_o <= l_bus_i;
				`RIGHT: u_bus_o <= r_bus_i;
				`UP: u_bus_o <= u_bus_i;
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

	// // override these values in top modules
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

module t_arbiter #(
	parameter level=0
	)(
	input [1:0] d_l,
	input [1:0] d_r,
	input [1:0] d_u,
	output reg [1:0] sel_l,
	output reg [1:0] sel_r,
	output reg [1:0] sel_u
	);
	
	// parameter level= 1;
	/*
	*	d_l, d_r, d_u designate where the specific packet from a certain
	*	direction would like to (ideally go).
	*	d_{l,r,u}=00, non-valid packet. 
	*   d_{l,r,u}=01, packet should go left.
	*	d_{l,r,u}=10, packet should go right.
   	*	d_{l,r,u}=11, packet should go up.
	*/

	generate
		if (level == 0)
			always @* begin
				sel_l= `VOID;
				sel_r= `VOID;
				sel_u= `VOID;
				if (d_l == `LEFT)
					sel_l= `LEFT;
				if (d_r == `RIGHT)
					sel_r= `RIGHT;
				if (sel_l == `VOID && d_r == `LEFT)
					sel_l= `RIGHT;
                                if (sel_l == `LEFT && d_r == `LEFT)
					sel_r= `RIGHT;			//return back
				if (sel_r == `VOID && d_l == `RIGHT)
					sel_r= `LEFT;			
				if (sel_r == `RIGHT && d_l == `RIGHT)
					sel_l= `LEFT;			//return back
			end
		else 
			/* 
			* select lines are for the MUX's that actually route the packets to the
			`UP* neighboring nodes. 
			*/
			always @* begin
				sel_l= `VOID;
				sel_r= `VOID;
				sel_u= `VOID;
				// First Priority: Turnback (When a packet has already been deflected
				// and needs to turn back within one level)
				if (d_l == `LEFT)
					sel_l= `LEFT;
				if (d_r == `RIGHT)
					sel_r= `RIGHT;
				if (d_u == `UP)
					sel_u= `UP;
				// Second Priority: Downlinks (When a packet wants to go from Up to
				// Left or Right-- must check if bus is already used by Turnbacked
				// packets)
				else if (d_u == `LEFT)
					if (d_l != `LEFT)
						sel_l= `UP;
					// If left bus is already used by turnback packet, deflect up
					// packet back up
					else
						sel_u= `UP;
				else if (d_u == `RIGHT)
					if (d_r != `RIGHT)
						sel_r= `UP;
					// If right bus is already used by turnback packet, deflect up
					// packet back up
					else
						sel_u= `UP;
				// Third Priority: `UP/Side Link
				// Left to Right
				if (d_l == `RIGHT)
					// if right bus is not already used by either a turnback packet or
					// a downlink packet, send left packet there
					if (sel_r == `VOID)
						sel_r= `LEFT;
					// otherwise, deflect left packet 
						// If downlink is already using left bus, deflect packet up
					else if (d_u == `LEFT)
						sel_u= `LEFT;
						// Last remaining option is deflection in direction of arrival
						// (must be correct, via deduction)
					else
						sel_l= `LEFT;
				// Left to Up
				else if (d_l == `UP)
					// if up bus is not occupied by turnback packet, send uplink up
					if (sel_u == `VOID)
						sel_u= `LEFT;
					// otherwise, deflect left packet
					// deflect back in direction of arrival if possible
					else if (sel_l == `VOID)
						sel_l= `LEFT;
					// otherwise, deflect to the right
					else
						sel_r= `LEFT;
				// Right to Left
				if (d_r == `LEFT)
					// if left bus is not occupied by turnback packet or downlink
					// paket, send right packet there
					if (sel_l == `VOID)
						sel_l= `RIGHT;
					// otherwise, deflect packet
					else if (sel_r == `VOID)
						sel_r= `RIGHT;
					else
						sel_u= `RIGHT;
				// Right to Up
				else if (d_r == `UP)
					// if up bus is not occupied by turnback packet or other uplink
					// packet, send right uplink packet up
					if (sel_u == `VOID)
						sel_u= `RIGHT;
					// else deflect right packet
					else if (sel_r == `VOID)
						sel_r= `RIGHT;
					// last possible option is to send packet to the left
					else
						sel_l= `RIGHT;
				`ifdef OPTIMIZED
				// Makes exception to when left and right packets swap, up packet gets
				// deflected up
				if (d_l == `RIGHT && d_r == `LEFT && d_u != `VOID) begin
					sel_l= `RIGHT;
					sel_r= `LEFT;
					sel_u= `UP;
				end
				`endif
			end
	endgenerate
endmodule
