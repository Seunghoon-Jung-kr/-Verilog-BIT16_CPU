`timescale 1ns / 1ps
module bit4_cla(a, b, cin, s, cout);
input  wire [3:0] a,b  ;
input  wire       cin   ;
output wire [3:0] s     ;
output wire       cout  ;

wire [3:0] g;
wire [3:0] p;
wire [3:0] c;

assign g = a & b;
assign p = a ^ b;

assign c[0] = cin,
       c[1] = g[0] | ( p[0] & c[0] ),
       c[2] = g[1] | ( p[1] & c[1] ),
       c[3] = g[2] | ( p[2] & c[2] );

assign s = p ^ c;

assign cout = g[3] | ( p[3] & c[3]); 
endmodule
