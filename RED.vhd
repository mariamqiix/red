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



--component RED_MUX_FOR_REG_DST 
    --Port (
	     --RED_SELECT     : in  STD_LOGIC;
        --RED_RT         : in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[20:16]
        --RED_RD         : in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[15:11]
        --RED_OUTPUT     : out STD_LOGIC_VECTOR(4 downto 0)
    --);
--end component;









begin
    process(RED_INPUT,RED_CLOCK)
    begin

	 
	 
	 
        null;
    end process;
end Behavioral;
