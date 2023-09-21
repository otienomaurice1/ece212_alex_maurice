`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 02:39:14 PM
// Design Name: 
// Module Name: hr
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


module hr(
input logic clk, rst, cy3,   // take in clock, reset and enable signal cy3
output [3:0]h1, h0, am_pm    // declare three outputs for the first and second digit of the hr and one for the am_pm functionality
    );
    logic cy;
     logic [7:0] l; 
    logic [3:0] hr_12_0;   // rceives the hr value from the counter
    logic [3:0] k,o,p;
    counter_rc_mod #(.MOD(12))U_D0SEC(.clk,.rst,.enb(cy3),.q(hr_12_0),.cy); // instantiate the counter 
    always_comb
   if (hr_12_0 == 0)  k = 4'd12;  // if hr == 0, change it 12 else retain the value of hr
   else  k =  hr_12_0;
     
    always_ff @(posedge clk)
    if(rst) o <= 4'd12;
    else o <= k;
       assign l = {{4'b0000},o};          // make hr an eight bit value
    dbl_dabble U_HR(.b(l),.hundreds(p),.tens(h1),.ones(h0));  // convert hr to its binary coded decimal equvalent
endmodule: hr
 