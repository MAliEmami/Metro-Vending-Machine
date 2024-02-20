library ieee;
use ieee.std_logic_1164.all;

entity metro_vending_machine is
    Port (
        Coin500     :  in std_logic_vector (1 downto 0);
        Coin1000    :  in std_logic_vector (1 downto 0);
        TicketType  :  in std_logic_vector (1 downto 0);
        clk         :  in std_logic;
        Exchange    : out integer := 0
    );
end metro_vending_machine;

architecture Behavioral of metro_vending_machine is
    signal SelectedTicket   : integer := 0;
    signal InternalExchange : integer := 0;
    signal IsItPossible     : boolean;
begin
    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (Coin1000 = "00") then
                if (Coin500 = "00") then 
                    InternalExchange <= 0 + 0;
                elsif (Coin500 = "01") then
                    InternalExchange <= 0 + 500;
                elsif (Coin500 = "10") then
                    InternalExchange <= 0 + 500 + 500;
                elsif (Coin500 = "11") then
                    InternalExchange <= 0 + 500 + 500 + 500;
                    end if;
                    elsif (Coin1000 = "01") then
                        if (Coin500 = "00") then 
                        InternalExchange <= 1000 + 0;
                        elsif (Coin500 = "01") then
                            SelectedTicket <= InternalExchange;
                    InternalExchange <= 1000 + 500;
                elsif (Coin500 = "10") then
                    InternalExchange <= 1000 + 500 + 500;
                elsif (Coin500 = "11") then
                    InternalExchange <= 1000 + 500 + 500 + 500;
                end if;
            elsif (Coin1000 = "10") then
                if (Coin500 = "00") then 
                    InternalExchange <= 2000 + 0;
                elsif (Coin500 = "01") then
                    InternalExchange <= 2000 + 500;
                elsif (Coin500 = "10") then
                    InternalExchange <= 2000 + 500 + 500;
                elsif (Coin500 = "11") then
                    InternalExchange <= 2000 + 500 + 500 + 500;
                end if;
            elsif (Coin1000 = "11") then
                if (Coin500 = "00") then 
                    InternalExchange <= 3000 + 0;
                elsif (Coin500 = "01") then
                    InternalExchange <= 3000 + 500;
                elsif (Coin500 = "10") then
                    InternalExchange <= 3000 + 500 + 500;
                elsif (Coin500 = "11") then
                    InternalExchange <= 3000 + 500 + 500 + 500;
                end if;
            end if;

            case TicketType is
                when "01" =>
                    SelectedTicket <= 500;
                    IsItPossible <= (InternalExchange >= 500);
                    InternalExchange <= InternalExchange - 500;

                when "10" =>
                    SelectedTicket <= 1500;
                    InternalExchange <= InternalExchange - 1500;
                    IsItPossible <= (InternalExchange >= 1500);

                when "11" =>
                    SelectedTicket <= 4000;
                    InternalExchange <= InternalExchange - 4000;
                    IsItPossible <= (InternalExchange >= 4000);

                when others =>
                    SelectedTicket <= 0;
                    InternalExchange <= 0;
                    IsItPossible <= false;
            end case;
        end if;
            end process;
    Exchange <= InternalExchange;

end Behavioral;