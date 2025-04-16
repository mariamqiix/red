library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_SL_BY_2 is
    Port (
        RED_INPUT  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OUTPUT : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_SL_BY_2;
