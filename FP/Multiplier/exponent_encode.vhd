library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exponent_encode is
    generic (NBITS   : natural :=8;
             MANTISSA: natural :=4;
             EXPONENT: natural :=3);
    Port ( A : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
           denorm,Inf,NaN,Zero : in STD_LOGIC;
           exp_encode : out STD_LOGIC_VECTOR (EXPONENT-1 downto 0));
end exponent_encode;

architecture Behavioral of exponent_encode is

begin
exp_encode<= "000" when Zero='1' else
             "111" when Inf='1' or NaN='1' else
             "000" when A="110" and denorm='1' else
             "001" when A="110" and denorm='0' else
             "010" when A="111" else
             "011" when A="000" else
             "100" when A="001" else
             "101" when A="010" else
             "110" when A="011" else
             "XXX"; --- not a  case

end Behavioral;
