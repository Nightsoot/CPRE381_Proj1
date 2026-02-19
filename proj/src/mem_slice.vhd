-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mem_slice.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an immediate generator to take the instruciton and output it to its proper 32-bit value
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity mem_slice is

    port (
        i_data : in std_logic_vector(31 downto 0);
        i_add_2LSB : in std_logic_vector(1 downto 0);
        --0: FULL WORD
        --1: BYTE SIGNED
        --2: HALFWORD SIGNED
        --3: BYTE UNSIGNED
        --4: HALFWORD UNSIGNED
        i_slice_type : in std_logic_vector(2 downto 0);
        o_data : out std_logic_vector(31 downto 0)
    );

end mem_slice;

architecture dataflow of mem_slice is
    signal s_byte : std_logic_vector(7 downto 0);
    signal s_half : std_logic_vector(15 downto 0);

begin

    s_byte <= i_data(7 downto 0) when (
        i_add_2LSB = "00"
        )
        else
        i_data(15 downto 8) when (
        i_add_2LSB = "01"
        )
        else
        i_data(23 downto 16) when (
        i_add_2LSB = "10"
        )
        else
        i_data(31 downto 24);

    s_half <= i_data(15 downto 0) when (i_add_2LSB = "00") else i_data(31 downto 16);

    o_data <= i_data when(
        i_slice_type = "000"
        )
        else
        (23 downto 0 => s_byte(7)) & s_byte when(
        i_slice_type = "001"
        )
        else
        (15 downto 0 => s_half(15)) & s_half when(
        i_slice_type = "010"
        )
        else
        (23 downto 0 => '0') & s_byte when(
        i_slice_type = "011"
        )
        else
        (15 downto 0 => '0') & s_half when(
        i_slice_type = "100"
        )
        else
        i_data;

end dataflow;