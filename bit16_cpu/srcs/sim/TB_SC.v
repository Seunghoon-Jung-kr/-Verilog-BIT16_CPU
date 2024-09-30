`timescale 1ns / 1ps
module TB_SC();
reg i_s, i_ctl, clk;
wire [6:0] o_t;

SC DUT(i_s, i_ctl, clk, o_t);
always #5 clk = ~clk;
initial begin
clk = 0;
i_s = 0;
i_ctl = 0;
#10
i_s = 0;
i_ctl = 1;
#10
i_s = 1;
i_ctl = 1;
#10
i_s = 1;
i_ctl = 0;
#140
$finish;
end
endmodule
