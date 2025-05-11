library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_REG1 is
    Port (
        RED_CLOCK              : in  STD_LOGIC;
        -- Inputs from Stage 1
        Next_RED_ADDRESS       : in  STD_LOGIC_VECTOR(63 downto 0);
        Next_RED_INSTRUCTION   : in  STD_LOGIC_VECTOR(31 downto 0);
        -- Outputs for Stage 2
        RED_ADDRESS_REG        : out STD_LOGIC_VECTOR(63 downto 0);
        RED_INSTRUCTION_REG    : out STD_LOGIC_VECTOR(31 downto 0)

    );
end RED_REG1;

architecture Behavioral of RED_REG1 is
    -- Declare internal signals to hold next values
    signal next_temp_address : STD_LOGIC_VECTOR(63 downto 0);
    signal next_temp_instruction : STD_LOGIC_VECTOR(31 downto 0);

begin            
        RED_ADDRESS_REG <= next_temp_address;
        RED_INSTRUCTION_REG <= next_temp_instruction;
				
    process(RED_CLOCK)
    begin
        if rising_edge(RED_CLOCK) then
            next_temp_address <= Next_RED_ADDRESS;
            next_temp_instruction <= Next_RED_INSTRUCTION;
        end if;
    end process;
end Behavioral;

