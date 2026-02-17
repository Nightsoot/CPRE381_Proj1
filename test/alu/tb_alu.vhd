-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the ALU
-- 
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_alu is
    generic (gCLK_HPER : time := 50 ns);
end tb_alu;

architecture behavior of tb_alu is

    constant cCLK_PER : time := gCLK_HPER * 2;
    component alu
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

    end component;

    signal s_a, s_b, s_result : std_logic_vector(31 downto 0);
    signal s_ALU_operation : std_logic_vector(3 downto 0);
    signal s_carry_out, s_negative, s_overflow, s_zero : std_logic;
    signal s_case_number : integer;

begin
    DUT : alu
    port map(
        i_opperand1 => s_a,
        i_opperand2 => s_b,
        i_ALU_op    => s_ALU_operation,
        o_F         => s_result,
        o_C         => s_carry_out,
        o_N         => s_negative,
        o_V         => s_overflow,
        o_Z         => s_zero
    );

    p_TB : process
    begin

        s_a <= X"FFFFFFFF";
s_b <= X"00000001";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 0 result failed" severity error;
assert (s_zero = '1') report "Case 0 zero flag failed" severity error;
assert (s_negative = '0') report "Case 0 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 0 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 0 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 0;

s_a <= X"FFFFFFFF";
s_b <= X"00000001";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFE") report "Case 1 result failed" severity error;
assert (s_zero = '0') report "Case 1 zero flag failed" severity error;
assert (s_negative = '1') report "Case 1 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 1 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 1 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1;

s_a <= X"FFFFFFFF";
s_b <= X"00000000";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 2 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 2;

s_a <= X"FFFFFFFF";
s_b <= X"00000000";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFF") report "Case 3 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 3;

s_a <= X"FFFFFFFF";
s_b <= X"FFFFFFFF";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 4 result failed" severity error;
s_case_number <= 4;

s_a <= X"80000000";
s_b <= X"0000001F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 5 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 5;

s_a <= X"80000000";
s_b <= X"0000001F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 6 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 6;

s_a <= X"80000000";
s_b <= X"0000001F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFF") report "Case 7 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 7;

s_a <= X"265461F4";
s_b <= X"9BB425A4";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"C2088798") report "Case 8 result failed" severity error;
assert (s_zero = '0') report "Case 8 zero flag failed" severity error;
assert (s_negative = '1') report "Case 8 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 8 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 8 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 8;

s_a <= X"FF53F17F";
s_b <= X"AB155859";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"AA6949D8") report "Case 9 result failed" severity error;
assert (s_zero = '0') report "Case 9 zero flag failed" severity error;
assert (s_negative = '1') report "Case 9 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 9 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 9 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 9;

s_a <= X"D73D504D";
s_b <= X"5F764853";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"36B398A0") report "Case 10 result failed" severity error;
assert (s_zero = '0') report "Case 10 zero flag failed" severity error;
assert (s_negative = '0') report "Case 10 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 10 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 10 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 10;

s_a <= X"72221040";
s_b <= X"D842A7D2";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"4A64B812") report "Case 11 result failed" severity error;
assert (s_zero = '0') report "Case 11 zero flag failed" severity error;
assert (s_negative = '0') report "Case 11 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 11 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 11 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 11;

s_a <= X"BFA20A8B";
s_b <= X"F9F389E0";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"B995946B") report "Case 12 result failed" severity error;
assert (s_zero = '0') report "Case 12 zero flag failed" severity error;
assert (s_negative = '1') report "Case 12 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 12 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 12 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 12;

s_a <= X"963A361C";
s_b <= X"E6368924";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"7C70BF40") report "Case 13 result failed" severity error;
assert (s_zero = '0') report "Case 13 zero flag failed" severity error;
assert (s_negative = '0') report "Case 13 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 13 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 13 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 13;

s_a <= X"F1F53204";
s_b <= X"CC55AFB2";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"BE4AE1B6") report "Case 14 result failed" severity error;
assert (s_zero = '0') report "Case 14 zero flag failed" severity error;
assert (s_negative = '1') report "Case 14 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 14 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 14 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 14;

s_a <= X"05916BD0";
s_b <= X"1EEFE1D1";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"24814DA1") report "Case 15 result failed" severity error;
assert (s_zero = '0') report "Case 15 zero flag failed" severity error;
assert (s_negative = '0') report "Case 15 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 15 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 15 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 15;

s_a <= X"0591835D";
s_b <= X"451E6C72";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"4AAFEFCF") report "Case 16 result failed" severity error;
assert (s_zero = '0') report "Case 16 zero flag failed" severity error;
assert (s_negative = '0') report "Case 16 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 16 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 16 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 16;

s_a <= X"3A7E9730";
s_b <= X"4A1EE54D";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"849D7C7D") report "Case 17 result failed" severity error;
assert (s_zero = '0') report "Case 17 zero flag failed" severity error;
assert (s_negative = '1') report "Case 17 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 17 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 17 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 17;

s_a <= X"9C3BEE55";
s_b <= X"0331E3B5";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"9F6DD20A") report "Case 18 result failed" severity error;
assert (s_zero = '0') report "Case 18 zero flag failed" severity error;
assert (s_negative = '1') report "Case 18 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 18 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 18 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 18;

s_a <= X"5C065290";
s_b <= X"0D69E06A";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"697032FA") report "Case 19 result failed" severity error;
assert (s_zero = '0') report "Case 19 zero flag failed" severity error;
assert (s_negative = '0') report "Case 19 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 19 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 19 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 19;

s_a <= X"5352EB6C";
s_b <= X"006B2AE0";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"53BE164C") report "Case 20 result failed" severity error;
assert (s_zero = '0') report "Case 20 zero flag failed" severity error;
assert (s_negative = '0') report "Case 20 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 20 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 20 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 20;

s_a <= X"809FFEB0";
s_b <= X"D3012AFA";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"53A129AA") report "Case 21 result failed" severity error;
assert (s_zero = '0') report "Case 21 zero flag failed" severity error;
assert (s_negative = '0') report "Case 21 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 21 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 21 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 21;

s_a <= X"0F35531D";
s_b <= X"F3042F1B";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"02398238") report "Case 22 result failed" severity error;
assert (s_zero = '0') report "Case 22 zero flag failed" severity error;
assert (s_negative = '0') report "Case 22 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 22 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 22 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 22;

s_a <= X"DB796A6A";
s_b <= X"C85F2FE4";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"A3D89A4E") report "Case 23 result failed" severity error;
assert (s_zero = '0') report "Case 23 zero flag failed" severity error;
assert (s_negative = '1') report "Case 23 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 23 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 23 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 23;

s_a <= X"365ED3E6";
s_b <= X"48C8848D";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"7F275873") report "Case 24 result failed" severity error;
assert (s_zero = '0') report "Case 24 zero flag failed" severity error;
assert (s_negative = '0') report "Case 24 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 24 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 24 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 24;

s_a <= X"EE33E73A";
s_b <= X"4EBDAB7A";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"3CF192B4") report "Case 25 result failed" severity error;
assert (s_zero = '0') report "Case 25 zero flag failed" severity error;
assert (s_negative = '0') report "Case 25 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 25 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 25 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 25;

s_a <= X"5E68FA40";
s_b <= X"F1A54689";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"500E40C9") report "Case 26 result failed" severity error;
assert (s_zero = '0') report "Case 26 zero flag failed" severity error;
assert (s_negative = '0') report "Case 26 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 26 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 26 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 26;

s_a <= X"E846F574";
s_b <= X"013223E2";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"E9791956") report "Case 27 result failed" severity error;
assert (s_zero = '0') report "Case 27 zero flag failed" severity error;
assert (s_negative = '1') report "Case 27 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 27 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 27 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 27;

s_a <= X"A51A7BC4";
s_b <= X"7E9AB1C7";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"23B52D8B") report "Case 28 result failed" severity error;
assert (s_zero = '0') report "Case 28 zero flag failed" severity error;
assert (s_negative = '0') report "Case 28 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 28 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 28 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 28;

s_a <= X"2E296FC6";
s_b <= X"72F71FDE";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"A1208FA4") report "Case 29 result failed" severity error;
assert (s_zero = '0') report "Case 29 zero flag failed" severity error;
assert (s_negative = '1') report "Case 29 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 29 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 29 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 29;

s_a <= X"FC25C942";
s_b <= X"5DD37409";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"59F93D4B") report "Case 30 result failed" severity error;
assert (s_zero = '0') report "Case 30 zero flag failed" severity error;
assert (s_negative = '0') report "Case 30 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 30 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 30 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 30;

s_a <= X"5A4CEF79";
s_b <= X"0C3EADE7";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"668B9D60") report "Case 31 result failed" severity error;
assert (s_zero = '0') report "Case 31 zero flag failed" severity error;
assert (s_negative = '0') report "Case 31 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 31 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 31 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 31;

s_a <= X"938FF2D2";
s_b <= X"3D7005B8";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"D0FFF88A") report "Case 32 result failed" severity error;
assert (s_zero = '0') report "Case 32 zero flag failed" severity error;
assert (s_negative = '1') report "Case 32 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 32 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 32 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 32;

s_a <= X"307CC8B9";
s_b <= X"F3620B71";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"23DED42A") report "Case 33 result failed" severity error;
assert (s_zero = '0') report "Case 33 zero flag failed" severity error;
assert (s_negative = '0') report "Case 33 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 33 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 33 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 33;

s_a <= X"619843F9";
s_b <= X"44D29FA7";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"A66AE3A0") report "Case 34 result failed" severity error;
assert (s_zero = '0') report "Case 34 zero flag failed" severity error;
assert (s_negative = '1') report "Case 34 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 34 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 34 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 34;

s_a <= X"96E3570B";
s_b <= X"CAF43E4C";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"61D79557") report "Case 35 result failed" severity error;
assert (s_zero = '0') report "Case 35 zero flag failed" severity error;
assert (s_negative = '0') report "Case 35 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 35 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 35 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 35;

s_a <= X"3F57F478";
s_b <= X"BD8FDDAD";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"FCE7D225") report "Case 36 result failed" severity error;
assert (s_zero = '0') report "Case 36 zero flag failed" severity error;
assert (s_negative = '1') report "Case 36 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 36 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 36 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 36;

s_a <= X"7A5AF777";
s_b <= X"C84EF344";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"42A9EABB") report "Case 37 result failed" severity error;
assert (s_zero = '0') report "Case 37 zero flag failed" severity error;
assert (s_negative = '0') report "Case 37 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 37 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 37 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 37;

s_a <= X"E8F8DA11";
s_b <= X"00925CC9";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"E98B36DA") report "Case 38 result failed" severity error;
assert (s_zero = '0') report "Case 38 zero flag failed" severity error;
assert (s_negative = '1') report "Case 38 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 38 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 38 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 38;

s_a <= X"940BBE5E";
s_b <= X"4B533756";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"DF5EF5B4") report "Case 39 result failed" severity error;
assert (s_zero = '0') report "Case 39 zero flag failed" severity error;
assert (s_negative = '1') report "Case 39 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 39 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 39 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 39;

s_a <= X"5D7B854E";
s_b <= X"F0D9D7C7";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"4E555D15") report "Case 40 result failed" severity error;
assert (s_zero = '0') report "Case 40 zero flag failed" severity error;
assert (s_negative = '0') report "Case 40 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 40 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 40 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 40;

s_a <= X"28BCA213";
s_b <= X"AFE5AE2C";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"D8A2503F") report "Case 41 result failed" severity error;
assert (s_zero = '0') report "Case 41 zero flag failed" severity error;
assert (s_negative = '1') report "Case 41 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 41 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 41 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 41;

s_a <= X"105DE7AA";
s_b <= X"2ACC68F9";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"3B2A50A3") report "Case 42 result failed" severity error;
assert (s_zero = '0') report "Case 42 zero flag failed" severity error;
assert (s_negative = '0') report "Case 42 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 42 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 42 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 42;

s_a <= X"48CB997A";
s_b <= X"CC772EFD";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"1542C877") report "Case 43 result failed" severity error;
assert (s_zero = '0') report "Case 43 zero flag failed" severity error;
assert (s_negative = '0') report "Case 43 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 43 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 43 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 43;

s_a <= X"C9EB9040";
s_b <= X"3FF2DE4B";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"09DE6E8B") report "Case 44 result failed" severity error;
assert (s_zero = '0') report "Case 44 zero flag failed" severity error;
assert (s_negative = '0') report "Case 44 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 44 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 44 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 44;

s_a <= X"DE62754C";
s_b <= X"87EAA83D";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"664D1D89") report "Case 45 result failed" severity error;
assert (s_zero = '0') report "Case 45 zero flag failed" severity error;
assert (s_negative = '0') report "Case 45 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 45 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 45 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 45;

s_a <= X"266C5C2C";
s_b <= X"12FD8DB7";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"3969E9E3") report "Case 46 result failed" severity error;
assert (s_zero = '0') report "Case 46 zero flag failed" severity error;
assert (s_negative = '0') report "Case 46 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 46 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 46 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 46;

s_a <= X"96457B65";
s_b <= X"EC004A95";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"8245C5FA") report "Case 47 result failed" severity error;
assert (s_zero = '0') report "Case 47 zero flag failed" severity error;
assert (s_negative = '1') report "Case 47 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 47 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 47 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 47;

s_a <= X"387B85E6";
s_b <= X"D880BE35";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"10FC441B") report "Case 48 result failed" severity error;
assert (s_zero = '0') report "Case 48 zero flag failed" severity error;
assert (s_negative = '0') report "Case 48 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 48 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 48 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 48;

s_a <= X"BA2B4E0B";
s_b <= X"56014A78";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"102C9883") report "Case 49 result failed" severity error;
assert (s_zero = '0') report "Case 49 zero flag failed" severity error;
assert (s_negative = '0') report "Case 49 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 49 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 49 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 49;

s_a <= X"D8C2D1EB";
s_b <= X"BC96E161";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"9559B34C") report "Case 50 result failed" severity error;
assert (s_zero = '0') report "Case 50 zero flag failed" severity error;
assert (s_negative = '1') report "Case 50 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 50 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 50 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 50;

s_a <= X"C646E05D";
s_b <= X"AA7451D3";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"70BB3230") report "Case 51 result failed" severity error;
assert (s_zero = '0') report "Case 51 zero flag failed" severity error;
assert (s_negative = '0') report "Case 51 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 51 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 51 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 51;

s_a <= X"E51B871D";
s_b <= X"41CD3C44";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"26E8C361") report "Case 52 result failed" severity error;
assert (s_zero = '0') report "Case 52 zero flag failed" severity error;
assert (s_negative = '0') report "Case 52 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 52 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 52 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 52;

s_a <= X"A4EB60AA";
s_b <= X"4190AAB2";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"E67C0B5C") report "Case 53 result failed" severity error;
assert (s_zero = '0') report "Case 53 zero flag failed" severity error;
assert (s_negative = '1') report "Case 53 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 53 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 53 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 53;

s_a <= X"3CDB369F";
s_b <= X"256E1A86";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"62495125") report "Case 54 result failed" severity error;
assert (s_zero = '0') report "Case 54 zero flag failed" severity error;
assert (s_negative = '0') report "Case 54 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 54 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 54 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 54;

s_a <= X"F676D818";
s_b <= X"6B6B64CD";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"61E23CE5") report "Case 55 result failed" severity error;
assert (s_zero = '0') report "Case 55 zero flag failed" severity error;
assert (s_negative = '0') report "Case 55 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 55 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 55 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 55;

s_a <= X"7A579289";
s_b <= X"AAE91F03";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"2540B18C") report "Case 56 result failed" severity error;
assert (s_zero = '0') report "Case 56 zero flag failed" severity error;
assert (s_negative = '0') report "Case 56 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 56 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 56 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 56;

s_a <= X"3DAF0468";
s_b <= X"0453257B";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"420229E3") report "Case 57 result failed" severity error;
assert (s_zero = '0') report "Case 57 zero flag failed" severity error;
assert (s_negative = '0') report "Case 57 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 57 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 57 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 57;

s_a <= X"C93BA6B2";
s_b <= X"4AC00A6A";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"13FBB11C") report "Case 58 result failed" severity error;
assert (s_zero = '0') report "Case 58 zero flag failed" severity error;
assert (s_negative = '0') report "Case 58 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 58 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 58 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 58;

s_a <= X"F664BB0C";
s_b <= X"D70A4CDC";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"CD6F07E8") report "Case 59 result failed" severity error;
assert (s_zero = '0') report "Case 59 zero flag failed" severity error;
assert (s_negative = '1') report "Case 59 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 59 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 59 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 59;

s_a <= X"210041CA";
s_b <= X"81C5AA4A";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"A2C5EC14") report "Case 60 result failed" severity error;
assert (s_zero = '0') report "Case 60 zero flag failed" severity error;
assert (s_negative = '1') report "Case 60 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 60 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 60 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 60;

s_a <= X"FDB3F744";
s_b <= X"6A7CBAEA";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"6830B22E") report "Case 61 result failed" severity error;
assert (s_zero = '0') report "Case 61 zero flag failed" severity error;
assert (s_negative = '0') report "Case 61 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 61 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 61 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 61;

s_a <= X"945101A5";
s_b <= X"7C8C8B83";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"10DD8D28") report "Case 62 result failed" severity error;
assert (s_zero = '0') report "Case 62 zero flag failed" severity error;
assert (s_negative = '0') report "Case 62 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 62 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 62 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 62;

s_a <= X"6E8188EA";
s_b <= X"A585C4A5";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"14074D8F") report "Case 63 result failed" severity error;
assert (s_zero = '0') report "Case 63 zero flag failed" severity error;
assert (s_negative = '0') report "Case 63 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 63 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 63 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 63;

s_a <= X"D0F4DE13";
s_b <= X"99D91096";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"6ACDEEA9") report "Case 64 result failed" severity error;
assert (s_zero = '0') report "Case 64 zero flag failed" severity error;
assert (s_negative = '0') report "Case 64 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 64 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 64 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 64;

s_a <= X"FBDF3613";
s_b <= X"1EC43620";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"1AA36C33") report "Case 65 result failed" severity error;
assert (s_zero = '0') report "Case 65 zero flag failed" severity error;
assert (s_negative = '0') report "Case 65 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 65 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 65 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 65;

