//--------level=0--------------
module  gen_nw # (
	parameter num_leaves= 256,
	parameter payload_sz= $clog2(num_leaves) + 4,
	parameter p_sz= 1 + $clog2(num_leaves) + payload_sz, //packet size
	parameter addr= 0,
	parameter level= 0
	) (
	input clk,
	input reset,
	input [p_sz*256-1:0] pe_interface,
	output [p_sz*256-1:0] interface_pe,
	output [256-1:0] resend
	);
	wire [p_sz*16-1:0] left_switch_0_0;
	wire [p_sz*16-1:0] right_switch_0_0;
	wire [p_sz*16-1:0] switch_left_0_0;
	wire [p_sz*16-1:0] switch_right_0_0;
	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(addr),
		.level(level),
		.p_sz(p_sz),
		.num_switches(16))
		t_lvl0(
		.clk(clk),
		.reset(reset),
		.l_bus_i(left_switch_0_0),
		.r_bus_i(right_switch_0_0),
		.l_bus_o(switch_left_0_0),
		.r_bus_o(switch_right_0_0));


//--------level=1--------------
	wire [p_sz*8-1:0] left_switch_1_0;
	wire [p_sz*8-1:0] right_switch_1_0;
	wire [p_sz*8-1:0] switch_left_1_0;
	wire [p_sz*8-1:0] switch_right_1_0;
	wire [p_sz*8-1:0] left_switch_1_1;
	wire [p_sz*8-1:0] right_switch_1_1;
	wire [p_sz*8-1:0] switch_left_1_1;
	wire [p_sz*8-1:0] switch_right_1_1;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(1),
		.p_sz(p_sz),
		.num_switches(8)
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
		.num_switches(8)
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
	wire [p_sz*8-1:0] left_switch_2_0;
	wire [p_sz*8-1:0] right_switch_2_0;
	wire [p_sz*8-1:0] switch_left_2_0;
	wire [p_sz*8-1:0] switch_right_2_0;
	wire [p_sz*8-1:0] left_switch_2_1;
	wire [p_sz*8-1:0] right_switch_2_1;
	wire [p_sz*8-1:0] switch_left_2_1;
	wire [p_sz*8-1:0] switch_right_2_1;
	wire [p_sz*8-1:0] left_switch_2_2;
	wire [p_sz*8-1:0] right_switch_2_2;
	wire [p_sz*8-1:0] switch_left_2_2;
	wire [p_sz*8-1:0] switch_right_2_2;
	wire [p_sz*8-1:0] left_switch_2_3;
	wire [p_sz*8-1:0] right_switch_2_3;
	wire [p_sz*8-1:0] switch_left_2_3;
	wire [p_sz*8-1:0] switch_right_2_3;
	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(2),
		.p_sz(p_sz),
		.num_switches(8)
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
		.num_switches(8)
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
		.num_switches(8)
		)t_lvl_2_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_1_1),
		.u_bus_i(switch_left_1_1),
		.l_bus_i(left_switch_2_2),
		.r_bus_i(right_switch_2_2),
		.l_bus_o(switch_left_2_2),
		.r_bus_o(switch_right_2_2));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.level(2),
		.p_sz(p_sz),
		.num_switches(8)
		)t_lvl_2_3(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_1_1),
		.u_bus_i(switch_right_1_1),
		.l_bus_i(left_switch_2_3),
		.r_bus_i(right_switch_2_3),
		.l_bus_o(switch_left_2_3),
		.r_bus_o(switch_right_2_3));


//--------level=3--------------
	wire [p_sz*4-1:0] left_switch_3_0;
	wire [p_sz*4-1:0] right_switch_3_0;
	wire [p_sz*4-1:0] switch_left_3_0;
	wire [p_sz*4-1:0] switch_right_3_0;
	wire [p_sz*4-1:0] left_switch_3_1;
	wire [p_sz*4-1:0] right_switch_3_1;
	wire [p_sz*4-1:0] switch_left_3_1;
	wire [p_sz*4-1:0] switch_right_3_1;
	wire [p_sz*4-1:0] left_switch_3_2;
	wire [p_sz*4-1:0] right_switch_3_2;
	wire [p_sz*4-1:0] switch_left_3_2;
	wire [p_sz*4-1:0] switch_right_3_2;
	wire [p_sz*4-1:0] left_switch_3_3;
	wire [p_sz*4-1:0] right_switch_3_3;
	wire [p_sz*4-1:0] switch_left_3_3;
	wire [p_sz*4-1:0] switch_right_3_3;
	wire [p_sz*4-1:0] left_switch_3_4;
	wire [p_sz*4-1:0] right_switch_3_4;
	wire [p_sz*4-1:0] switch_left_3_4;
	wire [p_sz*4-1:0] switch_right_3_4;
	wire [p_sz*4-1:0] left_switch_3_5;
	wire [p_sz*4-1:0] right_switch_3_5;
	wire [p_sz*4-1:0] switch_left_3_5;
	wire [p_sz*4-1:0] switch_right_3_5;
	wire [p_sz*4-1:0] left_switch_3_6;
	wire [p_sz*4-1:0] right_switch_3_6;
	wire [p_sz*4-1:0] switch_left_3_6;
	wire [p_sz*4-1:0] switch_right_3_6;
	wire [p_sz*4-1:0] left_switch_3_7;
	wire [p_sz*4-1:0] right_switch_3_7;
	wire [p_sz*4-1:0] switch_left_3_7;
	wire [p_sz*4-1:0] switch_right_3_7;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(3),
		.p_sz(p_sz),
		.num_switches(4)
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
		.num_switches(4)
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
		.num_switches(4)
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
		.num_switches(4)
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
		.num_switches(4)
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
		.num_switches(4)
		)pi_lvl_3_5(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_2_2),
		.u_bus_i(switch_right_2_2),
		.l_bus_i(left_switch_3_5),
		.r_bus_i(right_switch_3_5),
		.l_bus_o(switch_left_3_5),
		.r_bus_o(switch_right_3_5));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(6),
		.level(3),
		.p_sz(p_sz),
		.num_switches(4)
		)pi_lvl_3_6(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_2_3),
		.u_bus_i(switch_left_2_3),
		.l_bus_i(left_switch_3_6),
		.r_bus_i(right_switch_3_6),
		.l_bus_o(switch_left_3_6),
		.r_bus_o(switch_right_3_6));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(7),
		.level(3),
		.p_sz(p_sz),
		.num_switches(4)
		)pi_lvl_3_7(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_2_3),
		.u_bus_i(switch_right_2_3),
		.l_bus_i(left_switch_3_7),
		.r_bus_i(right_switch_3_7),
		.l_bus_o(switch_left_3_7),
		.r_bus_o(switch_right_3_7));


//--------level=4--------------
	wire [p_sz*4-1:0] left_switch_4_0;
	wire [p_sz*4-1:0] right_switch_4_0;
	wire [p_sz*4-1:0] switch_left_4_0;
	wire [p_sz*4-1:0] switch_right_4_0;
	wire [p_sz*4-1:0] left_switch_4_1;
	wire [p_sz*4-1:0] right_switch_4_1;
	wire [p_sz*4-1:0] switch_left_4_1;
	wire [p_sz*4-1:0] switch_right_4_1;
	wire [p_sz*4-1:0] left_switch_4_2;
	wire [p_sz*4-1:0] right_switch_4_2;
	wire [p_sz*4-1:0] switch_left_4_2;
	wire [p_sz*4-1:0] switch_right_4_2;
	wire [p_sz*4-1:0] left_switch_4_3;
	wire [p_sz*4-1:0] right_switch_4_3;
	wire [p_sz*4-1:0] switch_left_4_3;
	wire [p_sz*4-1:0] switch_right_4_3;
	wire [p_sz*4-1:0] left_switch_4_4;
	wire [p_sz*4-1:0] right_switch_4_4;
	wire [p_sz*4-1:0] switch_left_4_4;
	wire [p_sz*4-1:0] switch_right_4_4;
	wire [p_sz*4-1:0] left_switch_4_5;
	wire [p_sz*4-1:0] right_switch_4_5;
	wire [p_sz*4-1:0] switch_left_4_5;
	wire [p_sz*4-1:0] switch_right_4_5;
	wire [p_sz*4-1:0] left_switch_4_6;
	wire [p_sz*4-1:0] right_switch_4_6;
	wire [p_sz*4-1:0] switch_left_4_6;
	wire [p_sz*4-1:0] switch_right_4_6;
	wire [p_sz*4-1:0] left_switch_4_7;
	wire [p_sz*4-1:0] right_switch_4_7;
	wire [p_sz*4-1:0] switch_left_4_7;
	wire [p_sz*4-1:0] switch_right_4_7;
	wire [p_sz*4-1:0] left_switch_4_8;
	wire [p_sz*4-1:0] right_switch_4_8;
	wire [p_sz*4-1:0] switch_left_4_8;
	wire [p_sz*4-1:0] switch_right_4_8;
	wire [p_sz*4-1:0] left_switch_4_9;
	wire [p_sz*4-1:0] right_switch_4_9;
	wire [p_sz*4-1:0] switch_left_4_9;
	wire [p_sz*4-1:0] switch_right_4_9;
	wire [p_sz*4-1:0] left_switch_4_10;
	wire [p_sz*4-1:0] right_switch_4_10;
	wire [p_sz*4-1:0] switch_left_4_10;
	wire [p_sz*4-1:0] switch_right_4_10;
	wire [p_sz*4-1:0] left_switch_4_11;
	wire [p_sz*4-1:0] right_switch_4_11;
	wire [p_sz*4-1:0] switch_left_4_11;
	wire [p_sz*4-1:0] switch_right_4_11;
	wire [p_sz*4-1:0] left_switch_4_12;
	wire [p_sz*4-1:0] right_switch_4_12;
	wire [p_sz*4-1:0] switch_left_4_12;
	wire [p_sz*4-1:0] switch_right_4_12;
	wire [p_sz*4-1:0] left_switch_4_13;
	wire [p_sz*4-1:0] right_switch_4_13;
	wire [p_sz*4-1:0] switch_left_4_13;
	wire [p_sz*4-1:0] switch_right_4_13;
	wire [p_sz*4-1:0] left_switch_4_14;
	wire [p_sz*4-1:0] right_switch_4_14;
	wire [p_sz*4-1:0] switch_left_4_14;
	wire [p_sz*4-1:0] switch_right_4_14;
	wire [p_sz*4-1:0] left_switch_4_15;
	wire [p_sz*4-1:0] right_switch_4_15;
	wire [p_sz*4-1:0] switch_left_4_15;
	wire [p_sz*4-1:0] switch_right_4_15;
	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_0),
		.u_bus_i(switch_left_3_0),
		.l_bus_i(left_switch_4_0),
		.r_bus_i(right_switch_4_0),
		.l_bus_o(switch_left_4_0),
		.r_bus_o(switch_right_4_0));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_0),
		.u_bus_i(switch_right_3_0),
		.l_bus_i(left_switch_4_1),
		.r_bus_i(right_switch_4_1),
		.l_bus_o(switch_left_4_1),
		.r_bus_o(switch_right_4_1));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_1),
		.u_bus_i(switch_left_3_1),
		.l_bus_i(left_switch_4_2),
		.r_bus_i(right_switch_4_2),
		.l_bus_o(switch_left_4_2),
		.r_bus_o(switch_right_4_2));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_3(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_1),
		.u_bus_i(switch_right_3_1),
		.l_bus_i(left_switch_4_3),
		.r_bus_i(right_switch_4_3),
		.l_bus_o(switch_left_4_3),
		.r_bus_o(switch_right_4_3));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(4),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_4(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_2),
		.u_bus_i(switch_left_3_2),
		.l_bus_i(left_switch_4_4),
		.r_bus_i(right_switch_4_4),
		.l_bus_o(switch_left_4_4),
		.r_bus_o(switch_right_4_4));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(5),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_5(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_2),
		.u_bus_i(switch_right_3_2),
		.l_bus_i(left_switch_4_5),
		.r_bus_i(right_switch_4_5),
		.l_bus_o(switch_left_4_5),
		.r_bus_o(switch_right_4_5));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(6),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_6(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_3),
		.u_bus_i(switch_left_3_3),
		.l_bus_i(left_switch_4_6),
		.r_bus_i(right_switch_4_6),
		.l_bus_o(switch_left_4_6),
		.r_bus_o(switch_right_4_6));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(7),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_7(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_3),
		.u_bus_i(switch_right_3_3),
		.l_bus_i(left_switch_4_7),
		.r_bus_i(right_switch_4_7),
		.l_bus_o(switch_left_4_7),
		.r_bus_o(switch_right_4_7));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(8),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_8(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_4),
		.u_bus_i(switch_left_3_4),
		.l_bus_i(left_switch_4_8),
		.r_bus_i(right_switch_4_8),
		.l_bus_o(switch_left_4_8),
		.r_bus_o(switch_right_4_8));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(9),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_9(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_4),
		.u_bus_i(switch_right_3_4),
		.l_bus_i(left_switch_4_9),
		.r_bus_i(right_switch_4_9),
		.l_bus_o(switch_left_4_9),
		.r_bus_o(switch_right_4_9));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(10),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_10(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_5),
		.u_bus_i(switch_left_3_5),
		.l_bus_i(left_switch_4_10),
		.r_bus_i(right_switch_4_10),
		.l_bus_o(switch_left_4_10),
		.r_bus_o(switch_right_4_10));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(11),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_11(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_5),
		.u_bus_i(switch_right_3_5),
		.l_bus_i(left_switch_4_11),
		.r_bus_i(right_switch_4_11),
		.l_bus_o(switch_left_4_11),
		.r_bus_o(switch_right_4_11));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(12),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_12(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_6),
		.u_bus_i(switch_left_3_6),
		.l_bus_i(left_switch_4_12),
		.r_bus_i(right_switch_4_12),
		.l_bus_o(switch_left_4_12),
		.r_bus_o(switch_right_4_12));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(13),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_13(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_6),
		.u_bus_i(switch_right_3_6),
		.l_bus_i(left_switch_4_13),
		.r_bus_i(right_switch_4_13),
		.l_bus_o(switch_left_4_13),
		.r_bus_o(switch_right_4_13));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(14),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_14(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_3_7),
		.u_bus_i(switch_left_3_7),
		.l_bus_i(left_switch_4_14),
		.r_bus_i(right_switch_4_14),
		.l_bus_o(switch_left_4_14),
		.r_bus_o(switch_right_4_14));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(15),
		.level(4),
		.p_sz(p_sz),
		.num_switches(4)
		)t_lvl_4_15(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_3_7),
		.u_bus_i(switch_right_3_7),
		.l_bus_i(left_switch_4_15),
		.r_bus_i(right_switch_4_15),
		.l_bus_o(switch_left_4_15),
		.r_bus_o(switch_right_4_15));


//--------level=5--------------
	wire [p_sz*2-1:0] left_switch_5_0;
	wire [p_sz*2-1:0] right_switch_5_0;
	wire [p_sz*2-1:0] switch_left_5_0;
	wire [p_sz*2-1:0] switch_right_5_0;
	wire [p_sz*2-1:0] left_switch_5_1;
	wire [p_sz*2-1:0] right_switch_5_1;
	wire [p_sz*2-1:0] switch_left_5_1;
	wire [p_sz*2-1:0] switch_right_5_1;
	wire [p_sz*2-1:0] left_switch_5_2;
	wire [p_sz*2-1:0] right_switch_5_2;
	wire [p_sz*2-1:0] switch_left_5_2;
	wire [p_sz*2-1:0] switch_right_5_2;
	wire [p_sz*2-1:0] left_switch_5_3;
	wire [p_sz*2-1:0] right_switch_5_3;
	wire [p_sz*2-1:0] switch_left_5_3;
	wire [p_sz*2-1:0] switch_right_5_3;
	wire [p_sz*2-1:0] left_switch_5_4;
	wire [p_sz*2-1:0] right_switch_5_4;
	wire [p_sz*2-1:0] switch_left_5_4;
	wire [p_sz*2-1:0] switch_right_5_4;
	wire [p_sz*2-1:0] left_switch_5_5;
	wire [p_sz*2-1:0] right_switch_5_5;
	wire [p_sz*2-1:0] switch_left_5_5;
	wire [p_sz*2-1:0] switch_right_5_5;
	wire [p_sz*2-1:0] left_switch_5_6;
	wire [p_sz*2-1:0] right_switch_5_6;
	wire [p_sz*2-1:0] switch_left_5_6;
	wire [p_sz*2-1:0] switch_right_5_6;
	wire [p_sz*2-1:0] left_switch_5_7;
	wire [p_sz*2-1:0] right_switch_5_7;
	wire [p_sz*2-1:0] switch_left_5_7;
	wire [p_sz*2-1:0] switch_right_5_7;
	wire [p_sz*2-1:0] left_switch_5_8;
	wire [p_sz*2-1:0] right_switch_5_8;
	wire [p_sz*2-1:0] switch_left_5_8;
	wire [p_sz*2-1:0] switch_right_5_8;
	wire [p_sz*2-1:0] left_switch_5_9;
	wire [p_sz*2-1:0] right_switch_5_9;
	wire [p_sz*2-1:0] switch_left_5_9;
	wire [p_sz*2-1:0] switch_right_5_9;
	wire [p_sz*2-1:0] left_switch_5_10;
	wire [p_sz*2-1:0] right_switch_5_10;
	wire [p_sz*2-1:0] switch_left_5_10;
	wire [p_sz*2-1:0] switch_right_5_10;
	wire [p_sz*2-1:0] left_switch_5_11;
	wire [p_sz*2-1:0] right_switch_5_11;
	wire [p_sz*2-1:0] switch_left_5_11;
	wire [p_sz*2-1:0] switch_right_5_11;
	wire [p_sz*2-1:0] left_switch_5_12;
	wire [p_sz*2-1:0] right_switch_5_12;
	wire [p_sz*2-1:0] switch_left_5_12;
	wire [p_sz*2-1:0] switch_right_5_12;
	wire [p_sz*2-1:0] left_switch_5_13;
	wire [p_sz*2-1:0] right_switch_5_13;
	wire [p_sz*2-1:0] switch_left_5_13;
	wire [p_sz*2-1:0] switch_right_5_13;
	wire [p_sz*2-1:0] left_switch_5_14;
	wire [p_sz*2-1:0] right_switch_5_14;
	wire [p_sz*2-1:0] switch_left_5_14;
	wire [p_sz*2-1:0] switch_right_5_14;
	wire [p_sz*2-1:0] left_switch_5_15;
	wire [p_sz*2-1:0] right_switch_5_15;
	wire [p_sz*2-1:0] switch_left_5_15;
	wire [p_sz*2-1:0] switch_right_5_15;
	wire [p_sz*2-1:0] left_switch_5_16;
	wire [p_sz*2-1:0] right_switch_5_16;
	wire [p_sz*2-1:0] switch_left_5_16;
	wire [p_sz*2-1:0] switch_right_5_16;
	wire [p_sz*2-1:0] left_switch_5_17;
	wire [p_sz*2-1:0] right_switch_5_17;
	wire [p_sz*2-1:0] switch_left_5_17;
	wire [p_sz*2-1:0] switch_right_5_17;
	wire [p_sz*2-1:0] left_switch_5_18;
	wire [p_sz*2-1:0] right_switch_5_18;
	wire [p_sz*2-1:0] switch_left_5_18;
	wire [p_sz*2-1:0] switch_right_5_18;
	wire [p_sz*2-1:0] left_switch_5_19;
	wire [p_sz*2-1:0] right_switch_5_19;
	wire [p_sz*2-1:0] switch_left_5_19;
	wire [p_sz*2-1:0] switch_right_5_19;
	wire [p_sz*2-1:0] left_switch_5_20;
	wire [p_sz*2-1:0] right_switch_5_20;
	wire [p_sz*2-1:0] switch_left_5_20;
	wire [p_sz*2-1:0] switch_right_5_20;
	wire [p_sz*2-1:0] left_switch_5_21;
	wire [p_sz*2-1:0] right_switch_5_21;
	wire [p_sz*2-1:0] switch_left_5_21;
	wire [p_sz*2-1:0] switch_right_5_21;
	wire [p_sz*2-1:0] left_switch_5_22;
	wire [p_sz*2-1:0] right_switch_5_22;
	wire [p_sz*2-1:0] switch_left_5_22;
	wire [p_sz*2-1:0] switch_right_5_22;
	wire [p_sz*2-1:0] left_switch_5_23;
	wire [p_sz*2-1:0] right_switch_5_23;
	wire [p_sz*2-1:0] switch_left_5_23;
	wire [p_sz*2-1:0] switch_right_5_23;
	wire [p_sz*2-1:0] left_switch_5_24;
	wire [p_sz*2-1:0] right_switch_5_24;
	wire [p_sz*2-1:0] switch_left_5_24;
	wire [p_sz*2-1:0] switch_right_5_24;
	wire [p_sz*2-1:0] left_switch_5_25;
	wire [p_sz*2-1:0] right_switch_5_25;
	wire [p_sz*2-1:0] switch_left_5_25;
	wire [p_sz*2-1:0] switch_right_5_25;
	wire [p_sz*2-1:0] left_switch_5_26;
	wire [p_sz*2-1:0] right_switch_5_26;
	wire [p_sz*2-1:0] switch_left_5_26;
	wire [p_sz*2-1:0] switch_right_5_26;
	wire [p_sz*2-1:0] left_switch_5_27;
	wire [p_sz*2-1:0] right_switch_5_27;
	wire [p_sz*2-1:0] switch_left_5_27;
	wire [p_sz*2-1:0] switch_right_5_27;
	wire [p_sz*2-1:0] left_switch_5_28;
	wire [p_sz*2-1:0] right_switch_5_28;
	wire [p_sz*2-1:0] switch_left_5_28;
	wire [p_sz*2-1:0] switch_right_5_28;
	wire [p_sz*2-1:0] left_switch_5_29;
	wire [p_sz*2-1:0] right_switch_5_29;
	wire [p_sz*2-1:0] switch_left_5_29;
	wire [p_sz*2-1:0] switch_right_5_29;
	wire [p_sz*2-1:0] left_switch_5_30;
	wire [p_sz*2-1:0] right_switch_5_30;
	wire [p_sz*2-1:0] switch_left_5_30;
	wire [p_sz*2-1:0] switch_right_5_30;
	wire [p_sz*2-1:0] left_switch_5_31;
	wire [p_sz*2-1:0] right_switch_5_31;
	wire [p_sz*2-1:0] switch_left_5_31;
	wire [p_sz*2-1:0] switch_right_5_31;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_0),
		.u_bus_i(switch_left_4_0),
		.l_bus_i(left_switch_5_0),
		.r_bus_i(right_switch_5_0),
		.l_bus_o(switch_left_5_0),
		.r_bus_o(switch_right_5_0));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_0),
		.u_bus_i(switch_right_4_0),
		.l_bus_i(left_switch_5_1),
		.r_bus_i(right_switch_5_1),
		.l_bus_o(switch_left_5_1),
		.r_bus_o(switch_right_5_1));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_1),
		.u_bus_i(switch_left_4_1),
		.l_bus_i(left_switch_5_2),
		.r_bus_i(right_switch_5_2),
		.l_bus_o(switch_left_5_2),
		.r_bus_o(switch_right_5_2));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_3(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_1),
		.u_bus_i(switch_right_4_1),
		.l_bus_i(left_switch_5_3),
		.r_bus_i(right_switch_5_3),
		.l_bus_o(switch_left_5_3),
		.r_bus_o(switch_right_5_3));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(4),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_4(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_2),
		.u_bus_i(switch_left_4_2),
		.l_bus_i(left_switch_5_4),
		.r_bus_i(right_switch_5_4),
		.l_bus_o(switch_left_5_4),
		.r_bus_o(switch_right_5_4));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(5),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_5(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_2),
		.u_bus_i(switch_right_4_2),
		.l_bus_i(left_switch_5_5),
		.r_bus_i(right_switch_5_5),
		.l_bus_o(switch_left_5_5),
		.r_bus_o(switch_right_5_5));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(6),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_6(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_3),
		.u_bus_i(switch_left_4_3),
		.l_bus_i(left_switch_5_6),
		.r_bus_i(right_switch_5_6),
		.l_bus_o(switch_left_5_6),
		.r_bus_o(switch_right_5_6));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(7),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_7(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_3),
		.u_bus_i(switch_right_4_3),
		.l_bus_i(left_switch_5_7),
		.r_bus_i(right_switch_5_7),
		.l_bus_o(switch_left_5_7),
		.r_bus_o(switch_right_5_7));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(8),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_8(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_4),
		.u_bus_i(switch_left_4_4),
		.l_bus_i(left_switch_5_8),
		.r_bus_i(right_switch_5_8),
		.l_bus_o(switch_left_5_8),
		.r_bus_o(switch_right_5_8));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(9),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_9(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_4),
		.u_bus_i(switch_right_4_4),
		.l_bus_i(left_switch_5_9),
		.r_bus_i(right_switch_5_9),
		.l_bus_o(switch_left_5_9),
		.r_bus_o(switch_right_5_9));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(10),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_10(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_5),
		.u_bus_i(switch_left_4_5),
		.l_bus_i(left_switch_5_10),
		.r_bus_i(right_switch_5_10),
		.l_bus_o(switch_left_5_10),
		.r_bus_o(switch_right_5_10));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(11),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_11(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_5),
		.u_bus_i(switch_right_4_5),
		.l_bus_i(left_switch_5_11),
		.r_bus_i(right_switch_5_11),
		.l_bus_o(switch_left_5_11),
		.r_bus_o(switch_right_5_11));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(12),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_12(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_6),
		.u_bus_i(switch_left_4_6),
		.l_bus_i(left_switch_5_12),
		.r_bus_i(right_switch_5_12),
		.l_bus_o(switch_left_5_12),
		.r_bus_o(switch_right_5_12));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(13),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_13(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_6),
		.u_bus_i(switch_right_4_6),
		.l_bus_i(left_switch_5_13),
		.r_bus_i(right_switch_5_13),
		.l_bus_o(switch_left_5_13),
		.r_bus_o(switch_right_5_13));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(14),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_14(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_7),
		.u_bus_i(switch_left_4_7),
		.l_bus_i(left_switch_5_14),
		.r_bus_i(right_switch_5_14),
		.l_bus_o(switch_left_5_14),
		.r_bus_o(switch_right_5_14));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(15),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_15(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_7),
		.u_bus_i(switch_right_4_7),
		.l_bus_i(left_switch_5_15),
		.r_bus_i(right_switch_5_15),
		.l_bus_o(switch_left_5_15),
		.r_bus_o(switch_right_5_15));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(16),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_16(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_8),
		.u_bus_i(switch_left_4_8),
		.l_bus_i(left_switch_5_16),
		.r_bus_i(right_switch_5_16),
		.l_bus_o(switch_left_5_16),
		.r_bus_o(switch_right_5_16));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(17),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_17(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_8),
		.u_bus_i(switch_right_4_8),
		.l_bus_i(left_switch_5_17),
		.r_bus_i(right_switch_5_17),
		.l_bus_o(switch_left_5_17),
		.r_bus_o(switch_right_5_17));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(18),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_18(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_9),
		.u_bus_i(switch_left_4_9),
		.l_bus_i(left_switch_5_18),
		.r_bus_i(right_switch_5_18),
		.l_bus_o(switch_left_5_18),
		.r_bus_o(switch_right_5_18));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(19),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_19(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_9),
		.u_bus_i(switch_right_4_9),
		.l_bus_i(left_switch_5_19),
		.r_bus_i(right_switch_5_19),
		.l_bus_o(switch_left_5_19),
		.r_bus_o(switch_right_5_19));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(20),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_20(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_10),
		.u_bus_i(switch_left_4_10),
		.l_bus_i(left_switch_5_20),
		.r_bus_i(right_switch_5_20),
		.l_bus_o(switch_left_5_20),
		.r_bus_o(switch_right_5_20));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(21),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_21(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_10),
		.u_bus_i(switch_right_4_10),
		.l_bus_i(left_switch_5_21),
		.r_bus_i(right_switch_5_21),
		.l_bus_o(switch_left_5_21),
		.r_bus_o(switch_right_5_21));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(22),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_22(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_11),
		.u_bus_i(switch_left_4_11),
		.l_bus_i(left_switch_5_22),
		.r_bus_i(right_switch_5_22),
		.l_bus_o(switch_left_5_22),
		.r_bus_o(switch_right_5_22));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(23),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_23(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_11),
		.u_bus_i(switch_right_4_11),
		.l_bus_i(left_switch_5_23),
		.r_bus_i(right_switch_5_23),
		.l_bus_o(switch_left_5_23),
		.r_bus_o(switch_right_5_23));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(24),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_24(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_12),
		.u_bus_i(switch_left_4_12),
		.l_bus_i(left_switch_5_24),
		.r_bus_i(right_switch_5_24),
		.l_bus_o(switch_left_5_24),
		.r_bus_o(switch_right_5_24));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(25),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_25(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_12),
		.u_bus_i(switch_right_4_12),
		.l_bus_i(left_switch_5_25),
		.r_bus_i(right_switch_5_25),
		.l_bus_o(switch_left_5_25),
		.r_bus_o(switch_right_5_25));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(26),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_26(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_13),
		.u_bus_i(switch_left_4_13),
		.l_bus_i(left_switch_5_26),
		.r_bus_i(right_switch_5_26),
		.l_bus_o(switch_left_5_26),
		.r_bus_o(switch_right_5_26));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(27),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_27(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_13),
		.u_bus_i(switch_right_4_13),
		.l_bus_i(left_switch_5_27),
		.r_bus_i(right_switch_5_27),
		.l_bus_o(switch_left_5_27),
		.r_bus_o(switch_right_5_27));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(28),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_28(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_14),
		.u_bus_i(switch_left_4_14),
		.l_bus_i(left_switch_5_28),
		.r_bus_i(right_switch_5_28),
		.l_bus_o(switch_left_5_28),
		.r_bus_o(switch_right_5_28));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(29),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_29(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_14),
		.u_bus_i(switch_right_4_14),
		.l_bus_i(left_switch_5_29),
		.r_bus_i(right_switch_5_29),
		.l_bus_o(switch_left_5_29),
		.r_bus_o(switch_right_5_29));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(30),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_30(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_4_15),
		.u_bus_i(switch_left_4_15),
		.l_bus_i(left_switch_5_30),
		.r_bus_i(right_switch_5_30),
		.l_bus_o(switch_left_5_30),
		.r_bus_o(switch_right_5_30));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(31),
		.level(5),
		.p_sz(p_sz),
		.num_switches(2)
		)pi_lvl_5_31(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_4_15),
		.u_bus_i(switch_right_4_15),
		.l_bus_i(left_switch_5_31),
		.r_bus_i(right_switch_5_31),
		.l_bus_o(switch_left_5_31),
		.r_bus_o(switch_right_5_31));


