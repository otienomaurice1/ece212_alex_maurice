//------------------------------------------------
// mipstest.sv
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Testbench for MIPS processor
// Revised for use with Lafayette Multi-cycle design
// John Nestor, March 2019
//------------------------------------------------

module controller_tb();
     logic       clk, reset;
     mips_decls_p::opcode_t opcode;
     mips_decls_p::funct_t funct;
     logic       zero;
     logic       pcen, memwrite, irwrite, regwrite;
     logic       alusrca, iord, memtoreg, regdst;
     logic [1:0] alusrcb, pcsrc;
     logic [2:0] alucontrol;

  // instantiate device to be tested
  controller DUV(.clk,.opcode, .funct,.reset,.zero,.pcen, .memwrite,. irwrite,. regwrite,.alusrca,. iord,. memtoreg,. regdst,.alusrcb,. pcsrc,.alucontrol);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check that 7 gets written to address 84
  always@(negedge clk)
    begin
      if(memwrite) begin
        if(dataadr === 84 & writedata === 33) begin
          $display("Simulation succeeded");
          $stop;
        end else if (dataadr !== 80) begin
          $display("Simulation failed");
          $stop;
        end
      end
    end

   localparam LIMIT = 100;  // don't let simulation go on forever
   
   integer cycle = 0;

   always @(posedge clk)
     begin
	   if (cycle>LIMIT) $stop;
	   else cycle <= cycle + 1;
     end 
   
endmodule



