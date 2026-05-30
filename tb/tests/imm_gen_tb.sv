`timescale 1ns/1ps

module imm_gen_tb;

    logic [31:0] instruction;
    logic [31:0] immediate;

    // Instantiate DUT
    imm_gen dut (
        .instruction(instruction),
        .immediate(immediate)
    );

    task check_imm(

        input logic [31:0] expected,
        input string msg

    );

        begin

            if (immediate !== expected) begin

                $display("ERROR: %s", msg);
                $display("Expected = %0d, Got = %0d",
                         expected, immediate);

                $fatal;

            end

            else begin

                $display("PASS: %s", msg);

            end

        end

    endtask

    initial begin

        // ADDI x1, x0, 5

        instruction = 32'h00500093;

        #1;

        check_imm(32'd5, "I-Type immediate");

        // SW immediate = 8

        instruction = 32'h00112423;

        #1;

        check_imm(32'd8, "S-Type immediate");


        $display("====================================");
        $display("All immediate generator tests passed!");
        $display("====================================");

        $stop;

    end

endmodule