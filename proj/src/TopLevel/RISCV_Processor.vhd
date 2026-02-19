-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- RISCV_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a RISCV_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-- 04/10/2025 by AP::Coverted to RISC-V.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.RISCV_types.all;

entity RISCV_Processor is
  generic (N : integer := DATA_WIDTH);
  port (
    iCLK : in std_logic;
    iRST : in std_logic;
    iInstLd : in std_logic;
    iInstAddr : in std_logic_vector(N - 1 downto 0);
    iInstExt : in std_logic_vector(N - 1 downto 0);
    oALUOut : out std_logic_vector(N - 1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end RISCV_Processor;
architecture structure of RISCV_Processor is

  -- Required data memory signals
  signal s_DMemWr : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the data memory output

  -- Required register file signals 
  signal s_RegWr : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr : std_logic_vector(N - 1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt : std_logic; -- TODO: this signal indicates to the simulation that intended program execution has completed. (Use WFI with Opcode: 111 0011)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl : std_logic; -- TODO: this signal indicates an overflow exception would have been initiated

  component mem is
    generic (
      ADDR_WIDTH : integer;
      DATA_WIDTH : integer);
    port (
      clk : in std_logic;
      addr : in std_logic_vector((ADDR_WIDTH - 1) downto 0);
      data : in std_logic_vector((DATA_WIDTH - 1) downto 0);
      we : in std_logic := '1';
      q : out std_logic_vector((DATA_WIDTH - 1) downto 0));
  end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment
  component alu is
    port (
      i_opperand1 : in std_logic_vector(31 downto 0);
      i_opperand2 : in std_logic_vector(31 downto 0);
      i_ALU_op : in std_logic_vector(3 downto 0);
      o_F : out std_logic_vector(31 downto 0);
      o_C : out std_logic;
      o_N : out std_logic;
      o_V : out std_logic;
      o_Z : out std_logic
    );
  end component;

  component control_decoder is

    port (
      i_instruction : in std_logic_vector(31 downto 0);
      o_ALU_src : out std_logic;
      o_ALU_control : out std_logic_vector(3 downto 0);
      o_imm_type : out std_logic_vector(2 downto 0);
      o_result_src : out std_logic_vector(1 downto 0);
      o_mem_write : out std_logic;
      o_reg_write : out std_logic;
      o_reg_read : out std_logic;
      o_PC_source : out std_logic_vector(1 downto 0);
      o_mem_slice : out std_logic_vector(2 downto 0);
      o_comparison : out std_logic_vector(2 downto 0);
      o_halt : out std_logic
    );
  end component;

  component imm_gen is

    port (
      i_instruction : in std_logic_vector(31 downto 0);
      --0 12 bit unsigned (I)
      --1 12 bit signed (I)
      --2 20 bit upper immediate (U)
      --3 12 bit padded (SB)
      --4 20 bit padded (UJ)
      --5 12 bit signed memory (I)
      --6 12 bit signed store  (S)
      i_imm_type : in std_logic_vector(2 downto 0);
      o_imm32 : out std_logic_vector(31 downto 0)
    );

  end component;

  component fetch_logic is

    port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      --"old" PC value
      i_PC : in std_logic_vector(31 downto 0);
      i_imm : in std_logic_vector(31 downto 0);
      --used for register relative addressing
      i_ALU_result : in std_logic_vector(31 downto 0);
      --control signals
      i_PC_source : in std_logic_vector(1 downto 0);
      i_comparison : in std_logic_vector(2 downto 0);
      --comaprison flags
      i_zero : in std_logic;
      i_negative : in std_logic;
      i_carry : in std_logic;
      i_overflow : in std_logic;
      --new PC used by the program memory
      o_new_PC : out std_logic_vector(31 downto 0);
      o_PC_4 : out std_logic_vector(31 downto 0);
      o_PC_imm : out std_logic_vector(31 downto 0)
    );
  end component;

  component reg_file is

    port (
      i_CLK : in std_logic; -- Clock input
      i_RST : in std_logic; -- Reset input
      i_read_reg1 : in std_logic_vector(4 downto 0);
      i_read_reg2 : in std_logic_vector(4 downto 0);
      i_write_reg : in std_logic_vector(4 downto 0);
      i_write_value : in std_logic_vector(31 downto 0);
      i_read_write : in std_logic;
      o_read_value1 : out std_logic_vector(31 downto 0);
      o_read_value2 : out std_logic_vector(31 downto 0));

  end component;

  component mem_slice is

    port (
      i_data : in std_logic_vector(31 downto 0);
      i_add_2LSB : in std_logic_vector(1 downto 0);
      --0: FULL WORD
      --1: BYTE SIGNED
      --2: HALFWORD SIGNED
      --3: BYTE UNSIGNED
      --4: HALFWORD UNSIGNED
      i_slice_type : in std_logic_vector(2 downto 0);
      o_data : out std_logic_vector(31 downto 0)
    );

  end component;

  --control signals
  signal s_ALU_src : std_logic;
  signal s_ALU_control : std_logic_vector(3 downto 0);
  signal s_imm_type : std_logic_vector(2 downto 0);
  signal s_result_src : std_logic_vector(1 downto 0);
  signal s_mem_write : std_logic;
  signal s_reg_write : std_logic;
  signal s_reg_read : std_logic;
  signal s_PC_source : std_logic_vector(1 downto 0);
  signal s_mem_slice : std_logic_vector(2 downto 0);
  signal s_comparison : std_logic_vector(2 downto 0);

  signal s_imm32 : std_logic_vector(31 downto 0);

  signal s_read_value1, s_read_value1_adjusted, s_read_value2, s_write_value : std_logic_vector(31 downto 0);
  signal s_ALU_operand2 : std_logic_vector(31 downto 0);

  signal s_ALU_result : std_logic_vector(31 downto 0);
  signal s_C : std_logic;
  signal s_N : std_logic;
  signal s_V : std_logic;
  signal s_Z : std_logic;

  signal s_mem_out : std_logic_vector(31 downto 0);

  signal s_PC_4, s_PC_imm : std_logic_vector(31 downto 0);

begin
  s_Ovfl <= '0';
  s_RegWrData <= s_write_value;
  s_RegWrAddr <= s_Inst(11 downto 7);

  oALUout <= s_ALU_result;

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
    iInstAddr when others;
  IMem : mem
  generic map(
    ADDR_WIDTH => ADDR_WIDTH,
    DATA_WIDTH => N)
  port map(
    clk => iCLK,
    addr => s_IMemAddr(11 downto 2),
    data => iInstExt,
    we => iInstLd,
    q => s_Inst);

  DMem : mem
  generic map(
    ADDR_WIDTH => ADDR_WIDTH,
    DATA_WIDTH => N)
  port map(
    clk => iCLK,
    addr => s_DMemAddr(11 downto 2),
    data => s_DMemData,
    we => s_DMemWr,
    q => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 
  g_control_decoder : control_decoder
  port map(
    i_instruction => s_Inst,
    o_ALU_src => s_ALU_src,
    o_ALU_control => s_ALU_control,
    o_imm_type => s_imm_type,
    o_result_src => s_result_src,
    o_mem_write => s_DMemWr,
    o_reg_write => s_RegWr,
    o_reg_read => s_reg_read,
    o_PC_source => s_PC_source,
    o_mem_slice => s_mem_slice,
    o_comparison => s_comparison,
    o_halt => s_Halt
  );

  g_imm_gen : imm_gen
  port map(
    i_instruction => s_Inst,
    i_imm_type => s_imm_type,
    o_imm32 => s_imm32
  );
  g_reg_file : reg_file
  port map(
    i_CLK => iCLK,
    i_RST => iRST,
    i_read_reg1 => s_Inst(19 downto 15),
    i_read_reg2 => s_Inst(24 downto 20),
    i_write_reg => s_Inst(11 downto 7),
    i_write_value => s_write_value,
    i_read_write => s_RegWr,
    o_read_value1 => s_read_value1,
    o_read_value2 => s_read_value2
  );

  --zeros out rs1 if not reading for lui
  s_read_value1_adjusted <= s_read_value1 when (s_reg_read = '1') else
    X"00000000";

  --switch between immediate and read value
  s_ALU_operand2 <= s_imm32 when (s_ALU_src = '1') else
    s_read_value2;

  g_ALU : alu
  port map(
    i_opperand1 => s_read_value1_adjusted,
    i_opperand2 => s_ALU_operand2,
    i_ALU_op => s_ALU_control,
    o_F => s_ALU_result,
    o_C => s_C,
    o_N => s_N,
    o_V => s_V,
    o_Z => s_Z
  );

  s_DMemAddr <= s_ALU_result;
  s_DMemData <= s_read_value2;

  g_fetch_logic : fetch_logic
  port map(
    i_CLK => iCLK,
    i_RST => iRST,
    i_PC => s_IMemAddr,
    i_imm => s_imm32,
    i_ALU_result => s_ALU_result,
    i_PC_source => s_PC_source,
    i_comparison => s_comparison,
    i_zero => s_Z,
    i_negative => s_N,
    i_carry => s_C,
    i_overflow => s_V,
    o_new_PC => s_NextInstAddr,
    o_PC_4 => s_PC_4,
    o_PC_imm => s_PC_imm
  );

  g_mem_slice : mem_slice
  port map(
    i_data => s_DMemOut,
    i_add_2LSB => s_DMemAddr(1 downto 0),
    i_slice_type => s_mem_slice,
    o_data => s_mem_out
  );

  --the various different result sources
  s_write_value <= s_ALU_result when(s_result_src = "00")
    else
    s_mem_out when(s_result_src = "01")
    else
    s_PC_4 when(s_result_src = "10")
    else
    s_PC_imm;

end structure;