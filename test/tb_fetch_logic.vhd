-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_fetch_logic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- fetch logic
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
entity tb_fetch_logic is
    generic (gCLK_HPER : time := 50 ns);
end tb_fetch_logic;

architecture behavior of tb_fetch_logic is
    constant cCLK_PER : time := gCLK_HPER * 2;
    component fetch_logic
        port(
            i_CLK : in std_logic;
            i_RST : in std_logic;
            --"old" PC value
            i_PC : in std_logic_vector(31 downto 0);
            i_imm : in std_logic_vector(31 downto 0);
            --used for register relative addressing
            i_ALU_result : in std_logic_vector(31 downto 0);
            --control signals
            i_PC_source : in std_logic_vector(1 downto 0);
            i_comparison : in std_logic_vector(2 downto 0);
            --comaprison flags
            i_zero : in std_logic;
            i_negative : in std_logic;
            i_carry : in std_logic;
            i_overflow : in std_logic;
            --new PC used by the program memory
            o_new_PC : out std_logic_vector(31 downto 0)
        );
        end component;

        signal s_CLK, s_RST, s_zero, s_negative, s_carry, s_overflow : std_logic;
        signal s_PC_source, s_comparison : std_logic_vector(3 downto 0);
        signal s_comparison_real : std_logic_vector(2 downto 0);
        signal s_PC_source_real : std_logic_vector(1 downto 0);
        signal s_PC, s_imm, s_ALU_result, s_new_PC : std_logic_vector(31 downto 0);



begin

    DUT : fetch_logic
    port MAP(
        i_CLK => s_CLK,
        i_RST => s_RST,
        i_PC => s_PC,
        i_imm => s_imm,
        i_ALU_result => s_ALU_result,
        i_PC_source => s_PC_source_real,
        i_comparison => s_comparison_real,
        i_zero => s_zero,
        i_negative => s_negative,
        i_carry => s_carry,
        i_overflow => s_overflow,
        o_new_PC => s_new_PC
    );

    s_PC_source_real <= s_PC_source(1 downto 0);
    s_comparison_real <= s_comparison(2 downto 0);

    P_CLK : process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    P_TB : process
    begin
        s_RST <= '1';
        wait for cCLK_PER;
        s_RST <= '0';

--Test Case 1:
s_PC <= X"CBA0E76D";
s_imm <= X"C728E38E";
s_ALU_result <= X"6CEC2D46";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"CBA0E771") report "Case 1 bgeu failed" severity error;

--Test Case 2:
s_PC <= X"7D7BE7F1";
s_imm <= X"8939A292";
s_ALU_result <= X"D749B289";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"06B58A83") report "Case 2 blt failed" severity error;

--Test Case 3:
s_PC <= X"67C3A6FE";
s_imm <= X"EC204204";
s_ALU_result <= X"F99513D0";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"F99513D0") report "Case 3 beq failed" severity error;

--Test Case 4:
s_PC <= X"2DAB521A";
s_imm <= X"9FFEFCBC";
s_ALU_result <= X"9B7B0595";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"2DAB521E") report "Case 4 bltu failed" severity error;

--Test Case 5:
s_PC <= X"6A9DC546";
s_imm <= X"DBC779E3";
s_ALU_result <= X"67FA7282";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"6A9DC54A") report "Case 5 beq failed" severity error;

--Test Case 6:
s_PC <= X"6037ED45";
s_imm <= X"4DA29FC7";
s_ALU_result <= X"D38ADB02";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D38ADB02") report "Case 6 blt failed" severity error;

--Test Case 7:
s_PC <= X"867AF602";
s_imm <= X"9A130668";
s_ALU_result <= X"D016243D";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D016243D") report "Case 7 bltu failed" severity error;

--Test Case 8:
s_PC <= X"E0449FB6";
s_imm <= X"DE9F36B4";
s_ALU_result <= X"C389BCE6";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C389BCE6") report "Case 8 blt failed" severity error;

