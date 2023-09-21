`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2023 01:49:53 PM
// Design Name: 
// Module Name: sevenseg_ext_top
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


module sevenseg_ext_n(
input logic [6:0] data,
output logic dp_n,
output logic [7:0] an_n,
output logic [6:0]segs_n

    );
    assign an_n = 8'b11111110;
    sevenseg_ext U_EXTENDED(.d(data), .dp_n,.segs_n);
endmodule