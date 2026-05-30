module instr_mem (

    input  logic [31:0] addr,

    output logic [31:0] instruction

);

    // 256 x 32-bit instruction memory

    logic [31:0] memory [0:255];

    initial begin

        // ADDI x1, x0, 100
        // x1 = 100
        memory[0] = 32'h06400093;

        // ADDI x2, x0, 42
        // x2 = 42
        memory[1] = 32'h02A00113;

        // SW x2, 0(x1)
        // MEM[100] = 42
        memory[2] = 32'h0020A023;

        // LW x3, 0(x1)
        // x3 = MEM[100]
        memory[3] = 32'h0000A183;

        // NOP
        memory[4] = 32'h00000013;

    end

    // Word-aligned instruction fetch

    assign instruction = memory[addr[31:2]];

endmodule