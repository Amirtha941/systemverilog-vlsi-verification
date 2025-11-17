module counter_4bit;
  reg clk = 0;
  reg [3:0] count = 0;

  always #5 clk = ~clk; // clock toggle every 5ns

  always @(posedge clk)
    count <= count + 1;

  initial begin
    $monitor("Time=%0t Count=%0d", $time, count);
    #100 $finish;
  end
endmodule