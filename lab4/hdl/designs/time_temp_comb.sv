`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2023 11:11:30 AM
// Design Name: 
// Module Name: time_temp_comb
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


module time_temp_comb(
input logic clk, rst,
adv_min, adv_hr,
input logic[1:0] SW,
output logic [7:0] an_n,
output logic dp_n,
output logic [6:0] segs_n,
inout  tmp_scl,       // use inout only - no logic     
inout  tmp_sda        // use inout only - no logic
    );
    //declare internal variables
    logic[6:0] d4_u,d3_u,d2_u,d1_u,sign_bit_out,cf_u;
    logic[6:0] h0,h1,m1,m0,s1,s0,am_pm;
   logic sel,cf,pe_enb;
    // 13-bit two's complement result with 4-bit fractional part     
    logic [12:0] temp;
   logic tmp_rdy, tmp_err;  // unused temp controller outputs 
   logic [6:0] d0,d1,d2,d3,d4,d5,d6,d7; // OUTPUTS TO SEVENSEGMENT CONTROLLER
   
  tdisplay U_DISPLAY(.tc(temp),.c_f(cf),.cf_u,.sign_bit_out,.d1_u, .d2_u, .d3_u, .d4_u );
  
  TempSensorCtl U_TSCTL (.TMP_SCL(tmp_scl), .TMP_SDA(tmp_sda), .TEMP_O(temp),        
    .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk),.SRST_I(rst));
 
  period_enb  #(.PERIOD_MS(2000)) U_ENB(.rst,.clk,.enb_out(pe_enb),.clr(1'b0));
  
 dig_clock U_DIG(.am_pm,.rst,.clk,.h0,.h1,.m1,.m0,.s1,.s0,.adv_min,.adv_hr);
 
  sevenseg_ctl U_SEVENSEG( .clk, .rst,.d0,.d1,.d2 ,.d3,.d4,.d5,.d6,.d7,.an_n,.dp_n ,.segs_n);
  
  
  // DECLARE A FINITE STATE MACHINE WITH FOUR STATES
    typedef enum logic [1:0] {
  TI = 2'b00,
  TF = 3'b01,
  TC = 3'b11
  } states;
  
  states next,state; // instantiate states


// the flip flop
  always_ff @(posedge clk)
  if(rst) state <= TI;  
  else state <= next;
  
  always_comb begin
  //declare default state and outputs
  next = TI;
  cf = 0;
  sel = 1;
 
  //Display time
  if(SW == 2'b00)
  begin
  sel = 1;
  end
  
  /*Alternate between displaying time and Farehnheight temperature every 2 seconds
 */
  else if(SW == 2'b01) 
begin
  case(state)
  TI: begin  
  sel = 1; // SELECT DIG_CLOCK
   if(pe_enb) next = TF; // SWITCH TO DISPLAY TEMP IN FARENHEIGHT
   else next = TI;      // CONTINUE DISPLAYING TIME
  end
  
   TF: begin
   cf = 1; // SELECT FARENHEIGHT
   sel = 0; // SECLECT TDISPLAY
   if(pe_enb) next = TI; // SWITCH TO DISPLAY TIME
   else next = TF;  // CONTINUE DISPLAYING TEMPERATURE
  end
   endcase
 end
 
 /*Alternate between displaying time and celcius temperature every 2 seconds
 */
   else if(SW == 2'b10) 
   begin
  case(state)
  TI: begin   
  sel = 1; // SELECT DIG_CLOCK
   if(pe_enb) next = TC;
   else next = TI;
  end
    TC: begin
   cf = 0; //SELECT DEGREES CELSIUS
   sel = 0; // SELECT TDISPLAY
   if(pe_enb) next = TI;
   else next = TC;
   end
   endcase
 end

/*Alternate between displaying time, Farehnheight temperature and celcius temperature every 2 seconds
 */
 else if(SW == 2'b11) begin
   
  case(state)
  TI: begin  
  sel = 1; // SELECT DIG_CLOCK
   if(pe_enb) next = TF;
   else next = TI;
  end
  
   TF: begin 
   cf = 1; //SELECT FARENHEIGHT
   sel = 0; // SELECT TDISPLAY
   if(pe_enb) next = TC; // IF ENABLE GO TO DISPLAY TEMP IN DEGREES CELCIUS
   else next = TF;     // ELSE CONTINUE DISPLAYING TEM IN DEGREES FARENHEIGHT 
  end
    TC: begin
   cf = 0; // SELECT CELSIUS
   sel = 0; // SELECT TDISPLAY
   if(pe_enb) next = TI;  // IF ENABLE GO BACK TO DISPLAY TIME
   else next = TC;       // ELSE CONTINUE DISPLAYING 
   end
   endcase
 end  
       
 if(sel) begin
  d0 =am_pm;
 d1 = 7'b1000000;
 d2 = s0;
 d3 = s1;
 d4 = m0;
 d5 = m1;
 d6 =  h0;
 d7 = h1; 
 end  
 else  begin      
  d0 = cf_u;
 d1 = d1_u;
 d2 = d2_u;
 d3 = d3_u;
 d4 = d4_u;
 d5 = sign_bit_out;   
 d6 = 7'b1000000;  
 d7 = 7'b1000000;
 end
 end   
endmodule
