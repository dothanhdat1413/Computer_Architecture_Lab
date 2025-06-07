module control_unit #(
  parameter OP_EFF_WIDTH = 5,     //Just need 5 bits from opcode to decode
  parameter FUNCT3_WIDTH = 3,
  parameter ALUCTRL_WIDTH = 4
)(
  input  [OP_EFF_WIDTH-1:0]   opcode_eff,     //Inst[6:0]
  input                       funct7_fif,     //Just need funct7[5] to decode
  input  [FUNCT3_WIDTH-1:0]   funct3,         //Inst[14:12]
  input                       BrEq,
  input                       BrLT,

  output                      PCSel,
  output [2:0]                ImmSel,
	output                      RegWEn,
	output                      BrUn,
	output                      ASel,
  output                      BSel,
  output [ALUCTRL_WIDTH-1:0]  ALUSel,
  output                      MemRW, //Read = 0, Write = 1 (Default: Read)
  output [1:0]                WBSel, // WB


  input [31:0]                ID_EX_Instr,

  output                      IF_flush,
  output                      ID_flush,
  output                      EX_flush 

);

wire arithmetic;

main_decoder_branch_prediction #(
    .OP_EFF_WIDTH(OP_EFF_WIDTH),
    .FUNCT3_WIDTH(FUNCT3_WIDTH)
)
MainDecodeBranchPrediction (
    .opcode_eff(opcode_eff),
    .funct3(funct3),
    .BrEq(BrEq),
    .BrLT(BrLT),
    .PCSel(PCSel),
    .ImmSel(ImmSel),
    .RegWEn(RegWEn),
    .BrUn(BrUn),
    .ASel(ASel),
    .BSel(BSel),
    .MemRW(MemRW),
    .WBSel(WBSel),
    .arithmetic(arithmetic),
    .i_type(i_type),
    .ID_EX_Instr(ID_EX_Instr),
    .IF_flush(IF_flush),
    .ID_flush(ID_flush),
    .EX_flush(EX_flush)
);

ALU_decoder #(
    .FUNCT3_WIDTH(FUNCT3_WIDTH),
    .ALUCTRL_WIDTH(ALUCTRL_WIDTH)
)
ALUDecode (
    .arithmetic(arithmetic),
    .funct3(funct3),
    .funct7_fif(funct7_fif),
    .i_type(i_type),
    .ALUSel(ALUSel)
);

endmodule
