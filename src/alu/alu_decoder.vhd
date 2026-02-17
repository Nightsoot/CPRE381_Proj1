-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- alu_decoder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a decoder for ALU instructions
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alu_decoder is
    port(
        i_ALU_op : in std_logic_vector(3 downto 0);
        o_mux_ctrl : out std_logic_vector(2 downto 0);
        o_barrel_left : out std_logic;
        o_barrel_sign : out std_logic;
        o_adder_cin : out std_logic
    );
end alu_decoder;

architecture dataflow of alu_decoder is
begin
    --ADD, SUB, SLT, SLTU
    o_mux_ctrl <= "000" when(
        (i_ALU_op = "0000") or
        (i_ALU_op = "0001") or
        (i_ALU_op = "1000") or
        (i_ALU_op = "1001")
        )
        else
        --AND
        "001" when(i_ALU_op = "0010")
        else
        --OR
        "010" when(i_ALU_op = "0011")
        else
        --XOR
        "011" when(i_ALU_op = "0100")
        else
        --Barrel Shifter
        "100" when(
        (i_ALU_op = "0101") or
        (i_ALU_op = "0110") or
        (i_ALU_op = "0111")
        )
        else "000";

    o_barrel_left <= '0' when(i_ALU_op = "0101")
    else
    '1' when(
        (i_ALU_op = "0110") or
        (i_ALU_op = "0111")
    )
    else '0';

    o_barrel_sign <= '1'
    when(i_ALU_op = "0111")
    else '0';

    o_adder_cin <= '1' when(
        (i_ALU_op = "0001") or
        (i_ALU_op = "1000") or
        (i_ALU_op = "1001")
    )
    else
    '0';

end dataflow;