----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2021 02:18:26 PM
-- Design Name: 
-- Module Name: shift_register - Behavioral
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

entity shift_register is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC;
           push : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end shift_register;

architecture Behavioral of shift_register is

signal internalBuffer : std_logic_vector(7 downto 0);

begin

    main : process(clk, push)
    begin
        if rising_edge(clk) then 
            if push = '1' then
                internalBuffer(7) <= internalBuffer(6);
                internalBuffer(6) <= internalBuffer(5);
                internalBuffer(5) <= internalBuffer(4);
                internalBuffer(4) <= internalBuffer(3);
                internalBuffer(3) <= internalBuffer(2);
                internalBuffer(2) <= internalBuffer(1);
                internalBuffer(1) <= internalBuffer(0);
                internalBuffer(0) <= input;
            end if;
        end if;
    end process;

end Behavioral;
