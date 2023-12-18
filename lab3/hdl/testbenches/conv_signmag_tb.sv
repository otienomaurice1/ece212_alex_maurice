`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette colle
// Engineer: Otieno Maurice
// 
// Create Date: 12/17/2023 09:25:47 PM
// Design Name: 
// Module Name: tdisplay_tb
// Project Name: 
// Target Devices: NAXYSA7 100T
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


module conv_sgnmag_tb;
   logic signed  [17:0] tx10;
   logic tx10_sign;
   logic unsigned [16:0] tx10_mag;
    //duv
   conv_sgnmag DUV(.tx10,.tx10_sign,.tx10_mag);
    initial begin
    //NEGATIVE VALUES
   tx10 = -18'd256; #10;
   tx10 = -18'd156; #10;
   tx10 = -18'd156; #10;
   tx10 = -18'd20; #10;
   //POSITIVE VALUES
   tx10 = 18'd0; #10;
   tx10 = 18'd20; #10;
   tx10 = 18'd156; #10;
   tx10 = 18'd156; #10;
   tx10 = 18'd255; #10;
   $stop;
   end
endmodule