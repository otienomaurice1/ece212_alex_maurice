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
input logic clk, rst, cy3,adv_hr, // take in clock, reset, advance hr and enable signal cy3
output [3:0]h1, h0, am_pm   // declare three outputs for the first and second digit of the hr and one for the am_pm functionality
    );
    
    
 typedef enum logic { AM = 0, PM =1}states; // declare a finite state machine with two states a
states next, state;
    logic cy;
    logic pe_enbh,pe_enb;
    assign pe_enbh = ((pe_enb&adv_hr)|cy3);
    logic [7:0] l; 
    logic [3:0] hr_12_0;   // rceives the hr value from the counter
    logic [3:0] k,o,p,am_pm0;
    period_enb  #(.PERIOD_MS(1000)) U_ENB(.rst,.clk,.enb_out(pe_enb),.clr(1'b0));
    counter_rc_mod #(.MOD(12)) U_D0SEC(.clk,.rst,.enb(pe_enbh),.q(hr_12_0),.cy); // instantiate the counter 
    always_comb
   if (hr_12_0 == 0)  k = 4'd12;  // if hr == 0, change it to 12 else retain the value of hr
   else  k =  hr_12_0;
    
    
always_ff @(posedge clk) begin     
         if(rst) begin  o <= 4'd12; state <= AM; end   
          else begin  o <= k;  state <= next; end
end


always_comb begin        
 case(state)
 AM: if(cy) begin 
  next = PM; 
  am_pm0 = 4'd11;
  end
  else begin 
  next = AM;
  am_pm0 = 4'd10;
  end
  
 PM: if (cy) begin
  next = AM;
  am_pm0 = 4'd10;
    end
  else begin
  next = PM; 
  am_pm0 = 4'd11;
    end
  
endcase
end 
      assign am_pm = am_pm0;
       assign l = {{4'b0000},o};          // make hr an eight bit value
    dbl_dabble U_HR(.b(l),.hundreds(p),.tens(h1),.ones(h0));  // convert hr to its binary coded decimal equvalent
endmodule: hr
 