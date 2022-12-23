library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

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
