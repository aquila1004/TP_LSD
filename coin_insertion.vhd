library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coin_insertion is
    port (
        pino4: in std_logic;
        pino5: in std_logic;
        pino6: in std_logic;
        pino7: in std_logic;
        coinSum: inout unsigned(6 downto 0)
    );
end entity coin_insertion;

architecture behavioral of coin_insertion is
    signal coins: unsigned(6 downto 0) := (others => '0');
begin
    process (pino4, pino5, pino6, pino7)
    begin
        if rising_edge(pino4) then
            coins <= coins + 1;
        end if;
        
        if rising_edge(pino5) then
            coins <= coins + 2;
        end if;
        
        if rising_edge(pino6) then
            coins <= coins + 5;
        end if;
        
        if rising_edge(pino7) then
            coins <= coins + 10;
        end if;
        
        coinSum <= coins;
    end process;
end architecture behavioral;