//--------level=6--------------
	wire [p_sz*2-1:0] left_switch_6_0;
	wire [p_sz*2-1:0] right_switch_6_0;
	wire [p_sz*2-1:0] switch_left_6_0;
	wire [p_sz*2-1:0] switch_right_6_0;
	wire [p_sz*2-1:0] left_switch_6_1;
	wire [p_sz*2-1:0] right_switch_6_1;
	wire [p_sz*2-1:0] switch_left_6_1;
	wire [p_sz*2-1:0] switch_right_6_1;
	wire [p_sz*2-1:0] left_switch_6_2;
	wire [p_sz*2-1:0] right_switch_6_2;
	wire [p_sz*2-1:0] switch_left_6_2;
	wire [p_sz*2-1:0] switch_right_6_2;
	wire [p_sz*2-1:0] left_switch_6_3;
	wire [p_sz*2-1:0] right_switch_6_3;
	wire [p_sz*2-1:0] switch_left_6_3;
	wire [p_sz*2-1:0] switch_right_6_3;
	wire [p_sz*2-1:0] left_switch_6_4;
	wire [p_sz*2-1:0] right_switch_6_4;
	wire [p_sz*2-1:0] switch_left_6_4;
	wire [p_sz*2-1:0] switch_right_6_4;
	wire [p_sz*2-1:0] left_switch_6_5;
	wire [p_sz*2-1:0] right_switch_6_5;
	wire [p_sz*2-1:0] switch_left_6_5;
	wire [p_sz*2-1:0] switch_right_6_5;
	wire [p_sz*2-1:0] left_switch_6_6;
	wire [p_sz*2-1:0] right_switch_6_6;
	wire [p_sz*2-1:0] switch_left_6_6;
	wire [p_sz*2-1:0] switch_right_6_6;
	wire [p_sz*2-1:0] left_switch_6_7;
	wire [p_sz*2-1:0] right_switch_6_7;
	wire [p_sz*2-1:0] switch_left_6_7;
	wire [p_sz*2-1:0] switch_right_6_7;
	wire [p_sz*2-1:0] left_switch_6_8;
	wire [p_sz*2-1:0] right_switch_6_8;
	wire [p_sz*2-1:0] switch_left_6_8;
	wire [p_sz*2-1:0] switch_right_6_8;
	wire [p_sz*2-1:0] left_switch_6_9;
	wire [p_sz*2-1:0] right_switch_6_9;
	wire [p_sz*2-1:0] switch_left_6_9;
	wire [p_sz*2-1:0] switch_right_6_9;
	wire [p_sz*2-1:0] left_switch_6_10;
	wire [p_sz*2-1:0] right_switch_6_10;
	wire [p_sz*2-1:0] switch_left_6_10;
	wire [p_sz*2-1:0] switch_right_6_10;
	wire [p_sz*2-1:0] left_switch_6_11;
	wire [p_sz*2-1:0] right_switch_6_11;
	wire [p_sz*2-1:0] switch_left_6_11;
	wire [p_sz*2-1:0] switch_right_6_11;
	wire [p_sz*2-1:0] left_switch_6_12;
	wire [p_sz*2-1:0] right_switch_6_12;
	wire [p_sz*2-1:0] switch_left_6_12;
	wire [p_sz*2-1:0] switch_right_6_12;
	wire [p_sz*2-1:0] left_switch_6_13;
	wire [p_sz*2-1:0] right_switch_6_13;
	wire [p_sz*2-1:0] switch_left_6_13;
	wire [p_sz*2-1:0] switch_right_6_13;
	wire [p_sz*2-1:0] left_switch_6_14;
	wire [p_sz*2-1:0] right_switch_6_14;
	wire [p_sz*2-1:0] switch_left_6_14;
	wire [p_sz*2-1:0] switch_right_6_14;
	wire [p_sz*2-1:0] left_switch_6_15;
	wire [p_sz*2-1:0] right_switch_6_15;
	wire [p_sz*2-1:0] switch_left_6_15;
	wire [p_sz*2-1:0] switch_right_6_15;
	wire [p_sz*2-1:0] left_switch_6_16;
	wire [p_sz*2-1:0] right_switch_6_16;
	wire [p_sz*2-1:0] switch_left_6_16;
	wire [p_sz*2-1:0] switch_right_6_16;
	wire [p_sz*2-1:0] left_switch_6_17;
	wire [p_sz*2-1:0] right_switch_6_17;
	wire [p_sz*2-1:0] switch_left_6_17;
	wire [p_sz*2-1:0] switch_right_6_17;
	wire [p_sz*2-1:0] left_switch_6_18;
	wire [p_sz*2-1:0] right_switch_6_18;
	wire [p_sz*2-1:0] switch_left_6_18;
	wire [p_sz*2-1:0] switch_right_6_18;
	wire [p_sz*2-1:0] left_switch_6_19;
	wire [p_sz*2-1:0] right_switch_6_19;
	wire [p_sz*2-1:0] switch_left_6_19;
	wire [p_sz*2-1:0] switch_right_6_19;
	wire [p_sz*2-1:0] left_switch_6_20;
	wire [p_sz*2-1:0] right_switch_6_20;
	wire [p_sz*2-1:0] switch_left_6_20;
	wire [p_sz*2-1:0] switch_right_6_20;
	wire [p_sz*2-1:0] left_switch_6_21;
	wire [p_sz*2-1:0] right_switch_6_21;
	wire [p_sz*2-1:0] switch_left_6_21;
	wire [p_sz*2-1:0] switch_right_6_21;
	wire [p_sz*2-1:0] left_switch_6_22;
	wire [p_sz*2-1:0] right_switch_6_22;
	wire [p_sz*2-1:0] switch_left_6_22;
	wire [p_sz*2-1:0] switch_right_6_22;
	wire [p_sz*2-1:0] left_switch_6_23;
	wire [p_sz*2-1:0] right_switch_6_23;
	wire [p_sz*2-1:0] switch_left_6_23;
	wire [p_sz*2-1:0] switch_right_6_23;
	wire [p_sz*2-1:0] left_switch_6_24;
	wire [p_sz*2-1:0] right_switch_6_24;
	wire [p_sz*2-1:0] switch_left_6_24;
	wire [p_sz*2-1:0] switch_right_6_24;
	wire [p_sz*2-1:0] left_switch_6_25;
	wire [p_sz*2-1:0] right_switch_6_25;
	wire [p_sz*2-1:0] switch_left_6_25;
	wire [p_sz*2-1:0] switch_right_6_25;
	wire [p_sz*2-1:0] left_switch_6_26;
	wire [p_sz*2-1:0] right_switch_6_26;
	wire [p_sz*2-1:0] switch_left_6_26;
	wire [p_sz*2-1:0] switch_right_6_26;
	wire [p_sz*2-1:0] left_switch_6_27;
	wire [p_sz*2-1:0] right_switch_6_27;
	wire [p_sz*2-1:0] switch_left_6_27;
	wire [p_sz*2-1:0] switch_right_6_27;
	wire [p_sz*2-1:0] left_switch_6_28;
	wire [p_sz*2-1:0] right_switch_6_28;
	wire [p_sz*2-1:0] switch_left_6_28;
	wire [p_sz*2-1:0] switch_right_6_28;
	wire [p_sz*2-1:0] left_switch_6_29;
	wire [p_sz*2-1:0] right_switch_6_29;
	wire [p_sz*2-1:0] switch_left_6_29;
	wire [p_sz*2-1:0] switch_right_6_29;
	wire [p_sz*2-1:0] left_switch_6_30;
	wire [p_sz*2-1:0] right_switch_6_30;
	wire [p_sz*2-1:0] switch_left_6_30;
	wire [p_sz*2-1:0] switch_right_6_30;
	wire [p_sz*2-1:0] left_switch_6_31;
	wire [p_sz*2-1:0] right_switch_6_31;
	wire [p_sz*2-1:0] switch_left_6_31;
	wire [p_sz*2-1:0] switch_right_6_31;
	wire [p_sz*2-1:0] left_switch_6_32;
	wire [p_sz*2-1:0] right_switch_6_32;
	wire [p_sz*2-1:0] switch_left_6_32;
	wire [p_sz*2-1:0] switch_right_6_32;
	wire [p_sz*2-1:0] left_switch_6_33;
	wire [p_sz*2-1:0] right_switch_6_33;
	wire [p_sz*2-1:0] switch_left_6_33;
	wire [p_sz*2-1:0] switch_right_6_33;
	wire [p_sz*2-1:0] left_switch_6_34;
	wire [p_sz*2-1:0] right_switch_6_34;
	wire [p_sz*2-1:0] switch_left_6_34;
	wire [p_sz*2-1:0] switch_right_6_34;
	wire [p_sz*2-1:0] left_switch_6_35;
	wire [p_sz*2-1:0] right_switch_6_35;
	wire [p_sz*2-1:0] switch_left_6_35;
	wire [p_sz*2-1:0] switch_right_6_35;
	wire [p_sz*2-1:0] left_switch_6_36;
	wire [p_sz*2-1:0] right_switch_6_36;
	wire [p_sz*2-1:0] switch_left_6_36;
	wire [p_sz*2-1:0] switch_right_6_36;
	wire [p_sz*2-1:0] left_switch_6_37;
	wire [p_sz*2-1:0] right_switch_6_37;
	wire [p_sz*2-1:0] switch_left_6_37;
	wire [p_sz*2-1:0] switch_right_6_37;
	wire [p_sz*2-1:0] left_switch_6_38;
	wire [p_sz*2-1:0] right_switch_6_38;
	wire [p_sz*2-1:0] switch_left_6_38;
	wire [p_sz*2-1:0] switch_right_6_38;
	wire [p_sz*2-1:0] left_switch_6_39;
	wire [p_sz*2-1:0] right_switch_6_39;
	wire [p_sz*2-1:0] switch_left_6_39;
	wire [p_sz*2-1:0] switch_right_6_39;
	wire [p_sz*2-1:0] left_switch_6_40;
	wire [p_sz*2-1:0] right_switch_6_40;
	wire [p_sz*2-1:0] switch_left_6_40;
	wire [p_sz*2-1:0] switch_right_6_40;
	wire [p_sz*2-1:0] left_switch_6_41;
	wire [p_sz*2-1:0] right_switch_6_41;
	wire [p_sz*2-1:0] switch_left_6_41;
	wire [p_sz*2-1:0] switch_right_6_41;
	wire [p_sz*2-1:0] left_switch_6_42;
	wire [p_sz*2-1:0] right_switch_6_42;
	wire [p_sz*2-1:0] switch_left_6_42;
	wire [p_sz*2-1:0] switch_right_6_42;
	wire [p_sz*2-1:0] left_switch_6_43;
	wire [p_sz*2-1:0] right_switch_6_43;
	wire [p_sz*2-1:0] switch_left_6_43;
	wire [p_sz*2-1:0] switch_right_6_43;
	wire [p_sz*2-1:0] left_switch_6_44;
	wire [p_sz*2-1:0] right_switch_6_44;
	wire [p_sz*2-1:0] switch_left_6_44;
	wire [p_sz*2-1:0] switch_right_6_44;
	wire [p_sz*2-1:0] left_switch_6_45;
	wire [p_sz*2-1:0] right_switch_6_45;
	wire [p_sz*2-1:0] switch_left_6_45;
	wire [p_sz*2-1:0] switch_right_6_45;
	wire [p_sz*2-1:0] left_switch_6_46;
	wire [p_sz*2-1:0] right_switch_6_46;
	wire [p_sz*2-1:0] switch_left_6_46;
	wire [p_sz*2-1:0] switch_right_6_46;
	wire [p_sz*2-1:0] left_switch_6_47;
	wire [p_sz*2-1:0] right_switch_6_47;
	wire [p_sz*2-1:0] switch_left_6_47;
	wire [p_sz*2-1:0] switch_right_6_47;
	wire [p_sz*2-1:0] left_switch_6_48;
	wire [p_sz*2-1:0] right_switch_6_48;
	wire [p_sz*2-1:0] switch_left_6_48;
	wire [p_sz*2-1:0] switch_right_6_48;
	wire [p_sz*2-1:0] left_switch_6_49;
	wire [p_sz*2-1:0] right_switch_6_49;
	wire [p_sz*2-1:0] switch_left_6_49;
	wire [p_sz*2-1:0] switch_right_6_49;
	wire [p_sz*2-1:0] left_switch_6_50;
	wire [p_sz*2-1:0] right_switch_6_50;
	wire [p_sz*2-1:0] switch_left_6_50;
	wire [p_sz*2-1:0] switch_right_6_50;
	wire [p_sz*2-1:0] left_switch_6_51;
	wire [p_sz*2-1:0] right_switch_6_51;
	wire [p_sz*2-1:0] switch_left_6_51;
	wire [p_sz*2-1:0] switch_right_6_51;
	wire [p_sz*2-1:0] left_switch_6_52;
	wire [p_sz*2-1:0] right_switch_6_52;
	wire [p_sz*2-1:0] switch_left_6_52;
	wire [p_sz*2-1:0] switch_right_6_52;
	wire [p_sz*2-1:0] left_switch_6_53;
	wire [p_sz*2-1:0] right_switch_6_53;
	wire [p_sz*2-1:0] switch_left_6_53;
	wire [p_sz*2-1:0] switch_right_6_53;
	wire [p_sz*2-1:0] left_switch_6_54;
	wire [p_sz*2-1:0] right_switch_6_54;
	wire [p_sz*2-1:0] switch_left_6_54;
	wire [p_sz*2-1:0] switch_right_6_54;
	wire [p_sz*2-1:0] left_switch_6_55;
	wire [p_sz*2-1:0] right_switch_6_55;
	wire [p_sz*2-1:0] switch_left_6_55;
	wire [p_sz*2-1:0] switch_right_6_55;
	wire [p_sz*2-1:0] left_switch_6_56;
	wire [p_sz*2-1:0] right_switch_6_56;
	wire [p_sz*2-1:0] switch_left_6_56;
	wire [p_sz*2-1:0] switch_right_6_56;
	wire [p_sz*2-1:0] left_switch_6_57;
	wire [p_sz*2-1:0] right_switch_6_57;
	wire [p_sz*2-1:0] switch_left_6_57;
	wire [p_sz*2-1:0] switch_right_6_57;
	wire [p_sz*2-1:0] left_switch_6_58;
	wire [p_sz*2-1:0] right_switch_6_58;
	wire [p_sz*2-1:0] switch_left_6_58;
	wire [p_sz*2-1:0] switch_right_6_58;
	wire [p_sz*2-1:0] left_switch_6_59;
	wire [p_sz*2-1:0] right_switch_6_59;
	wire [p_sz*2-1:0] switch_left_6_59;
	wire [p_sz*2-1:0] switch_right_6_59;
	wire [p_sz*2-1:0] left_switch_6_60;
	wire [p_sz*2-1:0] right_switch_6_60;
	wire [p_sz*2-1:0] switch_left_6_60;
	wire [p_sz*2-1:0] switch_right_6_60;
	wire [p_sz*2-1:0] left_switch_6_61;
	wire [p_sz*2-1:0] right_switch_6_61;
	wire [p_sz*2-1:0] switch_left_6_61;
	wire [p_sz*2-1:0] switch_right_6_61;
	wire [p_sz*2-1:0] left_switch_6_62;
	wire [p_sz*2-1:0] right_switch_6_62;
	wire [p_sz*2-1:0] switch_left_6_62;
	wire [p_sz*2-1:0] switch_right_6_62;
	wire [p_sz*2-1:0] left_switch_6_63;
	wire [p_sz*2-1:0] right_switch_6_63;
	wire [p_sz*2-1:0] switch_left_6_63;
	wire [p_sz*2-1:0] switch_right_6_63;
	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_0),
		.u_bus_i(switch_left_5_0),
		.l_bus_i(left_switch_6_0),
		.r_bus_i(right_switch_6_0),
		.l_bus_o(switch_left_6_0),
		.r_bus_o(switch_right_6_0));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_0),
		.u_bus_i(switch_right_5_0),
		.l_bus_i(left_switch_6_1),
		.r_bus_i(right_switch_6_1),
		.l_bus_o(switch_left_6_1),
		.r_bus_o(switch_right_6_1));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_1),
		.u_bus_i(switch_left_5_1),
		.l_bus_i(left_switch_6_2),
		.r_bus_i(right_switch_6_2),
		.l_bus_o(switch_left_6_2),
		.r_bus_o(switch_right_6_2));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_3(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_1),
		.u_bus_i(switch_right_5_1),
		.l_bus_i(left_switch_6_3),
		.r_bus_i(right_switch_6_3),
		.l_bus_o(switch_left_6_3),
		.r_bus_o(switch_right_6_3));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(4),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_4(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_2),
		.u_bus_i(switch_left_5_2),
		.l_bus_i(left_switch_6_4),
		.r_bus_i(right_switch_6_4),
		.l_bus_o(switch_left_6_4),
		.r_bus_o(switch_right_6_4));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(5),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_5(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_2),
		.u_bus_i(switch_right_5_2),
		.l_bus_i(left_switch_6_5),
		.r_bus_i(right_switch_6_5),
		.l_bus_o(switch_left_6_5),
		.r_bus_o(switch_right_6_5));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(6),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_6(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_3),
		.u_bus_i(switch_left_5_3),
		.l_bus_i(left_switch_6_6),
		.r_bus_i(right_switch_6_6),
		.l_bus_o(switch_left_6_6),
		.r_bus_o(switch_right_6_6));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(7),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_7(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_3),
		.u_bus_i(switch_right_5_3),
		.l_bus_i(left_switch_6_7),
		.r_bus_i(right_switch_6_7),
		.l_bus_o(switch_left_6_7),
		.r_bus_o(switch_right_6_7));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(8),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_8(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_4),
		.u_bus_i(switch_left_5_4),
		.l_bus_i(left_switch_6_8),
		.r_bus_i(right_switch_6_8),
		.l_bus_o(switch_left_6_8),
		.r_bus_o(switch_right_6_8));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(9),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_9(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_4),
		.u_bus_i(switch_right_5_4),
		.l_bus_i(left_switch_6_9),
		.r_bus_i(right_switch_6_9),
		.l_bus_o(switch_left_6_9),
		.r_bus_o(switch_right_6_9));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(10),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_10(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_5),
		.u_bus_i(switch_left_5_5),
		.l_bus_i(left_switch_6_10),
		.r_bus_i(right_switch_6_10),
		.l_bus_o(switch_left_6_10),
		.r_bus_o(switch_right_6_10));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(11),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_11(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_5),
		.u_bus_i(switch_right_5_5),
		.l_bus_i(left_switch_6_11),
		.r_bus_i(right_switch_6_11),
		.l_bus_o(switch_left_6_11),
		.r_bus_o(switch_right_6_11));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(12),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_12(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_6),
		.u_bus_i(switch_left_5_6),
		.l_bus_i(left_switch_6_12),
		.r_bus_i(right_switch_6_12),
		.l_bus_o(switch_left_6_12),
		.r_bus_o(switch_right_6_12));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(13),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_13(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_6),
		.u_bus_i(switch_right_5_6),
		.l_bus_i(left_switch_6_13),
		.r_bus_i(right_switch_6_13),
		.l_bus_o(switch_left_6_13),
		.r_bus_o(switch_right_6_13));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(14),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_14(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_7),
		.u_bus_i(switch_left_5_7),
		.l_bus_i(left_switch_6_14),
		.r_bus_i(right_switch_6_14),
		.l_bus_o(switch_left_6_14),
		.r_bus_o(switch_right_6_14));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(15),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_15(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_7),
		.u_bus_i(switch_right_5_7),
		.l_bus_i(left_switch_6_15),
		.r_bus_i(right_switch_6_15),
		.l_bus_o(switch_left_6_15),
		.r_bus_o(switch_right_6_15));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(16),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_16(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_8),
		.u_bus_i(switch_left_5_8),
		.l_bus_i(left_switch_6_16),
		.r_bus_i(right_switch_6_16),
		.l_bus_o(switch_left_6_16),
		.r_bus_o(switch_right_6_16));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(17),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_17(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_8),
		.u_bus_i(switch_right_5_8),
		.l_bus_i(left_switch_6_17),
		.r_bus_i(right_switch_6_17),
		.l_bus_o(switch_left_6_17),
		.r_bus_o(switch_right_6_17));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(18),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_18(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_9),
		.u_bus_i(switch_left_5_9),
		.l_bus_i(left_switch_6_18),
		.r_bus_i(right_switch_6_18),
		.l_bus_o(switch_left_6_18),
		.r_bus_o(switch_right_6_18));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(19),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_19(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_9),
		.u_bus_i(switch_right_5_9),
		.l_bus_i(left_switch_6_19),
		.r_bus_i(right_switch_6_19),
		.l_bus_o(switch_left_6_19),
		.r_bus_o(switch_right_6_19));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(20),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_20(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_10),
		.u_bus_i(switch_left_5_10),
		.l_bus_i(left_switch_6_20),
		.r_bus_i(right_switch_6_20),
		.l_bus_o(switch_left_6_20),
		.r_bus_o(switch_right_6_20));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(21),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_21(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_10),
		.u_bus_i(switch_right_5_10),
		.l_bus_i(left_switch_6_21),
		.r_bus_i(right_switch_6_21),
		.l_bus_o(switch_left_6_21),
		.r_bus_o(switch_right_6_21));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(22),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_22(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_11),
		.u_bus_i(switch_left_5_11),
		.l_bus_i(left_switch_6_22),
		.r_bus_i(right_switch_6_22),
		.l_bus_o(switch_left_6_22),
		.r_bus_o(switch_right_6_22));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(23),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_23(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_11),
		.u_bus_i(switch_right_5_11),
		.l_bus_i(left_switch_6_23),
		.r_bus_i(right_switch_6_23),
		.l_bus_o(switch_left_6_23),
		.r_bus_o(switch_right_6_23));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(24),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_24(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_12),
		.u_bus_i(switch_left_5_12),
		.l_bus_i(left_switch_6_24),
		.r_bus_i(right_switch_6_24),
		.l_bus_o(switch_left_6_24),
		.r_bus_o(switch_right_6_24));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(25),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_25(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_12),
		.u_bus_i(switch_right_5_12),
		.l_bus_i(left_switch_6_25),
		.r_bus_i(right_switch_6_25),
		.l_bus_o(switch_left_6_25),
		.r_bus_o(switch_right_6_25));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(26),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_26(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_13),
		.u_bus_i(switch_left_5_13),
		.l_bus_i(left_switch_6_26),
		.r_bus_i(right_switch_6_26),
		.l_bus_o(switch_left_6_26),
		.r_bus_o(switch_right_6_26));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(27),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_27(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_13),
		.u_bus_i(switch_right_5_13),
		.l_bus_i(left_switch_6_27),
		.r_bus_i(right_switch_6_27),
		.l_bus_o(switch_left_6_27),
		.r_bus_o(switch_right_6_27));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(28),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_28(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_14),
		.u_bus_i(switch_left_5_14),
		.l_bus_i(left_switch_6_28),
		.r_bus_i(right_switch_6_28),
		.l_bus_o(switch_left_6_28),
		.r_bus_o(switch_right_6_28));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(29),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_29(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_14),
		.u_bus_i(switch_right_5_14),
		.l_bus_i(left_switch_6_29),
		.r_bus_i(right_switch_6_29),
		.l_bus_o(switch_left_6_29),
		.r_bus_o(switch_right_6_29));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(30),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_30(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_15),
		.u_bus_i(switch_left_5_15),
		.l_bus_i(left_switch_6_30),
		.r_bus_i(right_switch_6_30),
		.l_bus_o(switch_left_6_30),
		.r_bus_o(switch_right_6_30));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(31),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_31(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_15),
		.u_bus_i(switch_right_5_15),
		.l_bus_i(left_switch_6_31),
		.r_bus_i(right_switch_6_31),
		.l_bus_o(switch_left_6_31),
		.r_bus_o(switch_right_6_31));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(32),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_32(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_16),
		.u_bus_i(switch_left_5_16),
		.l_bus_i(left_switch_6_32),
		.r_bus_i(right_switch_6_32),
		.l_bus_o(switch_left_6_32),
		.r_bus_o(switch_right_6_32));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(33),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_33(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_16),
		.u_bus_i(switch_right_5_16),
		.l_bus_i(left_switch_6_33),
		.r_bus_i(right_switch_6_33),
		.l_bus_o(switch_left_6_33),
		.r_bus_o(switch_right_6_33));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(34),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_34(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_17),
		.u_bus_i(switch_left_5_17),
		.l_bus_i(left_switch_6_34),
		.r_bus_i(right_switch_6_34),
		.l_bus_o(switch_left_6_34),
		.r_bus_o(switch_right_6_34));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(35),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_35(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_17),
		.u_bus_i(switch_right_5_17),
		.l_bus_i(left_switch_6_35),
		.r_bus_i(right_switch_6_35),
		.l_bus_o(switch_left_6_35),
		.r_bus_o(switch_right_6_35));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(36),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_36(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_18),
		.u_bus_i(switch_left_5_18),
		.l_bus_i(left_switch_6_36),
		.r_bus_i(right_switch_6_36),
		.l_bus_o(switch_left_6_36),
		.r_bus_o(switch_right_6_36));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(37),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_37(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_18),
		.u_bus_i(switch_right_5_18),
		.l_bus_i(left_switch_6_37),
		.r_bus_i(right_switch_6_37),
		.l_bus_o(switch_left_6_37),
		.r_bus_o(switch_right_6_37));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(38),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_38(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_19),
		.u_bus_i(switch_left_5_19),
		.l_bus_i(left_switch_6_38),
		.r_bus_i(right_switch_6_38),
		.l_bus_o(switch_left_6_38),
		.r_bus_o(switch_right_6_38));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(39),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_39(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_19),
		.u_bus_i(switch_right_5_19),
		.l_bus_i(left_switch_6_39),
		.r_bus_i(right_switch_6_39),
		.l_bus_o(switch_left_6_39),
		.r_bus_o(switch_right_6_39));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(40),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_40(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_20),
		.u_bus_i(switch_left_5_20),
		.l_bus_i(left_switch_6_40),
		.r_bus_i(right_switch_6_40),
		.l_bus_o(switch_left_6_40),
		.r_bus_o(switch_right_6_40));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(41),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_41(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_20),
		.u_bus_i(switch_right_5_20),
		.l_bus_i(left_switch_6_41),
		.r_bus_i(right_switch_6_41),
		.l_bus_o(switch_left_6_41),
		.r_bus_o(switch_right_6_41));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(42),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_42(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_21),
		.u_bus_i(switch_left_5_21),
		.l_bus_i(left_switch_6_42),
		.r_bus_i(right_switch_6_42),
		.l_bus_o(switch_left_6_42),
		.r_bus_o(switch_right_6_42));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(43),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_43(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_21),
		.u_bus_i(switch_right_5_21),
		.l_bus_i(left_switch_6_43),
		.r_bus_i(right_switch_6_43),
		.l_bus_o(switch_left_6_43),
		.r_bus_o(switch_right_6_43));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(44),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_44(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_22),
		.u_bus_i(switch_left_5_22),
		.l_bus_i(left_switch_6_44),
		.r_bus_i(right_switch_6_44),
		.l_bus_o(switch_left_6_44),
		.r_bus_o(switch_right_6_44));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(45),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_45(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_22),
		.u_bus_i(switch_right_5_22),
		.l_bus_i(left_switch_6_45),
		.r_bus_i(right_switch_6_45),
		.l_bus_o(switch_left_6_45),
		.r_bus_o(switch_right_6_45));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(46),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_46(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_23),
		.u_bus_i(switch_left_5_23),
		.l_bus_i(left_switch_6_46),
		.r_bus_i(right_switch_6_46),
		.l_bus_o(switch_left_6_46),
		.r_bus_o(switch_right_6_46));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(47),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_47(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_23),
		.u_bus_i(switch_right_5_23),
		.l_bus_i(left_switch_6_47),
		.r_bus_i(right_switch_6_47),
		.l_bus_o(switch_left_6_47),
		.r_bus_o(switch_right_6_47));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(48),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_48(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_24),
		.u_bus_i(switch_left_5_24),
		.l_bus_i(left_switch_6_48),
		.r_bus_i(right_switch_6_48),
		.l_bus_o(switch_left_6_48),
		.r_bus_o(switch_right_6_48));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(49),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_49(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_24),
		.u_bus_i(switch_right_5_24),
		.l_bus_i(left_switch_6_49),
		.r_bus_i(right_switch_6_49),
		.l_bus_o(switch_left_6_49),
		.r_bus_o(switch_right_6_49));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(50),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_50(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_25),
		.u_bus_i(switch_left_5_25),
		.l_bus_i(left_switch_6_50),
		.r_bus_i(right_switch_6_50),
		.l_bus_o(switch_left_6_50),
		.r_bus_o(switch_right_6_50));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(51),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_51(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_25),
		.u_bus_i(switch_right_5_25),
		.l_bus_i(left_switch_6_51),
		.r_bus_i(right_switch_6_51),
		.l_bus_o(switch_left_6_51),
		.r_bus_o(switch_right_6_51));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(52),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_52(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_26),
		.u_bus_i(switch_left_5_26),
		.l_bus_i(left_switch_6_52),
		.r_bus_i(right_switch_6_52),
		.l_bus_o(switch_left_6_52),
		.r_bus_o(switch_right_6_52));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(53),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_53(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_26),
		.u_bus_i(switch_right_5_26),
		.l_bus_i(left_switch_6_53),
		.r_bus_i(right_switch_6_53),
		.l_bus_o(switch_left_6_53),
		.r_bus_o(switch_right_6_53));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(54),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_54(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_27),
		.u_bus_i(switch_left_5_27),
		.l_bus_i(left_switch_6_54),
		.r_bus_i(right_switch_6_54),
		.l_bus_o(switch_left_6_54),
		.r_bus_o(switch_right_6_54));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(55),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_55(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_27),
		.u_bus_i(switch_right_5_27),
		.l_bus_i(left_switch_6_55),
		.r_bus_i(right_switch_6_55),
		.l_bus_o(switch_left_6_55),
		.r_bus_o(switch_right_6_55));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(56),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_56(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_28),
		.u_bus_i(switch_left_5_28),
		.l_bus_i(left_switch_6_56),
		.r_bus_i(right_switch_6_56),
		.l_bus_o(switch_left_6_56),
		.r_bus_o(switch_right_6_56));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(57),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_57(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_28),
		.u_bus_i(switch_right_5_28),
		.l_bus_i(left_switch_6_57),
		.r_bus_i(right_switch_6_57),
		.l_bus_o(switch_left_6_57),
		.r_bus_o(switch_right_6_57));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(58),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_58(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_29),
		.u_bus_i(switch_left_5_29),
		.l_bus_i(left_switch_6_58),
		.r_bus_i(right_switch_6_58),
		.l_bus_o(switch_left_6_58),
		.r_bus_o(switch_right_6_58));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(59),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_59(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_29),
		.u_bus_i(switch_right_5_29),
		.l_bus_i(left_switch_6_59),
		.r_bus_i(right_switch_6_59),
		.l_bus_o(switch_left_6_59),
		.r_bus_o(switch_right_6_59));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(60),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_60(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_30),
		.u_bus_i(switch_left_5_30),
		.l_bus_i(left_switch_6_60),
		.r_bus_i(right_switch_6_60),
		.l_bus_o(switch_left_6_60),
		.r_bus_o(switch_right_6_60));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(61),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_61(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_30),
		.u_bus_i(switch_right_5_30),
		.l_bus_i(left_switch_6_61),
		.r_bus_i(right_switch_6_61),
		.l_bus_o(switch_left_6_61),
		.r_bus_o(switch_right_6_61));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(62),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_62(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_5_31),
		.u_bus_i(switch_left_5_31),
		.l_bus_i(left_switch_6_62),
		.r_bus_i(right_switch_6_62),
		.l_bus_o(switch_left_6_62),
		.r_bus_o(switch_right_6_62));

	t_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(63),
		.level(6),
		.p_sz(p_sz),
		.num_switches(2)
		)t_lvl_6_63(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_5_31),
		.u_bus_i(switch_right_5_31),
		.l_bus_i(left_switch_6_63),
		.r_bus_i(right_switch_6_63),
		.l_bus_o(switch_left_6_63),
		.r_bus_o(switch_right_6_63));


