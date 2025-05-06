library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_STAGE3 is
    Port (
        -- Inputs
		  RED_CLOCK               : in STD_LOGIC;
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
end RED_STAGE3;



architecture Behavioral of RED_STAGE3 is

    signal RED_SHIFTED_OFFSET : STD_LOGIC_VECTOR(63 downto 0);
    signal RED_ALU_INPUT_B_INT : STD_LOGIC_VECTOR(31 downto 0);

    -- Component declarations

    component RED_MUX_FOR_ALU_SRC
        Port (
		      RED_CLOCK     : in STD_LOGIC;
            RED_SELECT    : in  STD_LOGIC;
            RED_INPUT_A   : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_INPUT_B   : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_OUTPUT    : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component RED_ADDER_FOR_BRANCH
        Port (
		      RED_CLOCK        : in STD_LOGIC;
            RED_PC           : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_OFFSET       : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_BRANCH_ADDER : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

    component RED_ALU
        Port (
		      RED_CLOCK         : in STD_LOGIC;
            RED_INPUT_A       : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_INPUT_B       : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_CTRL      : in  STD_LOGIC_VECTOR(3 downto 0);
            RED_ALU_RESULTS   : out STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_ZERO      : out STD_LOGIC
        );
    end component;

    component RED_SL_BY_1
        Port (
		      RED_CLOCK               : in STD_LOGIC;
            RED_INPUT  : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_OUTPUT : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;


begin

    -- Shift immediate left by 1
    RED_SHIFT_IMM: RED_SL_BY_1
        Port map (
		      RED_CLOCK  => RED_CLOCK,
            RED_INPUT  => RED_IMMEDIATE_IN,
            RED_OUTPUT => RED_SHIFTED_OFFSET
        );


    -- Branch target address = PC + shifted immediate
    RED_BRANCH_ADDR: RED_ADDER_FOR_BRANCH
        Port map (
		      RED_CLOCK        => RED_CLOCK,
            RED_PC           => RED_PC_IN,
            RED_OFFSET       => RED_SHIFTED_OFFSET,
            RED_BRANCH_ADDER => RED_BRANCH_TARGET
        );

    -- ALU input B selection
    RED_ALU_SRC_MUX: RED_MUX_FOR_ALU_SRC
        Port map (
		      RED_CLOCK    => RED_CLOCK,
            RED_SELECT   => RED_ALU_SRC_IN,
            RED_INPUT_A  => RED_READ_DATA2_IN,
            RED_INPUT_B  => RED_IMMEDIATE_IN(31 downto 0),
            RED_OUTPUT   => RED_ALU_INPUT_B_INT
        );


    -- ALU Operation
    RED_MAIN_ALU: RED_ALU
        Port map (
		      RED_CLOCK       => RED_CLOCK,
            RED_INPUT_A     => RED_READ_DATA1_IN,
            RED_INPUT_B     => RED_ALU_INPUT_B_INT,
            RED_ALU_CTRL    => RED_ALU_OP_IN,
            RED_ALU_RESULTS => RED_ALU_RESULTS,
            RED_ALU_ZERO    => RED_ALU_ZERO
        );


    -- Pass-through signals
	 	RED_ALU_INPUT_B <= RED_READ_DATA2_IN;
		RED_INSTRUCTION_OUT <= RED_INSTRUCTION_IN;

    -- Control signal forwarding
    RED_BRANCH          <= RED_BRANCH_IN;
    RED_MEM_TO_REG      <= RED_MEM_TO_REG_IN;
    RED_MEM_READ        <= RED_MEM_READ_IN;
    RED_MEM_WRITE       <= RED_MEM_WRITE_IN;
    RED_REG_WRITE_CTRL  <= RED_REG_WRITE_CTRL_IN;

end Behavioral;
