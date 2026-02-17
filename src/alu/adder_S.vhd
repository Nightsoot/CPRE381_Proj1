-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder_S.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1 bit adder
--
--
-- NOTES:
-- 1/28/26 Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder_S is
    port(i_A : in  std_logic;
         i_B : in  std_logic;
         i_C : in  std_logic;
         o_S : out std_logic;
         o_C : out std_logic);
end adder_S;

architecture structural of adder_S is
    component xorg2
        port(i_A          : in  std_logic;
             i_B          : in  std_logic;
             o_F          : out std_logic);
    end component;

    component andg2
        port(i_A : in  std_logic;
		     i_B : in  std_logic;
		     o_F : out std_logic);
    end component;

    component org2
		port(i_A : in  std_logic;
		     i_B : in  std_logic;
		     o_F : out std_logic);
    end component;

    signal s_X  : std_logic; --xor intermediate
    signal s_A1 : std_logic; --and 1 intermediate
    signal s_A2 : std_logic;

begin
    g_And1: andg2
    port MAP(i_A => s_X,
             i_B => i_C,
             o_F => s_A1);

    g_And2: andg2
    port MAP(i_A => i_A,
             i_B => i_B,
             o_F => s_A2);

    g_Xor1: xorg2
    port MAP(i_A => i_A,
             i_B => i_B,
             o_F => s_X);

    g_Xor2: xorg2
    port MAP(i_A => s_X,
             i_B => i_C,
             o_F => o_S);
             
    g_Or: org2
    port MAP(i_A => s_A1,
             i_B => s_A2,
             o_F => o_C);

end structural;
