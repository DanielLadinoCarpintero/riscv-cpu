`timescale 1ns/1ps

module ex_mem_tb;

    logic clk;
    logic rst;

    // Inputs

    logic [31:0] ex_alu_result;
    logic [31:0] ex_rs2_data;

    logic [4:0] ex_rd;

    logic       ex_reg_write;
    logic       ex_mem_read;
    logic       ex_mem_write;
    logic       ex_mem_to_reg;

    // Outputs

    logic [31:0] mem_alu_result;
    logic [31:0] mem_rs2_data;

    logic [4:0] mem_rd;

    logic       mem_reg_write;
    logic       mem_mem_read;
    logic       mem_mem_write;
    logic       mem_mem_to_reg;

    // Instantiate DUT

    ex_mem dut (

        .clk(clk),
        .rst(rst),

        .ex_alu_result(ex_alu_result),
        .ex_rs2_data(ex_rs2_data),

        .ex_rd(ex_rd),

        .ex_reg_write(ex_reg_write),
        .ex_mem_read(ex_mem_read),
        .ex_mem_write(ex_mem_write),
        .ex_mem_to_reg(ex_mem_to_reg),

        .mem_alu_result(mem_alu_result),
        .mem_rs2_data(mem_rs2_data),

        .mem_rd(mem_rd),

        .mem_reg_write(mem_reg_write),
        .mem_mem_read(mem_mem_read),
        .mem_mem_write(mem_mem_write),
        .mem_mem_to_reg(mem_mem_to_reg)

    );

    // Clock generation

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        // Initialize

        ex_alu_result = 0;
        ex_rs2_data   = 0;

        ex_rd         = 0;

        ex_reg_write  = 0;
        ex_mem_read   = 0;
        ex_mem_write  = 0;
        ex_mem_to_reg = 0;

        // Reset test

        @(posedge clk);

        #1;

        if (mem_alu_result !== 32'd0) begin
            $display("ERROR: Reset failed");
            $fatal;
        end

        // Pipeline transfer test

        rst = 0;

        ex_alu_result = 32'd42;
        ex_rs2_data   = 32'd100;

        ex_rd         = 5'd3;

        ex_reg_write  = 1;
        ex_mem_read   = 1;
        ex_mem_write  = 0;
        ex_mem_to_reg = 1;

        @(posedge clk);

        #1;

        if (mem_alu_result !== 32'd42) begin
            $display("ERROR: ALU result transfer failed");
            $fatal;
        end

        if (mem_rs2_data !== 32'd100) begin
            $display("ERROR: rs2 transfer failed");
            $fatal;
        end

        if (mem_rd !== 5'd3) begin
            $display("ERROR: rd transfer failed");
            $fatal;
        end

        if (mem_reg_write !== 1) begin
            $display("ERROR: reg_write transfer failed");
            $fatal;
        end

        if (mem_mem_read !== 1) begin
            $display("ERROR: mem_read transfer failed");
            $fatal;
        end

        if (mem_mem_to_reg !== 1) begin
            $display("ERROR: mem_to_reg transfer failed");
            $fatal;
        end

        $display("====================================");
        $display("EX/MEM pipeline register tests passed!");
        $display("====================================");

        $stop;

    end

endmodule