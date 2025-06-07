module branch_forward_unit (
    input  [4:0] rs1_ID,
    input  [4:0] rs2_ID,
    input  [4:0] rd_EX,
    input        reg_write_EX,
    input  [4:0] rd_MEM,
    input        reg_write_MEM,

    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);

always @(*) begin
    forwardA = 2'b00;
    forwardB = 2'b00;

    // Forward from EX stage
    if (reg_write_EX && (rd_EX != 0) && (rd_EX == rs1_ID)) begin
        forwardA = 2'b10;
    end
    if (reg_write_EX && (rd_EX != 0) && (rd_EX == rs2_ID)) begin
        forwardB = 2'b10;
    end

    // Forward from MEM stage
    if (reg_write_MEM && (rd_MEM != 0) && (rd_MEM == rs1_ID) &&
        !(reg_write_EX && (rd_EX != 0) && (rd_EX == rs1_ID))) begin
        forwardA = 2'b01;
    end
    if (reg_write_MEM && (rd_MEM != 0) && (rd_MEM == rs2_ID) &&
        !(reg_write_EX && (rd_EX != 0) && (rd_EX == rs2_ID))) begin
        forwardB = 2'b01;
    end
end

endmodule
