/*
[https://www.edaplayground.com/x/3pxk]
*/
//testbench
module tb;
  bit clk;
bit rst;
wire [3:0] bcd_value;
wire [3:0] gray_count;

gray_counter gc(clk, rst, bcd_value, gray_count);

initial begin
  $monitor("%0t | Reset -> %b",$time,rst);
  clk = 1'b0;
  rst = 1'b0;
  #10;
  rst = 1'b1;
  #50;
  rst = 1'b0;
  #500 $finish;
  end

always begin
  #10 clk = ~clk;
end
endmodule
