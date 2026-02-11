-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a VHDL testbench for the barrel shifter
-- automated test cases are made with the corresponding python script
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
entity tb_barrel_shifter is
    generic (gCLK_HPER : time := 50 ns);
end tb_barrel_shifter;

architecture behavior of tb_barrel_shifter is

    -- Calculate the clock period as twice the half-period
    constant cCLK_PER : time := gCLK_HPER * 2;
    component barrel_shifter
        port (
            i_opperand : in std_logic_vector(31 downto 0);
            i_shift : in std_logic_vector(4 downto 0);
            i_left : in std_logic;--0 for right shift, 1 for left shift
            i_sign_fill : in std_logic;
            o_result : out std_logic_vector(31 downto 0)
        );

    end component;
    -- Temporary signals to connect to the dff component.
    signal s_CLK, s_RST : std_logic;

    signal s_operand, s_result : std_logic_vector(31 downto 0);
    signal s_shift : std_logic_vector(7 downto 0);
    signal s_left, s_sign_fill : std_logic;

    signal s_shift_real : std_logic_vector(4 downto 0);


    --case number
    signal s_case_number : integer := 0;

begin
    s_shift_real <= s_shift(4 downto 0);

    DUT : barrel_shifter
    port map(
        i_opperand => s_operand,
        i_shift => s_shift_real,
        i_left => s_left, --0 for right shift, 1 for left shift
        i_sign_fill => s_sign_fill,
        o_result => s_result
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

        s_operand <= X"80000000";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        assert (s_result = X"FFFFFFFF") report "Case 0 failed" severity error;
        s_case_number <= 0;
        wait for cCLK_PER;

        s_operand <= X"80000000";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '0';
        assert (s_result = X"00000001") report "Case 1 failed" severity error;
        s_case_number <= 1;
        wait for cCLK_PER;

        s_operand <= X"80000000";
        s_shift <= X"01";
        s_left <= '1';
        s_sign_fill <= '0';
        assert (s_result = X"00000000") report "Case 2 failed" severity error;
        s_case_number <= 2;
        wait for cCLK_PER;

        s_operand <= X"FFFFFFFF";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        assert (s_result = X"FFFFFFFF") report "Case 3 failed" severity error;
        s_case_number <= 3;
        wait for cCLK_PER;

        s_operand <= X"00000000";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        assert (s_result = X"00000000") report "Case 4 failed" severity error;
        s_case_number <= 4;
        wait for cCLK_PER;
    end process;

end behavior;