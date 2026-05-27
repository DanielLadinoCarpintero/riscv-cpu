`timescale 1ns/1ps

module alu_tb;

    logic [31:0] a;
    logic [31:0] b;
    logic [2:0]  alu_sel;

    logic [31:0] result;
    logic        zero;

    // Instantiate DUT
    alu dut (
        .a(a),
        .b(b),
        .alu_sel(alu_sel),
        .result(result),
        .zero(zero)
    );

    // ALU operation encoding
    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND_OP = 3'b010;
    localparam OR_OP  = 3'b011;
    localparam XOR_OP = 3'b100;
    localparam SLT = 3'b101;

    task run_test(
        input logic [31:0] test_a,
        input logic [31:0] test_b,
        input logic [2:0]  test_sel,
        input logic [31:0] expected_result,
        input logic        expected_zero
    );

        begin

            a = test_a;
            b = test_b;
            alu_sel = test_sel;

            #10;

            if (result !== expected_result) begin
                $display("ERROR: result mismatch");
                $display("a = %0d, b = %0d, alu_sel = %0b", a, b, alu_sel);
                $display("Expected = %0d, Got = %0d", expected_result, result);
                $fatal;
            end

            if (zero !== expected_zero) begin
                $display("ERROR: zero flag mismatch");
                $display("Expected zero = %0b, Got = %0b", expected_zero, zero);
                $fatal;
            end

            $display("PASS: a=%0d b=%0d sel=%0b result=%0d",
                     a, b, alu_sel, result);

        end

    endtask

    initial begin

        $display("Starting ALU Testbench...");

        // ADD tests
        run_test(32'd5, 32'd3, ADD, 32'd8, 1'b0);
        run_test(32'd10, 32'd15, ADD, 32'd25, 1'b0);

        // SUB tests
        run_test(32'd8, 32'd8, SUB, 32'd0, 1'b1);
        run_test(32'd20, 32'd5, SUB, 32'd15, 1'b0);

        // AND tests
        run_test(32'hF0F0, 32'h0FF0, AND_OP, 32'h00F0, 1'b0);

        // OR tests
        run_test(32'hF000, 32'h0F00, OR_OP, 32'hFF00, 1'b0);

        // XOR tests
        run_test(32'hAAAA, 32'h5555, XOR_OP, 32'hFFFF, 1'b0);

        // SLT tests
        run_test(32'd4, 32'd7, SLT, 32'd1, 1'b0);
        run_test(32'd9, 32'd2, SLT, 32'd0, 1'b1);

        $display("====================================");
        $display("All ALU tests passed successfully!");
        $display("====================================");

        $stop;

    end

endmodule