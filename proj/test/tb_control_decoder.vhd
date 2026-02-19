-------------------------------------------------------------------------
-- Nicholas Jund
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_control_decoder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- control decoder
--
--
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
entity tb_control_decoder is
    generic (gCLK_HPER : time := 50 ns);
end tb_control_decoder;

architecture behavior of tb_control_decoder is

    -- Calculate the clock period as twice the half-period
    constant cCLK_PER : time := gCLK_HPER * 2;
    component control_decoder
        port (
            i_instruction : in std_logic_vector(31 downto 0);
            o_ALU_src : out std_logic;
            o_ALU_control : out std_logic_vector(2 downto 0);
            o_imm_type : out std_logic_vector(2 downto 0);
            o_result_src : out std_logic_vector(1 downto 0);
            o_mem_write : out std_logic;
            o_reg_write : out std_logic;
            o_reg_read : out std_logic;
            o_PC_source : out std_logic_vector(1 downto 0);
            o_mem_slice : out std_logic_vector(2 downto 0);
            o_comparison : out std_logic_vector(2 downto 0)
        );
    end component;

    signal s_instruction : std_logic_vector(31 downto 0);
    signal s_ALU_src     : std_logic;
    signal s_ALU_control : std_logic_vector(2 downto 0);
    signal s_imm_type    : std_logic_vector(2 downto 0);
    signal s_result_src  : std_logic_vector(1 downto 0);
    signal s_mem_write   : std_logic;
    signal s_reg_write   : std_logic;
    signal s_reg_read    : std_logic;
    signal s_PC_source   : std_logic_vector(1 downto 0);
    signal s_mem_slice   : std_logic_vector(2 downto 0);
    signal s_comparison  : std_logic_vector(2 downto 0);

    signal s_case_number : integer := 0;

