library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity RED_IMM_GEN is
    Port (
        RED_IMM          : in  STD_LOGIC_VECTOR(31 downto 0);   -- FOR RED_INSTRUCTION[25:21]
        RED_EXTENDET_IMM : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_IMM_GEN;

architecture Behavioral of RED_IMM_GEN is
begin
    RED_EXTENDET_IMM <= std_logic_vector(resize(signed(RED_IMM), 64));
end Behavioral;
