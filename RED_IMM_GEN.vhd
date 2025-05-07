library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity RED_IMM_GEN is
    Port (
        RED_CLOCK        : in  STD_LOGIC;
        RED_IMM          : in  STD_LOGIC_VECTOR(31 downto 0);   -- FOR RED_INSTRUCTION[25:21]
        RED_EXTENDET_IMM : out STD_LOGIC_VECTOR(63 downto 0)
    );
end RED_IMM_GEN;

architecture Behavioral of RED_IMM_GEN is
    signal imm_extended : STD_LOGIC_VECTOR(63 downto 0);
begin

--    process(RED_CLOCK)
--    begin
--        if rising_edge(RED_CLOCK) then
            imm_extended <= std_logic_vector(resize(signed(RED_IMM), 64));
--        end if;
--    end process;

    RED_EXTENDET_IMM <= imm_extended;

end Behavioral;
