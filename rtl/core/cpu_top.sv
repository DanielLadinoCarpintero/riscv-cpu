module cpu_top (

    input logic clk,
    input logic rst

);

    // PC Signals

    logic [31:0] current_pc;
    logic [31:0] next_pc;

    // Instruction Signals

    logic [31:0] instruction;

    // Instruction Fields

    logic [6:0] opcode;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [2:0] funct3;
    logic [6:0] funct7;

    // Register File Signals

    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    // Immediate Signals

    logic [31:0] immediate;

    // Control Signals

    logic       reg_write;
    logic       alu_src;
    logic       mem_read;
    logic       mem_write;
    logic       mem_to_reg;
    logic       branch;

    logic [1:0] alu_op;

    // ALU Signals

    logic [2:0] alu_sel;

    logic [31:0] alu_b;
    logic [31:0] alu_result;

    logic zero;

    // Data Memory Signals

    logic [31:0] mem_read_data;

    logic [31:0] writeback_data;

    // PC Increment

    assign next_pc = current_pc + 32'd4;

    // Instruction Field Extraction

    assign opcode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7 = instruction[31:25];

    // ALU Source Mux

    assign alu_b = (alu_src) ? immediate : rs2_data;

    // Writeback Mux

    assign writeback_data =
        (mem_to_reg) ? mem_read_data : alu_result;

    // Program Counter

    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );

    // Instruction Memory

    instr_mem instr_mem_inst (
        .addr(current_pc),
        .instruction(instruction)
    );

    // Register File

    regfile regfile_inst (
        .clk(clk),
        .rst(rst),

        .we(reg_write),

        .rs1_addr(rs1),
        .rs2_addr(rs2),

        .rd_addr(rd),

        .rd_data(writeback_data),

        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Immediate Generator

    imm_gen imm_gen_inst (
        .instruction(instruction),
        .immediate(immediate)
    );

    // Control Unit

    control_unit control_unit_inst (
        .opcode(opcode),

        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),

        .alu_op(alu_op)
    );

    // ALU Control

    alu_control alu_control_inst (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),

        .alu_sel(alu_sel)
    );

    // ALU

    alu alu_inst (
        .a(rs1_data),
        .b(alu_b),
        .alu_sel(alu_sel),

        .result(alu_result),
        .zero(zero)
    );

    // Data Memory

    data_mem data_mem_inst (

        .clk(clk),

        .mem_read(mem_read),
        .mem_write(mem_write),

        .addr(alu_result),

        .write_data(rs2_data),

        .read_data(mem_read_data)

    );

endmodule