s_a <= X"09C866CA";
s_b <= X"C5B6E8D9";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"CF7F4FA3") report "Case 66 result failed" severity error;
assert (s_zero = '0') report "Case 66 zero flag failed" severity error;
assert (s_negative = '1') report "Case 66 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 66 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 66 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 66;

s_a <= X"5277E385";
s_b <= X"4A12C53B";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"9C8AA8C0") report "Case 67 result failed" severity error;
assert (s_zero = '0') report "Case 67 zero flag failed" severity error;
assert (s_negative = '1') report "Case 67 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 67 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 67 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 67;

s_a <= X"E17A82D8";
s_b <= X"DE5E3404";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"BFD8B6DC") report "Case 68 result failed" severity error;
assert (s_zero = '0') report "Case 68 zero flag failed" severity error;
assert (s_negative = '1') report "Case 68 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 68 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 68 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 68;

s_a <= X"2C877EDE";
s_b <= X"66B25654";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"9339D532") report "Case 69 result failed" severity error;
assert (s_zero = '0') report "Case 69 zero flag failed" severity error;
assert (s_negative = '1') report "Case 69 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 69 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 69 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 69;

s_a <= X"6E9C50B4";
s_b <= X"F331D17D";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"61CE2231") report "Case 70 result failed" severity error;
assert (s_zero = '0') report "Case 70 zero flag failed" severity error;
assert (s_negative = '0') report "Case 70 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 70 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 70 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 70;

s_a <= X"9EA78457";
s_b <= X"E6749696";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"851C1AED") report "Case 71 result failed" severity error;
assert (s_zero = '0') report "Case 71 zero flag failed" severity error;
assert (s_negative = '1') report "Case 71 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 71 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 71 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 71;

s_a <= X"F147D737";
s_b <= X"10001794";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"0147EECB") report "Case 72 result failed" severity error;
assert (s_zero = '0') report "Case 72 zero flag failed" severity error;
assert (s_negative = '0') report "Case 72 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 72 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 72 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 72;

s_a <= X"C86CB558";
s_b <= X"5A23C840";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"22907D98") report "Case 73 result failed" severity error;
assert (s_zero = '0') report "Case 73 zero flag failed" severity error;
assert (s_negative = '0') report "Case 73 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 73 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 73 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 73;

s_a <= X"1389C422";
s_b <= X"79AB7FAE";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"8D3543D0") report "Case 74 result failed" severity error;
assert (s_zero = '0') report "Case 74 zero flag failed" severity error;
assert (s_negative = '1') report "Case 74 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 74 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 74 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 74;

s_a <= X"E7D3898C";
s_b <= X"489AF9AF";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"306E833B") report "Case 75 result failed" severity error;
assert (s_zero = '0') report "Case 75 zero flag failed" severity error;
assert (s_negative = '0') report "Case 75 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 75 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 75 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 75;

s_a <= X"93A22342";
s_b <= X"3084CD07";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"C426F049") report "Case 76 result failed" severity error;
assert (s_zero = '0') report "Case 76 zero flag failed" severity error;
assert (s_negative = '1') report "Case 76 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 76 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 76 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 76;

s_a <= X"4BE02E58";
s_b <= X"712FC4AE";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"BD0FF306") report "Case 77 result failed" severity error;
assert (s_zero = '0') report "Case 77 zero flag failed" severity error;
assert (s_negative = '1') report "Case 77 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 77 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 77 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 77;

s_a <= X"AB925996";
s_b <= X"6416EA3D";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"0FA943D3") report "Case 78 result failed" severity error;
assert (s_zero = '0') report "Case 78 zero flag failed" severity error;
assert (s_negative = '0') report "Case 78 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 78 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 78 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 78;

s_a <= X"736E4770";
s_b <= X"78A87A6F";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"EC16C1DF") report "Case 79 result failed" severity error;
assert (s_zero = '0') report "Case 79 zero flag failed" severity error;
assert (s_negative = '1') report "Case 79 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 79 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 79 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 79;

s_a <= X"47CC90FD";
s_b <= X"2FF12AA5";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"77BDBBA2") report "Case 80 result failed" severity error;
assert (s_zero = '0') report "Case 80 zero flag failed" severity error;
assert (s_negative = '0') report "Case 80 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 80 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 80 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 80;

s_a <= X"3CAE671F";
s_b <= X"653FB76A";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"A1EE1E89") report "Case 81 result failed" severity error;
assert (s_zero = '0') report "Case 81 zero flag failed" severity error;
assert (s_negative = '1') report "Case 81 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 81 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 81 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 81;

s_a <= X"98A2FEB0";
s_b <= X"9C1B3C71";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"34BE3B21") report "Case 82 result failed" severity error;
assert (s_zero = '0') report "Case 82 zero flag failed" severity error;
assert (s_negative = '0') report "Case 82 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 82 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 82 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 82;

s_a <= X"7C7EB9BC";
s_b <= X"F71D50B9";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"739C0A75") report "Case 83 result failed" severity error;
assert (s_zero = '0') report "Case 83 zero flag failed" severity error;
assert (s_negative = '0') report "Case 83 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 83 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 83 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 83;

s_a <= X"2A2FDDDD";
s_b <= X"62B90B78";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"8CE8E955") report "Case 84 result failed" severity error;
assert (s_zero = '0') report "Case 84 zero flag failed" severity error;
assert (s_negative = '1') report "Case 84 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 84 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 84 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 84;

s_a <= X"4B0D88CF";
s_b <= X"4386B5F5";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"8E943EC4") report "Case 85 result failed" severity error;
assert (s_zero = '0') report "Case 85 zero flag failed" severity error;
assert (s_negative = '1') report "Case 85 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 85 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 85 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 85;

s_a <= X"E0D61EC1";
s_b <= X"F112F983";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"D1E91844") report "Case 86 result failed" severity error;
assert (s_zero = '0') report "Case 86 zero flag failed" severity error;
assert (s_negative = '1') report "Case 86 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 86 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 86 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 86;

s_a <= X"BB55728E";
s_b <= X"0526E39B";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"C07C5629") report "Case 87 result failed" severity error;
assert (s_zero = '0') report "Case 87 zero flag failed" severity error;
assert (s_negative = '1') report "Case 87 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 87 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 87 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 87;

s_a <= X"07F0FD84";
s_b <= X"1AA8A3EB";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"2299A16F") report "Case 88 result failed" severity error;
assert (s_zero = '0') report "Case 88 zero flag failed" severity error;
assert (s_negative = '0') report "Case 88 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 88 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 88 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 88;

s_a <= X"BB96A36A";
s_b <= X"286E6DBE";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"E4051128") report "Case 89 result failed" severity error;
assert (s_zero = '0') report "Case 89 zero flag failed" severity error;
assert (s_negative = '1') report "Case 89 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 89 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 89 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 89;

s_a <= X"8318BCD8";
s_b <= X"E171E59C";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"648AA274") report "Case 90 result failed" severity error;
assert (s_zero = '0') report "Case 90 zero flag failed" severity error;
assert (s_negative = '0') report "Case 90 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 90 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 90 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 90;

s_a <= X"83B33F96";
s_b <= X"A2CBA5D3";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"267EE569") report "Case 91 result failed" severity error;
assert (s_zero = '0') report "Case 91 zero flag failed" severity error;
assert (s_negative = '0') report "Case 91 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 91 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 91 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 91;

s_a <= X"E241984B";
s_b <= X"C065E048";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"A2A77893") report "Case 92 result failed" severity error;
assert (s_zero = '0') report "Case 92 zero flag failed" severity error;
assert (s_negative = '1') report "Case 92 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 92 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 92 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 92;

s_a <= X"C1FE9BF0";
s_b <= X"E8BFF5EC";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"AABE91DC") report "Case 93 result failed" severity error;
assert (s_zero = '0') report "Case 93 zero flag failed" severity error;
assert (s_negative = '1') report "Case 93 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 93 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 93 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 93;

s_a <= X"44108BA5";
s_b <= X"3693B7B3";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"7AA44358") report "Case 94 result failed" severity error;
assert (s_zero = '0') report "Case 94 zero flag failed" severity error;
assert (s_negative = '0') report "Case 94 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 94 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 94 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 94;

s_a <= X"19324617";
s_b <= X"2A4827A7";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"437A6DBE") report "Case 95 result failed" severity error;
assert (s_zero = '0') report "Case 95 zero flag failed" severity error;
assert (s_negative = '0') report "Case 95 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 95 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 95 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 95;

s_a <= X"4B6BD0B7";
s_b <= X"FE986BDA";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"4A043C91") report "Case 96 result failed" severity error;
assert (s_zero = '0') report "Case 96 zero flag failed" severity error;
assert (s_negative = '0') report "Case 96 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 96 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 96 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 96;

s_a <= X"9FDDFC1B";
s_b <= X"768DECA9";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"166BE8C4") report "Case 97 result failed" severity error;
assert (s_zero = '0') report "Case 97 zero flag failed" severity error;
assert (s_negative = '0') report "Case 97 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 97 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 97 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 97;

s_a <= X"90CE558B";
s_b <= X"36E12178";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"C7AF7703") report "Case 98 result failed" severity error;
assert (s_zero = '0') report "Case 98 zero flag failed" severity error;
assert (s_negative = '1') report "Case 98 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 98 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 98 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 98;

s_a <= X"CB812A14";
s_b <= X"37933A6F";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"03146483") report "Case 99 result failed" severity error;
assert (s_zero = '0') report "Case 99 zero flag failed" severity error;
assert (s_negative = '0') report "Case 99 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 99 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 99 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 99;

s_a <= X"958F4484";
s_b <= X"8F657532";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"24F4B9B6") report "Case 100 result failed" severity error;
assert (s_zero = '0') report "Case 100 zero flag failed" severity error;
assert (s_negative = '0') report "Case 100 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 100 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 100 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 100;

s_a <= X"714CCA59";
s_b <= X"E8CC5B36";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"5A19258F") report "Case 101 result failed" severity error;
assert (s_zero = '0') report "Case 101 zero flag failed" severity error;
assert (s_negative = '0') report "Case 101 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 101 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 101 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 101;

s_a <= X"A6EB4E0F";
s_b <= X"80876BB4";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"2772B9C3") report "Case 102 result failed" severity error;
assert (s_zero = '0') report "Case 102 zero flag failed" severity error;
assert (s_negative = '0') report "Case 102 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 102 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 102 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 102;

s_a <= X"120DAB3A";
s_b <= X"B1667CB9";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"C37427F3") report "Case 103 result failed" severity error;
assert (s_zero = '0') report "Case 103 zero flag failed" severity error;
assert (s_negative = '1') report "Case 103 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 103 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 103 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 103;

s_a <= X"2BAD2F0D";
s_b <= X"1472D1A2";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"402000AF") report "Case 104 result failed" severity error;
assert (s_zero = '0') report "Case 104 zero flag failed" severity error;
assert (s_negative = '0') report "Case 104 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 104 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 104 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 104;

s_a <= X"9DE94109";
s_b <= X"934B01FD";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"31344306") report "Case 105 result failed" severity error;
assert (s_zero = '0') report "Case 105 zero flag failed" severity error;
assert (s_negative = '0') report "Case 105 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 105 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 105 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 105;

s_a <= X"E26D3FE4";
s_b <= X"4CD53AC9";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"2F427AAD") report "Case 106 result failed" severity error;
assert (s_zero = '0') report "Case 106 zero flag failed" severity error;
assert (s_negative = '0') report "Case 106 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 106 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 106 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 106;

s_a <= X"0F0BBD3D";
s_b <= X"B2273F6E";
s_ALU_operation <= X"0";
wait for cCLK_PER/2;
assert (s_result = X"C132FCAB") report "Case 107 result failed" severity error;
assert (s_zero = '0') report "Case 107 zero flag failed" severity error;
assert (s_negative = '1') report "Case 107 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 107 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 107 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 107;

s_a <= X"6A98EC44";
s_b <= X"C49E6BD5";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"A5FA806F") report "Case 108 result failed" severity error;
assert (s_zero = '0') report "Case 108 zero flag failed" severity error;
assert (s_negative = '1') report "Case 108 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 108 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 108 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 108;

s_a <= X"D7ECC238";
s_b <= X"E7E3499C";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"F009789C") report "Case 109 result failed" severity error;
assert (s_zero = '0') report "Case 109 zero flag failed" severity error;
assert (s_negative = '1') report "Case 109 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 109 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 109 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 109;

s_a <= X"709F4319";
s_b <= X"74C86C4E";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"FBD6D6CB") report "Case 110 result failed" severity error;
assert (s_zero = '0') report "Case 110 zero flag failed" severity error;
assert (s_negative = '1') report "Case 110 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 110 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 110 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 110;

s_a <= X"D52C9749";
s_b <= X"420FD608";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"931CC141") report "Case 111 result failed" severity error;
assert (s_zero = '0') report "Case 111 zero flag failed" severity error;
assert (s_negative = '1') report "Case 111 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 111 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 111 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 111;

s_a <= X"0271D9AA";
s_b <= X"5E6AAA60";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"A4072F4A") report "Case 112 result failed" severity error;
assert (s_zero = '0') report "Case 112 zero flag failed" severity error;
assert (s_negative = '1') report "Case 112 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 112 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 112 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 112;

s_a <= X"8FA36970";
s_b <= X"6C552C30";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"234E3D40") report "Case 113 result failed" severity error;
assert (s_zero = '0') report "Case 113 zero flag failed" severity error;
assert (s_negative = '0') report "Case 113 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 113 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 113 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 113;

s_a <= X"FE2ECB1B";
s_b <= X"5ED30AB2";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"9F5BC069") report "Case 114 result failed" severity error;
assert (s_zero = '0') report "Case 114 zero flag failed" severity error;
assert (s_negative = '1') report "Case 114 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 114 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 114 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 114;

s_a <= X"F658954E";
s_b <= X"73CD9FF1";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"828AF55D") report "Case 115 result failed" severity error;
assert (s_zero = '0') report "Case 115 zero flag failed" severity error;
assert (s_negative = '1') report "Case 115 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 115 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 115 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 115;

s_a <= X"A7AFDAFB";
s_b <= X"9F5D0C02";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"0852CEF9") report "Case 116 result failed" severity error;
assert (s_zero = '0') report "Case 116 zero flag failed" severity error;
assert (s_negative = '0') report "Case 116 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 116 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 116 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 116;

s_a <= X"A22FB65F";
s_b <= X"3C52DE10";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"65DCD84F") report "Case 117 result failed" severity error;
assert (s_zero = '0') report "Case 117 zero flag failed" severity error;
assert (s_negative = '0') report "Case 117 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 117 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 117 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 117;

s_a <= X"42DE53F8";
s_b <= X"9DE2A8B1";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"A4FBAB47") report "Case 118 result failed" severity error;
assert (s_zero = '0') report "Case 118 zero flag failed" severity error;
assert (s_negative = '1') report "Case 118 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 118 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 118 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 118;

s_a <= X"8E9D51BD";
s_b <= X"3094D699";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"5E087B24") report "Case 119 result failed" severity error;
assert (s_zero = '0') report "Case 119 zero flag failed" severity error;
assert (s_negative = '0') report "Case 119 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 119 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 119 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 119;

s_a <= X"08641846";
s_b <= X"FBEDEC6E";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"0C762BD8") report "Case 120 result failed" severity error;
assert (s_zero = '0') report "Case 120 zero flag failed" severity error;
assert (s_negative = '0') report "Case 120 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 120 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 120 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 120;

s_a <= X"E463A688";
s_b <= X"F103A451";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"F3600237") report "Case 121 result failed" severity error;
assert (s_zero = '0') report "Case 121 zero flag failed" severity error;
assert (s_negative = '1') report "Case 121 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 121 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 121 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 121;

s_a <= X"73086F08";
s_b <= X"4AAC0168";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"285C6DA0") report "Case 122 result failed" severity error;
assert (s_zero = '0') report "Case 122 zero flag failed" severity error;
assert (s_negative = '0') report "Case 122 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 122 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 122 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 122;

s_a <= X"FDF4754C";
s_b <= X"43F1BA25";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"BA02BB27") report "Case 123 result failed" severity error;
assert (s_zero = '0') report "Case 123 zero flag failed" severity error;
assert (s_negative = '1') report "Case 123 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 123 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 123 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 123;

s_a <= X"D86A4ADE";
s_b <= X"EE4859BC";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"EA21F122") report "Case 124 result failed" severity error;
assert (s_zero = '0') report "Case 124 zero flag failed" severity error;
assert (s_negative = '1') report "Case 124 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 124 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 124 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 124;

s_a <= X"0C2BAC6A";
s_b <= X"F5609008";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"16CB1C62") report "Case 125 result failed" severity error;
assert (s_zero = '0') report "Case 125 zero flag failed" severity error;
assert (s_negative = '0') report "Case 125 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 125 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 125 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 125;

s_a <= X"80305432";
s_b <= X"F60EBAD6";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"8A21995C") report "Case 126 result failed" severity error;
assert (s_zero = '0') report "Case 126 zero flag failed" severity error;
assert (s_negative = '1') report "Case 126 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 126 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 126 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 126;

s_a <= X"882AC907";
s_b <= X"D7B6E866";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"B073E0A1") report "Case 127 result failed" severity error;
assert (s_zero = '0') report "Case 127 zero flag failed" severity error;
assert (s_negative = '1') report "Case 127 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 127 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 127 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 127;

s_a <= X"634DE9EF";
s_b <= X"EC45EE72";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"7707FB7D") report "Case 128 result failed" severity error;
assert (s_zero = '0') report "Case 128 zero flag failed" severity error;
assert (s_negative = '0') report "Case 128 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 128 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 128 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 128;

s_a <= X"6F0A0865";
s_b <= X"B4272629";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"BAE2E23C") report "Case 129 result failed" severity error;
assert (s_zero = '0') report "Case 129 zero flag failed" severity error;
assert (s_negative = '1') report "Case 129 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 129 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 129 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 129;

s_a <= X"5ACE5BB1";
s_b <= X"BCEE1C3D";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"9DE03F74") report "Case 130 result failed" severity error;
assert (s_zero = '0') report "Case 130 zero flag failed" severity error;
assert (s_negative = '1') report "Case 130 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 130 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 130 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 130;

