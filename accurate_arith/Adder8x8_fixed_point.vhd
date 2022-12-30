----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/27/2022 08:43:25 PM
-- Design Name: 
-- Module Name: Adder8x8_fixed_point - Behavioral
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder8x8_fixed_point is
    Port ( A : in STD_LOGIC_VECTOR(7 downto 0);
       B : in STD_LOGIC_VECTOR(7 downto 0);
       output : out STD_LOGIC_VECTOR(7 downto 0));
end Adder8x8_fixed_point;

architecture Behavioral of Adder8x8_fixed_point is
signal o1 : STD_LOGIC_VECTOR(7 downto 0);
begin
o1<= (A) + (B);
output<= "01111111" when A(7)='0' and  B(7)='0' and o1(7)='1'  else -- overflow case
         "10000000" when A(7)='1' and  B(7)='1' and o1(7)='0' else
          o1(7 downto 0);

end Behavioral;