library IEEE;
use IEEE.std_logic_1164.all;

entity dispenser is
    port (
        state: in std_logic;
        dispenserSignal: out std_logic
    );
end entity dispenser;

architecture behavioral of dispenser is
begin
    process (state)
    begin
        if state = '1' then
            dispenserSignal <= '1';
        else
            dispenserSignal <= '0';
        end if;
    end process;
end architecture behavioral;
