module test_Branch_Comp();

    reg [31:0] operand_0;
    reg [31:0] operand_1;
    reg BrUn;
    wire BrEq;
    wire BrLT;

    Branch_Comp DUT(
        .operand_0(operand_0),
        .operand_1(operand_1),
        .BrUn(BrUn),
        .BrEq(BrEq),
        .BrLT(BrLT) 
    );

    initial begin
        
    end

    always @(*) begin
        
    end

endmodule