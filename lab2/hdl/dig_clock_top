`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette college
// Engineer: Otieno Maurice
// 
// Create Date: 09/14/2023 01:54:55 PM
// Design Name: Digital clock
// Module Name: dig_clock
// Project Name: 
// Target Devices: NEXYS A7100T - Diligent devices
// Tool Versions: 
// Description: /*This module is the top module of the digital clock
 /*                 it takes in the time outputs and concatenates them with  a three bit value for display on the sevensegment decorder
                    the three bit value functions are s follows:
                    100 - blank the digit
                    000- display the digit but dont display decimal point
                    010- display digit with its decimal point
                    001 - display minus sign(-) instead of digit
*/
// Dependencies: 
// /
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module dig_clock(
 input logic clk, rst, adv_hr, adv_min,
 output logic [6:0] s0,s1,m1,m0,h0,h1,am_pm
); 


logic  [3:0] h11, h00, m11, m00, s11, s00,am_pm0;

always_comb begin
      am_pm = {3'b000,am_pm0};
      s0 = {3'b000,s00};
      s1 = {3'b000,s11};
      m0 = {3'b010,m00}; // make the decimal poit visible after the min
      m1 = {3'b000,m11};
      h0 = {3'b010,h00};  // make the decimal point vissible after the hr
     if(h11 != 0)
      h1 = {3'b000,h11};
      else h1 = {3'b100,h11};   // blank the first digit of the hr if its value is zero
   end

time_ctr U_TIME(.clk,.rst,.s0(s00),.s1(s11),.m0(m00),. m1(m11),.h1(h11),.h0(h00),.adv_min,.adv_hr,.am_pm(am_pm0));

endmodule: dig_clock
