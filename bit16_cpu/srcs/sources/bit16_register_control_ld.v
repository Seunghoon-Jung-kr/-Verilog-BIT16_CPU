`timescale 1ns / 1ps
module bit16_register_control_ld(i_value, ld, clk, o_value);
input  wire [15:0] i_value;
input  wire        ld, clk;
output wire [15:0] o_value;

bit1_register_control_ld u_0(i_value[0], ld, clk, o_value[0]);
bit1_register_control_ld u_1(i_value[1], ld, clk, o_value[1]);
bit1_register_control_ld u_2(i_value[2], ld, clk, o_value[2]);
bit1_register_control_ld u_3(i_value[3], ld, clk, o_value[3]);

bit1_register_control_ld u_4(i_value[4], ld, clk, o_value[4]);
bit1_register_control_ld u_5(i_value[5], ld, clk, o_value[5]);
bit1_register_control_ld u_6(i_value[6], ld, clk, o_value[6]);
bit1_register_control_ld u_7(i_value[7], ld, clk, o_value[7]);

bit1_register_control_ld u_8(i_value[8], ld, clk, o_value[8]);
bit1_register_control_ld u_9(i_value[9], ld, clk, o_value[9]);
bit1_register_control_ld u_10(i_value[10], ld, clk, o_value[10]);
bit1_register_control_ld u_11(i_value[11], ld, clk, o_value[11]);

bit1_register_control_ld u_12(i_value[12], ld, clk, o_value[12]);
bit1_register_control_ld u_13(i_value[13], ld, clk, o_value[13]);
bit1_register_control_ld u_14(i_value[14], ld, clk, o_value[14]);
bit1_register_control_ld u_15(i_value[15], ld, clk, o_value[15]);
endmodule
