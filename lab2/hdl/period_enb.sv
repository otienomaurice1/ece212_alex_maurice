module period_enb(
 input logic clk, rst, clr,
 output logic enb_out
);
 // override ONE of the three delay parameters
           parameter PERIOD_MS = 1;
           parameter PERIOD_US = PERIOD_MS * 1000;
           parameter PERIOD_NS = PERIOD_US * 1000;
           parameter CLKFREQ_MHZ = 100; // Nexys4 default
      
       localparam CLKPD_NS = 1000 / CLKFREQ_MHZ;
       localparam PERIOD_COUNT_LIMIT = PERIOD_NS / CLKPD_NS;
       localparam PERIOD_COUNT_BITS = $clog2(PERIOD_COUNT_LIMIT);

 logic [PERIOD_COUNT_BITS-1:0] q;
 
 assign enb_out = (q == PERIOD_COUNT_LIMIT - 1);
 
 
 always_ff @(posedge clk)
     if (rst || clr || enb_out) q <= 0;
     else q <= q + 1;
endmodule: period_enb