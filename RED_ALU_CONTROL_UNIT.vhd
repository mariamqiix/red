library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 



entity RED_ALU_CONTROL_UNIT is
    Port (
        RED_ALU_OP     : in  STD_LOGIC_VECTOR(1 downto 0);
        RED_FUNCT      : in  STD_LOGIC_VECTOR(5 downto 0);   -- FOR RED_INSTRUCTION[5:0]
        RED_ALU_CTRL   : out STD_LOGIC_VECTOR(3 downto 0)    -- ALU OPERATION CODE
    );
end RED_ALU_CONTROL_UNIT;
