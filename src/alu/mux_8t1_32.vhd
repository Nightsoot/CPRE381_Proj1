-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux8t1_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32-bit wide 8 to 1 mux
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux8t1_32 is
    port(
        i_D0 : in std_logic_vector(31 downto 0);
        i_D1 : in std_logic_vector(31 downto 0);
        i_D2 : in std_logic_vector(31 downto 0);
        i_D3 : in std_logic_vector(31 downto 0);
        i_D4 : in std_logic_vector(31 downto 0);
        i_D5 : in std_logic_vector(31 downto 0);
        i_D6 : in std_logic_vector(31 downto 0);
        i_D7 : in std_logic_vector(31 downto 0);
        i_S  : in std_logic_vector(2 downto 0);
        o_F  : out std_logic_vector(31 downto 0)
    );
end mux8t1_32;

architecture dataflow of mux8t1_32 is
begin
    with i_S select
        o_F <= i_D0 when "000",
               i_D1 when "001",
               i_D2 when "010",
               i_D3 when "011",
               i_D4 when "100",
               i_D5 when "101",
               i_D6 when "110",
               i_D7 when "111",
               x"00000000" when others;
end dataflow;