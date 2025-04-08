module Imm_Gen(
    input [2:0] opcode,
    input [20:0] imm,
    output reg [31:0] imm_out,
);

localparam I_S_FORMAT = 3'b001;
localparam B_FORMAT = 3'b011;
localparam U_FORMAT = 3'b100;


always @(*) begin
    case (opcode)
        I_S_FORMAT: imm_out = { {20{imm[11]}}, imm[11:0] };
        B_J_FORMAT: imm_out = { {19{imm[11]}}, imm[11:0], 1'b0 }; 
        U_FORMAT: imm_out = { imm, 12'b0 }; 
        default: imm_out = 32'b0; 
    endcase
end


endmodule
