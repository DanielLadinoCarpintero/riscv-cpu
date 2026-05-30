`timescale 1ns/1ps

module control_unit_tb;

    logic [6:0] opcode;

    logic       reg_write;
    logic       alu_src;
    logic       mem_read;
    logic       mem_write;
    logic       mem_to_reg;
    logic       branch;

    logic [1:0] alu_op;

    // Instantiate DUT
    control_unit dut (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op)
    );

    task check_control(

        input logic expected_reg_write,
        input logic expected_alu_src,
        input logic expected_mem_read,
        input logic expected_mem_write,
        input logic expected_mem_to_reg,
        input logic expected_branch,
        input logic [1:0] expected_alu_op,

        input string msg

    );

        begin

            if (
                reg_write !== expected_reg_write ||
                alu_src   !== expected_alu_src   ||
                mem_read  !== expected_mem_read  ||
                mem_write !== expected_mem_write ||
                mem_to_reg !== expected_mem_to_reg ||
                branch    !== expected_branch    ||
                alu_op    !== expected_alu_op
            ) begin

                $display("ERROR: %s", msg);
                $fatal;

            end

            else begin

                $display("PASS: %s", msg);

            end

        end

    endtask

    initial begin

        // R-Type

        opcode = 7'b0110011;

        #1;

        check_control(
            1, 0, 0, 0, 0, 0, 2'b10,
            "R-Type decode"
        );

        // ADDI

        opcode = 7'b0010011;

        #1;

        check_control(
            1, 1, 0, 0, 0, 0, 2'b00,
            "ADDI decode"
        );

        // LW

        opcode = 7'b0000011;

        #1;

        check_control(
            1, 1, 1, 0, 1, 0, 2'b00,
            "LW decode"
        );

        // SW

        opcode = 7'b0100011;

        #1;

        check_control(
            0, 1, 0, 1, 0, 0, 2'b00,
            "SW decode"
        );

        // BEQ

        opcode = 7'b1100011;

        #1;

        check_control(
            0, 0, 0, 0, 0, 1, 2'b01,
            "BEQ decode"
        );


        $display("====================================");
        $display("All control unit tests passed!");
        $display("====================================");

        $stop;

    end

endmodule