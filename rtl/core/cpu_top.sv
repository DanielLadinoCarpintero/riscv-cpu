module cpu_top (

    input logic clk,
    input logic rst

);

    // PC Signals

    logic [31:0] current_pc;
    logic [31:0] next_pc;

    // Instruction Signals

    logic [31:0] instruction;

    // IF/ID Pipeline Signals

    logic [31:0] id_pc;
    logic [31:0] id_instruction;

    // ID/EX Pipeline Signals

    logic [31:0] ex_pc;

    logic [31:0] ex_rs1_data;
    logic [31:0] ex_rs2_data;

    logic [31:0] ex_immediate;

    logic [4:0] ex_rd;

    logic       ex_reg_write;
    logic       ex_alu_src;
    logic       ex_mem_read;
    logic       ex_mem_write;
    logic       ex_mem_to_reg;
    logic       ex_branch;

    logic [1:0] ex_alu_op;

    // EX/MEM Pipeline Signals

    logic [31:0] mem_alu_result;
    logic [31:0] mem_rs2_data;

    logic [4:0] mem_rd;

    logic       mem_reg_write;
    logic       mem_mem_read;
    logic       mem_mem_write;
    logic       mem_mem_to_reg;

    // MEM/WB Pipeline Signals

    logic [31:0] wb_alu_result;
    logic [31:0] wb_read_data;

    logic [4:0] wb_rd;

    logic       wb_reg_write;
    logic       wb_mem_to_reg;

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

    assign opcode = id_instruction[6:0];
    assign rd     = id_instruction[11:7];
    assign funct3 = id_instruction[14:12];
    assign rs1    = id_instruction[19:15];
    assign rs2    = id_instruction[24:20];
    assign funct7 = id_instruction[31:25];

    // ALU Source Mux

    assign alu_b =
        (ex_alu_src) ? ex_immediate : ex_rs2_data;

    // Writeback Mux

    assign writeback_data =
        (wb_mem_to_reg) ? wb_read_data : wb_alu_result;

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

    // IF/ID Pipeline Register

    if_id if_id_inst (

        .clk(clk),
        .rst(rst),

        .if_pc(current_pc),
        .if_instruction(instruction),

        .id_pc(id_pc),
        .id_instruction(id_instruction)

    );

    // Register File

    regfile regfile_inst (
        .clk(clk),
        .rst(rst),

        .we(wb_reg_write),

        .rs1_addr(rs1),
        .rs2_addr(rs2),

        .rd_addr(wb_rd),

        .rd_data(writeback_data),

        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Immediate Generator

    imm_gen imm_gen_inst (
        .instruction(id_instruction),
        .immediate(immediate)
    );

    // ID/EX Pipeline Register

    id_ex id_ex_inst (

        .clk(clk),
        .rst(rst),

        .id_pc(id_pc),

        .id_rs1_data(rs1_data),
        .id_rs2_data(rs2_data),

        .id_immediate(immediate),

        .id_rd(rd),

        .id_reg_write(reg_write),
        .id_alu_src(alu_src),
        .id_mem_read(mem_read),
        .id_mem_write(mem_write),
        .id_mem_to_reg(mem_to_reg),
        .id_branch(branch),

        .id_alu_op(alu_op),

        .ex_pc(ex_pc),

        .ex_rs1_data(ex_rs1_data),
        .ex_rs2_data(ex_rs2_data),

        .ex_immediate(ex_immediate),

        .ex_rd(ex_rd),

        .ex_reg_write(ex_reg_write),
        .ex_alu_src(ex_alu_src),
        .ex_mem_read(ex_mem_read),
        .ex_mem_write(ex_mem_write),
        .ex_mem_to_reg(ex_mem_to_reg),
        .ex_branch(ex_branch),

        .ex_alu_op(ex_alu_op)

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
        .alu_op(ex_alu_op),
        .funct3(funct3),
        .funct7(funct7),

        .alu_sel(alu_sel)
    );

    // ALU

    alu alu_inst (
        .a(ex_rs1_data),
        .b(alu_b),
        .alu_sel(alu_sel),

        .result(alu_result),
        .zero(zero)
    );

    // EX/MEM Pipeline Register

    ex_mem ex_mem_inst (

        .clk(clk),
        .rst(rst),

        .ex_alu_result(alu_result),
        .ex_rs2_data(ex_rs2_data),

        .ex_rd(ex_rd),

        .ex_reg_write(ex_reg_write),
        .ex_mem_read(ex_mem_read),
        .ex_mem_write(ex_mem_write),
        .ex_mem_to_reg(ex_mem_to_reg),

        .mem_alu_result(mem_alu_result),
        .mem_rs2_data(mem_rs2_data),

        .mem_rd(mem_rd),

        .mem_reg_write(mem_reg_write),
        .mem_mem_read(mem_mem_read),
        .mem_mem_write(mem_mem_write),
        .mem_mem_to_reg(mem_mem_to_reg)

    );

    // Data Memory

    data_mem data_mem_inst (

        .clk(clk),

        .mem_read(mem_mem_read),
        .mem_write(mem_mem_write),

        .addr(mem_alu_result),

        .write_data(mem_rs2_data),

        .read_data(mem_read_data)

    );

    // MEM/WB Pipeline Register

    mem_wb mem_wb_inst (

        .clk(clk),
        .rst(rst),

        .mem_alu_result(mem_alu_result),
        .mem_read_data(mem_read_data),

        .mem_rd(mem_rd),

        .mem_reg_write(mem_reg_write),
        .mem_mem_to_reg(mem_mem_to_reg),

        .wb_alu_result(wb_alu_result),
        .wb_read_data(wb_read_data),

        .wb_rd(wb_rd),

        .wb_reg_write(wb_reg_write),
        .wb_mem_to_reg(wb_mem_to_reg)

    );

endmodule