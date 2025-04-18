library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_ADDER_FOR_BRANCH is
    Port (
        RED_PC_P4          : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OFFSET         : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_BRANCH_ADDER   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_ADDER_FOR_BRANCH;

architecture Behavioral of RED_ADDER_FOR_BRANCH is
	begin
		RED_BRANCH_ADDER <= std_logic_vector(unsigned(RED_PC_P4) + unsigned(RED_OFFSET));
END Behavioral;