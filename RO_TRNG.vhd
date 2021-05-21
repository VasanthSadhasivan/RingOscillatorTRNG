----------------------------------------------------------------------------------
-- Engineer: Jacob Torchia and Vasanth Sadhasivan
-- 
-- Create Date: 05/08/2021 12:02:05 AM
-- Design Name:  RO_TRNG
-- Module Name: RO_TRNG - Behavioral
-- Project Name: RO_TRNG
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Top level of RO_TRNG
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

entity RO_TRNG is
    Port ( CLK     : in STD_LOGIC;
           BTNC    : in STD_LOGIC;
           LED      : out STD_LOGIC;
           DISP_EN  : out STD_LOGIC_VECTOR (3 downto 0);
           SEGMENTS : out STD_LOGIC_VECTOR (6 downto 0));
end RO_TRNG;

architecture Behavioral of RO_TRNG is

    component sampler is
        Port ( clk0    : in STD_LOGIC;
               clk1    : in STD_LOGIC;
               reset   : in STD_LOGIC;
               enable  : in STD_LOGIC;
               readAck : in STD_LOGIC;
               sample   : out STD_LOGIC;
               bitReady : out STD_LOGIC;
               randOut  : out STD_LOGIC);
    end component;

    component ring_oscillator is
        Port ( 
            output  : out std_logic
        );
    end component;

    component sseg_des is
    Port( COUNT : in std_logic_vector(15 downto 0); 				  
            CLK : in std_logic;
          VALID : in std_logic;
        DISP_EN : out std_logic_vector(3 downto 0);
       SEGMENTS : out std_logic_vector(6 downto 0)); -- Decimal Point is never used
    end component;

    component fsm IS
       PORT(
          clk      : IN   STD_LOGIC;
          bitReady : IN   STD_LOGIC;
          reset    : IN   STD_LOGIC;
          readAck  : OUT  STD_LOGIC;
          done     : OUT  STD_LOGIC;
          push     : OUT  STD_LOGIC);
    END component;

begin

end Behavioral;
