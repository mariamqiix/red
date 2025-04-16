library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_ADDER_FOR_PC_P4 is
    Port (
        RED_PC       : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_PC_P4    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_ADDER_FOR_PC_P4;
