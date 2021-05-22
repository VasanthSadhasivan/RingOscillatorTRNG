----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2021 08:40:49 PM
-- Design Name: 
-- Module Name: controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
    Port ( clk    : in STD_LOGIC;
           sample : in STD_LOGIC;
           reset   : out STD_LOGIC;
           enable  : out STD_LOGIC);
end controller;

architecture Behavioral of controller is
    
    constant numZeros      : std_logic_vector(3 downto 0) := "1000";
    
    signal zerosCnt        : std_logic_vector(3 downto 0);
    signal zerosDone       : std_logic;
    signal prevSample      : std_logic;
    
begin
    
    enable <= (zerosDone);
    reset  <= NOT(zerosDone);
    
    storeSample: process(sample,clk)
    begin
        if rising_edge(clk) then
            prevSample <= sample;
        end if;
    end process;
    
    zeroCnt: process(sample,clk)
    begin
        if rising_edge(clk) then
            zerosDone <= '1';
            if (prevSample='0')AND(sample='1') then
                zerosCnt <= (others=>'0');
                zerosDone <= '0';
            elsif zerosCnt < numZeros then
                zerosDone <= '0';
                if sample = '0' then
                    zerosCnt <= zerosCnt +1;
                end if;
            end if;
        end if;
    end process;

end Behavioral;