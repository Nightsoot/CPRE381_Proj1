-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux_32_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 bit wide 32 bit mux
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.custom_types.all;
use IEEE.NUMERIC_STD.all;
entity mux_32_32 is

    port (
        i_S : in std_logic_vector(4 downto 0); -- select vector input
        i_D : in word_array_t(0 to 31); --Data choice array
        o_Y : out std_logic_vector(31 downto 0)); -- vector output

end mux_32_32;
architecture dataflow of mux_32_32 is
begin

    o_Y <= i_D(to_integer(unsigned(i_S)));

end dataflow;