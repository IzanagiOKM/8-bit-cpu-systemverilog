module control_unit (
    input logic [7:0] opcode,
    output logic [2:0] alu_select,
    output logic accumulator_load,
    output logic halt,
 	output logic immediate_select
);
  
  always_comb begin
    case (opcode)
      8'b00000001: begin  // ADD
      alu_select = 3'b000;
      accumulator_load = 1'b1;
      immediate_select = 1'b0;
      halt = 1'b0;
  end
      8'b00000010: begin  //SUB
      alu_select = 3'b001;
      accumulator_load = 1'b1;
      immediate_select = 1'b0;
      halt = 1'b0;
  end
      8'b00000011: begin  //HLT
      alu_select = 3'b000;
      accumulator_load = 1'b0;
      immediate_select = 1'b0;
      halt = 1'b1;
  end
      8'b00000000: begin  //LDI
      alu_select = 3'b000;
      accumulator_load = 1'b1;
      immediate_select = 1'b1;
      halt = 1'b0;
  end
      default: begin
      alu_select = 3'b000;
      accumulator_load = 1'b0;
      immediate_select = 1'b1;
      halt = 1'b1;
  end
      
    endcase
  end

endmodule
