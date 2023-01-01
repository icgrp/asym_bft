//--------level=0--------------
module  gen_nw # (
	parameter num_leaves= 32,
	parameter payload_sz= $clog2(num_leaves) + 4,
	parameter p_sz= 1 + $clog2(num_leaves) + payload_sz, //packet size
	parameter addr= 0,
	parameter level= 0
	) (
	input clk,
	input reset,
	input [p_sz*24-1:0] pe_interface,
	output [p_sz*24-1:0] interface_pe,
	output [24-1:0] resend
	);
	wire [p_sz*8-1:0] left_switch_0_0;
	wire [p_sz*8-1:0] right_switch_0_0;
	wire [p_sz*8-1:0] switch_left_0_0;
	wire [p_sz*8-1:0] switch_right_0_0;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(addr),
		.level(level),
		.p_sz(p_sz),
		.num_switches(8))
		pi_lvl0(
		.clk(clk),
		.reset(reset),
		.l_bus_i(left_switch_0_0),
		.r_bus_i(right_switch_0_0),
		.l_bus_o(switch_left_0_0),
		.r_bus_o(switch_right_0_0));


//--------level=1--------------
	wire [p_sz*4-1:0] left_switch_1_0;
	wire [p_sz*4-1:0] right_switch_1_0;
	wire [p_sz*4-1:0] switch_left_1_0;
	wire [p_sz*4-1:0] switch_right_1_0;
	wire [p_sz*4-1:0] left_switch_1_1;
	wire [p_sz*4-1:0] right_switch_1_1;
	wire [p_sz*4-1:0] switch_left_1_1;
	wire [p_sz*4-1:0] switch_right_1_1;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(1),
		.p_sz(p_sz),
		.num_switches(4)
		)pi_lvl_1_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_0_0),
		.u_bus_i(switch_left_0_0),
		.l_bus_i(left_switch_1_0),
		.r_bus_i(right_switch_1_0),
		.l_bus_o(switch_left_1_0),
		.r_bus_o(switch_right_1_0));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(1),
		.p_sz(p_sz),
		.num_switches(4)
		)pi_lvl_1_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_0_0),
		.u_bus_i(switch_right_0_0),
		.l_bus_i(left_switch_1_1),
		.r_bus_i(right_switch_1_1),
		.l_bus_o(switch_left_1_1),
		.r_bus_o(switch_right_1_1));


//--------level=2--------------
	wire [p_sz*4-1:0] left_switch_2_0;
	wire [p_sz*4-1:0] right_switch_2_0;
	wire [p_sz*4-1:0] switch_left_2_0;
	wire [p_sz*4-1:0] switch_right_2_0;
	wire [p_sz*4-1:0] left_switch_2_1;
	wire [p_sz*4-1:0] right_switch_2_1;
	wire [p_sz*4-1:0] switch_left_2_1;
	wire [p_sz*4-1:0] switch_right_2_1;
	wire [p_sz*4-1:0] left_switch_2_2;
	wire [p_sz*4-1:0] right_switch_2_2;
	wire [p_sz*4-1:0] switch_left_2_2;
	wire [p_sz*4-1:0] switch_right_2_2;
	// wire [p_sz*4-1:0] left_switch_2_3;
	// wire [p_sz*4-1:0] right_switch_2_3;
	// wire [p_sz*4-1:0] switch_left_2_3;
	// wire [p_sz*4-1:0] switch_right_2_3;
	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(2),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_2_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_1_0),
		.u_bus_i(switch_left_1_0),
		.l_bus_i(left_switch_2_0),
		.r_bus_i(right_switch_2_0),
		.l_bus_o(switch_left_2_0),
		.r_bus_o(switch_right_2_0));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(2),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_2_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_1_0),
		.u_bus_i(switch_right_1_0),
		.l_bus_i(left_switch_2_1),
		.r_bus_i(right_switch_2_1),
		.l_bus_o(switch_left_2_1),
		.r_bus_o(switch_right_2_1));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.level(2),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_2_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_1_1),
		.u_bus_i(switch_left_1_1),
		.l_bus_i(left_switch_2_2),
		.r_bus_i(right_switch_2_2),
		.l_bus_o(switch_left_2_2),
		.r_bus_o(switch_right_2_2));

	// t_cluster #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(3),
	// 	.level(2),
	// 	.p_sz(p_sz),
	// 	.num_switches(4)
	// 	)t_lvl_2_3(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.u_bus_o(right_switch_1_1),
	// 	.u_bus_i(switch_right_1_1),
	// 	.l_bus_i(left_switch_2_3),
	// 	.r_bus_i(right_switch_2_3),
	// 	.l_bus_o(switch_left_2_3),
	// 	.r_bus_o(switch_right_2_3));


