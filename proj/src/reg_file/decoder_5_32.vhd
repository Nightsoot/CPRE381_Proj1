-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- decoder_5_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 5-32 decoder
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity decoder_5_32 is

    port (
        i_S : in std_logic_vector(4 downto 0); -- Data vector input
        o_Y : out std_logic_vector(31 downto 0)); -- Data vector output

end decoder_5_32;
architecture dataflow of decoder_5_32 is
begin

    G_NBit_REG : for i in 0 to 31 generate
        o_Y(i) <= '1' when to_integer(unsigned(i_S)) = i else '0';
    end generate G_NBit_REG;

end dataflow;