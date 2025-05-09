library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RED_ADDER_FOR_PC_P4 is
	port (
		RED_PC : in STD_LOGIC_VECTOR(63 downto 0);
		RED_PC_P4 : out STD_LOGIC_VECTOR(63 downto 0)
	);
end RED_ADDER_FOR_PC_P4;

architecture Behavioral of RED_ADDER_FOR_PC_P4 is
	constant FOUR_64BIT : STD_LOGIC_VECTOR(63 downto 0) :=
		(63 downto 3 => '0') & "100"; -- 64-bit representation of 4
begin

	RED_PC_P4 <= STD_LOGIC_VECTOR(unsigned(RED_PC) + unsigned(FOUR_64BIT));

end Behavioral;