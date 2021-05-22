---------------------------------------------------------------------------------- 
-- Engineer:  Jacob Torchia and Vasanth Sadhasivan
-- 
-- Create Date: 05/07/2021 10:58:32 PM
-- Design Name: sampler
-- Module Name: sampler - Behavioral
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

entity sampler is
    Port ( clk0    : in STD_LOGIC;
           clk1    : in STD_LOGIC;
           reset   : in STD_LOGIC;
           enable  : in STD_LOGIC;
           readAck : in STD_LOGIC;
           sample   : out STD_LOGIC;
           bitReady : out STD_LOGIC;
           randOut  : out STD_LOGIC);
end sampler;

architecture Behavioral of sampler is
   
    component Dflop is
        Port ( clk  : in STD_LOGIC;
               D    : in STD_LOGIC;
               CE   : in STD_LOGIC;
               init : in STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

    signal C        : std_logic;
    signal notC     : std_logic;
    signal S        : std_logic;
    signal notClk1 : std_logic;
    
begin
    notClk1 <= not Clk1;
    notC    <= not C;
    sample  <= S;
    
    --top left flip flop in figure 5 of paper
    TL_flop: Dflop  
        port map(
            clk  => clk1,
            D    => clk0,
            CE   => '1' ,
            init => '0',
            Q    => S);
            
    --top right flip flop in figure 5 of paper
    TR_flop: Dflop  
        port map(
            clk  => S,
            D    => '1',
            CE   => enable,
            init => readAck,
            Q    => bitReady);
            
    --bottom left flip flop in figure 5 of paper
    BL_flop: Dflop  
        port map(
            clk  => S,
            D    => C,
            CE   => '1',
            init => '0',
            Q    => randOut);
                                
    --bottom right flip flop in figure 5 of paper
    BR_flop: Dflop  
        port map(
            clk  => notClk1,
            D    => notC,
            CE   => enable,
            init => reset,
            Q    => C);
                                        
end Behavioral;
