module test_ALU();
    reg [3:0] ALU_Sel;
    reg [31:0] operand_0;
    reg [31:0] operand_1;
    wire [31:0] result;

    ALU DUT(
        .ALU_Sel(ALU_Sel),
        .operand_0(operand_0),
        .operand_1(operand_1),
        .result(result)
    );

//__________________________ALU ALU_Sels_____________________________//
    localparam ADD              = 4'b0000; 
    localparam SUB              = 4'b0001; 
    localparam AND              = 4'b0010;
    localparam OR               = 4'b0011;
    localparam XOR              = 4'b0100;
    localparam SHL_LOGICAL      = 4'b0101;
    localparam SHR_LOGICAL      = 4'b0110;
    localparam SHR_ARITHMETIC   = 4'b0111;
    localparam LESS_THAN        = 4'b1000;

//______________________Testcase location___________________________//
    localparam ADD_OPERAND_0            = "../test/input_data/ADD_OPERAND_0.txt";
    localparam ADD_OPERAND_1            = "../test/input_data/ADD_OPERAND_1.txt";
    localparam ADD_RESULT               = "../test/input_data/ADD_RESULT.txt";

    localparam SUB_OPERAND_0            = "../test/input_data/SUB_OPERAND_0.txt";
    localparam SUB_OPERAND_1            = "../test/input_data/SUB_OPERAND_1.txt";
    localparam SUB_RESULT               = "../test/input_data/SUB_RESULT.txt";

    localparam BITWISE_OPERAND_0        = "../test/input_data/BITWISE_OPERAND_0.txt";
    localparam BITWISE_OPERAND_1        = "../test/input_data/BITWISE_OPERAND_1.txt";
    localparam AND_RESULT               = "../test/input_data/AND_RESULT.txt";
    localparam OR_RESULT                = "../test/input_data/OR_RESULT.txt";
    localparam XOR_RESULT               = "../test/input_data/XOR_RESULT.txt";

    localparam SHL_LOGICAL_OPERAND_0    = "../test/input_data/SHL_LOGICAL_OPERAND_0.txt";
    localparam SHL_LOGICAL_OPERAND_1    = "../test/input_data/SHL_LOGICAL_OPERAND_1.txt";
    localparam SHL_LOGICAL_RESULT       = "../test/input_data/SHL_LOGICAL_RESULT.txt";

    localparam SHR_LOGICAL_OPERAND_0    = "../test/input_data/SHR_LOGICAL_OPERAND_0.txt";
    localparam SHR_LOGICAL_OPERAND_1    = "../test/input_data/SHR_LOGICAL_OPERAND_1.txt";
    localparam SHR_LOGICAL_RESULT       = "../test/input_data/SHR_LOGICAL_RESULT.txt";

    localparam SHR_ARITHMETIC_OPERAND_0 = "../test/input_data/SHR_ARITHMETIC_OPERAND_0.txt";
    localparam SHR_ARITHMETIC_OPERAND_1 = "../test/input_data/SHR_ARITHMETIC_OPERAND_1.txt";
    localparam SHR_ARITHMETIC_RESULT    = "../test/input_data/SHR_ARITHMETIC_RESULT.txt";

    localparam LESS_THAN_OPERAND_0      = "../test/input_data/LESS_THAN_OPERAND_0.txt";
    localparam LESS_THAN_OPERAND_1      = "../test/input_data/LESS_THAN_OPERAND_1.txt";
    localparam LESS_THAN_RESULT         = "../test/input_data/LESS_THAN_RESULT.txt";

//________________Testcase input & Golden output____________________//
    reg [31:0] ADD_operand_0 [0:1000];
    reg [31:0] ADD_operand_1 [0:1000];
    reg [31:0] ADD_result [0:1000];

    reg [31:0] SUB_operand_0 [0:1000];
    reg [31:0] SUB_operand_1 [0:1000];
    reg [31:0] SUB_result [0:1000];

    reg [31:0] BITWISE_operand_0 [0:1000];
    reg [31:0] BITWISE_operand_1 [0:1000];
    reg [31:0] AND_result [0:1000];
    reg [31:0] OR_result [0:1000];
    reg [31:0] XOR_result [0:1000];

    reg [31:0] SHL_LOGICAL_operand_0 [0:1000];
    reg [31:0] SHL_LOGICAL_operand_1 [0:1000];
    reg [31:0] SHL_LOGICAL_result [0:1000];

    reg [31:0] SHR_LOGICAL_operand_0 [0:1000];
    reg [31:0] SHR_LOGICAL_operand_1 [0:1000];
    reg [31:0] SHR_LOGICAL_result [0:1000];

    reg [31:0] SHR_ARITHMETIC_operand_0 [0:1000];
    reg [31:0] SHR_ARITHMETIC_operand_1 [0:1000];
    reg [31:0] SHR_ARITHMETIC_result [0:1000];

    reg [31:0] LESS_THAN_operand_0 [0:1000];
    reg [31:0] LESS_THAN_operand_1 [0:1000];
    reg [31:0] LESS_THAN_result [0:1000];

