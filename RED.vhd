library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RED is
    Port (
        RED_INPUT : in  STD_LOGIC_VECTOR(7 downto 0);
		  RED_CLOCK   : in  STD_LOGIC
	 );
end RED;

architecture Behavioral of RED is


component  RED_ADDER_FOR_BRANCH 
    Port (
        RED_PC_P4          : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OFFSET         : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_BRANCH_ADDER   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component ;


component RED_ADDER_FOR_PC_P4
    Port (
        RED_PC       : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_PC_P4    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;


component RED_ALU 
    Port (
        RED_INPUT_A       : in  STD_LOGIC_VECTOR(31 downto 0);  -- Operand 1
        RED_INPUT_B       : in  STD_LOGIC_VECTOR(31 downto 0);  -- Operand 2
        RED_ALU_CTRL      : in  STD_LOGIC_VECTOR(3 downto 0);   -- Control from RED_ALU_CONTROL_UNIT
        RED_ALU_RESULTS   : out STD_LOGIC_VECTOR(31 downto 0);
        RED_ALU_ZERO      : out STD_LOGIC
    );
end component;

component RED_ALU_CONTROL_UNIT
    Port (
        RED_ALU_OP     : in  STD_LOGIC_VECTOR(1 downto 0);
        RED_FUNCT      : in  STD_LOGIC_VECTOR(5 downto 0);   -- FOR RED_INSTRUCTION[5:0]
        RED_ALU_CTRL   : out STD_LOGIC_VECTOR(3 downto 0)    -- ALU OPERATION CODE
    );
end component;

component RED_CONTROL_UNIT 
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
end component;

component RED_DATA_MEM 
    Port (
	     RED_MEM_WRITE   : in  STD_LOGIC;
        RED_MEM_READ    : in  STD_LOGIC;
        RED_ADDRESS     : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_WRITE_DATA  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA        : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

component RED_INST_MEM
    Port (
        RED_ADDRESS    : in  STD_LOGIC_VECTOR(7 downto 0);
        RED_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;


component RED_MUX_FOR_ALU_SRC
    Port (
        RED_SELECT    : in  STD_LOGIC;
        RED_INPUT_A   : in  STD_LOGIC_VECTOR(31 downto 0);  -- ReadData2
        RED_INPUT_B   : in  STD_LOGIC_VECTOR(31 downto 0);  -- Immediate
        RED_OUTPUT    : out STD_LOGIC_VECTOR(31 downto 0)
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


component RED_PC 
    Port (
        RED_INPUT : in  STD_LOGIC_VECTOR(7 downto 0);
        RED_ADDRESS : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;


component RED_REGISTER_FILE
    Port (
		  RED_REG_WRITE      : in  STD_LOGIC;
        RED_REG1      		: in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[25:21]
        RED_REG2      		: in  STD_LOGIC_VECTOR(4 downto 0);   -- FOR RED_INSTRUCTION[20:16]
        RED_WRITE_REG      : in  STD_LOGIC_VECTOR(4 downto 0);   -- RED_INSTRUCTION[15–11] OR RED_INSTRUCTION[20–16] based on RED_REG_DST
        RED_WRITE_DATA     : in  STD_LOGIC_VECTOR(31 downto 0);  -- ALU OR MEM
        RED_DATA1     		: out STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA2     		: out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

component RED_SIGN_EXTEND 
    Port (
        RED_IMM    			: in  STD_LOGIC_VECTOR(15 downto 0);   -- FOR RED_INSTRUCTION[25:21]
        RED_EXTENDET_IMM   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;


component RED_SL_BY_1 
    Port (
        RED_INPUT  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OUTPUT : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;
begin
    process(RED_INPUT,RED_CLOCK)
    begin

	 
	 
	 
        null;
    end process;
end Behavioral;