s_a <= X"67AA0CB8";
s_b <= X"845E7F4D";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"E34B8D6B") report "Case 131 result failed" severity error;
assert (s_zero = '0') report "Case 131 zero flag failed" severity error;
assert (s_negative = '1') report "Case 131 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 131 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 131 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 131;

s_a <= X"907FADBE";
s_b <= X"F839DAA1";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"9845D31D") report "Case 132 result failed" severity error;
assert (s_zero = '0') report "Case 132 zero flag failed" severity error;
assert (s_negative = '1') report "Case 132 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 132 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 132 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 132;

s_a <= X"BEBA7DE0";
s_b <= X"861A5403";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"38A029DD") report "Case 133 result failed" severity error;
assert (s_zero = '0') report "Case 133 zero flag failed" severity error;
assert (s_negative = '0') report "Case 133 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 133 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 133 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 133;

s_a <= X"1A0D7D9E";
s_b <= X"F20A12D6";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"28036AC8") report "Case 134 result failed" severity error;
assert (s_zero = '0') report "Case 134 zero flag failed" severity error;
assert (s_negative = '0') report "Case 134 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 134 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 134 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 134;

s_a <= X"29CFB42F";
s_b <= X"16DF4B85";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"12F068AA") report "Case 135 result failed" severity error;
assert (s_zero = '0') report "Case 135 zero flag failed" severity error;
assert (s_negative = '0') report "Case 135 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 135 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 135 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 135;

s_a <= X"9F4B55DF";
s_b <= X"D0F57691";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"CE55DF4E") report "Case 136 result failed" severity error;
assert (s_zero = '0') report "Case 136 zero flag failed" severity error;
assert (s_negative = '1') report "Case 136 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 136 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 136 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 136;

s_a <= X"6D0856E9";
s_b <= X"B6A4B8C6";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"B6639E23") report "Case 137 result failed" severity error;
assert (s_zero = '0') report "Case 137 zero flag failed" severity error;
assert (s_negative = '1') report "Case 137 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 137 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 137 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 137;

s_a <= X"AF507127";
s_b <= X"90C835CE";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"1E883B59") report "Case 138 result failed" severity error;
assert (s_zero = '0') report "Case 138 zero flag failed" severity error;
assert (s_negative = '0') report "Case 138 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 138 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 138 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 138;

s_a <= X"CA178B97";
s_b <= X"CDB04007";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"FC674B90") report "Case 139 result failed" severity error;
assert (s_zero = '0') report "Case 139 zero flag failed" severity error;
assert (s_negative = '1') report "Case 139 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 139 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 139 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 139;

s_a <= X"4E8F8749";
s_b <= X"994AB784";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"B544CFC5") report "Case 140 result failed" severity error;
assert (s_zero = '0') report "Case 140 zero flag failed" severity error;
assert (s_negative = '1') report "Case 140 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 140 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 140 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 140;

s_a <= X"6F4B6409";
s_b <= X"5DA8B2D7";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"11A2B132") report "Case 141 result failed" severity error;
assert (s_zero = '0') report "Case 141 zero flag failed" severity error;
assert (s_negative = '0') report "Case 141 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 141 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 141 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 141;

s_a <= X"2A5D2F00";
s_b <= X"9AE5BE7F";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"8F777081") report "Case 142 result failed" severity error;
assert (s_zero = '0') report "Case 142 zero flag failed" severity error;
assert (s_negative = '1') report "Case 142 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 142 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 142 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 142;

s_a <= X"52E8652C";
s_b <= X"5FCC3ED2";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"F31C265A") report "Case 143 result failed" severity error;
assert (s_zero = '0') report "Case 143 zero flag failed" severity error;
assert (s_negative = '1') report "Case 143 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 143 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 143 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 143;

s_a <= X"B6024DDC";
s_b <= X"BA4F0A71";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"FBB3436B") report "Case 144 result failed" severity error;
assert (s_zero = '0') report "Case 144 zero flag failed" severity error;
assert (s_negative = '1') report "Case 144 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 144 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 144 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 144;

s_a <= X"130F40C7";
s_b <= X"0D9EA3F9";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"05709CCE") report "Case 145 result failed" severity error;
assert (s_zero = '0') report "Case 145 zero flag failed" severity error;
assert (s_negative = '0') report "Case 145 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 145 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 145 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 145;

s_a <= X"0902CCA4";
s_b <= X"80DC22D5";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"8826A9CF") report "Case 146 result failed" severity error;
assert (s_zero = '0') report "Case 146 zero flag failed" severity error;
assert (s_negative = '1') report "Case 146 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 146 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 146 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 146;

s_a <= X"E4F5BC78";
s_b <= X"116EE550";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"D386D728") report "Case 147 result failed" severity error;
assert (s_zero = '0') report "Case 147 zero flag failed" severity error;
assert (s_negative = '1') report "Case 147 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 147 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 147 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 147;

s_a <= X"19460F72";
s_b <= X"5D20B1CD";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"BC255DA5") report "Case 148 result failed" severity error;
assert (s_zero = '0') report "Case 148 zero flag failed" severity error;
assert (s_negative = '1') report "Case 148 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 148 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 148 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 148;

s_a <= X"98573B46";
s_b <= X"8B9CA9C1";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"0CBA9185") report "Case 149 result failed" severity error;
assert (s_zero = '0') report "Case 149 zero flag failed" severity error;
assert (s_negative = '0') report "Case 149 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 149 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 149 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 149;

s_a <= X"B84938ED";
s_b <= X"5FB49D4C";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"58949BA1") report "Case 150 result failed" severity error;
assert (s_zero = '0') report "Case 150 zero flag failed" severity error;
assert (s_negative = '0') report "Case 150 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 150 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 150 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 150;

s_a <= X"041DBC62";
s_b <= X"1393EE4C";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"F089CE16") report "Case 151 result failed" severity error;
assert (s_zero = '0') report "Case 151 zero flag failed" severity error;
assert (s_negative = '1') report "Case 151 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 151 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 151 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 151;

s_a <= X"08FBD7C7";
s_b <= X"AF937873";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"59685F54") report "Case 152 result failed" severity error;
assert (s_zero = '0') report "Case 152 zero flag failed" severity error;
assert (s_negative = '0') report "Case 152 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 152 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 152 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 152;

s_a <= X"72E87123";
s_b <= X"829F8F44";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"F048E1DF") report "Case 153 result failed" severity error;
assert (s_zero = '0') report "Case 153 zero flag failed" severity error;
assert (s_negative = '1') report "Case 153 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 153 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 153 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 153;

s_a <= X"2EBFCB42";
s_b <= X"D8C2AA57";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"55FD20EB") report "Case 154 result failed" severity error;
assert (s_zero = '0') report "Case 154 zero flag failed" severity error;
assert (s_negative = '0') report "Case 154 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 154 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 154 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 154;

s_a <= X"FBF7876B";
s_b <= X"A6C53A03";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"55324D68") report "Case 155 result failed" severity error;
assert (s_zero = '0') report "Case 155 zero flag failed" severity error;
assert (s_negative = '0') report "Case 155 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 155 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 155 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 155;

s_a <= X"635F796E";
s_b <= X"71258AE0";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"F239EE8E") report "Case 156 result failed" severity error;
assert (s_zero = '0') report "Case 156 zero flag failed" severity error;
assert (s_negative = '1') report "Case 156 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 156 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 156 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 156;

s_a <= X"6D1CCDFE";
s_b <= X"D604E53B";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"9717E8C3") report "Case 157 result failed" severity error;
assert (s_zero = '0') report "Case 157 zero flag failed" severity error;
assert (s_negative = '1') report "Case 157 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 157 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 157 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 157;

s_a <= X"EB7E2B40";
s_b <= X"3304331D";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"B879F823") report "Case 158 result failed" severity error;
assert (s_zero = '0') report "Case 158 zero flag failed" severity error;
assert (s_negative = '1') report "Case 158 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 158 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 158 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 158;

s_a <= X"D137F902";
s_b <= X"F0DD56BF";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"E05AA243") report "Case 159 result failed" severity error;
assert (s_zero = '0') report "Case 159 zero flag failed" severity error;
assert (s_negative = '1') report "Case 159 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 159 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 159 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 159;

s_a <= X"41DD5A07";
s_b <= X"B1C8A070";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"9014B997") report "Case 160 result failed" severity error;
assert (s_zero = '0') report "Case 160 zero flag failed" severity error;
assert (s_negative = '1') report "Case 160 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 160 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 160 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 160;

s_a <= X"7D30599F";
s_b <= X"541972C2";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"2916E6DD") report "Case 161 result failed" severity error;
assert (s_zero = '0') report "Case 161 zero flag failed" severity error;
assert (s_negative = '0') report "Case 161 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 161 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 161 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 161;

s_a <= X"06E20998";
s_b <= X"07E0321A";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"FF01D77E") report "Case 162 result failed" severity error;
assert (s_zero = '0') report "Case 162 zero flag failed" severity error;
assert (s_negative = '1') report "Case 162 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 162 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 162 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 162;

s_a <= X"62E993C2";
s_b <= X"0A5B6D85";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"588E263D") report "Case 163 result failed" severity error;
assert (s_zero = '0') report "Case 163 zero flag failed" severity error;
assert (s_negative = '0') report "Case 163 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 163 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 163 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 163;

s_a <= X"132ACC50";
s_b <= X"12D0CAA3";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"005A01AD") report "Case 164 result failed" severity error;
assert (s_zero = '0') report "Case 164 zero flag failed" severity error;
assert (s_negative = '0') report "Case 164 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 164 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 164 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 164;

s_a <= X"5AB37356";
s_b <= X"7C391F4B";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"DE7A540B") report "Case 165 result failed" severity error;
assert (s_zero = '0') report "Case 165 zero flag failed" severity error;
assert (s_negative = '1') report "Case 165 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 165 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 165 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 165;

s_a <= X"5A34F16C";
s_b <= X"FD3A2FBE";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"5CFAC1AE") report "Case 166 result failed" severity error;
assert (s_zero = '0') report "Case 166 zero flag failed" severity error;
assert (s_negative = '0') report "Case 166 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 166 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 166 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 166;

s_a <= X"78A3DA57";
s_b <= X"61D99EA6";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"16CA3BB1") report "Case 167 result failed" severity error;
assert (s_zero = '0') report "Case 167 zero flag failed" severity error;
assert (s_negative = '0') report "Case 167 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 167 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 167 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 167;

s_a <= X"678B8F15";
s_b <= X"331D6F45";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"346E1FD0") report "Case 168 result failed" severity error;
assert (s_zero = '0') report "Case 168 zero flag failed" severity error;
assert (s_negative = '0') report "Case 168 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 168 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 168 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 168;

s_a <= X"1FA09724";
s_b <= X"EDE4270D";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"31BC7017") report "Case 169 result failed" severity error;
assert (s_zero = '0') report "Case 169 zero flag failed" severity error;
assert (s_negative = '0') report "Case 169 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 169 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 169 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 169;

s_a <= X"0E04FA1E";
s_b <= X"D5BDF9EB";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"38470033") report "Case 170 result failed" severity error;
assert (s_zero = '0') report "Case 170 zero flag failed" severity error;
assert (s_negative = '0') report "Case 170 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 170 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 170 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 170;

s_a <= X"3EEB38A6";
s_b <= X"48B0A169";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"F63A973D") report "Case 171 result failed" severity error;
assert (s_zero = '0') report "Case 171 zero flag failed" severity error;
assert (s_negative = '1') report "Case 171 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 171 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 171 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 171;

s_a <= X"9E839F68";
s_b <= X"8A35494F";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"144E5619") report "Case 172 result failed" severity error;
assert (s_zero = '0') report "Case 172 zero flag failed" severity error;
assert (s_negative = '0') report "Case 172 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 172 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 172 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 172;

s_a <= X"6291635E";
s_b <= X"DD42586E";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"854F0AF0") report "Case 173 result failed" severity error;
assert (s_zero = '0') report "Case 173 zero flag failed" severity error;
assert (s_negative = '1') report "Case 173 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 173 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 173 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 173;

s_a <= X"DFA192B8";
s_b <= X"4A2B0D23";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"95768595") report "Case 174 result failed" severity error;
assert (s_zero = '0') report "Case 174 zero flag failed" severity error;
assert (s_negative = '1') report "Case 174 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 174 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 174 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 174;

s_a <= X"A0679E8D";
s_b <= X"894540C5";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"17225DC8") report "Case 175 result failed" severity error;
assert (s_zero = '0') report "Case 175 zero flag failed" severity error;
assert (s_negative = '0') report "Case 175 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 175 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 175 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 175;

s_a <= X"379BA33E";
s_b <= X"A901C503";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"8E99DE3B") report "Case 176 result failed" severity error;
assert (s_zero = '0') report "Case 176 zero flag failed" severity error;
assert (s_negative = '1') report "Case 176 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 176 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 176 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 176;

s_a <= X"79D554C8";
s_b <= X"BBC4B18D";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"BE10A33B") report "Case 177 result failed" severity error;
assert (s_zero = '0') report "Case 177 zero flag failed" severity error;
assert (s_negative = '1') report "Case 177 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 177 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 177 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 177;

s_a <= X"43100531";
s_b <= X"967A5ECF";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"AC95A662") report "Case 178 result failed" severity error;
assert (s_zero = '0') report "Case 178 zero flag failed" severity error;
assert (s_negative = '1') report "Case 178 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 178 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 178 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 178;

s_a <= X"488D54CB";
s_b <= X"0B57EEF8";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"3D3565D3") report "Case 179 result failed" severity error;
assert (s_zero = '0') report "Case 179 zero flag failed" severity error;
assert (s_negative = '0') report "Case 179 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 179 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 179 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 179;

s_a <= X"F81AB42C";
s_b <= X"3C7162B6";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"BBA95176") report "Case 180 result failed" severity error;
assert (s_zero = '0') report "Case 180 zero flag failed" severity error;
assert (s_negative = '1') report "Case 180 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 180 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 180 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 180;

s_a <= X"BE31D63F";
s_b <= X"29FB26DC";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"9436AF63") report "Case 181 result failed" severity error;
assert (s_zero = '0') report "Case 181 zero flag failed" severity error;
assert (s_negative = '1') report "Case 181 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 181 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 181 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 181;

s_a <= X"70896375";
s_b <= X"D856F760";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"98326C15") report "Case 182 result failed" severity error;
assert (s_zero = '0') report "Case 182 zero flag failed" severity error;
assert (s_negative = '1') report "Case 182 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 182 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 182 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 182;

s_a <= X"24311815";
s_b <= X"D4C13D2D";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"4F6FDAE8") report "Case 183 result failed" severity error;
assert (s_zero = '0') report "Case 183 zero flag failed" severity error;
assert (s_negative = '0') report "Case 183 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 183 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 183 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 183;

s_a <= X"44AB1E23";
s_b <= X"2C5B1261";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"18500BC2") report "Case 184 result failed" severity error;
assert (s_zero = '0') report "Case 184 zero flag failed" severity error;
assert (s_negative = '0') report "Case 184 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 184 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 184 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 184;

s_a <= X"0B1B8B59";
s_b <= X"FFCB431B";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"0B50483E") report "Case 185 result failed" severity error;
assert (s_zero = '0') report "Case 185 zero flag failed" severity error;
assert (s_negative = '0') report "Case 185 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 185 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 185 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 185;

s_a <= X"4640FB34";
s_b <= X"5BF51E5B";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"EA4BDCD9") report "Case 186 result failed" severity error;
assert (s_zero = '0') report "Case 186 zero flag failed" severity error;
assert (s_negative = '1') report "Case 186 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 186 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 186 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 186;

s_a <= X"30E8D4C7";
s_b <= X"0270A657";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"2E782E70") report "Case 187 result failed" severity error;
assert (s_zero = '0') report "Case 187 zero flag failed" severity error;
assert (s_negative = '0') report "Case 187 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 187 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 187 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 187;

s_a <= X"C9D82C1C";
s_b <= X"B8029EB2";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"11D58D6A") report "Case 188 result failed" severity error;
assert (s_zero = '0') report "Case 188 zero flag failed" severity error;
assert (s_negative = '0') report "Case 188 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 188 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 188 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 188;

s_a <= X"142ACC90";
s_b <= X"727A495B";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"A1B08335") report "Case 189 result failed" severity error;
assert (s_zero = '0') report "Case 189 zero flag failed" severity error;
assert (s_negative = '1') report "Case 189 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 189 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 189 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 189;

s_a <= X"C34295B3";
s_b <= X"5E389756";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"6509FE5D") report "Case 190 result failed" severity error;
assert (s_zero = '0') report "Case 190 zero flag failed" severity error;
assert (s_negative = '0') report "Case 190 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 190 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 190 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 190;

s_a <= X"7D6F066E";
s_b <= X"F8B113E3";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"84BDF28B") report "Case 191 result failed" severity error;
assert (s_zero = '0') report "Case 191 zero flag failed" severity error;
assert (s_negative = '1') report "Case 191 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 191 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 191 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 191;

s_a <= X"9BDB34C2";
s_b <= X"4440F980";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"579A3B42") report "Case 192 result failed" severity error;
assert (s_zero = '0') report "Case 192 zero flag failed" severity error;
assert (s_negative = '0') report "Case 192 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 192 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 192 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 192;

s_a <= X"CAA07FBA";
s_b <= X"62D8630B";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"67C81CAF") report "Case 193 result failed" severity error;
assert (s_zero = '0') report "Case 193 zero flag failed" severity error;
assert (s_negative = '0') report "Case 193 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 193 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 193 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 193;

s_a <= X"898D1C8A";
s_b <= X"FF4C530F";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"8A40C97B") report "Case 194 result failed" severity error;
assert (s_zero = '0') report "Case 194 zero flag failed" severity error;
assert (s_negative = '1') report "Case 194 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 194 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 194 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 194;

s_a <= X"7429BC08";
s_b <= X"33C713E6";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"4062A822") report "Case 195 result failed" severity error;
assert (s_zero = '0') report "Case 195 zero flag failed" severity error;
assert (s_negative = '0') report "Case 195 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 195 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 195 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 195;

