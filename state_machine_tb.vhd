library ieee;
use ieee.std_logic_1164.all;

entity state_machine_tb is
end entity state_machine_tb;

architecture testbench of state_machine_tb is
    -- DUT signals
    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    signal pino1, pino2, pino3, pino4, pino5, pino6, pino7: std_logic;
    signal display: std_logic_vector(6 downto 0);
    signal produto_dispensado: std_logic;

    -- Other signals
    signal finish_sim: boolean := false;

    -- Constants
    constant CLK_PERIOD: time := 100 ns;

begin
    -- Clock process
    process
    begin
        while not finish_sim loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    process
    begin
        reset <= '1'; -- Apply reset
        wait for 10 ns;
        reset <= '0'; -- Deassert reset

        -- Stimulus generation
        wait for 20 ns;
        pino1 <= '1';
        wait for CLK_PERIOD;
        pino1 <= '0';

        wait for 20 ns;
        pino2 <= '1';
        wait for CLK_PERIOD;
        pino2 <= '0';

        wait for 20 ns;
        pino3 <= '1';
        wait for CLK_PERIOD;
        pino3 <= '0';

        wait for 20 ns;
        pino4 <= '1';
        wait for CLK_PERIOD;
        pino4 <= '0';

        wait for 20 ns;
        pino5 <= '1';
        wait for CLK_PERIOD;
        pino5 <= '0';

        wait for 20 ns;
        pino6 <= '1';
        wait for CLK_PERIOD;
        pino6 <= '0';

        wait for 20 ns;
        pino7 <= '1';
        wait for CLK_PERIOD;
        pino7 <= '0';

        wait for 100 ns;
        finish_sim <= true; -- End simulation
        wait;
    end process;

    -- Instantiate the DUT
    component state_machine
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
    end component;

    -- Connect DUT to testbench signals
    signal dut_clk: std_logic := clk;
    signal dut_reset: std_logic := reset;
    signal dut_pino1: std_logic := pino1;
    signal dut_pino2: std_logic := pino2;
    signal dut_pino3: std_logic := pino3;
    signal dut_pino4: std_logic := pino4;
    signal dut_pino5: std_logic := pino5;
    signal dut_pino6: std_logic := pino6;
    signal dut_pino7: std_logic := pino7;
    signal dut_display: std_logic_vector(6 downto 0) := display;
    signal dut_produto_dispensado: std_logic := produto_dispensado;

begin
    -- Instantiate the DUT
    dut_inst : state_machine
        generic map (
            CLK_FREQ => 10_000_000
        )
        port map (
            clk => dut_clk,
            reset => dut_reset,
            pino1 => dut_pino1,
            pino2 => dut_pino2,
            pino3 => dut_pino3,
            pino4 => dut_pino4,
            pino5 => dut_pino5,
            pino6 => dut_pino6,
            pino7 => dut_pino7,
            display => dut_display,
            produto_dispensado => dut_produto_dispensado
        );

    -- Add assertions or checks if needed

end architecture testbench;


