`timescale 1ns / 1ps
module bit16_shifter(e, i_ac_fix, sel, o_value);
input  wire [15:0] i_ac_fix;
input  wire        e   ;
input  wire [2:0]  sel ;
output wire [15:0] o_value;

wire [15:0] i_ac;
wire w_gating;
wire w_s;

//sel assign
assign w_s = sel[2] & ~sel[1] & sel[0]; //100(Left) == 1, RIGHT == 0
assign w_gating = sel[2] & ~sel[1];
assign i_ac = i_ac_fix & {16{w_gating}};

// bit2_shifter(i_gating, i_value, sel, o_value);
bit2_shifter u_0({i_ac[2:0], e}, w_s, o_value[1:0]);
bit2_shifter u_1(i_ac[4:1], w_s, o_value[3:2]);
bit2_shifter u_2(i_ac[6:3], w_s, o_value[5:4]);
bit2_shifter u_3(i_ac[8:5], w_s, o_value[7:6]);

bit2_shifter u_4(i_ac[10:7], w_s, o_value[9:8]);
bit2_shifter u_5(i_ac[12:9], w_s, o_value[11:10]);
bit2_shifter u_6(i_ac[14:11], w_s, o_value[13:12]);
bit2_shifter u_7({e, i_ac[15:13]}, w_s, o_value[15:14]);
endmodule
