`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
// Company: Lafayette college
// Engineer: Otieno Maurice
// 
// Create Date: 09/02/2023 01:50:49 PM
// Design Name: Seven segment display controller
// Module Name: sevenseg_ext
// Project Name: 
// Target Devices: NEXYS17 100T FPGA
// Tool Versions: 
//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//---------------------------------------------------------------------------------
//----------------------------------------------------------------------------------



module sevenseg_ext(
input logic  [6:0] d,
output logic [6:0] segs_n,
output logic dp_n

    );
    logic [3:0] data;
    assign data = d[3:0];   // isolate the first four bits (The data bits ) from the last three bits (Control bits)
  always_comb 
  begin
  if(d[6]) begin
        segs_n = 7'b1111111;
        dp_n = '1;
        end     
  else begin
  
  if(d[5]) 
  dp_n = 0;
  else dp_n = 1;
  
  
  if(d[4]) 
   segs_n = 7'b0111111;
   else  begin
   case(data)                   // use the data bits to decode values of segs_n
   4'd1: segs_n = 7'b1111001;
   4'd2: segs_n = 7'b0100100;
   4'd3: segs_n = 7'b0110000;
   4'd4: segs_n = 7'b0011001;
   4'd5: segs_n = 7'b0010010;
   4'd6: segs_n = 7'b0000010;
   4'd7: segs_n = 7'b1111000;
   4'd8: segs_n = 7'b0000000;
   4'd9: segs_n = 7'b0011000;
   4'd10: segs_n = 7'b0001000;
   4'd11: segs_n = 7'b0001100;
   4'd12: segs_n = 7'b1000110;
   4'd15: segs_n = 7'b0001110;
   default: segs_n = 7'b1111111;

   endcase
   end 
   end   
   end
   endmodule: sevenseg_ext
    
   
       
  

