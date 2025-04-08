module ALU(
    input [5:0] opcode,
    input [31:0] operand_0,
    input [31:0] operand_1,
    output reg [31:0] result,
);

localparam ADD              = 5'b00000; 
localparam SUB              = 5'b00001; 
localparam AND              = 5'b00010;
localparam OR               = 5'b00011;
localparam XOR              = 5'b00100;
localparam SHL_LOGICAL      = 5'b00110;
localparam SHR_LOGICAL      = 5'b00111;
localparam SHR_ARITHMETIC   = 5'b01000;


always @(*) begin
    case (opcode)
        ADD: result = operand_0 + operand_1;
        SUB: result = operand_0 - operand_1;
        
        AND: result = operand_0 & operand_1;
        OR:  result = operand_0 | operand_1;
        XOR: result = operand_0 ^ operand_1;

        SHL_LOGICAL: result = operand_0 << operand_1[4:0];
        SHR_LOGICAL: result = operand_0 >> operand_1[4:0];
        SHR_ARITHMETIC: result = operand_0 >>> operand_1[4:0];
        
        default: result = 32'b0;
    endcase
end


endmodule