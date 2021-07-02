# Ref iverilog step 1 key parameter below
# SC = iverilog
# FLAGS = -g2005 -Wall -Wno-timescale 

# Change This TARGET name:
TARGET = fzadder
TEST = $(TARGET)Test

# Check the installing path
GFLAGS = -S gtkwave.tcl
GTKWAVE_OSX = /Applications/gtkwave.app/Contents/Resources/bin/gtkwave

all: clean zip
# iverilog step 1:
  # $(SC) $(FLAGS) -o $(TEST) $(TARGET).v $(TARGET).t.v
	iverilog -g2005 -Wall -Wno-timescale -o $(TEST) $(TARGET).v $(TARGET).t.v
# iverilog step 2:
	vvp $(TEST)
# iverilog step 1:	
	# open -a gtkwave test.vcd 
	gtkwave $(GFLAGS) *.vcd 2>/dev/null || $(GTKWAVE_OSX) $(GFLAGS) *.vcd 2>/dev/null

clean:
	rm -f *.vcd
	rm -f *Test *test

zip:
	zip -r $$(basename $$(pwd)).zip *.v
