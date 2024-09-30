`timescale 1ns / 1ps
module ALU(i_ac, i_dr, i_inpr, sel, i_e, o_ac, o_e_cla);
input  wire [15:0] i_ac    ; 
input  wire [15:0] i_dr    ;
input  wire [ 7:0] i_inpr  ;
input  wire [ 2:0] sel     ;
input  wire        i_e     ;
output wire [15:0] o_ac    ;
output wire        o_e_cla ;
reg  [15:0] r_mux   ;
wire        cin     ;
wire [15:0] w_o_cla ;
wire [15:0] w_o_shft;
// Adder (sel, cin, i_a, i_b, o_s, cout)
assign cin = 1'b0;
bit16_cla cla(sel, cin, i_ac, i_dr, w_o_cla, o_e_cla);

// Shifter (e, i_ac, sel, o_value)
bit16_shifter sht(i_e, i_ac, sel, w_o_shft);

//8x1 MUX
always @*begin
    case(sel)
        3'b000 : r_mux = i_ac & i_dr;
        3'b001 : r_mux = w_o_cla;
        3'b010 : r_mux = i_dr;
        3'b011 : r_mux = ~i_ac;
        
        3'b100 : r_mux = w_o_shft;
        3'b101 : r_mux = w_o_shft;
        3'b110 : r_mux = {{8{1'b0}}, i_inpr};
        3'b111 : r_mux = i_ac;
        default: r_mux = 16'hxxxx;
    endcase
end
assign o_ac = r_mux;
endmodule
