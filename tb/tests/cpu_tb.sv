`timescale 1ns/1ps

module cpu_tb;

    logic clk;
    logic rst;

    // Instantiate DUT

    cpu_top dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        // Reset

        #20;

        rst = 0;

        // Run Program

        #150;

        // Check Results

        if (dut.regfile_inst.registers[1] !== 32'd100) begin
            $display("ERROR: x1 incorrect");
            $fatal;
        end

        if (dut.regfile_inst.registers[2] !== 32'd42) begin
            $display("ERROR: x2 incorrect");
            $fatal;
        end

        if (dut.regfile_inst.registers[3] !== 32'd42) begin
            $display("ERROR: x3 incorrect");
            $fatal;
        end

        // Verify memory contents

        if (dut.data_mem_inst.memory[25] !== 32'd42) begin
            $display("ERROR: Memory write failed");
            $fatal;
        end

        $display("====================================");
        $display("CPU EXECUTION SUCCESSFUL");
        $display("x1 = %0d", dut.regfile_inst.registers[1]);
        $display("x2 = %0d", dut.regfile_inst.registers[2]);
        $display("x3 = %0d", dut.regfile_inst.registers[3]);
        $display("MEM[100] = %0d", dut.data_mem_inst.memory[25]);
        $display("====================================");

        $stop;

    end

endmodule