----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 09:07:01 AM
-- Design Name: 
-- Module Name: activation_function_tb - Behavioral
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

entity activation_function_tb is
--  Port ( );
end activation_function_tb;

architecture Behavioral of activation_function_tb is
component activation_function
    generic (NBITS: natural    := 8;    
             MANTISSA: natural := 4; 
             EXPONENT: natural := 3);
     Port ( input : in STD_LOGIC_VECTOR (NBITS-1 downto 0);
          output : out STD_LOGIC_VECTOR(NBITS-1 downto 0));
end component activation_function;

signal input,output: STD_LOGIC_VECTOR(7 downto 0);
begin
activation_fun: activation_function
port map(
input=> input,
output=>output
);
process begin
input <= "11010111"; wait for 20 ns;
input <= "01010111"; wait for 20 ns;
input <= "00000000"; wait for 20 ns;
wait;
end process;

end Behavioral;
