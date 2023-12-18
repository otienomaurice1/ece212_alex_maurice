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
     output logic sign,
    output logic [3:0] ones, tens, hund, thou
    );
     
    logic signed [17:0] tx10_u; 
    logic unsigned [16:0] tx10_mag_u;
    logic unsigned [12:0] tx10_mag_r_u;
   
  
  // Instantiate all the modules 
tconvert U_TCONV(.tc, .cf(c_f), .tx10(tx10_u));
conv_sgnmag U_CONV(.tx10(tx10_u), .tx10_sign(sign), .tx10_mag(tx10_mag_u));
round U_ROUND(.tx10_mag(tx10_mag_u), .tx10_mag_r(tx10_mag_r_u));
dbl_dabble_ext U_DBL_EXT(.b(tx10_mag_r_u),.ones,.tens,.hundreds(hund),.thousands(thou));
    
endmodule
