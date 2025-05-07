--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL; 
--
--entity RED_MUX_FOR_RED_PC is
--    Port (
--        RED_CLOCK         : in STD_LOGIC;
--        RED_SELECT        : in STD_LOGIC;
--        RED_SIGNAL_PC_P4  : in STD_LOGIC_VECTOR(63 downto 0);
--        RED_BRAMCH_ADD    : in STD_LOGIC_VECTOR(63 downto 0);
--        RED_OUTPUT        : out STD_LOGIC_VECTOR(63 downto 0)
--    );
--end RED_MUX_FOR_RED_PC;
--
--architecture Behavioral of RED_MUX_FOR_RED_PC is
--begin
----    process(RED_CLOCK)
----    begin
----        if rising_edge(RED_CLOCK) then
--process(RED_SELECT)
--begin
--            if RED_SELECT = '1' then
--				    RED_OUTPUT <= RED_BRAMCH_ADD;
--            else
--                RED_OUTPUT <= RED_SIGNAL_PC_P4;
--            end if;
----        end if;
--    end process;
--end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_MUX_FOR_RED_PC is
    Port (
        RED_CLOCK         : in STD_LOGIC;  -- Not used in this design
        RED_SELECT        : in STD_LOGIC;
        RED_SIGNAL_PC_P4  : in STD_LOGIC_VECTOR(63 downto 0);
        RED_BRAMCH_ADD    : in STD_LOGIC_VECTOR(63 downto 0);
        RED_OUTPUT        : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_MUX_FOR_RED_PC;

architecture Behavioral of RED_MUX_FOR_RED_PC is
begin
    with RED_SELECT select
        RED_OUTPUT <= RED_BRAMCH_ADD    when '1',
                      RED_SIGNAL_PC_P4 when others;
end Behavioral;


