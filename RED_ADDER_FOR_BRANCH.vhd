library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_ADDER_FOR_BRANCH is
    Port (
        RED_CLOCK        : in  STD_LOGIC;
        RED_PC           : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_OFFSET       : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_BRANCH_ADDER : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_ADDER_FOR_BRANCH;

architecture Behavioral of RED_ADDER_FOR_BRANCH is
    signal RED_BRANCH_RESULT : STD_LOGIC_VECTOR(63 downto 0);
begin
    process(RED_CLOCK)
    begin
        if rising_edge(RED_CLOCK) then
            RED_BRANCH_RESULT <= std_logic_vector(unsigned(RED_PC) + unsigned(RED_OFFSET));
        end if;
    end process;

    RED_BRANCH_ADDER <= RED_BRANCH_RESULT;
end Behavioral;