begin

    DUT : control_decoder
    port map(
        i_instruction => s_instruction,
        o_ALU_src     => s_ALU_src,
        o_ALU_control => s_ALU_control,
        o_imm_type    => s_imm_type,
        o_result_src  => s_result_src,
        o_mem_write   => s_mem_write,
        o_reg_write   => s_reg_write,
        o_reg_read    => s_reg_read,
        o_PC_source   => s_PC_source,
        o_mem_slice   => s_mem_slice,
        o_comparison  => s_comparison
    );


    -- Testbench process  
    P_TB : process
    begin
        --Test Case 1:
        s_instruction <= "00000000000000000010000000000011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 1: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 1: s_ALU_control failed" severity error;
        assert (s_imm_type = "001") report "Case 1: s_imm_type failed" severity error;
        assert (s_result_src = "01") report "Case 1: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 1: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 1: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 1: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 1: s_PC_source failed" severity error;
        assert (s_mem_slice = "000") report "Case 1: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 1: s_comparison failed" severity error;
        s_case_number <= 1;
        wait for cCLK_PER;


        --Test Case 2:
        s_instruction <= "00000000000000000000000000000011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 2: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 2: s_ALU_control failed" severity error;
        assert (s_imm_type = "001") report "Case 2: s_imm_type failed" severity error;
        assert (s_result_src = "01") report "Case 2: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 2: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 2: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 2: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 2: s_PC_source failed" severity error;
        assert (s_mem_slice = "001") report "Case 2: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 2: s_comparison failed" severity error;
        s_case_number <= 2;
        wait for cCLK_PER;


        --Test Case 3:
        s_instruction <= "00000000000000000001000000000011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 3: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 3: s_ALU_control failed" severity error;
        assert (s_imm_type = "001") report "Case 3: s_imm_type failed" severity error;
        assert (s_result_src = "01") report "Case 3: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 3: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 3: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 3: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 3: s_PC_source failed" severity error;
        assert (s_mem_slice = "010") report "Case 3: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 3: s_comparison failed" severity error;
        s_case_number <= 3;
        wait for cCLK_PER;


        --Test Case 4:
        s_instruction <= "00000000000000000100000000000011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 4: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 4: s_ALU_control failed" severity error;
        assert (s_imm_type = "001") report "Case 4: s_imm_type failed" severity error;
        assert (s_result_src = "01") report "Case 4: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 4: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 4: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 4: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 4: s_PC_source failed" severity error;
        assert (s_mem_slice = "011") report "Case 4: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 4: s_comparison failed" severity error;
        s_case_number <= 4;
        wait for cCLK_PER;


        --Test Case 5:
        s_instruction <= "00000000000000000101000000000011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 5: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 5: s_ALU_control failed" severity error;
        assert (s_imm_type = "001") report "Case 5: s_imm_type failed" severity error;
        assert (s_result_src = "01") report "Case 5: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 5: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 5: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 5: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 5: s_PC_source failed" severity error;
        assert (s_mem_slice = "100") report "Case 5: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 5: s_comparison failed" severity error;
        s_case_number <= 5;
        wait for cCLK_PER;


        --Test Case 6:
        s_instruction <= "00000000000000000000000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 6: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 6: s_ALU_control failed" severity error;
        assert (s_imm_type = "001") report "Case 6: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 6: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 6: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 6: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 6: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 6: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 6: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 6: s_comparison failed" severity error;
        s_case_number <= 6;
        wait for cCLK_PER;


        --Test Case 7:
        s_instruction <= "00000000000000000111000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 7: s_ALU_src failed" severity error;
        assert (s_ALU_control = "010") report "Case 7: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 7: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 7: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 7: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 7: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 7: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 7: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 7: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 7: s_comparison failed" severity error;
        s_case_number <= 7;
        wait for cCLK_PER;


        --Test Case 8:
        s_instruction <= "00000000000000000100000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 8: s_ALU_src failed" severity error;
        assert (s_ALU_control = "100") report "Case 8: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 8: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 8: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 8: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 8: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 8: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 8: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 8: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 8: s_comparison failed" severity error;
        s_case_number <= 8;
        wait for cCLK_PER;


        --Test Case 9:
        s_instruction <= "00000000000000000110000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 9: s_ALU_src failed" severity error;
        assert (s_ALU_control = "011") report "Case 9: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 9: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 9: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 9: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 9: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 9: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 9: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 9: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 9: s_comparison failed" severity error;
        s_case_number <= 9;
        wait for cCLK_PER;


        --Test Case 10:
        s_instruction <= "00000000000000000010000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 10: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 10: s_ALU_control failed" severity error;
        assert (s_imm_type = "001") report "Case 10: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 10: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 10: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 10: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 10: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 10: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 10: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 10: s_comparison failed" severity error;
        s_case_number <= 10;
        wait for cCLK_PER;


        --Test Case 11:
        s_instruction <= "00000000000000000001000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 11: s_ALU_src failed" severity error;
        assert (s_ALU_control = "101") report "Case 11: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 11: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 11: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 11: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 11: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 11: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 11: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 11: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 11: s_comparison failed" severity error;
        s_case_number <= 11;
        wait for cCLK_PER;


        --Test Case 12:
        s_instruction <= "00000000000000000101000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 12: s_ALU_src failed" severity error;
        assert (s_ALU_control = "110") report "Case 12: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 12: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 12: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 12: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 12: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 12: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 12: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 12: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 12: s_comparison failed" severity error;
        s_case_number <= 12;
        wait for cCLK_PER;


        --Test Case 13:
        s_instruction <= "01000000000000000101000000010011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 13: s_ALU_src failed" severity error;
        assert (s_ALU_control = "111") report "Case 13: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 13: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 13: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 13: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 13: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 13: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 13: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 13: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 13: s_comparison failed" severity error;
        s_case_number <= 13;
        wait for cCLK_PER;


        --Test Case 14:
        s_instruction <= "00000000000000000000000000010111";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 14: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 14: s_ALU_control failed" severity error;
        assert (s_imm_type = "010") report "Case 14: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 14: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 14: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 14: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 14: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 14: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 14: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 14: s_comparison failed" severity error;
        s_case_number <= 14;
        wait for cCLK_PER;


        --Test Case 15:
        s_instruction <= "00000000000000000010000000100011";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 15: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 15: s_ALU_control failed" severity error;
        assert (s_imm_type = "101") report "Case 15: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 15: s_result_src failed" severity error;
        assert (s_mem_write = '1') report "Case 15: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 15: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 15: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 15: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 15: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 15: s_comparison failed" severity error;
        s_case_number <= 15;
        wait for cCLK_PER;


        --Test Case 16:
        s_instruction <= "00000000000000000000000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 16: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 16: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 16: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 16: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 16: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 16: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 16: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 16: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 16: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 16: s_comparison failed" severity error;
        s_case_number <= 16;
        wait for cCLK_PER;


        --Test Case 17:
        s_instruction <= "00000000000000000111000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 17: s_ALU_src failed" severity error;
        assert (s_ALU_control = "010") report "Case 17: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 17: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 17: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 17: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 17: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 17: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 17: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 17: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 17: s_comparison failed" severity error;
        s_case_number <= 17;
        wait for cCLK_PER;


        --Test Case 18:
        s_instruction <= "00000000000000000100000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 18: s_ALU_src failed" severity error;
        assert (s_ALU_control = "100") report "Case 18: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 18: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 18: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 18: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 18: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 18: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 18: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 18: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 18: s_comparison failed" severity error;
        s_case_number <= 18;
        wait for cCLK_PER;


        --Test Case 19:
        s_instruction <= "00000000000000000110000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 19: s_ALU_src failed" severity error;
        assert (s_ALU_control = "011") report "Case 19: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 19: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 19: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 19: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 19: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 19: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 19: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 19: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 19: s_comparison failed" severity error;
        s_case_number <= 19;
        wait for cCLK_PER;


        --Test Case 20:
        s_instruction <= "00000000000000000010000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 20: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 20: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 20: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 20: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 20: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 20: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 20: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 20: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 20: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 20: s_comparison failed" severity error;
        s_case_number <= 20;
        wait for cCLK_PER;


        --Test Case 21:
        s_instruction <= "00000000000000000011000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 21: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 21: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 21: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 21: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 21: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 21: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 21: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 21: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 21: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 21: s_comparison failed" severity error;
        s_case_number <= 21;
        wait for cCLK_PER;


        --Test Case 22:
        s_instruction <= "00000000000000000001000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 22: s_ALU_src failed" severity error;
        assert (s_ALU_control = "101") report "Case 22: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 22: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 22: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 22: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 22: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 22: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 22: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 22: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 22: s_comparison failed" severity error;
        s_case_number <= 22;
        wait for cCLK_PER;


        --Test Case 23:
        s_instruction <= "00000000000000000101000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 23: s_ALU_src failed" severity error;
        assert (s_ALU_control = "110") report "Case 23: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 23: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 23: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 23: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 23: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 23: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 23: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 23: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 23: s_comparison failed" severity error;
        s_case_number <= 23;
        wait for cCLK_PER;


        --Test Case 24:
        s_instruction <= "01000000000000000101000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 24: s_ALU_src failed" severity error;
        assert (s_ALU_control = "111") report "Case 24: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 24: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 24: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 24: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 24: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 24: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 24: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 24: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 24: s_comparison failed" severity error;
        s_case_number <= 24;
        wait for cCLK_PER;


        --Test Case 25:
        s_instruction <= "01000000000000000000000000110011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 25: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 25: s_ALU_control failed" severity error;
        assert (s_imm_type = "000") report "Case 25: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 25: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 25: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 25: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 25: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 25: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 25: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 25: s_comparison failed" severity error;
        s_case_number <= 25;
        wait for cCLK_PER;


        --Test Case 26:
        s_instruction <= "00000000000000000000000000110111";
        wait for cCLK_PER;
        assert (s_ALU_src = '1') report "Case 26: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 26: s_ALU_control failed" severity error;
        assert (s_imm_type = "010") report "Case 26: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 26: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 26: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 26: s_reg_write failed" severity error;
        assert (s_reg_read = '0') report "Case 26: s_reg_read failed" severity error;
        assert (s_PC_source = "00") report "Case 26: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 26: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 26: s_comparison failed" severity error;
        s_case_number <= 26;
        wait for cCLK_PER;


        --Test Case 27:
        s_instruction <= "00000000000000000000000001100011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 27: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 27: s_ALU_control failed" severity error;
        assert (s_imm_type = "011") report "Case 27: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 27: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 27: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 27: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 27: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 27: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 27: s_mem_slice failed" severity error;
        assert (s_comparison = "000") report "Case 27: s_comparison failed" severity error;
        s_case_number <= 27;
        wait for cCLK_PER;


        --Test Case 28:
        s_instruction <= "00000000000000000001000001100011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 28: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 28: s_ALU_control failed" severity error;
        assert (s_imm_type = "011") report "Case 28: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 28: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 28: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 28: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 28: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 28: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 28: s_mem_slice failed" severity error;
        assert (s_comparison = "001") report "Case 28: s_comparison failed" severity error;
        s_case_number <= 28;
        wait for cCLK_PER;


        --Test Case 29:
        s_instruction <= "00000000000000000100000001100011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 29: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 29: s_ALU_control failed" severity error;
        assert (s_imm_type = "011") report "Case 29: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 29: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 29: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 29: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 29: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 29: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 29: s_mem_slice failed" severity error;
        assert (s_comparison = "010") report "Case 29: s_comparison failed" severity error;
        s_case_number <= 29;
        wait for cCLK_PER;


        --Test Case 30:
        s_instruction <= "00000000000000000101000001100011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 30: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 30: s_ALU_control failed" severity error;
        assert (s_imm_type = "011") report "Case 30: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 30: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 30: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 30: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 30: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 30: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 30: s_mem_slice failed" severity error;
        assert (s_comparison = "011") report "Case 30: s_comparison failed" severity error;
        s_case_number <= 30;
        wait for cCLK_PER;


        --Test Case 31:
        s_instruction <= "00000000000000000110000001100011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 31: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 31: s_ALU_control failed" severity error;
        assert (s_imm_type = "011") report "Case 31: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 31: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 31: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 31: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 31: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 31: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 31: s_mem_slice failed" severity error;
        assert (s_comparison = "100") report "Case 31: s_comparison failed" severity error;
        s_case_number <= 31;
        wait for cCLK_PER;


        --Test Case 32:
        s_instruction <= "00000000000000000111000001100011";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 32: s_ALU_src failed" severity error;
        assert (s_ALU_control = "001") report "Case 32: s_ALU_control failed" severity error;
        assert (s_imm_type = "011") report "Case 32: s_imm_type failed" severity error;
        assert (s_result_src = "00") report "Case 32: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 32: s_mem_write failed" severity error;
        assert (s_reg_write = '0') report "Case 32: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 32: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 32: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 32: s_mem_slice failed" severity error;
        assert (s_comparison = "101") report "Case 32: s_comparison failed" severity error;
        s_case_number <= 32;
        wait for cCLK_PER;


        --Test Case 33:
        s_instruction <= "00000000000000000000000001100111";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 33: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 33: s_ALU_control failed" severity error;
        assert (s_imm_type = "100") report "Case 33: s_imm_type failed" severity error;
        assert (s_result_src = "10") report "Case 33: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 33: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 33: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 33: s_reg_read failed" severity error;
        assert (s_PC_source = "10") report "Case 33: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 33: s_mem_slice failed" severity error;
        assert (s_comparison = "110") report "Case 33: s_comparison failed" severity error;
        s_case_number <= 33;
        wait for cCLK_PER;

        --Test Case 34:
        s_instruction <= "00000000000000000000000001101111";
        wait for cCLK_PER;
        assert (s_ALU_src = '0') report "Case 33: s_ALU_src failed" severity error;
        assert (s_ALU_control = "000") report "Case 33: s_ALU_control failed" severity error;
        assert (s_imm_type = "011") report "Case 33: s_imm_type failed" severity error;
        assert (s_result_src = "10") report "Case 33: s_result_src failed" severity error;
        assert (s_mem_write = '0') report "Case 33: s_mem_write failed" severity error;
        assert (s_reg_write = '1') report "Case 33: s_reg_write failed" severity error;
        assert (s_reg_read = '1') report "Case 33: s_reg_read failed" severity error;
        assert (s_PC_source = "01") report "Case 33: s_PC_source failed" severity error;
        --assert (s_mem_slice ="000") report "Case 33: s_mem_slice failed" severity error;
        assert (s_comparison = "110") report "Case 33: s_comparison failed" severity error;
        s_case_number <= 33;
        wait for cCLK_PER;

        wait;
    end process;

end behavior;