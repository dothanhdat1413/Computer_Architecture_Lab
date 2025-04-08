module Imm_Gen(
    input [2:0] opcode,
    input [20:0] imm,
    output reg [31:0] imm_out,
);

localparam R_FORMAT = 3'b000; // R-type instructions
localparam I_FORMAT = 3'b001;
localparam S_FORMAT = 3'b010;
localparam B_FORMAT = 3'b011;
localparam U_FORMAT = 3'b100;



endmodule
