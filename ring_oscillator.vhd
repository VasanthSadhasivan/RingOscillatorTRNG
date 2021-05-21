----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2021 11:43:28 AM
-- Design Name: 
-- Module Name: ring_oscillator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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

entity ring_oscillator is
    Port ( 
        output  : out std_logic
    );
end ring_oscillator;

architecture Behavioral of ring_oscillator is
    
    attribute KEEP : string;
    attribute S    : string;


    signal wire1 : std_logic := '0';
    signal wire2 : std_logic := '1';
    signal wire3 : std_logic := '1';
    signal wire4 : std_logic := '1';
    signal wire5 : std_logic := '1';
    
    signal outputwire : std_logic := '1';
    
    
    signal enable : std_logic := '0';
    
    attribute KEEP of wire1   : signal is "True";
    attribute S    of wire1   : signal is "True";
    attribute KEEP of wire2   : signal is "True";
    attribute S    of wire2   : signal is "True";
    attribute KEEP of wire3   : signal is "True";
    attribute S    of wire3   : signal is "True";
    attribute KEEP of wire4   : signal is "True";
    attribute S    of wire4   : signal is "True";
    attribute KEEP of wire5   : signal is "True";
    attribute S    of wire5   : signal is "True";
    attribute KEEP of outputwire : signal is "True";
    attribute S    of outputwire : signal is "True";
    attribute KEEP of enable  : signal is "True";
    attribute S    of enable  : signal is "True";

begin
    enable <= '1';
    wire2 <= not wire1;
    
    latch1 : process(enable)
    begin
        if enable = '1' then
            wire3 <= wire2;
        end if;
    end process;
    
    wire4 <= not wire3;
    wire5 <= not wire4;
    
    latch2 : process(enable)
    begin
        if enable = '1' then
            wire1 <= wire5;
        end if;
    end process;
    
    outputwire <= not wire5;
    output <= not outputwire;
end Behavioral;
