library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_ADDER_FOR_PC_P4 is
    Port (
        RED_PC     : in  STD_LOGIC_VECTOR(63 downto 0);
        RED_PC_P4  : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_ADDER_FOR_PC_P4;

architecture Behavioral of RED_ADDER_FOR_PC_P4 is
	begin
		 RED_PC_P4 <= std_logic_vector(unsigned(RED_PC) + to_unsigned(4, 64));
end Behavioral;
