//--------------------------------------------------------------------
// datapath.sv - Multicycle MIPS datapath
// David_Harris@hmc.edu 23 October 2005
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module:
//  1. Use enums from new package to make opcode & function codes
//     display symbolic names  during simulation
//  2. Explicitly break out and use instruction subfields (opcode, rs, rt, etc.
//
//--------------------------------------------------------------------

// The datapath unit is a structural verilog module.  That is,
// it is composed of instances of its sub-modules.  For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated.

module datapath(
    input  logic        clk, reset,
    input logic         pcen, irwrite, regwrite,
    input logic         alusrca, iord, memtoreg, regdst,
    input logic [1:0]   alusrcb, pcsrc,
    input logic [2:0]   alucontrol,
    output mips_decls_p::opcode_t opcode,
    output mips_decls_p::funct_t funct,
    output logic        zero,
    output logic [31:0] adr, writedata,
    input logic [31:0]  readdata
    );


   import mips_decls_p::*;

   // instruction fields
   logic [31:0]                     instr;
   logic [4:0]                      rs, rt, rd;  // register fields
   logic [15:0]                     immed;       // i-type immediate field
   logic [25:0]                     jmpimmed;    // j-type pseudo-address
  

  // extract instruction fields from instruction
   assign opcode = opcode_t'(instr[31:26]);
   assign funct = funct_t'(instr[5:0]);
   assign rs = instr[25:21];
   assign rt = instr[20:16];
   assign rd = instr[15:11];
   assign immed = instr[15:0];
   assign jmpimmed = instr[25:0];
   //DECLARATIONS FOR INTERNAL WIRES
   //FETCH STAGE
   //internal wires for pc and pc sources
   logic [31:0]                     pc,pcnext;
   //DECODE
   logic [31:0]                     pcjump,aluout;
   logic [27:0]                     jumpaddr;
   logic [3:0]                      pc_31_28;
   logic [31:0]                     data;
   logic [31:0]                     rd1,rd2;
   logic [31:0]                     regresult;
   logic [4:0]                      writereg;
   //EXECUTE
   logic [31:0]                     A,B;
   logic [31:0]                     srca,srcb;
   logic [31:0]                     signimm,signimmshift4mem,signimmshift4jump;
   logic [31:0]                     aluresult;
//ASSIGNMENTS FOR INTERNAL WIRES
 assign pc_31_28 = pc[31:28];
 assign  pcjump = {pc_31_28,jumpaddr};
 assign  writedata = B;
   // Your datapath hardware goes below.  Instantiate each of the submodules
   // that you need.  Feel free to copy ALU, muxes and other modules from
   // Lab 9.  This directory also includes parameterizable multipliexers
   // mux3.sv (paramaterized 3:1) and mux4.sv (paramterized 4:1)
   // Make sure to instantiate with the correct bitwidth!

   // Remember to give your instantiated modules applicable instance names
   // such as U_PCREG (PC register), U_WDMUX (Write Data Mux), etc.
   // so it's easier to find them during simulation and debugging.
   
//FETCH
 flopenr #(32)    U_PC(.clk, .reset,.en(pcen),.d(pcnext),.q(pc) );         //pc register
 mux2    #(32)    U_IORDMUX(.d0(pc),.d1(aluout),.s(iord),.y(adr));         //pc source multiplexer
//DECODE
 signext          U_SIGNEXT(.a(immed),.y(signimm));                        //sign extend the immediate for branch instr
 sl2     #(28)    U_SHIFT4JUMP(.a(jmpimmed),.y(jumpaddr));                 // shift to the left by 2 for jump instr   
 sl2     #(32)    U_SHIFT4MEM(.a(signimm),.y(signimmshift4mem));           // shift to the left by 2 for branch instr     
 flopenr #(32)    U_IR(.clk, .reset,.en(irwrite),. d(readdata),.q(instr) );// istr register
 flopr   #(32)    U_MDR(. clk, .reset,. d(readdata),.q(data));             // data register
 regfile          U_REGFILE(.clk,.we3(regwrite),.ra1(rs),.ra2(rt),.wa3(writereg),.wd3(regresult),.rd1, .rd2); //register file
 mux2    #(5)     U_REGDSTMUX(.d0(rt),.d1(rd),.s(regdst),.y(writereg));     // register destination multiplexer
 mux2    #(32)    U_WDMUX(.d0(aluout),.d1(data),.s(memtoreg),.y(regresult));//write data to memory multiplexer
//EXECUTE
flopr   #(32)     U_AREG(. clk, .reset,. d(rd1),.q(A));                     // alu source A register
flopr   #(32)     U_BREG(. clk, .reset,. d(rd2),.q(B));                     //alu source B register
mux2    #(32)    U_ALSRCAMUX(.d0(pc),.d1(A),.s(alusrca),.y(srca));          //alu source A multiplexer
mux4    #(32)    U_ALSRCBMUX(.d0(B), .d1(31'd4), .d2(signimm), .d3(signimmshift4mem),.s(alusrcb),.y(srcb)); // alu source B multiplexer
mux3    #(32)    U_PCSRCMUX(. d0(aluresult),.d1(aluout),.d2(pcjump),.s(pcsrc),.y(pcnext));  //PC source multiplexer
alu              U_ALU(.a(srca),.b(srcb),.f(alucontrol),.y(aluresult),.zero);  // alu file             
flopr   #(32)    U_ALUOUT(. clk, .reset,. d(aluresult),.q(aluout));           // alu output register
//MEMORY
//---MEMORY CONNECTED VIA I/O PORTS



endmodule
