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
wait for cCLK_PER;
s_PC <= X"2013847E";
s_imm <= X"762D038C";
s_ALU_result <= X"BA3D1181";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"9640880A") report "Case 1 bltu failed" severity error;

--Test Case 2:
wait for cCLK_PER;
s_PC <= X"DD7B76D8";
s_imm <= X"A7EEB5B1";
s_ALU_result <= X"6C95AC4B";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"856A2C89") report "Case 2 beq failed" severity error;

--Test Case 3:
wait for cCLK_PER;
s_PC <= X"54DBCB59";
s_imm <= X"EFC048E5";
s_ALU_result <= X"F390F68D";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"54DBCB5D") report "Case 3 beq failed" severity error;

--Test Case 4:
wait for cCLK_PER;
s_PC <= X"DF6EAC57";
s_imm <= X"4901EC91";
s_ALU_result <= X"B07CEACD";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"B07CEACD") report "Case 4 blt failed" severity error;

--Test Case 5:
wait for cCLK_PER;
s_PC <= X"627A2B60";
s_imm <= X"57813996";
s_ALU_result <= X"051948F4";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"627A2B64") report "Case 5 bgeu failed" severity error;

--Test Case 6:
wait for cCLK_PER;
s_PC <= X"E6C3CB41";
s_imm <= X"85554618";
s_ALU_result <= X"0F0743DC";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"E6C3CB45") report "Case 6 bge failed" severity error;

--Test Case 7:
wait for cCLK_PER;
s_PC <= X"9BC9587B";
s_imm <= X"40E4147B";
s_ALU_result <= X"14D8E425";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"14D8E425") report "Case 7 beq failed" severity error;

--Test Case 8:
wait for cCLK_PER;
s_PC <= X"C9CBE413";
s_imm <= X"1531B46C";
s_ALU_result <= X"98BD437A";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"C9CBE417") report "Case 8 bge failed" severity error;

--Test Case 9:
wait for cCLK_PER;
s_PC <= X"113E1F2A";
s_imm <= X"E1ADBE61";
s_ALU_result <= X"08D08078";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"08D08078") report "Case 9 beq failed" severity error;

--Test Case 10:
wait for cCLK_PER;
s_PC <= X"02B38DC9";
s_imm <= X"3EBDEBD6";
s_ALU_result <= X"76A63A4E";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"02B38DCD") report "Case 10 bltu failed" severity error;

--Test Case 11:
wait for cCLK_PER;
s_PC <= X"CF22D9FF";
s_imm <= X"BF35235D";
s_ALU_result <= X"A8E366C6";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"8E57FD5C") report "Case 11 bne failed" severity error;

--Test Case 12:
wait for cCLK_PER;
s_PC <= X"ABBF4E94";
s_imm <= X"4A4CF2A4";
s_ALU_result <= X"9D246B1C";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"ABBF4E98") report "Case 12 blt failed" severity error;

--Test Case 13:
wait for cCLK_PER;
s_PC <= X"7B6092AA";
s_imm <= X"585151D5";
s_ALU_result <= X"D3258B3D";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"D3B1E47F") report "Case 13 blt failed" severity error;

--Test Case 14:
wait for cCLK_PER;
s_PC <= X"C9480827";
s_imm <= X"7E2B892D";
s_ALU_result <= X"A7215E9E";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"47739154") report "Case 14 blt failed" severity error;

--Test Case 15:
wait for cCLK_PER;
s_PC <= X"D08B6B01";
s_imm <= X"2348214E";
s_ALU_result <= X"96275DB6";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"96275DB6") report "Case 15 blt failed" severity error;

--Test Case 16:
wait for cCLK_PER;
s_PC <= X"AAC6BEAA";
s_imm <= X"E61CD9D7";
s_ALU_result <= X"0EE2EF9D";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"AAC6BEAE") report "Case 16 beq failed" severity error;

--Test Case 17:
wait for cCLK_PER;
s_PC <= X"3B41DA4C";
s_imm <= X"2BE26C0A";
s_ALU_result <= X"8A6E124C";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"3B41DA50") report "Case 17 bltu failed" severity error;

--Test Case 18:
wait for cCLK_PER;
s_PC <= X"5E5617DE";
s_imm <= X"B61DD097";
s_ALU_result <= X"B3190F59";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"1473E875") report "Case 18 bne failed" severity error;

