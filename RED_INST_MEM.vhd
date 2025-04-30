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
    -- signal RED_MEM : RED_MEM_TYPE;
	 
	 -- just to test the stage 1
	     signal RED_MEM : RED_MEM_TYPE := (
        0 => x"00000013",  -- NOP (ADDI x0, x0, 0)
        1 => x"00100093",  -- ADDI x1, x0, 1
        2 => x"00200113",  -- ADDI x2, x0, 2
        3 => x"00308193",  -- ADDI x3, x1, 3
        4 => x"00408213",  -- ADDI x4, x1, 4
        5 => x"00510293",  -- ADDI x5, x2, 5
        6 => x"00618313",  -- ADDI x6, x3, 6
        7 => x"00720393",  -- ADDI x7, x4, 7
        others => (others => '0')  -- Remaining memory set to 0
    );
	 begin
	 
    RED_INSTRUCTION <= RED_MEM(to_integer(unsigned(RED_ADDRESS)));
	 
end Behavioral;


