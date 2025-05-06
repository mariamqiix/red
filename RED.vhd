library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RED is
    Port (
        RED_CLOCK   : in  STD_LOGIC
    );
end RED;

architecture Behavioral of RED is

    
    -- Component instantiations for each pipeline stage
    component RED_STAGE1 is
        Port (
            -- Inputs
            RED_CLOCK        : in STD_LOGIC;
            RED_SELECT       : in  STD_LOGIC;
            RED_BRAMCH_ADD   : in  STD_LOGIC_VECTOR(63 downto 0);

            -- Outputs
            RED_ADDRESS      : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component RED_STAGE2 is
        Port (
            -- Inputs
				RED_CLOCK        : in STD_LOGIC;
            RED_INSTRUCTION : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_ADDRESS     : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_WRITE_DATA  : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_WRITE_REG   : in  STD_LOGIC_VECTOR(4 downto 0);
            RED_REG_WRITE_IN: in  STD_LOGIC;  

            -- Outputs
            RED_ADDRESS_OUT      : out STD_LOGIC_VECTOR(63 downto 0);
            RED_DATA1            : out STD_LOGIC_VECTOR(31 downto 0);
            RED_DATA2            : out STD_LOGIC_VECTOR(31 downto 0);
            RED_EXTENDET_IMM     : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_OUT  : out STD_LOGIC_VECTOR(31 downto 0);

            -- Control signals
            RED_ALU_OP           : out STD_LOGIC_VECTOR(3 downto 0);
            RED_ALU_SRC          : out STD_LOGIC;
            RED_BRANCH           : out STD_LOGIC;
            RED_MEM_TO_REG       : out STD_LOGIC;
            RED_MEM_READ         : out STD_LOGIC;
            RED_MEM_WRITE        : out STD_LOGIC;
            RED_REG_WRITE_CTRL   : out STD_LOGIC 
        );
    end component;

    component RED_STAGE3 is
        Port (
            -- Inputs
				RED_CLOCK        : in STD_LOGIC;
            RED_PC_IN               : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_READ_DATA1_IN       : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_READ_DATA2_IN       : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_IMMEDIATE_IN        : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_IN      : in  STD_LOGIC_VECTOR(31 downto 0);

            -- Control Signals In
            RED_ALU_SRC_IN          : in  STD_LOGIC;
            RED_BRANCH_IN           : in  STD_LOGIC;
            RED_MEM_TO_REG_IN       : in  STD_LOGIC;
            RED_MEM_READ_IN         : in  STD_LOGIC;
            RED_MEM_WRITE_IN        : in  STD_LOGIC;
            RED_REG_WRITE_CTRL_IN   : in  STD_LOGIC;
            RED_ALU_OP_IN           : in  STD_LOGIC_VECTOR(3 downto 0);

            -- Outputs
            RED_ALU_INPUT_B         : out STD_LOGIC_VECTOR(31 downto 0);
            RED_BRANCH_TARGET       : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_OUT     : out STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_RESULTS         : out STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_ZERO            : out STD_LOGIC;

            -- Control Signals Out
            RED_BRANCH              : out STD_LOGIC;
            RED_MEM_TO_REG          : out STD_LOGIC;
            RED_MEM_READ            : out STD_LOGIC;
            RED_MEM_WRITE           : out STD_LOGIC;
            RED_REG_WRITE_CTRL      : out STD_LOGIC
        );
    end component;

    component RED_STAGE4 is
        Port (
            -- Inputs from Stage 3
				RED_CLOCK        : in STD_LOGIC;
            RED_MEM_TO_REG_IN      : in  STD_LOGIC;
            RED_MEM_READ_IN        : in  STD_LOGIC;
            RED_MEM_WRITE_IN       : in  STD_LOGIC;
            RED_REG_WRITE_CTRL_IN  : in  STD_LOGIC;
            RED_ALU_RESULTS_IN     : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_ZERO_IN        : in  STD_LOGIC;
            RED_ALU_INPUT_B_IN     : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_BRANCH_IN          : in  STD_LOGIC;
            RED_BRANCH_TARGET_IN   : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_IN     : in  STD_LOGIC_VECTOR(31 downto 0);

            -- Outputs
            RED_REG_WRITE_CTRL_OUT : out STD_LOGIC;
            RED_INSTRUCTION_OUT    : out STD_LOGIC_VECTOR(31 downto 0);
            RED_BRANCH_SELECT      : out STD_LOGIC;
            RED_BRANCH_TARGET      : out STD_LOGIC_VECTOR(63 downto 0);
            RED_WRITE_BACK_DATA    : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	     -- Registers
    component RED_REG1 is
        Port (
            RED_CLOCK         : in STD_LOGIC;
            Next_RED_ADDRESS  : in STD_LOGIC_VECTOR(63 downto 0);
            Next_RED_INSTRUCTION : in STD_LOGIC_VECTOR(31 downto 0);
            RED_ADDRESS_REG   : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_REG : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component RED_REG2 is
        Port (
            RED_CLOCK            : in STD_LOGIC;
            Next_RED_ADDRESS_OUT : in STD_LOGIC_VECTOR(63 downto 0);
            Next_RED_DATA1       : in STD_LOGIC_VECTOR(31 downto 0);
            Next_RED_DATA2       : in STD_LOGIC_VECTOR(31 downto 0);
            Next_RED_EXTENDET_IMM : in STD_LOGIC_VECTOR(63 downto 0);
            Next_RED_INSTRUCTION_OUT : in STD_LOGIC_VECTOR(31 downto 0);
            Next_RED_ALU_OP      : in STD_LOGIC_VECTOR(3 downto 0);
            Next_RED_ALU_SRC     : in STD_LOGIC;
            Next_RED_BRANCH      : in STD_LOGIC;
            Next_RED_MEM_TO_REG  : in STD_LOGIC;
            Next_RED_MEM_READ    : in STD_LOGIC;
            Next_RED_MEM_WRITE   : in STD_LOGIC;
            Next_RED_REG_WRITE_CTRL : in STD_LOGIC;
            RED_ADDRESS_OUT      : out STD_LOGIC_VECTOR(63 downto 0);
            RED_DATA1            : out STD_LOGIC_VECTOR(31 downto 0);
            RED_DATA2            : out STD_LOGIC_VECTOR(31 downto 0);
            RED_EXTENDET_IMM     : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_OUT  : out STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_OP           : out STD_LOGIC_VECTOR(3 downto 0);
            RED_ALU_SRC          : out STD_LOGIC;
            RED_BRANCH           : out STD_LOGIC;
            RED_MEM_TO_REG       : out STD_LOGIC;
            RED_MEM_READ         : out STD_LOGIC;
            RED_MEM_WRITE        : out STD_LOGIC;
            RED_REG_WRITE_CTRL   : out STD_LOGIC
        );
    end component;

    component RED_REG3 is
        Port (
            RED_CLOCK            : in STD_LOGIC;
            Next_RED_ALU_INPUT_B : in STD_LOGIC_VECTOR(31 downto 0);
            Next_RED_BRANCH_TARGET : in STD_LOGIC_VECTOR(63 downto 0);
            Next_RED_INSTRUCTION_OUT : in STD_LOGIC_VECTOR(31 downto 0);
            Next_RED_ALU_RESULTS : in STD_LOGIC_VECTOR(31 downto 0);
            Next_RED_ALU_ZERO    : in STD_LOGIC;
            Next_RED_BRANCH      : in STD_LOGIC;
            Next_RED_MEM_TO_REG  : in STD_LOGIC;
            Next_RED_MEM_READ    : in STD_LOGIC;
            Next_RED_MEM_WRITE   : in STD_LOGIC;
            Next_RED_REG_WRITE_CTRL : in STD_LOGIC;
            RED_ALU_INPUT_B      : out STD_LOGIC_VECTOR(31 downto 0);
            RED_BRANCH_TARGET    : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_OUT  : out STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_RESULTS      : out STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_ZERO         : out STD_LOGIC;
            RED_BRANCH           : out STD_LOGIC;
            RED_MEM_TO_REG       : out STD_LOGIC;
            RED_MEM_READ         : out STD_LOGIC;
            RED_MEM_WRITE        : out STD_LOGIC;
            RED_REG_WRITE_CTRL   : out STD_LOGIC
        );
    end component;


-- Signals for RED_STAGE1
signal RED_STAGE1_INPUT_RED_SELECT         : STD_LOGIC;
signal RED_STAGE1_INPUT_RED_BRANCH_ADD     : STD_LOGIC_VECTOR(63 downto 0);

signal RED_STAGE1_OUTPUT_RED_ADDRESS       : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE1_OUTPUT_RED_INSTRUCTION   : STD_LOGIC_VECTOR(31 downto 0);

-- Signals for RED_STAGE2
signal RED_STAGE2_INPUT_RED_INSTRUCTION    : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE2_INPUT_RED_ADDRESS        : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE2_INPUT_RED_WRITE_DATA     : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE2_INPUT_RED_WRITE_REG      : STD_LOGIC_VECTOR(4 downto 0);
signal RED_STAGE2_INPUT_RED_REG_WRITE_IN   : STD_LOGIC;

signal RED_STAGE2_OUTPUT_RED_ADDRESS_OUT     : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE2_OUTPUT_RED_DATA1           : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE2_OUTPUT_RED_DATA2           : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE2_OUTPUT_RED_EXTENDET_IMM    : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE2_OUTPUT_RED_INSTRUCTION_OUT : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE2_OUTPUT_RED_ALU_OP          : STD_LOGIC_VECTOR(3 downto 0);
signal RED_STAGE2_OUTPUT_RED_ALU_SRC         : STD_LOGIC;
signal RED_STAGE2_OUTPUT_RED_BRANCH          : STD_LOGIC;
signal RED_STAGE2_OUTPUT_RED_MEM_TO_REG      : STD_LOGIC;
signal RED_STAGE2_OUTPUT_RED_MEM_READ        : STD_LOGIC;
signal RED_STAGE2_OUTPUT_RED_MEM_WRITE       : STD_LOGIC;
signal RED_STAGE2_OUTPUT_RED_REG_WRITE_CTRL  : STD_LOGIC;

-- Signals for RED_STAGE3
signal RED_STAGE3_INPUT_RED_PC_IN             : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE3_INPUT_RED_READ_DATA1_IN     : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE3_INPUT_RED_READ_DATA2_IN     : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE3_INPUT_RED_IMMEDIATE_IN      : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE3_INPUT_RED_INSTRUCTION_IN    : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE3_INPUT_RED_ALU_SRC_IN        : STD_LOGIC;
signal RED_STAGE3_INPUT_RED_BRANCH_IN         : STD_LOGIC;
signal RED_STAGE3_INPUT_RED_MEM_TO_REG_IN     : STD_LOGIC;
signal RED_STAGE3_INPUT_RED_MEM_READ_IN       : STD_LOGIC;
signal RED_STAGE3_INPUT_RED_MEM_WRITE_IN      : STD_LOGIC;
signal RED_STAGE3_INPUT_RED_REG_WRITE_CTRL_IN : STD_LOGIC;
signal RED_STAGE3_INPUT_RED_ALU_OP_IN         : STD_LOGIC_VECTOR(3 downto 0);

signal RED_STAGE3_OUTPUT_RED_INSTRUCTION_OUT  : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE3_OUTPUT_RED_ALU_INPUT_B      : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE3_OUTPUT_RED_BRANCH_TARGET    : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE3_OUTPUT_RED_ALU_RESULTS      : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE3_OUTPUT_RED_ALU_ZERO         : STD_LOGIC;
signal RED_STAGE3_OUTPUT_RED_BRANCH           : STD_LOGIC;
signal RED_STAGE3_OUTPUT_RED_MEM_TO_REG       : STD_LOGIC;
signal RED_STAGE3_OUTPUT_RED_MEM_READ         : STD_LOGIC;
signal RED_STAGE3_OUTPUT_RED_MEM_WRITE        : STD_LOGIC;
signal RED_STAGE3_OUTPUT_RED_REG_WRITE_CTRL   : STD_LOGIC;

-- Signals for RED_STAGE4
signal RED_STAGE4_INPUT_RED_MEM_TO_REG_IN     : STD_LOGIC;
signal RED_STAGE4_INPUT_RED_MEM_READ_IN       : STD_LOGIC;
signal RED_STAGE4_INPUT_RED_MEM_WRITE_IN      : STD_LOGIC;
signal RED_STAGE4_INPUT_RED_REG_WRITE_CTRL_IN : STD_LOGIC;
signal RED_STAGE4_INPUT_RED_ALU_RESULTS_IN    : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE4_INPUT_RED_ALU_ZERO_IN       : STD_LOGIC;
signal RED_STAGE4_INPUT_RED_ALU_INPUT_B_IN    : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE4_INPUT_RED_BRANCH_IN         : STD_LOGIC;
signal RED_STAGE4_INPUT_RED_BRANCH_TARGET_IN  : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE4_INPUT_RED_INSTRUCTION_IN    : STD_LOGIC_VECTOR(31 downto 0);

signal RED_STAGE4_OUTPUT_RED_REG_WRITE_CTRL_OUT : STD_LOGIC;
signal RED_STAGE4_OUTPUT_RED_INSTRUCTION_OUT    : STD_LOGIC_VECTOR(31 downto 0);
signal RED_STAGE4_OUTPUT_RED_BRANCH_SELECT      : STD_LOGIC;
signal RED_STAGE4_OUTPUT_RED_BRANCH_TARGET      : STD_LOGIC_VECTOR(63 downto 0);
signal RED_STAGE4_OUTPUT_RED_WRITE_BACK_DATA    : STD_LOGIC_VECTOR(31 downto 0);

begin


STAGE1 : RED_STAGE1  Port map (
            -- Inputs
				RED_CLOCK         => RED_CLOCK,
            RED_SELECT       => RED_STAGE1_INPUT_RED_SELECT,
            RED_BRAMCH_ADD   => RED_STAGE1_INPUT_RED_BRANCH_ADD,

            -- Outputs
            RED_ADDRESS      => RED_STAGE1_OUTPUT_RED_ADDRESS,
            RED_INSTRUCTION  => RED_STAGE1_OUTPUT_RED_INSTRUCTION
);


REG1 : RED_REG1  Port map (
            RED_CLOCK         => RED_CLOCK,
            Next_RED_ADDRESS  => RED_STAGE1_OUTPUT_RED_ADDRESS,
            Next_RED_INSTRUCTION => RED_STAGE1_OUTPUT_RED_INSTRUCTION	,
            RED_ADDRESS_REG   => RED_STAGE2_INPUT_RED_ADDRESS,
            RED_INSTRUCTION_REG => RED_STAGE2_INPUT_RED_INSTRUCTION
        );
		 
STAGE2 : RED_STAGE2 port map ( 
				 -- Inputs
				RED_CLOCK          => RED_CLOCK,
            RED_INSTRUCTION 	 => RED_STAGE2_INPUT_RED_INSTRUCTION,
            RED_ADDRESS    	 => RED_STAGE2_INPUT_RED_ADDRESS,
            RED_WRITE_DATA   	 => RED_STAGE2_INPUT_RED_WRITE_DATA ,
            RED_WRITE_REG      => RED_STAGE2_INPUT_RED_WRITE_REG ,
            RED_REG_WRITE_IN   => RED_STAGE2_INPUT_RED_REG_WRITE_IN,  

            -- Outputs
            RED_ADDRESS_OUT    => RED_STAGE2_OUTPUT_RED_ADDRESS_OUT,
            RED_DATA1          => RED_STAGE2_OUTPUT_RED_DATA1,
            RED_DATA2          =>  RED_STAGE2_OUTPUT_RED_DATA2,
            RED_EXTENDET_IMM   =>  RED_STAGE2_OUTPUT_RED_EXTENDET_IMM,
            RED_INSTRUCTION_OUT  => RED_STAGE2_OUTPUT_RED_INSTRUCTION_OUT,

            -- Control signals
            RED_ALU_OP           => RED_STAGE2_OUTPUT_RED_ALU_OP,
            RED_ALU_SRC          => RED_STAGE2_OUTPUT_RED_ALU_SRC,
            RED_BRANCH           => RED_STAGE2_OUTPUT_RED_BRANCH,
            RED_MEM_TO_REG       => RED_STAGE2_OUTPUT_RED_MEM_TO_REG,
            RED_MEM_READ         => RED_STAGE2_OUTPUT_RED_MEM_READ,
            RED_MEM_WRITE        => RED_STAGE2_OUTPUT_RED_MEM_WRITE,
            RED_REG_WRITE_CTRL   => RED_STAGE2_OUTPUT_RED_REG_WRITE_CTRL
				);
				
REG2 : RED_REG2 port map(
				RED_CLOCK   =>         RED_CLOCK,
            Next_RED_ADDRESS_OUT => RED_STAGE2_OUTPUT_RED_ADDRESS_OUT ,
            Next_RED_DATA1       => RED_STAGE2_OUTPUT_RED_DATA1,
            Next_RED_DATA2       => RED_STAGE2_OUTPUT_RED_DATA2,
            Next_RED_EXTENDET_IMM  =>  RED_STAGE2_OUTPUT_RED_EXTENDET_IMM,
            Next_RED_INSTRUCTION_OUT => RED_STAGE2_OUTPUT_RED_INSTRUCTION_OUT,
            Next_RED_ALU_OP      => RED_STAGE2_OUTPUT_RED_ALU_OP,
            Next_RED_ALU_SRC     => RED_STAGE2_OUTPUT_RED_ALU_SRC,
            Next_RED_BRANCH      => RED_STAGE2_OUTPUT_RED_BRANCH,
            Next_RED_MEM_TO_REG  => RED_STAGE2_OUTPUT_RED_MEM_TO_REG,
            Next_RED_MEM_READ    => RED_STAGE2_OUTPUT_RED_MEM_READ,
            Next_RED_MEM_WRITE   => RED_STAGE2_OUTPUT_RED_MEM_WRITE,
            Next_RED_REG_WRITE_CTRL => RED_STAGE2_OUTPUT_RED_REG_WRITE_CTRL,
            RED_ADDRESS_OUT      => RED_STAGE3_INPUT_RED_PC_IN,
            RED_DATA1            => RED_STAGE3_INPUT_RED_READ_DATA1_IN,
            RED_DATA2            => RED_STAGE3_INPUT_RED_READ_DATA2_IN,
            RED_EXTENDET_IMM     => RED_STAGE3_INPUT_RED_IMMEDIATE_IN,
            RED_INSTRUCTION_OUT  => RED_STAGE3_INPUT_RED_INSTRUCTION_IN,
            RED_ALU_OP           => RED_STAGE3_INPUT_RED_ALU_OP_IN,
            RED_ALU_SRC          => RED_STAGE3_INPUT_RED_ALU_SRC_IN,
            RED_BRANCH           => RED_STAGE3_INPUT_RED_BRANCH_IN,
            RED_MEM_TO_REG       => RED_STAGE3_INPUT_RED_MEM_TO_REG_IN,
            RED_MEM_READ         => RED_STAGE3_INPUT_RED_MEM_READ_IN,
            RED_MEM_WRITE        => RED_STAGE3_INPUT_RED_MEM_WRITE_IN,
            RED_REG_WRITE_CTRL   => RED_STAGE3_INPUT_RED_REG_WRITE_CTRL_IN
				);
				
STAGE3 : RED_STAGE3 port map(
				 -- Inputs
				RED_CLOCK             => RED_CLOCK,
            RED_PC_IN             => RED_STAGE3_INPUT_RED_PC_IN,
            RED_READ_DATA1_IN     => RED_STAGE3_INPUT_RED_READ_DATA1_IN,
            RED_READ_DATA2_IN     => RED_STAGE3_INPUT_RED_READ_DATA2_IN,
            RED_IMMEDIATE_IN      => RED_STAGE3_INPUT_RED_IMMEDIATE_IN,
            RED_INSTRUCTION_IN    => RED_STAGE3_INPUT_RED_INSTRUCTION_IN,

            -- Control Signals In
            RED_ALU_SRC_IN        => RED_STAGE3_INPUT_RED_ALU_SRC_IN ,
            RED_BRANCH_IN         => RED_STAGE3_INPUT_RED_BRANCH_IN,
            RED_MEM_TO_REG_IN     => RED_STAGE3_INPUT_RED_MEM_TO_REG_IN ,
            RED_MEM_READ_IN       => RED_STAGE3_INPUT_RED_MEM_READ_IN,
            RED_MEM_WRITE_IN      => RED_STAGE3_INPUT_RED_MEM_WRITE_IN,
            RED_REG_WRITE_CTRL_IN => RED_STAGE3_INPUT_RED_REG_WRITE_CTRL_IN,
            RED_ALU_OP_IN         => RED_STAGE3_INPUT_RED_ALU_OP_IN ,

            -- Outputs
            RED_ALU_INPUT_B       => RED_STAGE3_OUTPUT_RED_ALU_INPUT_B,
            RED_BRANCH_TARGET     => RED_STAGE3_OUTPUT_RED_BRANCH_TARGET ,
				RED_INSTRUCTION_OUT   => RED_STAGE3_OUTPUT_RED_INSTRUCTION_OUT,
            RED_ALU_RESULTS       => RED_STAGE3_OUTPUT_RED_ALU_RESULTS,
            RED_ALU_ZERO          => RED_STAGE3_OUTPUT_RED_ALU_ZERO ,

            -- Control Signals Out
            RED_BRANCH            => RED_STAGE3_OUTPUT_RED_BRANCH,
            RED_MEM_TO_REG        => RED_STAGE3_OUTPUT_RED_MEM_TO_REG,
            RED_MEM_READ          => RED_STAGE3_OUTPUT_RED_MEM_READ,
            RED_MEM_WRITE         =>  RED_STAGE3_OUTPUT_RED_MEM_WRITE,
            RED_REG_WRITE_CTRL    => RED_STAGE3_OUTPUT_RED_REG_WRITE_CTRL
				);

REG3 : RED_REG3 port map(
				RED_CLOCK             =>  RED_CLOCK,
            Next_RED_ALU_INPUT_B => RED_STAGE3_OUTPUT_RED_ALU_INPUT_B,
            Next_RED_BRANCH_TARGET => RED_STAGE3_OUTPUT_RED_BRANCH_TARGET,
            Next_RED_INSTRUCTION_OUT => RED_STAGE3_OUTPUT_RED_INSTRUCTION_OUT,
            Next_RED_ALU_RESULTS => RED_STAGE3_OUTPUT_RED_ALU_RESULTS,
            Next_RED_ALU_ZERO    => RED_STAGE3_OUTPUT_RED_ALU_ZERO,
            Next_RED_BRANCH      => RED_STAGE3_OUTPUT_RED_BRANCH,
            Next_RED_MEM_TO_REG  => RED_STAGE3_OUTPUT_RED_MEM_TO_REG,
            Next_RED_MEM_READ    => RED_STAGE3_OUTPUT_RED_MEM_READ,
            Next_RED_MEM_WRITE   => RED_STAGE3_OUTPUT_RED_MEM_WRITE,
            Next_RED_REG_WRITE_CTRL => RED_STAGE3_OUTPUT_RED_REG_WRITE_CTRL,
            RED_ALU_INPUT_B      => RED_STAGE4_INPUT_RED_ALU_INPUT_B_IN,
            RED_BRANCH_TARGET    => RED_STAGE4_INPUT_RED_BRANCH_TARGET_IN ,
            RED_INSTRUCTION_OUT  => RED_STAGE4_INPUT_RED_INSTRUCTION_IN,
            RED_ALU_RESULTS      => RED_STAGE4_INPUT_RED_ALU_RESULTS_IN,
            RED_ALU_ZERO         => RED_STAGE4_INPUT_RED_ALU_ZERO_IN,
            RED_BRANCH           => RED_STAGE4_INPUT_RED_BRANCH_IN,
            RED_MEM_TO_REG       => RED_STAGE4_INPUT_RED_MEM_TO_REG_IN,
            RED_MEM_READ         => RED_STAGE4_INPUT_RED_MEM_READ_IN,
            RED_MEM_WRITE        => RED_STAGE4_INPUT_RED_MEM_WRITE_IN,
            RED_REG_WRITE_CTRL   => RED_STAGE4_INPUT_RED_REG_WRITE_CTRL_IN
				);
				
				
STAGE4 : RED_STAGE4 port map(
				   -- Inputs from Stage 3
				RED_CLOCK              => RED_CLOCK,
            RED_MEM_TO_REG_IN      => RED_STAGE4_INPUT_RED_MEM_TO_REG_IN,
            RED_MEM_READ_IN        => RED_STAGE4_INPUT_RED_MEM_READ_IN,
            RED_MEM_WRITE_IN       => RED_STAGE4_INPUT_RED_MEM_WRITE_IN,
            RED_REG_WRITE_CTRL_IN  => RED_STAGE4_INPUT_RED_REG_WRITE_CTRL_IN,
            RED_ALU_RESULTS_IN     => RED_STAGE4_INPUT_RED_ALU_RESULTS_IN,
            RED_ALU_ZERO_IN        => RED_STAGE4_INPUT_RED_ALU_ZERO_IN,
            RED_ALU_INPUT_B_IN     => RED_STAGE4_INPUT_RED_ALU_INPUT_B_IN,
            RED_BRANCH_IN          => RED_STAGE4_INPUT_RED_BRANCH_IN,
            RED_BRANCH_TARGET_IN   => RED_STAGE4_INPUT_RED_BRANCH_TARGET_IN,
            RED_INSTRUCTION_IN     => RED_STAGE4_INPUT_RED_INSTRUCTION_IN ,

            -- Outputs
            RED_REG_WRITE_CTRL_OUT =>  RED_STAGE4_OUTPUT_RED_REG_WRITE_CTRL_OUT,
            RED_INSTRUCTION_OUT    => RED_STAGE4_OUTPUT_RED_INSTRUCTION_OUT,
            RED_BRANCH_SELECT      => RED_STAGE4_OUTPUT_RED_BRANCH_SELECT ,
            RED_BRANCH_TARGET      => RED_STAGE4_OUTPUT_RED_BRANCH_TARGET ,
            RED_WRITE_BACK_DATA    => RED_STAGE4_OUTPUT_RED_WRITE_BACK_DATA  
				);
				
				
				RED_STAGE1_INPUT_RED_BRANCH_ADD <=RED_STAGE4_OUTPUT_RED_BRANCH_TARGET;
				RED_STAGE2_INPUT_RED_WRITE_REG <= RED_STAGE4_INPUT_RED_INSTRUCTION_IN(11 downto 7);
				RED_STAGE2_INPUT_RED_WRITE_DATA <= RED_STAGE4_OUTPUT_RED_WRITE_BACK_DATA;
				RED_STAGE2_INPUT_RED_REG_WRITE_IN <= RED_STAGE4_OUTPUT_RED_REG_WRITE_CTRL_OUT;
				RED_STAGE1_INPUT_RED_SELECT <= RED_STAGE4_OUTPUT_RED_BRANCH_SELECT;
end Behavioral;
