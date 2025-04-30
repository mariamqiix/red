library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_REGISTER_FILE is
    Port (
        RED_REG_WRITE     : in  STD_LOGIC;
        RED_REG1          : in  STD_LOGIC_VECTOR(4 downto 0);
        RED_REG2          : in  STD_LOGIC_VECTOR(4 downto 0);
        RED_WRITE_REG     : in  STD_LOGIC_VECTOR(4 downto 0);
        RED_WRITE_DATA    : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA1         : out STD_LOGIC_VECTOR(31 downto 0);
        RED_DATA2         : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_REGISTER_FILE;

architecture Behavioral of RED_REGISTER_FILE is
    type RED_REGISTER_Array is array(31 downto 0) of std_logic_vector(31 downto 0);
    signal RED_REGISTER : RED_REGISTER_Array := (others => (others => '0'));
begin

    process(RED_REG_WRITE)
    begin
        if RED_REG_WRITE = '1' then
            RED_REGISTER(to_integer(unsigned(RED_WRITE_REG))) <= RED_WRITE_DATA;
        end if;
    end process;

    RED_DATA1 <= RED_REGISTER(to_integer(unsigned(RED_REG1)));
    RED_DATA2 <= RED_REGISTER(to_integer(unsigned(RED_REG2)));

end Behavioral;
