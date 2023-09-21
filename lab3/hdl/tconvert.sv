`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 03:18:41 PM
// Design Name: 
// Module Name: tconvert
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

module  tconvert(
   input logic [12:0] tc,
   input logic cf,
   output logic [17:0] tx10);
 logic [17:0] tc_32;
always_comb begin
  tc_32 = tc << 4 + tc<<3 +tc<<1 +320; // multiply by 18 and add 320
           if(cf) 
           tx10 = tc_32 << 3 + tc_32 <<1;  // multiply by 10
            else 
           tx10 = tc <<3+ tc <<1;  // multiply  by 10
            end

endmodule