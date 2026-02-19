-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a VHDL testbench for the barrel shifter
-- automated test cases are made with the corresponding python script
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
entity tb_barrel_shifter is
    generic (gCLK_HPER : time := 50 ns);
end tb_barrel_shifter;

architecture behavior of tb_barrel_shifter is

    -- Calculate the clock period as twice the half-period
    constant cCLK_PER : time := gCLK_HPER * 2;
    component barrel_shifter
        port (
            i_opperand : in std_logic_vector(31 downto 0);
            i_shift : in std_logic_vector(4 downto 0);
            i_left : in std_logic;--0 for right shift, 1 for left shift
            i_sign_fill : in std_logic;
            o_result : out std_logic_vector(31 downto 0)
        );

    end component;
    -- Temporary signals to connect to the dff component.
    signal s_CLK, s_RST : std_logic;

    signal s_operand, s_result : std_logic_vector(31 downto 0);
    signal s_shift : std_logic_vector(7 downto 0);
    signal s_left, s_sign_fill : std_logic;

    signal s_shift_real : std_logic_vector(4 downto 0);
    --case number
    signal s_case_number : integer := 0;

begin
    s_shift_real <= s_shift(4 downto 0);

    DUT : barrel_shifter
    port map(
        i_opperand => s_operand,
        i_shift => s_shift_real,
        i_left => s_left, --0 for right shift, 1 for left shift
        i_sign_fill => s_sign_fill,
        o_result => s_result
    );

    -- This process sets the clock value (low for gCLK_HPER, then high
    -- for gCLK_HPER). Absent a "wait" command, processes restart 
    -- at the beginning once they have reached the final statement.
    P_CLK : process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    -- Testbench process  
    P_TB : process
    begin
        s_RST <= '1';
        wait for cCLK_PER;
        s_RST <= '0';
        s_operand <= X"80000000";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 0;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFFF") report "Case 1 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"80000000";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 1;
        wait for cCLK_PER/2;
        assert (s_result = X"00000001") report "Case 2 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"80000000";
        s_shift <= X"01";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 2;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 3 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FFFFFFFF";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 3;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFFF") report "Case 4 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"00000000";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 4;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 5 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"97FF0BAB";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 5;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFCBFF8") report "Case 6 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"AFA2F7D3";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 6;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFFF") report "Case 7 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"5C01A79D";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 7;
        wait for cCLK_PER/2;
        assert (s_result = X"170069E7") report "Case 8 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"66A49AC5";
        s_shift <= X"1C";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 8;
        wait for cCLK_PER/2;
        assert (s_result = X"00000006") report "Case 9 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"1A8D270A";
        s_shift <= X"00";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 9;
        wait for cCLK_PER/2;
        assert (s_result = X"1A8D270A") report "Case 10 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"587D5C44";
        s_shift <= X"01";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 10;
        wait for cCLK_PER/2;
        assert (s_result = X"2C3EAE22") report "Case 11 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"342EF5E5";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 11;
        wait for cCLK_PER/2;
        assert (s_result = X"000D0BBD") report "Case 12 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C13EC739";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 12;
        wait for cCLK_PER/2;
        assert (s_result = X"F04FB1CE") report "Case 13 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"61108DDE";
        s_shift <= X"00";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 13;
        wait for cCLK_PER/2;
        assert (s_result = X"61108DDE") report "Case 14 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6D6BBCEE";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 14;
        wait for cCLK_PER/2;
        assert (s_result = X"00001B5A") report "Case 15 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8E065EEF";
        s_shift <= X"17";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 15;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFF1C") report "Case 16 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"DD384777";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 16;
        wait for cCLK_PER/2;
        assert (s_result = X"FBA708EE") report "Case 17 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"608C2C7E";
        s_shift <= X"0C";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 17;
        wait for cCLK_PER/2;
        assert (s_result = X"000608C2") report "Case 18 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E9434459";
        s_shift <= X"0B";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 18;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFD2868") report "Case 19 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"65ED8475";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 19;
        wait for cCLK_PER/2;
        assert (s_result = X"0032F6C2") report "Case 20 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"4D126D23";
        s_shift <= X"06";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 20;
        wait for cCLK_PER/2;
        assert (s_result = X"013449B4") report "Case 21 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B90118DD";
        s_shift <= X"0C";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 21;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFB9011") report "Case 22 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"45707725";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 22;
        wait for cCLK_PER/2;
        assert (s_result = X"00000011") report "Case 23 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F6255E95";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 23;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFB12") report "Case 24 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7A31DDE4";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 24;
        wait for cCLK_PER/2;
        assert (s_result = X"001E8C77") report "Case 25 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"AE47F149";
        s_shift <= X"01";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 25;
        wait for cCLK_PER/2;
        assert (s_result = X"D723F8A4") report "Case 26 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"1E9D9C1B";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 26;
        wait for cCLK_PER/2;
        assert (s_result = X"000000F4") report "Case 27 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6DBB7A3D";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 27;
        wait for cCLK_PER/2;
        assert (s_result = X"1B6EDE8F") report "Case 28 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8774B8A9";
        s_shift <= X"0F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 28;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFF0EE9") report "Case 29 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D24AD77B";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 29;
        wait for cCLK_PER/2;
        assert (s_result = X"FFF492B5") report "Case 30 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A09C8F27";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 30;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFE827") report "Case 31 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A2BC88E3";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 31;
        wait for cCLK_PER/2;
        assert (s_result = X"F457911C") report "Case 32 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"947CD307";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 32;
        wait for cCLK_PER/2;
        assert (s_result = X"FFCA3E69") report "Case 33 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F77B5B32";
        s_shift <= X"13";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 33;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFEEF") report "Case 34 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D61DE76D";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 34;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFFF") report "Case 35 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F909A73A";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 35;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFC8") report "Case 36 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"70A27F53";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 36;
        wait for cCLK_PER/2;
        assert (s_result = X"0000001C") report "Case 37 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6D5CFC18";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 37;
        wait for cCLK_PER/2;
        assert (s_result = X"1B573F06") report "Case 38 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D03ED996";
        s_shift <= X"1E";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 38;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFFF") report "Case 39 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"612F2595";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 39;
        wait for cCLK_PER/2;
        assert (s_result = X"0000184B") report "Case 40 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C2645932";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 40;
        wait for cCLK_PER/2;
        assert (s_result = X"FFE1322C") report "Case 41 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"10E1DEEF";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 41;
        wait for cCLK_PER/2;
        assert (s_result = X"00000870") report "Case 42 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"5C088323";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 42;
        wait for cCLK_PER/2;
        assert (s_result = X"0000002E") report "Case 43 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"CB978FBB";
        s_shift <= X"08";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 43;
        wait for cCLK_PER/2;
        assert (s_result = X"FFCB978F") report "Case 44 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"0D144159";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 44;
        wait for cCLK_PER/2;
        assert (s_result = X"0000068A") report "Case 45 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"394971E3";
        s_shift <= X"18";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 45;
        wait for cCLK_PER/2;
        assert (s_result = X"00000039") report "Case 46 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"CB158F04";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 46;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFE5") report "Case 47 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"4E62E5FA";
        s_shift <= X"0C";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 47;
        wait for cCLK_PER/2;
        assert (s_result = X"0004E62E") report "Case 48 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"63B090A8";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 48;
        wait for cCLK_PER/2;
        assert (s_result = X"0C761215") report "Case 49 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"09B0DA40";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 49;
        wait for cCLK_PER/2;
        assert (s_result = X"00026C36") report "Case 50 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B512FBC2";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 50;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFDA897") report "Case 51 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F8619BDE";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 51;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFE18") report "Case 52 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"0A7A5AD4";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 52;
        wait for cCLK_PER/2;
        assert (s_result = X"014F4B5A") report "Case 53 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"DD5BE7DF";
        s_shift <= X"1C";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 53;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFFD") report "Case 54 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BEEF949B";
        s_shift <= X"14";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 54;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFBEE") report "Case 55 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2AE15C25";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 55;
        wait for cCLK_PER/2;
        assert (s_result = X"00001570") report "Case 56 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"196FCBB6";
        s_shift <= X"0F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 56;
        wait for cCLK_PER/2;
        assert (s_result = X"000032DF") report "Case 57 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8B7A4DCB";
        s_shift <= X"04";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 57;
        wait for cCLK_PER/2;
        assert (s_result = X"F8B7A4DC") report "Case 58 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"4703F39A";
        s_shift <= X"1C";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 58;
        wait for cCLK_PER/2;
        assert (s_result = X"00000004") report "Case 59 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"40D9C060";
        s_shift <= X"0E";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 59;
        wait for cCLK_PER/2;
        assert (s_result = X"00010367") report "Case 60 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"9BE74C8C";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 60;
        wait for cCLK_PER/2;
        assert (s_result = X"FFCDF3A6") report "Case 61 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"CB562212";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 61;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFF2D") report "Case 62 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"63F87090";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 62;
        wait for cCLK_PER/2;
        assert (s_result = X"00000018") report "Case 63 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"61E795AC";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 63;
        wait for cCLK_PER/2;
        assert (s_result = X"00000003") report "Case 64 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"69A185D8";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 64;
        wait for cCLK_PER/2;
        assert (s_result = X"001A6861") report "Case 65 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F0BBB6AF";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 65;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFC2EED") report "Case 66 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7F605506";
        s_shift <= X"05";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 66;
        wait for cCLK_PER/2;
        assert (s_result = X"03FB02A8") report "Case 67 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"AB59CB97";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 67;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFEAD") report "Case 68 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"1DCA34A5";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 68;
        wait for cCLK_PER/2;
        assert (s_result = X"00000007") report "Case 69 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"54C72554";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 69;
        wait for cCLK_PER/2;
        assert (s_result = X"00001531") report "Case 70 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"36EFF9E2";
        s_shift <= X"06";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 70;
        wait for cCLK_PER/2;
        assert (s_result = X"00DBBFE7") report "Case 71 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"188177CD";
        s_shift <= X"14";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 71;
        wait for cCLK_PER/2;
        assert (s_result = X"00000188") report "Case 72 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"DA8EA6C3";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 72;
        wait for cCLK_PER/2;
        assert (s_result = X"FB51D4D8") report "Case 73 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"5717AEBC";
        s_shift <= X"07";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 73;
        wait for cCLK_PER/2;
        assert (s_result = X"00AE2F5D") report "Case 74 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"3C40EF4D";
        s_shift <= X"06";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 74;
        wait for cCLK_PER/2;
        assert (s_result = X"00F103BD") report "Case 75 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"DE7125DE";
        s_shift <= X"04";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 75;
        wait for cCLK_PER/2;
        assert (s_result = X"FDE7125D") report "Case 76 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"9BC70BFE";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 76;
        wait for cCLK_PER/2;
        assert (s_result = X"FFCDE385") report "Case 77 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"061ABE88";
        s_shift <= X"01";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 77;
        wait for cCLK_PER/2;
        assert (s_result = X"030D5F44") report "Case 78 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BC07EE0A";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 78;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFEF0") report "Case 79 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F44831E3";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 79;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFFF") report "Case 80 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"450D3DFA";
        s_shift <= X"07";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 80;
        wait for cCLK_PER/2;
        assert (s_result = X"008A1A7B") report "Case 81 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8DFD2320";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 81;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFE37") report "Case 82 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"227B5589";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 82;
        wait for cCLK_PER/2;
        assert (s_result = X"000113DA") report "Case 83 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F047FB41";
        s_shift <= X"0B";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 83;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFE08FF") report "Case 84 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E84CC520";
        s_shift <= X"0E";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 84;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFA133") report "Case 85 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"224198CC";
        s_shift <= X"0F";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 85;
        wait for cCLK_PER/2;
        assert (s_result = X"00004483") report "Case 86 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"3DB8F63C";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 86;
        wait for cCLK_PER/2;
        assert (s_result = X"000001ED") report "Case 87 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"9FD40C78";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 87;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFCFEA") report "Case 88 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"32A83002";
        s_shift <= X"13";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 88;
        wait for cCLK_PER/2;
        assert (s_result = X"00000655") report "Case 89 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B366955D";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 89;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFD9B34") report "Case 90 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"43CE2261";
        s_shift <= X"07";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 90;
        wait for cCLK_PER/2;
        assert (s_result = X"00879C44") report "Case 91 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"27CC84AA";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 91;
        wait for cCLK_PER/2;
        assert (s_result = X"00000013") report "Case 92 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"286CAA8B";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 92;
        wait for cCLK_PER/2;
        assert (s_result = X"00014365") report "Case 93 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7E61EAE5";
        s_shift <= X"10";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 93;
        wait for cCLK_PER/2;
        assert (s_result = X"00007E61") report "Case 94 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"446FE451";
        s_shift <= X"14";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 94;
        wait for cCLK_PER/2;
        assert (s_result = X"00000446") report "Case 95 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"89E8F5B1";
        s_shift <= X"00";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 95;
        wait for cCLK_PER/2;
        assert (s_result = X"89E8F5B1") report "Case 96 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"11174BE5";
        s_shift <= X"05";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 96;
        wait for cCLK_PER/2;
        assert (s_result = X"0088BA5F") report "Case 97 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"90F346A4";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 97;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFE43") report "Case 98 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"125D688B";
        s_shift <= X"14";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 98;
        wait for cCLK_PER/2;
        assert (s_result = X"00000125") report "Case 99 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"DDC8D785";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 99;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFFFF7") report "Case 100 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"02D44E88";
        s_shift <= X"04";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 100;
        wait for cCLK_PER/2;
        assert (s_result = X"002D44E8") report "Case 101 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F4B5C2CA";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 101;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFFA5AE") report "Case 102 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"643EFE98";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 102;
        wait for cCLK_PER/2;
        assert (s_result = X"190FBFA6") report "Case 103 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"263F701A";
        s_shift <= X"1C";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 103;
        wait for cCLK_PER/2;
        assert (s_result = X"00000002") report "Case 104 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E3917479";
        s_shift <= X"0B";
        s_left <= '0';
        s_sign_fill <= '1';
        s_case_number <= 104;
        wait for cCLK_PER/2;
        assert (s_result = X"FFFC722E") report "Case 105 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C3566829";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 105;
        wait for cCLK_PER/2;
        assert (s_result = X"0030D59A") report "Case 106 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"881642AF";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 106;
        wait for cCLK_PER/2;
        assert (s_result = X"00000220") report "Case 107 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D3C1BC99";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 107;
        wait for cCLK_PER/2;
        assert (s_result = X"0000069E") report "Case 108 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"26CE603E";
        s_shift <= X"17";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 108;
        wait for cCLK_PER/2;
        assert (s_result = X"0000004D") report "Case 109 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"35AD024D";
        s_shift <= X"18";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 109;
        wait for cCLK_PER/2;
        assert (s_result = X"00000035") report "Case 110 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A57AE1AE";
        s_shift <= X"05";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 110;
        wait for cCLK_PER/2;
        assert (s_result = X"052BD70D") report "Case 111 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C27A7D7F";
        s_shift <= X"0B";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 111;
        wait for cCLK_PER/2;
        assert (s_result = X"00184F4F") report "Case 112 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7B67CF98";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 112;
        wait for cCLK_PER/2;
        assert (s_result = X"000001ED") report "Case 113 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2A7A4858";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 113;
        wait for cCLK_PER/2;
        assert (s_result = X"0A9E9216") report "Case 114 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E52EBC3A";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 114;
        wait for cCLK_PER/2;
        assert (s_result = X"00000007") report "Case 115 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FA5623EE";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 115;
        wait for cCLK_PER/2;
        assert (s_result = X"00000001") report "Case 116 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"43D11C33";
        s_shift <= X"01";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 116;
        wait for cCLK_PER/2;
        assert (s_result = X"21E88E19") report "Case 117 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"997F3561";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 117;
        wait for cCLK_PER/2;
        assert (s_result = X"00000004") report "Case 118 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"78DEE313";
        s_shift <= X"00";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 118;
        wait for cCLK_PER/2;
        assert (s_result = X"78DEE313") report "Case 119 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B95A5DA6";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 119;
        wait for cCLK_PER/2;
        assert (s_result = X"2E569769") report "Case 120 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"0AB9004B";
        s_shift <= X"13";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 120;
        wait for cCLK_PER/2;
        assert (s_result = X"00000157") report "Case 121 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"51CF9FDD";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 121;
        wait for cCLK_PER/2;
        assert (s_result = X"00001473") report "Case 122 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"23B26A37";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 122;
        wait for cCLK_PER/2;
        assert (s_result = X"00000011") report "Case 123 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"1D707419";
        s_shift <= X"14";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 123;
        wait for cCLK_PER/2;
        assert (s_result = X"000001D7") report "Case 124 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"89737451";
        s_shift <= X"06";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 124;
        wait for cCLK_PER/2;
        assert (s_result = X"0225CDD1") report "Case 125 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"5A50E474";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 125;
        wait for cCLK_PER/2;
        assert (s_result = X"0000002D") report "Case 126 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"5102E4C5";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 126;
        wait for cCLK_PER/2;
        assert (s_result = X"00002881") report "Case 127 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6C7299F6";
        s_shift <= X"08";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 127;
        wait for cCLK_PER/2;
        assert (s_result = X"006C7299") report "Case 128 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"02043576";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 128;
        wait for cCLK_PER/2;
        assert (s_result = X"004086AE") report "Case 129 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C6108D59";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 129;
        wait for cCLK_PER/2;
        assert (s_result = X"31842356") report "Case 130 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E00556E9";
        s_shift <= X"0B";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 130;
        wait for cCLK_PER/2;
        assert (s_result = X"001C00AA") report "Case 131 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A596FE6D";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 131;
        wait for cCLK_PER/2;
        assert (s_result = X"2965BF9B") report "Case 132 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A0C1D48E";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 132;
        wait for cCLK_PER/2;
        assert (s_result = X"005060EA") report "Case 133 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C0E179E3";
        s_shift <= X"04";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 133;
        wait for cCLK_PER/2;
        assert (s_result = X"0C0E179E") report "Case 134 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"293A7008";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 134;
        wait for cCLK_PER/2;
        assert (s_result = X"05274E01") report "Case 135 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"11A30B73";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 135;
        wait for cCLK_PER/2;
        assert (s_result = X"00000008") report "Case 136 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BD99E00E";
        s_shift <= X"1B";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 136;
        wait for cCLK_PER/2;
        assert (s_result = X"00000017") report "Case 137 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"003BFEF1";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 137;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 138 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D58AB3AD";
        s_shift <= X"0F";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 138;
        wait for cCLK_PER/2;
        assert (s_result = X"0001AB15") report "Case 139 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"10189A60";
        s_shift <= X"1B";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 139;
        wait for cCLK_PER/2;
        assert (s_result = X"00000002") report "Case 140 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7EE73163";
        s_shift <= X"0F";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 140;
        wait for cCLK_PER/2;
        assert (s_result = X"0000FDCE") report "Case 141 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"AD0F1E69";
        s_shift <= X"18";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 141;
        wait for cCLK_PER/2;
        assert (s_result = X"000000AD") report "Case 142 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"53968C9F";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 142;
        wait for cCLK_PER/2;
        assert (s_result = X"00029CB4") report "Case 143 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7460C92B";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 143;
        wait for cCLK_PER/2;
        assert (s_result = X"00003A30") report "Case 144 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BFFECC40";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 144;
        wait for cCLK_PER/2;
        assert (s_result = X"00002FFF") report "Case 145 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6E098A67";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 145;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 146 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"9F82D779";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 146;
        wait for cCLK_PER/2;
        assert (s_result = X"000004FC") report "Case 147 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"232AA5EA";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 147;
        wait for cCLK_PER/2;
        assert (s_result = X"000008CA") report "Case 148 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"AEB8C727";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 148;
        wait for cCLK_PER/2;
        assert (s_result = X"00000005") report "Case 149 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"953886C5";
        s_shift <= X"10";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 149;
        wait for cCLK_PER/2;
        assert (s_result = X"00009538") report "Case 150 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"08EB68E9";
        s_shift <= X"10";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 150;
        wait for cCLK_PER/2;
        assert (s_result = X"000008EB") report "Case 151 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"CAE442B6";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 151;
        wait for cCLK_PER/2;
        assert (s_result = X"00000065") report "Case 152 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"3C3A921E";
        s_shift <= X"17";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 152;
        wait for cCLK_PER/2;
        assert (s_result = X"00000078") report "Case 153 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E4E136B6";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 153;
        wait for cCLK_PER/2;
        assert (s_result = X"00000001") report "Case 154 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"EA31312B";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 154;
        wait for cCLK_PER/2;
        assert (s_result = X"00000007") report "Case 155 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B5B68ABE";
        s_shift <= X"10";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 155;
        wait for cCLK_PER/2;
        assert (s_result = X"0000B5B6") report "Case 156 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8974B5E0";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 156;
        wait for cCLK_PER/2;
        assert (s_result = X"00044BA5") report "Case 157 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"589664E7";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 157;
        wait for cCLK_PER/2;
        assert (s_result = X"00162599") report "Case 158 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"317074C0";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 158;
        wait for cCLK_PER/2;
        assert (s_result = X"000000C5") report "Case 159 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D6289252";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 159;
        wait for cCLK_PER/2;
        assert (s_result = X"0000006B") report "Case 160 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"33C8FF9E";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 160;
        wait for cCLK_PER/2;
        assert (s_result = X"00000001") report "Case 161 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A444F81C";
        s_shift <= X"0E";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 161;
        wait for cCLK_PER/2;
        assert (s_result = X"00029113") report "Case 162 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"44C93A41";
        s_shift <= X"0A";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 162;
        wait for cCLK_PER/2;
        assert (s_result = X"0011324E") report "Case 163 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D86049EA";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 163;
        wait for cCLK_PER/2;
        assert (s_result = X"000006C3") report "Case 164 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"316F694E";
        s_shift <= X"17";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 164;
        wait for cCLK_PER/2;
        assert (s_result = X"00000062") report "Case 165 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"703BBE63";
        s_shift <= X"11";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 165;
        wait for cCLK_PER/2;
        assert (s_result = X"0000381D") report "Case 166 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FB1F774E";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 166;
        wait for cCLK_PER/2;
        assert (s_result = X"1F63EEE9") report "Case 167 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2D992CA5";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 167;
        wait for cCLK_PER/2;
        assert (s_result = X"000000B6") report "Case 168 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"762C2301";
        s_shift <= X"07";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 168;
        wait for cCLK_PER/2;
        assert (s_result = X"00EC5846") report "Case 169 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"3AEB2497";
        s_shift <= X"1E";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 169;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 170 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F7381157";
        s_shift <= X"19";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 170;
        wait for cCLK_PER/2;
        assert (s_result = X"0000007B") report "Case 171 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FF978A73";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 171;
        wait for cCLK_PER/2;
        assert (s_result = X"007FCBC5") report "Case 172 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B519E47F";
        s_shift <= X"18";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 172;
        wait for cCLK_PER/2;
        assert (s_result = X"000000B5") report "Case 173 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"33075600";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 173;
        wait for cCLK_PER/2;
        assert (s_result = X"00000001") report "Case 174 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"048CA456";
        s_shift <= X"07";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 174;
        wait for cCLK_PER/2;
        assert (s_result = X"00091948") report "Case 175 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8F8EF6DF";
        s_shift <= X"07";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 175;
        wait for cCLK_PER/2;
        assert (s_result = X"011F1DED") report "Case 176 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6EF0D88A";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 176;
        wait for cCLK_PER/2;
        assert (s_result = X"00037786") report "Case 177 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"93D5EC36";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 177;
        wait for cCLK_PER/2;
        assert (s_result = X"127ABD86") report "Case 178 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"44F8A43F";
        s_shift <= X"18";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 178;
        wait for cCLK_PER/2;
        assert (s_result = X"00000044") report "Case 179 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"4202268C";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 179;
        wait for cCLK_PER/2;
        assert (s_result = X"00021011") report "Case 180 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"749E2F35";
        s_shift <= X"06";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 180;
        wait for cCLK_PER/2;
        assert (s_result = X"01D278BC") report "Case 181 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"DBEFECFA";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 181;
        wait for cCLK_PER/2;
        assert (s_result = X"000006DF") report "Case 182 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"13C8503F";
        s_shift <= X"15";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 182;
        wait for cCLK_PER/2;
        assert (s_result = X"0000009E") report "Case 183 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A0039E0D";
        s_shift <= X"0C";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 183;
        wait for cCLK_PER/2;
        assert (s_result = X"000A0039") report "Case 184 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"17685E55";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 184;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 185 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BE7944C0";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 185;
        wait for cCLK_PER/2;
        assert (s_result = X"00000005") report "Case 186 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"86B0FD9C";
        s_shift <= X"09";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 186;
        wait for cCLK_PER/2;
        assert (s_result = X"0043587E") report "Case 187 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"73E5BD98";
        s_shift <= X"06";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 187;
        wait for cCLK_PER/2;
        assert (s_result = X"01CF96F6") report "Case 188 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"5666620C";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 188;
        wait for cCLK_PER/2;
        assert (s_result = X"00000015") report "Case 189 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"14AFB5E2";
        s_shift <= X"1D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 189;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 190 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"80D705A6";
        s_shift <= X"14";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 190;
        wait for cCLK_PER/2;
        assert (s_result = X"0000080D") report "Case 191 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C4B639CF";
        s_shift <= X"08";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 191;
        wait for cCLK_PER/2;
        assert (s_result = X"00C4B639") report "Case 192 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7666FF54";
        s_shift <= X"02";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 192;
        wait for cCLK_PER/2;
        assert (s_result = X"1D99BFD5") report "Case 193 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D9DCE667";
        s_shift <= X"00";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 193;
        wait for cCLK_PER/2;
        assert (s_result = X"D9DCE667") report "Case 194 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B47AE90C";
        s_shift <= X"0E";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 194;
        wait for cCLK_PER/2;
        assert (s_result = X"0002D1EB") report "Case 195 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"3FDBEB06";
        s_shift <= X"14";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 195;
        wait for cCLK_PER/2;
        assert (s_result = X"000003FD") report "Case 196 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"803C3B45";
        s_shift <= X"05";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 196;
        wait for cCLK_PER/2;
        assert (s_result = X"0401E1DA") report "Case 197 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B66D6ADE";
        s_shift <= X"03";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 197;
        wait for cCLK_PER/2;
        assert (s_result = X"16CDAD5B") report "Case 198 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D69A27DE";
        s_shift <= X"0E";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 198;
        wait for cCLK_PER/2;
        assert (s_result = X"00035A68") report "Case 199 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"1B51B198";
        s_shift <= X"1A";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 199;
        wait for cCLK_PER/2;
        assert (s_result = X"00000006") report "Case 200 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"91ED43DE";
        s_shift <= X"1F";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 200;
        wait for cCLK_PER/2;
        assert (s_result = X"00000001") report "Case 201 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"0C99A692";
        s_shift <= X"0D";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 201;
        wait for cCLK_PER/2;
        assert (s_result = X"000064CD") report "Case 202 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FD0E6C0C";
        s_shift <= X"12";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 202;
        wait for cCLK_PER/2;
        assert (s_result = X"00003F43") report "Case 203 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"1756D25D";
        s_shift <= X"08";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 203;
        wait for cCLK_PER/2;
        assert (s_result = X"001756D2") report "Case 204 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2895B00E";
        s_shift <= X"16";
        s_left <= '0';
        s_sign_fill <= '0';
        s_case_number <= 204;
        wait for cCLK_PER/2;
        assert (s_result = X"000000A2") report "Case 205 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D5017FD0";
        s_shift <= X"06";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 205;
        wait for cCLK_PER/2;
        assert (s_result = X"405FF400") report "Case 206 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2AC69A26";
        s_shift <= X"0B";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 206;
        wait for cCLK_PER/2;
        assert (s_result = X"34D13000") report "Case 207 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"53CE89BC";
        s_shift <= X"11";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 207;
        wait for cCLK_PER/2;
        assert (s_result = X"13780000") report "Case 208 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"26C81446";
        s_shift <= X"07";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 208;
        wait for cCLK_PER/2;
        assert (s_result = X"640A2300") report "Case 209 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"41B60050";
        s_shift <= X"17";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 209;
        wait for cCLK_PER/2;
        assert (s_result = X"28000000") report "Case 210 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"15749CB3";
        s_shift <= X"07";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 210;
        wait for cCLK_PER/2;
        assert (s_result = X"BA4E5980") report "Case 211 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8BDD5B8D";
        s_shift <= X"08";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 211;
        wait for cCLK_PER/2;
        assert (s_result = X"DD5B8D00") report "Case 212 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F7BC73EF";
        s_shift <= X"14";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 212;
        wait for cCLK_PER/2;
        assert (s_result = X"3EF00000") report "Case 213 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A58ACCBE";
        s_shift <= X"09";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 213;
        wait for cCLK_PER/2;
        assert (s_result = X"15997C00") report "Case 214 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2E895F36";
        s_shift <= X"0A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 214;
        wait for cCLK_PER/2;
        assert (s_result = X"257CD800") report "Case 215 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"26791EEF";
        s_shift <= X"1E";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 215;
        wait for cCLK_PER/2;
        assert (s_result = X"C0000000") report "Case 216 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"CAD26E84";
        s_shift <= X"13";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 216;
        wait for cCLK_PER/2;
        assert (s_result = X"74200000") report "Case 217 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BAC93A88";
        s_shift <= X"1C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 217;
        wait for cCLK_PER/2;
        assert (s_result = X"80000000") report "Case 218 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F337A23D";
        s_shift <= X"04";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 218;
        wait for cCLK_PER/2;
        assert (s_result = X"337A23D0") report "Case 219 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F90773DA";
        s_shift <= X"17";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 219;
        wait for cCLK_PER/2;
        assert (s_result = X"ED000000") report "Case 220 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"314C9A77";
        s_shift <= X"11";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 220;
        wait for cCLK_PER/2;
        assert (s_result = X"34EE0000") report "Case 221 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"62150E2A";
        s_shift <= X"06";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 221;
        wait for cCLK_PER/2;
        assert (s_result = X"85438A80") report "Case 222 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"86F921CE";
        s_shift <= X"0C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 222;
        wait for cCLK_PER/2;
        assert (s_result = X"921CE000") report "Case 223 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"AB3BA267";
        s_shift <= X"12";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 223;
        wait for cCLK_PER/2;
        assert (s_result = X"899C0000") report "Case 224 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"80B7C5D3";
        s_shift <= X"1E";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 224;
        wait for cCLK_PER/2;
        assert (s_result = X"C0000000") report "Case 225 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A8268B5B";
        s_shift <= X"15";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 225;
        wait for cCLK_PER/2;
        assert (s_result = X"6B600000") report "Case 226 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"3213E93F";
        s_shift <= X"10";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 226;
        wait for cCLK_PER/2;
        assert (s_result = X"E93F0000") report "Case 227 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FFDE374B";
        s_shift <= X"18";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 227;
        wait for cCLK_PER/2;
        assert (s_result = X"4B000000") report "Case 228 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2D7AFD49";
        s_shift <= X"14";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 228;
        wait for cCLK_PER/2;
        assert (s_result = X"D4900000") report "Case 229 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2CF96244";
        s_shift <= X"0F";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 229;
        wait for cCLK_PER/2;
        assert (s_result = X"B1220000") report "Case 230 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"45C0E76E";
        s_shift <= X"11";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 230;
        wait for cCLK_PER/2;
        assert (s_result = X"CEDC0000") report "Case 231 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"CEE3D0DE";
        s_shift <= X"00";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 231;
        wait for cCLK_PER/2;
        assert (s_result = X"CEE3D0DE") report "Case 232 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"DB8F238C";
        s_shift <= X"1B";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 232;
        wait for cCLK_PER/2;
        assert (s_result = X"60000000") report "Case 233 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B7FA8EE4";
        s_shift <= X"09";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 233;
        wait for cCLK_PER/2;
        assert (s_result = X"F51DC800") report "Case 234 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"570313AC";
        s_shift <= X"18";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 234;
        wait for cCLK_PER/2;
        assert (s_result = X"AC000000") report "Case 235 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"06968930";
        s_shift <= X"1C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 235;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 236 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8700AC2D";
        s_shift <= X"15";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 236;
        wait for cCLK_PER/2;
        assert (s_result = X"85A00000") report "Case 237 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2146D8E6";
        s_shift <= X"01";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 237;
        wait for cCLK_PER/2;
        assert (s_result = X"428DB1CC") report "Case 238 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"739CF3AB";
        s_shift <= X"15";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 238;
        wait for cCLK_PER/2;
        assert (s_result = X"75600000") report "Case 239 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F05ABB84";
        s_shift <= X"1C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 239;
        wait for cCLK_PER/2;
        assert (s_result = X"40000000") report "Case 240 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"CAE1EAB9";
        s_shift <= X"08";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 240;
        wait for cCLK_PER/2;
        assert (s_result = X"E1EAB900") report "Case 241 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7BF86595";
        s_shift <= X"11";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 241;
        wait for cCLK_PER/2;
        assert (s_result = X"CB2A0000") report "Case 242 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D2B7EC1D";
        s_shift <= X"18";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 242;
        wait for cCLK_PER/2;
        assert (s_result = X"1D000000") report "Case 243 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7251325E";
        s_shift <= X"08";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 243;
        wait for cCLK_PER/2;
        assert (s_result = X"51325E00") report "Case 244 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7799087D";
        s_shift <= X"15";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 244;
        wait for cCLK_PER/2;
        assert (s_result = X"0FA00000") report "Case 245 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B28824F5";
        s_shift <= X"1A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 245;
        wait for cCLK_PER/2;
        assert (s_result = X"D4000000") report "Case 246 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E6774099";
        s_shift <= X"12";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 246;
        wait for cCLK_PER/2;
        assert (s_result = X"02640000") report "Case 247 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"551BB676";
        s_shift <= X"19";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 247;
        wait for cCLK_PER/2;
        assert (s_result = X"EC000000") report "Case 248 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"55575451";
        s_shift <= X"1F";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 248;
        wait for cCLK_PER/2;
        assert (s_result = X"80000000") report "Case 249 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"153030FA";
        s_shift <= X"0A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 249;
        wait for cCLK_PER/2;
        assert (s_result = X"C0C3E800") report "Case 250 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"39612820";
        s_shift <= X"02";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 250;
        wait for cCLK_PER/2;
        assert (s_result = X"E584A080") report "Case 251 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"9523F625";
        s_shift <= X"1A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 251;
        wait for cCLK_PER/2;
        assert (s_result = X"94000000") report "Case 252 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"56644202";
        s_shift <= X"02";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 252;
        wait for cCLK_PER/2;
        assert (s_result = X"59910808") report "Case 253 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E19585F2";
        s_shift <= X"14";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 253;
        wait for cCLK_PER/2;
        assert (s_result = X"5F200000") report "Case 254 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"E0F28620";
        s_shift <= X"07";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 254;
        wait for cCLK_PER/2;
        assert (s_result = X"79431000") report "Case 255 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"66E03656";
        s_shift <= X"09";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 255;
        wait for cCLK_PER/2;
        assert (s_result = X"C06CAC00") report "Case 256 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"74339C49";
        s_shift <= X"17";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 256;
        wait for cCLK_PER/2;
        assert (s_result = X"24800000") report "Case 257 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2AE36E93";
        s_shift <= X"11";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 257;
        wait for cCLK_PER/2;
        assert (s_result = X"DD260000") report "Case 258 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"3581856F";
        s_shift <= X"10";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 258;
        wait for cCLK_PER/2;
        assert (s_result = X"856F0000") report "Case 259 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"9912DE0B";
        s_shift <= X"1A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 259;
        wait for cCLK_PER/2;
        assert (s_result = X"2C000000") report "Case 260 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"46FA0BE5";
        s_shift <= X"1D";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 260;
        wait for cCLK_PER/2;
        assert (s_result = X"A0000000") report "Case 261 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F287FF85";
        s_shift <= X"17";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 261;
        wait for cCLK_PER/2;
        assert (s_result = X"C2800000") report "Case 262 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"91F50662";
        s_shift <= X"13";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 262;
        wait for cCLK_PER/2;
        assert (s_result = X"33100000") report "Case 263 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D8BFA27B";
        s_shift <= X"12";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 263;
        wait for cCLK_PER/2;
        assert (s_result = X"89EC0000") report "Case 264 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"647C00B1";
        s_shift <= X"0E";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 264;
        wait for cCLK_PER/2;
        assert (s_result = X"002C4000") report "Case 265 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FE10D653";
        s_shift <= X"04";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 265;
        wait for cCLK_PER/2;
        assert (s_result = X"E10D6530") report "Case 266 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"EE5AFD0A";
        s_shift <= X"0F";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 266;
        wait for cCLK_PER/2;
        assert (s_result = X"7E850000") report "Case 267 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F1391BEB";
        s_shift <= X"16";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 267;
        wait for cCLK_PER/2;
        assert (s_result = X"FAC00000") report "Case 268 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"EC2179B3";
        s_shift <= X"18";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 268;
        wait for cCLK_PER/2;
        assert (s_result = X"B3000000") report "Case 269 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"B1F9B29B";
        s_shift <= X"1A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 269;
        wait for cCLK_PER/2;
        assert (s_result = X"6C000000") report "Case 270 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"575A2951";
        s_shift <= X"05";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 270;
        wait for cCLK_PER/2;
        assert (s_result = X"EB452A20") report "Case 271 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6ADF7EE8";
        s_shift <= X"02";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 271;
        wait for cCLK_PER/2;
        assert (s_result = X"AB7DFBA0") report "Case 272 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"0CE90811";
        s_shift <= X"13";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 272;
        wait for cCLK_PER/2;
        assert (s_result = X"40880000") report "Case 273 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7405489A";
        s_shift <= X"0A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 273;
        wait for cCLK_PER/2;
        assert (s_result = X"15226800") report "Case 274 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A4E9FDDF";
        s_shift <= X"0C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 274;
        wait for cCLK_PER/2;
        assert (s_result = X"9FDDF000") report "Case 275 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"501CEF11";
        s_shift <= X"07";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 275;
        wait for cCLK_PER/2;
        assert (s_result = X"0E778880") report "Case 276 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"094F8CD4";
        s_shift <= X"1C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 276;
        wait for cCLK_PER/2;
        assert (s_result = X"40000000") report "Case 277 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"9C7525C0";
        s_shift <= X"01";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 277;
        wait for cCLK_PER/2;
        assert (s_result = X"38EA4B80") report "Case 278 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"1A019AA2";
        s_shift <= X"19";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 278;
        wait for cCLK_PER/2;
        assert (s_result = X"44000000") report "Case 279 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BE3A9957";
        s_shift <= X"17";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 279;
        wait for cCLK_PER/2;
        assert (s_result = X"AB800000") report "Case 280 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"047592E3";
        s_shift <= X"05";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 280;
        wait for cCLK_PER/2;
        assert (s_result = X"8EB25C60") report "Case 281 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7BDCD1E9";
        s_shift <= X"1D";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 281;
        wait for cCLK_PER/2;
        assert (s_result = X"20000000") report "Case 282 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"6F92D8F1";
        s_shift <= X"1B";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 282;
        wait for cCLK_PER/2;
        assert (s_result = X"88000000") report "Case 283 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"C0CFBE05";
        s_shift <= X"0C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 283;
        wait for cCLK_PER/2;
        assert (s_result = X"FBE05000") report "Case 284 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"263CD33E";
        s_shift <= X"04";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 284;
        wait for cCLK_PER/2;
        assert (s_result = X"63CD33E0") report "Case 285 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"2086A040";
        s_shift <= X"11";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 285;
        wait for cCLK_PER/2;
        assert (s_result = X"40800000") report "Case 286 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"D34D1059";
        s_shift <= X"1A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 286;
        wait for cCLK_PER/2;
        assert (s_result = X"64000000") report "Case 287 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"BF3E430F";
        s_shift <= X"0B";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 287;
        wait for cCLK_PER/2;
        assert (s_result = X"F2187800") report "Case 288 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"FD21A13D";
        s_shift <= X"1A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 288;
        wait for cCLK_PER/2;
        assert (s_result = X"F4000000") report "Case 289 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"50424A6F";
        s_shift <= X"19";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 289;
        wait for cCLK_PER/2;
        assert (s_result = X"DE000000") report "Case 290 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"70224F1C";
        s_shift <= X"1D";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 290;
        wait for cCLK_PER/2;
        assert (s_result = X"80000000") report "Case 291 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"8A8D1E6A";
        s_shift <= X"17";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 291;
        wait for cCLK_PER/2;
        assert (s_result = X"35000000") report "Case 292 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"AE96D684";
        s_shift <= X"01";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 292;
        wait for cCLK_PER/2;
        assert (s_result = X"5D2DAD08") report "Case 293 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"124B9CD1";
        s_shift <= X"0B";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 293;
        wait for cCLK_PER/2;
        assert (s_result = X"5CE68800") report "Case 294 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7687FD41";
        s_shift <= X"0A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 294;
        wait for cCLK_PER/2;
        assert (s_result = X"1FF50400") report "Case 295 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"4FC4D9BB";
        s_shift <= X"07";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 295;
        wait for cCLK_PER/2;
        assert (s_result = X"E26CDD80") report "Case 296 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"84261677";
        s_shift <= X"1F";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 296;
        wait for cCLK_PER/2;
        assert (s_result = X"80000000") report "Case 297 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"A73085F2";
        s_shift <= X"0C";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 297;
        wait for cCLK_PER/2;
        assert (s_result = X"085F2000") report "Case 298 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"834A81E0";
        s_shift <= X"04";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 298;
        wait for cCLK_PER/2;
        assert (s_result = X"34A81E00") report "Case 299 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"7496E6A6";
        s_shift <= X"13";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 299;
        wait for cCLK_PER/2;
        assert (s_result = X"35300000") report "Case 300 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"0B417A06";
        s_shift <= X"1D";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 300;
        wait for cCLK_PER/2;
        assert (s_result = X"C0000000") report "Case 301 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"33E88AB0";
        s_shift <= X"1F";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 301;
        wait for cCLK_PER/2;
        assert (s_result = X"00000000") report "Case 302 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"F04A88D9";
        s_shift <= X"0D";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 302;
        wait for cCLK_PER/2;
        assert (s_result = X"511B2000") report "Case 303 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"27AC7888";
        s_shift <= X"0A";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 303;
        wait for cCLK_PER/2;
        assert (s_result = X"B1E22000") report "Case 304 failed" severity error;
        wait for cCLK_PER/2;

        s_operand <= X"726F370D";
        s_shift <= X"02";
        s_left <= '1';
        s_sign_fill <= '0';
        s_case_number <= 304;
        wait for cCLK_PER/2;
        assert (s_result = X"C9BCDC34") report "Case 305 failed" severity error;
        wait for cCLK_PER/2;

    end process;

end behavior;