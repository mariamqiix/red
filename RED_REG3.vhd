library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- REG3: Pipeline register between STAGE3 and STAGE4
entity RED_REG3 is
    Port (
        RED_CLOCK               : in  STD_LOGIC;
        -- Inputs from Stage 3
        Next_RED_ALU_INPUT_B    : in  STD_LOGIC_VECTOR(31 downto 0);
        Next_RED_BRANCH_TARGET  : in  STD_LOGIC_VECTOR(63 downto 0);
        Next_RED_INSTRUCTION_OUT: in  STD_LOGIC_VECTOR(31 downto 0);
        Next_RED_ALU_RESULTS    : in  STD_LOGIC_VECTOR(31 downto 0);
        Next_RED_ALU_ZERO       : in  STD_LOGIC;

        -- Control signals from Stage 3
        Next_RED_BRANCH         : in  STD_LOGIC;
        Next_RED_MEM_TO_REG     : in  STD_LOGIC;
        Next_RED_MEM_READ       : in  STD_LOGIC;
        Next_RED_MEM_WRITE      : in  STD_LOGIC;
        Next_RED_REG_WRITE_CTRL : in  STD_LOGIC;

        -- Outputs for Stage 4
        RED_ALU_INPUT_B         : out STD_LOGIC_VECTOR(31 downto 0);
        RED_BRANCH_TARGET       : out STD_LOGIC_VECTOR(63 downto 0);
        RED_INSTRUCTION_OUT     : out STD_LOGIC_VECTOR(31 downto 0);
        RED_ALU_RESULTS         : out STD_LOGIC_VECTOR(31 downto 0);
        RED_ALU_ZERO            : out STD_LOGIC;

        -- Control Signals for Stage 4
        RED_BRANCH              : out STD_LOGIC;
        RED_MEM_TO_REG          : out STD_LOGIC;
        RED_MEM_READ            : out STD_LOGIC;
        RED_MEM_WRITE           : out STD_LOGIC;
        RED_REG_WRITE_CTRL      : out STD_LOGIC
    );
end entity;

-- REG3 Architecture
architecture Behavioral of RED_REG3 is
    -- Declare internal signals to hold next values
    signal next_temp_alu_input_b  : STD_LOGIC_VECTOR(31 downto 0);
    signal next_temp_branch_target : STD_LOGIC_VECTOR(63 downto 0);
    signal next_temp_instruction   : STD_LOGIC_VECTOR(31 downto 0);
    signal next_temp_alu_results   : STD_LOGIC_VECTOR(31 downto 0);
    signal next_temp_alu_zero      : STD_LOGIC;

    -- Declare internal control signals for stage 4
    signal next_temp_branch        : STD_LOGIC;
    signal next_temp_mem_to_reg    : STD_LOGIC;
    signal next_temp_mem_read      : STD_LOGIC;
    signal next_temp_mem_write     : STD_LOGIC;
    signal next_temp_reg_write_ctrl: STD_LOGIC;

	 begin

 -- Process to store next values in temporary signals
				 -- Save the current values of next_temp into the output
			RED_ALU_INPUT_B    <= next_temp_alu_input_b;
			RED_BRANCH_TARGET  <= next_temp_branch_target;
			RED_INSTRUCTION_OUT <= next_temp_instruction;
			RED_ALU_RESULTS    <= next_temp_alu_results;
			RED_ALU_ZERO       <= next_temp_alu_zero;
			RED_BRANCH         <= next_temp_branch;
			RED_MEM_TO_REG     <= next_temp_mem_to_reg;
			RED_MEM_READ       <= next_temp_mem_read;
			RED_MEM_WRITE      <= next_temp_mem_write;
			RED_REG_WRITE_CTRL <= next_temp_reg_write_ctrl;
			
    process(RED_CLOCK)
    begin
        if rising_edge(RED_CLOCK) then


            -- Update the next_temp values with the current inputs
            next_temp_alu_input_b  <= Next_RED_ALU_INPUT_B;
            next_temp_branch_target <= Next_RED_BRANCH_TARGET;
            next_temp_instruction   <= Next_RED_INSTRUCTION_OUT;
            next_temp_alu_results   <= Next_RED_ALU_RESULTS;
            next_temp_alu_zero      <= Next_RED_ALU_ZERO;
            next_temp_branch        <= Next_RED_BRANCH;
            next_temp_mem_to_reg    <= Next_RED_MEM_TO_REG;
            next_temp_mem_read      <= Next_RED_MEM_READ;
            next_temp_mem_write     <= Next_RED_MEM_WRITE;
            next_temp_reg_write_ctrl<= Next_RED_REG_WRITE_CTRL;
        end if;
    end process;
end Behavioral;
