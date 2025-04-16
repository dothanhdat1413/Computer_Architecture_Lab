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
        $dumpfile("../sim/dumpfile/Branch_Comp_wave.vcd");
        $dumpvars(0, test_Branch_Comp);
    end

    initial begin
        // Test 1: Equal values (signed and unsigned)
        operand_0 = 32'd100;
        operand_1 = 32'd100;
        BrUn = 0; #10;
        $display("Signed Eq: operand_0 = %0d, operand_1 = %0d, BrEq = %b, BrLT = %b", operand_0, operand_1, BrEq, BrLT);

        BrUn = 1; #10;
        $display("Unsigned Eq: operand_0 = %0d, operand_1 = %0d, BrEq = %b, BrLT = %b", operand_0, operand_1, BrEq, BrLT);

        // Test 2: operand_0 < operand_1 (signed)
        operand_0 = -32'd10;
        operand_1 = 32'd5;
        BrUn = 0; #10;
        $display("Signed LT: operand_0 = %0d, operand_1 = %0d, BrEq = %b, BrLT = %b", $signed(operand_0), $signed(operand_1), BrEq, BrLT);

        // Test 3: operand_0 < operand_1 (unsigned)
        operand_0 = 32'hFFFFFFF0;  // large unsigned number (4294967280)
        operand_1 = 32'd5;
        BrUn = 1; #10;
        $display("Unsigned LT: operand_0 = %0d, operand_1 = %0d, BrEq = %b, BrLT = %b", operand_0, operand_1, BrEq, BrLT);

        // Test 4: operand_0 > operand_1
        operand_0 = 32'd200;
        operand_1 = 32'd100;
        BrUn = 0; #10;
        $display("Signed GT: operand_0 = %0d, operand_1 = %0d, BrEq = %b, BrLT = %b", operand_0, operand_1, BrEq, BrLT);

        // Test 5: operand_0 = operand_1 = 0
        operand_0 = 32'd0;
        operand_1 = 32'd0;
        BrUn = 1; #10;
        $display("Zero: operand_0 = %0d, operand_1 = %0d, BrEq = %b, BrLT = %b", operand_0, operand_1, BrEq, BrLT);

        $finish;
    end

endmodule