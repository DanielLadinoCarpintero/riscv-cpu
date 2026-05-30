`timescale 1ns/1ps

module instr_mem_tb;

    logic [31:0] addr;
    logic [31:0] instruction;

    // Instantiate DUT
    instr_mem dut (
        .addr(addr),
        .instruction(instruction)
    );

    task check_instruction(
        input logic [31:0] expected,
        input string msg
    );

        begin

            if (instruction !== expected) begin
                $display("ERROR: %s", msg);
                $display("Expected = %h, Got = %h",
                         expected, instruction);
                $fatal;
            end

            else begin
                $display("PASS: %s", msg);
            end

        end

    endtask

    initial begin

        // Instruction 0

        addr = 32'd0;

        #1;

        check_instruction(
            32'h00500093,
            "Fetched instruction 0"
        );

        // Instruction 1

        addr = 32'd4;

        #1;

        check_instruction(
            32'h00A00113,
            "Fetched instruction 1"
        );

        // Instruction 2

        addr = 32'd8;

        #1;

        check_instruction(
            32'h002081B3,
            "Fetched instruction 2"
        );

        //----------------------------------------

        $display("====================================");
        $display("All instruction memory tests passed!");
        $display("====================================");

        $stop;

    end

endmodule