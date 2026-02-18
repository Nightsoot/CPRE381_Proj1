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
s_PC <= X"608EB6BD";
s_imm <= X"509D98CD";
s_ALU_result <= X"FE927F9B";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"608EB6C1") report "Case 1 beq failed" severity error;

--Test Case 2:
s_PC <= X"B21FC7BF";
s_imm <= X"CA70DC0F";
s_ALU_result <= X"A72ABA57";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"B21FC7C3") report "Case 2 beq failed" severity error;

--Test Case 3:
s_PC <= X"C6742111";
s_imm <= X"AC45779A";
s_ALU_result <= X"3F1C5D0E";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"3F1C5D0E") report "Case 3 bne failed" severity error;

--Test Case 4:
s_PC <= X"848D0C75";
s_imm <= X"A74B1067";
s_ALU_result <= X"5F49FBB8";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"2BD81CDC") report "Case 4 blt failed" severity error;

--Test Case 5:
s_PC <= X"5445472E";
s_imm <= X"423C640E";
s_ALU_result <= X"25771901";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"25771901") report "Case 5 bge failed" severity error;

--Test Case 6:
s_PC <= X"DC7D30E4";
s_imm <= X"C62E2871";
s_ALU_result <= X"D51FEDC3";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"DC7D30E8") report "Case 6 bne failed" severity error;

--Test Case 7:
s_PC <= X"71287B3B";
s_imm <= X"89CE170C";
s_ALU_result <= X"DEDB38B6";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"71287B3F") report "Case 7 bgeu failed" severity error;

--Test Case 8:
s_PC <= X"B09CE900";
s_imm <= X"9B48283E";
s_ALU_result <= X"6EEDFF94";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"6EEDFF94") report "Case 8 bge failed" severity error;

--Test Case 9:
s_PC <= X"2D545D49";
s_imm <= X"7508B1B9";
s_ALU_result <= X"73ED26D1";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"73ED26D1") report "Case 9 bltu failed" severity error;

--Test Case 10:
s_PC <= X"E3C28DC6";
s_imm <= X"BC5922CD";
s_ALU_result <= X"69E86E2E";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"E3C28DCA") report "Case 10 blt failed" severity error;

--Test Case 11:
s_PC <= X"7CA5983F";
s_imm <= X"937AD734";
s_ALU_result <= X"7B2506D9";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"10206F73") report "Case 11 bne failed" severity error;

--Test Case 12:
s_PC <= X"68B1E0AC";
s_imm <= X"8B3F081E";
s_ALU_result <= X"196305D4";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"196305D4") report "Case 12 bltu failed" severity error;

--Test Case 13:
s_PC <= X"E07FF2A6";
s_imm <= X"A42A40F9";
s_ALU_result <= X"7813DAA8";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"84AA339F") report "Case 13 blt failed" severity error;

--Test Case 14:
s_PC <= X"36478685";
s_imm <= X"B8980C27";
s_ALU_result <= X"4C087904";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"36478689") report "Case 14 bne failed" severity error;

--Test Case 15:
s_PC <= X"79A3C8FE";
s_imm <= X"594D1E62";
s_ALU_result <= X"8BDC636E";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D2F0E760") report "Case 15 blt failed" severity error;

--Test Case 16:
s_PC <= X"61DC141B";
s_imm <= X"18D80BB0";
s_ALU_result <= X"4961C31F";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"61DC141F") report "Case 16 bgeu failed" severity error;

--Test Case 17:
s_PC <= X"0D201B19";
s_imm <= X"8A10AAAB";
s_ALU_result <= X"AC456938";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"9730C5C4") report "Case 17 bgeu failed" severity error;

--Test Case 18:
s_PC <= X"5A65F7AD";
s_imm <= X"6BA2F9BD";
s_ALU_result <= X"0EA88001";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"5A65F7B1") report "Case 18 bne failed" severity error;

--Test Case 19:
s_PC <= X"51659BD5";
s_imm <= X"B8C340DD";
s_ALU_result <= X"602B4333";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"51659BD9") report "Case 19 bgeu failed" severity error;

--Test Case 20:
s_PC <= X"F30F518E";
s_imm <= X"DD8D0172";
s_ALU_result <= X"87C7F5ED";
s_PC_source <= X"3";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"F30F5192") report "Case 20 bge failed" severity error;

