module instr_mem (

    input  logic [31:0] addr,

    output logic [31:0] instruction

);

    // 256 x 32-bit instruction memory
    logic [31:0] memory [0:255];

    initial begin

        // Example program

        // ADDI x1, x0, 5
        memory[0] = 32'h00500093;

        // ADDI x2, x0, 10
        memory[1] = 32'h00A00113;

        // ADD x3, x1, x2
        memory[2] = 32'h002081B3;

        // NOP
        memory[3] = 32'h00000013;

    end

    // Word-aligned instruction fetch
    assign instruction = memory[addr[31:2]];

endmodule