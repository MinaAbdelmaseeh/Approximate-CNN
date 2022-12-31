library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FL_8Bit_Adder is
    Port ( A, B : in STD_LOGIC_VECTOR(7 downto 0);
           F : out STD_LOGIC_VECTOR(7 downto 0));
    end FL_8Bit_Adder;

architecture Behavioral of FL_8Bit_Adder is

signal A_mantissa, B_mantissa, A_mantissa_shifted, B_mantissa_shifted, F_mantissa : std_logic_vector(5 downto 0):="000000";
signal F_normalized : std_logic_vector(7 downto 0):="00000000";
signal shift : std_logic_vector(4 downto 0):="00000"; 
signal A_exponent, B_exponent, F_exponent, maxNormalization, maxExponent, One, Two, Three, Four : std_logic_vector(2 downto 0):="000";
signal A_state, B_state : std_logic_vector(1 downto 0):="00";
signal A_sign, B_sign, F_sign, shiftA_mantissa, shiftB_mantissa : std_logic:='0';

begin
-- decomposition the two given input numbers into (sign(1 bit), mantissa(4 bits), exponent(3 bits)) with adding the hidden bit to the mantissa. 
-- A_mantissa, B_mantissa is 6 bits each(1 bit for the addition's carry(vivado internal library's adders has a one bit overflow so in order to add the two numbers correctly '0' bit must be added to the left), 1 bit for the hidden bit, 4 bits for the number's mantissa).
A_sign <= A(7);
A_exponent <= A(2 downto 0);
A_mantissa <= "00" & A(6 downto 3) when A_exponent = "000" else
              "01" & A(6 downto 3);  
B_sign <= B(7);
B_exponent <= B(2 downto 0);
B_mantissa <= "00" & B(6 downto 3) when B_exponent = "000" else
              "01" & B(6 downto 3);
-- determining the state of the two numbers.
A_state <= "00" when (A_exponent = "000" and A_mantissa(3 downto 0) = "0000") else -- 00 for a Zero.
           "01" when (A_exponent = "111" and A_mantissa(3 downto 0) = "0000") else -- 01 for an Infinity.
           "10" when (A_exponent = "111" and A_mantissa(3 downto 0) /= "0000") else -- 10 for an NaN.
           "11"; -- 11 for an Number.
B_state <= "00" when (B_exponent = "000" and B_mantissa(3 downto 0) = "0000") else -- 00 for a Zero.
           "01" when (B_exponent = "111" and B_mantissa(3 downto 0) = "0000") else -- 01 for an Infinity.
           "10" when (B_exponent = "111" and B_mantissa(3 downto 0) /= "0000") else -- 10 for an NaN.
           "11"; -- 11 for an Number.    
-- calculating the difference in the exponent between the two numbers to determine whether there is a shift in one of the numbers' mantissa.
-- shift is 5 bits(2 bits for which mantissa is shifted, 3 bits for the difference). 
shift <= "01" & STD_LOGIC_VECTOR(unsigned(A_exponent) - unsigned(B_exponent)) when (A_exponent >= B_exponent) else -- 01 to shift B_mantissa.
         "10" & STD_LOGIC_VECTOR(unsigned(B_exponent) - unsigned(A_exponent)) when (A_exponent < B_exponent); -- 10 to shift A_mantissa.
-- shifting the mantissa.                          
B_mantissa_shifted(4 downto 0) <= ('0' & B_mantissa(4 downto 1)) when (shift = "01001") else
                                  ("00" & B_mantissa(4 downto 2)) when (shift = "01010") else
                                  ("000" & B_mantissa(4 downto 3)) when (shift = "01011") else
                                  ("0000" & B_mantissa(4)) when (shift = "01100") else
                                  ("00000") when (shift = "01101" or shift = "01110") else
                                  B_mantissa(4 downto 0);
A_mantissa_shifted(4 downto 0) <= ('0' & A_mantissa(4 downto 1)) when (shift = "10001") else
                                  ("00" & A_mantissa(4 downto 2)) when (shift = "10010") else
                                  ("000" & A_mantissa(4 downto 3)) when (shift = "10011") else
                                  ("0000" & A_mantissa(4)) when (shift = "10100") else
                                  ("00000") when (shift = "10101" or shift = "10110") else
                                  A_mantissa(4 downto 0);
