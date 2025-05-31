module EX_MEM (
  input clk,
  input rst_n,
  input [31:0] EX_PC,
  input [31:0] EX_ALU_Result, 
  input [31:0] EX_RD2,
  input [31:0] EX_Instr,

  input [1:0] EX_WBSel,
  input EX_RegWEn,

  input EX_MemR,
  input EX_MemW,

  output reg [31:0] EX_MEM_PC,
  output reg [31:0] EX_MEM_ALU_Result,
  output reg [31:0] EX_MEM_RD2,
  output reg [31:0] EX_MEM_Instr

  output reg [1:0] EX_MEM_WBSel,
  output reg EX_MEM_RegWEn,

  output reg EX_MEM_MemR,
  output reg EX_MEM_MemW
);

always @( posedge clk, negedge rst_n ) begin 
  if (~rst_n) begin
    EX_MEM_PC         <= 0;
    EX_MEM_ALU_Result <= 0;
    EX_MEM_RD2        <= 0; 
    EX_MEM_Instr      <= 0;

    EX_MEM_WBSel      <= 0;
    EX_MEM_RegWEn     <= 0;

    EX_MEM_MemR       <= 0;
    EX_MEM_MemW       <= 0;
  end

  else begin
    EX_MEM_PC         <= EX_PC;
    EX_MEM_ALU_Result <= EX_ALU_Result;
    EX_MEM_RD2        <= EX_RD2; 
    EX_MEM_Instr      <= EX_Instr;     

    EX_MEM_WBSel      <= EX_WBSel;
    EX_MEM_RegWEn     <= EX_RegWEn;
    
    EX_MEM_MemR       <= EX_MemR;
    EX_MEM_MemW       <= EX_MemW;   
  end
end

endmodule