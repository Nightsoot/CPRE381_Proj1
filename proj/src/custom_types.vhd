-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- custom_types.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a package with custom data types for ease
-- of development
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

--allows an array of variable size of word logic vectors
package custom_types is
    subtype word_t is std_logic_vector(31 downto 0);
    type word_array_t is array (natural range <>) of std_logic_vector(31 downto 0);
end package custom_types;