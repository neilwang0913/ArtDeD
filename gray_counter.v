/*

[https://www.intel.com/content/www/us/en/support/programmable/support-resources/design-examples/horizontal/ver-gray-counter.html]

Verilog Gray Counter Design Example v1.0 README File

This readme file for the Verilog Gray Counter Design contains 
information about the design example in the Quartus ll HDL 
Templates. Ensure that you have read the information on the
Verilog Gray Counter Design Example web page before using the 
example.

This file contains the following information:

o  Package Contents
o  Software Tool Requirements
o  Release History
o  Technical Support

Package Contents
================

Verilog Gray Counter Design Example v1.0


Software Tool Requirements
==========================

The Quartus II software version 9.1 or later, 
or supported versions of third-party synthesis tools. 

Contact your local sales representative if you do not have the
necessary software tools.


Release History
===============

Version 1.0
-----------
- First release of example


Technical Support
=================

Although we have made every effort to ensure that this design
example works correctly, there might be problems that we have not
encountered. If you have a question or problem that is not
answered by the information provided in this readme file or the
example's documentation, refer to the Altera technical support
web site: 

http://www.altera.com/mysupport


Last updated May, 2010                                
Copyright (c) 2010 Altera Corporation. All rights reserved.

*/
	
// Gray counter

module gray_count
(
	input clk, enable, reset,
	output reg [7:0] gray_count
);

// Implementation:

// There's an imaginary bit in the counter, at q[-1], that resets to 1
// (unlike the rest of the bits of the counter) and flips every clock cycle.
// The decision of whether to flip any non-imaginary bit in the counter
// depends solely on the bits below it, down to the imaginary bit.	It flips
// only if all these bits, taken together, match the pattern 10* (a one
// followed by any number of zeros).

// Almost every non-imaginary bit has a submodule instance that sets the
// bit based on the values of the lower-order bits, as described above.
// The rules have to differ slightly for the most significant bit or else 
// the counter would saturate at it's highest value, 1000...0.

	// q is the counter, plus the imaginary bit
	reg q [7:-1];
	
	// no_ones_below[x] = 1 iff there are no 1's in q below q[x]
	reg no_ones_below [7:-1];
	
	// q_msb is a modification to make the msb logic work
	reg q_msb;
	
	integer i, j, k;
	
	always @ (posedge reset or posedge clk)
	begin
		if (reset)
		begin
		
			// Resetting involves setting the imaginary bit to 1
			q[-1] <= 1;
			for (i = 0; i <= 7; i = i + 1)
				q[i] <= 0;
				
		end
		else if (enable)
		begin
			// Toggle the imaginary bit
			q[-1] <= ~q[-1];
			
			for (i = 0; i < 7; i = i + 1)
			begin
				
				// Flip q[i] if lower bits are a 1 followed by all 0's
				q[i] <= q[i] ^ (q[i-1] & no_ones_below[i-1]);
			
			end
			
			q[7] <= q[7] ^ (q_msb & no_ones_below[6]);
		end
	end
	
	
	always @(*)
	begin
		
		// There are never any 1's beneath the lowest bit
		no_ones_below[-1] <= 1;
		
		for (j = 0; j < 7; j = j + 1)
			no_ones_below[j] <= no_ones_below[j-1] & ~q[j-1];
			
		q_msb <= q[7] | q[6];
		
		// Copy over everything but the imaginary bit
		for (k = 0; k < 8; k = k + 1)
			gray_count[k] <= q[k];
		end	
		
endmodule
