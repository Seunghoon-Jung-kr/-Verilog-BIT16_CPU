`timescale 1ns / 1ps
module bit2_shifter(i_value, sel, o_value);
input  wire       sel;
input  wire [3:0] i_value;
output wire [1:0] o_value;

// Shift
assign o_value[0] = sel ? i_value[2] : i_value[0];
assign o_value[1] = sel ? i_value[3] : i_value[1];
endmodule
