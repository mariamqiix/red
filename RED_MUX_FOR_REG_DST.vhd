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
