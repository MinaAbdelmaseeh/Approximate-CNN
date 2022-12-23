library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity normalizer is
    generic (NBITS   : natural :=8;
         MANTISSA: natural :=4;
         EXPONENT: natural :=3);
    Port ( mult_out : in STD_LOGIC_VECTOR((MANTISSA+ MANTISSA+1) downto 0) ;
           exp_a : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0) ;
           exp_b : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0) ;
           mantissa_out : out STD_LOGIC_VECTOR(MANTISSA-1 downto 0) ;
           exp_out : out STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
           denorm,Inf,Zero: out STD_LOGIC);
end normalizer;

architecture Behavioral of normalizer is
signal exp,exp_shift: STD_LOGIC_VECTOR(EXPONENT+1 downto 0);
signal mantissa_shift,mantissa_1: STD_LOGIC_VECTOR(MANTISSA downto 0);
begin
exp<= STD_LOGIC_VECTOR( unsigned(exp_a(EXPONENT-1) & exp_a(EXPONENT-1) & exp_a) 
+ unsigned( exp_b(EXPONENT-1) & exp_b(EXPONENT-1) & exp_b)
+ unsigned(exp_shift)); -- adding exponents with sign extend

Inf<= '1' when signed(exp)>"00011" else
      '0';
Zero<='1' when signed(exp)<"11010" else
      '0';
denorm<='0' when signed(exp)>="11110" else
        '1';
exp_out<=exp(EXPONENT-1 downto 0) when signed(exp)>="11110" else
         "110";
mantissa_out<= mantissa_shift(MANTISSA-1 downto 0) when signed(exp)>= "11110" else
               mantissa_shift(MANTISSA downto 1) when exp="11101" else
               '0' &mantissa_shift(MANTISSA downto 2) when exp="11100" else
               "00" &mantissa_shift(MANTISSA downto 3) when exp="11011" else
               "000" &mantissa_shift(MANTISSA downto 4);

mantissa_shift <= mult_out(9 downto 5) when mult_out(9)='1' else
                  mult_out(8 downto 4) when mult_out(8)='1' else
                  mult_out(7 downto 3) when mult_out(7)='1' else
                  mult_out(6 downto 2) when mult_out(6)='1' else
                  mult_out(5 downto 1) when mult_out(5)='1' else
                  mult_out(4 downto 0) when mult_out(4)='1' else
                  mult_out(3 downto 0)&"0"    when mult_out(3)='1' else
                  mult_out(2 downto 0)&"00"   when mult_out(2)='1' else
                  mult_out(1 downto 0)&"000"  when mult_out(1)='1' else
                  mult_out(0 downto 0) & "0000";
exp_shift <= "00001" when mult_out(9)='1' else
             "00000" when mult_out(8)='1' else
             "11111" when mult_out(7)='1' else
             "11110" when mult_out(6)='1' else
             "11101" when mult_out(5)='1' else
             "11100" when mult_out(4)='1' else
             "11011" when mult_out(3)='1' else
             "11010" when mult_out(2)='1' else
             "11001" when mult_out(1)='1' else
             "11000";
            

end Behavioral;