--Test Case 19:
wait for cCLK_PER;
s_PC <= X"474C5720";
s_imm <= X"727E3A25";
s_ALU_result <= X"82305254";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"474C5724") report "Case 19 bltu failed" severity error;

--Test Case 20:
wait for cCLK_PER;
s_PC <= X"D4AE3F56";
s_imm <= X"8B7835A9";
s_ALU_result <= X"ABA8915A";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"602674FF") report "Case 20 beq failed" severity error;

--Test Case 21:
wait for cCLK_PER;
s_PC <= X"C2384DE6";
s_imm <= X"A5DA5CB3";
s_ALU_result <= X"06E73545";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"C2384DEA") report "Case 21 bgeu failed" severity error;

--Test Case 22:
wait for cCLK_PER;
s_PC <= X"DB330BF2";
s_imm <= X"B4A222BA";
s_ALU_result <= X"94799EAC";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"DB330BF6") report "Case 22 blt failed" severity error;

--Test Case 23:
wait for cCLK_PER;
s_PC <= X"2A4B5419";
s_imm <= X"8A88C374";
s_ALU_result <= X"C5A6D68E";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"B4D4178D") report "Case 23 beq failed" severity error;

--Test Case 24:
wait for cCLK_PER;
s_PC <= X"6098943F";
s_imm <= X"BC3D5B15";
s_ALU_result <= X"E5ADFFAE";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"E5ADFFAE") report "Case 24 bltu failed" severity error;

--Test Case 25:
wait for cCLK_PER;
s_PC <= X"50B47E57";
s_imm <= X"3265A586";
s_ALU_result <= X"E14352C3";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"831A23DD") report "Case 25 bgeu failed" severity error;

--Test Case 26:
wait for cCLK_PER;
s_PC <= X"E162C245";
s_imm <= X"8A3B39B1";
s_ALU_result <= X"9CC2110D";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"9CC2110D") report "Case 26 bne failed" severity error;

--Test Case 27:
wait for cCLK_PER;
s_PC <= X"79BB7446";
s_imm <= X"79D80B9A";
s_ALU_result <= X"5CE65104";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"79BB744A") report "Case 27 bgeu failed" severity error;

--Test Case 28:
wait for cCLK_PER;
s_PC <= X"54B94005";
s_imm <= X"C684E1C7";
s_ALU_result <= X"D5240041";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"1B3E21CC") report "Case 28 bne failed" severity error;

--Test Case 29:
wait for cCLK_PER;
s_PC <= X"50E15AA9";
s_imm <= X"98A046AC";
s_ALU_result <= X"1D2F595E";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"50E15AAD") report "Case 29 bgeu failed" severity error;

--Test Case 30:
wait for cCLK_PER;
s_PC <= X"46443B64";
s_imm <= X"5298276D";
s_ALU_result <= X"69D90776";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"46443B68") report "Case 30 bltu failed" severity error;

--Test Case 31:
wait for cCLK_PER;
s_PC <= X"A730ECB2";
s_imm <= X"166A021E";
s_ALU_result <= X"196316C6";
s_PC_source <= X"3";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"BD9AEED0") report "Case 31 bge failed" severity error;

--Test Case 32:
wait for cCLK_PER;
s_PC <= X"9CB2BA66";
s_imm <= X"E63AF5AB";
s_ALU_result <= X"C195ABA4";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"9CB2BA6A") report "Case 32 blt failed" severity error;

--Test Case 33:
wait for cCLK_PER;
s_PC <= X"6068D1D9";
s_imm <= X"27CD0874";
s_ALU_result <= X"2BC227E3";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"6068D1DD") report "Case 33 bge failed" severity error;

--Test Case 34:
wait for cCLK_PER;
s_PC <= X"A887B425";
s_imm <= X"BB14E430";
s_ALU_result <= X"ED1B3C68";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"ED1B3C68") report "Case 34 bne failed" severity error;

--Test Case 35:
wait for cCLK_PER;
s_PC <= X"3D47BEF2";
s_imm <= X"6DB49EFA";
s_ALU_result <= X"BCD1BC16";
s_PC_source <= X"3";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"AAFC5DEC") report "Case 35 bge failed" severity error;

--Test Case 36:
wait for cCLK_PER;
s_PC <= X"C5472FC3";
s_imm <= X"AB73ABCA";
s_ALU_result <= X"A27808D2";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"C5472FC7") report "Case 36 blt failed" severity error;

