module Imm_Gen (
    Instr,
    ImmSel,
    Imm
);

parameter R = 3'b000;
parameter I = 3'b001;
parameter S = 3'b010;
parameter B = 3'b011;
parameter U = 3'b100;
parameter J = 3'b101;

input [31:0] Instr;
input [2:0] ImmSel;
output reg [31:0] Imm;

always @(*) begin
    case (ImmSel)
        I: begin
            Imm={{21{Instr[31]}}, Instr[30:20]};
        end
        S: begin
            Imm={{21{Instr[31]}}, Instr[30:25], Instr[11:7]};
        end
        U: begin
            Imm={Instr[31], Instr[30:12], {12{1'b0}}};
        end
        B: begin
            Imm={{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
        end
        J: begin
            Imm={{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};
        end
        default: 
            Imm= 32'h00000000;
    endcase
end

endmodule
