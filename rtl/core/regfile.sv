module regfile (
    input  logic        clk,
    input  logic        rst,

    input  logic        we,         // Write enable
    input  logic [4:0]  rs1_addr,   // Read address 1
    input  logic [4:0]  rs2_addr,   // Read address 2
    input  logic [4:0]  rd_addr,    // Write address
    input  logic [31:0] rd_data,    // Write data

    output logic [31:0] rs1_data,   // Read data 1
    output logic [31:0] rs2_data    // Read data 2
);

    // 32 registers, each 32 bits wide
    logic [31:0] registers [31:0];

    integer i;

    // Synchronous write + reset
    always_ff @(posedge clk) begin

        if (rst) begin

            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'd0;
            end

        end

        else begin

            // x0 must always remain zero
            if (we && (rd_addr != 5'd0)) begin
                registers[rd_addr] <= rd_data;
            end

            // Force x0 to remain zero
            registers[0] <= 32'd0;

        end

    end

    // Combinational reads
    assign rs1_data = registers[rs1_addr];
    assign rs2_data = registers[rs2_addr];

endmodule