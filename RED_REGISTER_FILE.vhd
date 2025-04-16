library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 



entity RED_REGISTER_FILE is
    Port (
		  RED_REG_WRITE      : in  STD_LOGIC;
        RED_REG1      		: in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[25:21]
        RED_REG2      		: in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[20:16]
        RED_WRITE_REG      : in  STD_LOGIC_VECTOR(4 downto 0);   -- RED_INSTRUCTION[15–11] OR RED_INSTRUCTION[20–16] based on RED_REG_DST
        RED_WRITE_DATA     : in  STD_LOGIC_VECTOR(31 downto 0);  -- ALU OR MEM
        RED_DATA1     		: out STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA2     		: out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_REGISTER_FILE;
