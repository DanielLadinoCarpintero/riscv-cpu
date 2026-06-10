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

    // Pipeline Monitor

    always @(posedge clk) begin

        $display(
            "[%0t] PC=%0d ID=%h EX_RD=%0d MEM_RD=%0d WB_RD=%0d",
            $time,
            dut.current_pc,
            dut.id_instruction,
            dut.ex_rd,
            dut.mem_rd,
            dut.wb_rd
        );

    end

    initial begin

        clk = 0;
        rst = 1;

        // Reset

        #20;

        rst = 0;

        // Allow program to execute

        #400;

        $display("");
        $display("========================================");
        $display("         CPU EXECUTION SUMMARY");
        $display("========================================");

        $display("x1 = %0d", dut.regfile_inst.registers[1]);
        $display("x2 = %0d", dut.regfile_inst.registers[2]);

        $display("");

        $display("Memory Contents:");
        $display("MEM[100] = %0h",
                 dut.data_mem_inst.memory[25]);

        $display("");

        $display("x3 = %0d",
                 dut.regfile_inst.registers[3]);

        $display("");

        $display("Pipeline State:");
        $display("IF  Instruction = %h",
                 dut.instruction);

        $display("ID  Instruction = %h",
                 dut.id_instruction);

        $display("EX  Destination  = %0d",
                 dut.ex_rd);

        $display("MEM Destination  = %0d",
                 dut.mem_rd);

        $display("WB  Destination  = %0d",
                 dut.wb_rd);

        $display("");

        // Architectural Checks

        if (dut.regfile_inst.registers[1] !== 32'd100)
            $fatal;

        if (dut.regfile_inst.registers[2] !== 32'd42)
            $fatal;

        $display("");
        $display("========================================");
        $display("      ALL ARCHITECTURAL TESTS PASSED");
        $display("========================================");
        $display("");

        $stop;

    end

endmodule