//--------level=7--------------
	wire [p_sz*1-1:0] left_switch_7_0;
	wire [p_sz*1-1:0] right_switch_7_0;
	wire [p_sz*1-1:0] switch_left_7_0;
	wire [p_sz*1-1:0] switch_right_7_0;
	wire [p_sz*1-1:0] left_switch_7_1;
	wire [p_sz*1-1:0] right_switch_7_1;
	wire [p_sz*1-1:0] switch_left_7_1;
	wire [p_sz*1-1:0] switch_right_7_1;
	wire [p_sz*1-1:0] left_switch_7_2;
	wire [p_sz*1-1:0] right_switch_7_2;
	wire [p_sz*1-1:0] switch_left_7_2;
	wire [p_sz*1-1:0] switch_right_7_2;
	wire [p_sz*1-1:0] left_switch_7_3;
	wire [p_sz*1-1:0] right_switch_7_3;
	wire [p_sz*1-1:0] switch_left_7_3;
	wire [p_sz*1-1:0] switch_right_7_3;
	wire [p_sz*1-1:0] left_switch_7_4;
	wire [p_sz*1-1:0] right_switch_7_4;
	wire [p_sz*1-1:0] switch_left_7_4;
	wire [p_sz*1-1:0] switch_right_7_4;
	wire [p_sz*1-1:0] left_switch_7_5;
	wire [p_sz*1-1:0] right_switch_7_5;
	wire [p_sz*1-1:0] switch_left_7_5;
	wire [p_sz*1-1:0] switch_right_7_5;
	wire [p_sz*1-1:0] left_switch_7_6;
	wire [p_sz*1-1:0] right_switch_7_6;
	wire [p_sz*1-1:0] switch_left_7_6;
	wire [p_sz*1-1:0] switch_right_7_6;
	wire [p_sz*1-1:0] left_switch_7_7;
	wire [p_sz*1-1:0] right_switch_7_7;
	wire [p_sz*1-1:0] switch_left_7_7;
	wire [p_sz*1-1:0] switch_right_7_7;
	wire [p_sz*1-1:0] left_switch_7_8;
	wire [p_sz*1-1:0] right_switch_7_8;
	wire [p_sz*1-1:0] switch_left_7_8;
	wire [p_sz*1-1:0] switch_right_7_8;
	wire [p_sz*1-1:0] left_switch_7_9;
	wire [p_sz*1-1:0] right_switch_7_9;
	wire [p_sz*1-1:0] switch_left_7_9;
	wire [p_sz*1-1:0] switch_right_7_9;
	wire [p_sz*1-1:0] left_switch_7_10;
	wire [p_sz*1-1:0] right_switch_7_10;
	wire [p_sz*1-1:0] switch_left_7_10;
	wire [p_sz*1-1:0] switch_right_7_10;
	wire [p_sz*1-1:0] left_switch_7_11;
	wire [p_sz*1-1:0] right_switch_7_11;
	wire [p_sz*1-1:0] switch_left_7_11;
	wire [p_sz*1-1:0] switch_right_7_11;
	wire [p_sz*1-1:0] left_switch_7_12;
	wire [p_sz*1-1:0] right_switch_7_12;
	wire [p_sz*1-1:0] switch_left_7_12;
	wire [p_sz*1-1:0] switch_right_7_12;
	wire [p_sz*1-1:0] left_switch_7_13;
	wire [p_sz*1-1:0] right_switch_7_13;
	wire [p_sz*1-1:0] switch_left_7_13;
	wire [p_sz*1-1:0] switch_right_7_13;
	wire [p_sz*1-1:0] left_switch_7_14;
	wire [p_sz*1-1:0] right_switch_7_14;
	wire [p_sz*1-1:0] switch_left_7_14;
	wire [p_sz*1-1:0] switch_right_7_14;
	wire [p_sz*1-1:0] left_switch_7_15;
	wire [p_sz*1-1:0] right_switch_7_15;
	wire [p_sz*1-1:0] switch_left_7_15;
	wire [p_sz*1-1:0] switch_right_7_15;
	wire [p_sz*1-1:0] left_switch_7_16;
	wire [p_sz*1-1:0] right_switch_7_16;
	wire [p_sz*1-1:0] switch_left_7_16;
	wire [p_sz*1-1:0] switch_right_7_16;
	wire [p_sz*1-1:0] left_switch_7_17;
	wire [p_sz*1-1:0] right_switch_7_17;
	wire [p_sz*1-1:0] switch_left_7_17;
	wire [p_sz*1-1:0] switch_right_7_17;
	wire [p_sz*1-1:0] left_switch_7_18;
	wire [p_sz*1-1:0] right_switch_7_18;
	wire [p_sz*1-1:0] switch_left_7_18;
	wire [p_sz*1-1:0] switch_right_7_18;
	wire [p_sz*1-1:0] left_switch_7_19;
	wire [p_sz*1-1:0] right_switch_7_19;
	wire [p_sz*1-1:0] switch_left_7_19;
	wire [p_sz*1-1:0] switch_right_7_19;
	wire [p_sz*1-1:0] left_switch_7_20;
	wire [p_sz*1-1:0] right_switch_7_20;
	wire [p_sz*1-1:0] switch_left_7_20;
	wire [p_sz*1-1:0] switch_right_7_20;
	wire [p_sz*1-1:0] left_switch_7_21;
	wire [p_sz*1-1:0] right_switch_7_21;
	wire [p_sz*1-1:0] switch_left_7_21;
	wire [p_sz*1-1:0] switch_right_7_21;
	wire [p_sz*1-1:0] left_switch_7_22;
	wire [p_sz*1-1:0] right_switch_7_22;
	wire [p_sz*1-1:0] switch_left_7_22;
	wire [p_sz*1-1:0] switch_right_7_22;
	wire [p_sz*1-1:0] left_switch_7_23;
	wire [p_sz*1-1:0] right_switch_7_23;
	wire [p_sz*1-1:0] switch_left_7_23;
	wire [p_sz*1-1:0] switch_right_7_23;
	wire [p_sz*1-1:0] left_switch_7_24;
	wire [p_sz*1-1:0] right_switch_7_24;
	wire [p_sz*1-1:0] switch_left_7_24;
	wire [p_sz*1-1:0] switch_right_7_24;
	wire [p_sz*1-1:0] left_switch_7_25;
	wire [p_sz*1-1:0] right_switch_7_25;
	wire [p_sz*1-1:0] switch_left_7_25;
	wire [p_sz*1-1:0] switch_right_7_25;
	wire [p_sz*1-1:0] left_switch_7_26;
	wire [p_sz*1-1:0] right_switch_7_26;
	wire [p_sz*1-1:0] switch_left_7_26;
	wire [p_sz*1-1:0] switch_right_7_26;
	wire [p_sz*1-1:0] left_switch_7_27;
	wire [p_sz*1-1:0] right_switch_7_27;
	wire [p_sz*1-1:0] switch_left_7_27;
	wire [p_sz*1-1:0] switch_right_7_27;
	wire [p_sz*1-1:0] left_switch_7_28;
	wire [p_sz*1-1:0] right_switch_7_28;
	wire [p_sz*1-1:0] switch_left_7_28;
	wire [p_sz*1-1:0] switch_right_7_28;
	wire [p_sz*1-1:0] left_switch_7_29;
	wire [p_sz*1-1:0] right_switch_7_29;
	wire [p_sz*1-1:0] switch_left_7_29;
	wire [p_sz*1-1:0] switch_right_7_29;
	wire [p_sz*1-1:0] left_switch_7_30;
	wire [p_sz*1-1:0] right_switch_7_30;
	wire [p_sz*1-1:0] switch_left_7_30;
	wire [p_sz*1-1:0] switch_right_7_30;
	wire [p_sz*1-1:0] left_switch_7_31;
	wire [p_sz*1-1:0] right_switch_7_31;
	wire [p_sz*1-1:0] switch_left_7_31;
	wire [p_sz*1-1:0] switch_right_7_31;
	wire [p_sz*1-1:0] left_switch_7_32;
	wire [p_sz*1-1:0] right_switch_7_32;
	wire [p_sz*1-1:0] switch_left_7_32;
	wire [p_sz*1-1:0] switch_right_7_32;
	wire [p_sz*1-1:0] left_switch_7_33;
	wire [p_sz*1-1:0] right_switch_7_33;
	wire [p_sz*1-1:0] switch_left_7_33;
	wire [p_sz*1-1:0] switch_right_7_33;
	wire [p_sz*1-1:0] left_switch_7_34;
	wire [p_sz*1-1:0] right_switch_7_34;
	wire [p_sz*1-1:0] switch_left_7_34;
	wire [p_sz*1-1:0] switch_right_7_34;
	wire [p_sz*1-1:0] left_switch_7_35;
	wire [p_sz*1-1:0] right_switch_7_35;
	wire [p_sz*1-1:0] switch_left_7_35;
	wire [p_sz*1-1:0] switch_right_7_35;
	wire [p_sz*1-1:0] left_switch_7_36;
	wire [p_sz*1-1:0] right_switch_7_36;
	wire [p_sz*1-1:0] switch_left_7_36;
	wire [p_sz*1-1:0] switch_right_7_36;
	wire [p_sz*1-1:0] left_switch_7_37;
	wire [p_sz*1-1:0] right_switch_7_37;
	wire [p_sz*1-1:0] switch_left_7_37;
	wire [p_sz*1-1:0] switch_right_7_37;
	wire [p_sz*1-1:0] left_switch_7_38;
	wire [p_sz*1-1:0] right_switch_7_38;
	wire [p_sz*1-1:0] switch_left_7_38;
	wire [p_sz*1-1:0] switch_right_7_38;
	wire [p_sz*1-1:0] left_switch_7_39;
	wire [p_sz*1-1:0] right_switch_7_39;
	wire [p_sz*1-1:0] switch_left_7_39;
	wire [p_sz*1-1:0] switch_right_7_39;
	wire [p_sz*1-1:0] left_switch_7_40;
	wire [p_sz*1-1:0] right_switch_7_40;
	wire [p_sz*1-1:0] switch_left_7_40;
	wire [p_sz*1-1:0] switch_right_7_40;
	wire [p_sz*1-1:0] left_switch_7_41;
	wire [p_sz*1-1:0] right_switch_7_41;
	wire [p_sz*1-1:0] switch_left_7_41;
	wire [p_sz*1-1:0] switch_right_7_41;
	wire [p_sz*1-1:0] left_switch_7_42;
	wire [p_sz*1-1:0] right_switch_7_42;
	wire [p_sz*1-1:0] switch_left_7_42;
	wire [p_sz*1-1:0] switch_right_7_42;
	wire [p_sz*1-1:0] left_switch_7_43;
	wire [p_sz*1-1:0] right_switch_7_43;
	wire [p_sz*1-1:0] switch_left_7_43;
	wire [p_sz*1-1:0] switch_right_7_43;
	wire [p_sz*1-1:0] left_switch_7_44;
	wire [p_sz*1-1:0] right_switch_7_44;
	wire [p_sz*1-1:0] switch_left_7_44;
	wire [p_sz*1-1:0] switch_right_7_44;
	wire [p_sz*1-1:0] left_switch_7_45;
	wire [p_sz*1-1:0] right_switch_7_45;
	wire [p_sz*1-1:0] switch_left_7_45;
	wire [p_sz*1-1:0] switch_right_7_45;
	wire [p_sz*1-1:0] left_switch_7_46;
	wire [p_sz*1-1:0] right_switch_7_46;
	wire [p_sz*1-1:0] switch_left_7_46;
	wire [p_sz*1-1:0] switch_right_7_46;
	wire [p_sz*1-1:0] left_switch_7_47;
	wire [p_sz*1-1:0] right_switch_7_47;
	wire [p_sz*1-1:0] switch_left_7_47;
	wire [p_sz*1-1:0] switch_right_7_47;
	wire [p_sz*1-1:0] left_switch_7_48;
	wire [p_sz*1-1:0] right_switch_7_48;
	wire [p_sz*1-1:0] switch_left_7_48;
	wire [p_sz*1-1:0] switch_right_7_48;
	wire [p_sz*1-1:0] left_switch_7_49;
	wire [p_sz*1-1:0] right_switch_7_49;
	wire [p_sz*1-1:0] switch_left_7_49;
	wire [p_sz*1-1:0] switch_right_7_49;
	wire [p_sz*1-1:0] left_switch_7_50;
	wire [p_sz*1-1:0] right_switch_7_50;
	wire [p_sz*1-1:0] switch_left_7_50;
	wire [p_sz*1-1:0] switch_right_7_50;
	wire [p_sz*1-1:0] left_switch_7_51;
	wire [p_sz*1-1:0] right_switch_7_51;
	wire [p_sz*1-1:0] switch_left_7_51;
	wire [p_sz*1-1:0] switch_right_7_51;
	wire [p_sz*1-1:0] left_switch_7_52;
	wire [p_sz*1-1:0] right_switch_7_52;
	wire [p_sz*1-1:0] switch_left_7_52;
	wire [p_sz*1-1:0] switch_right_7_52;
	wire [p_sz*1-1:0] left_switch_7_53;
	wire [p_sz*1-1:0] right_switch_7_53;
	wire [p_sz*1-1:0] switch_left_7_53;
	wire [p_sz*1-1:0] switch_right_7_53;
	wire [p_sz*1-1:0] left_switch_7_54;
	wire [p_sz*1-1:0] right_switch_7_54;
	wire [p_sz*1-1:0] switch_left_7_54;
	wire [p_sz*1-1:0] switch_right_7_54;
	wire [p_sz*1-1:0] left_switch_7_55;
	wire [p_sz*1-1:0] right_switch_7_55;
	wire [p_sz*1-1:0] switch_left_7_55;
	wire [p_sz*1-1:0] switch_right_7_55;
	wire [p_sz*1-1:0] left_switch_7_56;
	wire [p_sz*1-1:0] right_switch_7_56;
	wire [p_sz*1-1:0] switch_left_7_56;
	wire [p_sz*1-1:0] switch_right_7_56;
	wire [p_sz*1-1:0] left_switch_7_57;
	wire [p_sz*1-1:0] right_switch_7_57;
	wire [p_sz*1-1:0] switch_left_7_57;
	wire [p_sz*1-1:0] switch_right_7_57;
	wire [p_sz*1-1:0] left_switch_7_58;
	wire [p_sz*1-1:0] right_switch_7_58;
	wire [p_sz*1-1:0] switch_left_7_58;
	wire [p_sz*1-1:0] switch_right_7_58;
	wire [p_sz*1-1:0] left_switch_7_59;
	wire [p_sz*1-1:0] right_switch_7_59;
	wire [p_sz*1-1:0] switch_left_7_59;
	wire [p_sz*1-1:0] switch_right_7_59;
	wire [p_sz*1-1:0] left_switch_7_60;
	wire [p_sz*1-1:0] right_switch_7_60;
	wire [p_sz*1-1:0] switch_left_7_60;
	wire [p_sz*1-1:0] switch_right_7_60;
	wire [p_sz*1-1:0] left_switch_7_61;
	wire [p_sz*1-1:0] right_switch_7_61;
	wire [p_sz*1-1:0] switch_left_7_61;
	wire [p_sz*1-1:0] switch_right_7_61;
	wire [p_sz*1-1:0] left_switch_7_62;
	wire [p_sz*1-1:0] right_switch_7_62;
	wire [p_sz*1-1:0] switch_left_7_62;
	wire [p_sz*1-1:0] switch_right_7_62;
	wire [p_sz*1-1:0] left_switch_7_63;
	wire [p_sz*1-1:0] right_switch_7_63;
	wire [p_sz*1-1:0] switch_left_7_63;
	wire [p_sz*1-1:0] switch_right_7_63;
	wire [p_sz*1-1:0] left_switch_7_64;
	wire [p_sz*1-1:0] right_switch_7_64;
	wire [p_sz*1-1:0] switch_left_7_64;
	wire [p_sz*1-1:0] switch_right_7_64;
	wire [p_sz*1-1:0] left_switch_7_65;
	wire [p_sz*1-1:0] right_switch_7_65;
	wire [p_sz*1-1:0] switch_left_7_65;
	wire [p_sz*1-1:0] switch_right_7_65;
	wire [p_sz*1-1:0] left_switch_7_66;
	wire [p_sz*1-1:0] right_switch_7_66;
	wire [p_sz*1-1:0] switch_left_7_66;
	wire [p_sz*1-1:0] switch_right_7_66;
	wire [p_sz*1-1:0] left_switch_7_67;
	wire [p_sz*1-1:0] right_switch_7_67;
	wire [p_sz*1-1:0] switch_left_7_67;
	wire [p_sz*1-1:0] switch_right_7_67;
	wire [p_sz*1-1:0] left_switch_7_68;
	wire [p_sz*1-1:0] right_switch_7_68;
	wire [p_sz*1-1:0] switch_left_7_68;
	wire [p_sz*1-1:0] switch_right_7_68;
	wire [p_sz*1-1:0] left_switch_7_69;
	wire [p_sz*1-1:0] right_switch_7_69;
	wire [p_sz*1-1:0] switch_left_7_69;
	wire [p_sz*1-1:0] switch_right_7_69;
	wire [p_sz*1-1:0] left_switch_7_70;
	wire [p_sz*1-1:0] right_switch_7_70;
	wire [p_sz*1-1:0] switch_left_7_70;
	wire [p_sz*1-1:0] switch_right_7_70;
	wire [p_sz*1-1:0] left_switch_7_71;
	wire [p_sz*1-1:0] right_switch_7_71;
	wire [p_sz*1-1:0] switch_left_7_71;
	wire [p_sz*1-1:0] switch_right_7_71;
	wire [p_sz*1-1:0] left_switch_7_72;
	wire [p_sz*1-1:0] right_switch_7_72;
	wire [p_sz*1-1:0] switch_left_7_72;
	wire [p_sz*1-1:0] switch_right_7_72;
	wire [p_sz*1-1:0] left_switch_7_73;
	wire [p_sz*1-1:0] right_switch_7_73;
	wire [p_sz*1-1:0] switch_left_7_73;
	wire [p_sz*1-1:0] switch_right_7_73;
	wire [p_sz*1-1:0] left_switch_7_74;
	wire [p_sz*1-1:0] right_switch_7_74;
	wire [p_sz*1-1:0] switch_left_7_74;
	wire [p_sz*1-1:0] switch_right_7_74;
	wire [p_sz*1-1:0] left_switch_7_75;
	wire [p_sz*1-1:0] right_switch_7_75;
	wire [p_sz*1-1:0] switch_left_7_75;
	wire [p_sz*1-1:0] switch_right_7_75;
	wire [p_sz*1-1:0] left_switch_7_76;
	wire [p_sz*1-1:0] right_switch_7_76;
	wire [p_sz*1-1:0] switch_left_7_76;
	wire [p_sz*1-1:0] switch_right_7_76;
	wire [p_sz*1-1:0] left_switch_7_77;
	wire [p_sz*1-1:0] right_switch_7_77;
	wire [p_sz*1-1:0] switch_left_7_77;
	wire [p_sz*1-1:0] switch_right_7_77;
	wire [p_sz*1-1:0] left_switch_7_78;
	wire [p_sz*1-1:0] right_switch_7_78;
	wire [p_sz*1-1:0] switch_left_7_78;
	wire [p_sz*1-1:0] switch_right_7_78;
	wire [p_sz*1-1:0] left_switch_7_79;
	wire [p_sz*1-1:0] right_switch_7_79;
	wire [p_sz*1-1:0] switch_left_7_79;
	wire [p_sz*1-1:0] switch_right_7_79;
	wire [p_sz*1-1:0] left_switch_7_80;
	wire [p_sz*1-1:0] right_switch_7_80;
	wire [p_sz*1-1:0] switch_left_7_80;
	wire [p_sz*1-1:0] switch_right_7_80;
	wire [p_sz*1-1:0] left_switch_7_81;
	wire [p_sz*1-1:0] right_switch_7_81;
	wire [p_sz*1-1:0] switch_left_7_81;
	wire [p_sz*1-1:0] switch_right_7_81;
	wire [p_sz*1-1:0] left_switch_7_82;
	wire [p_sz*1-1:0] right_switch_7_82;
	wire [p_sz*1-1:0] switch_left_7_82;
	wire [p_sz*1-1:0] switch_right_7_82;
	wire [p_sz*1-1:0] left_switch_7_83;
	wire [p_sz*1-1:0] right_switch_7_83;
	wire [p_sz*1-1:0] switch_left_7_83;
	wire [p_sz*1-1:0] switch_right_7_83;
	wire [p_sz*1-1:0] left_switch_7_84;
	wire [p_sz*1-1:0] right_switch_7_84;
	wire [p_sz*1-1:0] switch_left_7_84;
	wire [p_sz*1-1:0] switch_right_7_84;
	wire [p_sz*1-1:0] left_switch_7_85;
	wire [p_sz*1-1:0] right_switch_7_85;
	wire [p_sz*1-1:0] switch_left_7_85;
	wire [p_sz*1-1:0] switch_right_7_85;
	wire [p_sz*1-1:0] left_switch_7_86;
	wire [p_sz*1-1:0] right_switch_7_86;
	wire [p_sz*1-1:0] switch_left_7_86;
	wire [p_sz*1-1:0] switch_right_7_86;
	wire [p_sz*1-1:0] left_switch_7_87;
	wire [p_sz*1-1:0] right_switch_7_87;
	wire [p_sz*1-1:0] switch_left_7_87;
	wire [p_sz*1-1:0] switch_right_7_87;
	wire [p_sz*1-1:0] left_switch_7_88;
	wire [p_sz*1-1:0] right_switch_7_88;
	wire [p_sz*1-1:0] switch_left_7_88;
	wire [p_sz*1-1:0] switch_right_7_88;
	wire [p_sz*1-1:0] left_switch_7_89;
	wire [p_sz*1-1:0] right_switch_7_89;
	wire [p_sz*1-1:0] switch_left_7_89;
	wire [p_sz*1-1:0] switch_right_7_89;
	wire [p_sz*1-1:0] left_switch_7_90;
	wire [p_sz*1-1:0] right_switch_7_90;
	wire [p_sz*1-1:0] switch_left_7_90;
	wire [p_sz*1-1:0] switch_right_7_90;
	wire [p_sz*1-1:0] left_switch_7_91;
	wire [p_sz*1-1:0] right_switch_7_91;
	wire [p_sz*1-1:0] switch_left_7_91;
	wire [p_sz*1-1:0] switch_right_7_91;
	wire [p_sz*1-1:0] left_switch_7_92;
	wire [p_sz*1-1:0] right_switch_7_92;
	wire [p_sz*1-1:0] switch_left_7_92;
	wire [p_sz*1-1:0] switch_right_7_92;
	wire [p_sz*1-1:0] left_switch_7_93;
	wire [p_sz*1-1:0] right_switch_7_93;
	wire [p_sz*1-1:0] switch_left_7_93;
	wire [p_sz*1-1:0] switch_right_7_93;
	wire [p_sz*1-1:0] left_switch_7_94;
	wire [p_sz*1-1:0] right_switch_7_94;
	wire [p_sz*1-1:0] switch_left_7_94;
	wire [p_sz*1-1:0] switch_right_7_94;
	wire [p_sz*1-1:0] left_switch_7_95;
	wire [p_sz*1-1:0] right_switch_7_95;
	wire [p_sz*1-1:0] switch_left_7_95;
	wire [p_sz*1-1:0] switch_right_7_95;
	wire [p_sz*1-1:0] left_switch_7_96;
	wire [p_sz*1-1:0] right_switch_7_96;
	wire [p_sz*1-1:0] switch_left_7_96;
	wire [p_sz*1-1:0] switch_right_7_96;
	wire [p_sz*1-1:0] left_switch_7_97;
	wire [p_sz*1-1:0] right_switch_7_97;
	wire [p_sz*1-1:0] switch_left_7_97;
	wire [p_sz*1-1:0] switch_right_7_97;
	wire [p_sz*1-1:0] left_switch_7_98;
	wire [p_sz*1-1:0] right_switch_7_98;
	wire [p_sz*1-1:0] switch_left_7_98;
	wire [p_sz*1-1:0] switch_right_7_98;
	wire [p_sz*1-1:0] left_switch_7_99;
	wire [p_sz*1-1:0] right_switch_7_99;
	wire [p_sz*1-1:0] switch_left_7_99;
	wire [p_sz*1-1:0] switch_right_7_99;
	wire [p_sz*1-1:0] left_switch_7_100;
	wire [p_sz*1-1:0] right_switch_7_100;
	wire [p_sz*1-1:0] switch_left_7_100;
	wire [p_sz*1-1:0] switch_right_7_100;
	wire [p_sz*1-1:0] left_switch_7_101;
	wire [p_sz*1-1:0] right_switch_7_101;
	wire [p_sz*1-1:0] switch_left_7_101;
	wire [p_sz*1-1:0] switch_right_7_101;
	wire [p_sz*1-1:0] left_switch_7_102;
	wire [p_sz*1-1:0] right_switch_7_102;
	wire [p_sz*1-1:0] switch_left_7_102;
	wire [p_sz*1-1:0] switch_right_7_102;
	wire [p_sz*1-1:0] left_switch_7_103;
	wire [p_sz*1-1:0] right_switch_7_103;
	wire [p_sz*1-1:0] switch_left_7_103;
	wire [p_sz*1-1:0] switch_right_7_103;
	wire [p_sz*1-1:0] left_switch_7_104;
	wire [p_sz*1-1:0] right_switch_7_104;
	wire [p_sz*1-1:0] switch_left_7_104;
	wire [p_sz*1-1:0] switch_right_7_104;
	wire [p_sz*1-1:0] left_switch_7_105;
	wire [p_sz*1-1:0] right_switch_7_105;
	wire [p_sz*1-1:0] switch_left_7_105;
	wire [p_sz*1-1:0] switch_right_7_105;
	wire [p_sz*1-1:0] left_switch_7_106;
	wire [p_sz*1-1:0] right_switch_7_106;
	wire [p_sz*1-1:0] switch_left_7_106;
	wire [p_sz*1-1:0] switch_right_7_106;
	wire [p_sz*1-1:0] left_switch_7_107;
	wire [p_sz*1-1:0] right_switch_7_107;
	wire [p_sz*1-1:0] switch_left_7_107;
	wire [p_sz*1-1:0] switch_right_7_107;
	wire [p_sz*1-1:0] left_switch_7_108;
	wire [p_sz*1-1:0] right_switch_7_108;
	wire [p_sz*1-1:0] switch_left_7_108;
	wire [p_sz*1-1:0] switch_right_7_108;
	wire [p_sz*1-1:0] left_switch_7_109;
	wire [p_sz*1-1:0] right_switch_7_109;
	wire [p_sz*1-1:0] switch_left_7_109;
	wire [p_sz*1-1:0] switch_right_7_109;
	wire [p_sz*1-1:0] left_switch_7_110;
	wire [p_sz*1-1:0] right_switch_7_110;
	wire [p_sz*1-1:0] switch_left_7_110;
	wire [p_sz*1-1:0] switch_right_7_110;
	wire [p_sz*1-1:0] left_switch_7_111;
	wire [p_sz*1-1:0] right_switch_7_111;
	wire [p_sz*1-1:0] switch_left_7_111;
	wire [p_sz*1-1:0] switch_right_7_111;
	wire [p_sz*1-1:0] left_switch_7_112;
	wire [p_sz*1-1:0] right_switch_7_112;
	wire [p_sz*1-1:0] switch_left_7_112;
	wire [p_sz*1-1:0] switch_right_7_112;
	wire [p_sz*1-1:0] left_switch_7_113;
	wire [p_sz*1-1:0] right_switch_7_113;
	wire [p_sz*1-1:0] switch_left_7_113;
	wire [p_sz*1-1:0] switch_right_7_113;
	wire [p_sz*1-1:0] left_switch_7_114;
	wire [p_sz*1-1:0] right_switch_7_114;
	wire [p_sz*1-1:0] switch_left_7_114;
	wire [p_sz*1-1:0] switch_right_7_114;
	wire [p_sz*1-1:0] left_switch_7_115;
	wire [p_sz*1-1:0] right_switch_7_115;
	wire [p_sz*1-1:0] switch_left_7_115;
	wire [p_sz*1-1:0] switch_right_7_115;
	wire [p_sz*1-1:0] left_switch_7_116;
	wire [p_sz*1-1:0] right_switch_7_116;
	wire [p_sz*1-1:0] switch_left_7_116;
	wire [p_sz*1-1:0] switch_right_7_116;
	wire [p_sz*1-1:0] left_switch_7_117;
	wire [p_sz*1-1:0] right_switch_7_117;
	wire [p_sz*1-1:0] switch_left_7_117;
	wire [p_sz*1-1:0] switch_right_7_117;
	wire [p_sz*1-1:0] left_switch_7_118;
	wire [p_sz*1-1:0] right_switch_7_118;
	wire [p_sz*1-1:0] switch_left_7_118;
	wire [p_sz*1-1:0] switch_right_7_118;
	wire [p_sz*1-1:0] left_switch_7_119;
	wire [p_sz*1-1:0] right_switch_7_119;
	wire [p_sz*1-1:0] switch_left_7_119;
	wire [p_sz*1-1:0] switch_right_7_119;
	wire [p_sz*1-1:0] left_switch_7_120;
	wire [p_sz*1-1:0] right_switch_7_120;
	wire [p_sz*1-1:0] switch_left_7_120;
	wire [p_sz*1-1:0] switch_right_7_120;
	wire [p_sz*1-1:0] left_switch_7_121;
	wire [p_sz*1-1:0] right_switch_7_121;
	wire [p_sz*1-1:0] switch_left_7_121;
	wire [p_sz*1-1:0] switch_right_7_121;
	wire [p_sz*1-1:0] left_switch_7_122;
	wire [p_sz*1-1:0] right_switch_7_122;
	wire [p_sz*1-1:0] switch_left_7_122;
	wire [p_sz*1-1:0] switch_right_7_122;
	wire [p_sz*1-1:0] left_switch_7_123;
	wire [p_sz*1-1:0] right_switch_7_123;
	wire [p_sz*1-1:0] switch_left_7_123;
	wire [p_sz*1-1:0] switch_right_7_123;
	wire [p_sz*1-1:0] left_switch_7_124;
	wire [p_sz*1-1:0] right_switch_7_124;
	wire [p_sz*1-1:0] switch_left_7_124;
	wire [p_sz*1-1:0] switch_right_7_124;
	wire [p_sz*1-1:0] left_switch_7_125;
	wire [p_sz*1-1:0] right_switch_7_125;
	wire [p_sz*1-1:0] switch_left_7_125;
	wire [p_sz*1-1:0] switch_right_7_125;
	wire [p_sz*1-1:0] left_switch_7_126;
	wire [p_sz*1-1:0] right_switch_7_126;
	wire [p_sz*1-1:0] switch_left_7_126;
	wire [p_sz*1-1:0] switch_right_7_126;
	wire [p_sz*1-1:0] left_switch_7_127;
	wire [p_sz*1-1:0] right_switch_7_127;
	wire [p_sz*1-1:0] switch_left_7_127;
	wire [p_sz*1-1:0] switch_right_7_127;
	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_0(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_0),
		.u_bus_i(switch_left_6_0),
		.l_bus_i(left_switch_7_0),
		.r_bus_i(right_switch_7_0),
		.l_bus_o(switch_left_7_0),
		.r_bus_o(switch_right_7_0));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(1),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_1(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_0),
		.u_bus_i(switch_right_6_0),
		.l_bus_i(left_switch_7_1),
		.r_bus_i(right_switch_7_1),
		.l_bus_o(switch_left_7_1),
		.r_bus_o(switch_right_7_1));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(2),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_2(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_1),
		.u_bus_i(switch_left_6_1),
		.l_bus_i(left_switch_7_2),
		.r_bus_i(right_switch_7_2),
		.l_bus_o(switch_left_7_2),
		.r_bus_o(switch_right_7_2));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(3),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_3(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_1),
		.u_bus_i(switch_right_6_1),
		.l_bus_i(left_switch_7_3),
		.r_bus_i(right_switch_7_3),
		.l_bus_o(switch_left_7_3),
		.r_bus_o(switch_right_7_3));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(4),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_4(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_2),
		.u_bus_i(switch_left_6_2),
		.l_bus_i(left_switch_7_4),
		.r_bus_i(right_switch_7_4),
		.l_bus_o(switch_left_7_4),
		.r_bus_o(switch_right_7_4));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(5),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_5(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_2),
		.u_bus_i(switch_right_6_2),
		.l_bus_i(left_switch_7_5),
		.r_bus_i(right_switch_7_5),
		.l_bus_o(switch_left_7_5),
		.r_bus_o(switch_right_7_5));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(6),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_6(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_3),
		.u_bus_i(switch_left_6_3),
		.l_bus_i(left_switch_7_6),
		.r_bus_i(right_switch_7_6),
		.l_bus_o(switch_left_7_6),
		.r_bus_o(switch_right_7_6));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(7),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_7(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_3),
		.u_bus_i(switch_right_6_3),
		.l_bus_i(left_switch_7_7),
		.r_bus_i(right_switch_7_7),
		.l_bus_o(switch_left_7_7),
		.r_bus_o(switch_right_7_7));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(8),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_8(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_4),
		.u_bus_i(switch_left_6_4),
		.l_bus_i(left_switch_7_8),
		.r_bus_i(right_switch_7_8),
		.l_bus_o(switch_left_7_8),
		.r_bus_o(switch_right_7_8));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(9),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_9(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_4),
		.u_bus_i(switch_right_6_4),
		.l_bus_i(left_switch_7_9),
		.r_bus_i(right_switch_7_9),
		.l_bus_o(switch_left_7_9),
		.r_bus_o(switch_right_7_9));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(10),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_10(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_5),
		.u_bus_i(switch_left_6_5),
		.l_bus_i(left_switch_7_10),
		.r_bus_i(right_switch_7_10),
		.l_bus_o(switch_left_7_10),
		.r_bus_o(switch_right_7_10));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(11),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_11(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_5),
		.u_bus_i(switch_right_6_5),
		.l_bus_i(left_switch_7_11),
		.r_bus_i(right_switch_7_11),
		.l_bus_o(switch_left_7_11),
		.r_bus_o(switch_right_7_11));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(12),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_12(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_6),
		.u_bus_i(switch_left_6_6),
		.l_bus_i(left_switch_7_12),
		.r_bus_i(right_switch_7_12),
		.l_bus_o(switch_left_7_12),
		.r_bus_o(switch_right_7_12));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(13),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_13(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_6),
		.u_bus_i(switch_right_6_6),
		.l_bus_i(left_switch_7_13),
		.r_bus_i(right_switch_7_13),
		.l_bus_o(switch_left_7_13),
		.r_bus_o(switch_right_7_13));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(14),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_14(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_7),
		.u_bus_i(switch_left_6_7),
		.l_bus_i(left_switch_7_14),
		.r_bus_i(right_switch_7_14),
		.l_bus_o(switch_left_7_14),
		.r_bus_o(switch_right_7_14));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(15),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_15(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_7),
		.u_bus_i(switch_right_6_7),
		.l_bus_i(left_switch_7_15),
		.r_bus_i(right_switch_7_15),
		.l_bus_o(switch_left_7_15),
		.r_bus_o(switch_right_7_15));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(16),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_16(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_8),
		.u_bus_i(switch_left_6_8),
		.l_bus_i(left_switch_7_16),
		.r_bus_i(right_switch_7_16),
		.l_bus_o(switch_left_7_16),
		.r_bus_o(switch_right_7_16));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(17),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_17(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_8),
		.u_bus_i(switch_right_6_8),
		.l_bus_i(left_switch_7_17),
		.r_bus_i(right_switch_7_17),
		.l_bus_o(switch_left_7_17),
		.r_bus_o(switch_right_7_17));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(18),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_18(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_9),
		.u_bus_i(switch_left_6_9),
		.l_bus_i(left_switch_7_18),
		.r_bus_i(right_switch_7_18),
		.l_bus_o(switch_left_7_18),
		.r_bus_o(switch_right_7_18));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(19),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_19(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_9),
		.u_bus_i(switch_right_6_9),
		.l_bus_i(left_switch_7_19),
		.r_bus_i(right_switch_7_19),
		.l_bus_o(switch_left_7_19),
		.r_bus_o(switch_right_7_19));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(20),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_20(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_10),
		.u_bus_i(switch_left_6_10),
		.l_bus_i(left_switch_7_20),
		.r_bus_i(right_switch_7_20),
		.l_bus_o(switch_left_7_20),
		.r_bus_o(switch_right_7_20));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(21),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_21(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_10),
		.u_bus_i(switch_right_6_10),
		.l_bus_i(left_switch_7_21),
		.r_bus_i(right_switch_7_21),
		.l_bus_o(switch_left_7_21),
		.r_bus_o(switch_right_7_21));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(22),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_22(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_11),
		.u_bus_i(switch_left_6_11),
		.l_bus_i(left_switch_7_22),
		.r_bus_i(right_switch_7_22),
		.l_bus_o(switch_left_7_22),
		.r_bus_o(switch_right_7_22));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(23),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_23(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_11),
		.u_bus_i(switch_right_6_11),
		.l_bus_i(left_switch_7_23),
		.r_bus_i(right_switch_7_23),
		.l_bus_o(switch_left_7_23),
		.r_bus_o(switch_right_7_23));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(24),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_24(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_12),
		.u_bus_i(switch_left_6_12),
		.l_bus_i(left_switch_7_24),
		.r_bus_i(right_switch_7_24),
		.l_bus_o(switch_left_7_24),
		.r_bus_o(switch_right_7_24));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(25),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_25(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_12),
		.u_bus_i(switch_right_6_12),
		.l_bus_i(left_switch_7_25),
		.r_bus_i(right_switch_7_25),
		.l_bus_o(switch_left_7_25),
		.r_bus_o(switch_right_7_25));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(26),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_26(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_13),
		.u_bus_i(switch_left_6_13),
		.l_bus_i(left_switch_7_26),
		.r_bus_i(right_switch_7_26),
		.l_bus_o(switch_left_7_26),
		.r_bus_o(switch_right_7_26));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(27),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_27(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_13),
		.u_bus_i(switch_right_6_13),
		.l_bus_i(left_switch_7_27),
		.r_bus_i(right_switch_7_27),
		.l_bus_o(switch_left_7_27),
		.r_bus_o(switch_right_7_27));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(28),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_28(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_14),
		.u_bus_i(switch_left_6_14),
		.l_bus_i(left_switch_7_28),
		.r_bus_i(right_switch_7_28),
		.l_bus_o(switch_left_7_28),
		.r_bus_o(switch_right_7_28));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(29),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_29(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_14),
		.u_bus_i(switch_right_6_14),
		.l_bus_i(left_switch_7_29),
		.r_bus_i(right_switch_7_29),
		.l_bus_o(switch_left_7_29),
		.r_bus_o(switch_right_7_29));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(30),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_30(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_15),
		.u_bus_i(switch_left_6_15),
		.l_bus_i(left_switch_7_30),
		.r_bus_i(right_switch_7_30),
		.l_bus_o(switch_left_7_30),
		.r_bus_o(switch_right_7_30));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(31),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_31(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_15),
		.u_bus_i(switch_right_6_15),
		.l_bus_i(left_switch_7_31),
		.r_bus_i(right_switch_7_31),
		.l_bus_o(switch_left_7_31),
		.r_bus_o(switch_right_7_31));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(32),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_32(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_16),
		.u_bus_i(switch_left_6_16),
		.l_bus_i(left_switch_7_32),
		.r_bus_i(right_switch_7_32),
		.l_bus_o(switch_left_7_32),
		.r_bus_o(switch_right_7_32));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(33),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_33(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_16),
		.u_bus_i(switch_right_6_16),
		.l_bus_i(left_switch_7_33),
		.r_bus_i(right_switch_7_33),
		.l_bus_o(switch_left_7_33),
		.r_bus_o(switch_right_7_33));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(34),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_34(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_17),
		.u_bus_i(switch_left_6_17),
		.l_bus_i(left_switch_7_34),
		.r_bus_i(right_switch_7_34),
		.l_bus_o(switch_left_7_34),
		.r_bus_o(switch_right_7_34));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(35),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_35(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_17),
		.u_bus_i(switch_right_6_17),
		.l_bus_i(left_switch_7_35),
		.r_bus_i(right_switch_7_35),
		.l_bus_o(switch_left_7_35),
		.r_bus_o(switch_right_7_35));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(36),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_36(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_18),
		.u_bus_i(switch_left_6_18),
		.l_bus_i(left_switch_7_36),
		.r_bus_i(right_switch_7_36),
		.l_bus_o(switch_left_7_36),
		.r_bus_o(switch_right_7_36));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(37),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_37(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_18),
		.u_bus_i(switch_right_6_18),
		.l_bus_i(left_switch_7_37),
		.r_bus_i(right_switch_7_37),
		.l_bus_o(switch_left_7_37),
		.r_bus_o(switch_right_7_37));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(38),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_38(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_19),
		.u_bus_i(switch_left_6_19),
		.l_bus_i(left_switch_7_38),
		.r_bus_i(right_switch_7_38),
		.l_bus_o(switch_left_7_38),
		.r_bus_o(switch_right_7_38));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(39),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_39(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_19),
		.u_bus_i(switch_right_6_19),
		.l_bus_i(left_switch_7_39),
		.r_bus_i(right_switch_7_39),
		.l_bus_o(switch_left_7_39),
		.r_bus_o(switch_right_7_39));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(40),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_40(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_20),
		.u_bus_i(switch_left_6_20),
		.l_bus_i(left_switch_7_40),
		.r_bus_i(right_switch_7_40),
		.l_bus_o(switch_left_7_40),
		.r_bus_o(switch_right_7_40));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(41),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_41(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_20),
		.u_bus_i(switch_right_6_20),
		.l_bus_i(left_switch_7_41),
		.r_bus_i(right_switch_7_41),
		.l_bus_o(switch_left_7_41),
		.r_bus_o(switch_right_7_41));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(42),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_42(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_21),
		.u_bus_i(switch_left_6_21),
		.l_bus_i(left_switch_7_42),
		.r_bus_i(right_switch_7_42),
		.l_bus_o(switch_left_7_42),
		.r_bus_o(switch_right_7_42));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(43),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_43(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_21),
		.u_bus_i(switch_right_6_21),
		.l_bus_i(left_switch_7_43),
		.r_bus_i(right_switch_7_43),
		.l_bus_o(switch_left_7_43),
		.r_bus_o(switch_right_7_43));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(44),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_44(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_22),
		.u_bus_i(switch_left_6_22),
		.l_bus_i(left_switch_7_44),
		.r_bus_i(right_switch_7_44),
		.l_bus_o(switch_left_7_44),
		.r_bus_o(switch_right_7_44));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(45),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_45(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_22),
		.u_bus_i(switch_right_6_22),
		.l_bus_i(left_switch_7_45),
		.r_bus_i(right_switch_7_45),
		.l_bus_o(switch_left_7_45),
		.r_bus_o(switch_right_7_45));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(46),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_46(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_23),
		.u_bus_i(switch_left_6_23),
		.l_bus_i(left_switch_7_46),
		.r_bus_i(right_switch_7_46),
		.l_bus_o(switch_left_7_46),
		.r_bus_o(switch_right_7_46));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(47),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_47(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_23),
		.u_bus_i(switch_right_6_23),
		.l_bus_i(left_switch_7_47),
		.r_bus_i(right_switch_7_47),
		.l_bus_o(switch_left_7_47),
		.r_bus_o(switch_right_7_47));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(48),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_48(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_24),
		.u_bus_i(switch_left_6_24),
		.l_bus_i(left_switch_7_48),
		.r_bus_i(right_switch_7_48),
		.l_bus_o(switch_left_7_48),
		.r_bus_o(switch_right_7_48));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(49),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_49(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_24),
		.u_bus_i(switch_right_6_24),
		.l_bus_i(left_switch_7_49),
		.r_bus_i(right_switch_7_49),
		.l_bus_o(switch_left_7_49),
		.r_bus_o(switch_right_7_49));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(50),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_50(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_25),
		.u_bus_i(switch_left_6_25),
		.l_bus_i(left_switch_7_50),
		.r_bus_i(right_switch_7_50),
		.l_bus_o(switch_left_7_50),
		.r_bus_o(switch_right_7_50));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(51),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_51(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_25),
		.u_bus_i(switch_right_6_25),
		.l_bus_i(left_switch_7_51),
		.r_bus_i(right_switch_7_51),
		.l_bus_o(switch_left_7_51),
		.r_bus_o(switch_right_7_51));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(52),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_52(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_26),
		.u_bus_i(switch_left_6_26),
		.l_bus_i(left_switch_7_52),
		.r_bus_i(right_switch_7_52),
		.l_bus_o(switch_left_7_52),
		.r_bus_o(switch_right_7_52));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(53),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_53(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_26),
		.u_bus_i(switch_right_6_26),
		.l_bus_i(left_switch_7_53),
		.r_bus_i(right_switch_7_53),
		.l_bus_o(switch_left_7_53),
		.r_bus_o(switch_right_7_53));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(54),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_54(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_27),
		.u_bus_i(switch_left_6_27),
		.l_bus_i(left_switch_7_54),
		.r_bus_i(right_switch_7_54),
		.l_bus_o(switch_left_7_54),
		.r_bus_o(switch_right_7_54));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(55),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_55(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_27),
		.u_bus_i(switch_right_6_27),
		.l_bus_i(left_switch_7_55),
		.r_bus_i(right_switch_7_55),
		.l_bus_o(switch_left_7_55),
		.r_bus_o(switch_right_7_55));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(56),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_56(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_28),
		.u_bus_i(switch_left_6_28),
		.l_bus_i(left_switch_7_56),
		.r_bus_i(right_switch_7_56),
		.l_bus_o(switch_left_7_56),
		.r_bus_o(switch_right_7_56));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(57),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_57(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_28),
		.u_bus_i(switch_right_6_28),
		.l_bus_i(left_switch_7_57),
		.r_bus_i(right_switch_7_57),
		.l_bus_o(switch_left_7_57),
		.r_bus_o(switch_right_7_57));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(58),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_58(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_29),
		.u_bus_i(switch_left_6_29),
		.l_bus_i(left_switch_7_58),
		.r_bus_i(right_switch_7_58),
		.l_bus_o(switch_left_7_58),
		.r_bus_o(switch_right_7_58));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(59),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_59(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_29),
		.u_bus_i(switch_right_6_29),
		.l_bus_i(left_switch_7_59),
		.r_bus_i(right_switch_7_59),
		.l_bus_o(switch_left_7_59),
		.r_bus_o(switch_right_7_59));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(60),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_60(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_30),
		.u_bus_i(switch_left_6_30),
		.l_bus_i(left_switch_7_60),
		.r_bus_i(right_switch_7_60),
		.l_bus_o(switch_left_7_60),
		.r_bus_o(switch_right_7_60));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(61),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_61(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_30),
		.u_bus_i(switch_right_6_30),
		.l_bus_i(left_switch_7_61),
		.r_bus_i(right_switch_7_61),
		.l_bus_o(switch_left_7_61),
		.r_bus_o(switch_right_7_61));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(62),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_62(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_31),
		.u_bus_i(switch_left_6_31),
		.l_bus_i(left_switch_7_62),
		.r_bus_i(right_switch_7_62),
		.l_bus_o(switch_left_7_62),
		.r_bus_o(switch_right_7_62));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(63),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_63(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_31),
		.u_bus_i(switch_right_6_31),
		.l_bus_i(left_switch_7_63),
		.r_bus_i(right_switch_7_63),
		.l_bus_o(switch_left_7_63),
		.r_bus_o(switch_right_7_63));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(64),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_64(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_32),
		.u_bus_i(switch_left_6_32),
		.l_bus_i(left_switch_7_64),
		.r_bus_i(right_switch_7_64),
		.l_bus_o(switch_left_7_64),
		.r_bus_o(switch_right_7_64));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(65),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_65(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_32),
		.u_bus_i(switch_right_6_32),
		.l_bus_i(left_switch_7_65),
		.r_bus_i(right_switch_7_65),
		.l_bus_o(switch_left_7_65),
		.r_bus_o(switch_right_7_65));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(66),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_66(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_33),
		.u_bus_i(switch_left_6_33),
		.l_bus_i(left_switch_7_66),
		.r_bus_i(right_switch_7_66),
		.l_bus_o(switch_left_7_66),
		.r_bus_o(switch_right_7_66));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(67),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_67(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_33),
		.u_bus_i(switch_right_6_33),
		.l_bus_i(left_switch_7_67),
		.r_bus_i(right_switch_7_67),
		.l_bus_o(switch_left_7_67),
		.r_bus_o(switch_right_7_67));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(68),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_68(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_34),
		.u_bus_i(switch_left_6_34),
		.l_bus_i(left_switch_7_68),
		.r_bus_i(right_switch_7_68),
		.l_bus_o(switch_left_7_68),
		.r_bus_o(switch_right_7_68));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(69),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_69(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_34),
		.u_bus_i(switch_right_6_34),
		.l_bus_i(left_switch_7_69),
		.r_bus_i(right_switch_7_69),
		.l_bus_o(switch_left_7_69),
		.r_bus_o(switch_right_7_69));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(70),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_70(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_35),
		.u_bus_i(switch_left_6_35),
		.l_bus_i(left_switch_7_70),
		.r_bus_i(right_switch_7_70),
		.l_bus_o(switch_left_7_70),
		.r_bus_o(switch_right_7_70));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(71),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_71(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_35),
		.u_bus_i(switch_right_6_35),
		.l_bus_i(left_switch_7_71),
		.r_bus_i(right_switch_7_71),
		.l_bus_o(switch_left_7_71),
		.r_bus_o(switch_right_7_71));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(72),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_72(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_36),
		.u_bus_i(switch_left_6_36),
		.l_bus_i(left_switch_7_72),
		.r_bus_i(right_switch_7_72),
		.l_bus_o(switch_left_7_72),
		.r_bus_o(switch_right_7_72));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(73),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_73(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_36),
		.u_bus_i(switch_right_6_36),
		.l_bus_i(left_switch_7_73),
		.r_bus_i(right_switch_7_73),
		.l_bus_o(switch_left_7_73),
		.r_bus_o(switch_right_7_73));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(74),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_74(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_37),
		.u_bus_i(switch_left_6_37),
		.l_bus_i(left_switch_7_74),
		.r_bus_i(right_switch_7_74),
		.l_bus_o(switch_left_7_74),
		.r_bus_o(switch_right_7_74));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(75),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_75(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_37),
		.u_bus_i(switch_right_6_37),
		.l_bus_i(left_switch_7_75),
		.r_bus_i(right_switch_7_75),
		.l_bus_o(switch_left_7_75),
		.r_bus_o(switch_right_7_75));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(76),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_76(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_38),
		.u_bus_i(switch_left_6_38),
		.l_bus_i(left_switch_7_76),
		.r_bus_i(right_switch_7_76),
		.l_bus_o(switch_left_7_76),
		.r_bus_o(switch_right_7_76));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(77),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_77(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_38),
		.u_bus_i(switch_right_6_38),
		.l_bus_i(left_switch_7_77),
		.r_bus_i(right_switch_7_77),
		.l_bus_o(switch_left_7_77),
		.r_bus_o(switch_right_7_77));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(78),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_78(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_39),
		.u_bus_i(switch_left_6_39),
		.l_bus_i(left_switch_7_78),
		.r_bus_i(right_switch_7_78),
		.l_bus_o(switch_left_7_78),
		.r_bus_o(switch_right_7_78));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(79),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_79(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_39),
		.u_bus_i(switch_right_6_39),
		.l_bus_i(left_switch_7_79),
		.r_bus_i(right_switch_7_79),
		.l_bus_o(switch_left_7_79),
		.r_bus_o(switch_right_7_79));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(80),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_80(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_40),
		.u_bus_i(switch_left_6_40),
		.l_bus_i(left_switch_7_80),
		.r_bus_i(right_switch_7_80),
		.l_bus_o(switch_left_7_80),
		.r_bus_o(switch_right_7_80));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(81),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_81(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_40),
		.u_bus_i(switch_right_6_40),
		.l_bus_i(left_switch_7_81),
		.r_bus_i(right_switch_7_81),
		.l_bus_o(switch_left_7_81),
		.r_bus_o(switch_right_7_81));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(82),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_82(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_41),
		.u_bus_i(switch_left_6_41),
		.l_bus_i(left_switch_7_82),
		.r_bus_i(right_switch_7_82),
		.l_bus_o(switch_left_7_82),
		.r_bus_o(switch_right_7_82));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(83),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_83(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_41),
		.u_bus_i(switch_right_6_41),
		.l_bus_i(left_switch_7_83),
		.r_bus_i(right_switch_7_83),
		.l_bus_o(switch_left_7_83),
		.r_bus_o(switch_right_7_83));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(84),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_84(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_42),
		.u_bus_i(switch_left_6_42),
		.l_bus_i(left_switch_7_84),
		.r_bus_i(right_switch_7_84),
		.l_bus_o(switch_left_7_84),
		.r_bus_o(switch_right_7_84));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(85),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_85(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_42),
		.u_bus_i(switch_right_6_42),
		.l_bus_i(left_switch_7_85),
		.r_bus_i(right_switch_7_85),
		.l_bus_o(switch_left_7_85),
		.r_bus_o(switch_right_7_85));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(86),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_86(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_43),
		.u_bus_i(switch_left_6_43),
		.l_bus_i(left_switch_7_86),
		.r_bus_i(right_switch_7_86),
		.l_bus_o(switch_left_7_86),
		.r_bus_o(switch_right_7_86));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(87),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_87(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_43),
		.u_bus_i(switch_right_6_43),
		.l_bus_i(left_switch_7_87),
		.r_bus_i(right_switch_7_87),
		.l_bus_o(switch_left_7_87),
		.r_bus_o(switch_right_7_87));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(88),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_88(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_44),
		.u_bus_i(switch_left_6_44),
		.l_bus_i(left_switch_7_88),
		.r_bus_i(right_switch_7_88),
		.l_bus_o(switch_left_7_88),
		.r_bus_o(switch_right_7_88));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(89),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_89(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_44),
		.u_bus_i(switch_right_6_44),
		.l_bus_i(left_switch_7_89),
		.r_bus_i(right_switch_7_89),
		.l_bus_o(switch_left_7_89),
		.r_bus_o(switch_right_7_89));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(90),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_90(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_45),
		.u_bus_i(switch_left_6_45),
		.l_bus_i(left_switch_7_90),
		.r_bus_i(right_switch_7_90),
		.l_bus_o(switch_left_7_90),
		.r_bus_o(switch_right_7_90));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(91),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_91(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_45),
		.u_bus_i(switch_right_6_45),
		.l_bus_i(left_switch_7_91),
		.r_bus_i(right_switch_7_91),
		.l_bus_o(switch_left_7_91),
		.r_bus_o(switch_right_7_91));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(92),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_92(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_46),
		.u_bus_i(switch_left_6_46),
		.l_bus_i(left_switch_7_92),
		.r_bus_i(right_switch_7_92),
		.l_bus_o(switch_left_7_92),
		.r_bus_o(switch_right_7_92));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(93),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_93(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_46),
		.u_bus_i(switch_right_6_46),
		.l_bus_i(left_switch_7_93),
		.r_bus_i(right_switch_7_93),
		.l_bus_o(switch_left_7_93),
		.r_bus_o(switch_right_7_93));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(94),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_94(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_47),
		.u_bus_i(switch_left_6_47),
		.l_bus_i(left_switch_7_94),
		.r_bus_i(right_switch_7_94),
		.l_bus_o(switch_left_7_94),
		.r_bus_o(switch_right_7_94));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(95),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_95(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_47),
		.u_bus_i(switch_right_6_47),
		.l_bus_i(left_switch_7_95),
		.r_bus_i(right_switch_7_95),
		.l_bus_o(switch_left_7_95),
		.r_bus_o(switch_right_7_95));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(96),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_96(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_48),
		.u_bus_i(switch_left_6_48),
		.l_bus_i(left_switch_7_96),
		.r_bus_i(right_switch_7_96),
		.l_bus_o(switch_left_7_96),
		.r_bus_o(switch_right_7_96));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(97),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_97(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_48),
		.u_bus_i(switch_right_6_48),
		.l_bus_i(left_switch_7_97),
		.r_bus_i(right_switch_7_97),
		.l_bus_o(switch_left_7_97),
		.r_bus_o(switch_right_7_97));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(98),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_98(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_49),
		.u_bus_i(switch_left_6_49),
		.l_bus_i(left_switch_7_98),
		.r_bus_i(right_switch_7_98),
		.l_bus_o(switch_left_7_98),
		.r_bus_o(switch_right_7_98));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(99),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_99(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_49),
		.u_bus_i(switch_right_6_49),
		.l_bus_i(left_switch_7_99),
		.r_bus_i(right_switch_7_99),
		.l_bus_o(switch_left_7_99),
		.r_bus_o(switch_right_7_99));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(100),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_100(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_50),
		.u_bus_i(switch_left_6_50),
		.l_bus_i(left_switch_7_100),
		.r_bus_i(right_switch_7_100),
		.l_bus_o(switch_left_7_100),
		.r_bus_o(switch_right_7_100));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(101),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_101(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_50),
		.u_bus_i(switch_right_6_50),
		.l_bus_i(left_switch_7_101),
		.r_bus_i(right_switch_7_101),
		.l_bus_o(switch_left_7_101),
		.r_bus_o(switch_right_7_101));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(102),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_102(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_51),
		.u_bus_i(switch_left_6_51),
		.l_bus_i(left_switch_7_102),
		.r_bus_i(right_switch_7_102),
		.l_bus_o(switch_left_7_102),
		.r_bus_o(switch_right_7_102));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(103),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_103(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_51),
		.u_bus_i(switch_right_6_51),
		.l_bus_i(left_switch_7_103),
		.r_bus_i(right_switch_7_103),
		.l_bus_o(switch_left_7_103),
		.r_bus_o(switch_right_7_103));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(104),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_104(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_52),
		.u_bus_i(switch_left_6_52),
		.l_bus_i(left_switch_7_104),
		.r_bus_i(right_switch_7_104),
		.l_bus_o(switch_left_7_104),
		.r_bus_o(switch_right_7_104));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(105),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_105(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_52),
		.u_bus_i(switch_right_6_52),
		.l_bus_i(left_switch_7_105),
		.r_bus_i(right_switch_7_105),
		.l_bus_o(switch_left_7_105),
		.r_bus_o(switch_right_7_105));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(106),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_106(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_53),
		.u_bus_i(switch_left_6_53),
		.l_bus_i(left_switch_7_106),
		.r_bus_i(right_switch_7_106),
		.l_bus_o(switch_left_7_106),
		.r_bus_o(switch_right_7_106));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(107),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_107(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_53),
		.u_bus_i(switch_right_6_53),
		.l_bus_i(left_switch_7_107),
		.r_bus_i(right_switch_7_107),
		.l_bus_o(switch_left_7_107),
		.r_bus_o(switch_right_7_107));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(108),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_108(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_54),
		.u_bus_i(switch_left_6_54),
		.l_bus_i(left_switch_7_108),
		.r_bus_i(right_switch_7_108),
		.l_bus_o(switch_left_7_108),
		.r_bus_o(switch_right_7_108));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(109),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_109(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_54),
		.u_bus_i(switch_right_6_54),
		.l_bus_i(left_switch_7_109),
		.r_bus_i(right_switch_7_109),
		.l_bus_o(switch_left_7_109),
		.r_bus_o(switch_right_7_109));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(110),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_110(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_55),
		.u_bus_i(switch_left_6_55),
		.l_bus_i(left_switch_7_110),
		.r_bus_i(right_switch_7_110),
		.l_bus_o(switch_left_7_110),
		.r_bus_o(switch_right_7_110));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(111),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_111(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_55),
		.u_bus_i(switch_right_6_55),
		.l_bus_i(left_switch_7_111),
		.r_bus_i(right_switch_7_111),
		.l_bus_o(switch_left_7_111),
		.r_bus_o(switch_right_7_111));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(112),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_112(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_56),
		.u_bus_i(switch_left_6_56),
		.l_bus_i(left_switch_7_112),
		.r_bus_i(right_switch_7_112),
		.l_bus_o(switch_left_7_112),
		.r_bus_o(switch_right_7_112));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(113),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_113(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_56),
		.u_bus_i(switch_right_6_56),
		.l_bus_i(left_switch_7_113),
		.r_bus_i(right_switch_7_113),
		.l_bus_o(switch_left_7_113),
		.r_bus_o(switch_right_7_113));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(114),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_114(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_57),
		.u_bus_i(switch_left_6_57),
		.l_bus_i(left_switch_7_114),
		.r_bus_i(right_switch_7_114),
		.l_bus_o(switch_left_7_114),
		.r_bus_o(switch_right_7_114));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(115),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_115(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_57),
		.u_bus_i(switch_right_6_57),
		.l_bus_i(left_switch_7_115),
		.r_bus_i(right_switch_7_115),
		.l_bus_o(switch_left_7_115),
		.r_bus_o(switch_right_7_115));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(116),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_116(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_58),
		.u_bus_i(switch_left_6_58),
		.l_bus_i(left_switch_7_116),
		.r_bus_i(right_switch_7_116),
		.l_bus_o(switch_left_7_116),
		.r_bus_o(switch_right_7_116));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(117),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_117(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_58),
		.u_bus_i(switch_right_6_58),
		.l_bus_i(left_switch_7_117),
		.r_bus_i(right_switch_7_117),
		.l_bus_o(switch_left_7_117),
		.r_bus_o(switch_right_7_117));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(118),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_118(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_59),
		.u_bus_i(switch_left_6_59),
		.l_bus_i(left_switch_7_118),
		.r_bus_i(right_switch_7_118),
		.l_bus_o(switch_left_7_118),
		.r_bus_o(switch_right_7_118));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(119),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_119(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_59),
		.u_bus_i(switch_right_6_59),
		.l_bus_i(left_switch_7_119),
		.r_bus_i(right_switch_7_119),
		.l_bus_o(switch_left_7_119),
		.r_bus_o(switch_right_7_119));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(120),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_120(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_60),
		.u_bus_i(switch_left_6_60),
		.l_bus_i(left_switch_7_120),
		.r_bus_i(right_switch_7_120),
		.l_bus_o(switch_left_7_120),
		.r_bus_o(switch_right_7_120));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(121),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_121(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_60),
		.u_bus_i(switch_right_6_60),
		.l_bus_i(left_switch_7_121),
		.r_bus_i(right_switch_7_121),
		.l_bus_o(switch_left_7_121),
		.r_bus_o(switch_right_7_121));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(122),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_122(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_61),
		.u_bus_i(switch_left_6_61),
		.l_bus_i(left_switch_7_122),
		.r_bus_i(right_switch_7_122),
		.l_bus_o(switch_left_7_122),
		.r_bus_o(switch_right_7_122));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(123),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_123(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_61),
		.u_bus_i(switch_right_6_61),
		.l_bus_i(left_switch_7_123),
		.r_bus_i(right_switch_7_123),
		.l_bus_o(switch_left_7_123),
		.r_bus_o(switch_right_7_123));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(124),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_124(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_62),
		.u_bus_i(switch_left_6_62),
		.l_bus_i(left_switch_7_124),
		.r_bus_i(right_switch_7_124),
		.l_bus_o(switch_left_7_124),
		.r_bus_o(switch_right_7_124));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(125),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_125(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_62),
		.u_bus_i(switch_right_6_62),
		.l_bus_i(left_switch_7_125),
		.r_bus_i(right_switch_7_125),
		.l_bus_o(switch_left_7_125),
		.r_bus_o(switch_right_7_125));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(126),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_126(
		.clk(clk),
		.reset(reset),
		.u_bus_o(left_switch_6_63),
		.u_bus_i(switch_left_6_63),
		.l_bus_i(left_switch_7_126),
		.r_bus_i(right_switch_7_126),
		.l_bus_o(switch_left_7_126),
		.r_bus_o(switch_right_7_126));

	pi_cluster #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(127),
		.level(7),
		.p_sz(p_sz),
		.num_switches(1)
		)pi_lvl_7_127(
		.clk(clk),
		.reset(reset),
		.u_bus_o(right_switch_6_63),
		.u_bus_i(switch_right_6_63),
		.l_bus_i(left_switch_7_127),
		.r_bus_i(right_switch_7_127),
		.l_bus_o(switch_left_7_127),
		.r_bus_o(switch_right_7_127));


