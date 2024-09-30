`timescale 1ns / 1ps
module bit1_register_control3(i_value, i_inr, ld, inr, clr, clk, o_value);
input  wire i_value, i_inr, ld, inr, clr, clk;
output wire o_value;

reg r_dff;
wire w_comb_out;

// Combinational Logic
assign w_comb_out = ~clr & (( ld & i_value ) | ( ~ld & inr & i_inr ) | ( ~ld & ~inr & o_value));  

// D_FF
always @(posedge clk)
    r_dff <= w_comb_out;
assign o_value = r_dff;
  
endmodule
