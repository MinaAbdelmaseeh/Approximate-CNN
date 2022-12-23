----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 04:16:10 PM
-- Design Name: 
-- Module Name: AccurateMultiplier_tb - Behavioral
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

entity AccurateMultiplier_tb is
--  Port ( );
end AccurateMultiplier_tb;

architecture Behavioral of AccurateMultiplier_tb is
component AccurateMultiplier is
Port (
        A: in std_logic_vector(1 downto 0);
        B: in std_logic_vector(1 downto 0);
        Output: out std_logic_vector(3 downto 0)
);
end component;
--Inputs 
signal A_test: std_logic_vector(1 downto 0);
signal B_test: std_logic_vector(1 downto 0);
--outputs
signal Output_test: std_logic_vector(3 downto 0);
begin
uut: AccurateMultiplier
Port Map(
A_test,
B_test,
Output_test
);
stim_process: Process
begin
A_test <= "10";
B_test <= "11";wait for 10ns;
end process;
end Behavioral;