--Test Case 37:
wait for cCLK_PER;
s_PC <= X"0A9E2580";
s_imm <= X"5AC105C3";
s_ALU_result <= X"3F0AA118";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"3F0AA118") report "Case 37 bltu failed" severity error;

--Test Case 38:
wait for cCLK_PER;
s_PC <= X"08A6704B";
s_imm <= X"60B070AF";
s_ALU_result <= X"7B825018";
s_PC_source <= X"3";
s_comparison <= X"3";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"6956E0FA") report "Case 38 bge failed" severity error;

--Test Case 39:
wait for cCLK_PER;
s_PC <= X"CD7BD10B";
s_imm <= X"A48F0134";
s_ALU_result <= X"CB49D0CA";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"CD7BD10F") report "Case 39 bltu failed" severity error;

--Test Case 40:
wait for cCLK_PER;
s_PC <= X"BA61CF69";
s_imm <= X"1724BED4";
s_ALU_result <= X"829A7257";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"D1868E3D") report "Case 40 bne failed" severity error;

--Test Case 41:
wait for cCLK_PER;
s_PC <= X"1F061DBC";
s_imm <= X"C73B7EB1";
s_ALU_result <= X"0249934F";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"0249934F") report "Case 41 bgeu failed" severity error;

--Test Case 42:
wait for cCLK_PER;
s_PC <= X"75DEB351";
s_imm <= X"1ACFB7EA";
s_ALU_result <= X"96924B7F";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"75DEB355") report "Case 42 beq failed" severity error;

--Test Case 43:
wait for cCLK_PER;
s_PC <= X"F85CDF56";
s_imm <= X"A244D0AF";
s_ALU_result <= X"CCA4B568";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"F85CDF5A") report "Case 43 bne failed" severity error;

--Test Case 44:
wait for cCLK_PER;
s_PC <= X"D94BB149";
s_imm <= X"476C0500";
s_ALU_result <= X"6540EDE0";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"D94BB14D") report "Case 44 bne failed" severity error;

--Test Case 45:
wait for cCLK_PER;
s_PC <= X"748B4761";
s_imm <= X"D1D5B6A1";
s_ALU_result <= X"4216FF05";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"4216FF05") report "Case 45 blt failed" severity error;

--Test Case 46:
wait for cCLK_PER;
s_PC <= X"2828B762";
s_imm <= X"291BDB2B";
s_ALU_result <= X"A169930D";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"2828B766") report "Case 46 beq failed" severity error;

--Test Case 47:
wait for cCLK_PER;
s_PC <= X"4575EECF";
s_imm <= X"9D3067EA";
s_ALU_result <= X"72A8D509";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"E2A656B9") report "Case 47 blt failed" severity error;

--Test Case 48:
wait for cCLK_PER;
s_PC <= X"C45931F0";
s_imm <= X"70A64BED";
s_ALU_result <= X"FE2E9E0D";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"C45931F4") report "Case 48 bge failed" severity error;

--Test Case 49:
wait for cCLK_PER;
s_PC <= X"F5747F74";
s_imm <= X"191F42F8";
s_ALU_result <= X"F24C666D";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"F5747F78") report "Case 49 bltu failed" severity error;

--Test Case 50:
wait for cCLK_PER;
s_PC <= X"ED8A24FF";
s_imm <= X"0A91585E";
s_ALU_result <= X"77766503";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"F81B7D5D") report "Case 50 blt failed" severity error;

--Test Case 51:
wait for cCLK_PER;
s_PC <= X"70D245A4";
s_imm <= X"A5630B8D";
s_ALU_result <= X"5D492728";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"5D492728") report "Case 51 bne failed" severity error;

--Test Case 52:
wait for cCLK_PER;
s_PC <= X"64A89AEE";
s_imm <= X"A10F368F";
s_ALU_result <= X"CCADAC5E";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"CCADAC5E") report "Case 52 bne failed" severity error;

--Test Case 53:
wait for cCLK_PER;
s_PC <= X"A3EEDF79";
s_imm <= X"5A044480";
s_ALU_result <= X"87E27329";
s_PC_source <= X"3";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"FDF323F9") report "Case 53 bltu failed" severity error;

