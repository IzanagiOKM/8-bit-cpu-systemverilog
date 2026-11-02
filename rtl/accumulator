module accumulator_tb (
    input logic start,
    output logic done
);

    logic clk;
    logic reset;
    logic load;
    logic [7:0] data_in;
    logic [7:0] data_out;

    accumulator uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );
  
  	initial clk = 0;
    always #5 clk = ~clk;
  
initial begin
    done = 0;
    wait(start === 1'b1);

    $display("================================");
    $display("       ACCUMULATOR TESTS");
    $display("================================");

    reset = 1;
    load = 0;
    data_in = 8'd25;

    #2;
  	if (data_out === 8'd0)
        $display("PASS: Reset test");
    else
        $display("FAIL: Reset test");
  
    // Load test
    @(negedge clk);
    reset = 0;
    load = 1;
    data_in = 8'd25;

    @(posedge clk);
    #1;

    if (data_out === 8'd25)
        $display("PASS: Load test");
    else
        $display("FAIL: Load test");
  
     // Hold test
     @(negedge clk);
     load = 0;
     data_in = 8'd100;

     @(posedge clk);
     #1;

     if (data_out === 8'd25)
          $display("PASS: Hold test");
     else
          $display("FAIL: Hold test");
  
  	// Overwrite test
    @(negedge clk);
    load = 1;
    data_in = 8'd75;

    @(posedge clk);
    #1;

    if (data_out === 8'd75)
        $display("PASS: Overwrite test");
    else
        $display("FAIL: Overwrite test");
  
  
  	 $display("================================");
     $display("     ACCUMULATOR TESTS COMPLETE");
     $display("================================");

   	 done = 1;
  
end
     
  
endmodule
