`timescale 1ns/1ps

module data_mem_tb;

    logic clk;

    logic mem_read;
    logic mem_write;

    logic [31:0] addr;
    logic [31:0] write_data;

    logic [31:0] read_data;

    // Instantiate DUT

    data_mem dut (
        .clk(clk),

        .mem_read(mem_read),
        .mem_write(mem_write),

        .addr(addr),
        .write_data(write_data),

        .read_data(read_data)
    );

    // Clock generation

    always #5 clk = ~clk;

    task check_result(

        input logic [31:0] expected,
        input string msg

    );

        begin

            if (read_data !== expected) begin

                $display("ERROR: %s", msg);
                $display("Expected = %0d, Got = %0d",
                         expected, read_data);

                $fatal;

            end

            else begin

                $display("PASS: %s", msg);

            end

        end

    endtask

    initial begin

        clk = 0;

        mem_read  = 0;
        mem_write = 0;

        addr       = 0;
        write_data = 0;

        // Write memory

        @(posedge clk);

        mem_write = 1;

        addr       = 32'd4;
        write_data = 32'd1234;

        @(posedge clk);

        mem_write = 0;

        // Read memory

        mem_read = 1;

        addr = 32'd4;

        #1;

        check_result(32'd1234, "Memory read/write");

        // Another memory test

        @(posedge clk);

        mem_write = 1;

        addr       = 32'd8;
        write_data = 32'd9999;

        @(posedge clk);

        mem_write = 0;

        mem_read = 1;

        addr = 32'd8;

        #1;

        check_result(32'd9999, "Second memory read/write");

        $display("====================================");
        $display("All data memory tests passed!");
        $display("====================================");

        $stop;

    end

endmodule