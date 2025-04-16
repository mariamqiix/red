library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity RED_MUX_FOR_MEM_TO_REG is
    Port (
        RED_SELECT         : in  STD_LOGIC;
        RED_ALU_RESULTS    : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_MEM_DATA       : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OUTPUT         : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_MUX_FOR_MEM_TO_REG;
