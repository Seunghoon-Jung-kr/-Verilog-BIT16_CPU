`timescale 1ns / 1ps
module bit1_register_control_ld(i_value, ld, clk, o_value);
input  wire i_value, ld, clk;
output wire o_value;

reg  r_dff;
wire w_din;

 ///*
always @(posedge clk)
    r_dff <= w_din;
    
assign w_din = (i_value & ld) | (o_value & ~ld); 
assign o_value = r_dff;
//*/

/*
always @(posedge clk)begin
    if( ld )begin
        r_dff <= i_value;
    end
    else begin
        r_dff <= r_dff;
    end
end

assign o_value = r_dff;
*/
endmodule
