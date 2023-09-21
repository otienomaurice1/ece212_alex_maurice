`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2023 10:39:04 PM
// Design Name: 
// Module Name: sevenseg_ctl_top
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


module sevenseg_ctl_top(
input logic clk, rst,
output logic [7:0] an_n, 
output logic [6:0] segs_n,
output logic dp_n
    );
    logic [6:0] d0,d1,d2,d3,d4,d5,d6,d7;
    always_comb begin
    d0= 7'b010_1111;
    d1= 7'b010_0010;
    d2= 7'b010_1011;
    d3= 7'b010_0110;
    d4= 7'b010_1111;
    d5= 7'b010_0011;
    d6= 7'b010_0100;
    d7= 7'b010_0111;
   end
   sevenseg_ctl U_CTL(.d0,.d1,.d2,.d3,.d4,.d5,.d6,.d7,.an_n,.segs_n,.rst,.clk,.dp_n);
endmodule
