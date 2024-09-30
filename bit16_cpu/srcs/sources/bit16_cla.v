`timescale 1ns / 1ps
module bit16_cla(sel, cin, i_a, i_b, o_s, cout);
//bit4_cla(a, b, cin, s, cout);
input  wire [15:0] i_a;
input  wire [15:0] i_b;
input  wire [ 2:0] sel;
input  wire        cin;
output wire [15:0] o_s;
output wire        cout;
wire [15:0] w_gating_a, w_gating_b; 
wire w_gating;
wire [2:0 ] w_c;

assign w_gating = ~sel[2] & ~sel[1] & sel[0];
assign w_gating_a = i_a & {16{w_gating}};
assign w_gating_b = i_b & {16{w_gating}};

bit4_cla u_0(w_gating_a[3:0]  , w_gating_b[3:0],   cin   , o_s[3:0]  , w_c[0]);
bit4_cla u_1(w_gating_a[7:4]  , w_gating_b[7:4],   w_c[0], o_s[7:4]  , w_c[1]);
bit4_cla u_2(w_gating_a[11:8] , w_gating_b[11:8],  w_c[1], o_s[11:8] , w_c[2]);
bit4_cla u_3(w_gating_a[15:12], w_gating_b[15:12], w_c[2], o_s[15:12], cout);


endmodule
