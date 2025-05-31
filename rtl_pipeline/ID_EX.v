module ID_EX (
  input clk,
  input rst_n,
  input [31:0] ID_PC, 
  input [31:0] ID_RD1,
  input [31:0] ID_RD2,
  input [31:0] ID_Imm,
  input [31:0] ID_Instr,

  input [1:0] ID_ASel,
  input [1:0] ID_BSel,
  input [3:0] ID_ALUSel,

  input [1:0] ID_WBSel,
  input ID_RegWEn,

  input ID_MemR,
  input ID_MemW,
  
  output reg [31:0] ID_EX_RD1,
  output reg [31:0] ID_EX_RD2,
  output reg [31:0] ID_EX_PC, 
  output reg [31:0] ID_EX_Imm,
  output reg [31:0] ID_EX_Instr,

  output reg [1:0] ID_EX_ASel,
  output reg [1:0] ID_EX_BSel,
  output reg [3:0] ID_EX_ALUSel,

  output reg ID_EX_MemR,
  output reg ID_EX_MemW,

  output reg [1:0] ID_EX_WBSel,
  output reg ID_EX_RegWEn

);

always @( posedge clk, negedge rst_n ) begin
  if (~rst_n) begin
    ID_EX_RD1 <= 0;
    ID_EX_RD2 <= 0;
    ID_EX_PC  <= 0;
    ID_EX_Imm <= 0;
    ID_EX_Instr <= 0;

    ID_EX_ASel <= 0;
    ID_EX_BSel <= 0;
    ID_EX_ALUSel <= 0;

    ID_EX_MemR <= 0;
    ID_EX_MemW <= 0;
    ID_EX_WBSel <= 0;
    ID_EX_RegWEn <= 0;
  end
  else begin
    ID_EX_RD1 <= ID_RD1;
    ID_EX_RD2 <= ID_RD2;
    ID_EX_PC  <= ID_PC;
    ID_EX_Imm <= ID_Imm;
    ID_EX_Instr <= ID_Instr;

    ID_EX_ASel <= ID_ASel;
    ID_EX_BSel <= ID_BSel;
    ID_EX_ALUSel <= ID_ALUSel;

    ID_EX_MemR <= ID_MemR;
    ID_EX_MemW <= ID_MemW;

    ID_EX_WBSel <= ID_WBSel;
    ID_EX_RegWEn <= ID_RegWEn;
  end
end

endmodule