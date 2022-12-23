library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Mult5x5 is
    Port ( A : in STD_LOGIC_VECTOR(4 downto 0);
           B : in STD_LOGIC_VECTOR(4 downto 0);
           output : out STD_LOGIC_VECTOR(9 downto 0));
end Mult5x5;

architecture Behavioral of Mult5x5 is
signal z: STD_LOGIC_VECTOR(9 downto 0);
begin
output <= STD_LOGIC_VECTOR(unsigned(A)* unsigned(B));

end Behavioral;