--Test Case 21:
s_PC <= X"40FB3CEF";
s_imm <= X"89F3B8F2";
s_ALU_result <= X"21CDBFBA";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"21CDBFBA") report "Case 21 bgeu failed" severity error;

--Test Case 22:
s_PC <= X"5A3363AE";
s_imm <= X"12E8A56A";
s_ALU_result <= X"ED31ECD0";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"5A3363B2") report "Case 22 bge failed" severity error;

--Test Case 23:
s_PC <= X"2421ECF5";
s_imm <= X"AC0B5930";
s_ALU_result <= X"CBBFE260";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"2421ECF9") report "Case 23 beq failed" severity error;

--Test Case 24:
s_PC <= X"41AC30FA";
s_imm <= X"6010686B";
s_ALU_result <= X"DDAC30ED";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"A1BC9965") report "Case 24 beq failed" severity error;

--Test Case 25:
s_PC <= X"0235B239";
s_imm <= X"440CF724";
s_ALU_result <= X"0191BDBB";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"0191BDBB") report "Case 25 beq failed" severity error;

--Test Case 26:
s_PC <= X"4B196D7D";
s_imm <= X"8409ECEE";
s_ALU_result <= X"7A04B353";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"4B196D81") report "Case 26 bltu failed" severity error;

--Test Case 27:
s_PC <= X"B315B4F0";
s_imm <= X"6642CC2F";
s_ALU_result <= X"0758E8D5";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"1958811F") report "Case 27 blt failed" severity error;

--Test Case 28:
s_PC <= X"3361802F";
s_imm <= X"962F203A";
s_ALU_result <= X"71D92F74";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"33618033") report "Case 28 bgeu failed" severity error;

--Test Case 29:
s_PC <= X"B2064C97";
s_imm <= X"F7F69DFE";
s_ALU_result <= X"88B9E50E";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"B2064C9B") report "Case 29 beq failed" severity error;

--Test Case 30:
s_PC <= X"3E2ECB3D";
s_imm <= X"AF45482B";
s_ALU_result <= X"E10E383E";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"ED741368") report "Case 30 bgeu failed" severity error;

--Test Case 31:
s_PC <= X"A90AC12D";
s_imm <= X"A8003824";
s_ALU_result <= X"78965814";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"A90AC131") report "Case 31 bne failed" severity error;

--Test Case 32:
s_PC <= X"31C7A097";
s_imm <= X"B4C32F8A";
s_ALU_result <= X"89417E86";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"89417E86") report "Case 32 bge failed" severity error;

--Test Case 33:
s_PC <= X"C428A028";
s_imm <= X"6A3CD752";
s_ALU_result <= X"33773888";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C428A02C") report "Case 33 bgeu failed" severity error;

--Test Case 34:
s_PC <= X"A5ACE6D5";
s_imm <= X"3D1458EE";
s_ALU_result <= X"57AACD7F";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"A5ACE6D9") report "Case 34 bge failed" severity error;

--Test Case 35:
s_PC <= X"09F51F2A";
s_imm <= X"D6122C31";
s_ALU_result <= X"D5C77A4D";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D5C77A4D") report "Case 35 bge failed" severity error;

--Test Case 36:
s_PC <= X"87A69DC2";
s_imm <= X"B9FB692E";
s_ALU_result <= X"C2A240B4";
s_PC_source <= X"3";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"41A206F0") report "Case 36 bltu failed" severity error;

--Test Case 37:
s_PC <= X"48790E92";
s_imm <= X"43BCCDEF";
s_ALU_result <= X"333FBB1F";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"333FBB1F") report "Case 37 bge failed" severity error;

--Test Case 38:
s_PC <= X"717042E7";
s_imm <= X"A6CA17D2";
s_ALU_result <= X"D15EE4FD";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"717042EB") report "Case 38 blt failed" severity error;

--Test Case 39:
s_PC <= X"7E2188BF";
s_imm <= X"6789C413";
s_ALU_result <= X"9F080F08";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"7E2188C3") report "Case 39 blt failed" severity error;

--Test Case 40:
s_PC <= X"A1847405";
s_imm <= X"86DF2814";
s_ALU_result <= X"8FAF7F54";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"8FAF7F54") report "Case 40 blt failed" severity error;

