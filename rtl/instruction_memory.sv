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
