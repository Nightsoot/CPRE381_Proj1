-- -------------------------------------------------------------------------
-- -- David Rice
-- -- Department of Electrical and Computer Engineering
-- -- Iowa State University
-- -------------------------------------------------------------------------
-- -- tb_mem_slice.vhd
-- -------------------------------------------------------------------------
-- -- DESCRIPTION: This file contains a simple VHDL testbench for the
-- -- immediate generator
-- --
-- --
-- -------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
entity tb_mem_slice is
    generic (gCLK_HPER : time := 50 ns);
end tb_mem_slice;

architecture behavior of tb_mem_slice is

    -- Calculate the clock period as twice the half-period
    constant cCLK_PER : time := gCLK_HPER * 2;
    component mem_slice is

        port (
            i_data : in std_logic_vector(31 downto 0);
            --0: FULL WORD
            --1: BYTE SIGNED
            --2: HALFWORD SIGNED
            --3: BYTE UNSIGNED
            --4: HALFWORD UNSIGNED
            i_slice_type : in std_logic_vector(2 downto 0);
            o_data : out std_logic_vector(31 downto 0)
        );

    end component;

    -- Temporary signals to connect to the dff component.
    signal s_CLK, s_RST : std_logic;

    -- Temporary signals to connect to the decoder component.
    signal s_data_i, s_data_o : std_logic_vector(31 downto 0);
    signal s_slice_type : std_logic_vector(2 downto 0);

begin

    DUT : mem_slice
    port map(
        i_data => s_data_i,
        i_slice_type => s_slice_type,
        o_data => s_data_o
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

        s_data_i <= X"FFFFFFFF";
        s_slice_type <= "000";
        wait for cCLK_PER;

        s_data_i <= X"FFFFFFFF";
        s_slice_type <= "001";
        wait for cCLK_PER;

        s_data_i <= X"FFFFFFFF";
        s_slice_type <= "010";
        wait for cCLK_PER;

        s_data_i <= X"FFFFFFFF";
        s_slice_type <= "011";
        wait for cCLK_PER;

        s_data_i <= X"FFFFFFFF";
        s_slice_type <= "100";
        wait for cCLK_PER;

        

        wait;
    end process;

end behavior;