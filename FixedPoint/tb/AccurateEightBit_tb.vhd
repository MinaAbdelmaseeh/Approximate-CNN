----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 08:08:14 PM
-- Design Name: 
-- Module Name: AccurateEightBit_tb - Behavioral
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

entity AccurateEightBit_tb is
--  Port ( );
end AccurateEightBit_tb;

architecture Behavioral of AccurateEightBit_tb is
component AccurateEightBit is
Port (
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        Output: out std_logic_vector(15 downto 0)
);
end component;
--Inputs 
signal A_test: std_logic_vector(7 downto 0);
signal B_test: std_logic_vector(7 downto 0);
--outputs
signal Output_test: std_logic_vector(15 downto 0);
begin
uut: AccurateEightBit
Port Map(
A_test,
B_test,
Output_test
);
stim_process: Process
begin
A_test <= "10010111";
B_test <= "10101010";wait for 10ns;
end process;
end Behavioral;