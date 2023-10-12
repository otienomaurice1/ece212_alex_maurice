`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette college
//--------------------------------------------------------------------------------
//---Engineer: Otieno Maurice -------------------------------------------------
// 
// Create Date: 09/28/2023 01:44:55 PM
// Design Name: 
// Module Name: tdisplay
// Project Name: 
// Target Devices: NEXYSA7- 100T
// Tool Versions: 
 //--------------------------------------------------------------------------
// Description: This module connects all the four modules necessary to display 
//              the binary coded decimal value   of the temperature
//---------------------------------------------------------------------------            
 

module tdisplay(
    input logic signed [12:0] tc,
    input logic c_f,
    output logic [6:0] cf_u,sign_bit_out,d4_u,d3_u,d2_u,d1_u
    );
     
     
     logic sign1;
     logic [3:0] ones, tens, hund, thou;

    logic signed [17:0] tx10_u; 
    logic unsigned [16:0] tx10_mag_u;
    logic unsigned [12:0] tx10_mag_r_u;
   
    assign d2_u = {3'b010,ones};
    assign d1_u = {3'b000,tens};
  
  // Instantiate all the modules 
tconvert U_TCONV(.tc, .cf(c_f), .tx10(tx10_u));
conv_sgnmag U_CONV(.tx10(tx10_u), .tx10_sign(sign1), .tx10_mag(tx10_mag_u));
round U_ROUND(.tx10_mag(tx10_mag_u), .tx10_mag_r(tx10_mag_r_u));
dbl_dabble_ext U_DBL_EXT(.b(tx10_mag_r_u),.ones,.tens,.hundreds(hund),.thousands(thou));
    
      always_comb begin
   if (c_f) cf_u = 7'b0001111;  // F
    else cf_u = 7'b0001100;  // C
    
      if (sign1) sign_bit_out = 7'b0010000;  // Neg. sign 
    else sign_bit_out = 7'b1000000;  //Blank

    if (thou != '0) d4_u = {3'b000, thou};  // Display d4
    else d4_u = 7'b1000000;  // Empty

    if (hund != 0) d3_u = {3'b000, hund};  // Display d3
    else if (thou != 0 )d3_u = 7'b0000000; //Display 0
    else d3_u = 7'b1000000;   // Blank
    end

endmodule
