library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity venda is
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
end entity venda;

architecture rtl of venda is
    -- Component instantiations
    component state_machine is
        generic (
            CLK_FREQ: natural := 10_000_000
        );
        port (
            clk: in std_logic;
            reset: in std_logic;
            pino1: in std_logic;
            pino2: in std_logic;
            pino3: in std_logic;
            display: out std_logic_vector(6 downto 0)
        );
    end component;

    component dispenser is
        port (
            clk: in std_logic;
            reset: in std_logic;
            dispense_product: in std_logic;
            produto_dispensado: out std_logic
        );
    end component;

    -- Internal signals
    signal dispense_product: std_logic;
    signal state_display: std_logic_vector(6 downto 0);

begin
    -- Component instantiations
    state_machine_inst: state_machine
        
        port map (
            clk => clk,
            reset => reset,
            pino1 => pino1,
            pino2 => pino2,
            pino3 => pino3,
            display => state_display
        );

    dispenser_inst: dispenser
        port map (
            clk => clk,
            reset => reset,
            dispense_product => dispense_product,
            produto_dispensado => produto_dispensado
        );

    -- Output control
    process (state_display, dispense_product)
    begin
        case state_display is
            when "0000001" =>
                display <= "0000001";

            when "0000010" =>
                display <= "0000010";

            when "0000100" =>
                display <= "0000100";

            when "0001000" =>
                display <= "0001000";
                produto_dispensado <= '1';

            when others =>
                display <= (others => '0');
                produto_dispensado <= '0';
        end case;
    end process;

end architecture rtl;
