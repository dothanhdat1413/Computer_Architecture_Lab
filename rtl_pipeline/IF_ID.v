module IF_ID (
  input clk,
  input rst_n,
  input [31:0] IF_Instr,
  input [31:0] IF_PC,
  output reg [31:0] IF_ID_Instr,
  output reg [31:0] IF_ID_PC
);

always @( posedge clk, negedge rst_n) begin
  if (~rst_n) begin
    IF_ID_Instr <= 0;
    IF_ID_PC <= 0;
  end
  else begin	 
    IF_ID_Instr <= IF_Instr;
    IF_ID_PC <= IF_PC;
  end
end

endmodule