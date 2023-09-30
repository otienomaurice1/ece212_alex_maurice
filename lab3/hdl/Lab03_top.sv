`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2023 01:37:17 PM
// Design Name: 
// Module Name: Lab03_top
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


module lab03_top(
    input logic clk, rst,
    input logic switch_C_F,  // change between celcius and farenheight
    input logic switch_sensor_test, // switch1 - switch from from temperature sensor to temp from switches
    input logic [12:0] SW,//switch_test,  // temp test value from switches
    output logic [7:0] an_n,     
    output logic [6:0] segs_n,     
    output logic dp_n,    // display decimal point 
    inout  tmp_scl,       // use inout only - no logic     
    inout  tmp_sda        // use inout only - no logic
     );      
    logic tmp_rdy, tmp_err;  // unused temp controller outputs 
    // logic for either temperature or test of user
    logic [12:0] temp_u;  // selector variable for tempsensor and switches 
    // Internal wire to display F and C
    logic [6:0] cf_u;  
    logic [6:0] d4_u, d3_u,d2_u,d1_u,d4,d3 ,d2, d1; // internal wires for output of tdisplay
    logic sign_bit_out, sign_bit_in; // This is the sign out/in from the multiplexer  
    // 13-bit two's complement result with 4-bit fractional part     
    logic [12:0] temp;      
    // instantiate the VHDL temperature sensor controller     
    TempSensorCtl U_TSCTL (.TMP_SCL(tmp_scl), .TMP_SDA(tmp_sda), .TEMP_O(temp),        
    .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk),.SRST_I(rst));      
   
   // add additional signals & instantiations here  
    tdisplay U_DISPLAY(
    .tc(temp_u), // Temperature from the sensor in C
    .c_f(switch_C_F), // Switch between C and F
    .sign(sign_bit_in), // Sign
    .ones(d1_u), .tens(d2_u), .hund(d3_u), .thou(d4_u) ); // BCD coded value of the temp

    sevenseg_ctl U_SEV_CTL(
    .clk, 
    .rst,
    .d7(7'b1000000), /*EMPTY most signif. bit is 1*/
    .d6(7'b1000000),  /*EMPTY most signif. bit is 1*/
    .d5(sign_bit_out), /*Sign*/
    .d4, /*Digit */
    .d3, /*Digit */
    .d2({3'b010,d2_u}), /*Digit */
    .d1({3'b000,d1_u}), /*Digit Fraction*/
    .d0(cf_u), /*This is the F-C*/
    .an_n,
    .segs_n,
    .dp_n);
    
    // Switch Fahrenheit and Celcius (MUX) 7-bits
    always_comb begin
    if (switch_C_F )
        cf_u = 7'b0001110; // F
    else
        cf_u = 7'b1000110; // C

    unique if (sign_bit_in )
        sign_bit_out = 7'b0010000; // Neg. sign 
    else
        sign_bit_out = 7'b1000000; //Empty

    if (d4_u != '0)
        d4 = {3'b000,d4_u}; // Display
    else
        d4 = 7'b1000000; // Empty

    if (d3_u != '0)
        d3 = {3'b000,d3_u}; // Display
    else
        d3 = 7'b1000000; // Empty
    
    // MUX TO SENSOR AND USER SWITCH
    if(switch_sensor_test)
        temp_u = SW;
    else 
         temp_u  = temp;

end
    
    endmodule