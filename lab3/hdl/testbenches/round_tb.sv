`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2023 09:25:47 PM
// Design Name: 
// Module Name: tdisplay_tb
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


module round_tb;
    logic [16:0] tx10_mag;
    logic [12:0] tx10_mag_r;
    //duv
    round DUV(.tx10_mag,.tx10_mag_r);
    initial begin
   tx10_mag = -17'd256; #10;
   tx10_mag = -17'd156; #10;
   tx10_mag = -17'd20; #10;
   tx10_mag = 17'd0; #10;
   tx10_mag = 17'd156; #10;
   tx10_mag = 17'd255; #10;
   $stop;
   end
endmodule