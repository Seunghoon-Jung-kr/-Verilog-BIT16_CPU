`timescale 1ns / 1ps
module CU(
    i_t, i_r, i_ir, i_ien, i_fgi, i_fgo, i_dr, i_ac, i_e, i_s, reset, start, i_fgi_on, i_fgo_on,
    o_sel, o_ar, o_ir, o_pc, o_r, o_tr, o_ram, o_ien, o_sc, o_dr, o_ac, o_alu, o_e, o_s, 
    o_fgi, o_outr, o_fgo
);
parameter DR = 3'b000, AC = 3'b001, TR = 3'b010, AR = 3'b011, PC = 3'b100, IR = 3'b101, RAM = 3'b110;
parameter AND = 3'b000, ADD = 3'b001, T_DR = 3'b010, CMA = 3'b011, SHL = 3'b100, SHR = 3'b101, INPR = 3'b110, T_AC = 3'b111;

input  wire [ 6:0] i_t;
input  wire        i_r;
input  wire [15:0] i_ir;
input  wire        i_ien, i_fgi, i_fgo;
input  wire [15:0] i_dr;
input  wire [15:0] i_ac;
input  wire        i_e;
input  wire        i_s;
input  wire        start, reset;
input  wire        i_fgi_on, i_fgo_on;

output reg  [ 2:0] o_ar;
output reg  [ 2:0] o_sel;
output reg         o_ir;
output reg  [ 2:0] o_pc;
output reg  [ 1:0] o_r;
output reg  [ 2:0] o_tr;
output reg  [ 1:0] o_ram;
output reg  [ 1:0] o_ien;
output reg         o_sc;
output reg  [ 2:0] o_dr;
output reg  [ 2:0] o_ac;
output reg  [ 2:0] o_alu;
output reg  [ 3:0] o_e;
output reg  [ 1:0] o_s;
output reg  [ 1:0] o_fgi;
output reg         o_outr;
output reg  [ 1:0] o_fgo;

reg [7:0] d;
wire      i;
wire      r;
wire      p;

assign i = i_ir[15];
assign r = d[7] & ~i & i_t[3];
assign p = d[7] &  i & i_t[3];

//Decoder
always @*begin
    case(i_ir[14:12])
        3'b000 : d = 8'b0000_0001;
        3'b001 : d = 8'b0000_0010;
        3'b010 : d = 8'b0000_0100;
        3'b011 : d = 8'b0000_1000;
        3'b100 : d = 8'b0001_0000;
        3'b101 : d = 8'b0010_0000;
        3'b110 : d = 8'b0100_0000; 
        3'b111 : d = 8'b1000_0000;
        default: d = 8'hxx;
    endcase
end

//01 SEL
always @*begin
    if( ~i_r & i_t[0]) o_sel = PC;
    else if( ~i_r & i_t[1] ) o_sel = RAM;
    else if( ~i_r & i_t[2] ) o_sel = IR;
    else if( ~d[7] & ~i_r & i_t[3] ) o_sel = RAM;
    else if( i_r & i_t[0] ) o_sel = PC;
    else if( i_r & i_t[1] ) o_sel = TR;
    else if( d[0] & i_t[4] )o_sel = RAM;
    else if( d[1] & i_t[4] )o_sel = RAM;
    else if( d[2] & i_t[4] )o_sel = RAM;
    else if( d[3] & i_t[4] )o_sel = AC;
    else if( d[4] & i_t[4] )o_sel = AR;
    else if( d[5] & i_t[4] )o_sel = PC;
    else if( d[5] & i_t[5] )o_sel = AR;
    else if( d[6] & i_t[4] )o_sel = RAM;
    else if( d[6] & i_t[6] )o_sel = DR;
    else o_sel = AC;
end

//02 AR (LD, INR, CLR)
always @*begin
    if( ~i_r & i_t[0] ) o_ar = 3'b100;
    else if( ~i_r & i_t[2] ) o_ar = 3'b100; 
    else if( ~d[7] & i & i_t[3] ) o_ar = 3'b100;
    else if( i_r & i_t[0] ) o_ar = 3'b001;
    else if( d[5] & i_t[4] )o_ar = 3'b010;
    else o_ar = 3'b000;
end

//03 IR 
always @*begin
    if( ~i_r & i_t[1] ) o_ir = 1'b1;
    else o_ir = 1'b0;
end

//04 PC (LD, INR, CLR)
always @*begin
    if( ~i_s )                              o_pc = 3'b001;
    else if( ~i_r & i_t[1] )                o_pc = 3'b010;
    else if( i_r & i_t[1] )                 o_pc = 3'b001;
    else if( i_r & i_t[2] )                 o_pc = 3'b010;
    else if( d[4] & i_t[4] )                o_pc = 3'b100;
    else if( d[5] & i_t[5] )                o_pc = 3'b100;
    else if( d[6] & i_t[6] & (i_dr == 16'd0) ) o_pc = 3'b010;
    else if( r & i_ir[4] & ~i_ac[15])       o_pc = 3'b010; 
    else if( r & i_ir[3] &  i_ac[15])       o_pc = 3'b010;
    else if( r & i_ir[2] &  (i_ac == 16'd0))o_pc = 3'b010;  
    else if( r & i_ir[1] & ~i_e )           o_pc = 3'b010; 
    else if( p & i_ir[9] & i_fgi)           o_pc = 3'b010;
    else if( p & i_ir[8] & i_fgo)           o_pc = 3'b010;
    else o_pc = 3'b000;
end

//05 R (J, K) 
always @*begin
    if ( ~i_s ) o_r = 2'b01;
    else if( ~i_t[0] & ~i_t[1] & ~i_t[2] & i_ien & i_fgo & i_fgi ) o_r = 2'b10;
    else if( i_r & i_t[2] ) o_r = 2'b01;
    else o_r = 2'b11;
end

//06 TR (LD, INR, CLR)
always @*begin
    if( i_r & i_t[0] ) o_tr = 3'b100;
    else o_tr = 3'b000;
end

//07 RAM (R, W)
always @*begin
    if( ~i_r & i_t[1] )           o_ram = 2'b10;
    else if( ~d[7] & i & i_t[3] ) o_ram = 2'b10;
    else if( i_r & i_t[1] )       o_ram = 2'b01;
    else if( d[0] & i_t[4] )      o_ram = 2'b10;
    else if( d[1] & i_t[4] )      o_ram = 2'b10;
    else if( d[2] & i_t[4] )      o_ram = 2'b10;
    else if( d[3] & i_t[4] )      o_ram = 2'b01;
    else if( d[5] & i_t[4] )      o_ram = 2'b01;
    else if( d[6] & i_t[4] )      o_ram = 2'b10;
    else if( d[6] & i_t[6] )      o_ram = 2'b01;
    else o_ram = 2'b00;
end

//08 IEN (J, K)
always @*begin
    if( ~i_s )             o_ien = 2'b01;
    else if( i_r & i_t[2] )o_ien = 2'b01;
    else if( p & i_ir[7] ) o_ien = 2'b10;
    else if( p & i_ir[6] ) o_ien = 2'b01;
    else o_ien = 2'b11;
end

//09 SC
always @*begin
    if( i_r & i_t[2] )       o_sc = 1'b1;
    else if( d[0] & i_t[5] ) o_sc = 1'b1;
    else if( d[1] & i_t[5] ) o_sc = 1'b1;
    else if( d[2] & i_t[5] ) o_sc = 1'b1;
    else if( d[3] & i_t[4] ) o_sc = 1'b1;
    else if( d[4] & i_t[4] ) o_sc = 1'b1;
    else if( d[5] & i_t[5] ) o_sc = 1'b1;
    else if( d[6] & i_t[6] ) o_sc = 1'b1;
    else if( r )             o_sc = 1'b1;
    else if( p )             o_sc = 1'b1;
    else o_sc = 1'b0;
end

//10 DR (LD, INR, CLR)
always @*begin
    if( d[0] & i_t[4] )      o_dr = 3'b100;
    else if( d[1] & i_t[4] ) o_dr = 3'b100;
    else if( d[2] & i_t[4] ) o_dr = 3'b100;
    else if( d[6] & i_t[4] ) o_dr = 3'b100;
    else if( d[6] & i_t[5] ) o_dr = 3'b010;
    else o_dr = 3'b000;
end

//11 AC (LD, INR, CLR)
always @*begin
    if( d[0] & i_t[5] )      o_ac = 3'b100;
    else if( d[1] & i_t[5] ) o_ac = 3'b100;
    else if( d[2] & i_t[5] ) o_ac = 3'b100;
    else if( r & i_ir[11] )  o_ac = 3'b001;
    else if( r & i_ir[9])    o_ac = 3'b100;
    else if( r & i_ir[7])    o_ac = 3'b100;
    else if( r & i_ir[6])    o_ac = 3'b100;
    else if( r & i_ir[5])    o_ac = 3'b010;
    else if( p & i_ir[11] )  o_ac = 3'b100;
    else o_ac = 3'b000;
end

//12 ALU
always @*begin
    if( d[0] & i_t[5] )      o_alu = AND;
    else if( d[1] & i_t[5] ) o_alu = ADD;
    else if( d[2] & i_t[5] ) o_alu = T_DR;
    else if( r & i_ir[9])    o_alu = CMA;
    else if( r & i_ir[7])    o_alu = SHR;
    else if( r & i_ir[6])    o_alu = SHL;
    else if( p & i_ir[11])   o_alu = INPR;
    else o_alu = T_AC;    
end

//13 E {sel[1:0], reset, complement} 
//(00 = o_value, 01 = i_cout, 10 = ac[15], 11 = ac[0]) reset, complement
always @*begin
    if( d[1] & i_t[5] )   o_e = 4'b0100;
    else if( r & i_ir[10])o_e = 4'b0010;
    else if( r & i_ir[8]) o_e = 4'b0001;
    else if( r & i_ir[7]) o_e = 4'b1100;
    else if( r & i_ir[6]) o_e = 4'b1000; 
    else o_e = 4'b0000;
end

//14 S (J, K)
always @*begin
    if( reset ) o_s = 2'b01;
    else if( start )       o_s = 2'b10;
    else if( r & i_ir[0] ) o_s = 2'b01; 
    else o_s = 2'b11;
end

//15 FGI (J, K)
always @*begin
    if( ~i_s ) o_fgi = 2'b01;
    else if( p & i_ir[11] ) o_fgi = 2'b01;
    else if( i_fgi_on )o_fgi = 2'b10;
    else o_fgi = 2'b11;
end

//16 OUTR (LD)
always @*begin
    if( p & i_ir[10] ) o_outr = 1'b1;
    else o_outr = 1'b0;
end

//17 FGO (J, K)
always @*begin
    if( ~i_s ) o_fgo = 2'b01;
    else if( p & i_ir[10] ) o_fgo = 2'b01;
    else if( i_fgo_on )o_fgo = 2'b10;
    else o_fgo = 2'b11;
end

endmodule