module riscv_decoder (
    input  logic [31:0] instruction,
    input  logic [31:0] reg_read_data1,
    input  logic [31:0] reg_read_data2,
    input  logic [31:0] pc,

    output logic [31:0] alu_operand_a,
    output logic [31:0] alu_operand_b,
    output logic [3:0] alu_control,
    output logic        reg_write_enable,
    output logic [4:0]  reg_write_dest,
    output logic        mem_read_enable,
    output logic        mem_write_enable,
    output logic        mem_to_reg,
    output logic        branch_enable,
    output logic        jump_enable,
    output logic [1:0] next_pc_select
);

  import riscv_defines::*;

  logic [6:0] opcode;
  logic [4:0] rd;
  logic [2:0] funct3;
  logic [4:0] rs1;
  logic [4:0] rs2;
  logic [6:0] funct7;

  logic [31:0] immediate_val;

  assign opcode   = instruction[6:0];
  assign rd       = instruction[11:7];
  assign funct3   = instruction[14:12];
  assign rs1      = instruction[19:15];
  assign rs2      = instruction[24:20];
  assign funct7   = instruction[31:25];

  assign reg_write_dest = rd;

  immediate_generator i_gen (
      .instruction (instruction),
      .opcode      (opcode),
      .immediate   (immediate_val)
  );

  assign alu_operand_a = (opcode == OPCODE_U_TYPE_AUIPC) ? pc : reg_read_data1;

  logic select_imm_for_alu_b;
  always_comb begin
    case (opcode)
      OPCODE_R_TYPE:           select_imm_for_alu_b = 1'b0;
      OPCODE_I_TYPE_ALU:       select_imm_for_alu_b = 1'b1;
      OPCODE_I_TYPE_LOAD:      select_imm_for_alu_b = 1'b1;
      OPCODE_S_TYPE:           select_imm_for_alu_b = 1'b1;
      OPCODE_B_TYPE:           select_imm_for_alu_b = 1'b1;
      OPCODE_U_TYPE_LUI:       select_imm_for_alu_b = 1'b1;
      OPCODE_U_TYPE_AUIPC:     select_imm_for_alu_b = 1'b1;
      OPCODE_J_TYPE_JAL:       select_imm_for_alu_b = 1'b1;
      OPCODE_I_TYPE_JALR:      select_imm_for_alu_b = 1'b1;
      default:                 select_imm_for_alu_b = 1'b0;
    endcase
  end

  assign alu_operand_b = select_imm_for_alu_b ? immediate_val : reg_read_data2;


  alu_control_unit alu_ctrl (
      .opcode    (opcode),
      .funct3    (funct3),
      .funct7    (funct7),
      .alu_control (alu_control)
  );

  main_control_unit main_ctrl (
      .opcode             (opcode),
      .reg_write_enable   (reg_write_enable),
      .mem_read_enable    (mem_read_enable),
      .mem_write_enable   (mem_write_enable),
      .mem_to_reg         (mem_to_reg),
      .branch_enable      (branch_enable),
      .jump_enable        (jump_enable),
      .next_pc_select     (next_pc_select)
  );

endmodule