s_a <= X"202E8FD1";
s_b <= X"0400ECEB";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"1C2DA2E6") report "Case 196 result failed" severity error;
assert (s_zero = '0') report "Case 196 zero flag failed" severity error;
assert (s_negative = '0') report "Case 196 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 196 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 196 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 196;

s_a <= X"B0447091";
s_b <= X"4DA8274A";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"629C4947") report "Case 197 result failed" severity error;
assert (s_zero = '0') report "Case 197 zero flag failed" severity error;
assert (s_negative = '0') report "Case 197 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 197 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 197 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 197;

s_a <= X"9E5B0E76";
s_b <= X"50D3AB8A";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"4D8762EC") report "Case 198 result failed" severity error;
assert (s_zero = '0') report "Case 198 zero flag failed" severity error;
assert (s_negative = '0') report "Case 198 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 198 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 198 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 198;

s_a <= X"79D2FE11";
s_b <= X"63E79487";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"15EB698A") report "Case 199 result failed" severity error;
assert (s_zero = '0') report "Case 199 zero flag failed" severity error;
assert (s_negative = '0') report "Case 199 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 199 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 199 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 199;

s_a <= X"911B14E8";
s_b <= X"B1A06B67";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"DF7AA981") report "Case 200 result failed" severity error;
assert (s_zero = '0') report "Case 200 zero flag failed" severity error;
assert (s_negative = '1') report "Case 200 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 200 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 200 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 200;

s_a <= X"BCD0CB14";
s_b <= X"7A54171C";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"427CB3F8") report "Case 201 result failed" severity error;
assert (s_zero = '0') report "Case 201 zero flag failed" severity error;
assert (s_negative = '0') report "Case 201 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 201 carry flag failed" severity error;
assert (s_overflow = '1') report "Case 201 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 201;

s_a <= X"A302B51B";
s_b <= X"CF70A58A";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"D3920F91") report "Case 202 result failed" severity error;
assert (s_zero = '0') report "Case 202 zero flag failed" severity error;
assert (s_negative = '1') report "Case 202 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 202 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 202 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 202;

s_a <= X"FEFF4C2A";
s_b <= X"AA00C264";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"54FE89C6") report "Case 203 result failed" severity error;
assert (s_zero = '0') report "Case 203 zero flag failed" severity error;
assert (s_negative = '0') report "Case 203 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 203 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 203 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 203;

s_a <= X"7EF5BBBE";
s_b <= X"48DC6B6E";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"36195050") report "Case 204 result failed" severity error;
assert (s_zero = '0') report "Case 204 zero flag failed" severity error;
assert (s_negative = '0') report "Case 204 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 204 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 204 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 204;

s_a <= X"55C10E5B";
s_b <= X"58139086";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"FDAD7DD5") report "Case 205 result failed" severity error;
assert (s_zero = '0') report "Case 205 zero flag failed" severity error;
assert (s_negative = '1') report "Case 205 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 205 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 205 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 205;

s_a <= X"57E1FE90";
s_b <= X"44B45B72";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"132DA31E") report "Case 206 result failed" severity error;
assert (s_zero = '0') report "Case 206 zero flag failed" severity error;
assert (s_negative = '0') report "Case 206 negative flag failed" severity error;
assert (s_carry_out = '1') report "Case 206 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 206 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 206;

s_a <= X"B6FD0E3A";
s_b <= X"FE6B0B8C";
s_ALU_operation <= X"1";
wait for cCLK_PER/2;
assert (s_result = X"B89202AE") report "Case 207 result failed" severity error;
assert (s_zero = '0') report "Case 207 zero flag failed" severity error;
assert (s_negative = '1') report "Case 207 negative flag failed" severity error;
assert (s_carry_out = '0') report "Case 207 carry flag failed" severity error;
assert (s_overflow = '0') report "Case 207 overflow flag failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 207;

s_a <= X"FC03F99B";
s_b <= X"A8492D13";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"A8012913") report "Case 208 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 208;

s_a <= X"0F31BCA3";
s_b <= X"E2325E30";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"02301C20") report "Case 209 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 209;

s_a <= X"2DE63D19";
s_b <= X"E8C9A6F3";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"28C02411") report "Case 210 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 210;

s_a <= X"09828B92";
s_b <= X"C3DBDDFB";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"01828992") report "Case 211 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 211;

s_a <= X"FA1CB684";
s_b <= X"A48FC4D2";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"A00C8480") report "Case 212 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 212;

s_a <= X"22DCDFD6";
s_b <= X"5F2DA73A";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"020C8712") report "Case 213 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 213;

s_a <= X"8E44B47F";
s_b <= X"6CF7A1F0";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0C44A070") report "Case 214 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 214;

s_a <= X"4C0934DD";
s_b <= X"7085EE41";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"40012441") report "Case 215 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 215;

s_a <= X"58E8F9B3";
s_b <= X"1AC846DC";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"18C84090") report "Case 216 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 216;

s_a <= X"93901D9E";
s_b <= X"E81BC3A2";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"80100182") report "Case 217 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 217;

s_a <= X"0C182500";
s_b <= X"1D210DB3";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0C000500") report "Case 218 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 218;

s_a <= X"D4CA9CF0";
s_b <= X"B07C0915";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"90480810") report "Case 219 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 219;

s_a <= X"B6B2EAE3";
s_b <= X"B2BC6D31";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"B2B06821") report "Case 220 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 220;

s_a <= X"3536660F";
s_b <= X"AD85CDAC";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"2504440C") report "Case 221 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 221;

s_a <= X"719E32CC";
s_b <= X"C19DA21C";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"419C220C") report "Case 222 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 222;

s_a <= X"49BE9AF4";
s_b <= X"D99D570F";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"499C1204") report "Case 223 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 223;

s_a <= X"948FE5FC";
s_b <= X"8F14F4C5";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"8404E4C4") report "Case 224 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 224;

s_a <= X"D5AFD956";
s_b <= X"EEB78E9D";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"C4A78814") report "Case 225 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 225;

s_a <= X"4915CE4B";
s_b <= X"4735ECE7";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"4115CC43") report "Case 226 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 226;

s_a <= X"950190DF";
s_b <= X"691C2268";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"01000048") report "Case 227 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 227;

s_a <= X"A24495CF";
s_b <= X"9ADE9A83";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"82449083") report "Case 228 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 228;

s_a <= X"2A585E49";
s_b <= X"41146957";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00104841") report "Case 229 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 229;

s_a <= X"3BA340CB";
s_b <= X"DF19A1DF";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"1B0100CB") report "Case 230 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 230;

s_a <= X"353DD92E";
s_b <= X"747EECB8";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"343CC828") report "Case 231 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 231;

s_a <= X"FC1D72D8";
s_b <= X"DA17015F";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"D8150058") report "Case 232 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 232;

s_a <= X"A2B1F965";
s_b <= X"B04E12EA";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"A0001060") report "Case 233 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 233;

s_a <= X"8E9505B4";
s_b <= X"813F7ADB";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"80150090") report "Case 234 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 234;

s_a <= X"B53B46B9";
s_b <= X"11880DD3";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"11080491") report "Case 235 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 235;

s_a <= X"B2238AFE";
s_b <= X"73D98BC2";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"32018AC2") report "Case 236 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 236;

s_a <= X"1581DEF6";
s_b <= X"EF6ED928";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0500D820") report "Case 237 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 237;

s_a <= X"84D4CF0B";
s_b <= X"8890CD08";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"8090CD08") report "Case 238 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 238;

s_a <= X"A185AF69";
s_b <= X"3FD707E5";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"21850761") report "Case 239 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 239;

s_a <= X"AF18080C";
s_b <= X"9E93F8EB";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"8E100808") report "Case 240 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 240;

s_a <= X"E62BCD12";
s_b <= X"1E405F99";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"06004D10") report "Case 241 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 241;

s_a <= X"086BFCE1";
s_b <= X"0E28B207";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0828B001") report "Case 242 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 242;

s_a <= X"C54133A3";
s_b <= X"02F6E165";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00402121") report "Case 243 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 243;

s_a <= X"68412D4E";
s_b <= X"E93E546F";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"6800044E") report "Case 244 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 244;

s_a <= X"D61BD7B4";
s_b <= X"774093E7";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"560093A4") report "Case 245 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 245;

s_a <= X"CE2AB054";
s_b <= X"073A530C";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"062A1004") report "Case 246 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 246;

s_a <= X"D700F7ED";
s_b <= X"52B312B4";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"520012A4") report "Case 247 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 247;

s_a <= X"9A328CB7";
s_b <= X"BA3E4C72";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"9A320C32") report "Case 248 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 248;

s_a <= X"DC480928";
s_b <= X"47DD882C";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"44480828") report "Case 249 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 249;

s_a <= X"CC9DC41C";
s_b <= X"5F691D9A";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"4C090418") report "Case 250 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 250;

s_a <= X"7D715543";
s_b <= X"9EF1916A";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"1C711142") report "Case 251 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 251;

s_a <= X"D540D256";
s_b <= X"D8CA3ECC";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"D0401244") report "Case 252 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 252;

s_a <= X"DC5A6AFB";
s_b <= X"C3D19039";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"C0500039") report "Case 253 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 253;

s_a <= X"3BA46E6E";
s_b <= X"7A3E6E79";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"3A246E68") report "Case 254 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 254;

s_a <= X"13AAA6BF";
s_b <= X"F207BCF8";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"1202A4B8") report "Case 255 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 255;

s_a <= X"3C48591C";
s_b <= X"D50C89DC";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"1408091C") report "Case 256 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 256;

s_a <= X"96A8E5A8";
s_b <= X"20D1244D";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00802408") report "Case 257 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 257;

s_a <= X"B8D889A8";
s_b <= X"D5B57F40";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"90900900") report "Case 258 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 258;

s_a <= X"DD1D7EF1";
s_b <= X"E494BF13";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"C4143E11") report "Case 259 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 259;

s_a <= X"72286AB9";
s_b <= X"6BBDCB28";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"62284A28") report "Case 260 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 260;

s_a <= X"3C2B7FB9";
s_b <= X"0F85D2AA";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0C0152A8") report "Case 261 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 261;

s_a <= X"6B3A9B20";
s_b <= X"F971D821";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"69309820") report "Case 262 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 262;

s_a <= X"2D2CAEAB";
s_b <= X"BDC0FD48";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"2D00AC08") report "Case 263 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 263;

s_a <= X"814306F1";
s_b <= X"6EBAC89A";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00020090") report "Case 264 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 264;

s_a <= X"8CAF6068";
s_b <= X"52EFC448";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00AF4048") report "Case 265 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 265;

s_a <= X"F63B0928";
s_b <= X"A8CE1FF5";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"A00A0920") report "Case 266 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 266;

s_a <= X"3FBDFC65";
s_b <= X"46CBCD4F";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0689CC45") report "Case 267 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 267;

s_a <= X"AE60CB42";
s_b <= X"3C280F75";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"2C200B40") report "Case 268 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 268;

s_a <= X"2DAED028";
s_b <= X"BDD1102E";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"2D801028") report "Case 269 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 269;

s_a <= X"E921A404";
s_b <= X"CB74B258";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"C920A000") report "Case 270 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 270;

s_a <= X"DD17A859";
s_b <= X"03C9DEC9";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"01018849") report "Case 271 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 271;

s_a <= X"C089EF2D";
s_b <= X"2080D6A5";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0080C625") report "Case 272 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 272;

s_a <= X"800C86B2";
s_b <= X"10AABE5D";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00088610") report "Case 273 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 273;

s_a <= X"E62D69A9";
s_b <= X"4F406958";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"46006908") report "Case 274 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 274;

s_a <= X"49446465";
s_b <= X"0BBD76C3";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"09046441") report "Case 275 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 275;

s_a <= X"26C78F2D";
s_b <= X"5BFAA458";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"02C28408") report "Case 276 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 276;

s_a <= X"57C8A7EC";
s_b <= X"CB114877";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"43000064") report "Case 277 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 277;

s_a <= X"BE1789F7";
s_b <= X"E0C35956";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"A0030956") report "Case 278 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 278;

s_a <= X"A30F449A";
s_b <= X"C9196960";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"81094000") report "Case 279 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 279;

s_a <= X"5DAC9B75";
s_b <= X"6C6B192C";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"4C281924") report "Case 280 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 280;

s_a <= X"AEC4B537";
s_b <= X"8C5E20F1";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"8C442031") report "Case 281 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 281;

s_a <= X"6C943D5E";
s_b <= X"A1C62D0A";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"20842D0A") report "Case 282 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 282;

s_a <= X"4ACF4452";
s_b <= X"291C9F95";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"080C0410") report "Case 283 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 283;

s_a <= X"46D7FAAF";
s_b <= X"CD281D06";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"44001806") report "Case 284 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 284;

s_a <= X"B343E3FF";
s_b <= X"A2603002";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"A2402002") report "Case 285 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 285;

s_a <= X"A9A3EA69";
s_b <= X"2BF3FEDE";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"29A3EA48") report "Case 286 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 286;

s_a <= X"1132E02D";
s_b <= X"A1D1E7F0";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0110E020") report "Case 287 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 287;

s_a <= X"F94D6E05";
s_b <= X"8B7506E4";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"89450604") report "Case 288 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 288;

s_a <= X"20CFF1D0";
s_b <= X"AFC020AB";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"20C02080") report "Case 289 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 289;

s_a <= X"C337C0D5";
s_b <= X"9EF2DB39";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"8232C011") report "Case 290 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 290;

s_a <= X"13B7B6AC";
s_b <= X"4306EEC0";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0306A680") report "Case 291 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 291;

s_a <= X"F6974970";
s_b <= X"8B88D771";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"82804170") report "Case 292 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 292;

s_a <= X"36351A3E";
s_b <= X"09A8D7A8";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00201228") report "Case 293 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 293;

s_a <= X"25B3760B";
s_b <= X"2B87A3E6";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"21832202") report "Case 294 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 294;

s_a <= X"0E4EBEE3";
s_b <= X"3DD17A32";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0C403A22") report "Case 295 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 295;

s_a <= X"1F166BB6";
s_b <= X"99C87D3F";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"19006936") report "Case 296 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 296;

s_a <= X"5851837E";
s_b <= X"A8E60114";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"08400114") report "Case 297 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 297;

s_a <= X"647F197D";
s_b <= X"4FEF8630";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"446F0030") report "Case 298 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 298;

s_a <= X"2E68FEC7";
s_b <= X"8EB31B80";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"0E201A80") report "Case 299 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 299;

s_a <= X"985F8E1C";
s_b <= X"06FCDEEB";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"005C8E08") report "Case 300 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 300;

s_a <= X"A976D558";
s_b <= X"78114942";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"28104140") report "Case 301 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 301;

s_a <= X"014689CC";
s_b <= X"1B3F53A5";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"01060184") report "Case 302 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 302;

s_a <= X"0EB51BFC";
s_b <= X"C6056E8E";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"06050A8C") report "Case 303 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 303;

s_a <= X"83BDCBDA";
s_b <= X"47BE5ACC";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"03BC4AC8") report "Case 304 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 304;

s_a <= X"FCF28858";
s_b <= X"0BF587F1";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"08F08050") report "Case 305 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 305;

s_a <= X"08917741";
s_b <= X"266037BE";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"00003700") report "Case 306 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 306;

s_a <= X"E531944D";
s_b <= X"4B52225E";
s_ALU_operation <= X"2";
wait for cCLK_PER/2;
assert (s_result = X"4110004C") report "Case 307 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 307;

s_a <= X"1571C85C";
s_b <= X"1E41B5EF";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"1F71FDFF") report "Case 308 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 308;

s_a <= X"478589F2";
s_b <= X"9DA56066";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DFA5E9F6") report "Case 309 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 309;

s_a <= X"C683CC88";
s_b <= X"6ED5F919";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EED7FD99") report "Case 310 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 310;

s_a <= X"93C4002C";
s_b <= X"648B8246";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F7CF826E") report "Case 311 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 311;

s_a <= X"267FF986";
s_b <= X"C1C225FF";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"E7FFFDFF") report "Case 312 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 312;

s_a <= X"45890FDE";
s_b <= X"A1A76DBC";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"E5AF6FFE") report "Case 313 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 313;

s_a <= X"5ED4677D";
s_b <= X"FA00E47D";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FED4E77D") report "Case 314 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 314;

s_a <= X"3EC62982";
s_b <= X"339F8765";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"3FDFAFE7") report "Case 315 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 315;

s_a <= X"9F8A9558";
s_b <= X"9D65C317";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"9FEFD75F") report "Case 316 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 316;

s_a <= X"2E7D908B";
s_b <= X"E155F059";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EF7DF0DB") report "Case 317 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 317;

s_a <= X"D4F05785";
s_b <= X"4652F344";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"D6F2F7C5") report "Case 318 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 318;

s_a <= X"6D74CAF1";
s_b <= X"83069261";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EF76DAF1") report "Case 319 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 319;

s_a <= X"596560C7";
s_b <= X"9C6CAFD8";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DD6DEFDF") report "Case 320 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 320;

s_a <= X"55F42EA3";
s_b <= X"EF01DB8B";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFF5FFAB") report "Case 321 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 321;

s_a <= X"29B36C20";
s_b <= X"10F32981";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"39F36DA1") report "Case 322 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 322;

s_a <= X"D007B4B2";
s_b <= X"38827993";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F887FDB3") report "Case 323 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 323;

s_a <= X"AE91108F";
s_b <= X"5AD65D74";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FED75DFF") report "Case 324 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 324;

s_a <= X"D2BBF522";
s_b <= X"68694426";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FAFBF526") report "Case 325 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 325;

s_a <= X"EDD5C46A";
s_b <= X"9FA743F9";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFF7C7FB") report "Case 326 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 326;

s_a <= X"F1A4DEDE";
s_b <= X"97C3DCAD";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F7E7DEFF") report "Case 327 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 327;

s_a <= X"336D23E5";
s_b <= X"07E4517D";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"37ED73FD") report "Case 328 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 328;

s_a <= X"2DBC0959";
s_b <= X"A55E00A5";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"ADFE09FD") report "Case 329 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 329;

s_a <= X"3054B50D";
s_b <= X"C51E2AC3";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F55EBFCF") report "Case 330 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 330;

