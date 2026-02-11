-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- control_decoder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a decoder that takes the instruction and outputs the proper 
-- control signals for the whole processor
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_decoder is

    port (
        i_instruction : in std_logic_vector(31 downto 0);
        o_ALU_src : out std_logic;
        o_ALU_control : out std_logic_vector(2 downto 0);
        o_imm_type : out std_logic_vector(2 downto 0);
        o_result_src : out std_logic_vector(1 downto 0);
        o_mem_write : out std_logic;
        o_reg_write : out std_logic;
        o_reg_read : out std_logic;
        o_PC_source : out std_logic_vector(1 downto 0);
        o_mem_slice : out std_logic_vector(2 downto 0)
    );

end control_decoder;
architecture dataflow of control_decoder is

    signal s_opcode : std_logic_vector(6 downto 0);
    signal s_funct3 : std_logic_vector(2 downto 0);
    signal s_funct7 : std_logic_vector(6 downto 0);
begin
    --slicing off the different sections of the intstruciton for ease of use
    s_opcode <= i_instruction(6 downto 0);
    s_funct3 <= i_instruction(14 downto 12);
    s_funct7 <= i_instruction(31 downto 25);

    --ALU SRC logic
    o_ALU_src <= '1' when (
        (s_opcode = "0010011") or
        (s_opcode = "0000011") or
        (s_opcode = "0110111") or
        (s_opcode = "0100011"))
        else
        '0';

    --which operation
    --0: ADD
    --1: SUB
    --2: AND
    --3: OR
    --4: XOR
    --5: LSL
    --6: RSL
    --7: RSA 
    o_ALU_control <= "000" when(
        --ADD
        --add is weird case
        (s_opcode = "0110011" and s_funct3 = "000" and s_funct7 = "0000000") or
        (s_opcode = "0010011" and s_funct3 = "000") or
        (s_opcode = "0110111") or
        (s_opcode = "0000011")
        )
        else
        --SUB
        "001" when(
        --sub/slt/sltu is wierd case
        (s_opcode = "0110011" and s_funct3 = "000" and s_funct7 = "0100000") or
        (s_opcode = "0110011" and s_funct3 = "010" and s_funct7 = "0000000") or
        (s_opcode = "0110011" and s_funct3 = "011" and s_funct7 = "0000000") or
        (s_opcode = "1100011")
        )
        --AND
        else
        "010" when(
        (s_opcode = "0110011" and s_funct3 = "111") or
        (s_opcode = "0010011" and s_funct3 = "111")
        )
        --OR
        else
        "011" when(
        (s_opcode = "0110011" and s_funct3 = "110") or
        (s_opcode = "0010011" and s_funct3 = "110")
        )
        --XOR
        else
        "100" when(
        (s_opcode = "0110011" and s_funct3 = "100") or
        (s_opcode = "0010011" and s_funct3 = "100")
        )
        --LSL
        else
        "101" when(
        (s_opcode = "0110011" and s_funct3 = "001") or
        (s_opcode = "0010011" and s_funct3 = "001")
        )
        --RSL
        else
        "110" when(
        (s_opcode = "0110011" and s_funct3 = "101" and s_funct7 = "0000000") or
        (s_opcode = "0010011" and s_funct3 = "101" and s_funct7 = "0000000")
        )
        else
        "111" when(
        (s_opcode = "0110011" and s_funct3 = "101" and s_funct7 = "0100000") or
        (s_opcode = "0010011" and s_funct3 = "101" and s_funct7 = "0100000")
        )
        else
        "000";

    --what type of immediate
    --0 12 bit unsigned
    --1 12 bit signed
    --2 20 bit upper immediate
    --3 12 bit padded
    --4 20 bit padded   
    --12 bit unsigned
    o_imm_type <= "000" when(
        --not addi or slti
        (s_opcode = "0010011" and not (s_funct3 = "010" or s_funct3 = "000"))
        )
        else
        --12 bit signed
        "001" when(
        (s_opcode = "0010011" and (s_funct3 = "010" or s_funct3 = "000")) or
        (s_opcode = "0000011") or
        (s_opcode = "0100011")
        )
        else
        --20 bit upper immediate
        "010" when(
        (s_opcode = "0110111") or
        (s_opcode = "0010111")
        )
        else
        --12 bit padded
        "011" when(
        (s_opcode = "1100011") or
        (s_opcode = "1101111")
        )

        else
        --20 bit padded
        "100" when(
        --just jalr
        (s_opcode = "1100111")
        )
        else
        "000";

    --determines where the result for write data is coming from
    --0 = ALU
    --1 = MEMORY
    --2 = PC + 4
    --MEMORY
    o_result_src <= "01" when(
        (s_opcode = "0000011")
        )
        else
        --PC + 4
        "10" when(
        (s_opcode = "1101111") or
        (s_opcode = "1100111")
        )
        --ALU
        else
        "00";

    --write to memory
    o_mem_write <= '1' when (s_opcode = "0100011") else
        '0';

    --write to register file
    o_reg_write <= '0' when(
        (s_opcode = "0100011") or
        (s_opcode = "1100011") or
        (s_opcode = "0010111")
        )
        else
        '0';

    --forces regs to 0 for lui
    o_reg_read <= '0' when (s_opcode = "0110111") else
        '1';

    --controls where the PC's next value comes from
    --0: PC + 4
    --1: PC RELATIVE
    --2: REGISTER + OFFSET
    --PC RELATIVE
    o_PC_source <= "01" when (
        (s_opcode = "1100011") or
        (s_opcode = "0010111") or
        (s_opcode = "1101111")
        )
        else
        --REGISTER + OFFSET
        "10"
        when(
        (s_opcode = "1100111")
        )
        else
        --PC + 4
        "00";

    --determines how to slice memory as we always get a word at a time
    --0: FULL WORD
    --1: BYTE SIGNED
    --2: HALFWORD SIGNED
    --3: BYTE UNSIGNED
    --4: HALFWORD UNSIGNED
    --we can ignore the opcode as this is only relevant for one opcode
    o_mem_slice <= "001" when(
        (s_funct3 = "000")
        ) else
        "010" when(
        (s_funct3 = "001")
        )
        else
        "011" when(
        (s_funct3 = "100")
        )
        else
        "100" when(
        (s_funct3 = "101")
        )
        else
        "000";

end dataflow;