--Test Case 9:
s_PC <= X"A91E7560";
s_imm <= X"6BE14B5E";
s_ALU_result <= X"DC69B9A9";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"A91E7564") report "Case 9 blt failed" severity error;

--Test Case 10:
s_PC <= X"B7A3AEF6";
s_imm <= X"4DA31762";
s_ALU_result <= X"08D55A4B";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"08D55A4B") report "Case 10 bge failed" severity error;

--Test Case 11:
s_PC <= X"CB0BD5BA";
s_imm <= X"41A6F853";
s_ALU_result <= X"BCB4AD34";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"CB0BD5BE") report "Case 11 bgeu failed" severity error;

--Test Case 12:
s_PC <= X"FD5E2A32";
s_imm <= X"420D4C03";
s_ALU_result <= X"CCE639F2";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"FD5E2A36") report "Case 12 bltu failed" severity error;

--Test Case 13:
s_PC <= X"38459430";
s_imm <= X"225BA6CD";
s_ALU_result <= X"5AF7158A";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"38459434") report "Case 13 bltu failed" severity error;

--Test Case 14:
s_PC <= X"BA037202";
s_imm <= X"28F4590C";
s_ALU_result <= X"4632F250";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"4632F250") report "Case 14 blt failed" severity error;

--Test Case 15:
s_PC <= X"C9A78365";
s_imm <= X"8F37E62E";
s_ALU_result <= X"E5C425F5";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C9A78369") report "Case 15 beq failed" severity error;

--Test Case 16:
s_PC <= X"DC288F19";
s_imm <= X"BA567F5B";
s_ALU_result <= X"84A8DA53";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"DC288F1D") report "Case 16 bgeu failed" severity error;

--Test Case 17:
s_PC <= X"372F36E9";
s_imm <= X"E3EA5875";
s_ALU_result <= X"A261D729";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"A261D729") report "Case 17 bne failed" severity error;

--Test Case 18:
s_PC <= X"FC897C44";
s_imm <= X"20AB3DE7";
s_ALU_result <= X"5C8B28C8";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"5C8B28C8") report "Case 18 bge failed" severity error;

--Test Case 19:
s_PC <= X"09581BEC";
s_imm <= X"C2610721";
s_ALU_result <= X"392D1035";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"09581BF0") report "Case 19 bltu failed" severity error;

--Test Case 20:
s_PC <= X"9A6CED53";
s_imm <= X"A21937B5";
s_ALU_result <= X"58D50F4F";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"58D50F4F") report "Case 20 bne failed" severity error;

--Test Case 21:
s_PC <= X"4ED4E8F9";
s_imm <= X"8302B3F7";
s_ALU_result <= X"3D733276";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"4ED4E8FD") report "Case 21 bgeu failed" severity error;

--Test Case 22:
s_PC <= X"0743BA73";
s_imm <= X"1AB6E6E9";
s_ALU_result <= X"F3BFC818";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"0743BA77") report "Case 22 bne failed" severity error;

--Test Case 23:
s_PC <= X"38A8B0A5";
s_imm <= X"92218E62";
s_ALU_result <= X"76242C32";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"38A8B0A9") report "Case 23 bne failed" severity error;

--Test Case 24:
s_PC <= X"93B123CB";
s_imm <= X"2D01F1F4";
s_ALU_result <= X"6221AACF";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"6221AACF") report "Case 24 bltu failed" severity error;

--Test Case 25:
s_PC <= X"F689E965";
s_imm <= X"86B19199";
s_ALU_result <= X"F4E2A183";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"F689E969") report "Case 25 bltu failed" severity error;

--Test Case 26:
s_PC <= X"77715FF5";
s_imm <= X"FD7C51DE";
s_ALU_result <= X"902E7C1B";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"902E7C1B") report "Case 26 blt failed" severity error;