s_a <= X"687B9478";
s_b <= X"FD07E3EB";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FD7FF7FB") report "Case 331 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 331;

s_a <= X"618DDF27";
s_b <= X"7641C9E6";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"77CDDFE7") report "Case 332 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 332;

s_a <= X"CF3169BC";
s_b <= X"6405F512";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EF35FDBE") report "Case 333 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 333;

s_a <= X"85EBE539";
s_b <= X"93BE4A2A";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"97FFEF3B") report "Case 334 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 334;

s_a <= X"9770D0CA";
s_b <= X"28B67A5A";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"BFF6FADA") report "Case 335 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 335;

s_a <= X"794ADEC8";
s_b <= X"FA1E0875";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FB5EDEFD") report "Case 336 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 336;

s_a <= X"2B1A9EF5";
s_b <= X"F2605BD0";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FB7ADFF5") report "Case 337 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 337;

s_a <= X"9629598C";
s_b <= X"00974371";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"96BF5BFD") report "Case 338 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 338;

s_a <= X"D64BD6EB";
s_b <= X"DF18A142";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DF5BF7EB") report "Case 339 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 339;

s_a <= X"92668015";
s_b <= X"284BDEE6";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"BA6FDEF7") report "Case 340 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 340;

s_a <= X"B5A4474C";
s_b <= X"F11CDE73";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F5BCDF7F") report "Case 341 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 341;

s_a <= X"A1EE66DB";
s_b <= X"1774AC3B";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"B7FEEEFB") report "Case 342 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 342;

s_a <= X"AFC62139";
s_b <= X"814425A2";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"AFC625BB") report "Case 343 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 343;

s_a <= X"DAE12BAD";
s_b <= X"72603D63";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FAE13FEF") report "Case 344 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 344;

s_a <= X"93CFA447";
s_b <= X"75777D23";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F7FFFD67") report "Case 345 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 345;

s_a <= X"EAD5ED35";
s_b <= X"29D84595";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EBDDEDB5") report "Case 346 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 346;

s_a <= X"4DD39AAD";
s_b <= X"C1962932";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"CDD7BBBF") report "Case 347 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 347;

s_a <= X"74413FF9";
s_b <= X"CED7AE95";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FED7BFFD") report "Case 348 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 348;

s_a <= X"46A1A0F7";
s_b <= X"355AFFE6";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"77FBFFF7") report "Case 349 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 349;

s_a <= X"1B9FE2AF";
s_b <= X"50E4184E";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"5BFFFAEF") report "Case 350 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 350;

s_a <= X"DE6105D7";
s_b <= X"2EC8E3B0";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FEE9E7F7") report "Case 351 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 351;

s_a <= X"7A7CB899";
s_b <= X"5C5814BF";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"7E7CBCBF") report "Case 352 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 352;

s_a <= X"76D20626";
s_b <= X"439A13B0";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"77DA17B6") report "Case 353 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 353;

s_a <= X"F531F0DD";
s_b <= X"B45DB207";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F57DF2DF") report "Case 354 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 354;

s_a <= X"7C56FEFE";
s_b <= X"967FA4AD";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FE7FFEFF") report "Case 355 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 355;

s_a <= X"FBC6C6AE";
s_b <= X"74A7152D";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFE7D7AF") report "Case 356 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 356;

s_a <= X"D46CDBA1";
s_b <= X"F06ABEF2";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F46EFFF3") report "Case 357 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 357;

s_a <= X"4B197001";
s_b <= X"37ADE48D";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"7FBDF48D") report "Case 358 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 358;

s_a <= X"6E269090";
s_b <= X"7870CB00";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"7E76DB90") report "Case 359 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 359;

s_a <= X"49DCA428";
s_b <= X"C9C35A97";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"C9DFFEBF") report "Case 360 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 360;

s_a <= X"49C68A0A";
s_b <= X"DD1E41A9";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DDDECBAB") report "Case 361 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 361;

s_a <= X"8E4C6796";
s_b <= X"5EB7BDF0";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DEFFFFF6") report "Case 362 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 362;

s_a <= X"D2324272";
s_b <= X"B134DDE9";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F336DFFB") report "Case 363 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 363;

s_a <= X"AED3CA86";
s_b <= X"911AB651";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"BFDBFED7") report "Case 364 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 364;

s_a <= X"F9827500";
s_b <= X"378776EB";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FF8777EB") report "Case 365 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 365;

s_a <= X"A500549D";
s_b <= X"7D581752";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FD5857DF") report "Case 366 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 366;

s_a <= X"BF18C849";
s_b <= X"54616533";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FF79ED7B") report "Case 367 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 367;

s_a <= X"51046BC8";
s_b <= X"FF61D890";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FF65FBD8") report "Case 368 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 368;

s_a <= X"E3F5E65C";
s_b <= X"A361E36A";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"E3F5E77E") report "Case 369 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 369;

s_a <= X"CD4120A8";
s_b <= X"A7BF49DF";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EFFF69FF") report "Case 370 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 370;

s_a <= X"3FE7D2A6";
s_b <= X"BD38214C";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"BFFFF3EE") report "Case 371 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 371;

s_a <= X"FCF323CA";
s_b <= X"455E1A49";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FDFF3BCB") report "Case 372 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 372;

s_a <= X"8A7D0F18";
s_b <= X"15DD3E8C";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"9FFD3F9C") report "Case 373 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 373;

s_a <= X"A4B19475";
s_b <= X"6BA38BED";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EFB39FFD") report "Case 374 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 374;

s_a <= X"17A4D28A";
s_b <= X"F428F095";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F7ACF29F") report "Case 375 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 375;

s_a <= X"835EA801";
s_b <= X"2DF35998";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"AFFFF999") report "Case 376 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 376;

s_a <= X"F5F4B13F";
s_b <= X"C07232F3";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F5F6B3FF") report "Case 377 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 377;

s_a <= X"63580845";
s_b <= X"3E33DE6A";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"7F7BDE6F") report "Case 378 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 378;

s_a <= X"AB70AB2B";
s_b <= X"3B75D84F";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"BB75FB6F") report "Case 379 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 379;

s_a <= X"C47EAD25";
s_b <= X"0DD427F9";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"CDFEAFFD") report "Case 380 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 380;

s_a <= X"715F1387";
s_b <= X"8C0FF1F9";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FD5FF3FF") report "Case 381 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 381;

s_a <= X"08DDF0BF";
s_b <= X"5C7BCB65";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"5CFFFBFF") report "Case 382 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 382;

s_a <= X"89C4BAF2";
s_b <= X"D5B04B92";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DDF4FBF2") report "Case 383 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 383;

s_a <= X"86472E7E";
s_b <= X"FCEE08C1";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FEEF2EFF") report "Case 384 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 384;

s_a <= X"6E62197C";
s_b <= X"155FE0A9";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"7F7FF9FD") report "Case 385 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 385;

s_a <= X"A10C4266";
s_b <= X"95CECC89";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"B5CECEEF") report "Case 386 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 386;

s_a <= X"A70C71C6";
s_b <= X"938BAA4D";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"B78FFBCF") report "Case 387 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 387;

s_a <= X"AD93A5F2";
s_b <= X"00F59945";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"ADF7BDF7") report "Case 388 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 388;

s_a <= X"30E6AFE7";
s_b <= X"CC00BAFB";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FCE6BFFF") report "Case 389 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 389;

s_a <= X"FF8D92C0";
s_b <= X"952271ED";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFAFF3ED") report "Case 390 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 390;

s_a <= X"EB4EAF2D";
s_b <= X"EB6A9AFA";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EB6EBFFF") report "Case 391 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 391;

s_a <= X"FE81D66D";
s_b <= X"FBC578CB";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFC5FEEF") report "Case 392 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 392;

s_a <= X"AA881DC8";
s_b <= X"E54CA21D";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"EFCCBFDD") report "Case 393 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 393;

s_a <= X"FD3A8A5F";
s_b <= X"AF21302D";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FF3BBA7F") report "Case 394 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 394;

s_a <= X"67AAE248";
s_b <= X"00FCC0D9";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"67FEE2D9") report "Case 395 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 395;

s_a <= X"20DA8500";
s_b <= X"71F60AAA";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"71FE8FAA") report "Case 396 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 396;

s_a <= X"7660193A";
s_b <= X"1EF9660B";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"7EF97F3B") report "Case 397 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 397;

s_a <= X"14C732A4";
s_b <= X"DF52B472";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DFD7B6F6") report "Case 398 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 398;

s_a <= X"F0BD0B3E";
s_b <= X"0621E1FD";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F6BDEBFF") report "Case 399 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 399;

s_a <= X"3E50C831";
s_b <= X"C7D0BE72";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFD0FE73") report "Case 400 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 400;

s_a <= X"9FB227BA";
s_b <= X"440A6C97";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"DFBA6FBF") report "Case 401 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 401;

s_a <= X"B057B4CE";
s_b <= X"EFC89DC0";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"FFDFBDCE") report "Case 402 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 402;

s_a <= X"1E2B1879";
s_b <= X"AC04E405";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"BE2FFC7D") report "Case 403 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 403;

s_a <= X"B92576D1";
s_b <= X"3258B8C1";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"BB7DFED1") report "Case 404 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 404;

s_a <= X"78537868";
s_b <= X"F8A5EEE7";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"F8F7FEEF") report "Case 405 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 405;

s_a <= X"4666886E";
s_b <= X"791082E4";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"7F768AEE") report "Case 406 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 406;

s_a <= X"D6E52728";
s_b <= X"84FBA71A";
s_ALU_operation <= X"3";
wait for cCLK_PER/2;
assert (s_result = X"D6FFA73A") report "Case 407 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 407;

s_a <= X"55845F4E";
s_b <= X"8F522F02";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"DAD6704C") report "Case 408 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 408;

s_a <= X"6E9FA8BB";
s_b <= X"412CCDE7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"2FB3655C") report "Case 409 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 409;

s_a <= X"AFDBE835";
s_b <= X"56EEC664";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"F9352E51") report "Case 410 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 410;

s_a <= X"8F5D4E7F";
s_b <= X"10FBA8F8";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"9FA6E687") report "Case 411 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 411;

s_a <= X"6CADB5B7";
s_b <= X"EC6963FD";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"80C4D64A") report "Case 412 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 412;

s_a <= X"890A0184";
s_b <= X"60B72BF7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"E9BD2A73") report "Case 413 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 413;

s_a <= X"F1CABB12";
s_b <= X"8848117D";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"7982AA6F") report "Case 414 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 414;

s_a <= X"2D02A747";
s_b <= X"089CE510";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"259E4257") report "Case 415 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 415;

s_a <= X"EA760604";
s_b <= X"8A43269F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"6035209B") report "Case 416 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 416;

s_a <= X"E18F15D6";
s_b <= X"9A11552E";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"7B9E40F8") report "Case 417 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 417;

s_a <= X"E62D6933";
s_b <= X"DED1C357";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"38FCAA64") report "Case 418 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 418;

s_a <= X"5CED51DD";
s_b <= X"7FB1D9D4";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"235C8809") report "Case 419 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 419;

s_a <= X"69346AC8";
s_b <= X"A67413A3";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"CF40796B") report "Case 420 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 420;

s_a <= X"16C40904";
s_b <= X"D6F321F5";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"C03728F1") report "Case 421 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 421;

s_a <= X"5A35ECD4";
s_b <= X"39A8EE17";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"639D02C3") report "Case 422 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 422;

s_a <= X"8E5C7CD8";
s_b <= X"7BF30F2D";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"F5AF73F5") report "Case 423 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 423;

s_a <= X"176FB6B7";
s_b <= X"19E0AEF0";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"0E8F1847") report "Case 424 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 424;

s_a <= X"B5291A67";
s_b <= X"B1C1C050";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"04E8DA37") report "Case 425 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 425;

s_a <= X"AB52EA66";
s_b <= X"2279A8B7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"892B42D1") report "Case 426 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 426;

s_a <= X"DEF4A9C2";
s_b <= X"C1DA85D1";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"1F2E2C13") report "Case 427 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 427;

s_a <= X"C8A71D66";
s_b <= X"41CCDE8F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"896BC3E9") report "Case 428 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 428;

s_a <= X"CF001AE0";
s_b <= X"A4129282";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"6B128862") report "Case 429 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 429;

s_a <= X"752029AB";
s_b <= X"96E790B8";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"E3C7B913") report "Case 430 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 430;

s_a <= X"409F67E8";
s_b <= X"DD4990A7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"9DD6F74F") report "Case 431 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 431;

s_a <= X"C7656123";
s_b <= X"2AA82882";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"EDCD49A1") report "Case 432 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 432;

s_a <= X"22EB5F86";
s_b <= X"2E5FE350";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"0CB4BCD6") report "Case 433 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 433;

s_a <= X"20058327";
s_b <= X"BC2483CA";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"9C2100ED") report "Case 434 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 434;

s_a <= X"FED357F8";
s_b <= X"0AAA3B57";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"F4796CAF") report "Case 435 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 435;

s_a <= X"02D8CF7B";
s_b <= X"BBA87E47";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"B970B13C") report "Case 436 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 436;

s_a <= X"7611E7B2";
s_b <= X"89E96095";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"FFF88727") report "Case 437 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 437;

s_a <= X"F900C334";
s_b <= X"54936BD8";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"AD93A8EC") report "Case 438 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 438;

s_a <= X"B6A74EC9";
s_b <= X"00509036";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"B6F7DEFF") report "Case 439 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 439;

s_a <= X"D6E9D769";
s_b <= X"0C7912A9";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"DA90C5C0") report "Case 440 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 440;

s_a <= X"7628D17D";
s_b <= X"7142EF33";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"076A3E4E") report "Case 441 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 441;

s_a <= X"C839D086";
s_b <= X"6249B99E";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"AA706918") report "Case 442 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 442;

s_a <= X"6BED2E0B";
s_b <= X"5445259F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"3FA80B94") report "Case 443 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 443;

s_a <= X"77EC3B6F";
s_b <= X"051988B7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"72F5B3D8") report "Case 444 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 444;

s_a <= X"07C0FAD1";
s_b <= X"466D20BD";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"41ADDA6C") report "Case 445 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 445;

s_a <= X"E0547446";
s_b <= X"C22969A0";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"227D1DE6") report "Case 446 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 446;

s_a <= X"93D702ED";
s_b <= X"B1B38FD8";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"22648D35") report "Case 447 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 447;

s_a <= X"E8DD8D8F";
s_b <= X"D4B8AA4A";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"3C6527C5") report "Case 448 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 448;

s_a <= X"7100C8DE";
s_b <= X"24480CCA";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"5548C414") report "Case 449 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 449;

s_a <= X"B4B23CD2";
s_b <= X"F9457468";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"4DF748BA") report "Case 450 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 450;

s_a <= X"2CAE5A97";
s_b <= X"4B87DF10";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"67298587") report "Case 451 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 451;

s_a <= X"0EBDB736";
s_b <= X"A32A9981";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"AD972EB7") report "Case 452 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 452;

s_a <= X"0CA5B850";
s_b <= X"D4B86CF9";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"D81DD4A9") report "Case 453 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 453;

s_a <= X"3C8A90E0";
s_b <= X"5D77050A";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"61FD95EA") report "Case 454 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 454;

s_a <= X"2DD34D27";
s_b <= X"78D6200B";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"55056D2C") report "Case 455 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 455;

s_a <= X"89687B10";
s_b <= X"90FC2022";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"19945B32") report "Case 456 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 456;

s_a <= X"1C13D404";
s_b <= X"45A614ED";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"59B5C0E9") report "Case 457 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 457;

s_a <= X"66E40A55";
s_b <= X"A35556D2";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"C5B15C87") report "Case 458 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 458;

s_a <= X"2EA29347";
s_b <= X"2F3A4FAC";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"0198DCEB") report "Case 459 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 459;

s_a <= X"987ED1EB";
s_b <= X"15BABF92";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"8DC46E79") report "Case 460 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 460;

s_a <= X"F71F4AF2";
s_b <= X"22F73A41";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"D5E870B3") report "Case 461 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 461;

s_a <= X"453FDC68";
s_b <= X"07B4FEDE";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"428B22B6") report "Case 462 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 462;

s_a <= X"0CDE643B";
s_b <= X"9CF3C18D";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"902DA5B6") report "Case 463 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 463;

s_a <= X"B150131E";
s_b <= X"63920ABA";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"D2C219A4") report "Case 464 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 464;

s_a <= X"39D66F49";
s_b <= X"16BE172F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"2F687866") report "Case 465 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 465;

s_a <= X"2518BF6B";
s_b <= X"95692612";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"B0719979") report "Case 466 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 466;

s_a <= X"82050F22";
s_b <= X"3282188B";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"B08717A9") report "Case 467 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 467;

s_a <= X"4F8CBAD1";
s_b <= X"2EA4DB3F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"612861EE") report "Case 468 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 468;

s_a <= X"7BA255C5";
s_b <= X"AFB918B4";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"D41B4D71") report "Case 469 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 469;

s_a <= X"979F29ED";
s_b <= X"FDE031E7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"6A7F180A") report "Case 470 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 470;

s_a <= X"E0680F18";
s_b <= X"ACB7970F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"4CDF9817") report "Case 471 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 471;

s_a <= X"974FE7AD";
s_b <= X"30128F89";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"A75D6824") report "Case 472 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 472;

s_a <= X"8BB3D208";
s_b <= X"49802774";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"C233F57C") report "Case 473 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 473;

s_a <= X"FB30075C";
s_b <= X"116ADFA7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"EA5AD8FB") report "Case 474 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 474;

s_a <= X"34D09C9A";
s_b <= X"5EB8F5EB";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"6A686971") report "Case 475 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 475;

s_a <= X"D2A43353";
s_b <= X"90FD5E3F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"42596D6C") report "Case 476 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 476;

s_a <= X"969AB62A";
s_b <= X"98F40847";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"0E6EBE6D") report "Case 477 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 477;

s_a <= X"AEF10335";
s_b <= X"B8C1F298";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"1630F1AD") report "Case 478 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 478;

s_a <= X"AE908733";
s_b <= X"0D7C8C50";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"A3EC0B63") report "Case 479 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 479;

