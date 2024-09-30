`timescale 1ns / 1ps
module bit8_register_control_ld(i_value_fix, ld, clk, o_value);
input  wire [15:0] i_value_fix;
input  wire        ld, clk;
output wire [7:0] o_value;
wire [7:0] i_value;
assign i_value = i_value_fix[7:0];
bit1_register_control_ld u_0(i_value[0], ld, clk, o_value[0]);
bit1_register_control_ld u_1(i_value[1], ld, clk, o_value[1]);
bit1_register_control_ld u_2(i_value[2], ld, clk, o_value[2]);
bit1_register_control_ld u_3(i_value[3], ld, clk, o_value[3]);

bit1_register_control_ld u_4(i_value[4], ld, clk, o_value[4]);
bit1_register_control_ld u_5(i_value[5], ld, clk, o_value[5]);
bit1_register_control_ld u_6(i_value[6], ld, clk, o_value[6]);
bit1_register_control_ld u_7(i_value[7], ld, clk, o_value[7]);
endmodule
