`timescale 1ns / 1ps
module bit1_register_jk(j,k,clk,o);
input j,k,clk;
output o;

reg r;
wire [1:0] t;
assign t = {j,k};
always @(posedge clk)begin
    case(t)
        2'b00 : r <= r;
        2'b01 : r <= 1'b0;
        2'b10 : r <= 1'b1;
        2'b11 : r <= r;
        default : r <= 1'bx;
    endcase
end

assign o = r;
endmodule
