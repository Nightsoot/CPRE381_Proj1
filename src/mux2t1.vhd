-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 2 to 1 mux 
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
    port(
        i_S  : in std_logic;
        i_D0 : in std_logic;
        i_D1 : in std_logic;
        o_F  : out std_logic
    );
end mux2t1;

architecture dataflow of mux2t1 is
begin

    o_F <= i_D1 when (i_S = '1') else i_D1;

end dataflow;