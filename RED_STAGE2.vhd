library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_STAGE2 is
    Port (
        -- Inputs
		  RED_CLOCK       : in STD_LOGIC;
        RED_INSTRUCTION : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_ADDRESS     : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_WRITE_DATA  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_WRITE_REG   : in  STD_LOGIC_VECTOR(4 downto 0);
        RED_REG_WRITE_IN: in  STD_LOGIC;  -- External write enable for register file

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
end RED_STAGE2;


architecture Behavioral of RED_STAGE2 is

    -- Component declarations
    component RED_CONTROL_UNIT
        Port (
		      RED_CLOCK        : in STD_LOGIC;
            RED_INSTRUCTION  : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_ALU_OP       : out STD_LOGIC_VECTOR(3 downto 0);
            RED_ALU_SRC      : out STD_LOGIC;
            RED_BRANCH       : out STD_LOGIC;
            RED_MEM_TO_Reg   : out STD_LOGIC;
            RED_REG_WRITE    : out STD_LOGIC;
            RED_MEM_READ     : out STD_LOGIC;
            RED_MEM_WRITE    : out STD_LOGIC
        );
    end component;

    component RED_REGISTER_FILE
        Port (
		      RED_CLOCK         : in STD_LOGIC;
            RED_REG_WRITE     : in  STD_LOGIC;
            RED_REG1          : in  STD_LOGIC_VECTOR(4 downto 0);
            RED_REG2          : in  STD_LOGIC_VECTOR(4 downto 0);
            RED_WRITE_REG     : in  STD_LOGIC_VECTOR(4 downto 0);
            RED_WRITE_DATA    : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_DATA1         : out STD_LOGIC_VECTOR(31 downto 0);
            RED_DATA2         : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component RED_IMM_GEN
        Port (
		      RED_CLOCK         : in STD_LOGIC;
            RED_IMM           : in  STD_LOGIC_VECTOR(31 downto 0);
            RED_EXTENDET_IMM  : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

    signal internal_reg_write_ctrl : STD_LOGIC;

begin

    -- Control unit
    CU: RED_CONTROL_UNIT
        Port map (
		      RED_CLOCK        => RED_CLOCK,
            RED_INSTRUCTION  => RED_INSTRUCTION,
            RED_ALU_OP       => RED_ALU_OP,
            RED_ALU_SRC      => RED_ALU_SRC,
            RED_BRANCH       => RED_BRANCH,
            RED_MEM_TO_Reg   => RED_MEM_TO_REG,
            RED_REG_WRITE    => internal_reg_write_ctrl,
            RED_MEM_READ     => RED_MEM_READ,
            RED_MEM_WRITE    => RED_MEM_WRITE
        );

    -- Assign internal reg write signal to output
    RED_REG_WRITE_CTRL <= internal_reg_write_ctrl;

    -- Register File
    RF: RED_REGISTER_FILE
        Port map (
		      RED_CLOCK      => RED_CLOCK,
            RED_REG_WRITE  => RED_REG_WRITE_IN,
            RED_REG1       => RED_INSTRUCTION(19 downto 15),
            RED_REG2       => RED_INSTRUCTION(24 downto 20),
            RED_WRITE_REG  => RED_WRITE_REG,
            RED_WRITE_DATA => RED_WRITE_DATA,
            RED_DATA1      => RED_DATA1,
            RED_DATA2      => RED_DATA2
        );

    -- Immediate Generator
    IG: RED_IMM_GEN
        Port map (
		      RED_CLOCK         => RED_CLOCK,
            RED_IMM           => RED_INSTRUCTION,
            RED_EXTENDET_IMM  => RED_EXTENDET_IMM
        );

    -- Pass-throughs
    RED_ADDRESS_OUT     <= RED_ADDRESS;
    RED_INSTRUCTION_OUT <= RED_INSTRUCTION;

end Behavioral;