library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity RED_INST_MEM is
    Port (
        RED_ADDRESS    : in  STD_LOGIC_VECTOR(7 downto 0);
        RED_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RED_INST_MEM;

architecture Behavioral of RED_INST_MEM is

    type RED_MEM_TYPE is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    -- signal RED_MEM : RED_MEM_TYPE;
	 
	 -- just to test the stage 1
	     signal RED_MEM : RED_MEM_TYPE := (
    0  => x"00000033",  -- ADD x0, x0, x0       ; NOP
    1  => x"000000B3",  -- ADD x1, x0, x0       ; x1 = 0
    2  => x"001080B3",  -- ADD x1, x1, x1       ; still 0
    3  => x"001080B3",  -- ADD x1, x1, x1       ; still 0

    -- Create x2 = x1 + x1 = 0
    4  => x"00108133",  -- ADD x2, x1, x1

    -- x3 = x2 + x2 = 0
    5  => x"002101B3",  -- ADD x3, x2, x2

    -- x4 = x3 OR x1 = 0
    6  => x"0011A233",  -- OR x4, x3, x1

    -- x5 = x3 AND x1 = 0
    7  => x"0011B2B3",  -- AND x5, x3, x1

    -- Store x4 (0) into mem[0](x0)
    8  => x"00402023",  -- SD x4, 0(x0)

    -- Load into x6 from mem[0](x0)
    9  => x"0000A303",  -- LD x6, 0(x1)

    -- Add x7 = x1 + x6
    10 => x"0060C3B3",  -- ADD x7, x1, x6

    -- Sub x8 = x7 - x6 = x1
    11 => x"4063C433",  -- SUB x8, x7, x6

    -- AND x9 = x6 AND x8
    12 => x"0083D4B3",  -- AND x9, x7, x8

    -- OR x10 = x7 OR x6
    13 => x"0063E533",  -- OR x10, x7, x6

    -- BEQ x1, x2, +4 (should not branch)
    14 => x"00208663",  -- BEQ x1, x2, +4

    -- ADD x11 = x10 + x1 (executes if no branch)
    15 => x"0012F5B3",  -- ADD x11, x5, x1

    -- Label target for BEQ
    16 => x"00000033",  -- NOP

    others => (others => '0')
);

	 begin
	 
    RED_INSTRUCTION <= RED_MEM(to_integer(unsigned(RED_ADDRESS)));
	 
end Behavioral;


