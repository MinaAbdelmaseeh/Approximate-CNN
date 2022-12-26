----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2022 10:00:55 PM
-- Design Name: 
-- Module Name: mult4_tb - Behavioral
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

entity mult4_tb is
--  Port ( );
end mult4_tb;

architecture Behavioral of mult4_tb is
component mult4 is
 Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
      B : in STD_LOGIC_VECTOR (3 downto 0);
      C : out STD_LOGIC_VECTOR (7 downto 0));
end component; 
signal A: STD_LOGIC_VECTOR (3 downto 0):= (Others =>'0');
signal B: STD_LOGIC_VECTOR (3 downto 0):= (Others =>'0');
signal C: STD_LOGIC_VECTOR (7 downto 0):= (Others =>'0');     
begin
uut : mult4 PORT MAP (A=>A, B=>B, C=>C);
stim_proc: process
begin
wait for 50ns;
A<="0001"; B<="1000"; wait for 50ns;
A<="0100"; B<="1000"; wait for 50ns;
A<="1000"; B<="1000"; wait for 50ns;
A<="1010"; B<="1000"; wait for 50ns;
A<="1001"; B<="1010"; wait for 50ns;
A<="1010"; B<="0101"; wait for 50ns;
A<="1010"; B<="0000"; wait for 50ns;
A<="1010"; B<="0101"; wait for 50ns;
A<="1010"; B<="1010"; wait for 50ns;
A<="0101"; B<="0101"; wait for 50ns;
A<="1001"; B<="0110"; wait for 50ns;
A<="1001"; B<="1001"; wait for 50ns;
A<="0110"; B<="0110"; wait for 50ns;
A<="1111"; B<="1111"; wait;
end process;

end Behavioral;
