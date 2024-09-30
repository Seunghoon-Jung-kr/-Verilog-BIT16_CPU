`timescale 1ns / 1ps
module bit16_register_control3(i_value, ld, inr, clr, clk, o_value);
input  wire [15:0] i_value;
input  wire        ld, inr, clr, clk;
output wire [15:0] o_value;

//module bit1_register_control3(i_value, i_inr, ld, inr, clr, clk, o_value);
wire cin;
wire [15:0] i_inr;
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
bit1_register_control3 u_12(i_value[12], i_inr[12], ld, inr, clr, clk, o_value[12]) ;
bit1_register_control3 u_13(i_value[13], i_inr[13], ld, inr, clr, clk, o_value[13]) ;
bit1_register_control3 u_14(i_value[14], i_inr[14], ld, inr, clr, clk, o_value[14]) ;
bit1_register_control3 u_15(i_value[15], i_inr[15], ld, inr, clr, clk, o_value[15]) ;
assign cin = 1'b1;
//module bit4_incrementer(i_value, inr, cin, o_value, cout);
bit4_incrementer u_inc_0(o_value[3:0]  , inr, cin    , i_inr[3:0]  , cout[0]);
bit4_incrementer u_inc_1(o_value[7:4]  , inr, cout[0], i_inr[7:4]  , cout[1]);
bit4_incrementer u_inc_2(o_value[11:8] , inr, cout[1], i_inr[11:8] , cout[2]);
bit4_incrementer u_inc_3(o_value[15:12], inr, cout[2], i_inr[15:12],        );

endmodule
