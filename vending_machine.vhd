library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vending_machine is
    port (
        select_pins: in std_logic_vector(2 downto 0);
        coin_pins: in std_logic_vector(3 downto 0);
        display: out std_logic_vector(6 downto 0);
        dispenser: out std_logic
    );
end entity vending_machine;

architecture behavioral of vending_machine is
    type state_type is (selecting, waiting, adding, calculating_change, dispensing);
    signal state: state_type;
    signal product_price: unsigned(3 downto 0);
    signal coin_sum: unsigned(7 downto 0);
    signal change: unsigned(7 downto 0);
begin
    process (state, select_pins, coin_pins)
    begin
        case state is
            when selecting =>
                if select_pins = "000" then
                    product_price <= "0001";
                elsif select_pins = "001" then
                    product_price <= "0010";
                elsif select_pins = "010" then
                    product_price <= "0011";
                elsif select_pins = "011" then
                    product_price <= "0101";
                elsif select_pins = "100" then
                    product_price <= "1010";
                elsif select_pins = "101" then
                    product_price <= "1111";
                else
                    product_price <= "0000";
                end if;
                
                state <= waiting;

            when waiting =>
                if coin_pins /= "0000" then
                    state <= adding;
                end if;

            when adding =>
                coin_sum <= coin_sum + unsigned(coin_pins);
                state <= waiting;

            when calculating_change =>
                if coin_sum >= product_price then
                    change <= coin_sum - product_price;
                else
                    change <= "00000000";
                end if;
                
                state <= dispensing;

            when dispensing =>
                if change /= "00000000" then
                    dispenser <= '1';
                else
                    dispenser <= '0';
                end if;
                state <= selecting;

        end case;
    end process;
end architecture behavioral;
