module main_control_unit (
    input  logic [6:0]  opcode,
    output logic        reg_write_enable,
    output logic        mem_read_enable,
    output logic        mem_write_enable,
    output logic        mem_to_reg,
    output logic        branch_enable,
    output logic        jump_enable,
    output logic [1:0] next_pc_select
);

  import riscv_defines::*;

  always_comb begin
    reg_write_enable = 1'b0;
    mem_read_enable  = 1'b0;
    mem_write_enable = 1'b0;
    mem_to_reg       = 1'b0;
    branch_enable    = 1'b0;
    jump_enable      = 1'b0;
    next_pc_select   = NEXT_PC_PC_PLUS_4;

    case (opcode)
      OPCODE_R_TYPE: begin
        reg_write_enable = 1'b1;
        mem_to_reg       = 1'b0;
      end
      OPCODE_I_TYPE_ALU: begin
        reg_write_enable = 1'b1;
        mem_to_reg       = 1'b0;
      end
      OPCODE_I_TYPE_LOAD: begin
        reg_write_enable = 1'b1;
        mem_read_enable  = 1'b1;
        mem_to_reg       = 1'b1;
      end
      OPCODE_S_TYPE: begin
        mem_write_enable = 1'b1;
      end
      OPCODE_B_TYPE: begin
        branch_enable    = 1'b1;
        next_pc_select   = NEXT_PC_BRANCH_JUMP_TARGET;
      end
      OPCODE_U_TYPE_LUI: begin
        reg_write_enable = 1'b1;
        mem_to_reg       = 1'b0;
      end
      OPCODE_U_TYPE_AUIPC: begin
        reg_write_enable = 1'b1;
        mem_to_reg       = 1'b0;
      end
      OPCODE_J_TYPE_JAL: begin
        reg_write_enable = 1'b1;
        jump_enable      = 1'b1;
        next_pc_select   = NEXT_PC_BRANCH_JUMP_TARGET;
      end
      OPCODE_I_TYPE_JALR: begin
        reg_write_enable = 1'b1;
        jump_enable      = 1'b1;
        next_pc_select   = NEXT_PC_JALR_TARGET;
      end
      default: begin
      end
    endcase
  end

endmodule