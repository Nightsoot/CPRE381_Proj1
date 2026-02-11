-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- imm_gen.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an immediate generator to take the instruciton and output it to its proper 32-bit value
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity imm_gen is

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

end imm_gen;
architecture dataflow of imm_gen is

    signal s_I_type, s_S_type : std_logic_vector(11 downto 0);
    signal s_SB_type : std_logic_vector(12 downto 0);
    signal s_U_type : std_logic_vector(19 downto 0);
    signal s_UJ_type : std_logic_vector(20 downto 0);

    --padding for 12 bit signed
    signal s_sign_pad_12 : std_logic_vector(19 downto 0);

begin
    --assigns the different ways an immediate can be encoded
    s_I_type <= i_instruction(31 downto 20);
    s_S_type <= i_instruction(31 downto 25) & i_instruction(11 downto 7);
    s_SB_type <= i_instruction(31) & i_instruction(7) & i_instruction(30 downto 25) & i_instruction(11 downto 8) & '0';
    s_U_type <= i_instruction(31 downto 12);
    s_UJ_type <= i_instruction(31) & i_instruction(19 downto 12) & i_instruction(20) & i_instruction(30 downto 21) & '0';

    --0 12 bit unsigned (I)
    --1 12 bit signed (I)
    --2 20 bit upper immediate (U)
    --3 12 bit padded (SB)
    --4 20 bit padded (UJ)
    --5 12 bit signed store  (S)
    --0 padding
    o_imm32(31 downto 0) <= (19 downto 0 => '0') & s_I_type when(
    i_imm_type = "000"
    )
    --Sign extended
else
    (19 downto 0 => s_I_type(11)) & s_I_type when(
    i_imm_type = "001"
    )
    --0's to the right
else
    s_U_type & (11 downto 0 => '0') when(
    i_imm_type = "010"
    )
    --sign extended
else
    (18 downto 0 => s_SB_type(12)) & s_SB_type when(
    i_imm_type = "011"
    )
    --sign extended
else
    (10 downto 0 => s_UJ_type(20)) & s_UJ_type when(
    i_imm_type = "100"
    )
    --sign extended
else
    (19 downto 0 => s_S_type(11)) & s_S_type when(
    i_imm_type = "101"
    )
else
    (others => '0');

end dataflow;