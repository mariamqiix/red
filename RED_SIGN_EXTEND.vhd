library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_SIGN_EXTEND is
    Port (
        RED_IMM    			: in  STD_LOGIC_VECTOR(15 downto 0);   -- FOR RED_INSTRUCTION[25:21]
        RED_EXTENDET_IMM   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_SIGN_EXTEND;
