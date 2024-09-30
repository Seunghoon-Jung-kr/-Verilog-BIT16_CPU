`timescale 1ns / 1ps
module bit1_register_e(clk, i_sel, i_cout, i_ac_15, i_ac_0, i_reset, i_cm, o_value);
input  wire [1:0] i_sel;
input  wire       clk, i_cout, i_ac_15, i_ac_0, i_reset, i_cm;
output wire       o_value;
reg r_o_mux, r_dff;
always @*begin
    case(i_sel)
        2'b00 :   r_o_mux = o_value;
        2'b01 :   r_o_mux = i_cout;
        2'b10 :   r_o_mux = i_ac_15;
        2'b11 :   r_o_mux = i_ac_0;
        default : r_o_mux = 1'bx;
    endcase
end

always @(posedge clk)begin
    if( i_reset )
        r_dff <= 1'b0;
    else if( i_cm )
        r_dff <= ~r_dff;
    else
        r_dff <= r_o_mux;
end

assign o_value = r_dff;
endmodule
