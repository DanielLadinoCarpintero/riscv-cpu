module pc (
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] next_pc,

    output logic [31:0] current_pc
);

    always_ff @(posedge clk) begin

        if (rst) begin
            current_pc <= 32'd0;
        end

        else begin
            current_pc <= next_pc;
        end

    end

endmodule