//--------level=3--------------
	wire [p_sz*2-1:0] left_switch_3_0;
	wire [p_sz*2-1:0] right_switch_3_0;
	wire [p_sz*2-1:0] switch_left_3_0;
	wire [p_sz*2-1:0] switch_right_3_0;
	wire [p_sz*2-1:0] left_switch_3_1;
	wire [p_sz*2-1:0] right_switch_3_1;
	wire [p_sz*2-1:0] switch_left_3_1;
	wire [p_sz*2-1:0] switch_right_3_1;
	wire [p_sz*2-1:0] left_switch_3_2;
	wire [p_sz*2-1:0] right_switch_3_2;
	wire [p_sz*2-1:0] switch_left_3_2;
	wire [p_sz*2-1:0] switch_right_3_2;
	wire [p_sz*2-1:0] left_switch_3_3;
	wire [p_sz*2-1:0] right_switch_3_3;
	wire [p_sz*2-1:0] switch_left_3_3;
	wire [p_sz*2-1:0] switch_right_3_3;
	wire [p_sz*2-1:0] left_switch_3_4;
	wire [p_sz*2-1:0] right_switch_3_4;
	wire [p_sz*2-1:0] switch_left_3_4;
	wire [p_sz*2-1:0] switch_right_3_4;
	wire [p_sz*2-1:0] left_switch_3_5;
	wire [p_sz*2-1:0] right_switch_3_5;
	wire [p_sz*2-1:0] switch_left_3_5;
	wire [p_sz*2-1:0] switch_right_3_5;
	// wire [p_sz*2-1:0] left_switch_3_6;
	// wire [p_sz*2-1:0] right_switch_3_6;
	// wire [p_sz*2-1:0] switch_left_3_6;
	// wire [p_sz*2-1:0] switch_right_3_6;
	// wire [p_sz*2-1:0] left_switch_3_7;
	// wire [p_sz*2-1:0] right_switch_3_7;
	// wire [p_sz*2-1:0] switch_left_3_7;
	// wire [p_sz*2-1:0] switch_right_3_7;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(3),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_3_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_2_0),
		.u_bus_i(switch_left_2_0),
		.l_bus_i(left_switch_3_0),
		.r_bus_i(right_switch_3_0),
		.l_bus_o(switch_left_3_0),
		.r_bus_o(switch_right_3_0));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(3),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_3_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_2_0),
		.u_bus_i(switch_right_2_0),
		.l_bus_i(left_switch_3_1),
		.r_bus_i(right_switch_3_1),
		.l_bus_o(switch_left_3_1),
		.r_bus_o(switch_right_3_1));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.level(3),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_3_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_2_1),
		.u_bus_i(switch_left_2_1),
		.l_bus_i(left_switch_3_2),
		.r_bus_i(right_switch_3_2),
		.l_bus_o(switch_left_3_2),
		.r_bus_o(switch_right_3_2));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.level(3),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_3_3(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_2_1),
		.u_bus_i(switch_right_2_1),
		.l_bus_i(left_switch_3_3),
		.r_bus_i(right_switch_3_3),
		.l_bus_o(switch_left_3_3),
		.r_bus_o(switch_right_3_3));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(4),
		.level(3),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_3_4(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_2_2),
		.u_bus_i(switch_left_2_2),
		.l_bus_i(left_switch_3_4),
		.r_bus_i(right_switch_3_4),
		.l_bus_o(switch_left_3_4),
		.r_bus_o(switch_right_3_4));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(5),
		.level(3),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_3_5(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_2_2),
		.u_bus_i(switch_right_2_2),
		.l_bus_i(left_switch_3_5),
		.r_bus_i(right_switch_3_5),
		.l_bus_o(switch_left_3_5),
		.r_bus_o(switch_right_3_5));

	// pi_cluster #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(6),
	// 	.level(3),
	// 	.p_sz(p_sz),
	// 	.num_switches(2)
	// 	)pi_lvl_3_6(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.u_bus_o(left_switch_2_3),
	// 	.u_bus_i(switch_left_2_3),
	// 	.l_bus_i(left_switch_3_6),
	// 	.r_bus_i(right_switch_3_6),
	// 	.l_bus_o(switch_left_3_6),
	// 	.r_bus_o(switch_right_3_6));

	// pi_cluster #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(7),
	// 	.level(3),
	// 	.p_sz(p_sz),
	// 	.num_switches(2)
	// 	)pi_lvl_3_7(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.u_bus_o(right_switch_2_3),
	// 	.u_bus_i(switch_right_2_3),
	// 	.l_bus_i(left_switch_3_7),
	// 	.r_bus_i(right_switch_3_7),
	// 	.l_bus_o(switch_left_3_7),
	// 	.r_bus_o(switch_right_3_7));


