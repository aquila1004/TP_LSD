library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coin_insertion_tb is
end entity coin_insertion_tb;

architecture tb of coin_insertion_tb is
    component coin_insertion
        port (
            pino4: in std_logic;
            pino5: in std_logic;
            pino6: in std_logic;
            pino7: in std_logic;
            coinSum: inout unsigned(6 downto 0)
        );
    end component coin_insertion;
    
    signal pino4_tb: std_logic := '0';
    signal pino5_tb: std_logic := '0';
    signal pino6_tb: std_logic := '0';
    signal pino7_tb: std_logic := '0';
    signal coinSum_tb: unsigned(6 downto 0);
    
    constant TbPeriod : time := 1000 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
begin
    dut: coin_insertion
        port map (
            pino4 => pino4_tb,
            pino5 => pino5_tb,
            pino6 => pino6_tb,
            pino7 => pino7_tb,
            coinSum => coinSum_tb
        );
    
    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    
    stimuli: process
    begin
        -- Initialization
        pino4_tb <= '0';
        pino5_tb <= '0';
        pino6_tb <= '0';
        pino7_tb <= '0';
        
        -- Inserting coins
        pino4_tb <= '1'; -- Coin of value 1
        wait for TbPeriod;
        
        pino5_tb <= '1'; -- Coin of value 2
        wait for TbPeriod;
        
        pino6_tb <= '1'; -- Coin of value 5
        wait for TbPeriod;
        
        pino7_tb <= '1'; -- Coin of value 10
        wait for TbPeriod;
        
        pino4_tb <= '0'; -- Stop inserting coins
        
        wait for 100 * TbPeriod;
        
        -- Stop the clock and end the simulation
        TbSimEnded <= '1';
        wait;
    end process;
    
    -- Check if the sum of all coins is correct
    check_sum: process
    begin
        wait until TbSimEnded = '1';
        
        -- Expected sum: 1 + 2 + 5 + 10 = 18
        if coinSum_tb /= unsigned'("010010") then
            report "Incorrect sum of coins!" severity error;
        else
            report "Sum of coins is correct!" severity note;
        end if;
        
        wait;
    end process;
    
end tb;

-- Configuration block (may not be necessary depending on the simulator)

configuration cfg_tb_coin_insertion of coin_insertion_tb is
    for tb
    end for;
end cfg_tb_coin_insertion;
