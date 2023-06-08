library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vending_machine_tb is
end entity vending_machine_tb;

architecture tb_arch of vending_machine_tb is
    -- Component declaration for the DUT (Device Under Test)
    component vending_machine
        port (
            select_pins: in std_logic_vector(2 downto 0);
            coin_pins: in std_logic_vector(3 downto 0);
            display: out std_logic_vector(6 downto 0);
            dispenser: out std_logic
        );
    end component;

    -- Signals for the testbench
    signal select_pins_tb: std_logic_vector(2 downto 0);
    signal coin_pins_tb: std_logic_vector(3 downto 0);
    signal dispenser_tb: std_logic;

begin
    -- Instantiate the DUT
    dut: vending_machine
        port map (
            select_pins => select_pins_tb,
            coin_pins => coin_pins_tb,
            display => open,  -- Don't care about display output in this testbench
            dispenser => dispenser_tb
        );

    -- Stimulus process
    stimulus_proc: process
    begin
        -- Test case 1: Select product 0, add sufficient coins, dispense
        select_pins_tb <= "000";
        coin_pins_tb <= "0010";
        wait for 10 ns;
        assert dispenser_tb = '1'
            report "Incorrect dispenser activation for test case 1" severity error;

        -- Test case 2: Select product 3, add insufficient coins, no dispense
        select_pins_tb <= "011";
        coin_pins_tb <= "0000";
        wait for 10 ns;
        assert dispenser_tb = '0'
            report "Incorrect dispenser activation for test case 2" severity error;

        -- Test case 3: Select product 2, add sufficient coins, dispense
        select_pins_tb <= "010";
        coin_pins_tb <= "1010";
        wait for 10 ns;
        assert dispenser_tb = '1'
            report "Incorrect dispenser activation for test case 3" severity error;

        -- Test case 4: Select product 1, add insufficient coins, no dispense
        select_pins_tb <= "001";
        coin_pins_tb <= "0010";
        wait for 10 ns;
        assert dispenser_tb = '0'
            report "Incorrect dispenser activation for test case 4" severity error;

        wait;
    end process stimulus_proc;

end architecture tb_arch;
