module dig_clock(
 input logic clk, rst, adv_hr, adv_min,
 output logic [6:0] h1, h0, m1, m0, s1, so, am_pm
); 