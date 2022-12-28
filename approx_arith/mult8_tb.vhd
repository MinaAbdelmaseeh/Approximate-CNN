----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2022 06:22:58 PM
-- Design Name: 
-- Module Name: mult8_tb - Behavioral
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

entity mult8_tb is
--  Port ( );
end mult8_tb;

architecture Behavioral of mult8_tb is
Component mult8 is
Port ( 
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        Output: out std_logic_vector(15 downto 0)
);
end component;
signal A: STD_LOGIC_VECTOR (7 downto 0):= (Others =>'0');
signal B: STD_LOGIC_VECTOR (7 downto 0):= (Others =>'0');
signal Output: STD_LOGIC_VECTOR (15 downto 0):= (Others =>'0');     
begin
uut : mult8 PORT MAP (A=>A, B=>B, Output=>Output);
stim_proc: process
begin
wait for 50ns;
A<="00010001"; B<="00001000"; wait for 50ns;
A<="01000000"; B<="00001000"; wait for 50ns;
A<="10000000"; B<="10000000"; wait for 50ns;
A<="10100000"; B<="10001000"; wait for 50ns;
A<="10010000"; B<="10100000"; wait for 50ns;
A<="10100101"; B<="01011010"; wait for 50ns;
A<="10101001"; B<="01100000"; wait for 50ns;
A<="10100110"; B<="01100101"; wait for 50ns;
A<="10100101"; B<="10100110"; wait for 50ns;
A<="01010101"; B<="01010101"; wait for 50ns;
A<="10011010"; B<="01100101"; wait for 50ns;
A<="10010001"; B<="10010001"; wait for 50ns;
A<="01101010"; B<="01100110"; wait for 50ns;
A<="11111111"; B<="11111111"; wait;
end process;
end Behavioral;
