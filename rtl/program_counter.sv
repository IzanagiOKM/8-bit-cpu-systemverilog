module program_counter_tb (
    input logic start,
    output logic done
);
  
  logic clk;
    logic reset;
    logic enable;
    logic jump;
    logic [7:0] jump_address;
    logic [7:0] pc;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .jump(jump),
        .jump_address(jump_address),
        .pc(pc)
    );
      initial clk = 0;
      always #5 clk = ~clk;
  
      initial begin
      done = 0;
      wait(start === 1'b1);

      $display("================================");
      $display("      PROGRAM COUNTER TESTS");
      $display("================================");

      reset = 1;
      enable = 0;
      jump = 0;
      jump_address = 0;
      
      #2;
      
      if (pc === 8'd0)
            $display("PASS: Reset test");
        else
            $display("FAIL: Reset test");
    // Increment test
    @(negedge clk);
    reset = 0;
    enable = 1;
    jump = 0;

    @(posedge clk);
    #1;

    if (pc === 8'd1)
        $display("PASS: Increment test");
    else
        $display("FAIL: Increment test. PC = %0d", pc);
  
        // Jump test
      @(negedge clk);
      reset = 0;
      jump = 1;
      enable = 1;
      jump_address = 8'd20;

      @(posedge clk);
      #1;

      if (pc === 8'd20)
          $display("PASS: Jump test");
      else
      	$display("FAIL: Jump test. PC = %0d", pc);
        // Hold test
      @(negedge clk);
      reset = 0;
      jump = 0;
      enable = 0;

      @(posedge clk);
      #1;

      if (pc === 8'd20)
          $display("PASS: Hold test");
      else
          $display("FAIL: Hold test. PC = %0d", pc);
        
      $display("================================");
      $display("   PROGRAM COUNTER TESTS COMPLETE");
      $display("================================");
	  done = 1;
        
    end
endmodule