--Test Case 41:
s_PC <= X"57F8F5CC";
s_imm <= X"F086406C";
s_ALU_result <= X"D073BB22";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D073BB22") report "Case 41 bne failed" severity error;

--Test Case 42:
s_PC <= X"C3304374";
s_imm <= X"A4DFDED3";
s_ALU_result <= X"EE405A15";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C3304378") report "Case 42 bltu failed" severity error;

--Test Case 43:
s_PC <= X"9167CD05";
s_imm <= X"E82F43DD";
s_ALU_result <= X"6BD399EA";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"799710E2") report "Case 43 beq failed" severity error;

--Test Case 44:
s_PC <= X"E157876A";
s_imm <= X"6E72AE58";
s_ALU_result <= X"A17F98E1";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"E157876E") report "Case 44 beq failed" severity error;

--Test Case 45:
s_PC <= X"EAF1A914";
s_imm <= X"CFC5E9F3";
s_ALU_result <= X"C3E87CDD";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"C3E87CDD") report "Case 45 bltu failed" severity error;

--Test Case 46:
s_PC <= X"2D63A4DD";
s_imm <= X"8C9DA319";
s_ALU_result <= X"BABD5A09";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"2D63A4E1") report "Case 46 bne failed" severity error;

--Test Case 47:
s_PC <= X"C28B98CF";
s_imm <= X"BD839EB1";
s_ALU_result <= X"081C3ACD";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"081C3ACD") report "Case 47 bltu failed" severity error;

--Test Case 48:
s_PC <= X"0CBB3380";
s_imm <= X"E8116C05";
s_ALU_result <= X"180574C7";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"0CBB3384") report "Case 48 beq failed" severity error;

--Test Case 49:
s_PC <= X"87AB6602";
s_imm <= X"8C15C1AB";
s_ALU_result <= X"A32CD0CA";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"87AB6606") report "Case 49 beq failed" severity error;

--Test Case 50:
s_PC <= X"F8C66604";
s_imm <= X"1E2A7142";
s_ALU_result <= X"07A75DBC";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"F8C66608") report "Case 50 bne failed" severity error;

--Test Case 51:
s_PC <= X"B4B11794";
s_imm <= X"8F427E48";
s_ALU_result <= X"904AABB1";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"B4B11798") report "Case 51 bne failed" severity error;

--Test Case 52:
s_PC <= X"832DA5F0";
s_imm <= X"1EEFBDDD";
s_ALU_result <= X"CD0D1C13";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"CD0D1C13") report "Case 52 blt failed" severity error;

--Test Case 53:
s_PC <= X"D7CBAEF9";
s_imm <= X"00E38513";
s_ALU_result <= X"5E2A6CD0";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D8AF340C") report "Case 53 bne failed" severity error;

--Test Case 54:
s_PC <= X"95548350";
s_imm <= X"6DC6A5F6";
s_ALU_result <= X"AABC6EBB";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"95548354") report "Case 54 bgeu failed" severity error;

--Test Case 55:
s_PC <= X"97AEE191";
s_imm <= X"A9FAB777";
s_ALU_result <= X"DDCD108D";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"97AEE195") report "Case 55 bge failed" severity error;

--Test Case 56:
s_PC <= X"ADFF2DE2";
s_imm <= X"8712BB7F";
s_ALU_result <= X"DF19C7F7";
s_PC_source <= X"3";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"3511E961") report "Case 56 bltu failed" severity error;

--Test Case 57:
s_PC <= X"A4EFEF9F";
s_imm <= X"6D2A2009";
s_ALU_result <= X"ABCA8DC4";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"ABCA8DC4") report "Case 57 bne failed" severity error;

--Test Case 58:
s_PC <= X"50AE8768";
s_imm <= X"3F3D26F3";
s_ALU_result <= X"20A3C588";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"50AE876C") report "Case 58 bltu failed" severity error;

--Test Case 59:
s_PC <= X"9EF89A9F";
s_imm <= X"E1D09EAF";
s_ALU_result <= X"1142A2F8";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"80C9394E") report "Case 59 bge failed" severity error;

--Test Case 60:
s_PC <= X"5742E3E5";
s_imm <= X"03DD3E9D";
s_ALU_result <= X"5AB2E9D5";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"5742E3E9") report "Case 60 bgeu failed" severity error;

