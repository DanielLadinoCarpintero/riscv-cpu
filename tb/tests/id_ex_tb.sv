`timescale 1ns/1ps

module id_ex_tb;

    logic clk;
    logic rst;

    // Inputs

    logic [31:0] id_pc;
    logic [31:0] id_rs1_data;
    logic [31:0] id_rs2_data;
    logic [31:0] id_immediate;

    logic [4:0] id_rd;

    logic       id_reg_write;
    logic       id_alu_src;
    logic       id_mem_read;
    logic       id_mem_write;
    logic       id_mem_to_reg;
    logic       id_branch;

    logic [1:0] id_alu_op;

    // Outputs

    logic [31:0] ex_pc;
    logic [31:0] ex_rs1_data;
    logic [31:0] ex_rs2_data;
    logic [31:0] ex_immediate;

    logic [4:0] ex_rd;

    logic       ex_reg_write;
    logic       ex_alu_src;
    logic       ex_mem_read;
    logic       ex_mem_write;
    logic       ex_mem_to_reg;
    logic       ex_branch;

    logic [1:0] ex_alu_op;

    // Instantiate DUT

    id_ex dut (

        .clk(clk),
        .rst(rst),

        .id_pc(id_pc),
        .id_rs1_data(id_rs1_data),
        .id_rs2_data(id_rs2_data),
        .id_immediate(id_immediate),

        .id_rd(id_rd),

        .id_reg_write(id_reg_write),
        .id_alu_src(id_alu_src),
        .id_mem_read(id_mem_read),
        .id_mem_write(id_mem_write),
        .id_mem_to_reg(id_mem_to_reg),
        .id_branch(id_branch),

        .id_alu_op(id_alu_op),

        .ex_pc(ex_pc),
        .ex_rs1_data(ex_rs1_data),
        .ex_rs2_data(ex_rs2_data),
        .ex_immediate(ex_immediate),

        .ex_rd(ex_rd),

        .ex_reg_write(ex_reg_write),
        .ex_alu_src(ex_alu_src),
        .ex_mem_read(ex_mem_read),
        .ex_mem_write(ex_mem_write),
        .ex_mem_to_reg(ex_mem_to_reg),
        .ex_branch(ex_branch),

        .ex_alu_op(ex_alu_op)

    );

    // Clock generation

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        // Initialize inputs

        id_pc = 0;
        id_rs1_data = 0;
        id_rs2_data = 0;
        id_immediate = 0;

        id_rd = 0;

        id_reg_write = 0;
        id_alu_src = 0;
        id_mem_read = 0;
        id_mem_write = 0;
        id_mem_to_reg = 0;
        id_branch = 0;

        id_alu_op = 0;

        // Reset test

        @(posedge clk);

        #1;

        if (ex_pc !== 32'd0) begin
            $display("ERROR: Reset failed");
            $fatal;
        end

        // Pipeline transfer test

        rst = 0;

        id_pc = 32'd8;
        id_rs1_data = 32'd5;
        id_rs2_data = 32'd10;
        id_immediate = 32'd42;

        id_rd = 5'd3;

        id_reg_write = 1;
        id_alu_src = 1;
        id_mem_read = 0;
        id_mem_write = 1;
        id_mem_to_reg = 0;
        id_branch = 0;

        id_alu_op = 2'b10;

        @(posedge clk);

        #1;

        if (ex_pc !== 32'd8) begin
            $display("ERROR: PC transfer failed");
            $fatal;
        end

        if (ex_rs1_data !== 32'd5) begin
            $display("ERROR: rs1 transfer failed");
            $fatal;
        end

        if (ex_rs2_data !== 32'd10) begin
            $display("ERROR: rs2 transfer failed");
            $fatal;
        end

        if (ex_immediate !== 32'd42) begin
            $display("ERROR: immediate transfer failed");
            $fatal;
        end

        if (ex_rd !== 5'd3) begin
            $display("ERROR: rd transfer failed");
            $fatal;
        end

        if (ex_reg_write !== 1) begin
            $display("ERROR: reg_write transfer failed");
            $fatal;
        end

        if (ex_mem_write !== 1) begin
            $display("ERROR: mem_write transfer failed");
            $fatal;
        end

        $display("====================================");
        $display("ID/EX pipeline register tests passed!");
        $display("====================================");

        $stop;

    end

endmodule