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

        #100;

        // Check Results

        if (dut.regfile_inst.registers[1] !== 32'd5) begin
            $display("ERROR: x1 incorrect");
            $fatal;
        end

        if (dut.regfile_inst.registers[2] !== 32'd10) begin
            $display("ERROR: x2 incorrect");
            $fatal;
        end

        if (dut.regfile_inst.registers[3] !== 32'd15) begin
            $display("ERROR: x3 incorrect");
            $fatal;
        end

        $display("====================================");
        $display("CPU EXECUTION SUCCESSFUL");
        $display("x1 = %0d", dut.regfile_inst.registers[1]);
        $display("x2 = %0d", dut.regfile_inst.registers[2]);
        $display("x3 = %0d", dut.regfile_inst.registers[3]);
        $display("====================================");

        $stop;

    end

endmodule