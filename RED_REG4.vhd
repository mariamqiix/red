library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- REG2: Pipeline register between STAGE2 and STAGE3
entity RED_REG4 is
    Port (
        RED_CLOCK               : in  STD_LOGIC;
        -- Inputs from Stage 2
        Next_RED_REG_WRITE_CTRL : in  STD_LOGIC;
        Next_RED_INSTRUCTION_OUT: in  STD_LOGIC_VECTOR(31 downto 0);
        Next_RED_BRANCH_SELECT  : in  STD_LOGIC;
        Next_RED_BRANCH_TARGET  : in  STD_LOGIC_VECTOR(63 downto 0);
        Next_RED_WRITE_BACK_DATA: in  STD_LOGIC_VECTOR(31 downto 0);

        -- Outputs for Stage 3
        RED_REG_WRITE_CTRL_OUT  : out STD_LOGIC;
        RED_INSTRUCTION_OUT     : out STD_LOGIC_VECTOR(31 downto 0);
        RED_BRANCH_SELECT       : out STD_LOGIC;
        RED_BRANCH_TARGET       : out STD_LOGIC_VECTOR(63 downto 0);
        RED_WRITE_BACK_DATA     : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_REG4;

-- REG2 Architecture
architecture Behavioral of RED_REG4 is
    -- Declare internal signals to hold next values
    signal next_temp_reg_write_ctrl : STD_LOGIC;
    signal next_temp_instruction_out : STD_LOGIC_VECTOR(31 downto 0);
    signal next_temp_branch_select   : STD_LOGIC;
    signal next_temp_branch_target   : STD_LOGIC_VECTOR(63 downto 0);
    signal next_temp_write_back_data : STD_LOGIC_VECTOR(31 downto 0);

begin
    -- Process to store next values in temporary signals
    process(RED_CLOCK)
    begin
        if rising_edge(RED_CLOCK) then
            -- Save the current values of next_temp into the output
            RED_REG_WRITE_CTRL_OUT <= next_temp_reg_write_ctrl;
            RED_INSTRUCTION_OUT    <= next_temp_instruction_out;
            RED_BRANCH_SELECT      <= next_temp_branch_select;
            RED_BRANCH_TARGET      <= next_temp_branch_target;
            RED_WRITE_BACK_DATA    <= next_temp_write_back_data;

            -- Now, update the next_temp values with the current inputs
            next_temp_reg_write_ctrl <= Next_RED_REG_WRITE_CTRL;
            next_temp_instruction_out <= Next_RED_INSTRUCTION_OUT;
            next_temp_branch_select   <= Next_RED_BRANCH_SELECT;
            next_temp_branch_target   <= Next_RED_BRANCH_TARGET;
            next_temp_write_back_data <= Next_RED_WRITE_BACK_DATA;
        end if;
    end process;
end Behavioral;
