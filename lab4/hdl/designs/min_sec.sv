`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 01:54:55 PM
// Design Name: 
// Module Name: min_sec
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


module min_sec (
input logic rst, clk,adv_min,adv_hr,
output logic  cy3,
output logic [3:0] s0,s1, m0, m1
    );
      logic cy1, cy2,cy0, pe_enb;
    assign pe_enbs = (~adv_min&pe_enb&~adv_hr);
  assign pe_enbm = ((pe_enb&adv_min)|cy1);
    period_enb  #(.PERIOD_MS(1000)) U_ENB(.rst,.clk,.enb_out(pe_enb),.clr(1'b0));
    counter_rc_mod #(.MOD(10))U_D0SEC(.clk,.rst,.enb(pe_enbs),.q(s0),.cy(cy0));
    counter_rc_mod #(.MOD(6))U_D1SEC(.clk,.rst,.enb(cy0),.q(s1),.cy(cy1));
    counter_rc_mod #(.MOD(10))U_D2MIN(.clk,.rst,.enb(pe_enbm),.q(m0),.cy(cy2));
    counter_rc_mod #(.MOD(6))U_D3MIN(.clk,.rst,.enb(cy2),.q(m1),.cy(cy3));
endmodule
