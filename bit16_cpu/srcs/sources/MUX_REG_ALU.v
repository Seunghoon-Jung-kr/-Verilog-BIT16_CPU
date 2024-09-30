`timescale 1ns / 1ps
module MUX_REG_ALU(
    clk, sel,
    i_inpr, i_ram,
    ctl_alu, ctl_dr, ctl_ac, ctl_tr, ctl_ar, ctl_pc, ctl_ir, ctl_inpr, ctl_outr, ctl_r, ctl_ien, ctl_s, ctl_fgi, ctl_fgo, ctl_e,
    o_ir, o_ien, o_fgo, o_fgi, o_dr, o_ac, o_e, o_outr, o_r, o_s, o_ar, o_ram
);
input  wire        clk                      ;
input  wire [2:0]  sel                      ;
input  wire [7:0]  i_inpr                   ;
input  wire [15:0] i_ram                    ;
input  wire [2:0]  ctl_alu, ctl_dr, ctl_ac, ctl_tr, ctl_ar, ctl_pc;
input  wire        ctl_ir                   ;
input  wire        ctl_inpr, ctl_outr       ;
input  wire [1:0]  ctl_r, ctl_ien, ctl_s, ctl_fgi, ctl_fgo ;
input  wire [3:0]  ctl_e                    ;

output wire [15:0] o_ir                     ;
output wire        o_ien, o_fgo, o_fgi      ;
output wire [15:0] o_dr , o_ac              ;
output wire        o_e                      ;    
output wire [ 7:0] o_outr                   ;
output wire        o_r                      ;
output wire        o_s                      ;
output wire [11:0] o_ar                     ;
output wire [15:0] o_ram                    ;

wire [15:0] w_o_dr,
            w_o_ac,
            w_o_tr,
            w_o_ar,
            w_o_pc,
            w_o_ir,
            w_o_ram ;
wire [15:0] w_o_alu ;
reg  [15:0] r_mux   ;
wire [ 7:0] w_o_inpr;
wire        cout;

assign o_ir = w_o_ir;
assign o_dr = w_o_dr;
assign o_ac = w_o_ac;

//1.BUS
always @*begin
    case(sel)
        3'b000 : r_mux = w_o_dr;
        3'b001 : r_mux = w_o_ac;
        3'b010 : r_mux = w_o_tr;
        3'b011 : r_mux = w_o_ar;
        3'b100 : r_mux = w_o_pc;
        3'b101 : r_mux = w_o_ir;
        3'b110 : r_mux = i_ram;
        3'b111 : r_mux = w_o_dr;
        default: r_mux = 16'hxxxx;
    endcase
end

//2.Register
//DR, AC, TR
bit16_register_control3 DR   (r_mux,   ctl_dr[2], ctl_dr[1], ctl_dr[0], clk, w_o_dr); // (i_value, ld, inr, clr, clk, o_value);
bit16_register_control3 AC   (w_o_alu, ctl_ac[2], ctl_ac[1], ctl_ac[0], clk, w_o_ac);
bit16_register_control3 TR   (r_mux,   ctl_tr[2], ctl_tr[1], ctl_tr[0], clk, w_o_tr);
//AR, PC 
bit12_register_control3 AR   (r_mux,   ctl_ar[2], ctl_ar[1], ctl_ar[0], clk, w_o_ar); // (i_value, ld, inr, clr, clk, o_value);
bit12_register_control3 PC   (r_mux,   ctl_pc[2], ctl_pc[1], ctl_pc[0], clk, w_o_pc);
//IR
bit16_register_control_ld IR (r_mux,   ctl_ir,    clk,       w_o_ir)                ; // (i_value, ld, clk, o_value);
//OUTR, INPR
bit8_register_control_ld OUTR(r_mux,   ctl_outr,  clk,       o_outr)                ; // (i_value, ld, clk, o_value);
bit8_register_control_ld INPR(i_inpr,  ctl_inpr,  clk,       w_o_inpr)              ;
//R, IEN, S, FGI, FGO, E
bit1_register_jk R  (ctl_r[1]  , ctl_r[0]  , clk, o_r)  ; // (j,k,clk,o);
bit1_register_jk IEN(ctl_ien[1], ctl_ien[0], clk, o_ien);
bit1_register_jk S  (ctl_s[1]  , ctl_s[0]  , clk, o_s)  ;
bit1_register_jk FGI(ctl_fgi[1], ctl_fgi[0], clk, o_fgi);
bit1_register_jk FGO(ctl_fgo[1], ctl_fgo[0], clk, o_fgo);
bit1_register_e  E  (clk, ctl_e[3:2], cout, w_o_ac[15], w_o_ac[0], ctl_e[1], ctl_e[0], o_e); // (clk, i_sel, i_cout, i_ac_15, i_ac_0, i_reset, i_cm, o_value); 

//3.ALU
ALU alu(w_o_ac, w_o_dr, w_o_inpr, ctl_alu, o_e, w_o_alu, cout); // (i_ac, i_dr, i_inpr, sel, i_e, o_ac, o_e_cla);

//4.RAM
assign o_ram = r_mux;
assign o_ar  = w_o_ar;
endmodule
