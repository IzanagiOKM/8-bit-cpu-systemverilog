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
