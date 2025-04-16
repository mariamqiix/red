library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_ALU is
    Port (
        RED_INPUT_A       : in  STD_LOGIC_VECTOR(31 downto 0);  -- Operand 1
        RED_INPUT_B       : in  STD_LOGIC_VECTOR(31 downto 0);  -- Operand 2
        RED_ALU_CTRL      : in  STD_LOGIC_VECTOR(3 downto 0);   -- Control from RED_ALU_CONTROL_UNIT
        RED_ALU_RESULTS   : out STD_LOGIC_VECTOR(31 downto 0);
        RED_ALU_ZERO      : out STD_LOGIC
    );
end RED_ALU;
