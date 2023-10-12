`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 04:26:06 PM
// Design Name: 
// Module Name: time_ctr
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

module time_ctr(
input logic rst, clk ,adv_min, adv_hr,
output logic [3:0] s0,s1, m0, m1,h1,h0,am_pm
    );
 
  logic cy;
    hr U_HR(.clk,.rst,.h1,.h0,.cy3(cy),.adv_hr,.am_pm);
    min_sec U_MINSEC(.rst, .clk,.s0,.s1,.m0,.m1,.cy3(cy),.adv_hr,.adv_min);
endmodule
