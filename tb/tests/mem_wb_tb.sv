`timescale 1ns/1ps

module mem_wb_tb;

    logic clk;
    logic rst;

    logic [31:0] mem_alu_result;
    logic [31:0] mem_read_data;

    logic [4:0] mem_rd;

    logic mem_reg_write;
    logic mem_mem_to_reg;

    logic [31:0] wb_alu_result;
    logic [31:0] wb_read_data;

    logic [4:0] wb_rd;

    logic wb_reg_write;
    logic wb_mem_to_reg;

    mem_wb dut (

        .clk(clk),
        .rst(rst),

        .mem_alu_result(mem_alu_result),
        .mem_read_data(mem_read_data),

        .mem_rd(mem_rd),

        .mem_reg_write(mem_reg_write),
        .mem_mem_to_reg(mem_mem_to_reg),

        .wb_alu_result(wb_alu_result),
        .wb_read_data(wb_read_data),

        .wb_rd(wb_rd),

        .wb_reg_write(wb_reg_write),
        .wb_mem_to_reg(wb_mem_to_reg)

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        mem_alu_result = 0;
        mem_read_data  = 0;

        mem_rd         = 0;

        mem_reg_write  = 0;
        mem_mem_to_reg = 0;

        @(posedge clk);

        #1;

        if (wb_alu_result !== 32'd0) begin
            $display("ERROR: Reset ALU result failed");
            $fatal;
        end

        if (wb_rd !== 5'd0) begin
            $display("ERROR: Reset rd failed");
            $fatal;
        end

        rst = 0;

        mem_alu_result = 32'd42;
        mem_read_data  = 32'd99;

        mem_rd         = 5'd3;

        mem_reg_write  = 1;
        mem_mem_to_reg = 1;

        @(posedge clk);

        #1;

        if (wb_alu_result !== 32'd42) begin
            $display("ERROR: ALU result transfer failed");
            $fatal;
        end

        if (wb_read_data !== 32'd99) begin
            $display("ERROR: Read data transfer failed");
            $fatal;
        end

        if (wb_rd !== 5'd3) begin
            $display("ERROR: rd transfer failed");
            $fatal;
        end

        if (wb_reg_write !== 1'b1) begin
            $display("ERROR: reg_write transfer failed");
            $fatal;
        end

        if (wb_mem_to_reg !== 1'b1) begin
            $display("ERROR: mem_to_reg transfer failed");
            $fatal;
        end

        $display("====================================");
        $display("MEM/WB pipeline register tests passed!");
        $display("====================================");

        $stop;

    end

endmodule