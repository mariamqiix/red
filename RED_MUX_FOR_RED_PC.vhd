library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_MUX_FOR_RED_PC is
    Port (
	     RED_SELECT         : in  STD_LOGIC;
        RED_SIGNAL_PC_P4   : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_BRAMCH_ADD     : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OUTPUT         : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_MUX_FOR_RED_PC;

architecture Behavioral of RED_MUX_FOR_RED_PC is
	begin
		 process(RED_SELECT, RED_SIGNAL_PC_P4, RED_BRAMCH_ADD)
		 begin
			  if RED_SELECT = '1' then
					RED_OUTPUT <= RED_SIGNAL_PC_P4;
			  else
					RED_OUTPUT <= RED_BRAMCH_ADD;
			  end if;
		 end process;
end Behavioral;
