 module instruction_memory(
    input logic [7:0] address,
    output logic [15:0] instruction);
    
    logic [15:0] memory [0:255];
    
    initial begin
    memory[0] = 16'b00000000_00000101; // LDI 5
    memory[1] = 16'b00000001_00000011; // ADD 3
    memory[2] = 16'b00000010_00000010; // SUB 2
    memory[3] = 16'b00000011_00000000; // HLT
	end
    
   always_comb begin
      instruction = memory[address];
  	end
  
endmodule
