-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- nor32t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32-bit or gate
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity nor32t1 is
    port(
        i_A : in std_logic_vector(31 downto 0);
        o_F : out std_logic
    );
end nor32t1;

architecture dataflow of nor32t1 is
begin
    o_F <= nor i_A;
end dataflow;
