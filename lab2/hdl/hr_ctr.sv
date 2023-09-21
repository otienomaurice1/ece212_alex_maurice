`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 03:45:01 PM
// Design Name: 
// Module Name: hr_ctr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hr_ctr(
input logic clk, rst, enb,
output logic cy,
output logic [3:0] h1,h0
    );
    logic [3:0] hrct;
    always_ff @(posedge clk)
   
    if(rst) begin
        h1 = 4'd1;
        h0 = 4'd2;
    end
    else if (enb) begin
    if (h1 == 4'd1 && h0 == 4'd2) begin
    h1 <= 0;
    h0 <= 1;
    end
    
    else if (h1 == 4'd0 && h0 == 4'd9) begin
    h1 <= 1;
    h0 <= 0;
    end
    end
endmodule: hr_ctr