--Test Case 27:
s_PC <= X"2F3FAD48";
s_imm <= X"80441D78";
s_ALU_result <= X"7914439C";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"AF83CAC0") report "Case 27 bltu failed" severity error;

--Test Case 28:
s_PC <= X"DA978F18";
s_imm <= X"9DEC69C6";
s_ALU_result <= X"39E61BDA";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"39E61BDA") report "Case 28 bgeu failed" severity error;

--Test Case 29:
s_PC <= X"154DE12B";
s_imm <= X"C61257DB";
s_ALU_result <= X"4DB13247";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"154DE12F") report "Case 29 bge failed" severity error;

--Test Case 30:
s_PC <= X"6E168B73";
s_imm <= X"940368FF";
s_ALU_result <= X"F721BA42";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"6E168B77") report "Case 30 bge failed" severity error;

--Test Case 31:
s_PC <= X"88516D09";
s_imm <= X"C37A0F0C";
s_ALU_result <= X"54C45C2C";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"54C45C2C") report "Case 31 bgeu failed" severity error;

--Test Case 32:
s_PC <= X"BB27816A";
s_imm <= X"409AAF98";
s_ALU_result <= X"62C7D8F6";
s_PC_source <= X"0";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"BB27816E") report "Case 32 blt failed" severity error;

--Test Case 33:
s_PC <= X"69BE9C58";
s_imm <= X"5ECB8F43";
s_ALU_result <= X"D9194474";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"69BE9C5C") report "Case 33 bltu failed" severity error;

--Test Case 34:
s_PC <= X"163DDD71";
s_imm <= X"B6BE62EA";
s_ALU_result <= X"3BD9432F";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"163DDD75") report "Case 34 bne failed" severity error;

--Test Case 35:
s_PC <= X"C2584FDF";
s_imm <= X"1AA54997";
s_ALU_result <= X"512F83CB";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C2584FE3") report "Case 35 bltu failed" severity error;

--Test Case 36:
s_PC <= X"C8F4B610";
s_imm <= X"4309B6CB";
s_ALU_result <= X"27E109FD";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C8F4B614") report "Case 36 beq failed" severity error;

--Test Case 37:
s_PC <= X"6B2DACD3";
s_imm <= X"3493AFA6";
s_ALU_result <= X"BF5EB213";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"BF5EB213") report "Case 37 blt failed" severity error;

--Test Case 38:
s_PC <= X"2C38C87D";
s_imm <= X"A5DF9082";
s_ALU_result <= X"C821BCDA";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"2C38C881") report "Case 38 bltu failed" severity error;

--Test Case 39:
s_PC <= X"FDA06CCB";
s_imm <= X"F3F5D527";
s_ALU_result <= X"BF5E64C3";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"BF5E64C3") report "Case 39 blt failed" severity error;

--Test Case 40:
s_PC <= X"FE2470C0";
s_imm <= X"977E980E";
s_ALU_result <= X"16F6D9EE";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"95A308CE") report "Case 40 beq failed" severity error;

--Test Case 41:
s_PC <= X"1E16ABCB";
s_imm <= X"A3895110";
s_ALU_result <= X"911BC973";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"911BC973") report "Case 41 beq failed" severity error;

--Test Case 42:
s_PC <= X"30D9531F";
s_imm <= X"36C5AFF5";
s_ALU_result <= X"05054D60";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"30D95323") report "Case 42 beq failed" severity error;

--Test Case 43:
s_PC <= X"3A6C8801";
s_imm <= X"8E3DC215";
s_ALU_result <= X"EB72EA17";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"EB72EA17") report "Case 43 bge failed" severity error;

--Test Case 44:
s_PC <= X"AF6726F0";
s_imm <= X"B024B0FF";
s_ALU_result <= X"6BA6C0EF";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"5F8BD7EF") report "Case 44 bne failed" severity error;

--Test Case 45:
s_PC <= X"E12CF567";
s_imm <= X"75F3EE83";
s_ALU_result <= X"1F84A165";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"5720E3EA") report "Case 45 beq failed" severity error;

