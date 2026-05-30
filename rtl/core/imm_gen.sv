module imm_gen (

    input  logic [31:0] instruction,

    output logic [31:0] immediate

);

    logic [6:0] opcode;

    assign opcode = instruction[6:0];

    always_comb begin

        unique case (opcode)

            // I-Type (ADDI, LW)
            7'b0010011,
            7'b0000011: begin

                immediate = {
                    {20{instruction[31]}},
                    instruction[31:20]
                };

            end

            // S-Type (SW)
            7'b0100011: begin

                immediate = {
                    {20{instruction[31]}},
                    instruction[31:25],
                    instruction[11:7]
                };

            end

            // B-Type (BEQ)
            7'b1100011: begin

                immediate = {
                    {19{instruction[31]}},
                    instruction[31],
                    instruction[7],
                    instruction[30:25],
                    instruction[11:8],
                    1'b0
                };

            end

            default: begin
                immediate = 32'd0;
            end

        endcase

    end

endmodule