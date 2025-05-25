module MEM_WB (
  input clk, 
  input rst_n,
  input [31:0] MEM_ALU_Result,
  input [31:0] MEM_PC_Plus4,
  input [31:0] MEM_Read_Data,
  input [31:0] MEM_Instr,
  output reg [31:0] MEM_WB_ALU_Result,
  output reg [31:0] MEM_WB_PC_Plus4,
  output reg [31:0] MEM_WB_Read_Data,
  output reg [31:0] MEM_WB_Instr
);

always @( posedge clk, negedge rst_n ) begin
  if (~rst_n) begin
    MEM_WB_ALU_Result <= 0;
    MEM_WB_PC_Plus4 <= 0;
    MEM_WB_Read_Data <= 0; 
    MEM_WB_Instr <= 0;
  end
  else begin
    MEM_WB_ALU_Result <= MEM_ALU_Result;
    MEM_WB_PC_Plus4 <= MEM_PC_Plus4;
    MEM_WB_Read_Data <= MEM_Read_Data; 
    MEM_WB_Instr <= MEM_Instr;
  end
end

endmodule