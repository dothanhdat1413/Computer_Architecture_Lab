module IF_ID (
  input clk,
  input rst_n,

  input [4:0] IF_Rs1,
  input [4:0] IF_Rs2,


  input [31:0] IF_Instr,
  input [31:0] IF_PC,

  output reg [31:0] IF_ID_Instr,
  output reg [31:0] IF_ID_PC,

  output reg [4:0] IF_ID_Rs1,
  output reg [4:0] IF_ID_Rs2
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