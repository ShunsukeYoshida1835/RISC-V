//`include "riscv_defines.sv"

module alu_control_unit (
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [6:0]  funct7,
    output logic [3:0] alu_control
);

  import riscv_defines::*;

  always_comb begin
    alu_control = ALU_ADD;

    case (opcode)
      OPCODE_R_TYPE: begin
        case (funct3)
          FUNCT3_ADD_SUB: alu_control = (funct7 == FUNCT7_SUB_SRA) ? ALU_SUB : ALU_ADD;
          FUNCT3_SLL:     alu_control = ALU_SLL;
          FUNCT3_SLT:     alu_control = ALU_SLT;
          FUNCT3_SLTU:    alu_control = ALU_SLTU;
          FUNCT3_XOR:     alu_control = ALU_XOR;
          FUNCT3_SR_AR:   alu_control = (funct7 == FUNCT7_SUB_SRA) ? ALU_SRA : ALU_SRL;
          FUNCT3_OR:      alu_control = ALU_OR;
          FUNCT3_AND:     alu_control = ALU_AND;
          default:        alu_control = ALU_ADD;
        endcase
      end
      OPCODE_I_TYPE_ALU: begin
        case (funct3)
          FUNCT3_ADD_SUB: alu_control = ALU_ADD;
          FUNCT3_SLL:     alu_control = ALU_SLL;
          FUNCT3_SLT:     alu_control = ALU_SLT;
          FUNCT3_SLTU:    alu_control = ALU_SLTU;
          FUNCT3_XOR:     alu_control = ALU_XOR;
          FUNCT3_SR_AR:   alu_control = (funct7 == FUNCT7_SUB_SRA) ? ALU_SRA : ALU_SRL;
          FUNCT3_OR:      alu_control = ALU_OR;
          FUNCT3_AND:     alu_control = ALU_AND;
          default:        alu_control = ALU_ADD;
        endcase
      end
      OPCODE_I_TYPE_LOAD, OPCODE_S_TYPE, OPCODE_B_TYPE,
      OPCODE_U_TYPE_AUIPC, OPCODE_J_TYPE_JAL, OPCODE_I_TYPE_JALR:
        alu_control = ALU_ADD;
      OPCODE_U_TYPE_LUI:
        alu_control = ALU_PASS_B;
      default:
        alu_control = ALU_ADD;
    endcase
  end

endmodule