--Test Case 46:
s_PC <= X"E9D9827D";
s_imm <= X"CA178BDC";
s_ALU_result <= X"9C867D16";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"9C867D16") report "Case 46 bgeu failed" severity error;

--Test Case 47:
s_PC <= X"2C4F0C81";
s_imm <= X"D88B2AB4";
s_ALU_result <= X"2B341554";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"2B341554") report "Case 47 blt failed" severity error;

--Test Case 48:
s_PC <= X"438184C7";
s_imm <= X"1F584231";
s_ALU_result <= X"6E47D2A8";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"6E47D2A8") report "Case 48 bgeu failed" severity error;

--Test Case 49:
s_PC <= X"050A5448";
s_imm <= X"A1A4A46B";
s_ALU_result <= X"5AC38B30";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"5AC38B30") report "Case 49 bltu failed" severity error;

--Test Case 50:
s_PC <= X"1E1461E5";
s_imm <= X"591DE0C2";
s_ALU_result <= X"32BEFC2C";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"32BEFC2C") report "Case 50 bltu failed" severity error;

--Test Case 51:
s_PC <= X"182DD967";
s_imm <= X"6506325C";
s_ALU_result <= X"DC3855D3";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"182DD96B") report "Case 51 bge failed" severity error;

--Test Case 52:
s_PC <= X"FBFE787D";
s_imm <= X"A9C57A2A";
s_ALU_result <= X"8D715BFF";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"FBFE7881") report "Case 52 bgeu failed" severity error;

--Test Case 53:
s_PC <= X"2CE3BDE1";
s_imm <= X"A818C128";
s_ALU_result <= X"05221CEB";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"D4FC7F09") report "Case 53 bgeu failed" severity error;

--Test Case 54:
s_PC <= X"A902E561";
s_imm <= X"BF22DD22";
s_ALU_result <= X"A84E84BF";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"A902E565") report "Case 54 bne failed" severity error;

--Test Case 55:
s_PC <= X"A0E8BF06";
s_imm <= X"955CE4DA";
s_ALU_result <= X"22387D74";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"3645A3E0") report "Case 55 beq failed" severity error;

--Test Case 56:
s_PC <= X"97F4256A";
s_imm <= X"1DD04168";
s_ALU_result <= X"0CBA5326";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"97F4256E") report "Case 56 bgeu failed" severity error;

--Test Case 57:
s_PC <= X"DEF289F8";
s_imm <= X"BFD220D8";
s_ALU_result <= X"A132583C";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"DEF289FC") report "Case 57 bltu failed" severity error;

--Test Case 58:
s_PC <= X"572E120F";
s_imm <= X"5772EECC";
s_ALU_result <= X"1A6EF5F5";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"572E1213") report "Case 58 bgeu failed" severity error;

--Test Case 59:
s_PC <= X"C8C5D81A";
s_imm <= X"A3421FEA";
s_ALU_result <= X"48CD5C3A";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C8C5D81E") report "Case 59 bgeu failed" severity error;

--Test Case 60:
s_PC <= X"3D34B161";
s_imm <= X"1E500556";
s_ALU_result <= X"03D34DCB";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"3D34B165") report "Case 60 bgeu failed" severity error;

--Test Case 61:
s_PC <= X"F46DDE95";
s_imm <= X"3A0F8DD0";
s_ALU_result <= X"82407040";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"82407040") report "Case 61 bltu failed" severity error;

--Test Case 62:
s_PC <= X"1DECC961";
s_imm <= X"4EA9AC1E";
s_ALU_result <= X"2D7CAD79";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"6C96757F") report "Case 62 beq failed" severity error;

--Test Case 63:
s_PC <= X"366F11B4";
s_imm <= X"31A7A0BC";
s_ALU_result <= X"2C9685F6";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"366F11B8") report "Case 63 bgeu failed" severity error;

