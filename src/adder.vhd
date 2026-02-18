-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32-bit adder
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity adder is
    port(
        i_opperand1 : in std_logic_vector(31 downto 0);
        i_opperand2 : in std_logic_vector(31 downto 0);
        i_carry : in std_logic;
        o_result : out std_logic_vector(31 downto 0);
        o_carry_o : out std_logic;
        o_carry_i : out std_logic
    );
end adder;

architecture structural of adder is
    component adder_S is
        port(i_A : in  std_logic;
             i_B : in  std_logic;
             i_C : in  std_logic;
             o_S : out std_logic;
             o_C : out std_logic);
    end component;

    signal s_C  : std_logic_vector(30 downto 0);

begin

    g_Adder0: adder_S
        port MAP(i_A => i_opperand1(0),
                 i_B => i_opperand2(0),
                 i_C => i_carry,
                 o_S => o_result(0),
                 o_C => s_C(0));

    g_Adder31: adder_S
        port MAP(i_A => i_opperand1(31),
                 i_B => i_opperand2(31),
                 i_C => s_C(30),
                 o_S => o_result(31),
                 o_C => o_carry_o);

    o_carry_i <= s_C(30);

    G_NBit_adder: for i in 1 to 30 generate
        ADDERI: adder_S port map(
            i_A => i_opperand1(i),
            i_B => i_opperand2(i),
            i_C => s_C(i-1),
            o_S => o_result(i),
            o_C => s_C(i));
    end generate G_NBit_adder;

end structural;