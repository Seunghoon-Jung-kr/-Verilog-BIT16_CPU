`timescale 1ns / 1ps
module tb();
reg clk;
reg [15:0] i_inpr;
reg        ctl_inpr;
wire [15:0] i_ram;
reg start, reset;
wire [11:0] o_adr;
wire [15:0] o_ram;
wire [15:0] o_data;
wire [1:0]  ctl;
reg         fgo, fgi;
always #5 clk = ~clk;
CPU DUT(
    .clk(clk),
    .i_ram(o_data),
    .start(start), 
    .reset(reset),
    .o_ctl_ram(ctl),
    .o_ram(o_ram),
    .o_adr(o_adr),
    .i_inpr(i_inpr),
    .i_ctl_inpr(ctl_inpr),
    .i_fgi_on(fgi),
    .i_fgo_on(fgo)
);
ram DUTT(
.clk(clk),
.i_data(o_ram),
.i_adrr(o_adr),
.i_ctl_ram(ctl),
.o_data(o_data),
.reset(reset)      
);

initial begin
clk = 0;
reset = 1;
start = 0;
i_inpr = 8'b1010_1010;
ctl_inpr = 1'b1;
//fgi setting, you can chaing if you'd like to see the INTERRUPT, SKI, SKO
fgi = 1;
fgo = 1;
#10
ctl_inpr = 1'b0;
reset = 0;
#100
start = 1;
#10
start = 0;
end
endmodule
