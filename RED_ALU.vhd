library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity RED_ALU is
    Port (
        RED_CLOCK         : in STD_LOGIC;
        RED_INPUT_A       : in  STD_LOGIC_VECTOR(31 downto 0);  -- Operand 1
        RED_INPUT_B       : in  STD_LOGIC_VECTOR(31 downto 0);  -- Operand 2
        RED_ALU_CTRL      : in  STD_LOGIC_VECTOR(3 downto 0);   -- Control from RED_ALU_CONTROL_UNIT
        RED_ALU_RESULTS   : out STD_LOGIC_VECTOR(31 downto 0);
        RED_ALU_ZERO      : out STD_LOGIC
    );
end RED_ALU;

architecture Behavioral of RED_ALU is
    signal RED_TEMP_ALU_RESULTS : STD_LOGIC_VECTOR(31 downto 0);
    signal RED_MULT_RESULT      : SIGNED(63 downto 0);  -- 64-bit multiplication result
begin
    process(RED_CLOCK)
    begin
        if rising_edge(RED_CLOCK) then  -- Trigger on rising edge of RED_CLOCK
            RED_MULT_RESULT <= signed(RED_INPUT_A) * signed(RED_INPUT_B);  -- Always computed

            -- ALU operations based on RED_ALU_CTRL
            case RED_ALU_CTRL is
                when "0000" =>  -- Clear
                    RED_TEMP_ALU_RESULTS <= (others => '0');
                when "0001" =>  -- Sub
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(unsigned(RED_INPUT_A) - unsigned(RED_INPUT_B));
                when "0010" =>  -- Add
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(unsigned(RED_INPUT_A) + unsigned(RED_INPUT_B));
                when "0011" =>  -- Mult (low)
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(RED_MULT_RESULT(31 downto 0));
                when "0100" =>  -- Div
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(signed(RED_INPUT_A) / signed(RED_INPUT_B));
                when "0101" =>  -- Mod
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(signed(RED_INPUT_A) mod signed(RED_INPUT_B));
                when "0110" =>  -- SLL (by 1)
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(shift_left(signed(RED_INPUT_A), 1));
                when "0111" =>  -- SRL
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(shift_right(unsigned(RED_INPUT_A), 
                                            to_integer(unsigned(RED_INPUT_B(4 downto 0)))));
                when "1000" =>  -- SRA
                    RED_TEMP_ALU_RESULTS <= std_logic_vector(shift_right(signed(RED_INPUT_A), 
                                            to_integer(unsigned(RED_INPUT_B(4 downto 0)))));
                when "1001" =>  -- NOT
                    RED_TEMP_ALU_RESULTS <= not RED_INPUT_A;
                when "1010" =>  -- AND
                    RED_TEMP_ALU_RESULTS <= RED_INPUT_A and RED_INPUT_B;
                when "1011" =>  -- OR
                    RED_TEMP_ALU_RESULTS <= RED_INPUT_A or RED_INPUT_B;
                when "1100" =>  -- XOR
                    RED_TEMP_ALU_RESULTS <= RED_INPUT_A xor RED_INPUT_B;
                when "1101" =>  -- Set
                    RED_TEMP_ALU_RESULTS <= (others => '1');
                when others =>  -- Default case
                    RED_TEMP_ALU_RESULTS <= (others => 'Z');  -- High impedance state
            end case;

            -- Set the ALU zero flag
            if RED_TEMP_ALU_RESULTS = "00000000000000000000000000000000" then
                RED_ALU_ZERO <= '1';
            else
                RED_ALU_ZERO <= '0';
            end if;

            -- Output the ALU result
            RED_ALU_RESULTS <= RED_TEMP_ALU_RESULTS;
        end if;
    end process;
end Behavioral;
