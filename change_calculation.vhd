library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity change_calculation is
    port (
        productPrice: in unsigned(3 downto 0);
        coinSum: in unsigned(6 downto 0);
        change: out unsigned(6 downto 0)
    );
end entity change_calculation;

architecture behavioral of change_calculation is
begin
    process (productPrice, coinSum)
    begin
        if coinSum >= productPrice then
            change <= coinSum - productPrice;
        else
            change <= (others => '0');
        end if;
    end process;
end architecture behavioral;
