-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_imm_gen.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- immediate generator
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


entity tb_imm_gen is
    generic (gCLK_HPER : time := 50 ns);
end tb_imm_gen;

architecture behavior of tb_imm_gen is

    -- Calculate the clock period as twice the half-period
    constant cCLK_PER : time := gCLK_HPER * 2;
    component imm_gen
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
        o_imm32 : out std_logic_vector(31 downto 0);
    );

    end component;
    -- Temporary signals to connect to the dff component.
    signal s_CLK, s_RST : std_logic;

    -- Temporary signals to connect to the decoder component.
    signal s_instruction: std_logic_vector(31 downto 0);
    signal s_imm_type: std_logic_vector(2 downto 0);
    signal s_imm_32 : std_logic_vector(31 downto 0);

begin

    DUT : imm_gen
    port map(
        i_instruction <= s_instruction;
        i_imm_type <= s_imm_type;
        o_imm32 <= s_imm_32;
    );

    -- This process sets the clock value (low for gCLK_HPER, then high
    -- for gCLK_HPER). Absent a "wait" command, processes restart 
    -- at the beginning once they have reached the final statement.
    P_CLK : process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    -- Testbench process  
    P_TB : process
    begin
        s_RST <= '1';
        wait for cCLK_PER;
        s_RST <= '0';

        s_instruction <= X"80100000";
        s_imm_type <= "0"
        wait for cCLK_PER;

        s_instruction <= X"80100000";
        s_imm_type <= "1"
        wait for cCLK_PER;

        s_instruction <= X"80100000";
        s_imm_type <= "1"
        wait for cCLK_PER;

        wait;
    end process;

end behavior;