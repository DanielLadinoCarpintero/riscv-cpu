module if_id (

    input logic clk,
    input logic rst,

    input logic [31:0] if_pc,
    input logic [31:0] if_instruction,

    output logic [31:0] id_pc,
    output logic [31:0] id_instruction

);

    always_ff @(posedge clk) begin

        if (rst) begin

            id_pc          <= 32'd0;
            id_instruction <= 32'd0;

        end

        else begin

            id_pc          <= if_pc;
            id_instruction <= if_instruction;

        end

    end

endmodule