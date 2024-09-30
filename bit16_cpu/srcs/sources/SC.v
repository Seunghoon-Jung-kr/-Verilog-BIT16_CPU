`timescale 1ns / 1ps
module SC(i_s, i_ctl, clk, o_t);
input  wire i_s, i_ctl;
input  wire clk;
output wire [6:0] o_t;

reg  [2:0] r_o_counter;
reg  [8:0] w_o_t;
wire       w_clr;
//1.MUX
always @*begin
    case(r_o_counter)
        3'b000 : w_o_t = 8'b0000_0001;
        3'b001 : w_o_t = 8'b0000_0010;
        3'b010 : w_o_t = 8'b0000_0100;
        3'b011 : w_o_t = 8'b0000_1000;
        3'b100 : w_o_t = 8'b0001_0000;
        3'b101 : w_o_t = 8'b0010_0000;
        3'b110 : w_o_t = 8'b0100_0000;
        3'b111 : w_o_t = 8'b1000_0000;
        default : w_o_t = 8'b0000_0001;
    endcase
end
assign o_t = w_o_t[6:0];

//2.Counter
always @(posedge clk)begin
    if(w_clr)   r_o_counter <= 0;
    else        r_o_counter <= r_o_counter + 1;
end

//3. Combi
assign w_clr = ~i_s | (i_s & i_ctl) | w_o_t[6];
endmodule
