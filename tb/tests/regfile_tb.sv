`timescale 1ns/1ps

module regfile_tb;

    logic        clk;
    logic        rst;

    logic        we;
    logic [4:0]  rs1_addr;
    logic [4:0]  rs2_addr;
    logic [4:0]  rd_addr;
    logic [31:0] rd_data;

    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    // Instantiate DUT
    regfile dut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Helper task
    task check_result(
        input logic [31:0] actual,
        input logic [31:0] expected,
        input string message
    );

        begin

            if (actual !== expected) begin
                $display("ERROR: %s", message);
                $display("Expected = %0d, Got = %0d", expected, actual);
                $fatal;
            end

            else begin
                $display("PASS: %s", message);
            end

        end

    endtask

    initial begin

        // Initialize signals
        clk = 0;
        rst = 1;

        we = 0;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        rd_data = 0;

        // Apply reset
        #12;
        rst = 0;

       
        // Test 1: Write to register x1
        

        @(posedge clk);

        we = 1;
        rd_addr = 5'd1;
        rd_data = 32'd123;

        @(posedge clk);

        we = 0;

        rs1_addr = 5'd1;

        #1;

        check_result(rs1_data, 32'd123,
                     "Write/read x1");

        
        // Test 2: Write to register x5
       

        @(posedge clk);

        we = 1;
        rd_addr = 5'd5;
        rd_data = 32'd999;

        @(posedge clk);

        we = 0;

        rs1_addr = 5'd5;

        #1;

        check_result(rs1_data, 32'd999,
                     "Write/read x5");

        
        // Test 3: Verify x0 remains zero
        

        @(posedge clk);

        we = 1;
        rd_addr = 5'd0;
        rd_data = 32'd5555;

        @(posedge clk);

        we = 0;

        rs1_addr = 5'd0;

        #1;

        check_result(rs1_data, 32'd0,
                     "x0 remains zero");

       
        // Test 4: Reset clears registers
        

        rst = 1;

        @(posedge clk);

        rst = 0;

        rs1_addr = 5'd1;

        #1;

        check_result(rs1_data, 32'd0,
                     "Reset clears registers");

        //----------------------------------------

        $display("====================================");
        $display("All register file tests passed!");
        $display("====================================");

        $stop;

    end

endmodule