s_a <= X"B6C94A93";
s_b <= X"A104693C";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"17CD23AF") report "Case 480 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 480;

s_a <= X"D3D240FC";
s_b <= X"3DA8E8B0";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"EE7AA84C") report "Case 481 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 481;

s_a <= X"84A7713D";
s_b <= X"4B1610CC";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"CFB161F1") report "Case 482 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 482;

s_a <= X"EEAAEA05";
s_b <= X"67765E68";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"89DCB46D") report "Case 483 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 483;

s_a <= X"DD27467C";
s_b <= X"E521E046";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"3806A63A") report "Case 484 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 484;

s_a <= X"B0F5D789";
s_b <= X"49E9C95D";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"F91C1ED4") report "Case 485 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 485;

s_a <= X"C8C72904";
s_b <= X"1A05F45C";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"D2C2DD58") report "Case 486 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 486;

s_a <= X"C3A73453";
s_b <= X"D5F9C738";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"165EF36B") report "Case 487 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 487;

s_a <= X"8C0722FE";
s_b <= X"69C90DC0";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"E5CE2F3E") report "Case 488 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 488;

s_a <= X"F1B59F30";
s_b <= X"92D358B0";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"6366C780") report "Case 489 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 489;

s_a <= X"7EF02E54";
s_b <= X"6C3812A4";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"12C83CF0") report "Case 490 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 490;

s_a <= X"F43BE370";
s_b <= X"8443B01B";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"7078536B") report "Case 491 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 491;

s_a <= X"ED855049";
s_b <= X"D3D35B1C";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"3E560B55") report "Case 492 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 492;

s_a <= X"CAE03F3C";
s_b <= X"AFC49BF5";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"6524A4C9") report "Case 493 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 493;

s_a <= X"73114791";
s_b <= X"3BD0C2D2";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"48C18543") report "Case 494 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 494;

s_a <= X"76C56863";
s_b <= X"002E67D6";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"76EB0FB5") report "Case 495 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 495;

s_a <= X"215B7994";
s_b <= X"367452F6";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"172F2B62") report "Case 496 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 496;

s_a <= X"B4EE3EC6";
s_b <= X"EFBD65D5";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"5B535B13") report "Case 497 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 497;

s_a <= X"EFC85555";
s_b <= X"86B9297E";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"69717C2B") report "Case 498 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 498;

s_a <= X"AA831A16";
s_b <= X"59C9724E";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"F34A6858") report "Case 499 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 499;

s_a <= X"F8DA3858";
s_b <= X"837C3FE7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"7BA607BF") report "Case 500 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 500;

s_a <= X"D996D1E6";
s_b <= X"88583CAB";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"51CEED4D") report "Case 501 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 501;

s_a <= X"5F807FBF";
s_b <= X"0F9DD589";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"501DAA36") report "Case 502 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 502;

s_a <= X"1B4DAA5A";
s_b <= X"F5F4C419";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"EEB96E43") report "Case 503 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 503;

s_a <= X"100C6836";
s_b <= X"7ABA32E0";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"6AB65AD6") report "Case 504 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 504;

s_a <= X"73576E7A";
s_b <= X"A7202C5F";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"D4774225") report "Case 505 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 505;

s_a <= X"6AAEAB89";
s_b <= X"859A1A6A";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"EF34B1E3") report "Case 506 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 506;

s_a <= X"C395F971";
s_b <= X"B430CAF7";
s_ALU_operation <= X"4";
wait for cCLK_PER/2;
assert (s_result = X"77A53386") report "Case 507 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 507;

s_a <= X"E1C41040";
s_b <= X"00000008";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"C4104000") report "Case 508 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 508;

s_a <= X"F7937688";
s_b <= X"00000017";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"44000000") report "Case 509 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 509;

s_a <= X"B5FB47DF";
s_b <= X"00000001";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"6BF68FBE") report "Case 510 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 510;

s_a <= X"E4BB8C77";
s_b <= X"0000001C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"70000000") report "Case 511 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 511;

s_a <= X"3D281269";
s_b <= X"0000000B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"40934800") report "Case 512 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 512;

s_a <= X"D248F4E1";
s_b <= X"00000013";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"A7080000") report "Case 513 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 513;

s_a <= X"1B78BDA0";
s_b <= X"0000000F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"5ED00000") report "Case 514 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 514;

s_a <= X"680DE712";
s_b <= X"00000016";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"C4800000") report "Case 515 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 515;

s_a <= X"A76B4B48";
s_b <= X"00000017";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"A4000000") report "Case 516 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 516;

s_a <= X"16EDFBDE";
s_b <= X"0000000F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"FDEF0000") report "Case 517 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 517;

s_a <= X"E82CF146";
s_b <= X"0000000F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"78A30000") report "Case 518 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 518;

s_a <= X"7C6D2DB2";
s_b <= X"0000000B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"696D9000") report "Case 519 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 519;

s_a <= X"2EFBBD67";
s_b <= X"0000001F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"80000000") report "Case 520 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 520;

s_a <= X"FF2D21F6";
s_b <= X"0000001F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 521 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 521;

s_a <= X"ACEC3CE9";
s_b <= X"00000004";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"CEC3CE90") report "Case 522 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 522;

s_a <= X"9364683D";
s_b <= X"0000001D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"A0000000") report "Case 523 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 523;

s_a <= X"F65C5930";
s_b <= X"0000000F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"2C980000") report "Case 524 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 524;

s_a <= X"676F1440";
s_b <= X"00000019";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"80000000") report "Case 525 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 525;

s_a <= X"321FBEA0";
s_b <= X"00000016";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"A8000000") report "Case 526 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 526;

s_a <= X"6B8D165C";
s_b <= X"00000018";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"5C000000") report "Case 527 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 527;

s_a <= X"04D5A148";
s_b <= X"00000005";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"9AB42900") report "Case 528 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 528;

s_a <= X"02409FFA";
s_b <= X"0000000B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"04FFD000") report "Case 529 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 529;

s_a <= X"DD43C71C";
s_b <= X"0000000C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"3C71C000") report "Case 530 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 530;

s_a <= X"0B10D66B";
s_b <= X"0000000D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"1ACD6000") report "Case 531 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 531;

s_a <= X"B4AB534C";
s_b <= X"00000013";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"9A600000") report "Case 532 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 532;

s_a <= X"CD62CAFC";
s_b <= X"00000014";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"AFC00000") report "Case 533 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 533;

s_a <= X"88E26073";
s_b <= X"0000001C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"30000000") report "Case 534 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 534;

s_a <= X"1130B867";
s_b <= X"00000001";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"226170CE") report "Case 535 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 535;

s_a <= X"FD7FC350";
s_b <= X"00000012";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"0D400000") report "Case 536 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 536;

s_a <= X"58776319";
s_b <= X"0000001B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"C8000000") report "Case 537 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 537;

s_a <= X"FEBCEDFE";
s_b <= X"00000010";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"EDFE0000") report "Case 538 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 538;

s_a <= X"209027F9";
s_b <= X"00000004";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"09027F90") report "Case 539 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 539;

s_a <= X"47398A4E";
s_b <= X"00000019";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"9C000000") report "Case 540 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 540;

s_a <= X"3A5C6CC1";
s_b <= X"0000000D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"8D982000") report "Case 541 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 541;

s_a <= X"100C9AB5";
s_b <= X"0000000A";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"326AD400") report "Case 542 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 542;

s_a <= X"F2780A33";
s_b <= X"00000012";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"28CC0000") report "Case 543 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 543;

s_a <= X"EED0F673";
s_b <= X"0000000A";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"43D9CC00") report "Case 544 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 544;

s_a <= X"A73517B8";
s_b <= X"00000012";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"5EE00000") report "Case 545 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 545;

s_a <= X"FBF84A2A";
s_b <= X"0000000A";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"E128A800") report "Case 546 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 546;

s_a <= X"D27B7489";
s_b <= X"00000018";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"89000000") report "Case 547 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 547;

s_a <= X"403C5F2F";
s_b <= X"0000001C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"F0000000") report "Case 548 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 548;

s_a <= X"C902B968";
s_b <= X"00000008";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"02B96800") report "Case 549 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 549;

s_a <= X"82EF928F";
s_b <= X"00000000";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"82EF928F") report "Case 550 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 550;

s_a <= X"9C6D0EAA";
s_b <= X"00000010";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"0EAA0000") report "Case 551 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 551;

s_a <= X"9BADD68F";
s_b <= X"0000000A";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"B75A3C00") report "Case 552 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 552;

s_a <= X"F03CD467";
s_b <= X"00000001";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"E079A8CE") report "Case 553 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 553;

s_a <= X"B4E0B2A3";
s_b <= X"0000001B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"18000000") report "Case 554 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 554;

s_a <= X"08828921";
s_b <= X"0000000F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"44908000") report "Case 555 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 555;

s_a <= X"96CF51D6";
s_b <= X"00000010";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"51D60000") report "Case 556 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 556;

s_a <= X"BAE3507C";
s_b <= X"00000000";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"BAE3507C") report "Case 557 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 557;

s_a <= X"0CE783BE";
s_b <= X"00000014";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"3BE00000") report "Case 558 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 558;

s_a <= X"2327FC0A";
s_b <= X"00000018";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"0A000000") report "Case 559 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 559;

s_a <= X"EFE6AB73";
s_b <= X"00000017";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"B9800000") report "Case 560 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 560;

s_a <= X"8C5E765F";
s_b <= X"0000001D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"E0000000") report "Case 561 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 561;

s_a <= X"9D836A22";
s_b <= X"0000000C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"36A22000") report "Case 562 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 562;

s_a <= X"C089F334";
s_b <= X"0000001E";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 563 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 563;

s_a <= X"71EC3A5E";
s_b <= X"0000000D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"874BC000") report "Case 564 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 564;

s_a <= X"2E375B2F";
s_b <= X"00000002";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"B8DD6CBC") report "Case 565 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 565;

s_a <= X"ABDDC644";
s_b <= X"00000003";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"5EEE3220") report "Case 566 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 566;

s_a <= X"3E903BF9";
s_b <= X"0000000C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"03BF9000") report "Case 567 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 567;

s_a <= X"4BB3B78B";
s_b <= X"00000010";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"B78B0000") report "Case 568 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 568;

s_a <= X"FA5295B4";
s_b <= X"0000001E";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 569 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 569;

s_a <= X"29B875DD";
s_b <= X"00000015";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"BBA00000") report "Case 570 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 570;

s_a <= X"9E6373A4";
s_b <= X"00000004";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"E6373A40") report "Case 571 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 571;

s_a <= X"556D22A7";
s_b <= X"00000004";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"56D22A70") report "Case 572 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 572;

s_a <= X"36FB2BDD";
s_b <= X"0000000C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"B2BDD000") report "Case 573 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 573;

s_a <= X"A7B8DEFA";
s_b <= X"00000005";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"F71BDF40") report "Case 574 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 574;

s_a <= X"364F839C";
s_b <= X"0000001A";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"70000000") report "Case 575 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 575;

s_a <= X"64FB3DCA";
s_b <= X"0000000C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"B3DCA000") report "Case 576 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 576;

s_a <= X"4551DC00";
s_b <= X"00000004";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"551DC000") report "Case 577 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 577;

s_a <= X"0B52D10F";
s_b <= X"0000001B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"78000000") report "Case 578 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 578;

s_a <= X"18AC7ED6";
s_b <= X"0000000D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"8FDAC000") report "Case 579 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 579;

s_a <= X"9E73E9C5";
s_b <= X"00000006";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"9CFA7140") report "Case 580 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 580;

s_a <= X"6F5B1B1D";
s_b <= X"0000001B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"E8000000") report "Case 581 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 581;

s_a <= X"81114F3B";
s_b <= X"00000010";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"4F3B0000") report "Case 582 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 582;

s_a <= X"8DAD4207";
s_b <= X"00000016";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"81C00000") report "Case 583 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 583;

s_a <= X"523DEFB5";
s_b <= X"0000001B";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"A8000000") report "Case 584 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 584;

s_a <= X"BD48DFF2";
s_b <= X"00000002";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"F5237FC8") report "Case 585 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 585;

s_a <= X"53C0E9E0";
s_b <= X"0000000E";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"3A780000") report "Case 586 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 586;

s_a <= X"CC83B67E";
s_b <= X"00000003";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"641DB3F0") report "Case 587 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 587;

s_a <= X"F40E13D7";
s_b <= X"00000015";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"7AE00000") report "Case 588 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 588;

s_a <= X"92C1AB67";
s_b <= X"0000001D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"E0000000") report "Case 589 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 589;

s_a <= X"8E23C88B";
s_b <= X"00000010";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"C88B0000") report "Case 590 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 590;

s_a <= X"7B7158D3";
s_b <= X"00000008";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"7158D300") report "Case 591 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 591;

s_a <= X"0C3823F2";
s_b <= X"00000001";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"187047E4") report "Case 592 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 592;

s_a <= X"0859C82C";
s_b <= X"0000001A";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"B0000000") report "Case 593 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 593;

s_a <= X"BA163B20";
s_b <= X"0000001D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 594 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 594;

s_a <= X"95E81B0D";
s_b <= X"0000000C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"81B0D000") report "Case 595 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 595;

s_a <= X"E8715E2C";
s_b <= X"0000001F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 596 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 596;

s_a <= X"B6363A8F";
s_b <= X"0000000C";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"63A8F000") report "Case 597 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 597;

s_a <= X"138DFBAB";
s_b <= X"00000008";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"8DFBAB00") report "Case 598 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 598;

s_a <= X"332D1E6A";
s_b <= X"00000017";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"35000000") report "Case 599 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 599;

s_a <= X"E335BDC6";
s_b <= X"0000000F";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"DEE30000") report "Case 600 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 600;

s_a <= X"2E63069C";
s_b <= X"00000005";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"CC60D380") report "Case 601 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 601;

s_a <= X"DF471667";
s_b <= X"0000001D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"E0000000") report "Case 602 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 602;

s_a <= X"C55FDD61";
s_b <= X"0000000D";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"FBAC2000") report "Case 603 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 603;

s_a <= X"CD1301B7";
s_b <= X"00000012";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"06DC0000") report "Case 604 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 604;

s_a <= X"CF374C8F";
s_b <= X"00000016";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"23C00000") report "Case 605 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 605;

s_a <= X"24DF0E90";
s_b <= X"00000018";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"90000000") report "Case 606 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 606;

s_a <= X"01BA81D4";
s_b <= X"00000012";
s_ALU_operation <= X"5";
wait for cCLK_PER/2;
assert (s_result = X"07500000") report "Case 607 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 607;

s_a <= X"A6CD8192";
s_b <= X"00000017";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000014D") report "Case 608 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 608;

s_a <= X"F5BB6C27";
s_b <= X"00000004";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0F5BB6C2") report "Case 609 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 609;

s_a <= X"F58CAAF2";
s_b <= X"00000009";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"007AC655") report "Case 610 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 610;

s_a <= X"56E09A6C";
s_b <= X"00000019";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000002B") report "Case 611 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 611;

s_a <= X"EEA646BC";
s_b <= X"0000001A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000003B") report "Case 612 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 612;

s_a <= X"61E9645A";
s_b <= X"0000000B";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000C3D2C") report "Case 613 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 613;

s_a <= X"DDB92002";
s_b <= X"0000001A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000037") report "Case 614 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 614;

s_a <= X"BAB4E198";
s_b <= X"00000016";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000002EA") report "Case 615 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 615;

s_a <= X"24FA3E26";
s_b <= X"00000002";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"093E8F89") report "Case 616 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 616;

s_a <= X"0FFDFEDD";
s_b <= X"0000001F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 617 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 617;

s_a <= X"BC157302";
s_b <= X"00000005";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"05E0AB98") report "Case 618 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 618;

s_a <= X"13BE792C";
s_b <= X"00000009";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0009DF3C") report "Case 619 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 619;

s_a <= X"2371B9EC";
s_b <= X"00000011";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000011B8") report "Case 620 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 620;

s_a <= X"1E476A43";
s_b <= X"00000003";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"03C8ED48") report "Case 621 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 621;

s_a <= X"BFB205D1";
s_b <= X"00000015";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000005FD") report "Case 622 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 622;

s_a <= X"CA85152E";
s_b <= X"00000019";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000065") report "Case 623 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 623;

s_a <= X"951B21AA";
s_b <= X"0000001D";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000004") report "Case 624 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 624;

s_a <= X"44917925";
s_b <= X"00000005";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"02248BC9") report "Case 625 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 625;

s_a <= X"B2102DA6";
s_b <= X"0000001A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000002C") report "Case 626 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 626;

s_a <= X"A20E9E07";
s_b <= X"0000001E";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000002") report "Case 627 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 627;

s_a <= X"EB788C7B";
s_b <= X"00000003";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"1D6F118F") report "Case 628 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 628;

s_a <= X"37AD5F6E";
s_b <= X"00000017";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000006F") report "Case 629 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 629;

s_a <= X"FC9745B3";
s_b <= X"00000010";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000FC97") report "Case 630 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 630;

s_a <= X"6A9ED5F6";
s_b <= X"00000015";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000354") report "Case 631 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 631;

s_a <= X"78FA3957";
s_b <= X"00000003";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0F1F472A") report "Case 632 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 632;

s_a <= X"EF399234";
s_b <= X"00000018";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000000EF") report "Case 633 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 633;

s_a <= X"0E6184C0";
s_b <= X"00000007";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"001CC309") report "Case 634 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 634;

s_a <= X"647D7B67";
s_b <= X"00000008";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00647D7B") report "Case 635 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 635;

s_a <= X"9CA33A6F";
s_b <= X"0000000A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"002728CE") report "Case 636 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 636;

s_a <= X"90C1A38B";
s_b <= X"00000006";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0243068E") report "Case 637 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 637;

s_a <= X"7CE21D2C";
s_b <= X"0000000A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"001F3887") report "Case 638 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 638;

s_a <= X"4FB02470";
s_b <= X"00000005";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"027D8123") report "Case 639 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 639;

s_a <= X"119744D3";
s_b <= X"0000001B";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000002") report "Case 640 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 640;

s_a <= X"5D4231C2";
s_b <= X"00000015";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000002EA") report "Case 641 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 641;

