// This module rounds the bits up 

module  round(
   input logic [16:0] tx10_mag,
   output logic [12:0] tx10_mag_r);

always_comb begin
if (tx10_mag[3])
	tx10_mag_r = tx10_mag[16:4] + '1;
else 
	tx10_mag_r = tx10_mag[16:4]; 
end
endmodule