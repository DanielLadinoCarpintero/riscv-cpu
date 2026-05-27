module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [2:0]  alu_sel,

    output logic [31:0] result,
    output logic        zero
);

    // ALU operation encoding
    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND_OP = 3'b010;
    localparam OR_OP  = 3'b011;
    localparam XOR_OP = 3'b100;
    localparam SLT = 3'b101;

    always_comb begin
        unique case (alu_sel)

            ADD: begin
                result = a + b;
            end

            SUB: begin
                result = a - b;
            end

            AND_OP: begin
                result = a & b;
            end

            OR_OP: begin
                result = a | b;
            end

            XOR_OP: begin
                result = a ^ b;
            end

            SLT: begin
                result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            end

            default: begin
                result = 32'd0;
            end

        endcase
    end

    assign zero = (result == 32'd0);

endmodule