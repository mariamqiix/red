library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_STAGE4 is
    Port (
	 	  RED_CLOCK        : in STD_LOGIC;
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
end RED_STAGE4;

architecture Behavioral of RED_STAGE4 is

    -- Internal signals
    signal RED_MEM_DATA : STD_LOGIC_VECTOR(31 downto 0);

    -- Component declarations
    component RED_DATA_MEM 
        Port (
			   RED_CLOCK        : in STD_LOGIC;
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

begin

    -- Data memory access
    DATA_MEMORY : RED_DATA_MEM
        port map (
		      RED_CLOCK          => RED_CLOCK,
            RED_MEM_WRITE  => RED_MEM_WRITE_IN,
            RED_MEM_READ   => RED_MEM_READ_IN,
            RED_ADDRESS    => RED_ALU_RESULTS_IN,
            RED_WRITE_DATA => RED_ALU_INPUT_B_IN,
            RED_DATA       => RED_MEM_DATA
        );

    -- Write-back selection mux
    WB_MUX : RED_MUX_FOR_MEM_TO_REG
        port map (
            RED_SELECT      => RED_MEM_TO_REG_IN,
            RED_ALU_RESULTS => RED_ALU_RESULTS_IN,
            RED_MEM_DATA    => RED_MEM_DATA,
            RED_OUTPUT      => RED_WRITE_BACK_DATA
        );

    -- Pass through relevant control/data signals
    RED_REG_WRITE_CTRL_OUT <= RED_REG_WRITE_CTRL_IN;
    RED_INSTRUCTION_OUT    <= RED_INSTRUCTION_IN;
    RED_BRANCH_TARGET      <= RED_BRANCH_TARGET_IN;

    -- Branch decision: branch_select = branch & ~zero (BNE behavior)
    RED_BRANCH_SELECT <= RED_BRANCH_IN and RED_ALU_ZERO_IN;

end Behavioral;