//--------level=4--------------
	wire [p_sz*1-1:0] left_switch_4_0;
	wire [p_sz*1-1:0] right_switch_4_0;
	wire [p_sz*1-1:0] switch_left_4_0;
	wire [p_sz*1-1:0] switch_right_4_0;
	wire [p_sz*1-1:0] left_switch_4_1;
	wire [p_sz*1-1:0] right_switch_4_1;
	wire [p_sz*1-1:0] switch_left_4_1;
	wire [p_sz*1-1:0] switch_right_4_1;
	wire [p_sz*1-1:0] left_switch_4_2;
	wire [p_sz*1-1:0] right_switch_4_2;
	wire [p_sz*1-1:0] switch_left_4_2;
	wire [p_sz*1-1:0] switch_right_4_2;
	wire [p_sz*1-1:0] left_switch_4_3;
	wire [p_sz*1-1:0] right_switch_4_3;
	wire [p_sz*1-1:0] switch_left_4_3;
	wire [p_sz*1-1:0] switch_right_4_3;
	wire [p_sz*1-1:0] left_switch_4_4;
	wire [p_sz*1-1:0] right_switch_4_4;
	wire [p_sz*1-1:0] switch_left_4_4;
	wire [p_sz*1-1:0] switch_right_4_4;
	wire [p_sz*1-1:0] left_switch_4_5;
	wire [p_sz*1-1:0] right_switch_4_5;
	wire [p_sz*1-1:0] switch_left_4_5;
	wire [p_sz*1-1:0] switch_right_4_5;
	wire [p_sz*1-1:0] left_switch_4_6;
	wire [p_sz*1-1:0] right_switch_4_6;
	wire [p_sz*1-1:0] switch_left_4_6;
	wire [p_sz*1-1:0] switch_right_4_6;
	wire [p_sz*1-1:0] left_switch_4_7;
	wire [p_sz*1-1:0] right_switch_4_7;
	wire [p_sz*1-1:0] switch_left_4_7;
	wire [p_sz*1-1:0] switch_right_4_7;
	wire [p_sz*1-1:0] left_switch_4_8;
	wire [p_sz*1-1:0] right_switch_4_8;
	wire [p_sz*1-1:0] switch_left_4_8;
	wire [p_sz*1-1:0] switch_right_4_8;
	wire [p_sz*1-1:0] left_switch_4_9;
	wire [p_sz*1-1:0] right_switch_4_9;
	wire [p_sz*1-1:0] switch_left_4_9;
	wire [p_sz*1-1:0] switch_right_4_9;
	wire [p_sz*1-1:0] left_switch_4_10;
	wire [p_sz*1-1:0] right_switch_4_10;
	wire [p_sz*1-1:0] switch_left_4_10;
	wire [p_sz*1-1:0] switch_right_4_10;
	wire [p_sz*1-1:0] left_switch_4_11;
	wire [p_sz*1-1:0] right_switch_4_11;
	wire [p_sz*1-1:0] switch_left_4_11;
	wire [p_sz*1-1:0] switch_right_4_11;
	// wire [p_sz*1-1:0] left_switch_4_12;
	// wire [p_sz*1-1:0] right_switch_4_12;
	// wire [p_sz*1-1:0] switch_left_4_12;
	// wire [p_sz*1-1:0] switch_right_4_12;
	// wire [p_sz*1-1:0] left_switch_4_13;
	// wire [p_sz*1-1:0] right_switch_4_13;
	// wire [p_sz*1-1:0] switch_left_4_13;
	// wire [p_sz*1-1:0] switch_right_4_13;
	// wire [p_sz*1-1:0] left_switch_4_14;
	// wire [p_sz*1-1:0] right_switch_4_14;
	// wire [p_sz*1-1:0] switch_left_4_14;
	// wire [p_sz*1-1:0] switch_right_4_14;
	// wire [p_sz*1-1:0] left_switch_4_15;
	// wire [p_sz*1-1:0] right_switch_4_15;
	// wire [p_sz*1-1:0] switch_left_4_15;
	// wire [p_sz*1-1:0] switch_right_4_15;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_0),
		.u_bus_i(switch_left_3_0),
		.l_bus_i(left_switch_4_0),
		.r_bus_i(right_switch_4_0),
		.l_bus_o(switch_left_4_0),
		.r_bus_o(switch_right_4_0));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_0),
		.u_bus_i(switch_right_3_0),
		.l_bus_i(left_switch_4_1),
		.r_bus_i(right_switch_4_1),
		.l_bus_o(switch_left_4_1),
		.r_bus_o(switch_right_4_1));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_1),
		.u_bus_i(switch_left_3_1),
		.l_bus_i(left_switch_4_2),
		.r_bus_i(right_switch_4_2),
		.l_bus_o(switch_left_4_2),
		.r_bus_o(switch_right_4_2));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_3(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_1),
		.u_bus_i(switch_right_3_1),
		.l_bus_i(left_switch_4_3),
		.r_bus_i(right_switch_4_3),
		.l_bus_o(switch_left_4_3),
		.r_bus_o(switch_right_4_3));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(4),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_4(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_2),
		.u_bus_i(switch_left_3_2),
		.l_bus_i(left_switch_4_4),
		.r_bus_i(right_switch_4_4),
		.l_bus_o(switch_left_4_4),
		.r_bus_o(switch_right_4_4));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(5),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_5(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_2),
		.u_bus_i(switch_right_3_2),
		.l_bus_i(left_switch_4_5),
		.r_bus_i(right_switch_4_5),
		.l_bus_o(switch_left_4_5),
		.r_bus_o(switch_right_4_5));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(6),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_6(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_3),
		.u_bus_i(switch_left_3_3),
		.l_bus_i(left_switch_4_6),
		.r_bus_i(right_switch_4_6),
		.l_bus_o(switch_left_4_6),
		.r_bus_o(switch_right_4_6));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(7),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_7(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_3),
		.u_bus_i(switch_right_3_3),
		.l_bus_i(left_switch_4_7),
		.r_bus_i(right_switch_4_7),
		.l_bus_o(switch_left_4_7),
		.r_bus_o(switch_right_4_7));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(8),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_8(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_4),
		.u_bus_i(switch_left_3_4),
		.l_bus_i(left_switch_4_8),
		.r_bus_i(right_switch_4_8),
		.l_bus_o(switch_left_4_8),
		.r_bus_o(switch_right_4_8));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(9),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_9(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_4),
		.u_bus_i(switch_right_3_4),
		.l_bus_i(left_switch_4_9),
		.r_bus_i(right_switch_4_9),
		.l_bus_o(switch_left_4_9),
		.r_bus_o(switch_right_4_9));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(10),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_10(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_5),
		.u_bus_i(switch_left_3_5),
		.l_bus_i(left_switch_4_10),
		.r_bus_i(right_switch_4_10),
		.l_bus_o(switch_left_4_10),
		.r_bus_o(switch_right_4_10));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(11),
		.level(4),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_4_11(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_5),
		.u_bus_i(switch_right_3_5),
		.l_bus_i(left_switch_4_11),
		.r_bus_i(right_switch_4_11),
		.l_bus_o(switch_left_4_11),
		.r_bus_o(switch_right_4_11));

	// pi_cluster #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(12),
	// 	.level(4),
	// 	.p_sz(p_sz),
	// 	.num_switches(1)
	// 	)pi_lvl_4_12(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.u_bus_o(left_switch_3_6),
	// 	.u_bus_i(switch_left_3_6),
	// 	.l_bus_i(left_switch_4_12),
	// 	.r_bus_i(right_switch_4_12),
	// 	.l_bus_o(switch_left_4_12),
	// 	.r_bus_o(switch_right_4_12));

	// pi_cluster #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(13),
	// 	.level(4),
	// 	.p_sz(p_sz),
	// 	.num_switches(1)
	// 	)pi_lvl_4_13(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.u_bus_o(right_switch_3_6),
	// 	.u_bus_i(switch_right_3_6),
	// 	.l_bus_i(left_switch_4_13),
	// 	.r_bus_i(right_switch_4_13),
	// 	.l_bus_o(switch_left_4_13),
	// 	.r_bus_o(switch_right_4_13));

	// pi_cluster #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(14),
	// 	.level(4),
	// 	.p_sz(p_sz),
	// 	.num_switches(1)
	// 	)pi_lvl_4_14(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.u_bus_o(left_switch_3_7),
	// 	.u_bus_i(switch_left_3_7),
	// 	.l_bus_i(left_switch_4_14),
	// 	.r_bus_i(right_switch_4_14),
	// 	.l_bus_o(switch_left_4_14),
	// 	.r_bus_o(switch_right_4_14));

	// pi_cluster #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(15),
	// 	.level(4),
	// 	.p_sz(p_sz),
	// 	.num_switches(1)
	// 	)pi_lvl_4_15(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.u_bus_o(right_switch_3_7),
	// 	.u_bus_i(switch_right_3_7),
	// 	.l_bus_i(left_switch_4_15),
	// 	.r_bus_i(right_switch_4_15),
	// 	.l_bus_o(switch_left_4_15),
	// 	.r_bus_o(switch_right_4_15));


