`timescale 1ns/1ps

module pc_tb;

    logic clk;
    logic rst;

    logic [31:0] next_pc;
    logic [31:0] current_pc;

    // Instantiate DUT
    pc dut (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );

    // Clock generation
    always #5 clk = ~clk;

    task check_pc(
        input logic [31:0] expected
    );

        begin

            if (current_pc !== expected) begin
                $display("ERROR: PC mismatch");
                $display("Expected = %0d, Got = %0d",
                         expected, current_pc);
                $fatal;
            end

            else begin
                $display("PASS: PC = %0d", current_pc);
            end

        end

    endtask

    initial begin

        clk = 0;
        rst = 1;
        next_pc = 0;

        //----------------------------------------
        // Reset Test
        //----------------------------------------

        @(posedge clk);

        #1;

        check_pc(32'd0);

        //----------------------------------------
        // Update PC
        //----------------------------------------

        rst = 0;

        next_pc = 32'd4;

        @(posedge clk);

        #1;

        check_pc(32'd4);

        //----------------------------------------

        next_pc = 32'd8;

        @(posedge clk);

        #1;

        check_pc(32'd8);

        //----------------------------------------

        next_pc = 32'd12;

        @(posedge clk);

        #1;

        check_pc(32'd12);

        //----------------------------------------

        $display("====================================");
        $display("All PC tests passed!");
        $display("====================================");

        $stop;

    end

endmodule