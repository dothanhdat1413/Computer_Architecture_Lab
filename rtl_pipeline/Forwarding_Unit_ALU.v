module Forwarding_Unit_ALU(
    input [4:0] ID_EX_rs1,
    input [4:0] ID_EX_rs2,
    input [4:0] EX_MEM_rd,
    input [4:0] MEM_WB_rd,
    input EX_MEM_RegWrite,
    input EX_MEM_MemtoReg,
    input MEM_WB_RegWrite,
    input MEM_WB_MemtoReg,

    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);

parameter FORWARD_NONE = 2'b00;
parameter FORWARD_EX_MEM_ALU_result = 2'b10;
parameter FORWARD_MEM_WB_ALU_result_or_Data_memory = 2'b01;

always @(*) begin    

    if (EX_MEM_RegWrite && 
        (EX_MEM_rd != 0) && 
        (EX_MEM_rd == ID_EX_rs1)) begin     // Forwarding từ EX/MEM stage cho rs1
            ForwardA = FORWARD_EX_MEM_ALU_result;
        end 
    else if (EX_MEM_RegWrite && 
            (EX_MEM_rd != 0) && 
            (EX_MEM_rd == ID_EX_rs2)) begin     // Forwarding từ EX/MEM stage cho rs2
            
            ForwardB = FORWARD_EX_MEM_ALU_result;
        end 
    else if (MEM_WB_RegWrite && 
            (MEM_WB_rd != 0) && 
            !(EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs1)) &&
            (MEM_WB_rd == ID_EX_rs1)) begin     // Forwarding từ MEM/WB stage cho rs1
            
            ForwardA = FORWARD_MEM_WB_ALU_result_or_Data_memory;
        end  
    else if (MEM_WB_RegWrite && 
            (MEM_WB_rd != 0) && 
            !(EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs2)) &&
            (MEM_WB_rd == ID_EX_rs2)) begin    // Forwarding từ MEM/WB stage cho rs2
            
            ForwardB = FORWARD_MEM_WB_ALU_result_or_Data_memory;
    end else begin
        ForwardA = FORWARD_NONE; 
        ForwardB = FORWARD_NONE; 
        end
end

endmodule