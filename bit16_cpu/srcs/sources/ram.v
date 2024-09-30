`timescale 1ns / 1ps
module ram(
input  wire        clk       ,
input  wire [15:0] i_data    ,
input  wire [11:0] i_adrr    ,
input  wire [ 1:0] i_ctl_ram ,

input wire         reset,

output wire [15:0] o_data      
    );
reg [15:0] i_ram;
reg [15:0] data;
parameter CLA = 16'h7800, CLE = 16'h7400, CMA = 16'h7200, CME = 16'h7100,
          CIR = 16'h7080, CIL = 16'h7040, INC = 16'h7020, SPA = 16'h7010,
          SNA = 16'h7008, SZA = 16'h7004, SZE = 16'h7002, HLT = 16'h7001,
          INP = 16'hF800, OUT = 16'hF400, SKI = 16'hF200, SKO = 16'hF100,
          ION = 16'hF080, IOF = 16'hF040; 
// ADD ( 10 + 5 )
/*
    always @*begin
    case(i_adrr)
        0 : i_ram = 16'b0010_0000_0000_0010;
        1 : i_ram = 16'b0001_0000_0000_0011;
        2 : i_ram = 16'b0000_0000_0000_1010;
        3 : i_ram = 16'b0000_0000_0000_0101;
        default : i_ram = 16'hxxxx;
    endcase
end
*/
/*
// AND
    always @*begin
    case(i_adrr)
        0 : i_ram = 16'b0010_0000_0000_0010;
        1 : i_ram = 16'b0000_0000_0000_0011;
        2 : i_ram = 16'b0000_0000_1111_1010;
        3 : i_ram = 16'b0000_0000_1111_0101;
        default : i_ram = 16'hxxxx;
    endcase
end
*/
/*
// STA
    always @*begin
    case(i_adrr)
        0 : i_ram = 16'b0010_0000_0000_0010;
        1 : i_ram = 16'b0011_0000_0000_0011;
        2 : i_ram = 16'b0000_0000_1111_0000;
        3 : i_ram = 16'b0000_0000_1111_0101;
        default : i_ram = 16'hxxxx;
    endcase
end
always @(posedge clk)begin
    if( i_adrr == 12'd3 || i_ctl_ram == 2'b01) data <= i_data;
    else              data <= data;
end
*/
/*
// BSA
always @*begin
    case(i_adrr)
        0 : i_ram = 16'b0101_0000_0000_0100;
        default : i_ram = 16'hxxxx;
    endcase
end
always @(posedge clk)begin
    if( i_adrr == 12'd4 || i_ctl_ram == 2'b01) data <= i_data;
    else              data <= data;
end
*/
/*
// ISZ, HLT
always @*begin
    case(i_adrr)
        0 : i_ram = 16'b0110_0000_0000_0011; // ISZ 3
        1 : i_ram = 16'b0100_0000_0000_0000; // BUN 0
        2 : i_ram = 16'b0111_0000_0000_0001; // HLT
        default : i_ram = 16'hxxxx;
    endcase
end
always @(posedge clk)begin
    if( reset ) data <= 16'b1111_1111_1111_1100;
    else if( i_adrr == 12'd3 && i_ctl_ram == 2'b01 ) data <= i_data;
    else              data <= data;
end
assign o_data = i_adrr[1] ? (i_adrr[0] ? data : i_ram) : i_ram;
*/
/*
// CLA, CLE, CMA, CME
always @*begin
    case(i_adrr)
        0 : i_ram = 16'b0111_1000_0000_0000; // CLA
        1 : i_ram = 16'b0111_0100_0000_0000; // CLE
        2 : i_ram = 16'b0111_0010_0000_0000; // CMA
        3 : i_ram = 16'b0111_0001_0000_0000; // CME
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
// CIR, CIL
always @*begin
    case(i_adrr)
        0 : i_ram = 16'b0111_0100_0000_0000; // CLE
        1 : i_ram = 16'b0010_0000_0000_0100; // LDA
        2 : i_ram = 16'b0111_0000_1000_0000; // CIR ( => 0111_1111_1111_1111 )
        3 : i_ram = 16'b0111_0000_0100_0000; // CIL 
        4 : i_ram = 16'b1111_1111_1111_1111;
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
//INC, SPA, SNA
always @*begin
    case(i_adrr)
        0 : i_ram = CLA;
        1 : i_ram = SPA;
        2 : i_ram = HLT;
        3 : i_ram = CMA;
        4 : i_ram = SNA;
        5 : i_ram = 16'h4000; //BUN 0
        6 : i_ram = INC;
        7 : i_ram = HLT;
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
//SZA, SZE
always @*begin
    case(i_adrr)
        0 : i_ram = SZA;
        1 : i_ram = CLA;
        2 : i_ram = SZA;
        3 : i_ram = 16'hxxxx; //Error
        4 : i_ram = SZE;
        5 : i_ram = CLE;
        6 : i_ram = SZE;
        7 : i_ram = 16'hxxxx; //Error
        8 : i_ram = HLT;
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
//Indirect
always @*begin
    case(i_adrr)
        0 : i_ram = 16'ha001;
        1 : i_ram = 16'h0000;
        2 : i_ram = HLT;
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
//INP, OUT
always @*begin
    case(i_adrr)
        0 : i_ram = INP;
        1 : i_ram = OUT;
        2 : i_ram = HLT;
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
//SKI, SKO
always @*begin
    case(i_adrr)
        0 : i_ram = SKI;
        1 : i_ram = HLT;
        2 : i_ram = SKO;
        3 : i_ram = HLT;
        4 : i_ram = 16'h4000; // BUN 0
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
//ION, IOF
always @*begin
    case(i_adrr)
        0 : i_ram = ION;
        1 : i_ram = IOF;
        2 : i_ram = HLT;
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
/*
//Interrupt
always @*begin
    case(i_adrr)
        0 : i_ram = ION; // After this, a cycle enter the interrupt cycle
        1 : i_ram = ION;
        2 : i_ram = HLT;
        default : i_ram = 16'hxxxx;
    endcase
end

assign o_data = i_ram;
*/
endmodule
