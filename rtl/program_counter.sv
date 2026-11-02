module program_counter(
  input logic clk,
  input logic reset,
  input logic jump,
  input logic enable,
  input logic [7:0] jump_address,
  output logic [7:0] pc
);
  
  always_ff @(posedge clk or posedge reset)begin
    if(reset)begin
      pc <= 8'd0;
    end
    else if(jump)begin
      pc <= jump_address;
    end
    else if(enable)begin
      pc <= pc + 8'd1;
    end
end
endmodule
