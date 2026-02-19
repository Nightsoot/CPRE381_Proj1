-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- reg_file.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an posedge-triggered
-- 32 register file
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.custom_types.all;

entity reg_file is

    port (
        i_CLK : in std_logic; -- Clock input
        i_RST : in std_logic; -- Reset input
        i_read_reg1 : in std_logic_vector(4 downto 0);
        i_read_reg2 : in std_logic_vector(4 downto 0);
        i_write_reg : in std_logic_vector(4 downto 0);
        i_write_value : in std_logic_vector(31 downto 0);
        i_read_write : in std_logic;
        o_read_value1 : out std_logic_vector(31 downto 0);
        o_read_value2 : out std_logic_vector(31 downto 0));

end reg_file;

architecture mixed of reg_file is
    signal s_D : std_logic; -- Multiplexed input to the FF
    signal s_Q : std_logic; -- Output of the FF

    component reg_n is
        generic (N : integer := 32);
        port (
            i_CLK : in std_logic; -- Clock input
            i_RST : in std_logic; -- Reset input
            i_WE : in std_logic; -- Write enable input
            i_D : in std_logic_vector(N - 1 downto 0); -- Data vector input
            o_Q : out std_logic_vector(N - 1 downto 0)); -- Data vector output
    end component;

    component reg_sp is
        generic (N : integer := 32);
        port (
            i_CLK : in std_logic; -- Clock input
            i_RST : in std_logic; -- Reset input
            i_WE : in std_logic; -- Write enable input
            i_D : in std_logic_vector(N - 1 downto 0); -- Data vector input
            o_Q : out std_logic_vector(N - 1 downto 0)); -- Data vector output

    end component;

    component decoder_5_32 is
        port (
            i_S : in std_logic_vector(4 downto 0); -- Data vector input
            o_Y : out std_logic_vector(31 downto 0)); -- Data vector output
    end component;

    component mux_32_32 is
        port (
            i_S : in std_logic_vector(4 downto 0); -- select vector input
            i_D : in word_array_t(0 to 31); --Data choice array
            o_Y : out std_logic_vector(31 downto 0)); -- vector output
    end component;

    signal s_write_decoded : std_logic_vector(31 downto 0);
    signal s_write_enable : std_logic_vector(31 downto 0);
    signal s_reg_outputs : word_array_t(0 to 31);

begin

    s_write_enable <= s_write_decoded when (i_read_write = '1') else
        (others => '0');

    write_decoder : decoder_5_32 port map(
        i_S => i_write_reg,
        o_Y => s_write_decoded
    );

    --Zero reg is always 0, so just output to bus
    s_reg_outputs(0) <= (others => '0');

    --SP register is special
    G_SP : reg_sp
    port map(
        i_CLK => i_CLK,
        i_RST => i_RST,
        i_WE => s_write_enable(2),
        i_D => i_write_value,
        o_Q => s_reg_outputs(2)
    );

    G_N_REGS : for i in 1 to 31 generate
        regs : if i /= 2 generate
            REGI : reg_n port map(
                i_CLK => i_CLK,
                i_RST => i_RST,
                i_WE => s_write_enable(i),
                i_D => i_write_value,
                o_Q => s_reg_outputs(i)
            );
        end generate regs;
    end generate G_N_REGS;

    --Both read muxes share the same inputs
    read_mux1 : mux_32_32
    port map(
        i_S => i_read_reg1,
        i_D => s_reg_outputs,
        o_Y => o_read_value1
    );

    read_mux2 : mux_32_32
    port map(
        i_S => i_read_reg2,
        i_D => s_reg_outputs,
        o_Y => o_read_value2
    );
end mixed;