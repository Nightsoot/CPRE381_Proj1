-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- and32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32-bit and gate
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity and32 is
    port(
        i_A : in std_logic_vector(31 downto 0);
        i_B : in std_logic_vector(31 downto 0);
        o_F : out std_logic_vector(31 downto 0)
    );
end and32;

architecture dataflow of and32 is
begin
    o_F <= i_A and i_B;
end dataflow;
