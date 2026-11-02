module alu (
  input logic [7:0] A,             
  input logic [7:0] B,             
  input logic [2:0] Select,            
  input logic clk,       
  input logic reset,          
  output logic [7:0] Result,          
  output logic CarryOut
);
  
  logic [7:0] alu_result;
  logic alu_carry;
  
  always_comb begin 
    alu_carry = 1'b0;
    alu_result = 8'b0000;
    case(Select)
      3'b000: {alu_carry, alu_result} = {1'b0, A} + {1'b0, B};
      3'b001: alu_result = A - B;
      3'b010: alu_result = A & B;
      3'b011: alu_result = A | B;
      3'b100: alu_result = A ^ B;
      3'b101: alu_result = ~A;
      3'b110: alu_result = A << 1;
      3'b111: alu_result = A >> 1;
      
      
    endcase
  end
  
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      Result <= 8'b0000;
      CarryOut <= 1'b0;
    end
    else begin
    	Result <= alu_result;
  		CarryOut <= alu_carry;
    end
  end
  
endmodule


