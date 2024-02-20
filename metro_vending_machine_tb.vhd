library ieee;
use ieee.std_logic_1164.all;

entity metro_vending_machine_tb is
end metro_vending_machine_tb;

architecture sim of metro_vending_machine_tb is

    component metro_vending_machine is 
        port (

            Coin500     :  in std_logic_vector (1 downto 0);
            Coin1000    :  in std_logic_vector (1 downto 0);
            TicketType  :  in std_logic_vector (1 downto 0);
            clk         :  in std_logic;
            Exchange    : out integer := 0
        );
    end component;

    signal Coin500_tb      : std_logic_vector(1 downto 0);
    signal Coin1000_tb     : std_logic_vector(1 downto 0);
    signal TicketType_tb   : std_logic_vector(1 downto 0);
    signal Exchange_tb     : integer := 0;
    signal IsItPossible_tb : boolean;
    signal clk_tb          : std_logic := '0';

begin
    uut: metro_vending_machine
        port map (
            Coin500     => Coin500_tb,
            Coin1000    => Coin1000_tb,
            TicketType  => TicketType_tb,
            Exchange    => Exchange_tb,
            clk         => clk_tb
        );

        clk_tb <= not clk_tb after 10 ns;
        process
        begin
        wait for 20 ns;
        Coin500_tb    <= "00"; -- "00" == 0,   "01" == 500,  "10" == 1000, "11" == 1500
        Coin1000_tb   <= "01"; -- "00" == 0,   "01" == 1000, "10" == 2000, "11" == 3000
        TicketType_tb <= "11"; -- "01" == 500 , "10" == 1500, "11" == 4000
        wait for 15 ns;
        TicketType_tb <= "00";
        -- report "Exchange:     " & integer'image(Exchange_tb);
        -- report "IsItPossible: " & boolean'image(IsItPossible_tb);

        wait;
    end process;

end architecture sim;
