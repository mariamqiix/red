library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RED_REGISTER_FILE is
	port (
		RED_CLOCK       : in STD_LOGIC;
		RED_REG_WRITE   : in STD_LOGIC;
		RED_REG1        : in STD_LOGIC_VECTOR(4 downto 0);
		RED_REG2        : in STD_LOGIC_VECTOR(4 downto 0);
		RED_WRITE_REG   : in STD_LOGIC_VECTOR(4 downto 0);
		RED_WRITE_DATA  : in STD_LOGIC_VECTOR(31 downto 0);
		RED_DATA1       : out STD_LOGIC_VECTOR(31 downto 0);
		RED_DATA2       : out STD_LOGIC_VECTOR(31 downto 0)
	);
end RED_REGISTER_FILE;

architecture Behavioral of RED_REGISTER_FILE is
	type RED_REGISTER_Array is array(31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
	signal RED_REGISTER : RED_REGISTER_Array := (
		 0  => x"00000000",  -- Register 0
		 1  => x"11111111",  -- Register 1
		 2  => x"22222222",  -- Register 2
		 3  => x"33333333",  -- Register 3
		 4  => x"44444444",  -- Register 4
		 5  => x"55555555",  -- Register 5
		 6  => x"66666666",  -- Register 6
		 7  => x"77777777",  -- Register 7
		 8  => x"88888888",  -- Register 8
		 9  => x"99999999",  -- Register 9
		 others => (others => '0')  -- All other registers set to 0
	);
begin
	-- Write Process (Synchronous to RED_CLOCK)
	process(RED_CLOCK)
	begin
--		if rising_edge(RED_CLOCK) then
			if RED_REG_WRITE = '1' then
				RED_REGISTER(to_integer(unsigned(RED_WRITE_REG))) <= RED_WRITE_DATA;
			end if;
--		end if;
	end process;

	-- Read Ports (Asynchronous)
	RED_DATA1 <= RED_REGISTER(to_integer(unsigned(RED_REG1)));
	RED_DATA2 <= RED_REGISTER(to_integer(unsigned(RED_REG2)));

end Behavioral;