//--------level=5--------------
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.p_sz(p_sz)
		)interface_0(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_0),
		.bus_o(left_switch_4_0),
		.pe_interface(pe_interface[p_sz*1-1:p_sz*0]),
		.interface_pe(interface_pe[p_sz*1-1:p_sz*0]),
		.resend(resend[0]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.p_sz(p_sz)
		)interface_1(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_0),
		.bus_o(right_switch_4_0),
		.pe_interface(pe_interface[p_sz*2-1:p_sz*1]),
		.interface_pe(interface_pe[p_sz*2-1:p_sz*1]),
		.resend(resend[1]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.p_sz(p_sz)
		)interface_2(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_1),
		.bus_o(left_switch_4_1),
		.pe_interface(pe_interface[p_sz*3-1:p_sz*2]),
		.interface_pe(interface_pe[p_sz*3-1:p_sz*2]),
		.resend(resend[2]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.p_sz(p_sz)
		)interface_3(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_1),
		.bus_o(right_switch_4_1),
		.pe_interface(pe_interface[p_sz*4-1:p_sz*3]),
		.interface_pe(interface_pe[p_sz*4-1:p_sz*3]),
		.resend(resend[3]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(4),
		.p_sz(p_sz)
		)interface_4(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_2),
		.bus_o(left_switch_4_2),
		.pe_interface(pe_interface[p_sz*5-1:p_sz*4]),
		.interface_pe(interface_pe[p_sz*5-1:p_sz*4]),
		.resend(resend[4]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(5),
		.p_sz(p_sz)
		)interface_5(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_2),
		.bus_o(right_switch_4_2),
		.pe_interface(pe_interface[p_sz*6-1:p_sz*5]),
		.interface_pe(interface_pe[p_sz*6-1:p_sz*5]),
		.resend(resend[5]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(6),
		.p_sz(p_sz)
		)interface_6(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_3),
		.bus_o(left_switch_4_3),
		.pe_interface(pe_interface[p_sz*7-1:p_sz*6]),
		.interface_pe(interface_pe[p_sz*7-1:p_sz*6]),
		.resend(resend[6]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(7),
		.p_sz(p_sz)
		)interface_7(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_3),
		.bus_o(right_switch_4_3),
		.pe_interface(pe_interface[p_sz*8-1:p_sz*7]),
		.interface_pe(interface_pe[p_sz*8-1:p_sz*7]),
		.resend(resend[7]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(8),
		.p_sz(p_sz)
		)interface_8(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_4),
		.bus_o(left_switch_4_4),
		.pe_interface(pe_interface[p_sz*9-1:p_sz*8]),
		.interface_pe(interface_pe[p_sz*9-1:p_sz*8]),
		.resend(resend[8]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(9),
		.p_sz(p_sz)
		)interface_9(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_4),
		.bus_o(right_switch_4_4),
		.pe_interface(pe_interface[p_sz*10-1:p_sz*9]),
		.interface_pe(interface_pe[p_sz*10-1:p_sz*9]),
		.resend(resend[9]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(10),
		.p_sz(p_sz)
		)interface_10(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_5),
		.bus_o(left_switch_4_5),
		.pe_interface(pe_interface[p_sz*11-1:p_sz*10]),
		.interface_pe(interface_pe[p_sz*11-1:p_sz*10]),
		.resend(resend[10]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(11),
		.p_sz(p_sz)
		)interface_11(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_5),
		.bus_o(right_switch_4_5),
		.pe_interface(pe_interface[p_sz*12-1:p_sz*11]),
		.interface_pe(interface_pe[p_sz*12-1:p_sz*11]),
		.resend(resend[11]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(12),
		.p_sz(p_sz)
		)interface_12(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_6),
		.bus_o(left_switch_4_6),
		.pe_interface(pe_interface[p_sz*13-1:p_sz*12]),
		.interface_pe(interface_pe[p_sz*13-1:p_sz*12]),
		.resend(resend[12]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(13),
		.p_sz(p_sz)
		)interface_13(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_6),
		.bus_o(right_switch_4_6),
		.pe_interface(pe_interface[p_sz*14-1:p_sz*13]),
		.interface_pe(interface_pe[p_sz*14-1:p_sz*13]),
		.resend(resend[13]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(14),
		.p_sz(p_sz)
		)interface_14(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_7),
		.bus_o(left_switch_4_7),
		.pe_interface(pe_interface[p_sz*15-1:p_sz*14]),
		.interface_pe(interface_pe[p_sz*15-1:p_sz*14]),
		.resend(resend[14]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(15),
		.p_sz(p_sz)
		)interface_15(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_7),
		.bus_o(right_switch_4_7),
		.pe_interface(pe_interface[p_sz*16-1:p_sz*15]),
		.interface_pe(interface_pe[p_sz*16-1:p_sz*15]),
		.resend(resend[15]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(16),
		.p_sz(p_sz)
		)interface_16(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_8),
		.bus_o(left_switch_4_8),
		.pe_interface(pe_interface[p_sz*17-1:p_sz*16]),
		.interface_pe(interface_pe[p_sz*17-1:p_sz*16]),
		.resend(resend[16]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(17),
		.p_sz(p_sz)
		)interface_17(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_8),
		.bus_o(right_switch_4_8),
		.pe_interface(pe_interface[p_sz*18-1:p_sz*17]),
		.interface_pe(interface_pe[p_sz*18-1:p_sz*17]),
		.resend(resend[17]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(18),
		.p_sz(p_sz)
		)interface_18(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_9),
		.bus_o(left_switch_4_9),
		.pe_interface(pe_interface[p_sz*19-1:p_sz*18]),
		.interface_pe(interface_pe[p_sz*19-1:p_sz*18]),
		.resend(resend[18]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(19),
		.p_sz(p_sz)
		)interface_19(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_9),
		.bus_o(right_switch_4_9),
		.pe_interface(pe_interface[p_sz*20-1:p_sz*19]),
		.interface_pe(interface_pe[p_sz*20-1:p_sz*19]),
		.resend(resend[19]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(20),
		.p_sz(p_sz)
		)interface_20(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_10),
		.bus_o(left_switch_4_10),
		.pe_interface(pe_interface[p_sz*21-1:p_sz*20]),
		.interface_pe(interface_pe[p_sz*21-1:p_sz*20]),
		.resend(resend[20]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(21),
		.p_sz(p_sz)
		)interface_21(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_10),
		.bus_o(right_switch_4_10),
		.pe_interface(pe_interface[p_sz*22-1:p_sz*21]),
		.interface_pe(interface_pe[p_sz*22-1:p_sz*21]),
		.resend(resend[21]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(22),
		.p_sz(p_sz)
		)interface_22(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_4_11),
		.bus_o(left_switch_4_11),
		.pe_interface(pe_interface[p_sz*23-1:p_sz*22]),
		.interface_pe(interface_pe[p_sz*23-1:p_sz*22]),
		.resend(resend[22]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(23),
		.p_sz(p_sz)
		)interface_23(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_4_11),
		.bus_o(right_switch_4_11),
		.pe_interface(pe_interface[p_sz*24-1:p_sz*23]),
		.interface_pe(interface_pe[p_sz*24-1:p_sz*23]),
		.resend(resend[23]));
	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(24),
	// 	.p_sz(p_sz)
	// 	)interface_24(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_left_4_12),
	// 	.bus_o(left_switch_4_12),
	// 	.pe_interface(pe_interface[p_sz*25-1:p_sz*24]),
	// 	.interface_pe(interface_pe[p_sz*25-1:p_sz*24]),
	// 	.resend(resend[24]));

	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(25),
	// 	.p_sz(p_sz)
	// 	)interface_25(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_right_4_12),
	// 	.bus_o(right_switch_4_12),
	// 	.pe_interface(pe_interface[p_sz*26-1:p_sz*25]),
	// 	.interface_pe(interface_pe[p_sz*26-1:p_sz*25]),
	// 	.resend(resend[25]));
	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(26),
	// 	.p_sz(p_sz)
	// 	)interface_26(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_left_4_13),
	// 	.bus_o(left_switch_4_13),
	// 	.pe_interface(pe_interface[p_sz*27-1:p_sz*26]),
	// 	.interface_pe(interface_pe[p_sz*27-1:p_sz*26]),
	// 	.resend(resend[26]));

	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(27),
	// 	.p_sz(p_sz)
	// 	)interface_27(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_right_4_13),
	// 	.bus_o(right_switch_4_13),
	// 	.pe_interface(pe_interface[p_sz*28-1:p_sz*27]),
	// 	.interface_pe(interface_pe[p_sz*28-1:p_sz*27]),
	// 	.resend(resend[27]));
	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(28),
	// 	.p_sz(p_sz)
	// 	)interface_28(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_left_4_14),
	// 	.bus_o(left_switch_4_14),
	// 	.pe_interface(pe_interface[p_sz*29-1:p_sz*28]),
	// 	.interface_pe(interface_pe[p_sz*29-1:p_sz*28]),
	// 	.resend(resend[28]));

	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(29),
	// 	.p_sz(p_sz)
	// 	)interface_29(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_right_4_14),
	// 	.bus_o(right_switch_4_14),
	// 	.pe_interface(pe_interface[p_sz*30-1:p_sz*29]),
	// 	.interface_pe(interface_pe[p_sz*30-1:p_sz*29]),
	// 	.resend(resend[29]));
	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(30),
	// 	.p_sz(p_sz)
	// 	)interface_30(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_left_4_15),
	// 	.bus_o(left_switch_4_15),
	// 	.pe_interface(pe_interface[p_sz*31-1:p_sz*30]),
	// 	.interface_pe(interface_pe[p_sz*31-1:p_sz*30]),
	// 	.resend(resend[30]));

	// interface #(
	// 	.num_leaves(num_leaves),
	// 	.payload_sz(payload_sz),
	// 	.addr(31),
	// 	.p_sz(p_sz)
	// 	)interface_31(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.bus_i(switch_right_4_15),
	// 	.bus_o(right_switch_4_15),
	// 	.pe_interface(pe_interface[p_sz*32-1:p_sz*31]),
	// 	.interface_pe(interface_pe[p_sz*32-1:p_sz*31]),
	// 	.resend(resend[31]));