//--------level=8--------------
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(0),
		.p_sz(p_sz)
		)interface_0(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_0),
		.bus_o(left_switch_7_0),
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
		.bus_i(switch_right_7_0),
		.bus_o(right_switch_7_0),
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
		.bus_i(switch_left_7_1),
		.bus_o(left_switch_7_1),
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
		.bus_i(switch_right_7_1),
		.bus_o(right_switch_7_1),
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
		.bus_i(switch_left_7_2),
		.bus_o(left_switch_7_2),
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
		.bus_i(switch_right_7_2),
		.bus_o(right_switch_7_2),
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
		.bus_i(switch_left_7_3),
		.bus_o(left_switch_7_3),
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
		.bus_i(switch_right_7_3),
		.bus_o(right_switch_7_3),
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
		.bus_i(switch_left_7_4),
		.bus_o(left_switch_7_4),
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
		.bus_i(switch_right_7_4),
		.bus_o(right_switch_7_4),
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
		.bus_i(switch_left_7_5),
		.bus_o(left_switch_7_5),
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
		.bus_i(switch_right_7_5),
		.bus_o(right_switch_7_5),
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
		.bus_i(switch_left_7_6),
		.bus_o(left_switch_7_6),
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
		.bus_i(switch_right_7_6),
		.bus_o(right_switch_7_6),
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
		.bus_i(switch_left_7_7),
		.bus_o(left_switch_7_7),
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
		.bus_i(switch_right_7_7),
		.bus_o(right_switch_7_7),
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
		.bus_i(switch_left_7_8),
		.bus_o(left_switch_7_8),
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
		.bus_i(switch_right_7_8),
		.bus_o(right_switch_7_8),
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
		.bus_i(switch_left_7_9),
		.bus_o(left_switch_7_9),
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
		.bus_i(switch_right_7_9),
		.bus_o(right_switch_7_9),
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
		.bus_i(switch_left_7_10),
		.bus_o(left_switch_7_10),
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
		.bus_i(switch_right_7_10),
		.bus_o(right_switch_7_10),
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
		.bus_i(switch_left_7_11),
		.bus_o(left_switch_7_11),
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
		.bus_i(switch_right_7_11),
		.bus_o(right_switch_7_11),
		.pe_interface(pe_interface[p_sz*24-1:p_sz*23]),
		.interface_pe(interface_pe[p_sz*24-1:p_sz*23]),
		.resend(resend[23]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(24),
		.p_sz(p_sz)
		)interface_24(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_12),
		.bus_o(left_switch_7_12),
		.pe_interface(pe_interface[p_sz*25-1:p_sz*24]),
		.interface_pe(interface_pe[p_sz*25-1:p_sz*24]),
		.resend(resend[24]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(25),
		.p_sz(p_sz)
		)interface_25(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_12),
		.bus_o(right_switch_7_12),
		.pe_interface(pe_interface[p_sz*26-1:p_sz*25]),
		.interface_pe(interface_pe[p_sz*26-1:p_sz*25]),
		.resend(resend[25]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(26),
		.p_sz(p_sz)
		)interface_26(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_13),
		.bus_o(left_switch_7_13),
		.pe_interface(pe_interface[p_sz*27-1:p_sz*26]),
		.interface_pe(interface_pe[p_sz*27-1:p_sz*26]),
		.resend(resend[26]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(27),
		.p_sz(p_sz)
		)interface_27(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_13),
		.bus_o(right_switch_7_13),
		.pe_interface(pe_interface[p_sz*28-1:p_sz*27]),
		.interface_pe(interface_pe[p_sz*28-1:p_sz*27]),
		.resend(resend[27]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(28),
		.p_sz(p_sz)
		)interface_28(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_14),
		.bus_o(left_switch_7_14),
		.pe_interface(pe_interface[p_sz*29-1:p_sz*28]),
		.interface_pe(interface_pe[p_sz*29-1:p_sz*28]),
		.resend(resend[28]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(29),
		.p_sz(p_sz)
		)interface_29(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_14),
		.bus_o(right_switch_7_14),
		.pe_interface(pe_interface[p_sz*30-1:p_sz*29]),
		.interface_pe(interface_pe[p_sz*30-1:p_sz*29]),
		.resend(resend[29]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(30),
		.p_sz(p_sz)
		)interface_30(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_15),
		.bus_o(left_switch_7_15),
		.pe_interface(pe_interface[p_sz*31-1:p_sz*30]),
		.interface_pe(interface_pe[p_sz*31-1:p_sz*30]),
		.resend(resend[30]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(31),
		.p_sz(p_sz)
		)interface_31(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_15),
		.bus_o(right_switch_7_15),
		.pe_interface(pe_interface[p_sz*32-1:p_sz*31]),
		.interface_pe(interface_pe[p_sz*32-1:p_sz*31]),
		.resend(resend[31]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(32),
		.p_sz(p_sz)
		)interface_32(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_16),
		.bus_o(left_switch_7_16),
		.pe_interface(pe_interface[p_sz*33-1:p_sz*32]),
		.interface_pe(interface_pe[p_sz*33-1:p_sz*32]),
		.resend(resend[32]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(33),
		.p_sz(p_sz)
		)interface_33(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_16),
		.bus_o(right_switch_7_16),
		.pe_interface(pe_interface[p_sz*34-1:p_sz*33]),
		.interface_pe(interface_pe[p_sz*34-1:p_sz*33]),
		.resend(resend[33]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(34),
		.p_sz(p_sz)
		)interface_34(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_17),
		.bus_o(left_switch_7_17),
		.pe_interface(pe_interface[p_sz*35-1:p_sz*34]),
		.interface_pe(interface_pe[p_sz*35-1:p_sz*34]),
		.resend(resend[34]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(35),
		.p_sz(p_sz)
		)interface_35(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_17),
		.bus_o(right_switch_7_17),
		.pe_interface(pe_interface[p_sz*36-1:p_sz*35]),
		.interface_pe(interface_pe[p_sz*36-1:p_sz*35]),
		.resend(resend[35]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(36),
		.p_sz(p_sz)
		)interface_36(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_18),
		.bus_o(left_switch_7_18),
		.pe_interface(pe_interface[p_sz*37-1:p_sz*36]),
		.interface_pe(interface_pe[p_sz*37-1:p_sz*36]),
		.resend(resend[36]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(37),
		.p_sz(p_sz)
		)interface_37(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_18),
		.bus_o(right_switch_7_18),
		.pe_interface(pe_interface[p_sz*38-1:p_sz*37]),
		.interface_pe(interface_pe[p_sz*38-1:p_sz*37]),
		.resend(resend[37]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(38),
		.p_sz(p_sz)
		)interface_38(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_19),
		.bus_o(left_switch_7_19),
		.pe_interface(pe_interface[p_sz*39-1:p_sz*38]),
		.interface_pe(interface_pe[p_sz*39-1:p_sz*38]),
		.resend(resend[38]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(39),
		.p_sz(p_sz)
		)interface_39(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_19),
		.bus_o(right_switch_7_19),
		.pe_interface(pe_interface[p_sz*40-1:p_sz*39]),
		.interface_pe(interface_pe[p_sz*40-1:p_sz*39]),
		.resend(resend[39]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(40),
		.p_sz(p_sz)
		)interface_40(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_20),
		.bus_o(left_switch_7_20),
		.pe_interface(pe_interface[p_sz*41-1:p_sz*40]),
		.interface_pe(interface_pe[p_sz*41-1:p_sz*40]),
		.resend(resend[40]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(41),
		.p_sz(p_sz)
		)interface_41(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_20),
		.bus_o(right_switch_7_20),
		.pe_interface(pe_interface[p_sz*42-1:p_sz*41]),
		.interface_pe(interface_pe[p_sz*42-1:p_sz*41]),
		.resend(resend[41]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(42),
		.p_sz(p_sz)
		)interface_42(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_21),
		.bus_o(left_switch_7_21),
		.pe_interface(pe_interface[p_sz*43-1:p_sz*42]),
		.interface_pe(interface_pe[p_sz*43-1:p_sz*42]),
		.resend(resend[42]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(43),
		.p_sz(p_sz)
		)interface_43(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_21),
		.bus_o(right_switch_7_21),
		.pe_interface(pe_interface[p_sz*44-1:p_sz*43]),
		.interface_pe(interface_pe[p_sz*44-1:p_sz*43]),
		.resend(resend[43]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(44),
		.p_sz(p_sz)
		)interface_44(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_22),
		.bus_o(left_switch_7_22),
		.pe_interface(pe_interface[p_sz*45-1:p_sz*44]),
		.interface_pe(interface_pe[p_sz*45-1:p_sz*44]),
		.resend(resend[44]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(45),
		.p_sz(p_sz)
		)interface_45(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_22),
		.bus_o(right_switch_7_22),
		.pe_interface(pe_interface[p_sz*46-1:p_sz*45]),
		.interface_pe(interface_pe[p_sz*46-1:p_sz*45]),
		.resend(resend[45]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(46),
		.p_sz(p_sz)
		)interface_46(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_23),
		.bus_o(left_switch_7_23),
		.pe_interface(pe_interface[p_sz*47-1:p_sz*46]),
		.interface_pe(interface_pe[p_sz*47-1:p_sz*46]),
		.resend(resend[46]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(47),
		.p_sz(p_sz)
		)interface_47(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_23),
		.bus_o(right_switch_7_23),
		.pe_interface(pe_interface[p_sz*48-1:p_sz*47]),
		.interface_pe(interface_pe[p_sz*48-1:p_sz*47]),
		.resend(resend[47]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(48),
		.p_sz(p_sz)
		)interface_48(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_24),
		.bus_o(left_switch_7_24),
		.pe_interface(pe_interface[p_sz*49-1:p_sz*48]),
		.interface_pe(interface_pe[p_sz*49-1:p_sz*48]),
		.resend(resend[48]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(49),
		.p_sz(p_sz)
		)interface_49(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_24),
		.bus_o(right_switch_7_24),
		.pe_interface(pe_interface[p_sz*50-1:p_sz*49]),
		.interface_pe(interface_pe[p_sz*50-1:p_sz*49]),
		.resend(resend[49]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(50),
		.p_sz(p_sz)
		)interface_50(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_25),
		.bus_o(left_switch_7_25),
		.pe_interface(pe_interface[p_sz*51-1:p_sz*50]),
		.interface_pe(interface_pe[p_sz*51-1:p_sz*50]),
		.resend(resend[50]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(51),
		.p_sz(p_sz)
		)interface_51(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_25),
		.bus_o(right_switch_7_25),
		.pe_interface(pe_interface[p_sz*52-1:p_sz*51]),
		.interface_pe(interface_pe[p_sz*52-1:p_sz*51]),
		.resend(resend[51]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(52),
		.p_sz(p_sz)
		)interface_52(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_26),
		.bus_o(left_switch_7_26),
		.pe_interface(pe_interface[p_sz*53-1:p_sz*52]),
		.interface_pe(interface_pe[p_sz*53-1:p_sz*52]),
		.resend(resend[52]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(53),
		.p_sz(p_sz)
		)interface_53(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_26),
		.bus_o(right_switch_7_26),
		.pe_interface(pe_interface[p_sz*54-1:p_sz*53]),
		.interface_pe(interface_pe[p_sz*54-1:p_sz*53]),
		.resend(resend[53]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(54),
		.p_sz(p_sz)
		)interface_54(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_27),
		.bus_o(left_switch_7_27),
		.pe_interface(pe_interface[p_sz*55-1:p_sz*54]),
		.interface_pe(interface_pe[p_sz*55-1:p_sz*54]),
		.resend(resend[54]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(55),
		.p_sz(p_sz)
		)interface_55(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_27),
		.bus_o(right_switch_7_27),
		.pe_interface(pe_interface[p_sz*56-1:p_sz*55]),
		.interface_pe(interface_pe[p_sz*56-1:p_sz*55]),
		.resend(resend[55]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(56),
		.p_sz(p_sz)
		)interface_56(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_28),
		.bus_o(left_switch_7_28),
		.pe_interface(pe_interface[p_sz*57-1:p_sz*56]),
		.interface_pe(interface_pe[p_sz*57-1:p_sz*56]),
		.resend(resend[56]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(57),
		.p_sz(p_sz)
		)interface_57(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_28),
		.bus_o(right_switch_7_28),
		.pe_interface(pe_interface[p_sz*58-1:p_sz*57]),
		.interface_pe(interface_pe[p_sz*58-1:p_sz*57]),
		.resend(resend[57]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(58),
		.p_sz(p_sz)
		)interface_58(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_29),
		.bus_o(left_switch_7_29),
		.pe_interface(pe_interface[p_sz*59-1:p_sz*58]),
		.interface_pe(interface_pe[p_sz*59-1:p_sz*58]),
		.resend(resend[58]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(59),
		.p_sz(p_sz)
		)interface_59(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_29),
		.bus_o(right_switch_7_29),
		.pe_interface(pe_interface[p_sz*60-1:p_sz*59]),
		.interface_pe(interface_pe[p_sz*60-1:p_sz*59]),
		.resend(resend[59]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(60),
		.p_sz(p_sz)
		)interface_60(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_30),
		.bus_o(left_switch_7_30),
		.pe_interface(pe_interface[p_sz*61-1:p_sz*60]),
		.interface_pe(interface_pe[p_sz*61-1:p_sz*60]),
		.resend(resend[60]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(61),
		.p_sz(p_sz)
		)interface_61(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_30),
		.bus_o(right_switch_7_30),
		.pe_interface(pe_interface[p_sz*62-1:p_sz*61]),
		.interface_pe(interface_pe[p_sz*62-1:p_sz*61]),
		.resend(resend[61]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(62),
		.p_sz(p_sz)
		)interface_62(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_31),
		.bus_o(left_switch_7_31),
		.pe_interface(pe_interface[p_sz*63-1:p_sz*62]),
		.interface_pe(interface_pe[p_sz*63-1:p_sz*62]),
		.resend(resend[62]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(63),
		.p_sz(p_sz)
		)interface_63(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_31),
		.bus_o(right_switch_7_31),
		.pe_interface(pe_interface[p_sz*64-1:p_sz*63]),
		.interface_pe(interface_pe[p_sz*64-1:p_sz*63]),
		.resend(resend[63]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(64),
		.p_sz(p_sz)
		)interface_64(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_32),
		.bus_o(left_switch_7_32),
		.pe_interface(pe_interface[p_sz*65-1:p_sz*64]),
		.interface_pe(interface_pe[p_sz*65-1:p_sz*64]),
		.resend(resend[64]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(65),
		.p_sz(p_sz)
		)interface_65(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_32),
		.bus_o(right_switch_7_32),
		.pe_interface(pe_interface[p_sz*66-1:p_sz*65]),
		.interface_pe(interface_pe[p_sz*66-1:p_sz*65]),
		.resend(resend[65]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(66),
		.p_sz(p_sz)
		)interface_66(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_33),
		.bus_o(left_switch_7_33),
		.pe_interface(pe_interface[p_sz*67-1:p_sz*66]),
		.interface_pe(interface_pe[p_sz*67-1:p_sz*66]),
		.resend(resend[66]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(67),
		.p_sz(p_sz)
		)interface_67(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_33),
		.bus_o(right_switch_7_33),
		.pe_interface(pe_interface[p_sz*68-1:p_sz*67]),
		.interface_pe(interface_pe[p_sz*68-1:p_sz*67]),
		.resend(resend[67]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(68),
		.p_sz(p_sz)
		)interface_68(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_34),
		.bus_o(left_switch_7_34),
		.pe_interface(pe_interface[p_sz*69-1:p_sz*68]),
		.interface_pe(interface_pe[p_sz*69-1:p_sz*68]),
		.resend(resend[68]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(69),
		.p_sz(p_sz)
		)interface_69(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_34),
		.bus_o(right_switch_7_34),
		.pe_interface(pe_interface[p_sz*70-1:p_sz*69]),
		.interface_pe(interface_pe[p_sz*70-1:p_sz*69]),
		.resend(resend[69]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(70),
		.p_sz(p_sz)
		)interface_70(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_35),
		.bus_o(left_switch_7_35),
		.pe_interface(pe_interface[p_sz*71-1:p_sz*70]),
		.interface_pe(interface_pe[p_sz*71-1:p_sz*70]),
		.resend(resend[70]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(71),
		.p_sz(p_sz)
		)interface_71(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_35),
		.bus_o(right_switch_7_35),
		.pe_interface(pe_interface[p_sz*72-1:p_sz*71]),
		.interface_pe(interface_pe[p_sz*72-1:p_sz*71]),
		.resend(resend[71]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(72),
		.p_sz(p_sz)
		)interface_72(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_36),
		.bus_o(left_switch_7_36),
		.pe_interface(pe_interface[p_sz*73-1:p_sz*72]),
		.interface_pe(interface_pe[p_sz*73-1:p_sz*72]),
		.resend(resend[72]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(73),
		.p_sz(p_sz)
		)interface_73(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_36),
		.bus_o(right_switch_7_36),
		.pe_interface(pe_interface[p_sz*74-1:p_sz*73]),
		.interface_pe(interface_pe[p_sz*74-1:p_sz*73]),
		.resend(resend[73]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(74),
		.p_sz(p_sz)
		)interface_74(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_37),
		.bus_o(left_switch_7_37),
		.pe_interface(pe_interface[p_sz*75-1:p_sz*74]),
		.interface_pe(interface_pe[p_sz*75-1:p_sz*74]),
		.resend(resend[74]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(75),
		.p_sz(p_sz)
		)interface_75(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_37),
		.bus_o(right_switch_7_37),
		.pe_interface(pe_interface[p_sz*76-1:p_sz*75]),
		.interface_pe(interface_pe[p_sz*76-1:p_sz*75]),
		.resend(resend[75]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(76),
		.p_sz(p_sz)
		)interface_76(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_38),
		.bus_o(left_switch_7_38),
		.pe_interface(pe_interface[p_sz*77-1:p_sz*76]),
		.interface_pe(interface_pe[p_sz*77-1:p_sz*76]),
		.resend(resend[76]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(77),
		.p_sz(p_sz)
		)interface_77(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_38),
		.bus_o(right_switch_7_38),
		.pe_interface(pe_interface[p_sz*78-1:p_sz*77]),
		.interface_pe(interface_pe[p_sz*78-1:p_sz*77]),
		.resend(resend[77]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(78),
		.p_sz(p_sz)
		)interface_78(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_39),
		.bus_o(left_switch_7_39),
		.pe_interface(pe_interface[p_sz*79-1:p_sz*78]),
		.interface_pe(interface_pe[p_sz*79-1:p_sz*78]),
		.resend(resend[78]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(79),
		.p_sz(p_sz)
		)interface_79(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_39),
		.bus_o(right_switch_7_39),
		.pe_interface(pe_interface[p_sz*80-1:p_sz*79]),
		.interface_pe(interface_pe[p_sz*80-1:p_sz*79]),
		.resend(resend[79]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(80),
		.p_sz(p_sz)
		)interface_80(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_40),
		.bus_o(left_switch_7_40),
		.pe_interface(pe_interface[p_sz*81-1:p_sz*80]),
		.interface_pe(interface_pe[p_sz*81-1:p_sz*80]),
		.resend(resend[80]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(81),
		.p_sz(p_sz)
		)interface_81(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_40),
		.bus_o(right_switch_7_40),
		.pe_interface(pe_interface[p_sz*82-1:p_sz*81]),
		.interface_pe(interface_pe[p_sz*82-1:p_sz*81]),
		.resend(resend[81]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(82),
		.p_sz(p_sz)
		)interface_82(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_41),
		.bus_o(left_switch_7_41),
		.pe_interface(pe_interface[p_sz*83-1:p_sz*82]),
		.interface_pe(interface_pe[p_sz*83-1:p_sz*82]),
		.resend(resend[82]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(83),
		.p_sz(p_sz)
		)interface_83(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_41),
		.bus_o(right_switch_7_41),
		.pe_interface(pe_interface[p_sz*84-1:p_sz*83]),
		.interface_pe(interface_pe[p_sz*84-1:p_sz*83]),
		.resend(resend[83]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(84),
		.p_sz(p_sz)
		)interface_84(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_42),
		.bus_o(left_switch_7_42),
		.pe_interface(pe_interface[p_sz*85-1:p_sz*84]),
		.interface_pe(interface_pe[p_sz*85-1:p_sz*84]),
		.resend(resend[84]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(85),
		.p_sz(p_sz)
		)interface_85(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_42),
		.bus_o(right_switch_7_42),
		.pe_interface(pe_interface[p_sz*86-1:p_sz*85]),
		.interface_pe(interface_pe[p_sz*86-1:p_sz*85]),
		.resend(resend[85]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(86),
		.p_sz(p_sz)
		)interface_86(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_43),
		.bus_o(left_switch_7_43),
		.pe_interface(pe_interface[p_sz*87-1:p_sz*86]),
		.interface_pe(interface_pe[p_sz*87-1:p_sz*86]),
		.resend(resend[86]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(87),
		.p_sz(p_sz)
		)interface_87(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_43),
		.bus_o(right_switch_7_43),
		.pe_interface(pe_interface[p_sz*88-1:p_sz*87]),
		.interface_pe(interface_pe[p_sz*88-1:p_sz*87]),
		.resend(resend[87]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(88),
		.p_sz(p_sz)
		)interface_88(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_44),
		.bus_o(left_switch_7_44),
		.pe_interface(pe_interface[p_sz*89-1:p_sz*88]),
		.interface_pe(interface_pe[p_sz*89-1:p_sz*88]),
		.resend(resend[88]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(89),
		.p_sz(p_sz)
		)interface_89(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_44),
		.bus_o(right_switch_7_44),
		.pe_interface(pe_interface[p_sz*90-1:p_sz*89]),
		.interface_pe(interface_pe[p_sz*90-1:p_sz*89]),
		.resend(resend[89]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(90),
		.p_sz(p_sz)
		)interface_90(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_45),
		.bus_o(left_switch_7_45),
		.pe_interface(pe_interface[p_sz*91-1:p_sz*90]),
		.interface_pe(interface_pe[p_sz*91-1:p_sz*90]),
		.resend(resend[90]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(91),
		.p_sz(p_sz)
		)interface_91(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_45),
		.bus_o(right_switch_7_45),
		.pe_interface(pe_interface[p_sz*92-1:p_sz*91]),
		.interface_pe(interface_pe[p_sz*92-1:p_sz*91]),
		.resend(resend[91]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(92),
		.p_sz(p_sz)
		)interface_92(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_46),
		.bus_o(left_switch_7_46),
		.pe_interface(pe_interface[p_sz*93-1:p_sz*92]),
		.interface_pe(interface_pe[p_sz*93-1:p_sz*92]),
		.resend(resend[92]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(93),
		.p_sz(p_sz)
		)interface_93(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_46),
		.bus_o(right_switch_7_46),
		.pe_interface(pe_interface[p_sz*94-1:p_sz*93]),
		.interface_pe(interface_pe[p_sz*94-1:p_sz*93]),
		.resend(resend[93]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(94),
		.p_sz(p_sz)
		)interface_94(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_47),
		.bus_o(left_switch_7_47),
		.pe_interface(pe_interface[p_sz*95-1:p_sz*94]),
		.interface_pe(interface_pe[p_sz*95-1:p_sz*94]),
		.resend(resend[94]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(95),
		.p_sz(p_sz)
		)interface_95(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_47),
		.bus_o(right_switch_7_47),
		.pe_interface(pe_interface[p_sz*96-1:p_sz*95]),
		.interface_pe(interface_pe[p_sz*96-1:p_sz*95]),
		.resend(resend[95]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(96),
		.p_sz(p_sz)
		)interface_96(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_48),
		.bus_o(left_switch_7_48),
		.pe_interface(pe_interface[p_sz*97-1:p_sz*96]),
		.interface_pe(interface_pe[p_sz*97-1:p_sz*96]),
		.resend(resend[96]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(97),
		.p_sz(p_sz)
		)interface_97(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_48),
		.bus_o(right_switch_7_48),
		.pe_interface(pe_interface[p_sz*98-1:p_sz*97]),
		.interface_pe(interface_pe[p_sz*98-1:p_sz*97]),
		.resend(resend[97]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(98),
		.p_sz(p_sz)
		)interface_98(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_49),
		.bus_o(left_switch_7_49),
		.pe_interface(pe_interface[p_sz*99-1:p_sz*98]),
		.interface_pe(interface_pe[p_sz*99-1:p_sz*98]),
		.resend(resend[98]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(99),
		.p_sz(p_sz)
		)interface_99(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_49),
		.bus_o(right_switch_7_49),
		.pe_interface(pe_interface[p_sz*100-1:p_sz*99]),
		.interface_pe(interface_pe[p_sz*100-1:p_sz*99]),
		.resend(resend[99]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(100),
		.p_sz(p_sz)
		)interface_100(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_50),
		.bus_o(left_switch_7_50),
		.pe_interface(pe_interface[p_sz*101-1:p_sz*100]),
		.interface_pe(interface_pe[p_sz*101-1:p_sz*100]),
		.resend(resend[100]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(101),
		.p_sz(p_sz)
		)interface_101(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_50),
		.bus_o(right_switch_7_50),
		.pe_interface(pe_interface[p_sz*102-1:p_sz*101]),
		.interface_pe(interface_pe[p_sz*102-1:p_sz*101]),
		.resend(resend[101]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(102),
		.p_sz(p_sz)
		)interface_102(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_51),
		.bus_o(left_switch_7_51),
		.pe_interface(pe_interface[p_sz*103-1:p_sz*102]),
		.interface_pe(interface_pe[p_sz*103-1:p_sz*102]),
		.resend(resend[102]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(103),
		.p_sz(p_sz)
		)interface_103(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_51),
		.bus_o(right_switch_7_51),
		.pe_interface(pe_interface[p_sz*104-1:p_sz*103]),
		.interface_pe(interface_pe[p_sz*104-1:p_sz*103]),
		.resend(resend[103]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(104),
		.p_sz(p_sz)
		)interface_104(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_52),
		.bus_o(left_switch_7_52),
		.pe_interface(pe_interface[p_sz*105-1:p_sz*104]),
		.interface_pe(interface_pe[p_sz*105-1:p_sz*104]),
		.resend(resend[104]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(105),
		.p_sz(p_sz)
		)interface_105(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_52),
		.bus_o(right_switch_7_52),
		.pe_interface(pe_interface[p_sz*106-1:p_sz*105]),
		.interface_pe(interface_pe[p_sz*106-1:p_sz*105]),
		.resend(resend[105]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(106),
		.p_sz(p_sz)
		)interface_106(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_53),
		.bus_o(left_switch_7_53),
		.pe_interface(pe_interface[p_sz*107-1:p_sz*106]),
		.interface_pe(interface_pe[p_sz*107-1:p_sz*106]),
		.resend(resend[106]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(107),
		.p_sz(p_sz)
		)interface_107(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_53),
		.bus_o(right_switch_7_53),
		.pe_interface(pe_interface[p_sz*108-1:p_sz*107]),
		.interface_pe(interface_pe[p_sz*108-1:p_sz*107]),
		.resend(resend[107]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(108),
		.p_sz(p_sz)
		)interface_108(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_54),
		.bus_o(left_switch_7_54),
		.pe_interface(pe_interface[p_sz*109-1:p_sz*108]),
		.interface_pe(interface_pe[p_sz*109-1:p_sz*108]),
		.resend(resend[108]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(109),
		.p_sz(p_sz)
		)interface_109(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_54),
		.bus_o(right_switch_7_54),
		.pe_interface(pe_interface[p_sz*110-1:p_sz*109]),
		.interface_pe(interface_pe[p_sz*110-1:p_sz*109]),
		.resend(resend[109]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(110),
		.p_sz(p_sz)
		)interface_110(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_55),
		.bus_o(left_switch_7_55),
		.pe_interface(pe_interface[p_sz*111-1:p_sz*110]),
		.interface_pe(interface_pe[p_sz*111-1:p_sz*110]),
		.resend(resend[110]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(111),
		.p_sz(p_sz)
		)interface_111(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_55),
		.bus_o(right_switch_7_55),
		.pe_interface(pe_interface[p_sz*112-1:p_sz*111]),
		.interface_pe(interface_pe[p_sz*112-1:p_sz*111]),
		.resend(resend[111]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(112),
		.p_sz(p_sz)
		)interface_112(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_56),
		.bus_o(left_switch_7_56),
		.pe_interface(pe_interface[p_sz*113-1:p_sz*112]),
		.interface_pe(interface_pe[p_sz*113-1:p_sz*112]),
		.resend(resend[112]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(113),
		.p_sz(p_sz)
		)interface_113(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_56),
		.bus_o(right_switch_7_56),
		.pe_interface(pe_interface[p_sz*114-1:p_sz*113]),
		.interface_pe(interface_pe[p_sz*114-1:p_sz*113]),
		.resend(resend[113]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(114),
		.p_sz(p_sz)
		)interface_114(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_57),
		.bus_o(left_switch_7_57),
		.pe_interface(pe_interface[p_sz*115-1:p_sz*114]),
		.interface_pe(interface_pe[p_sz*115-1:p_sz*114]),
		.resend(resend[114]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(115),
		.p_sz(p_sz)
		)interface_115(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_57),
		.bus_o(right_switch_7_57),
		.pe_interface(pe_interface[p_sz*116-1:p_sz*115]),
		.interface_pe(interface_pe[p_sz*116-1:p_sz*115]),
		.resend(resend[115]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(116),
		.p_sz(p_sz)
		)interface_116(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_58),
		.bus_o(left_switch_7_58),
		.pe_interface(pe_interface[p_sz*117-1:p_sz*116]),
		.interface_pe(interface_pe[p_sz*117-1:p_sz*116]),
		.resend(resend[116]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(117),
		.p_sz(p_sz)
		)interface_117(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_58),
		.bus_o(right_switch_7_58),
		.pe_interface(pe_interface[p_sz*118-1:p_sz*117]),
		.interface_pe(interface_pe[p_sz*118-1:p_sz*117]),
		.resend(resend[117]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(118),
		.p_sz(p_sz)
		)interface_118(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_59),
		.bus_o(left_switch_7_59),
		.pe_interface(pe_interface[p_sz*119-1:p_sz*118]),
		.interface_pe(interface_pe[p_sz*119-1:p_sz*118]),
		.resend(resend[118]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(119),
		.p_sz(p_sz)
		)interface_119(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_59),
		.bus_o(right_switch_7_59),
		.pe_interface(pe_interface[p_sz*120-1:p_sz*119]),
		.interface_pe(interface_pe[p_sz*120-1:p_sz*119]),
		.resend(resend[119]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(120),
		.p_sz(p_sz)
		)interface_120(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_60),
		.bus_o(left_switch_7_60),
		.pe_interface(pe_interface[p_sz*121-1:p_sz*120]),
		.interface_pe(interface_pe[p_sz*121-1:p_sz*120]),
		.resend(resend[120]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(121),
		.p_sz(p_sz)
		)interface_121(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_60),
		.bus_o(right_switch_7_60),
		.pe_interface(pe_interface[p_sz*122-1:p_sz*121]),
		.interface_pe(interface_pe[p_sz*122-1:p_sz*121]),
		.resend(resend[121]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(122),
		.p_sz(p_sz)
		)interface_122(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_61),
		.bus_o(left_switch_7_61),
		.pe_interface(pe_interface[p_sz*123-1:p_sz*122]),
		.interface_pe(interface_pe[p_sz*123-1:p_sz*122]),
		.resend(resend[122]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(123),
		.p_sz(p_sz)
		)interface_123(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_61),
		.bus_o(right_switch_7_61),
		.pe_interface(pe_interface[p_sz*124-1:p_sz*123]),
		.interface_pe(interface_pe[p_sz*124-1:p_sz*123]),
		.resend(resend[123]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(124),
		.p_sz(p_sz)
		)interface_124(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_62),
		.bus_o(left_switch_7_62),
		.pe_interface(pe_interface[p_sz*125-1:p_sz*124]),
		.interface_pe(interface_pe[p_sz*125-1:p_sz*124]),
		.resend(resend[124]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(125),
		.p_sz(p_sz)
		)interface_125(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_62),
		.bus_o(right_switch_7_62),
		.pe_interface(pe_interface[p_sz*126-1:p_sz*125]),
		.interface_pe(interface_pe[p_sz*126-1:p_sz*125]),
		.resend(resend[125]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(126),
		.p_sz(p_sz)
		)interface_126(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_63),
		.bus_o(left_switch_7_63),
		.pe_interface(pe_interface[p_sz*127-1:p_sz*126]),
		.interface_pe(interface_pe[p_sz*127-1:p_sz*126]),
		.resend(resend[126]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(127),
		.p_sz(p_sz)
		)interface_127(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_63),
		.bus_o(right_switch_7_63),
		.pe_interface(pe_interface[p_sz*128-1:p_sz*127]),
		.interface_pe(interface_pe[p_sz*128-1:p_sz*127]),
		.resend(resend[127]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(128),
		.p_sz(p_sz)
		)interface_128(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_64),
		.bus_o(left_switch_7_64),
		.pe_interface(pe_interface[p_sz*129-1:p_sz*128]),
		.interface_pe(interface_pe[p_sz*129-1:p_sz*128]),
		.resend(resend[128]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(129),
		.p_sz(p_sz)
		)interface_129(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_64),
		.bus_o(right_switch_7_64),
		.pe_interface(pe_interface[p_sz*130-1:p_sz*129]),
		.interface_pe(interface_pe[p_sz*130-1:p_sz*129]),
		.resend(resend[129]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(130),
		.p_sz(p_sz)
		)interface_130(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_65),
		.bus_o(left_switch_7_65),
		.pe_interface(pe_interface[p_sz*131-1:p_sz*130]),
		.interface_pe(interface_pe[p_sz*131-1:p_sz*130]),
		.resend(resend[130]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(131),
		.p_sz(p_sz)
		)interface_131(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_65),
		.bus_o(right_switch_7_65),
		.pe_interface(pe_interface[p_sz*132-1:p_sz*131]),
		.interface_pe(interface_pe[p_sz*132-1:p_sz*131]),
		.resend(resend[131]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(132),
		.p_sz(p_sz)
		)interface_132(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_66),
		.bus_o(left_switch_7_66),
		.pe_interface(pe_interface[p_sz*133-1:p_sz*132]),
		.interface_pe(interface_pe[p_sz*133-1:p_sz*132]),
		.resend(resend[132]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(133),
		.p_sz(p_sz)
		)interface_133(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_66),
		.bus_o(right_switch_7_66),
		.pe_interface(pe_interface[p_sz*134-1:p_sz*133]),
		.interface_pe(interface_pe[p_sz*134-1:p_sz*133]),
		.resend(resend[133]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(134),
		.p_sz(p_sz)
		)interface_134(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_67),
		.bus_o(left_switch_7_67),
		.pe_interface(pe_interface[p_sz*135-1:p_sz*134]),
		.interface_pe(interface_pe[p_sz*135-1:p_sz*134]),
		.resend(resend[134]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(135),
		.p_sz(p_sz)
		)interface_135(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_67),
		.bus_o(right_switch_7_67),
		.pe_interface(pe_interface[p_sz*136-1:p_sz*135]),
		.interface_pe(interface_pe[p_sz*136-1:p_sz*135]),
		.resend(resend[135]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(136),
		.p_sz(p_sz)
		)interface_136(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_68),
		.bus_o(left_switch_7_68),
		.pe_interface(pe_interface[p_sz*137-1:p_sz*136]),
		.interface_pe(interface_pe[p_sz*137-1:p_sz*136]),
		.resend(resend[136]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(137),
		.p_sz(p_sz)
		)interface_137(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_68),
		.bus_o(right_switch_7_68),
		.pe_interface(pe_interface[p_sz*138-1:p_sz*137]),
		.interface_pe(interface_pe[p_sz*138-1:p_sz*137]),
		.resend(resend[137]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(138),
		.p_sz(p_sz)
		)interface_138(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_69),
		.bus_o(left_switch_7_69),
		.pe_interface(pe_interface[p_sz*139-1:p_sz*138]),
		.interface_pe(interface_pe[p_sz*139-1:p_sz*138]),
		.resend(resend[138]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(139),
		.p_sz(p_sz)
		)interface_139(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_69),
		.bus_o(right_switch_7_69),
		.pe_interface(pe_interface[p_sz*140-1:p_sz*139]),
		.interface_pe(interface_pe[p_sz*140-1:p_sz*139]),
		.resend(resend[139]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(140),
		.p_sz(p_sz)
		)interface_140(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_70),
		.bus_o(left_switch_7_70),
		.pe_interface(pe_interface[p_sz*141-1:p_sz*140]),
		.interface_pe(interface_pe[p_sz*141-1:p_sz*140]),
		.resend(resend[140]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(141),
		.p_sz(p_sz)
		)interface_141(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_70),
		.bus_o(right_switch_7_70),
		.pe_interface(pe_interface[p_sz*142-1:p_sz*141]),
		.interface_pe(interface_pe[p_sz*142-1:p_sz*141]),
		.resend(resend[141]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(142),
		.p_sz(p_sz)
		)interface_142(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_71),
		.bus_o(left_switch_7_71),
		.pe_interface(pe_interface[p_sz*143-1:p_sz*142]),
		.interface_pe(interface_pe[p_sz*143-1:p_sz*142]),
		.resend(resend[142]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(143),
		.p_sz(p_sz)
		)interface_143(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_71),
		.bus_o(right_switch_7_71),
		.pe_interface(pe_interface[p_sz*144-1:p_sz*143]),
		.interface_pe(interface_pe[p_sz*144-1:p_sz*143]),
		.resend(resend[143]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(144),
		.p_sz(p_sz)
		)interface_144(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_72),
		.bus_o(left_switch_7_72),
		.pe_interface(pe_interface[p_sz*145-1:p_sz*144]),
		.interface_pe(interface_pe[p_sz*145-1:p_sz*144]),
		.resend(resend[144]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(145),
		.p_sz(p_sz)
		)interface_145(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_72),
		.bus_o(right_switch_7_72),
		.pe_interface(pe_interface[p_sz*146-1:p_sz*145]),
		.interface_pe(interface_pe[p_sz*146-1:p_sz*145]),
		.resend(resend[145]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(146),
		.p_sz(p_sz)
		)interface_146(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_73),
		.bus_o(left_switch_7_73),
		.pe_interface(pe_interface[p_sz*147-1:p_sz*146]),
		.interface_pe(interface_pe[p_sz*147-1:p_sz*146]),
		.resend(resend[146]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(147),
		.p_sz(p_sz)
		)interface_147(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_73),
		.bus_o(right_switch_7_73),
		.pe_interface(pe_interface[p_sz*148-1:p_sz*147]),
		.interface_pe(interface_pe[p_sz*148-1:p_sz*147]),
		.resend(resend[147]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(148),
		.p_sz(p_sz)
		)interface_148(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_74),
		.bus_o(left_switch_7_74),
		.pe_interface(pe_interface[p_sz*149-1:p_sz*148]),
		.interface_pe(interface_pe[p_sz*149-1:p_sz*148]),
		.resend(resend[148]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(149),
		.p_sz(p_sz)
		)interface_149(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_74),
		.bus_o(right_switch_7_74),
		.pe_interface(pe_interface[p_sz*150-1:p_sz*149]),
		.interface_pe(interface_pe[p_sz*150-1:p_sz*149]),
		.resend(resend[149]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(150),
		.p_sz(p_sz)
		)interface_150(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_75),
		.bus_o(left_switch_7_75),
		.pe_interface(pe_interface[p_sz*151-1:p_sz*150]),
		.interface_pe(interface_pe[p_sz*151-1:p_sz*150]),
		.resend(resend[150]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(151),
		.p_sz(p_sz)
		)interface_151(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_75),
		.bus_o(right_switch_7_75),
		.pe_interface(pe_interface[p_sz*152-1:p_sz*151]),
		.interface_pe(interface_pe[p_sz*152-1:p_sz*151]),
		.resend(resend[151]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(152),
		.p_sz(p_sz)
		)interface_152(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_76),
		.bus_o(left_switch_7_76),
		.pe_interface(pe_interface[p_sz*153-1:p_sz*152]),
		.interface_pe(interface_pe[p_sz*153-1:p_sz*152]),
		.resend(resend[152]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(153),
		.p_sz(p_sz)
		)interface_153(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_76),
		.bus_o(right_switch_7_76),
		.pe_interface(pe_interface[p_sz*154-1:p_sz*153]),
		.interface_pe(interface_pe[p_sz*154-1:p_sz*153]),
		.resend(resend[153]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(154),
		.p_sz(p_sz)
		)interface_154(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_77),
		.bus_o(left_switch_7_77),
		.pe_interface(pe_interface[p_sz*155-1:p_sz*154]),
		.interface_pe(interface_pe[p_sz*155-1:p_sz*154]),
		.resend(resend[154]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(155),
		.p_sz(p_sz)
		)interface_155(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_77),
		.bus_o(right_switch_7_77),
		.pe_interface(pe_interface[p_sz*156-1:p_sz*155]),
		.interface_pe(interface_pe[p_sz*156-1:p_sz*155]),
		.resend(resend[155]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(156),
		.p_sz(p_sz)
		)interface_156(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_78),
		.bus_o(left_switch_7_78),
		.pe_interface(pe_interface[p_sz*157-1:p_sz*156]),
		.interface_pe(interface_pe[p_sz*157-1:p_sz*156]),
		.resend(resend[156]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(157),
		.p_sz(p_sz)
		)interface_157(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_78),
		.bus_o(right_switch_7_78),
		.pe_interface(pe_interface[p_sz*158-1:p_sz*157]),
		.interface_pe(interface_pe[p_sz*158-1:p_sz*157]),
		.resend(resend[157]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(158),
		.p_sz(p_sz)
		)interface_158(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_79),
		.bus_o(left_switch_7_79),
		.pe_interface(pe_interface[p_sz*159-1:p_sz*158]),
		.interface_pe(interface_pe[p_sz*159-1:p_sz*158]),
		.resend(resend[158]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(159),
		.p_sz(p_sz)
		)interface_159(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_79),
		.bus_o(right_switch_7_79),
		.pe_interface(pe_interface[p_sz*160-1:p_sz*159]),
		.interface_pe(interface_pe[p_sz*160-1:p_sz*159]),
		.resend(resend[159]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(160),
		.p_sz(p_sz)
		)interface_160(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_80),
		.bus_o(left_switch_7_80),
		.pe_interface(pe_interface[p_sz*161-1:p_sz*160]),
		.interface_pe(interface_pe[p_sz*161-1:p_sz*160]),
		.resend(resend[160]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(161),
		.p_sz(p_sz)
		)interface_161(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_80),
		.bus_o(right_switch_7_80),
		.pe_interface(pe_interface[p_sz*162-1:p_sz*161]),
		.interface_pe(interface_pe[p_sz*162-1:p_sz*161]),
		.resend(resend[161]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(162),
		.p_sz(p_sz)
		)interface_162(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_81),
		.bus_o(left_switch_7_81),
		.pe_interface(pe_interface[p_sz*163-1:p_sz*162]),
		.interface_pe(interface_pe[p_sz*163-1:p_sz*162]),
		.resend(resend[162]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(163),
		.p_sz(p_sz)
		)interface_163(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_81),
		.bus_o(right_switch_7_81),
		.pe_interface(pe_interface[p_sz*164-1:p_sz*163]),
		.interface_pe(interface_pe[p_sz*164-1:p_sz*163]),
		.resend(resend[163]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(164),
		.p_sz(p_sz)
		)interface_164(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_82),
		.bus_o(left_switch_7_82),
		.pe_interface(pe_interface[p_sz*165-1:p_sz*164]),
		.interface_pe(interface_pe[p_sz*165-1:p_sz*164]),
		.resend(resend[164]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(165),
		.p_sz(p_sz)
		)interface_165(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_82),
		.bus_o(right_switch_7_82),
		.pe_interface(pe_interface[p_sz*166-1:p_sz*165]),
		.interface_pe(interface_pe[p_sz*166-1:p_sz*165]),
		.resend(resend[165]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(166),
		.p_sz(p_sz)
		)interface_166(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_83),
		.bus_o(left_switch_7_83),
		.pe_interface(pe_interface[p_sz*167-1:p_sz*166]),
		.interface_pe(interface_pe[p_sz*167-1:p_sz*166]),
		.resend(resend[166]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(167),
		.p_sz(p_sz)
		)interface_167(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_83),
		.bus_o(right_switch_7_83),
		.pe_interface(pe_interface[p_sz*168-1:p_sz*167]),
		.interface_pe(interface_pe[p_sz*168-1:p_sz*167]),
		.resend(resend[167]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(168),
		.p_sz(p_sz)
		)interface_168(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_84),
		.bus_o(left_switch_7_84),
		.pe_interface(pe_interface[p_sz*169-1:p_sz*168]),
		.interface_pe(interface_pe[p_sz*169-1:p_sz*168]),
		.resend(resend[168]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(169),
		.p_sz(p_sz)
		)interface_169(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_84),
		.bus_o(right_switch_7_84),
		.pe_interface(pe_interface[p_sz*170-1:p_sz*169]),
		.interface_pe(interface_pe[p_sz*170-1:p_sz*169]),
		.resend(resend[169]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(170),
		.p_sz(p_sz)
		)interface_170(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_85),
		.bus_o(left_switch_7_85),
		.pe_interface(pe_interface[p_sz*171-1:p_sz*170]),
		.interface_pe(interface_pe[p_sz*171-1:p_sz*170]),
		.resend(resend[170]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(171),
		.p_sz(p_sz)
		)interface_171(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_85),
		.bus_o(right_switch_7_85),
		.pe_interface(pe_interface[p_sz*172-1:p_sz*171]),
		.interface_pe(interface_pe[p_sz*172-1:p_sz*171]),
		.resend(resend[171]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(172),
		.p_sz(p_sz)
		)interface_172(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_86),
		.bus_o(left_switch_7_86),
		.pe_interface(pe_interface[p_sz*173-1:p_sz*172]),
		.interface_pe(interface_pe[p_sz*173-1:p_sz*172]),
		.resend(resend[172]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(173),
		.p_sz(p_sz)
		)interface_173(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_86),
		.bus_o(right_switch_7_86),
		.pe_interface(pe_interface[p_sz*174-1:p_sz*173]),
		.interface_pe(interface_pe[p_sz*174-1:p_sz*173]),
		.resend(resend[173]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(174),
		.p_sz(p_sz)
		)interface_174(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_87),
		.bus_o(left_switch_7_87),
		.pe_interface(pe_interface[p_sz*175-1:p_sz*174]),
		.interface_pe(interface_pe[p_sz*175-1:p_sz*174]),
		.resend(resend[174]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(175),
		.p_sz(p_sz)
		)interface_175(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_87),
		.bus_o(right_switch_7_87),
		.pe_interface(pe_interface[p_sz*176-1:p_sz*175]),
		.interface_pe(interface_pe[p_sz*176-1:p_sz*175]),
		.resend(resend[175]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(176),
		.p_sz(p_sz)
		)interface_176(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_88),
		.bus_o(left_switch_7_88),
		.pe_interface(pe_interface[p_sz*177-1:p_sz*176]),
		.interface_pe(interface_pe[p_sz*177-1:p_sz*176]),
		.resend(resend[176]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(177),
		.p_sz(p_sz)
		)interface_177(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_88),
		.bus_o(right_switch_7_88),
		.pe_interface(pe_interface[p_sz*178-1:p_sz*177]),
		.interface_pe(interface_pe[p_sz*178-1:p_sz*177]),
		.resend(resend[177]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(178),
		.p_sz(p_sz)
		)interface_178(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_89),
		.bus_o(left_switch_7_89),
		.pe_interface(pe_interface[p_sz*179-1:p_sz*178]),
		.interface_pe(interface_pe[p_sz*179-1:p_sz*178]),
		.resend(resend[178]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(179),
		.p_sz(p_sz)
		)interface_179(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_89),
		.bus_o(right_switch_7_89),
		.pe_interface(pe_interface[p_sz*180-1:p_sz*179]),
		.interface_pe(interface_pe[p_sz*180-1:p_sz*179]),
		.resend(resend[179]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(180),
		.p_sz(p_sz)
		)interface_180(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_90),
		.bus_o(left_switch_7_90),
		.pe_interface(pe_interface[p_sz*181-1:p_sz*180]),
		.interface_pe(interface_pe[p_sz*181-1:p_sz*180]),
		.resend(resend[180]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(181),
		.p_sz(p_sz)
		)interface_181(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_90),
		.bus_o(right_switch_7_90),
		.pe_interface(pe_interface[p_sz*182-1:p_sz*181]),
		.interface_pe(interface_pe[p_sz*182-1:p_sz*181]),
		.resend(resend[181]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(182),
		.p_sz(p_sz)
		)interface_182(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_91),
		.bus_o(left_switch_7_91),
		.pe_interface(pe_interface[p_sz*183-1:p_sz*182]),
		.interface_pe(interface_pe[p_sz*183-1:p_sz*182]),
		.resend(resend[182]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(183),
		.p_sz(p_sz)
		)interface_183(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_91),
		.bus_o(right_switch_7_91),
		.pe_interface(pe_interface[p_sz*184-1:p_sz*183]),
		.interface_pe(interface_pe[p_sz*184-1:p_sz*183]),
		.resend(resend[183]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(184),
		.p_sz(p_sz)
		)interface_184(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_92),
		.bus_o(left_switch_7_92),
		.pe_interface(pe_interface[p_sz*185-1:p_sz*184]),
		.interface_pe(interface_pe[p_sz*185-1:p_sz*184]),
		.resend(resend[184]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(185),
		.p_sz(p_sz)
		)interface_185(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_92),
		.bus_o(right_switch_7_92),
		.pe_interface(pe_interface[p_sz*186-1:p_sz*185]),
		.interface_pe(interface_pe[p_sz*186-1:p_sz*185]),
		.resend(resend[185]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(186),
		.p_sz(p_sz)
		)interface_186(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_93),
		.bus_o(left_switch_7_93),
		.pe_interface(pe_interface[p_sz*187-1:p_sz*186]),
		.interface_pe(interface_pe[p_sz*187-1:p_sz*186]),
		.resend(resend[186]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(187),
		.p_sz(p_sz)
		)interface_187(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_93),
		.bus_o(right_switch_7_93),
		.pe_interface(pe_interface[p_sz*188-1:p_sz*187]),
		.interface_pe(interface_pe[p_sz*188-1:p_sz*187]),
		.resend(resend[187]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(188),
		.p_sz(p_sz)
		)interface_188(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_94),
		.bus_o(left_switch_7_94),
		.pe_interface(pe_interface[p_sz*189-1:p_sz*188]),
		.interface_pe(interface_pe[p_sz*189-1:p_sz*188]),
		.resend(resend[188]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(189),
		.p_sz(p_sz)
		)interface_189(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_94),
		.bus_o(right_switch_7_94),
		.pe_interface(pe_interface[p_sz*190-1:p_sz*189]),
		.interface_pe(interface_pe[p_sz*190-1:p_sz*189]),
		.resend(resend[189]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(190),
		.p_sz(p_sz)
		)interface_190(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_95),
		.bus_o(left_switch_7_95),
		.pe_interface(pe_interface[p_sz*191-1:p_sz*190]),
		.interface_pe(interface_pe[p_sz*191-1:p_sz*190]),
		.resend(resend[190]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(191),
		.p_sz(p_sz)
		)interface_191(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_95),
		.bus_o(right_switch_7_95),
		.pe_interface(pe_interface[p_sz*192-1:p_sz*191]),
		.interface_pe(interface_pe[p_sz*192-1:p_sz*191]),
		.resend(resend[191]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(192),
		.p_sz(p_sz)
		)interface_192(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_96),
		.bus_o(left_switch_7_96),
		.pe_interface(pe_interface[p_sz*193-1:p_sz*192]),
		.interface_pe(interface_pe[p_sz*193-1:p_sz*192]),
		.resend(resend[192]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(193),
		.p_sz(p_sz)
		)interface_193(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_96),
		.bus_o(right_switch_7_96),
		.pe_interface(pe_interface[p_sz*194-1:p_sz*193]),
		.interface_pe(interface_pe[p_sz*194-1:p_sz*193]),
		.resend(resend[193]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(194),
		.p_sz(p_sz)
		)interface_194(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_97),
		.bus_o(left_switch_7_97),
		.pe_interface(pe_interface[p_sz*195-1:p_sz*194]),
		.interface_pe(interface_pe[p_sz*195-1:p_sz*194]),
		.resend(resend[194]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(195),
		.p_sz(p_sz)
		)interface_195(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_97),
		.bus_o(right_switch_7_97),
		.pe_interface(pe_interface[p_sz*196-1:p_sz*195]),
		.interface_pe(interface_pe[p_sz*196-1:p_sz*195]),
		.resend(resend[195]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(196),
		.p_sz(p_sz)
		)interface_196(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_98),
		.bus_o(left_switch_7_98),
		.pe_interface(pe_interface[p_sz*197-1:p_sz*196]),
		.interface_pe(interface_pe[p_sz*197-1:p_sz*196]),
		.resend(resend[196]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(197),
		.p_sz(p_sz)
		)interface_197(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_98),
		.bus_o(right_switch_7_98),
		.pe_interface(pe_interface[p_sz*198-1:p_sz*197]),
		.interface_pe(interface_pe[p_sz*198-1:p_sz*197]),
		.resend(resend[197]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(198),
		.p_sz(p_sz)
		)interface_198(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_99),
		.bus_o(left_switch_7_99),
		.pe_interface(pe_interface[p_sz*199-1:p_sz*198]),
		.interface_pe(interface_pe[p_sz*199-1:p_sz*198]),
		.resend(resend[198]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(199),
		.p_sz(p_sz)
		)interface_199(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_99),
		.bus_o(right_switch_7_99),
		.pe_interface(pe_interface[p_sz*200-1:p_sz*199]),
		.interface_pe(interface_pe[p_sz*200-1:p_sz*199]),
		.resend(resend[199]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(200),
		.p_sz(p_sz)
		)interface_200(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_100),
		.bus_o(left_switch_7_100),
		.pe_interface(pe_interface[p_sz*201-1:p_sz*200]),
		.interface_pe(interface_pe[p_sz*201-1:p_sz*200]),
		.resend(resend[200]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(201),
		.p_sz(p_sz)
		)interface_201(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_100),
		.bus_o(right_switch_7_100),
		.pe_interface(pe_interface[p_sz*202-1:p_sz*201]),
		.interface_pe(interface_pe[p_sz*202-1:p_sz*201]),
		.resend(resend[201]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(202),
		.p_sz(p_sz)
		)interface_202(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_101),
		.bus_o(left_switch_7_101),
		.pe_interface(pe_interface[p_sz*203-1:p_sz*202]),
		.interface_pe(interface_pe[p_sz*203-1:p_sz*202]),
		.resend(resend[202]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(203),
		.p_sz(p_sz)
		)interface_203(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_101),
		.bus_o(right_switch_7_101),
		.pe_interface(pe_interface[p_sz*204-1:p_sz*203]),
		.interface_pe(interface_pe[p_sz*204-1:p_sz*203]),
		.resend(resend[203]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(204),
		.p_sz(p_sz)
		)interface_204(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_102),
		.bus_o(left_switch_7_102),
		.pe_interface(pe_interface[p_sz*205-1:p_sz*204]),
		.interface_pe(interface_pe[p_sz*205-1:p_sz*204]),
		.resend(resend[204]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(205),
		.p_sz(p_sz)
		)interface_205(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_102),
		.bus_o(right_switch_7_102),
		.pe_interface(pe_interface[p_sz*206-1:p_sz*205]),
		.interface_pe(interface_pe[p_sz*206-1:p_sz*205]),
		.resend(resend[205]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(206),
		.p_sz(p_sz)
		)interface_206(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_103),
		.bus_o(left_switch_7_103),
		.pe_interface(pe_interface[p_sz*207-1:p_sz*206]),
		.interface_pe(interface_pe[p_sz*207-1:p_sz*206]),
		.resend(resend[206]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(207),
		.p_sz(p_sz)
		)interface_207(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_103),
		.bus_o(right_switch_7_103),
		.pe_interface(pe_interface[p_sz*208-1:p_sz*207]),
		.interface_pe(interface_pe[p_sz*208-1:p_sz*207]),
		.resend(resend[207]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(208),
		.p_sz(p_sz)
		)interface_208(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_104),
		.bus_o(left_switch_7_104),
		.pe_interface(pe_interface[p_sz*209-1:p_sz*208]),
		.interface_pe(interface_pe[p_sz*209-1:p_sz*208]),
		.resend(resend[208]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(209),
		.p_sz(p_sz)
		)interface_209(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_104),
		.bus_o(right_switch_7_104),
		.pe_interface(pe_interface[p_sz*210-1:p_sz*209]),
		.interface_pe(interface_pe[p_sz*210-1:p_sz*209]),
		.resend(resend[209]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(210),
		.p_sz(p_sz)
		)interface_210(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_105),
		.bus_o(left_switch_7_105),
		.pe_interface(pe_interface[p_sz*211-1:p_sz*210]),
		.interface_pe(interface_pe[p_sz*211-1:p_sz*210]),
		.resend(resend[210]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(211),
		.p_sz(p_sz)
		)interface_211(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_105),
		.bus_o(right_switch_7_105),
		.pe_interface(pe_interface[p_sz*212-1:p_sz*211]),
		.interface_pe(interface_pe[p_sz*212-1:p_sz*211]),
		.resend(resend[211]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(212),
		.p_sz(p_sz)
		)interface_212(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_106),
		.bus_o(left_switch_7_106),
		.pe_interface(pe_interface[p_sz*213-1:p_sz*212]),
		.interface_pe(interface_pe[p_sz*213-1:p_sz*212]),
		.resend(resend[212]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(213),
		.p_sz(p_sz)
		)interface_213(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_106),
		.bus_o(right_switch_7_106),
		.pe_interface(pe_interface[p_sz*214-1:p_sz*213]),
		.interface_pe(interface_pe[p_sz*214-1:p_sz*213]),
		.resend(resend[213]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(214),
		.p_sz(p_sz)
		)interface_214(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_107),
		.bus_o(left_switch_7_107),
		.pe_interface(pe_interface[p_sz*215-1:p_sz*214]),
		.interface_pe(interface_pe[p_sz*215-1:p_sz*214]),
		.resend(resend[214]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(215),
		.p_sz(p_sz)
		)interface_215(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_107),
		.bus_o(right_switch_7_107),
		.pe_interface(pe_interface[p_sz*216-1:p_sz*215]),
		.interface_pe(interface_pe[p_sz*216-1:p_sz*215]),
		.resend(resend[215]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(216),
		.p_sz(p_sz)
		)interface_216(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_108),
		.bus_o(left_switch_7_108),
		.pe_interface(pe_interface[p_sz*217-1:p_sz*216]),
		.interface_pe(interface_pe[p_sz*217-1:p_sz*216]),
		.resend(resend[216]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(217),
		.p_sz(p_sz)
		)interface_217(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_108),
		.bus_o(right_switch_7_108),
		.pe_interface(pe_interface[p_sz*218-1:p_sz*217]),
		.interface_pe(interface_pe[p_sz*218-1:p_sz*217]),
		.resend(resend[217]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(218),
		.p_sz(p_sz)
		)interface_218(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_109),
		.bus_o(left_switch_7_109),
		.pe_interface(pe_interface[p_sz*219-1:p_sz*218]),
		.interface_pe(interface_pe[p_sz*219-1:p_sz*218]),
		.resend(resend[218]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(219),
		.p_sz(p_sz)
		)interface_219(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_109),
		.bus_o(right_switch_7_109),
		.pe_interface(pe_interface[p_sz*220-1:p_sz*219]),
		.interface_pe(interface_pe[p_sz*220-1:p_sz*219]),
		.resend(resend[219]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(220),
		.p_sz(p_sz)
		)interface_220(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_110),
		.bus_o(left_switch_7_110),
		.pe_interface(pe_interface[p_sz*221-1:p_sz*220]),
		.interface_pe(interface_pe[p_sz*221-1:p_sz*220]),
		.resend(resend[220]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(221),
		.p_sz(p_sz)
		)interface_221(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_110),
		.bus_o(right_switch_7_110),
		.pe_interface(pe_interface[p_sz*222-1:p_sz*221]),
		.interface_pe(interface_pe[p_sz*222-1:p_sz*221]),
		.resend(resend[221]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(222),
		.p_sz(p_sz)
		)interface_222(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_111),
		.bus_o(left_switch_7_111),
		.pe_interface(pe_interface[p_sz*223-1:p_sz*222]),
		.interface_pe(interface_pe[p_sz*223-1:p_sz*222]),
		.resend(resend[222]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(223),
		.p_sz(p_sz)
		)interface_223(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_111),
		.bus_o(right_switch_7_111),
		.pe_interface(pe_interface[p_sz*224-1:p_sz*223]),
		.interface_pe(interface_pe[p_sz*224-1:p_sz*223]),
		.resend(resend[223]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(224),
		.p_sz(p_sz)
		)interface_224(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_112),
		.bus_o(left_switch_7_112),
		.pe_interface(pe_interface[p_sz*225-1:p_sz*224]),
		.interface_pe(interface_pe[p_sz*225-1:p_sz*224]),
		.resend(resend[224]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(225),
		.p_sz(p_sz)
		)interface_225(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_112),
		.bus_o(right_switch_7_112),
		.pe_interface(pe_interface[p_sz*226-1:p_sz*225]),
		.interface_pe(interface_pe[p_sz*226-1:p_sz*225]),
		.resend(resend[225]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(226),
		.p_sz(p_sz)
		)interface_226(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_113),
		.bus_o(left_switch_7_113),
		.pe_interface(pe_interface[p_sz*227-1:p_sz*226]),
		.interface_pe(interface_pe[p_sz*227-1:p_sz*226]),
		.resend(resend[226]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(227),
		.p_sz(p_sz)
		)interface_227(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_113),
		.bus_o(right_switch_7_113),
		.pe_interface(pe_interface[p_sz*228-1:p_sz*227]),
		.interface_pe(interface_pe[p_sz*228-1:p_sz*227]),
		.resend(resend[227]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(228),
		.p_sz(p_sz)
		)interface_228(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_114),
		.bus_o(left_switch_7_114),
		.pe_interface(pe_interface[p_sz*229-1:p_sz*228]),
		.interface_pe(interface_pe[p_sz*229-1:p_sz*228]),
		.resend(resend[228]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(229),
		.p_sz(p_sz)
		)interface_229(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_114),
		.bus_o(right_switch_7_114),
		.pe_interface(pe_interface[p_sz*230-1:p_sz*229]),
		.interface_pe(interface_pe[p_sz*230-1:p_sz*229]),
		.resend(resend[229]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(230),
		.p_sz(p_sz)
		)interface_230(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_115),
		.bus_o(left_switch_7_115),
		.pe_interface(pe_interface[p_sz*231-1:p_sz*230]),
		.interface_pe(interface_pe[p_sz*231-1:p_sz*230]),
		.resend(resend[230]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(231),
		.p_sz(p_sz)
		)interface_231(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_115),
		.bus_o(right_switch_7_115),
		.pe_interface(pe_interface[p_sz*232-1:p_sz*231]),
		.interface_pe(interface_pe[p_sz*232-1:p_sz*231]),
		.resend(resend[231]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(232),
		.p_sz(p_sz)
		)interface_232(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_116),
		.bus_o(left_switch_7_116),
		.pe_interface(pe_interface[p_sz*233-1:p_sz*232]),
		.interface_pe(interface_pe[p_sz*233-1:p_sz*232]),
		.resend(resend[232]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(233),
		.p_sz(p_sz)
		)interface_233(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_116),
		.bus_o(right_switch_7_116),
		.pe_interface(pe_interface[p_sz*234-1:p_sz*233]),
		.interface_pe(interface_pe[p_sz*234-1:p_sz*233]),
		.resend(resend[233]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(234),
		.p_sz(p_sz)
		)interface_234(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_117),
		.bus_o(left_switch_7_117),
		.pe_interface(pe_interface[p_sz*235-1:p_sz*234]),
		.interface_pe(interface_pe[p_sz*235-1:p_sz*234]),
		.resend(resend[234]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(235),
		.p_sz(p_sz)
		)interface_235(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_117),
		.bus_o(right_switch_7_117),
		.pe_interface(pe_interface[p_sz*236-1:p_sz*235]),
		.interface_pe(interface_pe[p_sz*236-1:p_sz*235]),
		.resend(resend[235]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(236),
		.p_sz(p_sz)
		)interface_236(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_118),
		.bus_o(left_switch_7_118),
		.pe_interface(pe_interface[p_sz*237-1:p_sz*236]),
		.interface_pe(interface_pe[p_sz*237-1:p_sz*236]),
		.resend(resend[236]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(237),
		.p_sz(p_sz)
		)interface_237(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_118),
		.bus_o(right_switch_7_118),
		.pe_interface(pe_interface[p_sz*238-1:p_sz*237]),
		.interface_pe(interface_pe[p_sz*238-1:p_sz*237]),
		.resend(resend[237]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(238),
		.p_sz(p_sz)
		)interface_238(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_119),
		.bus_o(left_switch_7_119),
		.pe_interface(pe_interface[p_sz*239-1:p_sz*238]),
		.interface_pe(interface_pe[p_sz*239-1:p_sz*238]),
		.resend(resend[238]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(239),
		.p_sz(p_sz)
		)interface_239(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_119),
		.bus_o(right_switch_7_119),
		.pe_interface(pe_interface[p_sz*240-1:p_sz*239]),
		.interface_pe(interface_pe[p_sz*240-1:p_sz*239]),
		.resend(resend[239]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(240),
		.p_sz(p_sz)
		)interface_240(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_120),
		.bus_o(left_switch_7_120),
		.pe_interface(pe_interface[p_sz*241-1:p_sz*240]),
		.interface_pe(interface_pe[p_sz*241-1:p_sz*240]),
		.resend(resend[240]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(241),
		.p_sz(p_sz)
		)interface_241(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_120),
		.bus_o(right_switch_7_120),
		.pe_interface(pe_interface[p_sz*242-1:p_sz*241]),
		.interface_pe(interface_pe[p_sz*242-1:p_sz*241]),
		.resend(resend[241]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(242),
		.p_sz(p_sz)
		)interface_242(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_121),
		.bus_o(left_switch_7_121),
		.pe_interface(pe_interface[p_sz*243-1:p_sz*242]),
		.interface_pe(interface_pe[p_sz*243-1:p_sz*242]),
		.resend(resend[242]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(243),
		.p_sz(p_sz)
		)interface_243(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_121),
		.bus_o(right_switch_7_121),
		.pe_interface(pe_interface[p_sz*244-1:p_sz*243]),
		.interface_pe(interface_pe[p_sz*244-1:p_sz*243]),
		.resend(resend[243]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(244),
		.p_sz(p_sz)
		)interface_244(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_122),
		.bus_o(left_switch_7_122),
		.pe_interface(pe_interface[p_sz*245-1:p_sz*244]),
		.interface_pe(interface_pe[p_sz*245-1:p_sz*244]),
		.resend(resend[244]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(245),
		.p_sz(p_sz)
		)interface_245(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_122),
		.bus_o(right_switch_7_122),
		.pe_interface(pe_interface[p_sz*246-1:p_sz*245]),
		.interface_pe(interface_pe[p_sz*246-1:p_sz*245]),
		.resend(resend[245]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(246),
		.p_sz(p_sz)
		)interface_246(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_123),
		.bus_o(left_switch_7_123),
		.pe_interface(pe_interface[p_sz*247-1:p_sz*246]),
		.interface_pe(interface_pe[p_sz*247-1:p_sz*246]),
		.resend(resend[246]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(247),
		.p_sz(p_sz)
		)interface_247(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_123),
		.bus_o(right_switch_7_123),
		.pe_interface(pe_interface[p_sz*248-1:p_sz*247]),
		.interface_pe(interface_pe[p_sz*248-1:p_sz*247]),
		.resend(resend[247]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(248),
		.p_sz(p_sz)
		)interface_248(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_124),
		.bus_o(left_switch_7_124),
		.pe_interface(pe_interface[p_sz*249-1:p_sz*248]),
		.interface_pe(interface_pe[p_sz*249-1:p_sz*248]),
		.resend(resend[248]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(249),
		.p_sz(p_sz)
		)interface_249(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_124),
		.bus_o(right_switch_7_124),
		.pe_interface(pe_interface[p_sz*250-1:p_sz*249]),
		.interface_pe(interface_pe[p_sz*250-1:p_sz*249]),
		.resend(resend[249]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(250),
		.p_sz(p_sz)
		)interface_250(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_125),
		.bus_o(left_switch_7_125),
		.pe_interface(pe_interface[p_sz*251-1:p_sz*250]),
		.interface_pe(interface_pe[p_sz*251-1:p_sz*250]),
		.resend(resend[250]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(251),
		.p_sz(p_sz)
		)interface_251(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_125),
		.bus_o(right_switch_7_125),
		.pe_interface(pe_interface[p_sz*252-1:p_sz*251]),
		.interface_pe(interface_pe[p_sz*252-1:p_sz*251]),
		.resend(resend[251]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(252),
		.p_sz(p_sz)
		)interface_252(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_126),
		.bus_o(left_switch_7_126),
		.pe_interface(pe_interface[p_sz*253-1:p_sz*252]),
		.interface_pe(interface_pe[p_sz*253-1:p_sz*252]),
		.resend(resend[252]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(253),
		.p_sz(p_sz)
		)interface_253(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_126),
		.bus_o(right_switch_7_126),
		.pe_interface(pe_interface[p_sz*254-1:p_sz*253]),
		.interface_pe(interface_pe[p_sz*254-1:p_sz*253]),
		.resend(resend[253]));
	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(254),
		.p_sz(p_sz)
		)interface_254(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_left_7_127),
		.bus_o(left_switch_7_127),
		.pe_interface(pe_interface[p_sz*255-1:p_sz*254]),
		.interface_pe(interface_pe[p_sz*255-1:p_sz*254]),
		.resend(resend[254]));

	interface #(
		.num_leaves(num_leaves),
		.payload_sz(payload_sz),
		.addr(255),
		.p_sz(p_sz)
		)interface_255(
		.clk(clk),
		.reset(reset),
		.bus_i(switch_right_7_127),
		.bus_o(right_switch_7_127),
		.pe_interface(pe_interface[p_sz*256-1:p_sz*255]),
		.interface_pe(interface_pe[p_sz*256-1:p_sz*255]),
		.resend(resend[255]));
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

/*
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
*/
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