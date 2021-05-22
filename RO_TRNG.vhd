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
    
    component ila_0 IS
    PORT (
        clk    : IN STD_LOGIC;       
        probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0));
    end component;
    
    component fsm IS
       PORT(
          clk      : IN   STD_LOGIC;
          bitReady : IN   STD_LOGIC;
          bitValue : IN   STD_LOGIC;
          reset    : IN   STD_LOGIC;
          readAck  : OUT  STD_LOGIC;
          done     : OUT  STD_LOGIC;
          push     : OUT  STD_LOGIC);
    END component;
    
    component controller is
    Port ( clk    : in STD_LOGIC;
           sample : in STD_LOGIC;
           reset   : out STD_LOGIC;
           enable  : out STD_LOGIC);
    end component;
    
    component shift_register is
    Port ( clk    : in STD_LOGIC;
           input  : in STD_LOGIC;
           push   : in STD_LOGIC;
           output  : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    signal clk0     : std_logic;
    signal clk1     : std_logic;
    signal reset    : std_logic;
    signal enable   : std_logic;
    signal readAck  : std_logic;
    signal sample   : std_logic;
    signal bitReady : std_logic;
    signal randOut  : std_logic;
    signal push     : std_logic;
    signal done     : std_logic;
    signal resetFSM : std_logic;
    signal randVal  : std_logic_vector(15 downto 0);
    
    attribute MARK_DEBUG : string;
    attribute MARK_DEBUG of bitReady: signal is "TRUE";
    attribute MARK_DEBUG of push: signal is "TRUE";
    attribute MARK_DEBUG of done: signal is "TRUE";
    attribute MARK_DEBUG of resetFSM: signal is "TRUE";
    attribute MARK_DEBUG of readAck: signal is "TRUE";
    attribute MARK_DEBUG of randOut: signal is "TRUE";
    --attribute MARK_DEBUG of randVal: signal is "TRUE";
    
begin
    RO_0: ring_oscillator
	port map ( output => clk0 ); 
	
	RO_1: ring_oscillator
	port map ( output => clk1 ); 
	
	mySampler: sampler
	port map ( 
	clk0     => clk0, 
    clk1     => clk1,
    reset    => reset,
    enable   => enable,
    readAck  => readAck,
    sample   => sample,
    bitReady => bitReady,
    randOut  => randOut); 
    
    myController: controller
	port map ( 
    clk    => clk1,
    sample => sample,
    reset  => reset,
    enable => enable);
    
    myFSM: fsm
	port map ( 
    clk      => clk,
    bitReady => bitReady,
    bitValue => randOut,
    reset    => resetFSM,
    readAck  => readAck,
    done     => done,
    push     => push);
    LED <= done;
    resetFSM<= BTNC;
    
    myShiftRegister: shift_register
	port map (
    clk    => clk, 
    input  => randOut, 
    push   => push, 
    output => randVal); 
    
    my_sseg_des:sseg_des
    port map ( 
    COUNT 	 => randVal,  
    CLK      => clk,
    VALID    => '1',
    DISP_EN  => DISP_EN,
    SEGMENTS => SEGMENTS);
    
end Behavioral;
