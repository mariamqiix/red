library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_DATA_MEM is
    Port (
        RED_MEM_WRITE   : in  STD_LOGIC;
        RED_MEM_READ    : in  STD_LOGIC;
        RED_ADDRESS     : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_WRITE_DATA  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA        : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_DATA_MEM;

architecture Behavioral of RED_DATA_MEM is

    type RED_MEM_ARRAY is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal RED_RAM : RED_MEM_ARRAY;
    signal RED_ADDR_INDEX : integer range 0 to 255;

begin

    process(RED_MEM_READ, RED_MEM_WRITE, RED_ADDRESS, RED_WRITE_DATA)
    begin
        RED_ADDR_INDEX <= to_integer(unsigned(RED_ADDRESS(9 downto 2)));  -- Word-aligned address (ignores lower 2 bits)

        if RED_MEM_WRITE = '1' then
            RED_RAM(RED_ADDR_INDEX) <= RED_WRITE_DATA;
        end if;

        if RED_MEM_READ = '1' then
            RED_DATA <= RED_RAM(RED_ADDR_INDEX);
        else
            RED_DATA <= (others => 'Z');
        end if;
    end process;

end Behavioral;
