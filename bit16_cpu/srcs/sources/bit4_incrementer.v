`timescale 1ns / 1ps
module bit4_incrementer(i_value, inr, cin, o_value, cout);
input  wire [3:0] i_value;
input  wire       inr, cin;
output wire [3:0] o_value;
output wire       cout;

wire [3:0] w_gating;
//For gating (reducing dynamic power loss)
assign w_gating = i_value & {4{inr}};

//o_value
assign o_value[0] = w_gating[0] ^ (cin);
assign o_value[1] = w_gating[1] ^ (cin & w_gating[0]);
assign o_value[2] = w_gating[2] ^ (cin & w_gating[0] & w_gating[1]);
assign o_value[3] = w_gating[3] ^ (cin & w_gating[0] & w_gating[1] & w_gating[2]);

//cout
assign cout = cin & w_gating[0] & w_gating[1] & w_gating[2] & w_gating[3];
endmodule
