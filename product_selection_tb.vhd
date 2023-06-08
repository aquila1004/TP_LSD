library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity product_selection_tb is
end entity product_selection_tb;

architecture tb of product_selection_tb is
    component product_selection
        port (
            pino1: in std_logic;
            pino2: in std_logic;
            pino3: in std_logic;
            produto_preco: out unsigned(3 downto 0)
        );
    end component product_selection;
    
    signal pino1_tb: std_logic := '0';
    signal pino2_tb: std_logic := '0';
    signal pino3_tb: std_logic := '0';
    signal produto_preco_tb: unsigned(3 downto 0);
    
    constant TbPeriod : time := 1000 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
begin
    dut: product_selection
        port map (
            pino1 => pino1_tb,
            pino2 => pino2_tb,
            pino3 => pino3_tb,
            produto_preco => produto_preco_tb
        );
    
    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    
    stimuli: process
    begin
        -- Initialization
        pino1_tb <= '0';
        pino2_tb <= '0';
        pino3_tb <= '0';
        
        -- Selecting product 1
        pino1_tb <= '0';
        pino2_tb <= '0';
        pino3_tb <= '0';
        wait for TbPeriod;
        
        -- Selecting product 2
        pino1_tb <= '0';
        pino2_tb <= '0';
        pino3_tb <= '1';
        wait for TbPeriod;
        
        -- Selecting product 3
        pino1_tb <= '0';
        pino2_tb <= '1';
        pino3_tb <= '0';
        wait for TbPeriod;
        
        -- Selecting product 4
        pino1_tb <= '0';
        pino2_tb <= '1';
        pino3_tb <= '1';
        wait for TbPeriod;
        
        -- Selecting product 5
        pino1_tb <= '1';
        pino2_tb <= '0';
        pino3_tb <= '0';
        wait for TbPeriod;
        
        -- Selecting product 6
        pino1_tb <= '1';
        pino2_tb <= '0';
        pino3_tb <= '1';
        wait for TbPeriod;
        
        -- Selecting an invalid product
        pino1_tb <= '1';
        pino2_tb <= '1';
        pino3_tb <= '1';
        wait for TbPeriod;
        
        -- Stop the clock and end the simulation
        TbSimEnded <= '1';
        wait;
    end process;
    
    -- Check the selected product price
    check_price: process
    begin
        wait until TbSimEnded = '1';
        
        -- Expected prices: 1, 2, 3, 5, 10, 15, 0
        if produto_preco_tb /= unsigned'("0001") and
           produto_preco_tb /= unsigned'("0010") and
           produto_preco_tb /= unsigned'("0011") and
           produto_preco_tb /= unsigned'("0101") and
           produto_preco_tb /= unsigned'("1010") and
           produto_preco_tb /= unsigned'("1111") then
            report "Incorrect product price!" severity error;
        else
            report "Product price is correct!" severity note;
        end if;
        
        wait;
    end process;
    
end tb;

-- Configuration block (may not be necessary depending on the simulator)

configuration cfg_tb_product_selection of product_selection_tb is
    for tb
    end for;
end cfg_tb_product_selection;
