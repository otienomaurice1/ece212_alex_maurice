`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2023 02:42:18 PM
// Design Name: 
// Module Name: sevenseg_ext_tb
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


module sevenseg_ext_tb;

logic [6:0] data;
logic [6:0] segs_n;
logic dp_n;

sevenseg_ext DUV(.d(data), .dp_n, .segs_n);
initial begin
data = 7'b100_0000;  #10; // (BLANK) WHEN D[6] IS ACTIVE HIGH AND NO DATA INPUT
data  = 7'b100_0110; #10; // BLANK but with DATA TO BE DISPLAYED FED
data = 7'b010_0000;  #10; // NOT BLANKED. DECIMAL POINT ASSERTED WITH NO DATA TO BE DISPLAYED
data = 7'b011_0000;  #10; // DECIMAL POINT ASSERTED AND d[5] ASSSERTED - displaying minus sign
data = 7'b011_1000;  #10; // DISPLAYING THE MINUS SIGN AND DECIMAL POINT
data = 7'b001_1000;  #10; // DISPLAYING THE MINUS SIGN WITHOUT THE DECIMAL POINT
data = 7'b001_1000;  #10; // DISPLAYING THE MINUS SIGN WHEN d[4] IS ASSERTED EVEN IF WE HAVE DATA TO BE DISPLAYED
data = 7'b010_0001;  #10; // DISPLAYING THE NUMBER 1 WITH THE DECIMAL POINT
data = 7'b000_0001;  #10; // DISPLAYING THE NUMBER 1 WITHOUT THE DECIMAL POINT
data = 7'b010_0010;  #10; // DISPLAYING THE NUMBER 1
data = 7'b010_0011;  #10; // DISPLAYING THE NUMBER 1
data = 7'b010_0100;  #10; // DISPLAYING THE NUMBER 1
data = 7'b010_0101;  #10; // DISPLAYING THE NUMBER 1
data = 7'b010_0110;  #10; // DISPLAYING THE NUMBER 1
data = 7'b010_0111;  #10; // DISPLAYING THE NUMBER 1
data = 7'b010_1000;  #10; // DISPLAYING THE NUMBER 1
data = 7'b010_1000;  #10; // DISPLAYING THE LETTER A
data = 7'b010_1000;  #10; // DISPLAYING THE LETTER P
data = 7'b010_1000;  #10; // DISPLAYING THE LETTER C
data = 7'b010_1111;  #10; // DISPLAYING THE LETTER F

$stop;
end
endmodule
