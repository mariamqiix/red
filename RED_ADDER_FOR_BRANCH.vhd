library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_ADDER_FOR_BRANCH is
    Port (
        RED_PC           : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_OFFSET       : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_BRANCH_ADDER : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_ADDER_FOR_BRANCH;

architecture Behavioral of RED_ADDER_FOR_BRANCH is
    signal RED_BRANCH_RESULT : STD_LOGIC_VECTOR(63 downto 0);
begin

            RED_BRANCH_RESULT <= std_logic_vector(signed(RED_PC) + signed(RED_OFFSET));
    RED_BRANCH_ADDER <= RED_BRANCH_RESULT;
end Behavioral;
