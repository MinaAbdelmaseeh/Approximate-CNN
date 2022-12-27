----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/27/2022 01:58:13 AM
-- Design Name: 
-- Module Name: mult5_tb - Behavioral
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

entity mult5_tb is
--  Port ( );
end mult5_tb;
         
architecture Behavioral of mult5_tb is
Component mult5 is
 Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
          B : in STD_LOGIC_VECTOR (4 downto 0);
          Output : out STD_LOGIC_VECTOR (9 downto 0));
 end Component; 
signal A: STD_LOGIC_VECTOR (4 downto 0):= (Others =>'0');
signal B: STD_LOGIC_VECTOR (4 downto 0):= (Others =>'0');
signal Output: STD_LOGIC_VECTOR (9 downto 0):= (Others =>'0');     
begin
uut : mult5 PORT MAP (A=>A, B=>B, Output=>Output);
stim_proc: process
begin
wait for 50ns;
A<="00010"; B<="10000"; wait for 50ns;
A<="01000"; B<="10000"; wait for 50ns;
A<="10000"; B<="10000"; wait for 50ns;
A<="10101"; B<="10001"; wait for 50ns;
A<="10010"; B<="10100"; wait for 50ns;
A<="10101"; B<="10101"; wait for 50ns;
A<="10101"; B<="00001"; wait for 50ns;
A<="10101"; B<="01010"; wait for 50ns;
A<="10100"; B<="10100"; wait for 50ns;
A<="01010"; B<="01010"; wait for 50ns;
A<="10010"; B<="01100"; wait for 50ns;
A<="10001"; B<="10001"; wait for 50ns;
A<="01010"; B<="01010"; wait for 50ns;
A<="11111"; B<="11111"; wait;
end process;

end Behavioral;