-- calculating F_sign.
F_sign <= '0' when (A_sign = '0' and B_sign = '0') or (A_sign = '0' and B_sign = '1' and A_mantissa_shifted(4 downto 0) >= B_mantissa_shifted(4 downto 0)) or (A_sign = '1' and B_sign = '0' and A_mantissa_shifted(4 downto 0) < B_mantissa_shifted(4 downto 0)) else
          '1' when (A_sign = '1' and B_sign = '1') or (A_sign = '1' and B_sign = '0' and A_mantissa_shifted(4 downto 0) >= B_mantissa_shifted(4 downto 0)) or (A_sign = '0' and B_sign = '1' and A_mantissa_shifted(4 downto 0) < B_mantissa_shifted(4 downto 0));
-- calculating F_mantissa(performing the addition).
-- F_mantissa is 6 bits(1 bit for the addition's carry, 5 bits for the number's mantissa(1(hidden) + 4)).
F_mantissa <= STD_LOGIC_VECTOR(unsigned(A_mantissa_shifted) + unsigned(B_mantissa_shifted)) when (A_sign = '0' and B_sign = '0') or (A_sign = '1' and B_sign = '1') else
              STD_LOGIC_VECTOR(unsigned(A_mantissa_shifted) - unsigned(B_mantissa_shifted)) when ((A_sign = '0' and B_sign = '1') or (A_sign = '1' and B_sign = '0')) and (A_mantissa_shifted(4 downto 0) >= B_mantissa_shifted(4 downto 0)) else
              STD_LOGIC_VECTOR(unsigned(B_mantissa_shifted) - unsigned(A_mantissa_shifted)) when ((A_sign = '0' and B_sign = '1') or (A_sign = '1' and B_sign = '0')) and (A_mantissa_shifted(4 downto 0) < B_mantissa_shifted(4 downto 0));
-- calculating F_exponent.
F_exponent <= A_exponent when (A_exponent >= B_exponent) else
              B_exponent;                        
-- constant which is used to perform the normalization.
One <= "001";
Two <= "010";
Three <= "011";
Four <= "100";
maxExponent <= "110"; -- the maximum value the exponent can take.
maxNormalization <= STD_LOGIC_VECTOR(unsigned(maxExponent) - unsigned(F_exponent)); -- the maximum value the normalization can be done.
-- normalizing the output number.
F_normalized <= F_sign & F_mantissa(4 downto 1) & F_exponent when (F_mantissa(5) = '1' and maxNormalization >= One) else -- this case if there is a carry bit.
                F_sign & "0000111" when (F_mantissa(5) = '1' and maxNormalization < One) else -- this case if there ia an overflow(the result floating number is bigger than to be represented by 3 bits for the exponent).
                F_sign & F_mantissa(3 downto 0) & F_exponent when (F_mantissa(4) = '1') else
                F_sign & F_mantissa(2 downto 0) & '0' & (STD_LOGIC_VECTOR(unsigned(F_exponent) + unsigned(One))) when ((F_mantissa(4 downto 3) = "01") and (maxNormalization >= One)) or ((F_mantissa(4 downto 2) = "001") and (maxNormalization >= Two)) or ((F_mantissa(4 downto 1) = "0001") and (maxNormalization < Three)) or ((F_mantissa(4 downto 0) = "00001") and (maxNormalization < Four)) else
                F_sign & F_mantissa(1 downto 0) & "00" & (STD_LOGIC_VECTOR(unsigned(F_exponent) + unsigned(Two))) when ((F_mantissa(4 downto 2) = "001") and (maxNormalization >= Two)) or ((F_mantissa(4 downto 1) = "0001") and (maxNormalization < Three)) or ((F_mantissa(4 downto 0) = "00001") and (maxNormalization < Four)) else
                F_sign & F_mantissa(0) & "000" & (STD_LOGIC_VECTOR(unsigned(F_exponent) + unsigned(Three))) when ((F_mantissa(4 downto 1) = "0001") and (maxNormalization >= Three)) or ((F_mantissa(4 downto 0) = "00001") and (maxNormalization < Four)) else
                F_sign & "0000" & (STD_LOGIC_VECTOR(unsigned(F_exponent) + unsigned(Four))) when (F_mantissa(4 downto 0) = "00001") and (maxNormalization >= Four);
-- handling all the cases of the addition including the special cases.         
F <= "11111111" when (A_state = "10" or B_state = "10" or (A_state = "01" and B_state = "01" and A_sign /= B_sign)) else
     "00000000" when (A_state = "00" and B_state = "00") or (A(6 downto 0) = B(6 downto 0) and A_sign /= B_sign) else
     A when (A_state = "11" and B_state = "00") or (A_state = "01" and (B_state = "00" or B_state = "11")) or (A_state = "01" and B_state = "01" and A_sign = B_sign) else
     B when (A_state = "00" and B_state = "11") or (B_state = "01" and (A_state = "00" or A_state = "11")) else
     F_normalized when (A_state = "11" and B_state = "11");
end Behavioral;
