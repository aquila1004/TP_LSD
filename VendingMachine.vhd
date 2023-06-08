
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
    entity VendingMachine is
        port (
            clk          : in  std_logic;
            reset        : in  std_logic;
            coin1        : in  std_logic;
            coin2        : in  std_logic;
            coin5        : in  std_logic;
            coin10       : in  std_logic;
            product1     : in  std_logic;
            product3     : in  std_logic;
            product4     : in  std_logic;
            product7     : in  std_logic;
            product9     : in  std_logic;
            product10    : in  std_logic;
            total        : out std_logic_vector(4 downto 0);
            change       : out std_logic_vector(4 downto 0);
            vend         : out std_logic;
            segA, segB   : out std_logic;
            segC, segD   : out std_logic;
            segE, segF   : out std_logic;
            segG         : out std_logic
        );
    end entity VendingMachine;
    
    architecture Behavioral of VendingMachine is
        signal sum       : unsigned(4 downto 0);
        signal paid      : unsigned(4 downto 0);
        signal price     : unsigned(4 downto 0);
        signal coinValue : unsigned(3 downto 0);
        signal display   : std_logic_vector(6 downto 0);
    
        component SevenSegmentDisplay is
            port (
                input_value : in  std_logic_vector(3 downto 0);
                segments   : out std_logic_vector(6 downto 0)
            );
        end component;
    
        component ChangeCalculator is
            port (
                clk        : in  std_logic;
                reset      : in  std_logic;
                coin1      : in  std_logic;
                coin2      : in  std_logic;
                coin5      : in  std_logic;
                coin10     : in  std_logic;
                product1   : in  std_logic;
                product3   : in  std_logic;
                product4   : in  std_logic;
                product7   : in  std_logic;
                product9   : in  std_logic;
                product10  : in  std_logic;
                total      : out std_logic_vector(4 downto 0);
                change     : out std_logic_vector(4 downto 0);
                vend       : out std_logic
            );
        end component;
    
    begin
    
        Display: SevenSegmentDisplay port map (
            input_value => display,
            segments => (segA, segB, segC, segD, segE, segF, segG)
        );
    
        Calculation: ChangeCalculator port map (
            clk => clk,
            reset => reset,
            coin1 => coin1,
            coin2 => coin2,
            coin5 => coin5,
            coin10 => coin10,
            product1 => product1,
            product3 => product3,
            product4 => product4,
            product7 => product7,
            product9 => product9,
            product10 => product10,
            total => total,
            change => change,
            vend => vend
        );
    
        process(clk)
        begin
            if rising_edge(clk) then
                if reset = '1' then
                    sum <= (others => '0');
                    paid <= (others => '0');
                    price <= (others => '0');
                    coinValue <= (others => '0');
                else
                    if coin1 = '1' then
                        coinValue <= "0001";
                        paid <= paid + coinValue;
                    elsif coin2 = '1' then
                        coinValue <= "0010";
                        paid <= paid + coinValue;
                    elsif coin5 = '1' then
                        coinValue <= "0101";
                        paid <= paid + coinValue;
                    elsif coin10 = '1' then
                        coinValue <= "1010";
                        paid <= paid + coinValue;
                    end if;
                    
                    if product1 = '1' then
                        price <= "00001";
                    elsif product3 = '1' then
                        price <= "00011";
                    elsif product4 = '1' then
                        price <= "00100";
                    elsif product7 = '1' then
                        price <= "00111";
                    elsif product9 = '1' then
                        price <= "01001";
                    elsif product10 = '1' then
                        price <= "01010";
                    else
                        price <= (others => '0');
                    end if;
                    
                    sum <= sum + coinValue;
                    
                    if sum >= price then
                        change <= std_logic_vector(sum - price);
                        vend <= '1';
                    else
                        change <= (others => '0');
                        vend <= '0';
                    end if;
                end if;
            end if;
        end process;
    
    end architecture Behavioral;
    
