package riscv_defines;

  localparam [6:0] OPCODE_R_TYPE        = 7'b0110011;
  localparam [6:0] OPCODE_I_TYPE_ALU    = 7'b0010011;
  localparam [6:0] OPCODE_I_TYPE_LOAD   = 7'b0000011;
  localparam [6:0] OPCODE_S_TYPE        = 7'b0100011;
  localparam [6:0] OPCODE_B_TYPE        = 7'b1100011;
  localparam [6:0] OPCODE_U_TYPE_LUI    = 7'b0110111;
  localparam [6:0] OPCODE_U_TYPE_AUIPC  = 7'b0010111;
  localparam [6:0] OPCODE_J_TYPE_JAL    = 7'b1101111;
  localparam [6:0] OPCODE_I_TYPE_JALR   = 7'b1100111;

  localparam [2:0] FUNCT3_ADD_SUB       = 3'b000;
  localparam [2:0] FUNCT3_SLL           = 3'b001;
  localparam [2:0] FUNCT3_SLT           = 3'b010;
  localparam [2:0] FUNCT3_SLTU          = 3'b011;
  localparam [2:0] FUNCT3_XOR           = 3'b100;
  localparam [2:0] FUNCT3_SR_AR         = 3'b101;
  localparam [2:0] FUNCT3_OR            = 3'b110;
  localparam [2:0] FUNCT3_AND           = 3'b111;

  localparam [6:0] FUNCT7_ADD_SLL_SRL_OR_AND_XOR_SLT_SLTU = 7'b0000000;
  localparam [6:0] FUNCT7_SUB_SRA                         = 7'b0100000;

  localparam [3:0] ALU_ADD = 4'b0000;
  localparam [3:0] ALU_SUB = 4'b0001;
  localparam [3:0] ALU_AND = 4'b0010;
  localparam [3:0] ALU_OR  = 4'b0011;
  localparam [3:0] ALU_XOR = 4'b0100;
  localparam [3:0] ALU_SLL = 4'b0101;
  localparam [3:0] ALU_SRL = 4'b0110;
  localparam [3:0] ALU_SRA = 4'b0111;
  localparam [3:0] ALU_SLT = 4'b1000;
  localparam [3:0] ALU_SLTU = 4'b1001;
  localparam [3:0] ALU_PASS_B = 4'b1111;

  localparam [1:0] NEXT_PC_PC_PLUS_4 = 2'b00;
  localparam [1:0] NEXT_PC_BRANCH_JUMP_TARGET = 2'b01;
  localparam [1:0] NEXT_PC_JALR_TARGET = 2'b10;

endpackage