library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity RED_PC is
	port (
		RED_INPUT : in STD_LOGIC_VECTOR(63 downto 0);
		RED_ADDRESS : out STD_LOGIC_VECTOR(63 downto 0)
	);
end RED_PC;

architecture Behavioral of RED_PC is

	--    signal PC : STD_LOGIC_VECTOR(63 downto 0);

begin
	RED_ADDRESS <= RED_INPUT;
	--    RED_ADDRESS <= PC;

end Behavioral;