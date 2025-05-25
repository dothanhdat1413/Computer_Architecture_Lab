module Hazard_Detection_Unit(
    input ID_EX_Memread,
    input [4:0] IF_ID_Rs1,
    input [4:0] IF_ID_Rs2,
    input [4:0] ID_EX_Rd,
    output reg control_unit_select,
    output reg PC_Write,
    output reg IF_ID_Write
    );
//  Control signals need to be synchronized with the control unit and pipeline register
    always @(*) begin
        if (ID_EX_Memread &&  (ID_EX_Rd != 0) && ((ID_EX_Rd == IF_ID_Rs1) || (ID_EX_Rd == IF_ID_Rs2))) begin
            control_unit_select = 1'b1;
            PC_Write = 1'b0;
            IF_ID_Write = 1'b0;
        end else begin
            control_unit_select = 1'b0;
            PC_Write = 1'b1;
            IF_ID_Write = 1'b1;
        end
    end
    
endmodule
