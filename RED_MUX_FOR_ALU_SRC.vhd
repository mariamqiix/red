library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_MUX_FOR_ALU_SRC is
    Port (
        RED_SELECT    : in  STD_LOGIC;
        RED_INPUT_A   : in  STD_LOGIC_VECTOR(31 downto 0);  -- ReadData2
        RED_INPUT_B   : in  STD_LOGIC_VECTOR(31 downto 0);  -- Immediate
        RED_OUTPUT    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_MUX_FOR_ALU_SRC;



architecture Behavioral of RED_MUX_FOR_ALU_SRC is
	begin
		 process(RED_SELECT, RED_INPUT_A, RED_INPUT_B)
		 begin
			  if RED_SELECT = '1' then
					RED_OUTPUT <= RED_INPUT_A;
			  else
					RED_OUTPUT <= RED_INPUT_B;
			  end if;
		 end process;
end Behavioral;
