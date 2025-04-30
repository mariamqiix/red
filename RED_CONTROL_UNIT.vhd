library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_CONTROL_UNIT is
    Port (
        RED_INSTRUCTION  : in  STD_LOGIC_VECTOR(31 downto 0);
        RED_ALU_OP       : out STD_LOGIC_VECTOR(3 downto 0);
        RED_ALU_SRC      : out STD_LOGIC;
        RED_BRANCH       : out STD_LOGIC;
        RED_MEM_TO_Reg   : out STD_LOGIC;
        RED_REG_WRITE    : out STD_LOGIC;
        RED_MEM_READ     : out STD_LOGIC;
        RED_MEM_WRITE    : out STD_LOGIC
    );
end RED_CONTROL_UNIT;

architecture Behavioral of RED_CONTROL_UNIT is

    signal RED_OPCODE  : STD_LOGIC_VECTOR(6 downto 0);
    signal RED_FUNCT3  : STD_LOGIC_VECTOR(2 downto 0);
    signal RED_FUNCT7  : STD_LOGIC_VECTOR(6 downto 0);

begin

    RED_OPCODE  <= RED_INSTRUCTION(6 downto 0);
    RED_FUNCT3  <= RED_INSTRUCTION(14 downto 12);
    RED_FUNCT7  <= RED_INSTRUCTION(31 downto 25);

    process(RED_OPCODE, RED_FUNCT3, RED_FUNCT7)
    begin
	         -- Default values 
        RED_ALU_OP      <= "0000";
        RED_ALU_SRC     <= '0';
        RED_BRANCH      <= '0';
        RED_MEM_TO_Reg  <= '0';
        RED_REG_WRITE   <= '0';
        RED_MEM_READ    <= '0';
        RED_MEM_WRITE   <= '0';
		  
		  
        case RED_OPCODE is
            when "0000011" =>  -- Load (ld)
                RED_ALU_OP      <= "0001";  -- ADD for address
                RED_ALU_SRC     <= '1';   -- Immediate
                RED_MEM_READ    <= '1';
                RED_MEM_TO_Reg  <= '1';
                RED_REG_WRITE   <= '1';
					 
					 

            when "0100011" =>  -- Store (sd)
                RED_ALU_OP      <= "0001";  -- ADD for address
                RED_ALU_SRC     <= '1';   -- Immediate
                RED_MEM_WRITE   <= '1';

					 
					 
            when "0110011" =>  -- R-type ALU ops (add, sub, and, or)
                RED_ALU_SRC     <= '0';   -- Register
                RED_MEM_TO_Reg  <= '0';
                RED_REG_WRITE   <= '1';

                case RED_FUNCT3 is
                    when "000" =>
						  
                        if RED_FUNCT7 = "0100000" then
                            RED_ALU_OP <= "0001"; -- SUB
									 
                        else
                            RED_ALU_OP <= "0010"; -- ADD
									 
                        end if;

						  when "001"  => RED_ALU_OP <= "0110"; -- SLL	
	                 when "100"  => RED_ALU_OP <= "1100"; -- xOR
	                 when "110"  => RED_ALU_OP <= "1011"; -- OR
                    when "111"  => RED_ALU_OP <= "1010"; -- AND
                    when others => RED_ALU_OP <= "0000";
						  
                end case;
					 


            when "1100011" =>  -- Branch (e.g., BEQ, BNE)
				
                RED_ALU_SRC     <= '0';   -- Compare 2 registers
                RED_BRANCH      <= '1';
					 
                case RED_FUNCT3 is
					 
                    when "000" | "001" =>
                        RED_ALU_OP <= "0001"; -- SUB for comparison
								
                    when others =>
                        RED_ALU_OP <= "0000";
								
                end case;

            when others =>
                RED_ALU_OP      <= "0000";
                RED_ALU_SRC     <= '0';
                RED_BRANCH      <= '0';
                RED_MEM_TO_Reg  <= '0';
                RED_REG_WRITE   <= '0';
                RED_MEM_READ    <= '0';
                RED_MEM_WRITE   <= '0';
        end case;
    end process;

end Behavioral;
