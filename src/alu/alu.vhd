-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an ALU taking 2 32-bit opperands
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alu is
    port(
        i_opperand1 : in std_logic_vector(31 downto 0);
        i_opperand2 : in std_logic_vector(31 downto 0);
        i_ALU_op : in std_logic_vector(3 downto 0);
        o_F   : out std_logic_vector(31 downto 0);
        o_C   : out std_logic;
        o_N   : out std_logic;
        o_V   : out std_logic;
        o_Z   : out std_logic
    );
end alu;

--ALU opcodes:
--x0: ADD
--x1: SUB
--x2: AND
--x3: OR
--x4: XOR
--x5: LSL
--x6: RSL
--x7: RSA 
--x8: SLT
--x9: SLTU

architecture structural of alu is

    component mux8t1_32 is
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
    end component;

    component adder is
        port(
            i_opperand1 : in std_logic_vector(31 downto 0);
            i_opperand2 : in std_logic_vector(31 downto 0);
            i_carry : in std_logic;
            o_result : out std_logic_vector(31 downto 0);
            o_carry_o : out std_logic;
            o_carry_i : out std_logic
        );
    end component;

    component barrel_shifter is
        port(
            i_opperand  : in std_logic_vector(31 downto 0);
            i_shift     : in std_logic_vector(4 downto 0);
            i_left      : in std_logic;
            i_sign_fill : in std_logic;
            o_result    : out std_logic_vector(31 downto 0)
        );
    end component;

    component and32 is
        port(
            i_A : in std_logic_vector(31 downto 0);
            i_B : in std_logic_vector(31 downto 0);
            o_F : out std_logic_vector(31 downto 0)
        );
    end component;

    component or32 is
        port(
            i_A : in std_logic_vector(31 downto 0);
            i_B : in std_logic_vector(31 downto 0);
            o_F : out std_logic_vector(31 downto 0)
        );
    end component;

    component xor32 is
        port(
            i_A : in std_logic_vector(31 downto 0);
            i_B : in std_logic_vector(31 downto 0);
            o_F : out std_logic_vector(31 downto 0)
        );
    end component;

    component nor32t1 is
        port(
            i_A : in std_logic_vector(31 downto 0);
            o_F : out std_logic
        );
    end component;

    component xorg2 is
        port(
            i_A : in std_logic;
            i_B : in std_logic;
            o_F : out std_logic
        );
    end component;

    component alu_decoder is
        port(
            i_ALU_op : in std_logic_vector(3 downto 0);
            o_mux_ctrl : out std_logic_vector(2 downto 0);
            o_barrel_left : out std_logic;
            o_barrel_sign : out std_logic;
            o_adder_cin : out std_logic
        );
    end component;

    signal s_adder_in, s_addsub, s_and, s_or, s_xor, s_shift_res : std_logic_vector(31 downto 0);
    signal s_Cin, s_C_MSB_out, s_C_MSB_in, s_left_shift, s_shift_sign_fill, s_N, s_V, s_slt, s_sltu : std_logic;
    signal s_mux_ctrl : std_logic_vector(2 downto 0);
begin

    g_Alu_Decode: alu_decoder
        port MAP(
            i_ALU_op => i_ALU_op,
            o_mux_ctrl => s_mux_ctrl,
            o_barrel_left => s_left_shift,
            o_barrel_sign => s_shift_sign_fill,
            o_adder_cin => s_Cin
        );


    g_Adder: adder
        port MAP(
            i_opperand1 => i_opperand1,
            i_opperand2 => s_adder_in,
            i_carry => s_Cin,
            o_result => s_addsub,
            o_carry_o => s_C_MSB_out,
            o_carry_i => s_C_MSB_in
        );

    o_C <= s_C_MSB_out;
    o_N <= s_addsub(31);
    s_N <= s_addsub(31);

    g_Inverter: xor32
        port MAP(
            i_A => i_opperand2,
            i_B => (others => s_Cin),
            o_F => s_adder_in
        );

    g_And: and32
        port MAP(
            i_A => i_opperand1,
            i_B => i_opperand2,
            o_F => s_and
        );

    g_Or: or32
        port MAP(
            i_A => i_opperand1,
            i_B => i_opperand2,
            o_F => s_or
        );

    g_Xor: xor32
        port MAP(
            i_A => i_opperand1,
            i_B => i_opperand2,
            o_F => s_xor
        );

    g_Shift: barrel_shifter
        port MAP(
            i_opperand  => i_opperand1,
            i_shift     => i_opperand2(4 downto 0),
            i_left      => s_left_shift,
            i_sign_fill => s_shift_sign_fill,
            o_result    => s_shift_res
        );

     g_Nor: nor32t1
        port MAP(
            i_A => s_addsub,
            o_F => o_Z
        );

    g_Xor_Overflow: xorg2
        port MAP(
            i_A => s_C_MSB_in,
            i_B => s_C_MSB_out,
            o_F => s_V
        );
    o_V <= s_V;

    g_Xor_SLT: xorg2
        port MAP(
            i_A => s_N,
            i_B => s_V,
            o_F => s_slt
        );

    s_sltu <= not s_C_MSB_out;

    g_Mux_Out: mux8t1_32
        port MAP(
            i_D0 => s_addsub,
            i_D1 => s_and,
            i_D2 => s_or,
            i_D3 => s_xor,
            i_D4 => s_shift_res,
            i_D5 => (0 => s_slt, others => '0'),
            i_D6 => (0 => s_sltu, others => '0'),
            i_D7 => x"00000000",
            i_S  => s_mux_ctrl,
            o_F  => o_F
        );

end structural;

    