--Test Case 54:
wait for cCLK_PER;
s_PC <= X"42681EFC";
s_imm <= X"709DBDC7";
s_ALU_result <= X"2A8DE256";
s_PC_source <= X"0";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"42681F00") report "Case 54 blt failed" severity error;

--Test Case 55:
wait for cCLK_PER;
s_PC <= X"6AAF0751";
s_imm <= X"7CED473C";
s_ALU_result <= X"9CB46601";
s_PC_source <= X"1";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"6AAF0755") report "Case 55 bge failed" severity error;

--Test Case 56:
wait for cCLK_PER;
s_PC <= X"855B3511";
s_imm <= X"F7B5FD4C";
s_ALU_result <= X"C0587756";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"C0587756") report "Case 56 bltu failed" severity error;

--Test Case 57:
wait for cCLK_PER;
s_PC <= X"E8DA4121";
s_imm <= X"0EA3B06C";
s_ALU_result <= X"7F5E1062";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"E8DA4125") report "Case 57 bltu failed" severity error;

--Test Case 58:
wait for cCLK_PER;
s_PC <= X"FF1906C6";
s_imm <= X"75F65B42";
s_ALU_result <= X"B00A3456";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"B00A3456") report "Case 58 blt failed" severity error;

--Test Case 59:
wait for cCLK_PER;
s_PC <= X"4E31A46B";
s_imm <= X"B245C2C9";
s_ALU_result <= X"0D99580C";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"4E31A46F") report "Case 59 beq failed" severity error;

--Test Case 60:
wait for cCLK_PER;
s_PC <= X"02247832";
s_imm <= X"37FDD13A";
s_ALU_result <= X"4AF0D448";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"4AF0D448") report "Case 60 bgeu failed" severity error;

--Test Case 61:
wait for cCLK_PER;
s_PC <= X"44C8E14E";
s_imm <= X"BAA6C9E2";
s_ALU_result <= X"F207EBA1";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"44C8E152") report "Case 61 bne failed" severity error;

--Test Case 62:
wait for cCLK_PER;
s_PC <= X"338971CC";
s_imm <= X"62073F3F";
s_ALU_result <= X"33D4F961";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"9590B10B") report "Case 62 blt failed" severity error;

--Test Case 63:
wait for cCLK_PER;
s_PC <= X"84093838";
s_imm <= X"69A2818E";
s_ALU_result <= X"C2A07EF2";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"EDABB9C6") report "Case 63 bne failed" severity error;

--Test Case 64:
wait for cCLK_PER;
s_PC <= X"F9F38037";
s_imm <= X"6A1FFE76";
s_ALU_result <= X"FBB65F0C";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"64137EAD") report "Case 64 blt failed" severity error;

--Test Case 65:
wait for cCLK_PER;
s_PC <= X"78BAC679";
s_imm <= X"D82ABD8E";
s_ALU_result <= X"C4C98C97";
s_PC_source <= X"1";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"50E58407") report "Case 65 bltu failed" severity error;

--Test Case 66:
wait for cCLK_PER;
s_PC <= X"4919A2D5";
s_imm <= X"B093A697";
s_ALU_result <= X"FF38742A";
s_PC_source <= X"0";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"4919A2D9") report "Case 66 beq failed" severity error;

--Test Case 67:
wait for cCLK_PER;
s_PC <= X"0FAF0E20";
s_imm <= X"C9927908";
s_ALU_result <= X"D111A5F9";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"D9418728") report "Case 67 bne failed" severity error;

--Test Case 68:
wait for cCLK_PER;
s_PC <= X"EF572075";
s_imm <= X"3CDD6D43";
s_ALU_result <= X"583C6506";
s_PC_source <= X"2";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"583C6506") report "Case 68 bgeu failed" severity error;

--Test Case 69:
wait for cCLK_PER;
s_PC <= X"6569A3C8";
s_imm <= X"E9D30F6D";
s_ALU_result <= X"C0996D65";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"6569A3CC") report "Case 69 beq failed" severity error;

--Test Case 70:
wait for cCLK_PER;
s_PC <= X"3E944CD7";
s_imm <= X"9645CB37";
s_ALU_result <= X"E4C70B38";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"3E944CDB") report "Case 70 bge failed" severity error;

--Test Case 71:
wait for cCLK_PER;
s_PC <= X"D13C515D";
s_imm <= X"321D1B58";
s_ALU_result <= X"604EB46E";
s_PC_source <= X"3";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"03596CB5") report "Case 71 bltu failed" severity error;

