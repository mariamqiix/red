library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_SL_BY_1 is
    Port (
        RED_CLOCK  : in STD_LOGIC;
        RED_INPUT  : in STD_LOGIC_VECTOR(63 downto 0);
        RED_OUTPUT : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_SL_BY_1;

architecture Behavioral of RED_SL_BY_1 is
begin
    process(RED_CLOCK)
    begin
        if rising_edge(RED_CLOCK) then
            RED_OUTPUT <= std_logic_vector(shift_left(unsigned(RED_INPUT), 1));
        end if;
    end process;
end Behavioral;
