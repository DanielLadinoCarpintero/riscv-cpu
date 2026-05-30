module alu_control (

    input  logic [1:0] alu_op,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic [2:0] alu_sel

);

    always_comb begin

        unique case (alu_op)

            // LW / SW / ADDI
            2'b00: begin
                alu_sel = 3'b000;
            end

            // BEQ
            2'b01: begin
                alu_sel = 3'b001;
            end

            // R-Type
            2'b10: begin

                unique case ({funct7, funct3})

                    // ADD
                    10'b0000000_000:
                        alu_sel = 3'b000;

                    // SUB
                    10'b0100000_000:
                        alu_sel = 3'b001;

                    // AND
                    10'b0000000_111:
                        alu_sel = 3'b010;

                    // OR
                    10'b0000000_110:
                        alu_sel = 3'b011;

                    // XOR
                    10'b0000000_100:
                        alu_sel = 3'b100;

                    // SLT
                    10'b0000000_010:
                        alu_sel = 3'b101;

                    default:
                        alu_sel = 3'b000;

                endcase

            end

            default: begin
                alu_sel = 3'b000;
            end

        endcase

    end

endmodule