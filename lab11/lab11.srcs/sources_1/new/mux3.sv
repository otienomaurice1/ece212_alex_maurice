`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alex Villalba
// 
// Create Date: 12/01/2023 12:51:04 PM
// Design Name: 
// Module Name: mux3
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

module mux3#(parameter WIDTH = 8)(
input logic [WIDTH-1:0] d0, d1, d2,
input logic [1:0] s,
output logic [WIDTH-1:0] y);

assign y = s[1] ? (s[0] ? d1 : d0) : d2;
endmodule