--Test Case 72:
wait for cCLK_PER;
s_PC <= X"38CF6557";
s_imm <= X"5FC1CA6D";
s_ALU_result <= X"11BD3B8C";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"98912FC4") report "Case 72 beq failed" severity error;

--Test Case 73:
wait for cCLK_PER;
s_PC <= X"742C05BF";
s_imm <= X"04985FFC";
s_ALU_result <= X"6790CB76";
s_PC_source <= X"0";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"742C05C3") report "Case 73 bltu failed" severity error;

--Test Case 74:
wait for cCLK_PER;
s_PC <= X"3EF97A3E";
s_imm <= X"6DDA782A";
s_ALU_result <= X"0C529851";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"3EF97A42") report "Case 74 beq failed" severity error;

--Test Case 75:
wait for cCLK_PER;
s_PC <= X"C6B1EE70";
s_imm <= X"9CF9401E";
s_ALU_result <= X"6D74546A";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"C6B1EE74") report "Case 75 bgeu failed" severity error;

--Test Case 76:
wait for cCLK_PER;
s_PC <= X"45C238EB";
s_imm <= X"4D3B2A38";
s_ALU_result <= X"6C7117B2";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"45C238EF") report "Case 76 bgeu failed" severity error;

--Test Case 77:
wait for cCLK_PER;
s_PC <= X"007DAA4B";
s_imm <= X"C11D5122";
s_ALU_result <= X"05CE8F98";
s_PC_source <= X"3";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"C19AFB6D") report "Case 77 blt failed" severity error;

--Test Case 78:
wait for cCLK_PER;
s_PC <= X"00C79165";
s_imm <= X"DF4B6CF4";
s_ALU_result <= X"C2D09875";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"00C79169") report "Case 78 bne failed" severity error;

--Test Case 79:
wait for cCLK_PER;
s_PC <= X"5CD69EE5";
s_imm <= X"0A2C68BF";
s_ALU_result <= X"69AFFE38";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"69AFFE38") report "Case 79 blt failed" severity error;

--Test Case 80:
wait for cCLK_PER;
s_PC <= X"DE83CDD2";
s_imm <= X"39F4A96B";
s_ALU_result <= X"E3599130";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"E3599130") report "Case 80 bltu failed" severity error;

--Test Case 81:
wait for cCLK_PER;
s_PC <= X"FE616C15";
s_imm <= X"47587E7F";
s_ALU_result <= X"58AEA93B";
s_PC_source <= X"3";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"FE616C19") report "Case 81 bne failed" severity error;

--Test Case 82:
wait for cCLK_PER;
s_PC <= X"D2A703D4";
s_imm <= X"A7B50059";
s_ALU_result <= X"73FFEE97";
s_PC_source <= X"2";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"73FFEE97") report "Case 82 bge failed" severity error;

--Test Case 83:
wait for cCLK_PER;
s_PC <= X"4433EF2C";
s_imm <= X"A0899A07";
s_ALU_result <= X"2B078948";
s_PC_source <= X"0";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"4433EF30") report "Case 83 bgeu failed" severity error;

--Test Case 84:
wait for cCLK_PER;
s_PC <= X"E2C9645D";
s_imm <= X"EA19B4CD";
s_ALU_result <= X"6AEEBADD";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"6AEEBADD") report "Case 84 bltu failed" severity error;

--Test Case 85:
wait for cCLK_PER;
s_PC <= X"7C2EB1FF";
s_imm <= X"98DB33E2";
s_ALU_result <= X"5FA9E39B";
s_PC_source <= X"0";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"7C2EB203") report "Case 85 bne failed" severity error;

--Test Case 86:
wait for cCLK_PER;
s_PC <= X"F70B5C9C";
s_imm <= X"4A310E6B";
s_ALU_result <= X"6F3D44C9";
s_PC_source <= X"0";
s_comparison <= X"3";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"F70B5CA0") report "Case 86 bge failed" severity error;

--Test Case 87:
wait for cCLK_PER;
s_PC <= X"491A78CF";
s_imm <= X"1F0C39D8";
s_ALU_result <= X"432C518E";
s_PC_source <= X"1";
s_comparison <= X"2";
s_zero <= '1';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"6826B2A7") report "Case 87 blt failed" severity error;

