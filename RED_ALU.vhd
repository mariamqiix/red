library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity RED_ALU is
    Port (
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
    RED_MULT_RESULT <= signed(RED_INPUT_A) * signed(RED_INPUT_B);  -- Always computed

    with RED_ALU_CTRL select
        RED_TEMP_ALU_RESULTS <=
            "00000000000000000000000000000000"                                         when "0000",  -- Clear
            std_logic_vector(unsigned(RED_INPUT_A) - unsigned(RED_INPUT_B))            when "0001",  -- Sub
            std_logic_vector(unsigned(RED_INPUT_A) + unsigned(RED_INPUT_B))            when "0010",  -- Add
            std_logic_vector(RED_MULT_RESULT(31 downto 0))                             when "0011",  -- Mult (low)
            std_logic_vector(signed(RED_INPUT_A) / signed(RED_INPUT_B))                when "0100",  -- Div
            std_logic_vector(signed(RED_INPUT_A) mod signed(RED_INPUT_B))              when "0101",  -- Mod
            std_logic_vector(shift_left(signed(RED_INPUT_A), 1))                       when "0110",  -- SLL (by 1)
            std_logic_vector(shift_right(unsigned(RED_INPUT_A), 
                                to_integer(unsigned(RED_INPUT_B(4 downto 0)))))        when "0111",  -- SRL
            std_logic_vector(shift_right(signed(RED_INPUT_A), 
                                to_integer(unsigned(RED_INPUT_B(4 downto 0)))))        when "1000",  -- SRA
            not RED_INPUT_A                                                            when "1001",  -- NOT
            RED_INPUT_A and RED_INPUT_B                                                when "1010",  -- AND
            RED_INPUT_A or RED_INPUT_B                                                 when "1011",  -- OR
            RED_INPUT_A xor RED_INPUT_B                                                when "1100",  -- XOR
            "11111111111111111111111111111111"                                         when "1101",  -- Set
            "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"                                         when others;

    RED_ALU_ZERO <= '1' when RED_TEMP_ALU_RESULTS = "00000000000000000000000000000000" else '0';
    RED_ALU_RESULTS <= RED_TEMP_ALU_RESULTS;
end Behavioral;