--Test Case 61:
s_PC <= X"2AF45FA7";
s_imm <= X"619DC080";
s_ALU_result <= X"C22F1272";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"2AF45FAB") report "Case 61 beq failed" severity error;

--Test Case 62:
s_PC <= X"4529B738";
s_imm <= X"607AB8EA";
s_ALU_result <= X"46D81669";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"4529B73C") report "Case 62 bne failed" severity error;

--Test Case 63:
s_PC <= X"6475D284";
s_imm <= X"B90C9E77";
s_ALU_result <= X"8D339109";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"1D8270FB") report "Case 63 bge failed" severity error;

--Test Case 64:
s_PC <= X"B2416817";
s_imm <= X"52A4B427";
s_ALU_result <= X"B3607F23";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"04E61C3E") report "Case 64 beq failed" severity error;

--Test Case 65:
s_PC <= X"EA34EA90";
s_imm <= X"B41384E6";
s_ALU_result <= X"A7B46BAE";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"9E486F76") report "Case 65 beq failed" severity error;

--Test Case 66:
s_PC <= X"D5AFFD1A";
s_imm <= X"170BF16A";
s_ALU_result <= X"B7ED1C1B";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"ECBBEE84") report "Case 66 beq failed" severity error;

--Test Case 67:
s_PC <= X"CD7371B0";
s_imm <= X"12D71B05";
s_ALU_result <= X"D751EAE9";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"CD7371B4") report "Case 67 beq failed" severity error;

--Test Case 68:
s_PC <= X"0863DCEB";
s_imm <= X"CFD7C9B0";
s_ALU_result <= X"1DF57825";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"D83BA69B") report "Case 68 bne failed" severity error;

--Test Case 69:
s_PC <= X"CCF24577";
s_imm <= X"F9CB9FCB";
s_ALU_result <= X"1D79913D";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"CCF2457B") report "Case 69 bgeu failed" severity error;

--Test Case 70:
s_PC <= X"D7C406AA";
s_imm <= X"4E01491B";
s_ALU_result <= X"54F0098C";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"D7C406AE") report "Case 70 beq failed" severity error;

--Test Case 71:
s_PC <= X"44EB867D";
s_imm <= X"293753B7";
s_ALU_result <= X"A36CAEAC";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"44EB8681") report "Case 71 bltu failed" severity error;

--Test Case 72:
s_PC <= X"EE82F90B";
s_imm <= X"7F28DADE";
s_ALU_result <= X"A55E43E3";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"6DABD3E9") report "Case 72 bgeu failed" severity error;

--Test Case 73:
s_PC <= X"1A676D83";
s_imm <= X"47002AED";
s_ALU_result <= X"5267239D";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"1A676D87") report "Case 73 bltu failed" severity error;

--Test Case 74:
s_PC <= X"889216D3";
s_imm <= X"0936206E";
s_ALU_result <= X"3D1A1EB6";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"91C83741") report "Case 74 bgeu failed" severity error;

--Test Case 75:
s_PC <= X"CE076BA7";
s_imm <= X"4D79320D";
s_ALU_result <= X"A2404088";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"CE076BAB") report "Case 75 bne failed" severity error;

--Test Case 76:
s_PC <= X"CB4DA02F";
s_imm <= X"313DC2E5";
s_ALU_result <= X"872245D0";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"CB4DA033") report "Case 76 bne failed" severity error;

--Test Case 77:
s_PC <= X"D6DB7C7C";
s_imm <= X"0CA1D8DE";
s_ALU_result <= X"88E92AEF";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"E37D555A") report "Case 77 blt failed" severity error;

--Test Case 78:
s_PC <= X"59056FFB";
s_imm <= X"188DB30E";
s_ALU_result <= X"D7A2750B";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"59056FFF") report "Case 78 bge failed" severity error;

--Test Case 79:
s_PC <= X"928C3CDE";
s_imm <= X"B8059D9C";
s_ALU_result <= X"DF7E7B4B";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"928C3CE2") report "Case 79 bge failed" severity error;

--Test Case 80:
s_PC <= X"01462A5A";
s_imm <= X"ABE361D2";
s_ALU_result <= X"2E59357F";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"AD298C2C") report "Case 80 bge failed" severity error;

--Test Case 81:
s_PC <= X"1D06EEA2";
s_imm <= X"20CFEFE7";
s_ALU_result <= X"A20A4316";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"3DD6DE89") report "Case 81 blt failed" severity error;

