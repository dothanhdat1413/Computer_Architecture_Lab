module EX_MEM (
  input clk,
  input rst_n,
  input [31:0] PC_EX,
  input [31:0] ALU_Result_EX, 
  input [31:0] RD2_EX,
  input [31:0] Instr_EX,

  output reg [31:0] PC_EX_MEM,
  output reg [31:0] ALU_Result_EX_MEM,
  output reg [31:0] RD2_EX_MEM,
  output reg [31:0] Instr_EX_MEM
);

always @( posedge clk, negedge rst_n ) begin 
  if (~rst_n) begin
    PC_EX_MEM         <= 0;
    ALU_Result_EX_MEM <= 0;
    RD2_EX_MEM        <= 0; 
    Instr_EX_MEM      <= 0;
  end

  else begin
    PC_EX_MEM         <= PC_EX;
    ALU_Result_EX_MEM <= ALU_Result_EX;
    RD2_EX_MEM        <= RD2_EX; 
    Instr_EX_MEM      <= Instr_EX;        
  end
end

endmodule