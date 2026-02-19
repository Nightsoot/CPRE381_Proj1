-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- reg_pc.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an posedge-triggered
-- generic N-bit register
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_pc is

    generic (N : integer := 32);
    port (
        i_CLK : in std_logic; -- Clock input
        i_RST : in std_logic; -- Reset input
        i_WE : in std_logic; -- Write enable input
        i_D : in std_logic_vector(N - 1 downto 0); -- Data vector input
        o_Q : out std_logic_vector(N - 1 downto 0)); -- Data vector output

end reg_pc;

architecture structural of reg_pc is
    signal s_D : std_logic; -- Multiplexed input to the FF
    signal s_Q : std_logic; -- Output of the FF

    component dffg is
        port (
            i_CLK : in std_logic; -- Clock input
            i_RST : in std_logic; -- Reset input
            i_WE : in std_logic; -- Write enable input
            i_D : in std_logic; -- Data value input
            o_Q : out std_logic); -- Data value output
    end component;

    component dffg_high is

        port (
            i_CLK : in std_logic; -- Clock input
            i_RST : in std_logic; -- Reset input
            i_WE : in std_logic; -- Write enable input
            i_D : in std_logic; -- Data value input
            o_Q : out std_logic); -- Data value output

    end component;
begin

    G_NBit_REG : for i in 0 to N - 1 generate
        high : if i = 22 generate
            REGI : dffg_high port map(
                i_CLK => i_CLK,
                i_RST => i_RST,
                i_WE => i_WE,
                i_D => i_D(i),
                o_Q => o_Q(i)
            );
        end generate high;

        low : if i /= 22 generate
            REGI : dffg port map(
                i_CLK => i_CLK,
                i_RST => i_RST,
                i_WE => i_WE,
                i_D => i_D(i),
                o_Q => o_Q(i)
            );
        end generate low;
    end generate G_NBit_REG;

end structural;