library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_INST_MEM is
    Port (
        RED_ADDRESS    : in  STD_LOGIC_VECTOR(7 downto 0);
        RED_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_INST_MEM;

architecture Behavioral of RED_INST_MEM is

    type RED_MEM_TYPE is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal RED_MEM : RED_MEM_TYPE;
	 
	 begin
	 
    RED_INSTRUCTION <= RED_MEM(to_integer(unsigned(RED_ADDRESS)));
	 
end Behavioral;