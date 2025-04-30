library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_ADDER_FOR_BRANCH is
    Port (
        RED_PC          : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_OFFSET         : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_BRANCH_ADDER   : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_ADDER_FOR_BRANCH;

architecture Behavioral of RED_ADDER_FOR_BRANCH is
	begin
		RED_BRANCH_ADDER <= std_logic_vector(unsigned(RED_PC) + unsigned(RED_OFFSET));
END Behavioral;