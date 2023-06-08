
library ieee;
use ieee.std_logic_1164.all;

entity state_machine is
    generic (
        CLK_FREQ: natural := 10_000_000
    );
    port (
        clk: in std_logic;
        reset: in std_logic;
        pino1: in std_logic;
        pino2: in std_logic;
        pino3: in std_logic;
        pino4: in std_logic;
        pino5: in std_logic;
        pino6: in std_logic;
        pino7: in std_logic;
        display: out std_logic_vector(6 downto 0);
        produto_dispensado: out std_logic
    );
end entity state_machine;

architecture rtl of state_machine is
    -- Enumeration of states
    type state_type is (selection, load, add, change, dispense);
    signal state: state_type;

    -- Signal declarations
    signal clk_div: std_logic;
    signal clk_count: integer range 0 to CLK_FREQ;
    signal valor_moedas_inseridas: integer range 0 to 15;
    constant valor_produto: integer := 10;

begin
    -- Clock divider process and state machine process combined
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= selection;
                valor_moedas_inseridas <= 0;
            else
                if clk_count = CLK_FREQ - 1 then
                    clk_count <= 0;
                    clk_div <= not clk_div;

                    -- Update the value of "valor_moedas_inseridas" based on input pins
                    if pino4 = '1' then
                        valor_moedas_inseridas <= valor_moedas_inseridas + 1;
                    elsif pino5 = '1' then
                        valor_moedas_inseridas <= valor_moedas_inseridas + 2;
                    elsif pino6 = '1' then
                        valor_moedas_inseridas <= valor_moedas_inseridas + 5;
                    elsif pino7 = '1' then
                        valor_moedas_inseridas <= valor_moedas_inseridas + 10;
                    end if;

                    -- State machine logic
                    case state is
                        when selection =>
                            if pino1 = '1' then
                                state <= load;
                            elsif pino2 = '1' then
                                state <= load;
                            elsif pino3 = '1' then
                                state <= load;
                            elsif pino4 = '1' then
                                state <= load;
                            elsif pino5 = '1' then
                                state <= load;
                            elsif pino6 = '1' then
                                state <= load;
                            end if;

                        when load =>
                            if pino4 = '1' or pino5 = '1' or pino6 = '1' or pino7 = '1' then
                                state <= add;
                            end if;

                        when add =>
                            if pino4 = '0' and pino5 = '0' and pino6 = '0' and pino7 = '0' then
                                if valor_moedas_inseridas >= valor_produto then
                                    state <= change;
                                else
                                    state <= dispense;
                                end if;
                            end if;

                        when change =>
                            state <= dispense;

                        when dispense =>
                            state <= selection;
                    end case;
                else
                    clk_count <= clk_count + 1;
                end if;
            end if;
        end if;
    end process;

end architecture rtl;
