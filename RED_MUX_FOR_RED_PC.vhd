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
