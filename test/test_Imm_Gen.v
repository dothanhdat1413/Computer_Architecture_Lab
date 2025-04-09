module test_Imm_Gen();
    
    reg [2:0] opcode;
    reg [20:0] imm;
    wire [31:0] imm_out;

    Imm_Gen DUT(
        .opcode(opcode),
        .imm(imm),
        .imm_out(imm_out)
    );


endmodule