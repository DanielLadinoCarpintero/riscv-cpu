`timescale 1ns/1ps

module if_id_tb;

    logic clk;
    logic rst;

    logic [31:0] if_pc;
    logic [31:0] if_instruction;

    logic [31:0] id_pc;
    logic [31:0] id_instruction;

    // Instantiate DUT

    if_id dut (

        .clk(clk),
        .rst(rst),

        .if_pc(if_pc),
        .if_instruction(if_instruction),

        .id_pc(id_pc),
        .id_instruction(id_instruction)

    );

    // Clock generation

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        if_pc = 0;
        if_instruction = 0;

        // Reset

        @(posedge clk);

        #1;

        if (id_pc !== 32'd0) begin
            $display("ERROR: Reset PC failed");
            $fatal;
        end

        if (id_instruction !== 32'd0) begin
            $display("ERROR: Reset instruction failed");
            $fatal;
        end

        // Pipeline transfer test

        rst = 0;

        if_pc = 32'd4;
        if_instruction = 32'h00500093;

        @(posedge clk);

        #1;

        if (id_pc !== 32'd4) begin
            $display("ERROR: PC pipeline transfer failed");
            $fatal;
        end

        if (id_instruction !== 32'h00500093) begin
            $display("ERROR: Instruction pipeline transfer failed");
            $fatal;
        end

        // Second pipeline transfer

        if_pc = 32'd8;
        if_instruction = 32'h02A00113;

        @(posedge clk);

        #1;

        if (id_pc !== 32'd8) begin
            $display("ERROR: Second PC transfer failed");
            $fatal;
        end

        if (id_instruction !== 32'h02A00113) begin
            $display("ERROR: Second instruction transfer failed");
            $fatal;
        end

        $display("====================================");
        $display("IF/ID pipeline register tests passed!");
        $display("====================================");

        $stop;

    end

endmodule