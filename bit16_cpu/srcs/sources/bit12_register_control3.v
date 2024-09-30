`timescale 1ns / 1ps
module bit12_register_control3(i_value_fix, ld, inr, clr, clk, o_value_fix);
input  wire [15:0] i_value_fix;
input  wire        ld, inr, clr, clk;
output wire [15:0] o_value_fix;
wire [11:0] i_value, o_value;
assign i_value = i_value_fix[11:0];
assign o_value_fix = {4'b0000,o_value};
//module bit1_register_control3(i_value, i_inr, ld, inr, clr, clk, o_value);
wire cin;
wire [11:0] i_inr;
wire [2:0]  cout; 
bit1_register_control3 u_0 (i_value[0] , i_inr[0] , ld, inr, clr, clk, o_value[0])  ;
bit1_register_control3 u_1 (i_value[1] , i_inr[1] , ld, inr, clr, clk, o_value[1])  ;
bit1_register_control3 u_2 (i_value[2] , i_inr[2] , ld, inr, clr, clk, o_value[2])  ;
bit1_register_control3 u_3 (i_value[3] , i_inr[3] , ld, inr, clr, clk, o_value[3])  ;
bit1_register_control3 u_4 (i_value[4] , i_inr[4] , ld, inr, clr, clk, o_value[4])  ;
bit1_register_control3 u_5 (i_value[5] , i_inr[5] , ld, inr, clr, clk, o_value[5])  ;
bit1_register_control3 u_6 (i_value[6] , i_inr[6] , ld, inr, clr, clk, o_value[6])  ;
bit1_register_control3 u_7 (i_value[7] , i_inr[7] , ld, inr, clr, clk, o_value[7])  ;
bit1_register_control3 u_8 (i_value[8] , i_inr[8] , ld, inr, clr, clk, o_value[8])  ;
bit1_register_control3 u_9 (i_value[9] , i_inr[9] , ld, inr, clr, clk, o_value[9])  ;
bit1_register_control3 u_10(i_value[10], i_inr[10], ld, inr, clr, clk, o_value[10]) ;
bit1_register_control3 u_11(i_value[11], i_inr[11], ld, inr, clr, clk, o_value[11]) ;
assign cin = 1'b1;
//module bit4_incrementer(i_value, inr, cin, o_value, cout);
bit4_incrementer u_inc_0(o_value[3:0]  , inr, cin    , i_inr[3:0]  , cout[0]);
bit4_incrementer u_inc_1(o_value[7:4]  , inr, cout[0], i_inr[7:4]  , cout[1]);
bit4_incrementer u_inc_2(o_value[11:8] , inr, cout[1], i_inr[11:8] , );

endmodule
