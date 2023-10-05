`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 12:14:30 AM
// Design Name: 
// Module Name: dig_clock_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Combines the digital clock with the seven segment controller for display
//              interfaces with the fpga
// 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dig_clock_top(
  input logic clk, rst, adv_hr, adv_min,
  output logic [6:0]segs_n,
  output logic [7:0] an_n,
  output logic dp_n
    );
  logic [6:0] s0,s1,m1,m0,h0,h1,am_pm;
      
dig_clock U_DIG(.am_pm,.rst,.clk,.h0,.h1,.m1,.m0,.s1,.s0,.adv_min,.adv_hr);

sevenseg_ctl U_SEVENSEG( .clk, .rst,.d0(am_pm),.d1(7'b1000000),.d2(s0) ,.d3(s1),.d4(m0),.d5(m1),.d6(h0),.d7(h1),.an_n,.dp_n ,.segs_n);
endmodule: dig_clock_top
