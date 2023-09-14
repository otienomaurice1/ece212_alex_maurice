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
input logic clk, rst, cy3,
output [3:0]h1, h0
    );
     
    logic [3:0] hr_12_0;
    logic [3:0] k,l,m,n,o,p;
    counter_rc_mod #(.MOD(12))U_D0SEC(.clk,.rst,.enb(cy3),.q(hr_12_0),.cy(1'b0));
    always_comb
   if (hr_12_0 == 0) k = 4'd12;
   else  k =  hr_12_0;
   
    assign l ={4'b0000,k};
    dbl_dabble U_HR(.b(l),.hundreds(4'b0),.tens(m),.ones(n));
    
    always_ff @(posedge clk)
    if(rst) begin
       o <= 4'd2;
       p <= 4'd1;
    end
    else begin 
    o <= n;
    p <= m;
    end
    
    assign h1 = p;    
    assign h0 = o;
endmodule: hr
 