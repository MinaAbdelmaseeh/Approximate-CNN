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
