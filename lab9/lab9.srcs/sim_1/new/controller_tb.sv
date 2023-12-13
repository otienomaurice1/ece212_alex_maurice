//------------------------------------------------
// mipstest.sv
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Testbench for MIPS processor
// Revised for use with Lafayette Multi-cycle design
// John Nestor, March 2019
//------------------------------------------------

module controller_tb;
     logic       clk, reset;
     logic [5:0] opcode;
     logic [5:0] funct;
     logic       zero;
     logic       pcen, memwrite, irwrite, regwrite;
     logic       alusrca, iord, memtoreg, regdst;
     logic [1:0] alusrcb, pcsrc;
     logic [2:0] alucontrol;

  // instantiate device to be tested
  controller DUV(.clk,
  .reset,
  .zero,
  .pcen, 
  .memwrite,
  .irwrite,
  . regwrite,
  .alusrca,
  . iord,
  . memtoreg,
  . regdst,
  .alusrcb,
  . pcsrc,
  .alucontrol,
  .opcode,
   .funct
   );
  
  

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end
// initialize test
  initial
    begin
      reset <= 1; #  9;
      reset <= 0;
       //ADD
     opcode <= 6'b000000;
     funct  <= 6'b100000;
       zero <= 0;
    end

   localparam LIMIT = 4;  // don't let simulation go on forever
   
   integer cycle = 0;

   always @(posedge clk)
     begin
	   if (cycle>LIMIT) $stop;
	   else cycle <= cycle + 1;
     end 
   
endmodule



