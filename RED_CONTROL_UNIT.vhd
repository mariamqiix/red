library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RED_CONTROL_UNIT is
    Port (
        RED_CLOCK        : in STD_LOGIC;
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

    signal alu_op_int      : STD_LOGIC_VECTOR(3 downto 0);
    signal alu_src_int     : STD_LOGIC;
    signal branch_int      : STD_LOGIC;
    signal mem_to_reg_int  : STD_LOGIC;
    signal reg_write_int   : STD_LOGIC;
    signal mem_read_int    : STD_LOGIC;
    signal mem_write_int   : STD_LOGIC;

begin

    RED_OPCODE  <= RED_INSTRUCTION(6 downto 0);
    RED_FUNCT3  <= RED_INSTRUCTION(14 downto 12);
    RED_FUNCT7  <= RED_INSTRUCTION(31 downto 25);

    process(RED_CLOCK)
    begin
        if rising_edge(RED_CLOCK) then

            -- Default values 
            alu_op_int      <= "0000";
            alu_src_int     <= '0';
            branch_int      <= '0';
            mem_to_reg_int  <= '0';
            reg_write_int   <= '0';
            mem_read_int    <= '0';
            mem_write_int   <= '0';

            case RED_OPCODE is
                when "0000011" =>  -- Load (ld)
                    alu_op_int      <= "0001";  -- ADD
                    alu_src_int     <= '1';   -- Immediate
                    mem_read_int    <= '1';
                    mem_to_reg_int  <= '1';
                    reg_write_int   <= '1';

                when "0100011" =>  -- Store (sd)
                    alu_op_int      <= "0001";  -- ADD
                    alu_src_int     <= '1';   -- Immediate
                    mem_write_int   <= '1';

                when "0110011" =>  -- R-type ALU ops
                    alu_src_int     <= '0';   -- Register
                    mem_to_reg_int  <= '0';
                    reg_write_int   <= '1';

                    case RED_FUNCT3 is
                        when "000" =>
                            if RED_FUNCT7 = "0100000" then
                                alu_op_int <= "0001"; -- SUB
                            else
                                alu_op_int <= "0010"; -- ADD
                            end if;
                        when "001"  => alu_op_int <= "0110"; -- SLL
                        when "100"  => alu_op_int <= "1100"; -- XOR
                        when "110"  => alu_op_int <= "1011"; -- OR
                        when "111"  => alu_op_int <= "1010"; -- AND
                        when others => alu_op_int <= "0000";
                    end case;

                when "1100011" =>  -- Branch
                    alu_src_int     <= '0';
                    branch_int      <= '1';

                    case RED_FUNCT3 is
                        when "000" | "001" =>
                            alu_op_int <= "0001"; -- SUB
                        when others =>
                            alu_op_int <= "0000";
                    end case;

                when others =>
                    alu_op_int      <= "0000";
                    alu_src_int     <= '0';
                    branch_int      <= '0';
                    mem_to_reg_int  <= '0';
                    reg_write_int   <= '0';
                    mem_read_int    <= '0';
                    mem_write_int   <= '0';
            end case;
        end if;
    end process;

    -- Assign internal signals to outputs
    RED_ALU_OP      <= alu_op_int;
    RED_ALU_SRC     <= alu_src_int;
    RED_BRANCH      <= branch_int;
    RED_MEM_TO_Reg  <= mem_to_reg_int;
    RED_REG_WRITE   <= reg_write_int;
    RED_MEM_READ    <= mem_read_int;
    RED_MEM_WRITE   <= mem_write_int;

end Behavioral;