--Test Case 64:
s_PC <= X"F03BBF98";
s_imm <= X"A9152B5A";
s_ALU_result <= X"1341C3BE";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"F03BBF9C") report "Case 64 bge failed" severity error;

--Test Case 65:
s_PC <= X"3E7652DA";
s_imm <= X"4919DA11";
s_ALU_result <= X"41DCA739";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"41DCA739") report "Case 65 bgeu failed" severity error;

--Test Case 66:
s_PC <= X"B4C6A644";
s_imm <= X"0FC084E0";
s_ALU_result <= X"A1D680A5";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"A1D680A5") report "Case 66 bltu failed" severity error;

--Test Case 67:
s_PC <= X"595CB553";
s_imm <= X"77A72AA0";
s_ALU_result <= X"A200CDFD";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D103DFF3") report "Case 67 bltu failed" severity error;

--Test Case 68:
s_PC <= X"DD711990";
s_imm <= X"17A7FE23";
s_ALU_result <= X"DD2FC4AE";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"DD2FC4AE") report "Case 68 bne failed" severity error;

--Test Case 69:
s_PC <= X"CDC87D9D";
s_imm <= X"AC31464C";
s_ALU_result <= X"C32D79E1";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"CDC87DA1") report "Case 69 bne failed" severity error;

--Test Case 70:
s_PC <= X"56233C05";
s_imm <= X"A4CB1761";
s_ALU_result <= X"4D6B274C";
s_PC_source <= X"0";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"56233C09") report "Case 70 blt failed" severity error;

--Test Case 71:
s_PC <= X"62B12F27";
s_imm <= X"AB74D265";
s_ALU_result <= X"C19CF8F3";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C19CF8F3") report "Case 71 blt failed" severity error;

--Test Case 72:
s_PC <= X"883FFD5D";
s_imm <= X"CD92320C";
s_ALU_result <= X"F732DD22";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"883FFD61") report "Case 72 bne failed" severity error;

--Test Case 73:
s_PC <= X"210E423C";
s_imm <= X"93018298";
s_ALU_result <= X"41B5C03F";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"B40FC4D4") report "Case 73 blt failed" severity error;

--Test Case 74:
s_PC <= X"89F12B6F";
s_imm <= X"B6D8A15C";
s_ALU_result <= X"CC5E922E";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"89F12B73") report "Case 74 bltu failed" severity error;

--Test Case 75:
s_PC <= X"AD634064";
s_imm <= X"B5DB83F2";
s_ALU_result <= X"EB0F8A71";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"AD634068") report "Case 75 bltu failed" severity error;

--Test Case 76:
s_PC <= X"E4390EAB";
s_imm <= X"7DFEEAB0";
s_ALU_result <= X"C4BE3865";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"E4390EAF") report "Case 76 bltu failed" severity error;

--Test Case 77:
s_PC <= X"95959BA9";
s_imm <= X"46D49BA8";
s_ALU_result <= X"947053DA";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"DC6A3751") report "Case 77 beq failed" severity error;

--Test Case 78:
s_PC <= X"6CC12755";
s_imm <= X"E259B65D";
s_ALU_result <= X"C2641AAE";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"6CC12759") report "Case 78 bne failed" severity error;

--Test Case 79:
s_PC <= X"719F982C";
s_imm <= X"481BEB4A";
s_ALU_result <= X"31761662";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"B9BB8376") report "Case 79 beq failed" severity error;

--Test Case 80:
s_PC <= X"C8FA3166";
s_imm <= X"B59413AB";
s_ALU_result <= X"58BAF95C";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"7E8E4511") report "Case 80 bne failed" severity error;

--Test Case 81:
s_PC <= X"866DF531";
s_imm <= X"50B79CEF";
s_ALU_result <= X"BD90C2A5";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"866DF535") report "Case 81 bgeu failed" severity error;

--Test Case 82:
s_PC <= X"80276415";
s_imm <= X"8A176563";
s_ALU_result <= X"994726F9";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"80276419") report "Case 82 bge failed" severity error;

