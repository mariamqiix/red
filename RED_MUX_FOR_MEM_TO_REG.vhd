library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity RED_MUX_FOR_MEM_TO_REG is
    Port (
        RED_CLOCK       : in STD_LOGIC;
        RED_SELECT      : in  STD_LOGIC;
        RED_ALU_RESULTS : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_MEM_DATA    : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_OUTPUT      : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_MUX_FOR_MEM_TO_REG;

architecture Behavioral of RED_MUX_FOR_MEM_TO_REG is
begin
    process(RED_CLOCK)  -- Triggered on rising edge of RED_CLOCK
    begin
        if rising_edge(RED_CLOCK) then
            if RED_SELECT = '1' then
                RED_OUTPUT <= RED_ALU_RESULTS;
            else
                RED_OUTPUT <= RED_MEM_DATA;
            end if;
        end if;
    end process;
end Behavioral;
