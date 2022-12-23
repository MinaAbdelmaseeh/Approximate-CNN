library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Mult4x4 is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           output : out STD_LOGIC_VECTOR(7 downto 0));
end Mult4x4;

architecture Behavioral of Mult4x4 is
signal z: STD_LOGIC_VECTOR(7 downto 0);
begin
output <= STD_LOGIC_VECTOR(unsigned(A)* unsigned(B));

end Behavioral;