--Test Case 83:
s_PC <= X"69F53992";
s_imm <= X"99632A62";
s_ALU_result <= X"795F0143";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"035863F4") report "Case 83 bne failed" severity error;

--Test Case 84:
s_PC <= X"0CBC390C";
s_imm <= X"616306A7";
s_ALU_result <= X"95A22403";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"0CBC3910") report "Case 84 beq failed" severity error;

--Test Case 85:
s_PC <= X"BF885D9F";
s_imm <= X"98404ED7";
s_ALU_result <= X"7D318AB5";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"57C8AC76") report "Case 85 bne failed" severity error;

--Test Case 86:
s_PC <= X"CA48567E";
s_imm <= X"272D18E6";
s_ALU_result <= X"0332E5FF";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"CA485682") report "Case 86 bltu failed" severity error;

--Test Case 87:
s_PC <= X"8E07D872";
s_imm <= X"264C621B";
s_ALU_result <= X"25CB26B4";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"8E07D876") report "Case 87 bltu failed" severity error;

--Test Case 88:
s_PC <= X"A3693A72";
s_imm <= X"1124A0B1";
s_ALU_result <= X"4F5F07C2";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"A3693A76") report "Case 88 bgeu failed" severity error;

--Test Case 89:
s_PC <= X"73411538";
s_imm <= X"D42C6AC8";
s_ALU_result <= X"563DED10";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"7341153C") report "Case 89 bgeu failed" severity error;

--Test Case 90:
s_PC <= X"2E4E21AC";
s_imm <= X"DB41DEE3";
s_ALU_result <= X"A575F94D";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"2E4E21B0") report "Case 90 bltu failed" severity error;

--Test Case 91:
s_PC <= X"8469BA65";
s_imm <= X"BAB7B410";
s_ALU_result <= X"945BE9BF";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"8469BA69") report "Case 91 blt failed" severity error;

--Test Case 92:
s_PC <= X"884FDBCA";
s_imm <= X"DD2A3F58";
s_ALU_result <= X"3DD59767";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"3DD59767") report "Case 92 beq failed" severity error;

--Test Case 93:
s_PC <= X"BD696B86";
s_imm <= X"E2D1C787";
s_ALU_result <= X"160A6EC0";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"160A6EC0") report "Case 93 bgeu failed" severity error;

--Test Case 94:
s_PC <= X"CBEE1603";
s_imm <= X"5E04D7C6";
s_ALU_result <= X"0FD6558D";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"0FD6558D") report "Case 94 bge failed" severity error;

--Test Case 95:
s_PC <= X"8D2DFC29";
s_imm <= X"D793EABE";
s_ALU_result <= X"DD40707D";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"DD40707D") report "Case 95 bgeu failed" severity error;

--Test Case 96:
s_PC <= X"D4006DC1";
s_imm <= X"381023E4";
s_ALU_result <= X"1E4B5B17";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"D4006DC5") report "Case 96 bne failed" severity error;

--Test Case 97:
s_PC <= X"5EB12B19";
s_imm <= X"B8A9F6DE";
s_ALU_result <= X"61030277";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"175B21F7") report "Case 97 beq failed" severity error;

--Test Case 98:
s_PC <= X"8589E791";
s_imm <= X"20DA5D82";
s_ALU_result <= X"5967AC29";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"5967AC29") report "Case 98 beq failed" severity error;

--Test Case 99:
s_PC <= X"96775EAC";
s_imm <= X"A405C55D";
s_ALU_result <= X"36813DD8";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"36813DD8") report "Case 99 bne failed" severity error;

--Test Case 100:
s_PC <= X"07337F60";
s_imm <= X"9B6B44AA";
s_ALU_result <= X"1E3D9C0B";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"1E3D9C0B") report "Case 100 bge failed" severity error;



        wait;
    end process;
end behavior;