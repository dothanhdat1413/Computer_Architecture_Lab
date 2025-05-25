module HazardDetectionUnit(
    input ID_EX_Memread,
    input [4:0] IF_ID_Rs1,
    input [4:0] IF_ID_Rs2,
    input [4:0] ID_EX_Rd,
    output reg control_unit_select,
    output reg PC_Write,
    output reg IF_ID_Write
    );
    // Pipeline stall signals
    always @(*) begin
        // Hazard detection logic
        if (ID_EX_Memread &&  (ID_EX_Rd != 0) && ((ID_EX_Rd == IF_ID_Rs1) || (ID_EX_Rd == IF_ID_Rs2))) begin
            control_unit_select = 1'b1; // Control unit select signal
            PC_Write = 1'b0; // Disable PC write
            IF_ID_Write = 1'b0; // Disable IF/ID write
        end else begin
            control_unit_select = 1'b0; // No hazard detected
            PC_Write = 1'b1; // Enable PC write
            IF_ID_Write = 1'b1; // Enable IF/ID write
        end
    end
    
endmodule