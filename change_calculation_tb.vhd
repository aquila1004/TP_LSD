library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity change_calculation_tb is
end entity change_calculation_tb;

architecture tb of change_calculation_tb is
    component change_calculation
        port (
            productPrice: in unsigned(3 downto 0);
            coinSum: in unsigned(6 downto 0);
            change: out unsigned(6 downto 0)
        );
    end component change_calculation;
    
    signal productPrice_tb: unsigned(3 downto 0) := (others => '0');
    signal coinSum_tb: unsigned(6 downto 0) := (others => '0');
    signal change_tb: unsigned(6 downto 0);
    
    constant TbPeriod : time := 1000 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
begin
    dut: change_calculation
        port map (
            productPrice => productPrice_tb,
            coinSum => coinSum_tb,
            change => change_tb
        );
    
    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    
    stimuli: process
    begin
        -- Test case 1: coinSum < productPrice
        productPrice_tb <= "0010";  -- Product price: 2
        coinSum_tb <= "0000010";    -- Coin sum: 2
        wait for TbPeriod;
        
        -- Test case 2: coinSum = productPrice
        productPrice_tb <= "0011";  -- Product price: 3
        coinSum_tb <= "0000011";    -- Coin sum: 3
        wait for TbPeriod;
        
        -- Test case 3: coinSum > productPrice
        productPrice_tb <= "0010";  -- Product price: 2
        coinSum_tb <= "0000110";    -- Coin sum: 6
        wait for TbPeriod;
        
        -- Stop the clock and end the simulation
        TbSimEnded <= '1';
        wait;
    end process;
    
    -- Check the output change value for each test case
    check_output: process
    begin
        wait until TbSimEnded = '1';
        
        -- Test case 1: coinSum < productPrice
        if change_tb /= "0000000" then
            report "Incorrect change value for test case 1!" severity error;
        else
            report "Change value for test case 1 is correct!" severity note;
        end if;
        
        -- Test case 2: coinSum = productPrice
        if change_tb /= "0000000" then
            report "Incorrect change value for test case 2!" severity error;
        else
            report "Change value for test case 2 is correct!" severity note;
        end if;
        
        -- Test case 3: coinSum > productPrice
        if change_tb /= "0000100" then
            report "Incorrect change value for test case 3!" severity error;
        else
            report "Change value for test case 3 is correct!" severity note;
        end if;
        
        wait;
    end process;
    
end tb;

-- Configuration block (may not be necessary depending on the simulator)

configuration cfg_tb_change_calculation of change_calculation_tb is
    for tb
    end for;
end cfg_tb_change_calculation;
