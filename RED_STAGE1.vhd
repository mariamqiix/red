library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RED_STAGE1 is
    Port (
        -- Inputs
        RED_CLOCK        : in STD_LOGIC;
        RED_SELECT       : in  STD_LOGIC := '0';
        RED_BRAMCH_ADD   : in  STD_LOGIC_VECTOR(63 downto 0);

        -- Outputs
        RED_ADDRESS      : out STD_LOGIC_VECTOR(63 downto 0);
        RED_INSTRUCTION  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_STAGE1;



architecture Behavioral of RED_STAGE1 is

    -- Component Declarations
    component RED_PC
        Port (
		      RED_CLOCK   : in STD_LOGIC;
            RED_INPUT   : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_ADDRESS : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

    component RED_ADDER_FOR_PC_P4
        Port (
		      RED_CLOCK   : in STD_LOGIC;
            RED_PC    : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_PC_P4 : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

    component RED_INST_MEM
        Port (
		      RED_CLOCK   : in STD_LOGIC;
            RED_ADDRESS     : in  STD_LOGIC_VECTOR(7 downto 0);  -- Only 8-bit address input
            RED_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component RED_MUX_FOR_RED_PC
        Port (
		      RED_CLOCK        : in STD_LOGIC;
            RED_SELECT       : in  STD_LOGIC;
            RED_SIGNAL_PC_P4 : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_BRAMCH_ADD   : in  STD_LOGIC_VECTOR(63 downto 0);
            RED_OUTPUT       : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

    -- Internal signals
    signal selected_input         : STD_LOGIC_VECTOR(63 downto 0);
    signal internal_red_address   : STD_LOGIC_VECTOR(63 downto 0);
	 signal RED_SIGNAL_PC_P4       : STD_LOGIC_VECTOR(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";

begin

    -- MUX for selecting PC input
    MUX_PC_INPUT: RED_MUX_FOR_RED_PC
        Port map (
		      RED_CLOCK        => RED_CLOCK,
            RED_SELECT       => RED_SELECT,
            RED_SIGNAL_PC_P4 => RED_SIGNAL_PC_P4,
            RED_BRAMCH_ADD   => RED_BRAMCH_ADD,
            RED_OUTPUT       => selected_input
        );

    -- RED_PC: Receives input from MUX and produces 64-bit address	
    U1: RED_PC
        Port map (
		      RED_CLOCK   => RED_CLOCK,
            RED_INPUT   => selected_input,
            RED_ADDRESS => internal_red_address
        );

    -- RED_ADDER_FOR_PC_P4: Adds 4 to PC
    U2: RED_ADDER_FOR_PC_P4
        Port map (
		      RED_CLOCK => RED_CLOCK,
            RED_PC    => internal_red_address,
            RED_PC_P4 => RED_SIGNAL_PC_P4
        );

    -- RED_INST_MEM: Uses only lower 8 bits of PC
    U3: RED_INST_MEM
        Port map (
		      RED_CLOCK       => RED_CLOCK,
            RED_ADDRESS     => internal_red_address(9 downto 2),
            RED_INSTRUCTION => RED_INSTRUCTION
        );

    -- Output the computed address
    RED_ADDRESS <= internal_red_address;

end Behavioral;
