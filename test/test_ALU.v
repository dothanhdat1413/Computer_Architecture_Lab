module test_ALU();
    reg [3:0] opcode;
    reg [31:0] operand_0;
    reg [31:0] operand_1;
    wire [31:0] result;

    ALU DUT(
        .opcode(opcode),
        .operand_0(operand_0),
        .operand_1(operand_1),
        .result(result)
    );

//__________________________ALU Opcodes_____________________________//
    localparam ADD              = 4'b0000; 
    localparam SUB              = 4'b0001; 
    localparam AND              = 4'b0010;
    localparam OR               = 4'b0011;
    localparam XOR              = 4'b0100;
    localparam SHL_LOGICAL      = 4'b0110;
    localparam SHR_LOGICAL      = 4'b0111;
    localparam SHR_ARITHMETIC   = 4'b1000;
    localparam LESS_THAN    = 4'b1001;

//______________________Testcase location___________________________//
    localparam ADD_OPERAND_0            = "./ADD_OPERAND_0.txt";
    localparam ADD_OPERAND_1            = "./ADD_OPERAND_1.txt";
    localparam ADD_RESULT               = "./ADD_RESULT.txt";

    localparam SUB_OPERAND_0            = "./SUB_OPERAND_0.txt";
    localparam SUB_OPERAND_1            = "./SUB_OPERAND_1.txt";
    localparam SUB_RESULT               = "./SUB_RESULT.txt";

    localparam BITWISE_OPERAND_0        = "./AND_OPERAND_0.txt";
    localparam BITWISE_OPERAND_1        = "./AND_OPERAND_1.txt";
    localparam AND_RESULT               = "./AND_RESULT.txt";
    localparam OR_RESULT                = "./OR_RESULT.txt";
    localparam XOR_RESULT               = "./XOR_RESULT.txt";

    localparam SHL_LOGICAL_OPERAND_0    = "./SHL_LOGICAL_OPERAND_0.txt";
    localparam SHL_LOGICAL_OPERAND_1    = "./SHL_LOGICAL_OPERAND_1.txt";
    localparam SHL_LOGICAL_RESULT       = "./SHL_LOGICAL_RESULT.txt";

    localparam SHR_LOGICAL_OPERAND_0    = "./SHR_LOGICAL_OPERAND_0.txt";
    localparam SHR_LOGICAL_OPERAND_1    = "./SHR_LOGICAL_OPERAND_1.txt";
    localparam SHR_LOGICAL_RESULT       = "./SHR_LOGICAL_RESULT.txt";

    localparam SHR_ARITHMETIC_OPERAND_0 = "./SHR_ARITHMETIC_OPERAND_0.txt";
    localparam SHR_ARITHMETIC_OPERAND_1 = "./SHR_ARITHMETIC_OPERAND_1.txt";
    localparam SHR_ARITHMETIC_RESULT    = "./SHR_ARITHMETIC_RESULT.txt";

    localparam LESS_THAN_OPERAND_0      = "./LESS_THAN_OPERAND_0.txt";
    localparam LESS_THAN_OPERAND_1      = "./LESS_THAN_OPERAND_1.txt";
    localparam LESS_THAN_RESULT         = "./LESS_THAN_RESULT.txt";

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
    end

//_______________________Drive input task___________________________//
    task drive_input;
        input [3:0] opcode_t;
        input [31:0] operand_0_t;
        input [31:0] operand_1_t;
        begin
            operand_0 = operand_0_t;
            operand_1 = operand_1_t;
            opcode = opcode_t;
            #1;
        end
    endtask

//__________________________Run testcase____________________________//
    integer i;
    initial begin
        for(i = 0; i < 1000; i = i+1) begin
            drive_input(ADD, ADD_operand_0[i], ADD_operand_1[i]);
        end
        
        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SUB, SUB_operand_0[i], SUB_operand_1[i]);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(AND, BITWISE_operand_0[i], BITWISE_operand_1[i]);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(OR, BITWISE_operand_0[i], BITWISE_operand_1[i]);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(XOR, BITWISE_operand_0[i], BITWISE_operand_1[i]);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SHL_LOGICAL, SHL_LOGICAL_operand_0[i], SHL_LOGICAL_operand_1[i]);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SHR_LOGICAL, SHR_LOGICAL_operand_0[i], SHR_LOGICAL_operand_1[i]);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(SHR_ARITHMETIC, SHR_ARITHMETIC_operand_0[i], SHR_ARITHMETIC_operand_1[i]);
        end

        for(i = 0; i < 1000; i = i+1) begin
            drive_input(LESS_THAN, LESS_THAN_operand_0[i], LESS_THAN_operand_1[i]);
        end

        $finish;
    end
//__________________________Check output____________________________//
    always @(result) begin
        case (opcode)
            ADD: begin
                if (result !== operand_0 + operand_1) begin
                    $display("ADD failed: %d + %d != %d", operand_0, operand_1, result);
                end else begin
                    $display("ADD passed: %d + %d = %d", operand_0, operand_1, result);
                end
            end
            SUB: begin
                if (result !== operand_0 - operand_1) begin
                    $display("SUB failed: %d - %d != %d", operand_0, operand_1, result);
                end else begin
                    $display("SUB passed: %d - %d = %d", operand_0, operand_1, result);
                end
            end
            AND: begin
                if (result !== operand_0 & operand_1) begin
                    $display("AND failed: %d & %d != %d", operand_0, operand_1, result);
                end else begin
                    $display("AND passed: %d & %d = %d", operand_0, operand_1, result);
                end
            end
            OR: begin
                if (result !== operand_0 | operand_1) begin
                    $display("OR failed: %d | %d != %d", operand_0, operand_1, result);
                end else begin
                    $display("OR passed: %d | %d = %d", operand_0, operand_1, result);
                end
            end
            XOR: begin
                if (result !== operand_0 ^ operand_1) begin
                    $display("XOR failed: %d ^ %d != %d", operand_0, operand_1, result);
                end else begin
                    $display("XOR passed: %d ^ %d = %d", operand_0, operand_1, result);
                end
            end
            SHL_LOGICAL: begin
                if (result !== (operand_0 << 1)) begin // Logical shift left by 1 bit.
                    $display("SHL_LOGICAL failed: %b << 1 != %b", operand_0, result);
                end else begin
                    $display("SHL_LOGICAL passed: %b << 1 = %b", operand_0, result);
                end
            end
            SHR_LOGICAL: begin
                if (result !== (operand_0 >> 1)) begin // Logical shift right by 1 bit.
                    $display("SHR_LOGICAL failed: %b >> 1 != %b", operand_0, result);
                end else begin
                    $display("SHR_LOGICAL passed: %b >> 1 = %b", operand_0, result);
                end
            end
            SHR_ARITHMETIC: begin
                if (result !== ($signed(operand_0) >>> 1)) begin // Arithmetic shift right by 1 bit.
                    $display("SHR_ARITHMETIC failed: %b >>> 1 != %b", operand_0, result);
                end else begin
                    $display("SHR_ARITHMETIC passed: %b >>> 1 = %b", operand_0, result);
                end
            end
            LESS_THAN: begin
                if (result !== ($signed(operand_0) < $signed(operand_1) ? 32'b1 : 32'b0)) begin // Less than comparison.
                    $display("LESS_THAN failed: %d < %d != %b", operand_0, operand_1, result);
                end else begin
                    $display("LESS_THAN passed: %d < %d = %b", operand_0, operand_1, result);
                end
            end
        endcase
    end 

endmodule
