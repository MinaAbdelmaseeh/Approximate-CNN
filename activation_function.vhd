----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 08:36:40 AM
-- Design Name: 
-- Module Name: activation_function - Behavioral
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

-- We are using the following floating point representation 
-- sign - mantissa - power
-- 1b   -    5b    - 2b     = 8bit
-- zero representation 0 00000 00


-- the activation function used here is ReLu
-- output = f(input) = max(0,input)
entity activation_function is
    generic (NBITS: natural;
             MANTISSA: natural;
             EXPONENT: natural);
    Port ( input : in STD_LOGIC_VECTOR (NBITS-1 downto 0);
           output : out STD_LOGIC_VECTOR(NBITS-1 downto 0));
end activation_function;

architecture Behavioral of activation_function is

begin
with input(NBITS-1) select --- checking the sign of the number
    output<= "00000000" when '1', -- negative numbers return 0
              input when others; -- positive numbers are unchanged

end Behavioral;