integer result_ADD, result_SUB, result_AND, result_OR, result_XOR;
integer result_SHL_LOGICAL, result_SHR_LOGICAL, result_SHR_ARITHMETIC, result_LESS_THAN;

integer j;
//_____________________Read testcase input__________________________//
    initial begin
        $readmemh(ADD_OPERAND_0, ADD_operand_0);
        $readmemh(ADD_OPERAND_1, ADD_operand_1);
        $readmemh(ADD_RESULT, ADD_result);

        $readmemh(SUB_OPERAND_0, SUB_operand_0);
        $readmemh(SUB_OPERAND_1, SUB_operand_1);
        $readmemh(SUB_RESULT, SUB_result);

        $readmemh(BITWISE_OPERAND_0, BITWISE_operand_0);
        $readmemh(BITWISE_OPERAND_1, BITWISE_operand_1);
        // for(j = 0; j < 1000; j = j+1) begin
        //     $display("%d", BITWISE_operand_0[j]);
        //     // $display("%d", BITWISE_operand_1[j]);
        // end

        $readmemh(AND_RESULT, AND_result);
        $readmemh(OR_RESULT, OR_result);
        $readmemh(XOR_RESULT, XOR_result);

        $readmemh(SHL_LOGICAL_OPERAND_0, SHL_LOGICAL_operand_0);
        $readmemh(SHL_LOGICAL_OPERAND_1, SHL_LOGICAL_operand_1);
        $readmemh(SHL_LOGICAL_RESULT, SHL_LOGICAL_result);

        $readmemh(SHR_LOGICAL_OPERAND_0, SHR_LOGICAL_operand_0);
        $readmemh(SHR_LOGICAL_OPERAND_1, SHR_LOGICAL_operand_1);
        $readmemh(SHR_LOGICAL_RESULT, SHR_LOGICAL_result);

        $readmemh(SHR_ARITHMETIC_OPERAND_0, SHR_ARITHMETIC_operand_0);
        $readmemh(SHR_ARITHMETIC_OPERAND_1, SHR_ARITHMETIC_operand_1);
        $readmemh(SHR_ARITHMETIC_RESULT, SHR_ARITHMETIC_result);

        $readmemh(LESS_THAN_OPERAND_0, LESS_THAN_operand_0);
        $readmemh(LESS_THAN_OPERAND_1, LESS_THAN_operand_1);
        $readmemh(LESS_THAN_RESULT, LESS_THAN_result);
        
        $dumpfile("../sim/dumpfile/ALU_wave.vcd");
        $dumpvars(0, test_ALU);

        result_ADD = 0;
        result_SUB = 0;
        result_AND = 0;
        result_OR = 0;
        result_XOR = 0;
        result_SHL_LOGICAL = 0;
        result_SHR_LOGICAL = 0;
        result_SHR_ARITHMETIC = 0;
        result_LESS_THAN = 0;
    end

//_______________________Drive input task___________________________//
    task drive_input;
        input [3:0] ALU_Sel_t;
        input [31:0] operand_0_t;
        input [31:0] operand_1_t;
        begin
            operand_0 = operand_0_t;
            operand_1 = operand_1_t;
            ALU_Sel = ALU_Sel_t;
            #1;
        end
    endtask

    task check_output;
        input [31:0] expected_result;
        input [31:0] result;
        inout integer check_result;
        begin
            if (result !== expected_result) begin
                $display("Test failed: %d != %d", result, expected_result);
            end else begin
                check_result = check_result + 1;
            end
        end
    endtask

