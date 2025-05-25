module ID_EX (
  input clk,
  input rst_n,
  input [31:0] ID_PC, 
  input [31:0] ID_RD1,
  input [31:0] ID_RD2,
  input [31:0] ID_Imm,
  input [31:0] ID_Instr,
  output reg [31:0] ID_EX_RD1,
  output reg [31:0] ID_EX_RD2,
  output reg [31:0] ID_EX_PC, 
  output reg [31:0] ID_EX_Imm,
  output reg [31:0] ID_EX_Instr
);

always @( posedge clk, negedge rst_n ) begin
  if (~rst_n) begin
    ID_EX_RD1 <= 0;
    ID_EX_RD2 <= 0;
    ID_EX_PC  <= 0;
    ID_EX_Imm <= 0;
    ID_EX_Instr <= 0;
  end
  else begin
    ID_EX_RD1 <= ID_RD1;
    ID_EX_RD2 <= ID_RD2;
    ID_EX_PC  <= ID_PC;
    ID_EX_Imm <= ID_Imm;
    ID_EX_Instr <= ID_Instr;
  end
end

endmodule