endmodule


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

module direction_determiner (
	input valid_i,
	input [$clog2(num_leaves)-1:0] addr_i,
	output reg [1:0] d
	);

	// override these values in top modules
	parameter num_leaves= 0;
	parameter addr= 0;
	parameter level= 0;  //level = $bits(addr) 

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
/*
module interface #(
    parameter num_leaves= 2,
    parameter payload_sz= 1,
    parameter addr= 1'b0,
    parameter p_sz= 1 + $clog2(num_leaves) + payload_sz //packet size
    ) (
    input clk, 
    input reset, 
    input [p_sz-1:0] bus_i,
    output reg [p_sz-1:0] bus_o, 
    input [p_sz-1:0] pe_interface,
    output reg [p_sz-1:0] interface_pe,
    output resend
    );



    wire accept_packet;
    wire send_packet;
    assign accept_packet= bus_i[p_sz-1] && (bus_i[p_sz-2:payload_sz] == addr);
    assign send_packet= !(bus_i[p_sz-1] && addr != bus_i[p_sz-2:payload_sz]);
    assign resend = !send_packet;
    
    always @(posedge clk) begin
    //    cache_o <= pe_interface;
        if (reset)
            {interface_pe, bus_o} <= 0;
        else begin
            if (accept_packet) interface_pe <= bus_i;
            else interface_pe <= 0;
            
            if (send_packet) begin            
                bus_o <=  pe_interface;   
            end else begin
                bus_o <= bus_i;
            end
       end
   end
    
endmodule
*/
module interface (
	input clk, 
	input reset, 
	input [p_sz-1:0] bus_i,
	output reg [p_sz-1:0] bus_o, 
	input [p_sz-1:0] pe_interface,
	output reg [p_sz-1:0] interface_pe,
	output resend
	);

	parameter num_leaves= 2;
	parameter payload_sz= 1;
	parameter addr= 1'b0;
	parameter p_sz= 1 + $clog2(num_leaves) + payload_sz; //packet size

	wire accept_packet;
	wire send_packet;
	assign accept_packet= bus_i[p_sz-1] && 
			(bus_i[p_sz-2:payload_sz] == addr);
	assign send_packet= !(bus_i[p_sz-1] && 
		addr != bus_i[p_sz-2:payload_sz]);

	reg winc, rinc;
	wire [p_sz-1:0] wdata, rdata;
	wire rempty;

	SynFIFO #(
		.DSIZE(p_sz),
		.ASIZE(2))
		FIFI_u (
		.clk(clk),
		.rst_n(~reset),
		.rdata(rdata), 
		.wfull(resend), 
		.rempty(rempty), 
		.wdata(pe_interface),
		.winc(pe_interface[p_sz-1]), 
		.rinc(send_packet && ~rempty) 
		);

	always @(posedge clk) begin
	//	cache_o <= pe_interface;
		if (reset)
			{interface_pe, bus_o} <= 0;
		else begin
			if (accept_packet)
				interface_pe <= bus_i;
			else
				interface_pe <= 0;
			if (send_packet) begin			
				if (rempty)
					bus_o <= 0;
				else
					bus_o <=  rdata;
				
			end
			else begin
				bus_o <= bus_i;
			end
		end
	end
	
