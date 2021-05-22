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
      bitValue : IN   STD_LOGIC;
      bitReady : IN   STD_LOGIC;
      reset    : IN   STD_LOGIC;
      readAck  : OUT  STD_LOGIC;
      done     : OUT  STD_LOGIC;
      push     : OUT  STD_LOGIC);
END fsm;
ARCHITECTURE a OF fsm IS
   TYPE STATE_TYPE IS (initState, wait1State, putFirstState, wait2State, putSecondState, checkState, pushState, doneState);
   SIGNAL state   : STATE_TYPE;
   SIGNAL index   : std_logic_vector(4 downto 0);
   SIGNAL firstValue : std_logic;
   SIGNAL secondValue : std_logic;
   attribute MARK_DEBUG : string;
   attribute MARK_DEBUG of state: signal is "TRUE";
   attribute MARK_DEBUG of index: signal is "TRUE";
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
                  state <= wait1State;
               END IF;
            WHEN wait1State=>
               IF bitReady = '1' THEN
                  state <= putFirstState;
               ELSE
                  state <= wait1State;
               END IF;
            WHEN putFirstState=>
               if bitReady = '1' then
                  state <= putFirstState;
               else
                  state <= wait2State;
               end if;
            WHEN wait2State =>
               IF bitReady = '1' THEN
                  state <= putSecondState;
               ELSE
                  state <= wait2State;
               END IF;
            WHEN putSecondState=>
               if bitReady = '1' then
                  state <= putSecondState;
               else
                  state <= checkState;
               end if;
            WHEN checkState=>
               if firstValue /= secondValue then
                  state <= pushState;
                  index <= index + 1;
               else
                  state <= wait1State;
               end if;
            WHEN pushState=>
               if index < "10000" then
                  state <= wait1State;
               else
                  state <= doneState;
               end if;
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
            readAck <= '0';
            done <= '0';
            push <= '0';
         WHEN wait1State =>
            readAck <= '0';
            done <= '0';
            push <= '0';
         when putFirstState =>
            done <= '0';
            push <= '0';
            readAck <= '1';
            firstValue <= bitValue;
         WHEN wait2State =>
            readAck <= '0';
            done <= '0';
            push <= '0';
         when putSecondState =>
            done <= '0';
            push <= '0';
            readAck <= '1';
            secondValue <= bitValue;
         WHEN checkState =>
            readAck <= '0';
            done <= '0';
            push <= '0';
         WHEN pushState =>
            done <= '0';
            push <= '1';
            readAck <= '0';
         WHEN doneState =>
            readAck <= '0';
            done <= '1';
            push <= '0';
      END CASE;
   END PROCESS;
   
END a;
