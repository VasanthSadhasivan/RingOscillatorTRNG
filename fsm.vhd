----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2021 03:15:01 PM
-- Design Name: 
-- Module Name: fsm - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY fsm IS
   PORT(
      clk      : IN   STD_LOGIC;
      bitReady : IN   STD_LOGIC;
      reset    : IN   STD_LOGIC;
      readAck  : OUT  STD_LOGIC;
      done     : OUT  STD_LOGIC;
      push     : OUT  STD_LOGIC);
END fsm;
ARCHITECTURE a OF fsm IS
   TYPE STATE_TYPE IS (initState, waitState, pushState, indexCheckState, doneState);
   SIGNAL state   : STATE_TYPE;
   SIGNAL index   : std_logic_vector(4 downto 0);
BEGIN
   PROCESS (clk, reset)
   BEGIN
      IF reset = '1' THEN
         state <= initState;
      ELSIF (clk'EVENT AND clk = '1') THEN
         CASE state IS
            WHEN initState=>
               IF reset = '1' THEN
                  state <= initState;
               ELSE
                  index <= "00000";
                  state <= waitState;
               END IF;
            WHEN waitState=>
               IF bitReady = '1' THEN
                  state <= pushState;
                  index <= index + 1;
               ELSE
                  state <= waitState;
               END IF;
            WHEN pushState=>
               IF bitReady = '1' THEN
                  state <= pushState;
               ELSE
                  state <= indexCheckState;
               END IF;
            WHEN indexCheckState=>
               IF index < "1000" THEN
                  state <= waitState;
               ELSE
                  state <= doneState;
               END IF;
            WHEN doneState=>
               IF reset = '1' THEN
                  state <= initState;
               ELSE
                  state <= doneState;
               END IF;
         END CASE;
      END IF;
   END PROCESS;
   
   PROCESS (state)
   BEGIN
      CASE state IS
         WHEN initState =>
            done <= '0';
            push <= '0';
         WHEN waitState =>
            done <= '0';
            push <= '0';
         WHEN pushState =>
            done <= '0';
            push <= '1';
         WHEN indexCheckState =>
            done <= '0';
            push <= '0';
         WHEN doneState =>
            done <= '1';
            push <= '0';
      END CASE;
   END PROCESS;
   
END a;
