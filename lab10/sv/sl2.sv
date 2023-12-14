//--------------------------------------------------------------
// sl2.sv - 2-bit left shifter
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
//--------------------------------------------------------------

module sl2 #(parameter BITLENGTH = 32) (
    input  logic [BITLENGTH-1:0] a,
    output logic [BITLENGTH-1:0] y
    );

    assign y = {a[BITLENGTH-3:0], 2'b00};

endmodule // sl2
