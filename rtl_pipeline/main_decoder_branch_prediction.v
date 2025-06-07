module main_decoder_branch_prediction#(
    parameter OP_EFF_WIDTH = 5,     //Just need 5 bits from opcode
    parameter FUNCT3_WIDTH = 3,

    parameter I_TYPE = 0,
    parameter S_TYPE = 1,
    parameter B_TYPE = 2,
    parameter J_TYPE = 3,
    parameter U_TYPE = 4
)
(
    input  [OP_EFF_WIDTH-1:0]   opcode_eff,     //Inst[6:0]
    input  [FUNCT3_WIDTH-1:0]   funct3,         //Inst[14:12]
    input                       BrEq,
    input                       BrLT,

    output reg          PCSel,      //+4 = 0, ALU = 1 (Default: +4)
    output reg [2:0]    ImmSel,
	output reg          RegWEn,
	output reg          BrUn,
	output reg          ASel,       //Reg = 0, PC = 1 (Default: Reg)
    output reg          BSel,       //Reg = 0, Imm = 1 (Default: Reg)
    output reg          MemRW,      //Read = 0, Write = 1 (Default: Read)
    output reg [1:0]    WBSel,      //Mem = 0, ALU = 1, PC+4 = 2, ImmGen = 3
    output reg          arithmetic,
    output reg          i_type,


    input [31:0]        ID_EX_Instr,

    output reg          IF_flush,
    output reg          ID_flush,
    output reg          EX_flush


);

always@(opcode_eff, funct3, BrEq, BrLT) begin

    if (ID_EX_Instr[6:0] == 7'b1100011) begin // B-Type: branch
        if (ID_EX_Instr[14]) begin // funct3[2] = 1 => BLT, BGE
            if (BrLT) begin
                if (~ID_EX_Instr[12]) begin // BLT right
                    PCSel    = 1;
                    IF_flush = 1;
                    ID_flush = 1;
                    EX_flush = 1;
                end
            end else begin
                if (ID_EX_Instr[12]) begin // BGE right
                    PCSel    = 1;
                    IF_flush = 1;
                    ID_flush = 1;
                    EX_flush = 1;
                end
            end
        end else begin // funct3[2] = 0 => BEQ, BNE
            if (BrEq) begin
                if (~ID_EX_Instr[12]) begin // BEQ right
                    PCSel    = 1;
                    IF_flush = 1;
                    ID_flush = 1;
                    EX_flush = 1;
                end
            end else begin
                if (ID_EX_Instr[12]) begin // BNE rỉght
                    PCSel    = 1;
                    IF_flush = 1;
                    ID_flush = 1;
                    EX_flush = 1;
                end
            end
        end else begin
            PCSel           = 0; 
            IF_flush        = 0;
            ID_flush        = 0;
            EX_flush        = 0;
        end

    end else begin
        case (opcode_eff)
            5'b01100: begin          //R-Type
                PCSel           = 0;
                ImmSel          = 0;
                RegWEn          = 1;
                BrUn            = 0;
                ASel            = 0;
                BSel            = 0;
                MemRW           = 0;
                WBSel           = 1;
                arithmetic      = 1;
                i_type          = 0;
            end
            5'b00100: begin          //I-Type Arithmetic
                PCSel           = 0;
                ImmSel          = I_TYPE;
                RegWEn          = 1;
                BrUn            = 0;
                ASel            = 0;
                BSel            = 1;
                MemRW           = 0;
                WBSel           = 1;
                arithmetic      = 1;
                i_type          = 1;
            end
            5'b00000: begin          //I-Type Load
                PCSel           = 0;
                ImmSel          = I_TYPE;
                RegWEn          = 1;
                BrUn            = 0;
                ASel            = 0;
                BSel            = 1;
                MemRW           = 0;
                WBSel           = 0;
                arithmetic      = 0;
                i_type          = 1;
            end
            5'b01000: begin          //S-Type
                PCSel           = 0;
                ImmSel          = S_TYPE;
                RegWEn          = 0;
                BrUn            = 0;
                ASel            = 0;
                BSel            = 1;
                MemRW           = 1;
                WBSel           = 0;
                arithmetic      = 0;
                i_type          = 0;
            end
            5'b11000: begin          //B-Type
                ImmSel          = B_TYPE;
                RegWEn          = 0;
                ASel            = 1;
                BSel            = 1;
                MemRW           = 0;
                WBSel           = 0;
                arithmetic      = 0;
                BrUn            = funct3[1];
                i_type          = 0;

                PCSel = 0; // Prediction default to +4

            end
            5'b11011: begin          //J-Type
                PCSel           = 1;
                ImmSel          = J_TYPE;
                RegWEn          = 1;
                BrUn            = 0;
                ASel            = 1;
                BSel            = 1;
                MemRW           = 0;
                WBSel           = 2;
                arithmetic      = 0;
                i_type          = 0;
            end
            5'b11001: begin          //I-Type Jump
                PCSel           = 1;
                ImmSel          = I_TYPE;
                RegWEn          = 1;
                BrUn            = 0;
                ASel            = 0;
                BSel            = 1;
                MemRW           = 0;
                WBSel           = 2;
                arithmetic      = 0;
                i_type          = 1;
            end
            5'b00101: begin          //U-Type auipc
                PCSel           = 0;
                ImmSel          = U_TYPE;
                RegWEn          = 1;
                BrUn            = 0;
                ASel            = 1;
                BSel            = 1;
                MemRW           = 0;
                WBSel           = 1;
                arithmetic      = 0;
                i_type          = 0;
            end
            5'b01101: begin          //U-Type lui
                PCSel           = 0;
                ImmSel          = U_TYPE;
                RegWEn          = 1;
                BrUn            = 0;
                ASel            = 0;
                BSel            = 0;
                MemRW           = 0;
                WBSel           = 3;
                arithmetic      = 0;
                i_type          = 0;
            end
            default: begin          //Default
                PCSel           = 0;
                ImmSel          = 0;
                RegWEn          = 0;
                BrUn            = 0;
                ASel            = 0;
                BSel            = 0;
                MemRW           = 0;
                WBSel           = 0;
                arithmetic      = 0;
                i_type          = 0;
            end
        endcase
    end

end

always@(*) begin
    ID_flush = 0;
    EX_flush = 0;

    if(ID_EX_Instr[6:0] == 7'b11000) begin // B-Type
        if (funct3[2]) begin // bge and blt
            if (BrLT) begin
                PCSel = ~funct3[0];
            end else begin
                PCSel = funct3[0];
            end
        end else begin // beq and bne
            if (BrEq) begin
                PCSel = ~funct3[0];
            end else begin
                PCSel = funct3[0];
            end
        end
    end else if (opcode_eff == 5'b11011) begin // J-Type
        PCSel = 1; // Always jump to target address
    end
end

endmodule