endmodule

module pipe_ff (
	input clk, 
	input reset, 
	input [data_width-1:0] din,
	output reg [data_width-1:0] dout 
	);

	parameter data_width= 2;


	always @(posedge clk) begin
		if (reset)
			dout <= 0;
		else
			dout <=din;
	end
	
endmodule


module SynFIFO (
	clk,
	rst_n,
	rdata, 
	wfull, 
	rempty, 
	wdata,
	winc, 
	rinc
	);
	
parameter DSIZE = 8;
parameter ASIZE = 2;
parameter MEMDEPTH = 1<<ASIZE;


output [DSIZE-1:0] rdata;
output wfull;
output rempty;

input [DSIZE-1:0] wdata;
input winc, rinc, clk, rst_n;

reg [ASIZE:0] wptr;
reg [ASIZE:0] rptr;
reg [DSIZE-1:0] ex_mem [0:MEMDEPTH-1];

wire wfull_r;
wire [ASIZE:0] wptr_1;

always @(posedge clk or negedge rst_n)
	if (!rst_n) wptr <= 0;
	else if (winc && !wfull_r) begin
		ex_mem[wptr[ASIZE-1:0]] <= wdata;
		wptr <= wptr+1;
	end


always @(posedge clk or negedge rst_n)
	if (!rst_n) rptr <= 0;
	else if (rinc && !rempty) rptr <= rptr+1;

