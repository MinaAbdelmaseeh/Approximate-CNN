----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 10:50:33 PM
-- Design Name: 
-- Module Name: mult2_tb - Behavioral
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

entity mult2_tb is
--  Port ( );
end mult2_tb;

architecture Behavioral of mult2_tb is
component mult2 is
  Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
     B : in STD_LOGIC_VECTOR (1 downto 0);
     C : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal A: STD_LOGIC_VECTOR (1 downto 0):= (Others =>'0');
signal B: STD_LOGIC_VECTOR (1 downto 0):= (Others =>'0');
signal C: STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
begin
uut : mult2 PORT MAP (A=>A, B=>B, C=>C);
stim_proc: process
begin
wait for 50ns;
A<="00"; B<="00"; wait for 50ns;
A<="00"; B<="11"; wait for 50ns;
A<="11"; B<="00"; wait for 50ns;
A<="11"; B<="01"; wait for 50ns;
A<="11"; B<="10"; wait for 50ns;
A<="10"; B<="10"; wait for 50ns;
A<="01"; B<="10"; wait for 50ns;
A<="11"; B<="11"; wait;
end process;

end Behavioral;
