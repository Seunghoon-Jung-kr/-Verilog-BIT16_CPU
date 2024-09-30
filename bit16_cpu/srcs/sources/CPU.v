`timescale 1ns / 1ps
module CPU(
    input  wire clk,
    input  wire [ 7:0] i_inpr,
    input  wire [15:0] i_ram,
    input  wire        i_ctl_inpr,
    input  wire        start, reset,
    input  wire        i_fgi_on, i_fgo_on,
    output wire [ 1:0] o_ctl_ram,
    output wire [ 7:0] o_outr,
    output wire [15:0] o_ram,
    output wire [11:0] o_adr
);

wire [2:0] w_sel;
wire       w_s;
wire [2:0] w_ctl_alu, w_ctl_dr;
wire       w_ctl_sc;
wire [6:0] w_t;
wire [2:0] w_ctl_ac, w_ctl_tr, w_ctl_ar, w_ctl_pc;
wire       w_ctl_ir, w_ctl_outr;
wire [1:0] w_ctl_r, w_ctl_ien, w_ctl_s, w_ctl_fgi, w_ctl_fgo;
wire [3:0] w_ctl_e;

wire [15:0] w_ir;
wire        w_ien, w_fgi, w_fgo;
wire [15:0] w_dr;
wire [15:0] w_ac;
wire        w_e;
wire        w_r;

MUX_REG_ALU u_alu(
    .clk(clk),
    .i_inpr(i_inpr),
    .i_ram(i_ram),
    .sel(w_sel),
    .ctl_alu(w_ctl_alu),
    .ctl_dr(w_ctl_dr),
    .ctl_ac(w_ctl_ac),
    .ctl_tr(w_ctl_tr),
    .ctl_ar(w_ctl_ar),
    .ctl_pc(w_ctl_pc),
    .ctl_ir(w_ctl_ir),
    .ctl_inpr(i_ctl_inpr),
    .ctl_outr(w_ctl_outr),
    .ctl_r(w_ctl_r),
    .ctl_ien(w_ctl_ien),
    .ctl_s(w_ctl_s),
    .ctl_fgi(w_ctl_fgi),
    .ctl_fgo(w_ctl_fgo),
    .ctl_e(w_ctl_e),
    
    .o_s(w_s),
    .o_ir(w_ir),
    .o_ien(w_ien),
    .o_fgo(w_fgo),
    .o_fgi(w_fgi),
    .o_dr(w_dr),
    .o_ac(w_ac),
    .o_e(w_e),
    .o_outr(o_outr),
    .o_r(w_r),
    .o_ar(o_adr),
    .o_ram(o_ram)
);
CU u_cu(
    .o_sel(w_sel),
    .o_alu(w_ctl_alu),
    .o_dr(w_ctl_dr),
    .o_sc(w_ctl_sc),
    .o_ac(w_ctl_ac),
    .o_tr(w_ctl_tr),
    .o_ar(w_ctl_ar),
    .o_pc(w_ctl_pc),
    .o_ir(w_ctl_ir),
    .o_outr(w_ctl_outr),
    .o_r(w_ctl_r),
    .o_ien(w_ctl_ien),
    .o_s(w_ctl_s),
    .o_fgi(w_ctl_fgi),
    .o_fgo(w_ctl_fgo),
    .o_e(w_ctl_e),
    
    .reset(reset),
    .start(start),
    .i_t(w_t),
    .i_ir(w_ir),
    .i_ien(w_ien),
    .i_fgi(w_fgi),
    .i_fgo(w_fgo),
    .i_dr(w_dr),
    .i_ac(w_ac),
    .i_e(w_e),
    .i_r(w_r),
    .o_ram(o_ctl_ram),
    .i_s(w_s),
    .i_fgi_on(i_fgi_on),
    .i_fgo_on(i_fgo_on)
);
    
SC u_sc(
    .clk(clk),
    .i_s(w_s),
    .i_ctl(w_ctl_sc),
    .o_t(w_t)
);


endmodule
