
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 03:18:41 PM
// Design Name: 
// Module Name: tconvert
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

module  tconvert(
   input logic signed [12:0] tc,
   input logic cf,
   output logic signed [17:0] tx10);
   logic signed [17:0] tx16, tx8, tx2;
   
   assign tx16 = tc << 4;
   assign tx8 = tc << 3;
   assign tx2 = tc << 1;
 
 
always_comb begin
if(cf) 
  tx10 = tx16 + tx2 +{14'd320,4'd0}; // multiply by 18 and add 320    
 else 
  tx10 = tx8 + tx2;  // multiply  by 10
            end
endmodule