s_a <= X"F4C5232B";
s_b <= X"00000005";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"07A62919") report "Case 642 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 642;

s_a <= X"6282F663";
s_b <= X"0000000F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000C505") report "Case 643 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 643;

s_a <= X"E18D0A49";
s_b <= X"0000001D";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000007") report "Case 644 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 644;

s_a <= X"4BB869C4";
s_b <= X"0000001F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 645 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 645;

s_a <= X"0D9065F4";
s_b <= X"0000000C";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000D906") report "Case 646 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 646;

s_a <= X"9AFCB838";
s_b <= X"00000007";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0135F970") report "Case 647 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 647;

s_a <= X"ABDAF85F";
s_b <= X"00000003";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"157B5F0B") report "Case 648 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 648;

s_a <= X"079EBA9B";
s_b <= X"00000013";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000000F3") report "Case 649 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 649;

s_a <= X"B136E1FD";
s_b <= X"00000000";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"B136E1FD") report "Case 650 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 650;

s_a <= X"003E519D";
s_b <= X"0000001A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 651 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 651;

s_a <= X"96051CB1";
s_b <= X"00000010";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00009605") report "Case 652 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 652;

s_a <= X"16DAE803";
s_b <= X"0000000C";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00016DAE") report "Case 653 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 653;

s_a <= X"C2A46B80";
s_b <= X"00000017";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000185") report "Case 654 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 654;

s_a <= X"7955C4D7";
s_b <= X"0000001D";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000003") report "Case 655 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 655;

s_a <= X"87A9F7CA";
s_b <= X"00000002";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"21EA7DF2") report "Case 656 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 656;

s_a <= X"3B844278";
s_b <= X"00000009";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"001DC221") report "Case 657 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 657;

s_a <= X"CC3EF767";
s_b <= X"00000012";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000330F") report "Case 658 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 658;

s_a <= X"37E3A878";
s_b <= X"00000006";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00DF8EA1") report "Case 659 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 659;

s_a <= X"7E948917";
s_b <= X"0000000B";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000FD291") report "Case 660 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 660;

s_a <= X"5D8EADEF";
s_b <= X"00000018";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000005D") report "Case 661 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 661;

s_a <= X"DDF2DC99";
s_b <= X"00000006";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0377CB72") report "Case 662 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 662;

s_a <= X"2D49B343";
s_b <= X"0000001A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000000B") report "Case 663 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 663;

s_a <= X"7E89AC9E";
s_b <= X"00000005";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"03F44D64") report "Case 664 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 664;

s_a <= X"2BC180A3";
s_b <= X"0000001A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000000A") report "Case 665 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 665;

s_a <= X"CAE66B1C";
s_b <= X"0000001A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000032") report "Case 666 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 666;

s_a <= X"7E8B32F6";
s_b <= X"00000005";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"03F45997") report "Case 667 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 667;

s_a <= X"1C9F20A3";
s_b <= X"0000000F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000393E") report "Case 668 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 668;

s_a <= X"A99DDF5D";
s_b <= X"00000009";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0054CEEF") report "Case 669 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 669;

s_a <= X"B66C8371";
s_b <= X"00000007";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"016CD906") report "Case 670 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 670;

s_a <= X"72E00AE8";
s_b <= X"00000018";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000072") report "Case 671 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 671;

s_a <= X"63334A75";
s_b <= X"00000019";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000031") report "Case 672 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 672;

s_a <= X"DEABA047";
s_b <= X"00000014";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000DEA") report "Case 673 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 673;

s_a <= X"3337F072";
s_b <= X"00000007";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00666FE0") report "Case 674 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 674;

s_a <= X"594BF7DE";
s_b <= X"00000015";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000002CA") report "Case 675 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 675;

s_a <= X"86F466A1";
s_b <= X"00000015";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000437") report "Case 676 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 676;

s_a <= X"CAB927E2";
s_b <= X"00000018";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000000CA") report "Case 677 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 677;

s_a <= X"6E5318B3";
s_b <= X"0000001D";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000003") report "Case 678 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 678;

s_a <= X"2B59C874";
s_b <= X"00000006";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00AD6721") report "Case 679 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 679;

s_a <= X"FFF3CD2A";
s_b <= X"0000000A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"003FFCF3") report "Case 680 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 680;

s_a <= X"F559BEE4";
s_b <= X"00000005";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"07AACDF7") report "Case 681 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 681;

s_a <= X"65E6E696";
s_b <= X"00000009";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0032F373") report "Case 682 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 682;

s_a <= X"D04ADACC";
s_b <= X"00000006";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"03412B6B") report "Case 683 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 683;

s_a <= X"FC1B9F7F";
s_b <= X"00000013";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00001F83") report "Case 684 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 684;

s_a <= X"F56C8F13";
s_b <= X"0000000E";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0003D5B2") report "Case 685 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 685;

s_a <= X"401D9238";
s_b <= X"0000001C";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000004") report "Case 686 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 686;

s_a <= X"1FF85895";
s_b <= X"0000000C";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0001FF85") report "Case 687 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 687;

s_a <= X"655FDF42";
s_b <= X"0000000C";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"000655FD") report "Case 688 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 688;

s_a <= X"23687DC9";
s_b <= X"0000000C";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00023687") report "Case 689 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 689;

s_a <= X"1F0A51F0";
s_b <= X"00000002";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"07C2947C") report "Case 690 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 690;

s_a <= X"B274F187";
s_b <= X"0000001B";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000016") report "Case 691 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 691;

s_a <= X"DFFBAE18";
s_b <= X"00000008";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00DFFBAE") report "Case 692 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 692;

s_a <= X"B7DB6EFB";
s_b <= X"0000001B";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000016") report "Case 693 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 693;

s_a <= X"A449E8CB";
s_b <= X"0000001F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 694 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 694;

s_a <= X"5EC04696";
s_b <= X"0000000A";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0017B011") report "Case 695 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 695;

s_a <= X"7504BB80";
s_b <= X"0000001D";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00000003") report "Case 696 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 696;

s_a <= X"53EC5B6A";
s_b <= X"00000000";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"53EC5B6A") report "Case 697 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 697;

s_a <= X"0A399CC2";
s_b <= X"00000001";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"051CCE61") report "Case 698 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 698;

s_a <= X"90321DA2";
s_b <= X"00000001";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"48190ED1") report "Case 699 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 699;

s_a <= X"1F634071";
s_b <= X"0000000F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00003EC6") report "Case 700 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 700;

s_a <= X"5CE1F81D";
s_b <= X"00000007";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"00B9C3F0") report "Case 701 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 701;

s_a <= X"F80903D0";
s_b <= X"00000019";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000007C") report "Case 702 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 702;

s_a <= X"99CF673C";
s_b <= X"0000000F";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0001339E") report "Case 703 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 703;

s_a <= X"7D693D7F";
s_b <= X"0000000C";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0007D693") report "Case 704 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 704;

s_a <= X"5DD3D5E2";
s_b <= X"0000001B";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000000B") report "Case 705 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 705;

s_a <= X"A8F65FCF";
s_b <= X"00000013";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"0000151E") report "Case 706 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 706;

s_a <= X"3EF88161";
s_b <= X"00000000";
s_ALU_operation <= X"6";
wait for cCLK_PER/2;
assert (s_result = X"3EF88161") report "Case 707 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 707;

s_a <= X"6AD2DB40";
s_b <= X"0000000C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0006AD2D") report "Case 708 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 708;

s_a <= X"CA53E715";
s_b <= X"00000012";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFF294") report "Case 709 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 709;

s_a <= X"2781B09C";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0009E06C") report "Case 710 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 710;

s_a <= X"E315A2E0";
s_b <= X"0000000B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFC62B4") report "Case 711 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 711;

s_a <= X"C7822748";
s_b <= X"0000001D";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFE") report "Case 712 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 712;

s_a <= X"039B7EB1";
s_b <= X"0000001C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 713 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 713;

s_a <= X"E0D822FA";
s_b <= X"00000007";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFC1B045") report "Case 714 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 714;

s_a <= X"56AC2315";
s_b <= X"0000001B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0000000A") report "Case 715 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 715;

s_a <= X"E3B786A0";
s_b <= X"00000013";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFC76") report "Case 716 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 716;

s_a <= X"FF5034B9";
s_b <= X"00000006";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFD40D2") report "Case 717 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 717;

s_a <= X"A2A25053";
s_b <= X"00000010";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFA2A2") report "Case 718 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 718;

s_a <= X"14E5692C";
s_b <= X"0000000C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00014E56") report "Case 719 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 719;

s_a <= X"29D803AD";
s_b <= X"00000003";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"053B0075") report "Case 720 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 720;

s_a <= X"95E8D1EC";
s_b <= X"00000011";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFCAF4") report "Case 721 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 721;

s_a <= X"FA090BB1";
s_b <= X"00000019";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFD") report "Case 722 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 722;

s_a <= X"E86AA674";
s_b <= X"00000014";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFE86") report "Case 723 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 723;

s_a <= X"84C265CB";
s_b <= X"0000000C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFF84C26") report "Case 724 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 724;

s_a <= X"C96964B1";
s_b <= X"00000010";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFC969") report "Case 725 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 725;

s_a <= X"4EBA7C5A";
s_b <= X"0000001C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000004") report "Case 726 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 726;

s_a <= X"0D07A0BE";
s_b <= X"0000000B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0001A0F4") report "Case 727 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 727;

s_a <= X"08DAC15C";
s_b <= X"00000007";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0011B582") report "Case 728 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 728;

s_a <= X"0E8B30CA";
s_b <= X"0000001A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000003") report "Case 729 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 729;

s_a <= X"6516F6A9";
s_b <= X"00000016";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000194") report "Case 730 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 730;

s_a <= X"2805E543";
s_b <= X"0000001C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000002") report "Case 731 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 731;

s_a <= X"D845326F";
s_b <= X"0000001D";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFE") report "Case 732 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 732;

s_a <= X"A762C070";
s_b <= X"0000000F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFF4EC5") report "Case 733 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 733;

s_a <= X"D68AE557";
s_b <= X"00000013";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFAD1") report "Case 734 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 734;

s_a <= X"7D843BFD";
s_b <= X"00000013";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000FB0") report "Case 735 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 735;

s_a <= X"C3B6E009";
s_b <= X"00000011";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFE1DB") report "Case 736 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 736;

s_a <= X"2E7BA562";
s_b <= X"0000001A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0000000B") report "Case 737 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 737;

s_a <= X"66EE9B2B";
s_b <= X"0000001A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000019") report "Case 738 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 738;

s_a <= X"913958D9";
s_b <= X"00000010";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFF9139") report "Case 739 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 739;

s_a <= X"CC3DBB5B";
s_b <= X"0000001B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFF9") report "Case 740 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 740;

s_a <= X"D5218E1E";
s_b <= X"0000000F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFAA43") report "Case 741 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 741;

s_a <= X"EDB0EA87";
s_b <= X"00000019";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFF6") report "Case 742 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 742;

s_a <= X"172CA3E6";
s_b <= X"00000013";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"000002E5") report "Case 743 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 743;

s_a <= X"25D924D2";
s_b <= X"00000017";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0000004B") report "Case 744 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 744;

s_a <= X"D0137D0D";
s_b <= X"00000010";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFD013") report "Case 745 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 745;

s_a <= X"2D19E38B";
s_b <= X"00000000";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"2D19E38B") report "Case 746 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 746;

s_a <= X"C3137170";
s_b <= X"0000000B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFF8626E") report "Case 747 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 747;

s_a <= X"D2B438AE";
s_b <= X"0000001D";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFE") report "Case 748 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 748;

s_a <= X"13D0C4E9";
s_b <= X"00000011";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"000009E8") report "Case 749 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 749;

s_a <= X"36F7E3FF";
s_b <= X"00000010";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"000036F7") report "Case 750 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 750;

s_a <= X"AFBA95C9";
s_b <= X"00000002";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"EBEEA572") report "Case 751 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 751;

s_a <= X"ED814083";
s_b <= X"00000011";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFF6C0") report "Case 752 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 752;

s_a <= X"0D62FC2E";
s_b <= X"00000009";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0006B17E") report "Case 753 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 753;

s_a <= X"162F1DFC";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00058BC7") report "Case 754 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 754;

s_a <= X"BAF607A6";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFEEBD81") report "Case 755 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 755;

s_a <= X"DC0D6808";
s_b <= X"0000000B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFB81AD") report "Case 756 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 756;

s_a <= X"A7C3ADCA";
s_b <= X"00000002";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"E9F0EB72") report "Case 757 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 757;

s_a <= X"870A3916";
s_b <= X"00000014";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFF870") report "Case 758 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 758;

s_a <= X"0AAC6FC0";
s_b <= X"00000015";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000055") report "Case 759 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 759;

s_a <= X"0EF680AC";
s_b <= X"00000017";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0000001D") report "Case 760 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 760;

s_a <= X"80BD63D8";
s_b <= X"00000012";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFE02F") report "Case 761 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 761;

s_a <= X"CFA25940";
s_b <= X"0000001B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFF9") report "Case 762 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 762;

s_a <= X"9660397E";
s_b <= X"00000006";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FE5980E5") report "Case 763 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 763;

s_a <= X"F6925E79";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFDA497") report "Case 764 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 764;

s_a <= X"A5E06A18";
s_b <= X"0000000E";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFE9781") report "Case 765 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 765;

s_a <= X"98D62624";
s_b <= X"0000001B";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFF3") report "Case 766 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 766;

s_a <= X"03F24FFD";
s_b <= X"00000001";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"01F927FE") report "Case 767 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 767;

s_a <= X"1931FFDD";
s_b <= X"00000015";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"000000C9") report "Case 768 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 768;

s_a <= X"9BBB58D6";
s_b <= X"00000004";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"F9BBB58D") report "Case 769 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 769;

s_a <= X"2B9F3CF5";
s_b <= X"00000015";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0000015C") report "Case 770 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 770;

s_a <= X"8FA7DE32";
s_b <= X"00000008";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FF8FA7DE") report "Case 771 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 771;

s_a <= X"75D5F67A";
s_b <= X"00000013";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000EBA") report "Case 772 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 772;

s_a <= X"4F4E0039";
s_b <= X"00000010";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00004F4E") report "Case 773 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 773;

s_a <= X"F1E5369D";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFC794D") report "Case 774 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 774;

s_a <= X"012643A0";
s_b <= X"0000001C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 775 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 775;

s_a <= X"1407B506";
s_b <= X"00000011";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000A03") report "Case 776 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 776;

s_a <= X"EBB63198";
s_b <= X"0000000C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFEBB63") report "Case 777 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 777;

s_a <= X"AE90F443";
s_b <= X"00000015";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFD74") report "Case 778 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 778;

s_a <= X"48A5DBEA";
s_b <= X"0000000E";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00012297") report "Case 779 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 779;

s_a <= X"9E2C44E6";
s_b <= X"0000001F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFF") report "Case 780 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 780;

s_a <= X"A6E2BACA";
s_b <= X"00000001";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"D3715D65") report "Case 781 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 781;

s_a <= X"AC4EF29E";
s_b <= X"0000001F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFF") report "Case 782 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 782;

s_a <= X"C2C528EE";
s_b <= X"00000001";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"E1629477") report "Case 783 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 783;

s_a <= X"B2B99D6D";
s_b <= X"00000009";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFD95CCE") report "Case 784 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 784;

s_a <= X"66977CC0";
s_b <= X"00000017";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"000000CD") report "Case 785 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 785;

s_a <= X"82276547";
s_b <= X"00000009";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFC113B2") report "Case 786 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 786;

s_a <= X"AE466FAC";
s_b <= X"00000015";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFD72") report "Case 787 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 787;

s_a <= X"4F25ECCF";
s_b <= X"00000008";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"004F25EC") report "Case 788 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 788;

s_a <= X"5ABEAA38";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0016AFAA") report "Case 789 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 789;

s_a <= X"F8C70A46";
s_b <= X"00000019";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFC") report "Case 790 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 790;

s_a <= X"77133AFD";
s_b <= X"0000001F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 791 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 791;

s_a <= X"A759B8FC";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFE9D66E") report "Case 792 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 792;

s_a <= X"DFB7C954";
s_b <= X"0000000F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFBF6F") report "Case 793 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 793;

s_a <= X"36DD06CF";
s_b <= X"0000000A";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"000DB741") report "Case 794 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 794;

s_a <= X"DF26A56D";
s_b <= X"0000001F";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFF") report "Case 795 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 795;

s_a <= X"53F097F2";
s_b <= X"00000014";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0000053F") report "Case 796 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 796;

s_a <= X"1E43EEAB";
s_b <= X"0000000C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0001E43E") report "Case 797 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 797;

s_a <= X"C8A88C58";
s_b <= X"00000002";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"F22A2316") report "Case 798 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 798;

s_a <= X"F15A5005";
s_b <= X"0000001D";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFF") report "Case 799 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 799;

s_a <= X"B7181EFB";
s_b <= X"00000018";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFB7") report "Case 800 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 800;

s_a <= X"6A8D2B76";
s_b <= X"00000007";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00D51A56") report "Case 801 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 801;

s_a <= X"3FBA863E";
s_b <= X"0000000E";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"0000FEEA") report "Case 802 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 802;

s_a <= X"AC4987AE";
s_b <= X"00000010";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFAC49") report "Case 803 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 803;

s_a <= X"628078B0";
s_b <= X"0000001C";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"00000006") report "Case 804 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 804;

s_a <= X"C5FCA66B";
s_b <= X"0000001D";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFE") report "Case 805 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 805;

s_a <= X"FC361A62";
s_b <= X"00000019";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FFFFFFFE") report "Case 806 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 806;

s_a <= X"F536CAAA";
s_b <= X"00000001";
s_ALU_operation <= X"7";
wait for cCLK_PER/2;
assert (s_result = X"FA9B6555") report "Case 807 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 807;

s_a <= X"319F08C1";
s_b <= X"0A91C338";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 808 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 808;

s_a <= X"781FFE9C";
s_b <= X"1540CD79";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 809 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 809;

s_a <= X"766B9D58";
s_b <= X"3F24FC07";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 810 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 810;

s_a <= X"A15D36C5";
s_b <= X"731B32D2";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 811 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 811;

s_a <= X"E933D8F2";
s_b <= X"22D650FE";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 812 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 812;

