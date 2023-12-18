`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette college
// Engineer: Otieno Maurice
// 
// Create Date: 12/17/2023 09:28:28 PM
// Design Name: 
// Module Name: tconvert_tb
// Project Name: 
// Target Devices: NEXYSA7100T 
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
  //instantiate DUV
  tconvert   DUV( .tc(tc),.cf(cf),.tx10(tx10));
  //give a set of values
  // the positive and negative values of specific decimal numbers within the range 
  //-256 to 255 are chosen for easier comparison
  initial begin
   cf = 0;
   tc = -9'd256; #10;
   tc = -9'd156; #10;
   tc = -9'd20; #10;
   cf = 1;
   tc = -9'd256; #10;
   tc = -9'd156; #10;
   tc = -9'd20; #10;
   cf = 0;
   tc = 9'd0; #10;
   tc = 9'd156; #10;
   tc = 9'd255; #10;
   cf = 1;
   tc = 9'd0; #10;
   tc = 9'd156; #10;
   tc = 9'd255; #10;
   $stop;
   end
    
endmodule
