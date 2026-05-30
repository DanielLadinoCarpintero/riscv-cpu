module control_unit (

    input  logic [6:0] opcode,

    output logic       reg_write,
    output logic       alu_src,
    output logic       mem_read,
    output logic       mem_write,
    output logic       mem_to_reg,
    output logic       branch,

    output logic [1:0] alu_op

);

    always_comb begin

        // Default values
        reg_write = 0;
        alu_src   = 0;
        mem_read  = 0;
        mem_write = 0;
        mem_to_reg = 0;
        branch    = 0;
        alu_op    = 2'b00;

        unique case (opcode)

            // R-Type Instructions
            7'b0110011: begin
                reg_write = 1;
                alu_src   = 0;
                alu_op    = 2'b10;
            end

            // I-Type (ADDI)
            7'b0010011: begin
                reg_write = 1;
                alu_src   = 1;
                alu_op    = 2'b00;
            end

            // LOAD (LW)
            7'b0000011: begin
                reg_write = 1;
                alu_src   = 1;
                mem_read  = 1;
                mem_to_reg = 1;
                alu_op    = 2'b00;
            end

            // STORE (SW)
            7'b0100011: begin
                alu_src   = 1;
                mem_write = 1;
                alu_op    = 2'b00;
            end

            // BRANCH (BEQ)
            7'b1100011: begin
                branch = 1;
                alu_op = 2'b01;
            end

            default: begin
                // Keep defaults
            end

        endcase

    end

endmodule