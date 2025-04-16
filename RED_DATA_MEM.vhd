library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_DATA_MEM is
    Port (
	     RED_MEM_WRITE   : in  STD_LOGIC;
        RED_MEM_READ    : in  STD_LOGIC;
        RED_ADDRESS     : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_WRITE_DATA  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA        : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_DATA_MEM;
