//--------------------------------------------------------------
// alu.sv - functional model of MIPS ALU for simulation purposes
// Remove this file for ECE 212 MIPS Labs
// John Nestor nestorj@lafayette.edu May 2018
// Added to refactored MIPS Single Cycle design
// Students in lab will replace this with their structural ALU
//--------------------------------------------------------------

module alu(
    input logic signed [31:0] a, b,
    input logic [2:0] f,
    output logic signed [31:0] y,
    output logic zero
    );

   always_comb
  begin
    case (f)
      3'b000 : y = a & b; //AND
      3'b001 : y = a | b; //OR
      3'b010 : y = a + b; //ADD
      3'b100 : y = a & ~b;
      3'b101 : y = a | ~b;
      3'b110 : y = a - b; // SUBTRACT
      3'b111 : if (a < b) y = 32'd1; 
               else y = 32'd0; //SLT      
      default : y = 'x;
   endcase
   if (y == 32'd0) zero = 1;
   else zero = 0;
 end    
    
endmodule
