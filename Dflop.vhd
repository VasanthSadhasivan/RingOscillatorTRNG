---------------------------------------------------------------------------------- 
-- Engineer:  Jacob Torchia and Vasanth Sadhasivan
-- 
-- Create Date: 05/07/2021 10:58:32 PM
-- Design Name: Dflop
-- Module Name: Dflop - Behavioral
-- Project Name: RO_TRNG
-- Target Devices: Basys 3
-- Description: D flip flop with init (reset) and clock enable
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Dflop is
    Port ( clk  : in STD_LOGIC;
           D    : in STD_LOGIC;
           CE   : in STD_LOGIC;
           init : in STD_LOGIC;
           Q     : out STD_LOGIC);
end Dflop;

architecture Behavioral of Dflop is

begin

    flop: process(clk)
    begin
        if (init = '1') then
            Q <= '0';
        elsif rising_edge(clk) then
            if (CE = '1') then
                Q <= D;
            end if;
        end if;
    end process flop;
    
end Behavioral;