--Test Case 82:
s_PC <= X"D4A43FC4";
s_imm <= X"6223C9E3";
s_ALU_result <= X"59F61E99";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"36C809A7") report "Case 82 bgeu failed" severity error;

--Test Case 83:
s_PC <= X"F08F44F8";
s_imm <= X"6A225B45";
s_ALU_result <= X"C9FE676C";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"5AB1A03D") report "Case 83 bgeu failed" severity error;

--Test Case 84:
s_PC <= X"C4D7E0B7";
s_imm <= X"EEC8248A";
s_ALU_result <= X"8335BF3D";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"8335BF3D") report "Case 84 bltu failed" severity error;

--Test Case 85:
s_PC <= X"F145BEC4";
s_imm <= X"135A7968";
s_ALU_result <= X"35FAD881";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"04A0382C") report "Case 85 bne failed" severity error;

--Test Case 86:
s_PC <= X"FC3E045F";
s_imm <= X"74EB9AD8";
s_ALU_result <= X"2DFAB521";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"FC3E0463") report "Case 86 bne failed" severity error;

--Test Case 87:
s_PC <= X"E7B7F562";
s_imm <= X"B534A9B7";
s_ALU_result <= X"02EA5DB8";
s_PC_source <= X"0";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"E7B7F566") report "Case 87 blt failed" severity error;

--Test Case 88:
s_PC <= X"54A9648F";
s_imm <= X"1278BAFC";
s_ALU_result <= X"D51BE12C";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"54A96493") report "Case 88 bgeu failed" severity error;

--Test Case 89:
s_PC <= X"6A69C407";
s_imm <= X"1D25F1F1";
s_ALU_result <= X"9FB54213";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"9FB54213") report "Case 89 bne failed" severity error;

--Test Case 90:
s_PC <= X"06121B8D";
s_imm <= X"58B88825";
s_ALU_result <= X"9BA48CA5";
s_PC_source <= X"3";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"5ECAA3B2") report "Case 90 bltu failed" severity error;

--Test Case 91:
s_PC <= X"0BC4DB9C";
s_imm <= X"950E4904";
s_ALU_result <= X"4B77A893";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"0BC4DBA0") report "Case 91 blt failed" severity error;

--Test Case 92:
s_PC <= X"AD9721B7";
s_imm <= X"B854A597";
s_ALU_result <= X"A46B1564";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"65EBC74E") report "Case 92 beq failed" severity error;

--Test Case 93:
s_PC <= X"41074FB6";
s_imm <= X"7753ADB6";
s_ALU_result <= X"2BF0AF4D";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"41074FBA") report "Case 93 bltu failed" severity error;

--Test Case 94:
s_PC <= X"CBA1EB9A";
s_imm <= X"A75143CC";
s_ALU_result <= X"C86F305B";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"CBA1EB9E") report "Case 94 beq failed" severity error;

--Test Case 95:
s_PC <= X"93027BB9";
s_imm <= X"74D86818";
s_ALU_result <= X"A810EC06";
s_PC_source <= X"3";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"93027BBD") report "Case 95 bge failed" severity error;

--Test Case 96:
s_PC <= X"8707D728";
s_imm <= X"9CC00208";
s_ALU_result <= X"DCD0535D";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"8707D72C") report "Case 96 bge failed" severity error;

--Test Case 97:
s_PC <= X"6BEF0A35";
s_imm <= X"B184D268";
s_ALU_result <= X"4D7F602C";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"6BEF0A39") report "Case 97 blt failed" severity error;

--Test Case 98:
s_PC <= X"E5C0AEF5";
s_imm <= X"DD4FBDCD";
s_ALU_result <= X"22F307C1";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"C3106CC2") report "Case 98 bne failed" severity error;

--Test Case 99:
s_PC <= X"248C44A7";
s_imm <= X"29425726";
s_ALU_result <= X"B05ACB97";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
wait for cCLK_PER;
assert (s_new_PC = X"248C44AB") report "Case 99 bge failed" severity error;

--Test Case 100:
s_PC <= X"FEBEA240";
s_imm <= X"E81F2CDA";
s_ALU_result <= X"0EAB3C81";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
wait for cCLK_PER;
assert (s_new_PC = X"E6DDCF1A") report "Case 100 bge failed" severity error;




        wait;
    end process;
end behavior;