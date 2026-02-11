-------------------------------------------------------------------------
-- David Rice
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- fetch_logic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains all the logic for determining the next value of PC
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity fetch_logic is

    port (
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

end fetch_logic;
architecture mixed of fetch_logic is

    --checks if the branch condition is met
    signal s_condition_met : std_logic;
    signal s_PC_chosen : std_logic_vector(31 downto 0);

    component reg_n is

        generic (N : integer := 32);
        port (
            i_CLK : in std_logic; -- Clock input
            i_RST : in std_logic; -- Reset input
            i_WE : in std_logic; -- Write enable input
            i_D : in std_logic_vector(N - 1 downto 0); -- Data vector input
            o_Q : out std_logic_vector(N - 1 downto 0)); -- Data vector output

    end component;

begin

    --instantiate the PC register
    PC_reg : reg_n
    port map(
        i_CLK => i_CLK,
        i_RST => i_RST,
        --we are always writing to PC
        i_WE => '1',
        i_D => s_PC_chosen,
        o_Q => o_new_PC
    );
    --Checking the branch condition
    --0: EQUALS
    --1: NOT EQUALS
    --2: LESS THAN (S)
    --3: GREATER THAN OR EQUAL (S)
    --4: LESS THAN (U)
    --5: GREATER THAN OR EQUAL (U)
    --6: JUMP
    s_condition_met <= '1' when(
        --EQUALS
        (i_comparison = "000" and i_zero = '1') or
        --NOT EQUALS
        (i_comparison = "001" and i_zero = '0') or
        --LESS THAN
        (i_comparison = "010" and i_negative /= i_overflow) or
        --GREATER THAN OR EQUAL (S)
        (i_comparison = "011" and i_negative = i_overflow) or
        --LESS THAN (U)
        (i_comparison = "100" and i_carry = '0') or
        --GREATER THAN OR EQUAL (U)
        (i_comparison = "101" and i_carry = '1') or
        --JUMP
        (i_comparison = "110")
        )
        else
        '0';
    --Muxing the different PC sources
    --0: PC + 4
    --1: PC relative
    --2: Register relative (ALU)
    --Some VHDL magic to add +4 to a std_logic_vector without instantiating an adder
    o_new_PC <= std_logic_vector(to_unsigned((to_integer(unsigned(i_PC)) + 4), 32)) when(
        i_PC_source = "00" or (i_PC_source = "01" and s_condition_met = '0')
        )
        else
        --Some VHDL magic to add +imm to a std_logic_vector without instantiating an adder
        std_logic_vector(to_unsigned((to_integer(unsigned(i_PC)) + to_integer(unsigned(i_imm))), 32)) when(
        --otherwise if the condition is met than this part can execute
        i_PC_source = "01"
        )
        else
        i_ALU_result when(
        i_PC_source = "10"
        )
        --if it reaches this part something very wrong has happened
        else
        X"00000000";

end mixed;