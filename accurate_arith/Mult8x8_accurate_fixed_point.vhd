library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_misc.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library accurate_arith;
use accurate_arith.accurate_package.all;
entity Mult8x8_accurate_fixed_point is
    Port ( A : in STD_LOGIC_VECTOR(7 downto 0);
           B : in STD_LOGIC_VECTOR(7 downto 0);
           output : out STD_LOGIC_VECTOR(7 downto 0));
end Mult8x8_accurate_fixed_point;

architecture Behavioral of Mult8x8_accurate_fixed_point is
signal o1,neg_o1: STD_LOGIC_VECTOR(15 downto 0);
signal abs_a,abs_b : STD_LOGIC_VECTOR(7 downto 0);
begin
abs_a<= A when A(7)='0' else
        not A;
abs_b<= B when B(7)='0' else
        not B;
Mult2: AccurateEightBit port map (
A=>abs_a,
B=>abs_b,
Output=>o1
);
neg_o1<= (not  o1) + 1;
output<= "01111111" when (A(7)= B(7)) and or_reduce(o1(15 downto 2*decimal+num))='1' else
         "10000000" when (A(7)= not B(7)) and or_reduce(o1(15 downto 2*decimal+num))='1' else
         o1(2*decimal+num-1 downto decimal) when (A(7)=B(7)) else
         neg_o1(2*decimal+num-1 downto decimal);
end Behavioral;
