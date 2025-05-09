library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- REG2: Pipeline register between STAGE2 and STAGE3
entity RED_REG2 is
    Port (
        RED_CLOCK               : in  STD_LOGIC;
        -- Inputs from Stage 2
        Next_RED_ADDRESS_OUT    : in  STD_LOGIC_VECTOR(63 downto 0);
        Next_RED_DATA1          : in  STD_LOGIC_VECTOR(31 downto 0);
        Next_RED_DATA2          : in  STD_LOGIC_VECTOR(31 downto 0);
        Next_RED_EXTENDET_IMM   : in  STD_LOGIC_VECTOR(63 downto 0);
        Next_RED_INSTRUCTION_OUT: in  STD_LOGIC_VECTOR(31 downto 0);

        -- Control signals from Stage 2
        Next_RED_ALU_OP         : in  STD_LOGIC_VECTOR(3 downto 0);
        Next_RED_ALU_SRC        : in  STD_LOGIC;
        Next_RED_BRANCH         : in  STD_LOGIC;
        Next_RED_MEM_TO_REG     : in  STD_LOGIC;
        Next_RED_MEM_READ       : in  STD_LOGIC;
        Next_RED_MEM_WRITE      : in  STD_LOGIC;
        Next_RED_REG_WRITE_CTRL : in  STD_LOGIC;

        -- Outputs for Stage 3
        RED_ADDRESS_OUT         : out STD_LOGIC_VECTOR(63 downto 0);
        RED_DATA1               : out STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA2               : out STD_LOGIC_VECTOR(31 downto 0);
        RED_EXTENDET_IMM        : out STD_LOGIC_VECTOR(63 downto 0);
        RED_INSTRUCTION_OUT     : out STD_LOGIC_VECTOR(31 downto 0);

        -- Control signals for Stage 3
        RED_ALU_OP              : out STD_LOGIC_VECTOR(3 downto 0);
        RED_ALU_SRC             : out STD_LOGIC;
        RED_BRANCH              : out STD_LOGIC;
        RED_MEM_TO_REG          : out STD_LOGIC;
        RED_MEM_READ            : out STD_LOGIC;
        RED_MEM_WRITE           : out STD_LOGIC;
        RED_REG_WRITE_CTRL      : out STD_LOGIC
    );
end RED_REG2;

-- REG2 Architecture
architecture Behavioral of RED_REG2 is
    -- Declare internal signals to hold next values
    signal next_temp_address_out : STD_LOGIC_VECTOR(63 downto 0);
    signal next_temp_data1        : STD_LOGIC_VECTOR(31 downto 0);
    signal next_temp_data2        : STD_LOGIC_VECTOR(31 downto 0);
    signal next_temp_ext_imm      : STD_LOGIC_VECTOR(63 downto 0);
    signal next_temp_instruction  : STD_LOGIC_VECTOR(31 downto 0);

    -- Declare internal control signals for stage 3
    signal next_temp_alu_op      : STD_LOGIC_VECTOR(3 downto 0);
    signal next_temp_alu_src     : STD_LOGIC;
    signal next_temp_branch      : STD_LOGIC;
    signal next_temp_mem_to_reg  : STD_LOGIC;
    signal next_temp_mem_read    : STD_LOGIC;
    signal next_temp_mem_write   : STD_LOGIC;
    signal next_temp_reg_write_ctrl : STD_LOGIC;

	 begin

		-- Save the current values of next_temp into the output
		RED_ADDRESS_OUT        <= next_temp_address_out;
		RED_DATA1              <= next_temp_data1;
		RED_DATA2              <= next_temp_data2;
		RED_EXTENDET_IMM       <= next_temp_ext_imm;
		RED_INSTRUCTION_OUT    <= next_temp_instruction;
		RED_ALU_OP             <= next_temp_alu_op;
		RED_ALU_SRC            <= next_temp_alu_src;
		RED_BRANCH             <= next_temp_branch;
		RED_MEM_TO_REG         <= next_temp_mem_to_reg;
		RED_MEM_READ           <= next_temp_mem_read;
		RED_MEM_WRITE          <= next_temp_mem_write;
		RED_REG_WRITE_CTRL     <= next_temp_reg_write_ctrl;
		
 -- Process to store next values in temporary signals
    process(RED_CLOCK)
    begin
        if RED_CLOCK = '1' then


            -- Update the next_temp values with the current inputs
            next_temp_address_out  <= Next_RED_ADDRESS_OUT;
            next_temp_data1        <= Next_RED_DATA1;
            next_temp_data2        <= Next_RED_DATA2;
            next_temp_ext_imm      <= Next_RED_EXTENDET_IMM;
            next_temp_instruction  <= Next_RED_INSTRUCTION_OUT;
            next_temp_alu_op       <= Next_RED_ALU_OP;
            next_temp_alu_src      <= Next_RED_ALU_SRC;
            next_temp_branch       <= Next_RED_BRANCH;
            next_temp_mem_to_reg   <= Next_RED_MEM_TO_REG;
            next_temp_mem_read     <= Next_RED_MEM_READ;
            next_temp_mem_write    <= Next_RED_MEM_WRITE;
            next_temp_reg_write_ctrl <= Next_RED_REG_WRITE_CTRL;
        end if;
    end process;
end Behavioral;
