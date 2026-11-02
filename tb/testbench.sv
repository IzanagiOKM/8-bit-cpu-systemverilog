module alu_tb (
    input logic start,
    output logic done
);
	
  
  integer passed = 0;
  integer failed = 0;
  logic[7:0] A;
  logic[7:0] B;
  logic[2:0] Select;
  logic [8:0] Expected;
  logic clk;
  logic reset;
  
  logic[7:0] Result; 
  logic CarryOut;
  
  
  alu uut(
    .A(A),
    .B(B),
    .Select(Select),
    .Result(Result), 
    .CarryOut(CarryOut),
    .clk(clk),
    .reset(reset)
  );
  
      initial clk = 0;
      always #5 clk = ~clk;

      initial begin
      done = 0;
      wait(start === 1'b1);

      $display("================================");
      $display("          ALU TESTS");
      $display("================================");

      reset = 1;
      A = 8'd0;
      B = 8'd0;
      Select = 3'b000;

      #2;
      reset = 0;

    // Addition test
    A = 8'd5;
    B = 8'd3;
    Select = 3'b000;

    Expected = {1'b0, A} + {1'b0, B};

    @(posedge clk);
    #1;
    check_result();

    // Subtraction test
	A = 8'd5;
    B = 8'd3;
    Select = 3'b001;
    
    Expected = {1'b0, A} - {1'b0, B};
    
    @(posedge clk);
    #1;
    check_result();
    
    // AND test
    A = 8'd9;
    B = 8'd3;
    Select = 3'b010;

    Expected = {1'b0, A & B};

    @(posedge clk);
    #1;
    check_result();
    
    // OR test
	A = 8'd9;
	B = 8'd3;
	Select = 3'b011;

    Expected = {1'b0, A | B};

	@(posedge clk);
	#1;
	check_result();
    
    // XOR test
    A = 8'd9;
    B = 8'd3;
    Select = 3'b100;

    Expected = {1'b0, A ^ B};

    @(posedge clk);
    #1;
    check_result();
    
    // NOT test
    A = 8'd9;
    B = 8'd3;
    Select = 3'b101;

    Expected = {1'b0, ~A};

    @(posedge clk);
    #1;
    check_result();
    
    // Shift Left test
    A = 8'd9;
    B = 8'd3;
    Select = 3'b110;

    Expected = {1'b0, A << 1};

    @(posedge clk);
    #1;
    check_result();
    
    // Shift Right test
    A = 8'd9;
    B = 8'd3;
    Select = 3'b111;

    Expected = {1'b0, A	>> 1};
    
    @(posedge clk);
    #1;
    check_result();
    
    // Addition overflow test
	A = 8'd255;
	B = 8'd1;
	Select = 3'b000;
    
    Expected = {1'b0, A} + {1'b0, B};
    
    @(posedge clk);
    #1;
    check_result();
    
    // Asynchronous Reset test
    @(negedge clk);
    reset = 1;
    Expected = 5'b00000;
	
    #1;
    check_result();
    
    // Clock Timing Test
    reset = 0;
    A = 8'd5;
    B = 8'd3;
    Select = 3'b000;
    
    Expected = 5'b1000;
    
    @(posedge clk);
    #1;
    check_result;
    
    @(negedge clk);

    A = 8'd9;
    B = 8'd3;
    Select = 3'b001;

    // The registered output should still be 8
    Expected = 5'b01000;

    #1;
    check_result();
    
    @(posedge clk);
    Expected = 5'b00110;
    #1;
    check_result();
    
    $display("ALU Tests Passed: %0d", passed);
    $display("ALU Tests Failed: %0d", failed);
    $display("================================");

    done = 1;
    
    
	end
  
    task check_result;
        begin
            if ({CarryOut, Result} === Expected) begin
                passed = passed + 1;
                $display("PASS: Select=%b Expected=%b Got=%b",
                         Select, Expected, {CarryOut, Result});
            end
            else begin
                failed = failed + 1;
                $display("FAIL: Select=%b Expected=%b Got=%b",
                         Select, Expected, {CarryOut, Result});
            end
        end
    endtask
  
	
endmodule



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

      module instruction_memory_tb (
      input logic start,
      output logic done
      );

          logic [7:0] address;
          logic [15:0] instruction;

          instruction_memory dut (
              .address(address),
              .instruction(instruction)
          );

            initial begin
            done = 0;
            wait(start === 1'b1);

            $display("================================");
            $display("      INSTRUCTION MEMORY TESTS");
            $display("================================");

            address = 0;
            #1;
            
            if (instruction === 16'b00000000_00000101)begin
            $display("PASS: LDI 5");
       	end
        	else begin
            	$display("FAIL: Expected LDI 5");
        end
            
            address = 1;
            #1;
            if (instruction === 16'b00000001_00000011)begin
              $display("PASS: ADD 3");
       	end
            else begin
              $display("FAIL: Expected ADD 3");
        end
            
            address = 2;
            #1;
            if (instruction === 16'b00000010_00000010)begin
              $display("PASS: SUB 2");
        end
            else begin
              $display("FAIL: Expected SUB 2");
        end   
              $display("================================");
              $display("   INSTRUCTION MEMORY COMPLETE");
              $display("================================");

              done = 1;
          
            end
      endmodule


          module control_unit_tb (
          input logic start,
          output logic done
      );

          logic [7:0] opcode;
          logic [2:0] alu_select;
          logic accumulator_load;
          logic halt;
          logic immediate_select;

          control_unit dut (
              .opcode(opcode),
              .alu_select(alu_select),
              .accumulator_load(accumulator_load),
              .halt(halt),
              .immediate_select(immediate_select)
          );

          initial begin
              done = 0;
              wait(start === 1'b1);

              $display("================================");
              $display("        CONTROL UNIT TESTS");
              $display("================================");

              opcode = 8'b00000000; // LDI Test
              #1;

              if (alu_select === 3'b000 &&
                  accumulator_load === 1'b1 &&
                  immediate_select === 1'b1 &&
                  halt === 1'b0) begin
                  $display("PASS: LDI");
              end
              else begin
                  $display("FAIL: LDI");
              end
         
              opcode = 8'b00000001;//ADD Test
              #1;

              if (alu_select === 3'b000 &&
                  accumulator_load === 1'b1 &&
                  immediate_select === 1'b0 &&
                  halt === 1'b0) begin
                  $display("PASS: ADD");
              end
              else begin
                  $display("FAIL: ADD");
              end
            
              opcode = 8'b00000010;//SUB Test
              #1;

              if (alu_select === 3'b001 &&
                  accumulator_load === 1'b1 &&
                  immediate_select === 1'b0 &&
                  halt === 1'b0) begin
                  $display("PASS: SUB");
              end
              else begin
                  $display("FAIL: SUB");
              end
            
              opcode = 8'b00000011;//HLT Test
              #1;

              if (alu_select === 3'b000 &&
                  accumulator_load === 1'b0 &&
                  immediate_select === 1'b0 &&
                  halt === 1'b1) begin
                  $display("PASS: HLT");
              end
              else begin
                  $display("FAIL: HLT");
              end
              $display("================================");
              $display("     CONTROL UNIT TESTS COMPLETE");
              $display("================================");

              done = 1;
          end

      	endmodule

    	module cpu_tb (
        input logic start,
        output logic done
    );

        logic clk;
        logic reset;
        logic [7:0] accumulator_out;
        logic [7:0] pc_out;
        logic halted;
  
        //Dut stands for Device Under Test.
        cpu_top dut (
      	.clk(clk),	//will drive the CPU's clock.
      	.reset(reset), //will initialize the processor.
      	.accumulator_out(accumulator_out), //observes calculation results.
      	.pc_out(pc_out),//tells which instruction the CPU is executing.
      	.halted(halted) //tells when the CPU stops.
    );
        //Clock Generator
        initial clk = 0;
        always #5 clk = ~clk;//reverses the clock every 5 simulation time 									units
          
          
  		// Uncomment to monitor the Program Counter,
    	// accumulator, instruction opcode, and HALT signal.
        //CPU debugging 
        /*always @(posedge clk) begin
        #1;
        $display("Time=%0t PC=%0d ACC=%0d OPCODE=%b HALT=%b",
                 $time,
                 pc_out,
                 accumulator_out,
                 dut.instruction[15:8],
                 halted);
		end
  	 	*/
          
  		//Main CPU Test
        initial begin
        done = 0;
        wait(start === 1'b1);

        $display("================================");
        $display("     8-BIT CPU INTEGRATION TEST");
        $display("================================");

        reset = 1;

        #12;
        reset = 0;

        // Wait until CPU reaches HALT
        wait(halted === 1'b1);

        #1;

        // Check final accumulator value
        if (accumulator_out === 8'd6) begin
            $display("PASS: Final accumulator = %0d",
                     accumulator_out);
        end
        else begin
            $display("FAIL: Expected 6, got %0d",
                     accumulator_out);
        end
          
        if (pc_out === 8'd3)
            $display("PASS: Program Counter stopped at 3");
       	else
            $display("FAIL: Expected PC=3, got %0d", pc_out);

        // Verify HALT signal
        if (halted === 1'b1)
            $display("PASS: HALT signal asserted");
        else
            $display("FAIL: HALT signal not asserted");
          
        // Verify CPU remains halted
        repeat (3) @(posedge clk);
        #1;

        if (pc_out === 8'd3 &&
            accumulator_out === 8'd6 &&
            halted === 1'b1)
            $display("PASS: CPU remains halted");
        else
            $display("FAIL: CPU changed after HALT");
        $display("================================");
        $display("     CPU TESTING COMPLETE");
        $display("================================");  
          
        done = 1;
    	end

endmodule


    module cpu_test_suite;

        logic [5:0] start;
        wire [5:0] done;

        alu_tb alu_test (
            .start(start[0]),
            .done(done[0])
        );

        accumulator_tb accumulator_test (
            .start(start[1]),
            .done(done[1])
        );

        program_counter_tb pc_test (
            .start(start[2]),
            .done(done[2])
        );

        instruction_memory_tb memory_test (
            .start(start[3]),
            .done(done[3])
        );

        control_unit_tb control_test (
            .start(start[4]),
            .done(done[4])
        );

        cpu_tb cpu_test (
            .start(start[5]),
            .done(done[5])
        );

        initial begin
            start = 6'b000000;

            $display("================================");
            $display("       8-BIT CPU TEST SUITE");
            $display("================================");

            start[0] = 1;
            wait(done[0] === 1'b1);
            start[0] = 0;

            start[1] = 1;
            wait(done[1] === 1'b1);
            start[1] = 0;

            start[2] = 1;
            wait(done[2] === 1'b1);
            start[2] = 0;

            start[3] = 1;
            wait(done[3] === 1'b1);
            start[3] = 0;

            start[4] = 1;
            wait(done[4] === 1'b1);
            start[4] = 0;

            start[5] = 1;
            wait(done[5] === 1'b1);
            start[5] = 0;

            $display("================================");
            $display("       TEST SUITE COMPLETE");
            $display("================================");

            $finish;
        end

        // Prevent an infinite simulation if a test hangs.
        initial begin
            #2000;
            $display("FAIL: Test suite timed out");
            $finish;
        end

    endmodule
