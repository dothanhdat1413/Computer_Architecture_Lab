module test_Imm_Gen();
    
    reg [2:0] opcode;
    reg [20:0] imm;
    wire [31:0] imm_out;

    Imm_Gen DUT(
        .opcode(opcode),
        .imm(imm),
        .imm_out(imm_out)
    );

    localparam I_S_FORMAT = 3'b001;
    localparam B_FORMAT   = 3'b011;
    localparam U_FORMAT   = 3'b100;

    initial begin
        $dumpfile("../sim/dumpfile/Imm_Gen_wave.vcd");
        $dumpvars(0, test_Imm_Gen);
    end

    initial begin
        // Test I/S format: sign-extend 12-bit immediate
        imm = 21'b0000_0000_0001_0101_0101_1; // 12-bit value = 0x155, sign bit = 1
        opcode = I_S_FORMAT;
        #10;
        $display("I/S Format: imm = %b => imm_out = %h", imm[11:0], imm_out);

        // Test B format: sign-extend 13-bit (imm[12:1]) << 1
        imm = 21'b0000_0000_0010_1010_1010_1; // B-type: bits [12:1] = 0x155
        opcode = B_FORMAT;
        #10;
        $display("B Format: imm = %b => imm_out = %h", imm[11:0], imm_out);

        // Test U format: upper 20 bits shifted left 12 bits
        imm = 21'hABCDE; // Just an example value
        opcode = U_FORMAT;
        #10;
        $display("U Format: imm = %h => imm_out = %h", imm, imm_out);

        // Test default case
        opcode = 3'b111;
        imm = 21'h00000;
        #10;
        $display("Default: imm = %h => imm_out = %h", imm, imm_out);

        $finish;
    end
    
endmodule