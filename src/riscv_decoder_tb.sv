import riscv_defines::*;

module riscv_decoder_tb;

  logic [31:0] instruction;
  logic [31:0] reg_read_data1;
  logic [31:0] reg_read_data2;
  logic [31:0] pc;

  logic [31:0] alu_operand_a;
  logic [31:0] alu_operand_b;
  logic [3:0]  alu_control;
  logic        reg_write_enable;
  logic [4:0]  reg_write_dest;
  logic        mem_read_enable;
  logic        mem_write_enable;
  logic        mem_to_reg;
  logic        branch_enable;
  logic        jump_enable;
  logic [1:0]  next_pc_select;

  riscv_decoder u_decoder (
      .instruction        (instruction),
      .reg_read_data1     (reg_read_data1),
      .reg_read_data2     (reg_read_data2),
      .pc                 (pc),

      .alu_operand_a      (alu_operand_a),
      .alu_operand_b      (alu_operand_b),
      .alu_control        (alu_control),
      .reg_write_enable   (reg_write_enable),
      .reg_write_dest     (reg_write_dest),
      .mem_read_enable    (mem_read_enable),
      .mem_write_enable   (mem_write_enable),
      .mem_to_reg         (mem_to_reg),
      .branch_enable      (branch_enable),
      .jump_enable        (jump_enable),
      .next_pc_select     (next_pc_select)
  );

  initial begin
    $dumpfile("riscv_decoder.vcd");
    $dumpvars(0, riscv_decoder_tb);

    reg_read_data1 = 32'h00000100;
    reg_read_data2 = 32'h00000020;
    pc             = 32'h80000000;

    $display("--- RISC-V Decoder Testbench ---");
    $display("Initial values: RegReadData1=0x%h, RegReadData2=0x%h, PC=0x%h", reg_read_data1, reg_read_data2, pc);

    // Test 1: ADD x3, x1, x2 (R-type)
    // 0x002081B3 (binary: 0000000 00010 00001 000 00011 0110011)
    instruction = 32'h002081B3;
    #10;
    $display("\nTest 1: ADD x3, x1, x2 (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select); // 16進数で表示

    // Test 2: ADDI x4, x1, 10 (I-type ALU)
    // 0x00A08213 (binary: 000000001010 00001 000 00100 0010011)
    instruction = 32'h00A08213;
    #10;
    $display("\nTest 2: ADDI x4, x1, 10 (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select);

    // Test 3: LW x5, 4(x1) (I-type LOAD)
    // 0x0040A283
    instruction = 32'h0040A283;
    #10;
    $display("\nTest 3: LW x5, 4(x1) (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select);

    // Test 4: SW x2, 8(x1) (S-type)
    // 0x00212423
    instruction = 32'h00212423;
    #10;
    $display("\nTest 4: SW x2, 8(x1) (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select);

    // Test 5: BEQ x1, x2, 12 (B-type)
    // 0x00C08663
    instruction = 32'h00C08663;
    #10;
    $display("\nTest 5: BEQ x1, x2, 12 (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select);

    // Test 6: JAL x6, 20 (J-type)
    // 0x0140036F
    instruction = 32'h0140036F;
    #10;
    $display("\nTest 6: JAL x6, 20 (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select);

    // Test 7: LUI x11, 0x12345 (U-type)
    // 0x012345B7
    instruction = 32'h012345B7;
    #10;
    $display("\nTest 7: LUI x11, 0x12345 (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select);

    // Test 8: AUIPC x29, 0xABCDE (U-type)
    // 0x0ABCDE97
    instruction = 32'h0ABCDE97;
    #10;
    $display("\nTest 8: AUIPC x29, 0xABCDE (0x%h)", instruction);
    $display("  ALU_OperandA = 0x%h, ALU_OperandB = 0x%h", alu_operand_a, alu_operand_b);
    $display("  ALU_Control = 0x%h", alu_control);
    $display("  RegWriteEnable = %b, RegWriteDest = x%d", reg_write_enable, reg_write_dest);
    $display("  MemReadEnable = %b, MemWriteEnable = %b, MemToReg = %b", mem_read_enable, mem_write_enable, mem_to_reg);
    $display("  BranchEnable = %b, JumpEnable = %b, NextPCSelect = 0x%h", branch_enable, jump_enable, next_pc_select);

    $finish;

  end

endmodule