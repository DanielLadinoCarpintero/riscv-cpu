module data_mem (

    input  logic        clk,

    input  logic        mem_read,
    input  logic        mem_write,

    input  logic [31:0] addr,
    input  logic [31:0] write_data,

    output logic [31:0] read_data

);

    // 256 x 32-bit memory

    logic [31:0] memory [0:255];

    // Synchronous writes

    always_ff @(posedge clk) begin

        if (mem_write) begin
            memory[addr[31:2]] <= write_data;
        end

    end

    // Combinational reads

    always_comb begin

        if (mem_read) begin
            read_data = memory[addr[31:2]];
        end

        else begin
            read_data = 32'd0;
        end

    end

endmodule