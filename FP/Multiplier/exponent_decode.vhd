----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 02:09:06 AM
-- Design Name: 
-- Module Name: exponent_decode - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity exponent_decode is
    generic (NBITS   : natural :=8;
             MANTISSA: natural :=4;
             EXPONENT: natural :=3);
    Port ( A : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
           exp_decode : out STD_LOGIC_VECTOR(EXPONENT-1 downto 0));
end exponent_decode;

architecture Behavioral of exponent_decode is

begin
with A select
            exp_decode<= "110" when "000", -- exponent = -2
                    "110" when "001", -- exponent = -2
                    "111" when "010", -- exponent = -1
                    "000" when "011", -- exponent = 0
                    "001" when "100", -- exponent = 1
                    "010" when "101", -- exponent = 2
                    "011" when others; -- exponent = 3 when "110"

end Behavioral;
