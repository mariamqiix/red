library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RED is
    Port (
        RED_INPUT : in  STD_LOGIC_VECTOR(7 downto 0);
		  RED_CLOCK   : in  STD_LOGIC
	 );
end RED;

architecture Behavioral of RED is







--component RED_ALU_CONTROL_UNIT
    --Port (
        --RED_ALU_OP     : in  STD_LOGIC_VECTOR(1 downto 0);
        --RED_FUNCT      : in  STD_LOGIC_VECTOR(5 downto 0);   -- FOR RED_INSTRUCTION[5:0]
        --RED_ALU_CTRL   : out STD_LOGIC_VECTOR(3 downto 0)    -- ALU OPERATION CODE
    --);
--end component;



component RED_DATA_MEM 
    Port (
	     RED_MEM_WRITE   : in  STD_LOGIC;
        RED_MEM_READ    : in  STD_LOGIC;
        RED_ADDRESS     : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_WRITE_DATA  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA        : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;






component RED_MUX_FOR_MEM_TO_REG 
    Port (
        RED_SELECT         : in  STD_LOGIC;
        RED_ALU_RESULTS    : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_MEM_DATA       : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OUTPUT         : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;


component RED_MUX_FOR_RED_PC
    Port (
	     RED_SELECT         : in  STD_LOGIC;
        RED_SIGNAL_PC_P4   : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_BRAMCH_ADD     : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OUTPUT         : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;


component RED_MUX_FOR_REG_DST 
    Port (
	     RED_SELECT     : in  STD_LOGIC;
        RED_RT         : in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[20:16]
        RED_RD         : in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[15:11]
        RED_OUTPUT     : out STD_LOGIC_VECTOR(4 downto 0)
    );
end component;









begin
    process(RED_INPUT,RED_CLOCK)
    begin

	 
	 
	 
        null;
    end process;
end Behavioral;
