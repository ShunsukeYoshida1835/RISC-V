module immediate_generator (
    input  logic [31:0] instruction,
    input  logic [6:0]  opcode,
    output logic [31:0] immediate
);

import riscv_defines::*;

  always_comb begin
    immediate = 32'b0;
    
    case (opcode)
      OPCODE_I_TYPE_ALU, OPCODE_I_TYPE_LOAD, OPCODE_I_TYPE_JALR: begin
        immediate = {{20{instruction[31]}}, instruction[31:20]};
      end
      OPCODE_S_TYPE: begin
immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
      end
      OPCODE_B_TYPE: begin
        immediate = {{19{instruction[31]}},
                     instruction[31],
                     instruction[7],
                     instruction[30:25],
                     instruction[11:8],
                     1'b0};
      end
      OPCODE_U_TYPE_LUI, OPCODE_U_TYPE_AUIPC: begin
        immediate = {instruction[31:12], 12'b0};
      end
      OPCODE_J_TYPE_JAL: begin
        immediate = {{11{instruction[31]}},
                     instruction[31],
                     instruction[19:12],
                     instruction[20],
                     instruction[30:21],
                     1'b0};
      end
      default: immediate = 32'b0;
    endcase
  end

endmodule