library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity RED_INST_MEM is
	port (
		RED_ADDRESS : in STD_LOGIC_VECTOR(7 downto 0);
		RED_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0)
	);
end RED_INST_MEM;

architecture Behavioral of RED_INST_MEM is

	type RED_MEM_TYPE is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
	-- signal RED_MEM : RED_MEM_TYPE;
 
	-- just to test the stage 1
	signal RED_MEM : RED_MEM_TYPE := (
		-- add x1, x0, x0 => x1 = 0
		0 => x"000000b3", -- opcode: 0110011, funct3: 000, funct7: 0000000

		-- add x2, x1, x1 => x2 = 0
		4 => x"00108133", -- rd=2, rs1=1, rs2=1

		-- or x3, x1, x2 => x3 = x1 | x2 = 0
		5 => x"0020e1b3", -- funct3: 110, funct7: 0000000

		-- and x4, x2, x3 => x4 = 0
		3 => x"00317233", -- funct3: 111

		-- sd x4, 5(x0) => store x4 to mem[0]
		1 => x"004032a3", -- funct3: 011, opcode: 0100011

		-- ld x5, 0(x0) => load mem[0] to x5
		2 => x"00003283", -- funct3: 011, opcode: 0000011

		-- sub x6, x5, x4 => x6 = x5 - x4
		6 => x"40428333", -- funct7: 0100000

		-- beq x6, x0, +4 => should not branch if x6 != 0
		7 => x"fe000ee3", -- funct3: 000, opcode: 1100011, imm=+8 (offset = 2 instructions)

		-- add x7, x6, x1 => skipped if branch taken
		8 => x"001303b3", 

		-- nop (add x0, x0, x0)
		9 => x"00000033", 

		others => (others => '0')
	);
	signal instruction_reg : STD_LOGIC_VECTOR(31 downto 0);

begin
	instruction_reg <= RED_MEM(to_integer(unsigned(RED_ADDRESS)));

	RED_INSTRUCTION <= instruction_reg;
 
end Behavioral;