--Test Case 88:
wait for cCLK_PER;
s_PC <= X"D0C24B56";
s_imm <= X"E0FB39F2";
s_ALU_result <= X"4DC12278";
s_PC_source <= X"3";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"D0C24B5A") report "Case 88 bgeu failed" severity error;

--Test Case 89:
wait for cCLK_PER;
s_PC <= X"B8DBEECB";
s_imm <= X"AD0DF525";
s_ALU_result <= X"A430FC1F";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"65E9E3F0") report "Case 89 bgeu failed" severity error;

--Test Case 90:
wait for cCLK_PER;
s_PC <= X"BAD18C78";
s_imm <= X"0DD72B54";
s_ALU_result <= X"BCD089D7";
s_PC_source <= X"1";
s_comparison <= X"1";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"BAD18C7C") report "Case 90 bne failed" severity error;

--Test Case 91:
wait for cCLK_PER;
s_PC <= X"F8D5FD74";
s_imm <= X"FC3BE2EC";
s_ALU_result <= X"A1F2A21E";
s_PC_source <= X"1";
s_comparison <= X"5";
s_zero <= '1';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"F8D5FD78") report "Case 91 bgeu failed" severity error;

--Test Case 92:
wait for cCLK_PER;
s_PC <= X"4C66A90A";
s_imm <= X"66588161";
s_ALU_result <= X"40EA7EDF";
s_PC_source <= X"2";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"40EA7EDF") report "Case 92 bltu failed" severity error;

--Test Case 93:
wait for cCLK_PER;
s_PC <= X"A4C0B7DC";
s_imm <= X"07291856";
s_ALU_result <= X"38E7975A";
s_PC_source <= X"3";
s_comparison <= X"4";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"A4C0B7E0") report "Case 93 bltu failed" severity error;

--Test Case 94:
wait for cCLK_PER;
s_PC <= X"1F43A9CB";
s_imm <= X"DDDB5E26";
s_ALU_result <= X"D49C26AB";
s_PC_source <= X"1";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"1F43A9CF") report "Case 94 beq failed" severity error;

--Test Case 95:
wait for cCLK_PER;
s_PC <= X"A8836909";
s_imm <= X"463C7ED5";
s_ALU_result <= X"D897F316";
s_PC_source <= X"2";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"D897F316") report "Case 95 blt failed" severity error;

--Test Case 96:
wait for cCLK_PER;
s_PC <= X"9E0AAFE3";
s_imm <= X"DF91ED17";
s_ALU_result <= X"BCBCB9AE";
s_PC_source <= X"0";
s_comparison <= X"2";
s_zero <= '0';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '1';
assert (s_new_PC = X"9E0AAFE7") report "Case 96 blt failed" severity error;

--Test Case 97:
wait for cCLK_PER;
s_PC <= X"25F3591A";
s_imm <= X"F4C5C952";
s_ALU_result <= X"E0B57F8C";
s_PC_source <= X"2";
s_comparison <= X"1";
s_zero <= '0';
s_negative <= '0';
s_carry <= '0';
s_overflow <= '0';
assert (s_new_PC = X"E0B57F8C") report "Case 97 bne failed" severity error;

--Test Case 98:
wait for cCLK_PER;
s_PC <= X"9DB02CAF";
s_imm <= X"5B38E55B";
s_ALU_result <= X"86A19734";
s_PC_source <= X"2";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"86A19734") report "Case 98 beq failed" severity error;

--Test Case 99:
wait for cCLK_PER;
s_PC <= X"2AB87FF0";
s_imm <= X"AC33BE2C";
s_ALU_result <= X"928696DA";
s_PC_source <= X"3";
s_comparison <= X"0";
s_zero <= '0';
s_negative <= '1';
s_carry <= '0';
s_overflow <= '1';
assert (s_new_PC = X"2AB87FF4") report "Case 99 beq failed" severity error;

--Test Case 100:
wait for cCLK_PER;
s_PC <= X"FB71D4BE";
s_imm <= X"AEDB4C50";
s_ALU_result <= X"00A190D3";
s_PC_source <= X"3";
s_comparison <= X"4";
s_zero <= '1';
s_negative <= '0';
s_carry <= '1';
s_overflow <= '0';
assert (s_new_PC = X"FB71D4C2") report "Case 100 bltu failed" severity error;



        wait;
    end process;
end behavior;