`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 12:14:30 AM
// Design Name: 
// Module Name: clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock (
  input logic clk, rst, dv_hr, adv_min,
  output logic [6:0]segs_n,
  output logic [7:0] an_n,
  output logic dp_n
    );
    logic [3:0] s00,s11,h00,h11,m00,m11,am_pm0; 
    logic [6:0] s0, s1, m0, m1, h0, h1;
     assign am_pm = {{3'b000},am_pm0};
     assign s0 = {{3'b000},s00};
     assign s1 = {{3'b000},s11};
     assign m0 = {{3'b010},m0};
     assign m1 = {{3'b000},m1};
     assign h0 = {{3'b010},h0};
    
     always_comb 
     if(h11 != 0)
      h1 = {{3'b000},h11};
      else h1 = {{3'b100},h11};
      
      
dig_clock U_DIG(.am_pm(am_pm0),.rst,.clk,.h0(h00),.h1(h11),.m1(m11),.m0(m00),.s1(s11),.s0(s00));
sevenseg_ctl U_SEVENSEG( .clk, .rst,.d0(am_pm),.d1(7'b1000000),.d2(s0) ,.d3(s1),.d4(m0),.d5(m1),.d6(h0),.d7(h1),.an_n,.dp_n ,.segs_n);
endmodule