assign wptr_1 = wptr + 1;	
assign rdata = ex_mem[rptr[ASIZE-1:0]];
assign rempty = (rptr == wptr);
assign wfull = ((wptr_1[ASIZE-1:0] == rptr[ASIZE-1:0]) && (wptr_1[ASIZE] != rptr[ASIZE]) && winc) || wfull_r;
assign wfull_r = (wptr[ASIZE-1:0] == rptr[ASIZE-1:0]) && (wptr[ASIZE] != rptr[ASIZE]);
endmodule

/*
module pipe_ff (
	input clk, 
	input reset, 
	input [data_width-1:0] din,
	output reg [data_width-1:0] dout 
	);

	parameter data_width= 2;


	always @(posedge clk) begin
		if (reset)
			dout <= 0;
		else
			dout <=din;
	end
	
endmodule

*/

`define PI_SWITCH

module pi_arbiter(
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
	
	parameter level= 1;
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


module pi_cluster (
	input clk,
	input reset,
	input [num_switches*p_sz-1:0] l_bus_i,
	input [num_switches*p_sz-1:0] r_bus_i,
	input [2*num_switches*p_sz-1:0] u_bus_i,
	output [num_switches*p_sz-1:0] l_bus_o,
	output [num_switches*p_sz-1:0] r_bus_o,
	output [2*num_switches*p_sz-1:0] u_bus_o
	);
	// Override these values in top modules
	parameter num_leaves= 2;
	parameter payload_sz= 1;
	parameter addr= 1'b0;
	parameter level= 1; // only change if level == 0
	parameter p_sz= 1+$clog2(num_leaves)+payload_sz; //packet size
	parameter num_switches= 1;

	wire [num_switches*p_sz-1:0] ul_bus_i;
	wire [num_switches*p_sz-1:0] ur_bus_i;
	wire [num_switches*p_sz-1:0] ul_bus_o;
	wire [num_switches*p_sz-1:0] ur_bus_o;
	
	assign {ul_bus_i, ur_bus_i} = u_bus_i;
	assign u_bus_o= {ul_bus_o, ur_bus_o};
	genvar i;
	generate
	for (i= 0; i < num_switches; i= i + 1) begin
		pi_switch #(
			.num_leaves(num_leaves),
			.payload_sz(payload_sz),
			.addr(addr),
			.level(level),
			.p_sz(p_sz))
			ps (
				.clk(clk),
				.reset(reset),
				.l_bus_i(l_bus_i[i*p_sz+:p_sz]),
				.r_bus_i(r_bus_i[i*p_sz+:p_sz]),
				.ul_bus_i(ul_bus_i[i*p_sz+:p_sz]),
				.ur_bus_i(ur_bus_i[i*p_sz+:p_sz]),
				.l_bus_o(l_bus_o[i*p_sz+:p_sz]),
				.r_bus_o(r_bus_o[i*p_sz+:p_sz]),
				.ul_bus_o(ul_bus_o[i*p_sz+:p_sz]),
				.ur_bus_o(ur_bus_o[i*p_sz+:p_sz]));
	end
	endgenerate
endmodule	


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



module t_arbiter(
	input [1:0] d_l,
	input [1:0] d_r,
	input [1:0] d_u,
	output reg [1:0] sel_l,
	output reg [1:0] sel_r,
	output reg [1:0] sel_u
	);
	
	parameter level= 1;
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
					sel_r= `RIGHT;
				if (sel_r == `VOID && d_l == `RIGHT)
					sel_r= `LEFT;
				if (sel_r == `RIGHT && d_l == `RIGHT)
					sel_l= `LEFT;
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


