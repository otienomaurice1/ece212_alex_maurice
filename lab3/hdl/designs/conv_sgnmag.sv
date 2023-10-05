`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 03:50:39 PM
// Design Name: 
// Module Name: conv_sgnmag
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
module  conv_sgnmag(
   input logic signed  [17:0] tx10,
   output logic tx10_sign,
   output logic unsigned [16:0] tx10_mag);
   logic [17:0] conv;
always_comb begin
conv  = ~(tx10)+18'd1 ;
    if(tx10[17]) begin
     tx10_sign = 1'b1;
     tx10_mag = conv[16:0];
 end
   else begin
    tx10_sign = tx10[17];
    tx10_mag = tx10[16:0]; 
  end
 end
endmodule