s_a <= X"B21B984C";
s_b <= X"4D71592A";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 813 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 813;

s_a <= X"FC889799";
s_b <= X"F190C9C8";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 814 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 814;

s_a <= X"43EC878C";
s_b <= X"1F9EE60E";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 815 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 815;

s_a <= X"8E851889";
s_b <= X"ABAAD63D";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 816 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 816;

s_a <= X"A5BE330E";
s_b <= X"50FF9F3C";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 817 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 817;

s_a <= X"BD4C18C1";
s_b <= X"74D944CC";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 818 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 818;

s_a <= X"48245E7C";
s_b <= X"13E01850";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 819 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 819;

s_a <= X"C3A7138B";
s_b <= X"3DFF111C";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 820 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 820;

s_a <= X"A452CF97";
s_b <= X"6117066F";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 821 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 821;

s_a <= X"02719294";
s_b <= X"45559174";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 822 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 822;

s_a <= X"814DF863";
s_b <= X"338E6167";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 823 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 823;

s_a <= X"4EF20D04";
s_b <= X"59833061";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 824 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 824;

s_a <= X"C2D3B987";
s_b <= X"93BB715B";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 825 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 825;

s_a <= X"C27A5716";
s_b <= X"728EE1F2";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 826 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 826;

s_a <= X"B262D585";
s_b <= X"69A462FA";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 827 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 827;

s_a <= X"556A7E4C";
s_b <= X"3B413B0E";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 828 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 828;

s_a <= X"F2FAB49C";
s_b <= X"7220D15D";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 829 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 829;

s_a <= X"FDEE83B2";
s_b <= X"8D059677";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 830 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 830;

s_a <= X"3CDAD1E2";
s_b <= X"7499A88E";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 831 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 831;

s_a <= X"B593B929";
s_b <= X"00CCC4B5";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 832 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 832;

s_a <= X"F96EB693";
s_b <= X"42687BAD";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 833 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 833;

s_a <= X"B787F67F";
s_b <= X"A0438DD7";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 834 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 834;

s_a <= X"69DDA6C3";
s_b <= X"A2BF6601";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 835 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 835;

s_a <= X"7E7EF266";
s_b <= X"683C6A62";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 836 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 836;

s_a <= X"947A6BD6";
s_b <= X"6E0144EE";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 837 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 837;

s_a <= X"1C8A3ED8";
s_b <= X"F2A4018E";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 838 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 838;

s_a <= X"5603ED4C";
s_b <= X"C998ABEE";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 839 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 839;

s_a <= X"7761BA2B";
s_b <= X"D9DC5B24";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 840 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 840;

s_a <= X"2026BAAB";
s_b <= X"8991FD82";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 841 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 841;

s_a <= X"DEF7EB8E";
s_b <= X"8AB64F6F";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 842 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 842;

s_a <= X"862B67A6";
s_b <= X"26413FD4";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 843 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 843;

s_a <= X"8FA1144C";
s_b <= X"2A53D8B1";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 844 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 844;

s_a <= X"6E59C9A0";
s_b <= X"EDDCB44E";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 845 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 845;

s_a <= X"A4326BB0";
s_b <= X"C80E10C6";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 846 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 846;

s_a <= X"D660D03D";
s_b <= X"1104D66C";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 847 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 847;

s_a <= X"3D6A71A1";
s_b <= X"3C6C083B";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 848 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 848;

s_a <= X"4A8C9A38";
s_b <= X"F696D1CC";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 849 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 849;

s_a <= X"069EE049";
s_b <= X"133C4643";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 850 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 850;

s_a <= X"664FE1C6";
s_b <= X"9B5A1160";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 851 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 851;

s_a <= X"8B70ECE4";
s_b <= X"02A03FBB";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 852 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 852;

s_a <= X"EB0DC511";
s_b <= X"6C7EBAD1";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 853 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 853;

s_a <= X"5DA9FF8A";
s_b <= X"83DD16C9";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 854 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 854;

s_a <= X"AB245DDC";
s_b <= X"DBEE88A9";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 855 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 855;

s_a <= X"A365C348";
s_b <= X"FE314B0F";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 856 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 856;

s_a <= X"D0B1E914";
s_b <= X"FB47FCEF";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 857 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 857;

s_a <= X"F3E9F452";
s_b <= X"7F023C59";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 858 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 858;

s_a <= X"258AB27F";
s_b <= X"CEF14C21";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 859 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 859;

s_a <= X"D6EC3DAB";
s_b <= X"CE4769FB";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 860 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 860;

s_a <= X"EEBA174E";
s_b <= X"E805BAFA";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 861 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 861;

s_a <= X"6D8198F7";
s_b <= X"1968A0F8";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 862 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 862;

s_a <= X"A7073493";
s_b <= X"A0369976";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 863 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 863;

s_a <= X"7CB7FADA";
s_b <= X"37165A76";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 864 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 864;

s_a <= X"0BEE1802";
s_b <= X"5CD38205";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 865 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 865;

s_a <= X"2285AB21";
s_b <= X"973C57DC";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 866 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 866;

s_a <= X"A840E0F4";
s_b <= X"D5DE8121";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 867 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 867;

s_a <= X"F6049A4B";
s_b <= X"489F0558";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 868 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 868;

s_a <= X"3EE8EFE6";
s_b <= X"2ACB6D95";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 869 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 869;

s_a <= X"5ECE1DEC";
s_b <= X"95FDDEF3";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 870 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 870;

s_a <= X"4711F042";
s_b <= X"54E77CA6";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 871 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 871;

s_a <= X"AA4ABDF0";
s_b <= X"92852626";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 872 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 872;

s_a <= X"57CF2849";
s_b <= X"83EE044E";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 873 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 873;

s_a <= X"82686F53";
s_b <= X"2B5D803F";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 874 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 874;

s_a <= X"2CAAB925";
s_b <= X"CB3D44A6";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 875 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 875;

s_a <= X"023E9F37";
s_b <= X"BB313A3F";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 876 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 876;

s_a <= X"966ED828";
s_b <= X"A689E87D";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 877 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 877;

s_a <= X"A8A2FBC4";
s_b <= X"AC537902";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 878 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 878;

s_a <= X"80ABC71B";
s_b <= X"29AAB541";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 879 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 879;

s_a <= X"3B766EFD";
s_b <= X"7F3162CD";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 880 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 880;

s_a <= X"9D03B056";
s_b <= X"3B74580C";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 881 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 881;

s_a <= X"CEF52840";
s_b <= X"3D80AEDA";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 882 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 882;

s_a <= X"56ED411F";
s_b <= X"68600632";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 883 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 883;

s_a <= X"1E549202";
s_b <= X"17CB52A8";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 884 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 884;

s_a <= X"F2ADE840";
s_b <= X"63D9FCC2";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 885 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 885;

s_a <= X"E3BDC630";
s_b <= X"450358BD";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 886 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 886;

s_a <= X"AE7C40D7";
s_b <= X"F52F0099";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 887 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 887;

s_a <= X"26DCAC5D";
s_b <= X"F3BC0558";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 888 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 888;

s_a <= X"B935DDD7";
s_b <= X"EFBE05A4";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 889 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 889;

s_a <= X"8CEFFE3E";
s_b <= X"55A655E1";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 890 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 890;

s_a <= X"2EE7C942";
s_b <= X"CAA83A05";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 891 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 891;

s_a <= X"A71DCA12";
s_b <= X"AD81B044";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 892 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 892;

s_a <= X"F5C96CE0";
s_b <= X"BDCC2EC8";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 893 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 893;

s_a <= X"452EACE6";
s_b <= X"6836D517";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 894 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 894;

s_a <= X"6087D2A9";
s_b <= X"6AD3BBFD";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 895 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 895;

s_a <= X"368469A7";
s_b <= X"04B487CC";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 896 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 896;

s_a <= X"13DB05E2";
s_b <= X"D5FB4CDC";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 897 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 897;

s_a <= X"DFAC7A52";
s_b <= X"6E0EA456";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 898 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 898;

s_a <= X"9D8B3E46";
s_b <= X"3CAB2A9D";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 899 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 899;

s_a <= X"BB278891";
s_b <= X"0DEDA472";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 900 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 900;

s_a <= X"06C3D30D";
s_b <= X"AE930E8F";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 901 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 901;

s_a <= X"3264BAE2";
s_b <= X"BD014C67";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 902 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 902;

s_a <= X"C1BB233A";
s_b <= X"21D11118";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 903 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 903;

s_a <= X"8CFB284D";
s_b <= X"8613DC12";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 904 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 904;

s_a <= X"86D246D0";
s_b <= X"819209E4";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 905 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 905;

s_a <= X"0B744E46";
s_b <= X"47DB6135";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 906 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 906;

s_a <= X"6B8E35FB";
s_b <= X"A664918B";
s_ALU_operation <= X"8";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 907 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 907;

s_a <= X"73272A2F";
s_b <= X"FC1BC14E";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 908 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 908;

s_a <= X"77ABD2D9";
s_b <= X"E465B16A";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 909 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 909;

s_a <= X"4BF6788B";
s_b <= X"E78BADBA";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 910 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 910;

s_a <= X"0272885D";
s_b <= X"CCB12AE8";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 911 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 911;

s_a <= X"0CFD74F2";
s_b <= X"364E02BE";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 912 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 912;

s_a <= X"144AC25B";
s_b <= X"4F7053F1";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 913 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 913;

s_a <= X"7BD40807";
s_b <= X"18A0D9DF";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 914 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 914;

s_a <= X"287F834A";
s_b <= X"90916BC4";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 915 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 915;

s_a <= X"3B851E3A";
s_b <= X"0130758F";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 916 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 916;

s_a <= X"1D686CC7";
s_b <= X"612F6CEC";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 917 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 917;

s_a <= X"1C3D5BB1";
s_b <= X"177DB6BF";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 918 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 918;

s_a <= X"B5A9F95C";
s_b <= X"016FF10E";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 919 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 919;

s_a <= X"C47FF464";
s_b <= X"4C703EFA";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 920 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 920;

s_a <= X"C007B5A6";
s_b <= X"6F238833";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 921 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 921;

s_a <= X"0D0C0574";
s_b <= X"3CF5C7D1";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 922 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 922;

s_a <= X"4119BCC6";
s_b <= X"61A1D0F2";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 923 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 923;

s_a <= X"5AEC6CA0";
s_b <= X"2B354E0B";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 924 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 924;

s_a <= X"D755A0DE";
s_b <= X"3578A5AB";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 925 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 925;

s_a <= X"CD2C1E02";
s_b <= X"4A16ECAC";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 926 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 926;

s_a <= X"FA306854";
s_b <= X"6DF440D4";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 927 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 927;

s_a <= X"39625CD0";
s_b <= X"B6D9DB6D";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 928 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 928;

s_a <= X"189BF76A";
s_b <= X"644F60A0";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 929 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 929;

s_a <= X"1C18B122";
s_b <= X"C9DE071B";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 930 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 930;

s_a <= X"A17C3D5B";
s_b <= X"2AD09D61";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 931 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 931;

s_a <= X"6E0F7355";
s_b <= X"64F0EE37";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 932 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 932;

s_a <= X"CBEA95F7";
s_b <= X"4FD2B8D8";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 933 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 933;

s_a <= X"4CEB405B";
s_b <= X"E5FD0E7E";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 934 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 934;

s_a <= X"37B62AAF";
s_b <= X"468B379A";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 935 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 935;

s_a <= X"0CC16F33";
s_b <= X"CBB7C9AB";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 936 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 936;

s_a <= X"27350A40";
s_b <= X"1C887920";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 937 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 937;

s_a <= X"F43DF7FC";
s_b <= X"158D0E19";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 938 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 938;

s_a <= X"554A699F";
s_b <= X"70380F12";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 939 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 939;

s_a <= X"B74A2897";
s_b <= X"E4C488FF";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 940 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 940;

s_a <= X"2CAA9322";
s_b <= X"1DBBD682";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 941 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 941;

s_a <= X"F0DADD1C";
s_b <= X"70723BA5";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 942 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 942;

s_a <= X"005B69CD";
s_b <= X"B3D856A9";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 943 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 943;

s_a <= X"27B1841F";
s_b <= X"DD24D526";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 944 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 944;

s_a <= X"DE5637B2";
s_b <= X"7A1A6F04";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 945 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 945;

s_a <= X"50EDB770";
s_b <= X"D136FB03";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 946 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 946;

s_a <= X"D354CCEC";
s_b <= X"ED649D74";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 947 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 947;

s_a <= X"3F0D6994";
s_b <= X"E913E1C9";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 948 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 948;

s_a <= X"3EC06016";
s_b <= X"16C5605E";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 949 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 949;

s_a <= X"1726B5EE";
s_b <= X"757A4CD4";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 950 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 950;

s_a <= X"DA82E336";
s_b <= X"6D3EA87B";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 951 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 951;

s_a <= X"055E9551";
s_b <= X"6DD6E63C";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 952 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 952;

s_a <= X"D637E89C";
s_b <= X"75DE8E4B";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 953 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 953;

s_a <= X"B82E4B0B";
s_b <= X"E0EAF663";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 954 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 954;

s_a <= X"2C78CD1B";
s_b <= X"8B562C55";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 955 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 955;

s_a <= X"6BDA0298";
s_b <= X"A658C496";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 956 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 956;

s_a <= X"A89D17B2";
s_b <= X"A3DE03CD";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 957 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 957;

s_a <= X"19A4FA9B";
s_b <= X"C7F76301";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 958 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 958;

s_a <= X"92688649";
s_b <= X"E9F9F6C9";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 959 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 959;

s_a <= X"D1876C40";
s_b <= X"3966A7FD";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 960 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 960;

s_a <= X"B1247565";
s_b <= X"F286A374";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 961 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 961;

s_a <= X"3CAC1329";
s_b <= X"3A5E1CEB";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 962 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 962;

s_a <= X"3CA305BC";
s_b <= X"FEEB8843";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 963 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 963;

s_a <= X"A2A091F9";
s_b <= X"9E7C8649";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 964 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 964;

s_a <= X"9A3EE58A";
s_b <= X"1BCF7E84";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 965 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 965;

s_a <= X"EB724C5D";
s_b <= X"C35C7447";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 966 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 966;

s_a <= X"923AE55C";
s_b <= X"B98F0A93";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 967 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 967;

s_a <= X"B7E2480E";
s_b <= X"2A477316";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 968 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 968;

s_a <= X"1E69A803";
s_b <= X"A0104608";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 969 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 969;

s_a <= X"B82C59D9";
s_b <= X"6DE11A6A";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 970 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 970;

s_a <= X"5996D1BA";
s_b <= X"DCDA24BB";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 971 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 971;

s_a <= X"095E4687";
s_b <= X"C575CBDC";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 972 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 972;

s_a <= X"151A4C4D";
s_b <= X"6A910B05";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 973 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 973;

s_a <= X"5F378482";
s_b <= X"B83D6B33";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 974 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 974;

s_a <= X"E74172E2";
s_b <= X"F677576B";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 975 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 975;

s_a <= X"E7270E49";
s_b <= X"B1E272EC";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 976 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 976;

s_a <= X"3CF38730";
s_b <= X"7872E5DA";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 977 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 977;

s_a <= X"5748212F";
s_b <= X"BE666195";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 978 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 978;

s_a <= X"BE306A9A";
s_b <= X"7E074AF5";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 979 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 979;

s_a <= X"01C7BCEC";
s_b <= X"D28639FB";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 980 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 980;

s_a <= X"68F02125";
s_b <= X"63BC4505";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 981 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 981;

s_a <= X"5AEB424D";
s_b <= X"60061352";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 982 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 982;

s_a <= X"BC33D699";
s_b <= X"0C651DA2";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 983 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 983;

s_a <= X"89D51B63";
s_b <= X"1C7623CC";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 984 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 984;

s_a <= X"C2026E68";
s_b <= X"E0BF378B";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 985 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 985;

s_a <= X"B5B86467";
s_b <= X"1D00446C";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 986 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 986;

s_a <= X"8DB5D92D";
s_b <= X"3B74453A";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 987 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 987;

s_a <= X"2882A206";
s_b <= X"F5B12C2F";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 988 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 988;

s_a <= X"35E1CA79";
s_b <= X"B27DA1A0";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 989 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 989;

s_a <= X"4506CF63";
s_b <= X"BCDC0348";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 990 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 990;

s_a <= X"E3EB1C3D";
s_b <= X"5B843DF5";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 991 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 991;

s_a <= X"0A7BABD4";
s_b <= X"E11553D7";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 992 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 992;

s_a <= X"D1830314";
s_b <= X"34392AFE";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 993 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 993;

s_a <= X"301491C6";
s_b <= X"304389C4";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 994 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 994;

s_a <= X"66CD4258";
s_b <= X"63C5B40D";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 995 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 995;

s_a <= X"973FD4C7";
s_b <= X"6CE4D733";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 996 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 996;

s_a <= X"881E3A63";
s_b <= X"A586D7E8";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 997 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 997;

s_a <= X"2A126E44";
s_b <= X"7816F2A4";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 998 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 998;

s_a <= X"54DFBFC9";
s_b <= X"CA06C4A5";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 999 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 999;

s_a <= X"1A2F89D8";
s_b <= X"3AE7BD5E";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 1000 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1000;

s_a <= X"07B1AD2A";
s_b <= X"514E76B5";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 1001 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1001;

s_a <= X"2F13A19E";
s_b <= X"20057112";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 1002 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1002;

s_a <= X"1CB13AD2";
s_b <= X"6279ABF9";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 1003 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1003;

s_a <= X"8A3A2F35";
s_b <= X"29680A19";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 1004 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1004;

s_a <= X"7CA6B6A3";
s_b <= X"B6A17E91";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000001") report "Case 1005 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1005;

s_a <= X"76F23880";
s_b <= X"708A6DD8";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 1006 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1006;

s_a <= X"BD56E08D";
s_b <= X"9CA21BAE";
s_ALU_operation <= X"9";
wait for cCLK_PER/2;
assert (s_result = X"00000000") report "Case 1007 result failed" severity error;
wait for cCLK_PER/2;
s_case_number <= 1007;



    wait;

    end process;
end behavior;