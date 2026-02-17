-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- or32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32-bit or gate
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity or32 is
    port(
        i_A : in std_logic_vector(31 downto 0);
        i_B : in std_logic_vector(31 downto 0);
        o_F : out std_logic_vector(31 downto 0)
    );
end or32;

architecture dataflow of or32 is
begin
    o_F <= i_A or i_B;
end dataflow;
