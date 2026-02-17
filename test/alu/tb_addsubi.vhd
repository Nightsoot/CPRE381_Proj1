-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for a 32-bit adder
--
--
-- NOTES:
-- 2/2/26 Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_addsub is
    generic(N : integer := 32);
end tb_addsub;

architecture mixed of tb_addsub is

    constant c_tstep : time := 10 ns;

    component adder is
        port(i_opperand1      : in  std_logic_vector(N-1 downto 0);
             i_opperand2      : in  std_logic_vector(N-1 downto 0);
             i_carry          : in  std_logic;
             o_result         : out std_logic_vector(N-1 downto 0);
             o_carry          : out std_logic);
    end component;

    signal s_A : std_logic_vector(N-1 downto 0) := x"00000000";
    signal s_B : std_logic_vector(N-1 downto 0) := x"00000000";
    signal s_iC : std_logic;
    signal s_S : std_logic_vector(N-1 downto 0) := x"00000000";
    signal s_oC : std_logic := '0';

begin

    ADDSUB0: adder
    port map(i_opperand1 => s_A,
             i_opperand2 => s_B,
             i_carry => s_iC,
             o_result => s_S,
             o_carry => s_oC);

    P_TEST_CASES: process
    begin
        wait for c_tstep;
        s_A <= x"00000001";
        s_B <= x"00000001";
        s_iC <= '0';
        wait for c_tstep;
        assert (s_S = x"00000002") report "Case 1 failed" severity error;
        assert (s_oC = '0') report "Carry Error Case 1 failed" severity error;

        wait for c_tstep;
        s_A <= x"00000001";
        s_B <= x"FFFFFFFF";
        s_iC <= '0';
        wait for c_tstep;
        assert (s_S = x"00000000") report "Case 2 failed" severity error;
        assert (s_oC = '1') report "Carry Error Case 2 failed" severity error;

        wait for c_tstep;
        s_A <= x"FFFFFFFF";
        s_B <= x"00000001";
        s_iC <= '0';
        wait for c_tstep;
        assert (s_S = x"FFFFFFFE") report "Case 3 failed" severity error;
        assert (s_oC = '0') report "Carry Error Case 3 failed" severity error;

        wait for c_tstep;
        s_A <= x"00000005";
        s_B <= x"00000042";
        s_iC <= '0';
        wait for c_tstep;
        assert (s_S = x"00000047") report "Case 4 failed" severity error;
        assert (s_oC = '0') report "Carry Error Case 4 failed" severity error;

        wait for c_tstep;
        s_A <= x"80000000";
        s_B <= x"FFFFFFFF";
        s_iC <= '0';
        wait for c_tstep;
        assert (s_S = x"7FFFFFFF") report "Case 5 failed" severity error;
        assert (s_oC = '1') report "Carry Error Case 5 failed" severity error;

        wait for c_tstep;
        s_A <= x"80000001";
        s_B <= x"7FFFFFFF";
        s_iC <= '0';
        wait for c_tstep;
        assert (s_S = x"00000000") report "Case 6 failed" severity error;
        assert (s_oC = '1') report "Carry Error Case 6 failed" severity error;

        wait;
    end process;
end mixed;