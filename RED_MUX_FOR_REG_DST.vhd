library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_MUX_FOR_REG_DST is
    Port (
	     RED_SELECT     : in  STD_LOGIC;
        RED_RT         : in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[20:16]
        RED_RD         : in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[15:11]
        RED_OUTPUT     : out STD_LOGIC_VECTOR(4 downto 0)
    );
end RED_MUX_FOR_REG_DST;


architecture Behavioral of RED_MUX_FOR_REG_DST is
	begin
		 process(RED_SELECT, RED_RT, RED_RD)
		 begin
			  if RED_SELECT = '1' then
					RED_OUTPUT <= RED_RT;
			  else
					RED_OUTPUT <= RED_RD;
			  end if;
		 end process;
end Behavioral;
