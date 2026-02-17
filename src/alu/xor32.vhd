-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- xor32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32-bit xor gate
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity xor32 is
    port(
        i_A : in std_logic_vector(31 downto 0);
        i_B : in std_logic_vector(31 downto 0);
        o_F : out std_logic_vector(31 downto 0)
    );
end xor32;

architecture dataflow of xor32 is
begin
    o_F <= i_A xor i_B;
end dataflow;
