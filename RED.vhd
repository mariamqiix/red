library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RED is
    Port (
        RED_INPUT   : in  STD_LOGIC_VECTOR(7 downto 0);
        RED_CLOCK   : in  STD_LOGIC
    );
end RED;

architecture Behavioral of RED is

    
    -- Component instantiations for each pipeline stage
    component RED_STAGE1 is
        Port (
            -- Inputs
            RED_SELECT       : in  STD_LOGIC;
            RED_SIGNAL_PC_P4 : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_BRAMCH_ADD   : in  STD_LOGIC_VECTOR(63 downto 0);

            -- Outputs
            RED_ADDRESS      : out STD_LOGIC_VECTOR(63 downto 0);
            RED_PC_P4        : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component RED_STAGE2 is
        Port (
            -- Inputs
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
            Next_RED_PC_P4    : in STD_LOGIC_VECTOR(63 downto 0);
            RED_ADDRESS_REG   : out STD_LOGIC_VECTOR(63 downto 0);
            RED_INSTRUCTION_REG : out STD_LOGIC_VECTOR(31 downto 0);
            RED_PC_P4         : out STD_LOGIC_VECTOR(63 downto 0)
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
            RED_REG_WRITE_CTRL   : out STD_LOGIC;
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
            RED_REG_WRITE_CTRL   : out STD_LOGIC;
        );
    end component;

begin

  

end Behavioral;