//__________________________Run testcase____________________________//

    integer i;
    initial begin
        for(i = 0; i < 1000; i = i+1) begin
            drive_input(ADD, ADD_operand_0[i], ADD_operand_1[i]);
            if(result!= ADD_result[i])$display("ADD %d: %d + %d = %d, expected: %d ", i, ADD_operand_0[i], ADD_operand_1[i], result, ADD_result[i]);
            check_output(ADD_result[i], result, result_ADD);
        end
        
        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SUB, SUB_operand_0[i], SUB_operand_1[i]);
            if(result!= SUB_result[i])$display("SUB %d: %d - %d = %d, expected: %d ", i, SUB_operand_0[i], SUB_operand_1[i], result, SUB_result[i]);
            check_output(SUB_result[i], result, result_SUB);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(AND, BITWISE_operand_0[i], BITWISE_operand_1[i]);
            if(result!= AND_result[i])$display("AND %d: %d & %d = %d, expected: %d ", i, BITWISE_operand_0[i], BITWISE_operand_1[i], result, AND_result[i]);
            check_output(AND_result[i], result, result_AND);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(OR, BITWISE_operand_0[i], BITWISE_operand_1[i]);
            if(result!= OR_result[i])$display("OR %d: %d | %d = %d, expected: %d ", i, BITWISE_operand_0[i], BITWISE_operand_1[i], result, OR_result[i]);
            check_output(OR_result[i], result, result_OR);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(XOR, BITWISE_operand_0[i], BITWISE_operand_1[i]);
            if(result!= XOR_result[i])$display("XOR %d: %d ^ %d = %d, expected: %d ", i, BITWISE_operand_0[i], BITWISE_operand_1[i], result, XOR_result[i]);
            check_output(XOR_result[i], result, result_XOR);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SHL_LOGICAL, SHL_LOGICAL_operand_0[i], SHL_LOGICAL_operand_1[i]);
            if(result!= SHL_LOGICAL_result[i])$display("SHL_LOGICAL %d: %b << %d = %b, expected: %b ", i, SHL_LOGICAL_operand_0[i], SHL_LOGICAL_operand_1[i][4:0], result, SHL_LOGICAL_result[i]);
            check_output(SHL_LOGICAL_result[i], result, result_SHL_LOGICAL);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SHR_LOGICAL, SHR_LOGICAL_operand_0[i], SHR_LOGICAL_operand_1[i]);
            if(result!= SHR_LOGICAL_result[i])$display("SHR_LOGICAL %d: %b >> %d = %b, expected: %b ", i, SHR_LOGICAL_operand_0[i], SHR_LOGICAL_operand_1[i][4:0], result, SHR_LOGICAL_result[i]);
            check_output(SHR_LOGICAL_result[i], result, result_SHR_LOGICAL);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SHR_ARITHMETIC, SHR_ARITHMETIC_operand_0[i], SHR_ARITHMETIC_operand_1[i]);
            if(result!= SHR_ARITHMETIC_result[i])$display("Failed SHR_ARITHMETIC %d: %b >>> %d = %b, expected: %b ", i, SHR_ARITHMETIC_operand_0[i], SHR_ARITHMETIC_operand_1[i][4:0], result, SHR_ARITHMETIC_result[i]);
            check_output(SHR_ARITHMETIC_result[i], result, result_SHR_ARITHMETIC);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(LESS_THAN, LESS_THAN_operand_0[i], LESS_THAN_operand_1[i]);
            if(result!= LESS_THAN_result[i])$display("LESS_THAN %d: %d < %d = %b, expected: %b ", i, $signed(LESS_THAN_operand_0[i]), $signed(LESS_THAN_operand_1[i]), result, LESS_THAN_result[i]);
            check_output(LESS_THAN_result[i], result, result_LESS_THAN);
        end

        #1;
        $display("Test completed.");
        $display("ADD: %d tests passed", result_ADD);
        $display("SUB: %d tests passed", result_SUB);
        $display("AND: %d tests passed", result_AND);
        $display("OR: %d tests passed", result_OR);
        $display("XOR: %d tests passed", result_XOR);
        $display("SHL_LOGICAL: %d tests passed", result_SHL_LOGICAL);
        $display("SHR_LOGICAL: %d tests passed", result_SHR_LOGICAL);
        $display("SHR_ARITHMETIC: %d tests passed", result_SHR_ARITHMETIC);
        $display("LESS_THAN: %d tests passed", result_LESS_THAN);
        $finish;
    end


endmodule
