-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a barrel shifter that can left and right shift 
-- and select sign fill or zero fill right shift
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter is

    port(
        i_opperand  : in std_logic_vector(31 downto 0);
        i_shift     : in std_logic_vector(4 downto 0);
        i_left      : in std_logic;--0 for right shift, 1 for left shift
        i_sign_fill : in std_logic;
        o_result    : out std_logic_vector(31 downto 0)
    );

end barrel_shifter;

architecture structural of barrel_shifter is

    component mux2t1 is
        port(
            i_S  : in std_logic;
            i_D0 : in std_logic;
            i_D1 : in std_logic;
            o_F  : out std_logic
        );
    end component;

    signal s_ext : std_logic;
    signal s_bit_swap, s_16_bit_shift, s_8_bit_shift, s_4_bit_shift, s_2_bit_shift, s_1_bit_shift : std_logic_vector(31 downto 0);

begin

    g_sign_extend: mux2t1
    port map(
        i_S  => i_sign_fill,
        i_D0 => '0',
        i_D1 => i_opperand(31),
        o_F  => s_ext
    );

    G_Bit_Flip_1: for i in 0 to 31 generate
        MUXI: mux2t1 port map(
            i_S  => i_left,
            i_D0 => i_opperand(i),
            i_D1 => i_opperand(31-i),
            o_F  => s_bit_swap(i)
        );
    end generate G_Bit_Flip_1;

    G_16_Bit_Shift_Mux: for i in 0 to 31 generate
        Low_Partition: if i <= 15 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(4),
                i_D0 => s_bit_swap(i),
                i_D1 => s_bit_swap(i+16),
                o_F  => s_16_bit_shift(i)
            );
        end generate Low_Partition;

        High_Partition: if i > 15 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(4),
                i_D0 => s_bit_swap(i),
                i_D1 => s_ext,
                o_F  => s_16_bit_shift(i)
            );
        end generate High_Partition;
    end generate G_16_Bit_Shift_Mux;

    G_8_Bit_Shift_Mux: for i in 0 to 31 generate
        Low_Partition: if i <= 23 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(3),
                i_D0 => s_16_bit_shift(i),
                i_D1 => s_16_bit_shift(i+8),
                o_F  => s_8_bit_shift(i)
            );
        end generate Low_Partition;

        High_Partition: if i > 23 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(3),
                i_D0 => s_16_bit_shift(i),
                i_D1 => s_ext,
                o_F  => s_8_bit_shift(i)
            );
        end generate High_Partition;
    end generate G_8_Bit_Shift_Mux;

    G_4_Bit_Shift_Mux: for i in 0 to 31 generate
        Low_Partition: if i <= 27 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(2),
                i_D0 => s_8_bit_shift(i),
                i_D1 => s_8_bit_shift(i+4),
                o_F  => s_4_bit_shift(i)
            );
        end generate Low_Partition;

        High_Partition: if i > 27 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(2),
                i_D0 => s_8_bit_shift(i),
                i_D1 => s_ext,
                o_F  => s_4_bit_shift(i)
            );
        end generate High_Partition;
    end generate G_4_Bit_Shift_Mux;

    G_2_Bit_Shift_Mux: for i in 0 to 31 generate
        Low_Partition: if i <= 29 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(1),
                i_D0 => s_4_bit_shift(i),
                i_D1 => s_4_bit_shift(i+2),
                o_F  => s_2_bit_shift(i)
            );
        end generate Low_Partition;

        High_Partition: if i > 29 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(1),
                i_D0 => s_4_bit_shift(i),
                i_D1 => s_ext,
                o_F  => s_2_bit_shift(i)
            );
        end generate High_Partition;
    end generate G_2_Bit_Shift_Mux;

    G_1_Bit_Shift_Mux: for i in 0 to 31 generate
        Low_Partition: if i <= 30 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(0),
                i_D0 => s_2_bit_shift(i),
                i_D1 => s_2_bit_shift(i+1),
                o_F  => s_1_bit_shift(i)
            );
        end generate Low_Partition;

        High_Partition: if i > 30 generate
            MUXI: mux2t1 port map(
                i_S => i_shift(0),
                i_D0 => s_2_bit_shift(i),
                i_D1 => s_ext,
                o_F  => s_1_bit_shift(i)
            );
        end generate High_Partition;
    end generate G_1_Bit_Shift_Mux;

    G_Bit_Flip_2: for i in 0 to 31 generate
        MUXI: mux2t1 port map(
            i_S  => i_left,
            i_D0 => s_1_bit_shift(i),
            i_D1 => s_1_bit_shift(31-i),
            o_F  => o_result(i)
        );
    end generate G_Bit_Flip_2;

end structural;