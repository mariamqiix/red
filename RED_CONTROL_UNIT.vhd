library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity RED_CONTROL_UNIT is
    Port (
        RED_OPCODE       : in  STD_LOGIC_VECTOR(5 downto 0);
		  RED_ALU_OP       : out STD_LOGIC_VECTOR(1 downto 0);
		  RED_ALU_SRC      : out STD_LOGIC;
		  RED_BRANCH       : out STD_LOGIC;
        RED_REG_DST      : out STD_LOGIC;
        RED_MEM_TO_Reg   : out STD_LOGIC;
        RED_REG_WRITE    : out STD_LOGIC;
        RED_MEM_READ     : out STD_LOGIC;
        RED_MEM_WRITE    : out STD_LOGIC
    );
end RED_CONTROL_UNIT;
