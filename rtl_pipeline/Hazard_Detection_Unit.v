module Hazard_Detection_Unit(
    input EX_MemR,
    input [4:0] ID_Rs1,
    input [4:0] ID_Rs2,
    input [4:0] EX_Rd,
    output reg ID_EX_control_unit_select,
    output reg PC_Write_en,
    output reg IF_ID_Write_en
    );

    // Handle lw data hazard
    always @(*) begin
        if (EX_Memread &&  (EX_Rd != 0) && ((EX_Rd == ID_Rs1) || (EX_Rd == ID_Rs2))) begin // LW hazard detected
            ID_EX_control_unit_select = 1'b1;
            PC_Write_en = 1'b0;
            IF_ID_Write_en = 1'b0;
        end else begin
            ID_EX_control_unit_select = 1'b0;
            PC_Write_en = 1'b1;
            IF_ID_Write_en = 1'b1;
        end
    end
    
endmodule
