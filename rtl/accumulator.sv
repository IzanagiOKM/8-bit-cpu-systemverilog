module accumulator (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

  always_ff @(posedge clk or posedge reset)begin
    
    if(reset)begin
      data_out <= 8'b00000000;
    end
    else if (load) begin
      data_out <= data_in;
    end
  end
  
endmodule