module t_cluster (
	input clk,
	input reset,
	input [num_switches*p_sz-1:0] l_bus_i,
	input [num_switches*p_sz-1:0] r_bus_i,
	input [num_switches*p_sz-1:0] u_bus_i,
	output [num_switches*p_sz-1:0] l_bus_o,
	output [num_switches*p_sz-1:0] r_bus_o,
	output [num_switches*p_sz-1:0] u_bus_o
	);
	// Override these values in top modules
	parameter num_leaves= 2;
	parameter payload_sz= 1;
	parameter addr= 1'b0;
	//parameter level= $bits(addr); // only change if level == 0
        parameter level= 15;
	parameter p_sz= 1+$clog2(num_leaves)+payload_sz; //packet size
	parameter num_switches= 1;

	genvar i;
	generate
	for (i= 0; i < num_switches; i= i + 1) begin
		t_switch #(
			.num_leaves(num_leaves),
			.payload_sz(payload_sz),
			.addr(addr),
			.level(level),
			.p_sz(p_sz))
			ts (
				.clk(clk),
				.reset(reset),
				.l_bus_i(l_bus_i[i*p_sz+:p_sz]),
				.r_bus_i(r_bus_i[i*p_sz+:p_sz]),
				.u_bus_i(u_bus_i[i*p_sz+:p_sz]),
				.l_bus_o(l_bus_o[i*p_sz+:p_sz]),
				.r_bus_o(r_bus_o[i*p_sz+:p_sz]),
				.u_bus_o(u_bus_o[i*p_sz+:p_sz]));
	end
	endgenerate
endmodule	


module t_switch (
	input clk,
	input reset,
	input [p_sz-1:0] l_bus_i,
	input [p_sz-1:0] r_bus_i,
	input [p_sz-1:0] u_bus_i,
	output reg [p_sz-1:0] l_bus_o,
	output reg [p_sz-1:0] r_bus_o,
	output reg [p_sz-1:0] u_bus_o
	);
	// Override these values in top modules
	parameter num_leaves= 2;
	parameter payload_sz= 1;
	parameter addr= 1'b0;
	parameter level= 15; // only change if level == 0
	parameter p_sz= 1+$clog2(num_leaves)+payload_sz; //packet size
	
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