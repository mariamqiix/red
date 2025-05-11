library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RED_IMM_GEN is
    port (
        RED_IMM          : in  STD_LOGIC_VECTOR(31 downto 0); -- 32-bit instruction
        RED_EXTENDET_IMM : out STD_LOGIC_VECTOR(63 downto 0)  -- Sign-extended (imm + rs1 if applicable)
    );
end RED_IMM_GEN;

architecture Behavioral of RED_IMM_GEN is
    signal RED_OPCODE         : STD_LOGIC_VECTOR(6 downto 0);
    signal RED_RS1            : STD_LOGIC_VECTOR(4 downto 0);

    signal RED_IMM_I_TYPE     : STD_LOGIC_VECTOR(11 downto 0);
    signal RED_IMM_S_TYPE     : STD_LOGIC_VECTOR(11 downto 0);
    signal RED_IMM_SB_TYPE    : STD_LOGIC_VECTOR(12 downto 0);
    signal RED_IMM_U_TYPE     : STD_LOGIC_VECTOR(19 downto 0);
    signal RED_IMM_UJ_TYPE    : STD_LOGIC_VECTOR(20 downto 0);

    signal RED_RESULT_SIGNED  : SIGNED(63 downto 0);
begin
    -- Extract fields
    RED_OPCODE <= RED_IMM(6 downto 0);
--    RED_RS1    <= RED_IMM(19 downto 15);	

    -- Immediates by format
    RED_IMM_I_TYPE  <= RED_IMM(31 downto 20);
    RED_IMM_S_TYPE  <= RED_IMM(31 downto 25) & RED_IMM(11 downto 7);
    RED_IMM_SB_TYPE <= RED_IMM(31) & RED_IMM(7) & RED_IMM(30 downto 25) & RED_IMM(11 downto 8) & '0';
    RED_IMM_U_TYPE  <= RED_IMM(31 downto 12);
    RED_IMM_UJ_TYPE <= RED_IMM(31) & RED_IMM(19 downto 12) & RED_IMM(20) & RED_IMM(30 downto 21) & '0';

    -- Main logic
    process(RED_OPCODE , RED_IMM_I_TYPE, RED_IMM_S_TYPE, RED_IMM_SB_TYPE, RED_IMM_U_TYPE, RED_IMM_UJ_TYPE)
--        variable v_rs1   : signed(63 downto 0);
        variable v_imm   : signed(63 downto 0);
    begin
--        v_rs1 := resize(signed('0' & RED_RS1), 64);  -- RS1 is unsigned 5-bit, pad with 0 to prevent sign extension

        case RED_OPCODE is
            -- I-type: imm + rs1
            when "0000011" | "0010011" | "1100111" =>
                v_imm := resize(signed(RED_IMM_I_TYPE(11) & RED_IMM_I_TYPE), 64);
                RED_RESULT_SIGNED <= v_imm ;

            -- S-type: imm + rs1
            when "0100011" =>
                v_imm := resize(signed(RED_IMM_S_TYPE(11) & RED_IMM_S_TYPE), 64);
                RED_RESULT_SIGNED <= v_imm ;

            -- SB-type: branch immediate only
            when "1100011" =>
                RED_RESULT_SIGNED <= resize(signed(RED_IMM_SB_TYPE(12) & RED_IMM_SB_TYPE), 64);

            -- U-type: immediate shifted by 12
            when "0110111" | "0010111" =>
                v_imm := resize(signed(RED_IMM_U_TYPE & x"000"), 64);  -- Treat upper 20 bits as signed, lower 12 as 0s
                RED_RESULT_SIGNED <= v_imm;

            -- UJ-type: jump immediate
            when "1101111" =>
                RED_RESULT_SIGNED <= resize(signed(RED_IMM_UJ_TYPE(20) & RED_IMM_UJ_TYPE), 64);

            -- Default
            when others =>
                RED_RESULT_SIGNED <= (others => '0');
        end case;
    end process;

    -- Final output
    RED_EXTENDET_IMM <= std_logic_vector(RED_RESULT_SIGNED);

end Behavioral;
