module id_ex (

    input logic clk,
    input logic rst,

    // Datapath Inputs

    input logic [31:0] id_pc,
    input logic [31:0] id_rs1_data,
    input logic [31:0] id_rs2_data,
    input logic [31:0] id_immediate,

    input logic [4:0] id_rd,

    // Control Inputs

    input logic       id_reg_write,
    input logic       id_alu_src,
    input logic       id_mem_read,
    input logic       id_mem_write,
    input logic       id_mem_to_reg,
    input logic       id_branch,

    input logic [1:0] id_alu_op,

    // Datapath Outputs

    output logic [31:0] ex_pc,
    output logic [31:0] ex_rs1_data,
    output logic [31:0] ex_rs2_data,
    output logic [31:0] ex_immediate,

    output logic [4:0] ex_rd,

    // Control Outputs

    output logic       ex_reg_write,
    output logic       ex_alu_src,
    output logic       ex_mem_read,
    output logic       ex_mem_write,
    output logic       ex_mem_to_reg,
    output logic       ex_branch,

    output logic [1:0] ex_alu_op

);

    always_ff @(posedge clk) begin

        if (rst) begin

            ex_pc          <= 32'd0;
            ex_rs1_data    <= 32'd0;
            ex_rs2_data    <= 32'd0;
            ex_immediate   <= 32'd0;

            ex_rd          <= 5'd0;

            ex_reg_write   <= 0;
            ex_alu_src     <= 0;
            ex_mem_read    <= 0;
            ex_mem_write   <= 0;
            ex_mem_to_reg  <= 0;
            ex_branch      <= 0;

            ex_alu_op      <= 2'b00;

        end

        else begin

            ex_pc          <= id_pc;
            ex_rs1_data    <= id_rs1_data;
            ex_rs2_data    <= id_rs2_data;
            ex_immediate   <= id_immediate;

            ex_rd          <= id_rd;

            ex_reg_write   <= id_reg_write;
            ex_alu_src     <= id_alu_src;
            ex_mem_read    <= id_mem_read;
            ex_mem_write   <= id_mem_write;
            ex_mem_to_reg  <= id_mem_to_reg;
            ex_branch      <= id_branch;

            ex_alu_op      <= id_alu_op;

        end

    end

endmodule