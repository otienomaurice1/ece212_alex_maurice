`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2023 09:28:28 PM
// Design Name: 
// Module Name: tconvert_tb
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

module tconvert_tb;
  logic signed [12:0] tc ;
  logic cf;
  logic signed [17:0] tx10;
  tconvert   DUV( .tc(tc),.cf(cf),.tx10(tx10));
  
  initial begin
   tc = 13'd234; cf = 1'b1; #20;
   tc = 13'd134; cf = 1'b1; #20;
   tc = 13'd24; cf = 1'b0; #20;
   tc =  13'd4; cf = 1'b0; #20;
   tc = 13'd234; cf = 1'b1; #20;
   
 // always begin
 // for(int i = -9'd256; i< 9'd256; i++)
 // tc = i;#5;
 end
endmodule
