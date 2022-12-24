----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 08:17:37 PM
-- Design Name: 
-- Module Name: Mult8x8_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mult8x8_tb is
--  Port ( );
end Mult8x8_tb;

architecture Behavioral of Mult8x8_tb is
component Mult8x8
    generic (NBITS   : natural :=8;
         MANTISSA: natural :=4;
         EXPONENT: natural :=3);
    Port ( A : in STD_LOGIC_VECTOR(NBITS-1 downto 0);
       B : in STD_LOGIC_VECTOR(NBITS-1 downto 0);
       output : out STD_LOGIC_VECTOR(NBITS-1 downto 0));
end component Mult8x8;
signal A,B: STD_LOGIC_VECTOR(7 downto 0);
signal output: STD_LOGIC_VECTOR(7 downto 0);
begin
hi: Mult8x8 port map (
A=> A,
B=> B,
output => output
);

process begin
    A<="00001000"; B<= "00001000";wait for 10ns; -- 0.0001 * 0.0001 = 0
    A<="00000110"; B<= "00000011";wait for 10ns; -- 1.00e2 * 1.00e0 = 1.00e2
    A<="00010110"; B<= "00001000";wait for 10ns; -- 1.0010e3 * 0.0001e-2 = 0.0001e1 = 0.1001e-2
    A<="00000111"; B<= "00000111";wait for 10ns; -- inf* inf = inf;
    A<="00000000"; B<= "00000000";wait for 10ns; -- 0 * 0 = 0
    A<="00000000"; B<= "00000111";wait for 10ns; -- 0*inf= NaN
    A<="00000110"; B<= "00000110";wait for 10ns; -- 1.00e3 * 1.00e3 = Inf
    A<="00000101"; B<= "00000101";wait for 10ns;
    A<="00001111"; B<= "01000000";wait for 10ns; -- NaN * 0.1e-2 = NaN
    A<="01010100"; B<= "10010101";wait for 10ns; -- 1.1010e1*1.0010e2 = 1.1101e3
    
    A<="11010011"; B<= "00000110";wait for 10ns; -- -1.101 * 1e3 = -1101.0
    A<="11001011"; B<= "10011100";wait for 10ns; -- -1.1001 * -1.0011e1 = 11.1011011
    A<="01011011"; B<= "10111111";wait for 10ns; -- 1.1011 * -NaN = -NaN
    A<="11111010"; B<= "10011001";wait for 10ns; -- -1.11111 * -1.0011e-2 = 0.01001001101
    A<="01000011"; B<= "10110001";wait for 10ns; -- 1.1 * -1.0110e-2 = 0.100001
    A<="11100111"; B<= "00100111";wait for 10ns; -- -NaN * NaN = -NaN
    A<="11000111"; B<= "11111101";wait for 10ns; -- -NaN * -1.1111e2 = NaN
    A<="01010011"; B<= "10001000";wait for 10ns; -- 1.1011 * -0.0001e-2 = -1.1011e-6
    A<="01100010"; B<= "11100001";wait for 10ns; -- 0.111 * -0.0111 = -1.10001e-2
    A<="00111100"; B<= "01100011";wait for 10ns; -- 1.0111e1 * 1.11 = 1.0100001e2
    A<="11100111"; B<= "10111111";wait for 10ns; -- -NaN * -NaN = NaN
    A<="11110010"; B<= "10011000";wait for 10ns; -- -0.1111 * -0.0011e-2 = 1.01101e-5
    A<="10010001"; B<= "01010010";wait for 10ns; -- -1.001e-2 * 0.1101 = -1.110101e-3
    A<="11101001"; B<= "00111110";wait for 10ns; -- -1.1101e-2 * 1.0111e3 = -1.010011011e2
    A<="01011100"; B<= "01001100";wait for 10ns; -- 1.1011e1 * 1.1001e1 = 1.010100011e3
    A<="00010101"; B<= "00000110";wait for 10ns; -- 1.0010e2 * 1e3 = 1.001e5
    A<="00101110"; B<= "01001011";wait for 10ns; -- 1.0101e3 * 1.1001 = 1.000001101e4
    A<="00011011"; B<= "01000001";wait for 10ns; -- 1.0011 * 0.011 = 1.11001e-2
    A<="11101000"; B<= "01001001";wait for 10ns; -- -0.1101e-2 * 1.1001e-2 = -1.01000101e-4
    A<="11110010"; B<= "01100101";wait for 10ns; -- -0.1111 * 1.11e2 = -1.101001e2
    A<="11101001"; B<= "01110101";wait for 10ns; -- -1.1101e-2 * 1.111e2 = -1.10110011e1
    A<="01001010"; B<= "10110011";wait for 10ns; -- 1.1001e-1 * -1.011 = -1.00010011
    A<="00000101"; B<= "01000011";wait for 10ns; -- 1e2 * 1.1 = 1.1e2
    A<="00010101"; B<= "01010101";wait for 10ns; -- 1.001e2 * 1.1010e2 = 1.110101e4
    A<="00001011"; B<= "10001000";wait for 10ns; -- 1.0001 * -0.0001e-2 = -1.0001e-6
    A<="01111110"; B<= "00111100";wait for 10ns; -- 1.1111e3 * 1.0111e1 = 1.011001001e5
    A<="10100101"; B<= "01011111";wait for 10ns; -- -1.01e2 * NaN = -NaN
    A<="01000011"; B<= "00000100";wait for 10ns; -- 1.1 * 1e1 = 1.1e1
    A<="01111110"; B<= "00011010";wait for 10ns; -- 1.1111e3 * 1.0011e-1 = 1.001001101e3
    A<="10000000"; B<= "01110000";wait for 10ns; -- -0.0 * 0.111e-2 = 0
    A<="10011100"; B<= "01110110";wait for 10ns; -- -1.0011e1 * 1.111e3 = -1.00011101e5
    A<="10111101"; B<= "11110101";wait for 10ns; -- -1.0111e2 * -1.111e2 = 1.01011001e5
    A<="10100000"; B<= "01111100";wait for 10ns; -- -0.0001 * 1.1111e1 = -1.1111e-3
    A<="01011101"; B<= "01001001";wait for 10ns; -- 1.1011e2 * 1.1001e-2 = 1.010100011e1
    A<="01110110"; B<= "00010100";wait for 10ns; -- 1.111e3 * 1.001e1 = 1.0000111e5
    A<="10001010"; B<= "00110000";wait for 10ns; -- -1.0001e-1 * 0.0110e-2 = -1.10011e-5
    A<="11011100"; B<= "11001100";wait for 10ns; -- -1.1011e1 * -1.1001e1 = 1.010100011e3
    A<="01000000"; B<= "10100100";wait for 10ns; -- 0.1e-2 * -1.01e1 = -1.01e-2  
    A<="11111110"; B<= "10011110";wait for 10ns; -- -1.1111e3 * -1.0011e3 = 1.001001101e7
    A<="10101011"; B<= "00000111";wait for 10ns; -- -1.0101 * inf = -inf
    A<="00000011"; B<= "11001100";wait for 10ns; -- 1.0 * -1.1001e1 = -1.1001e1
    A<="00100010"; B<= "00001110";wait for 10ns; -- 0.101 * 1.0001e3 = 1.010101e2
    A<="00100010"; B<= "10111000";wait for 10ns; -- 0.101 * -0.0111e-2 = -1.00011e-4
    A<="10001001"; B<= "11101110";wait for 10ns; -- -1.0001e-2 * -1.1101e3 = 1.11101101e1
    A<="00010101"; B<= "11001100";wait for 10ns; -- 1.001e2 * -1.1001e1 = -1.1100001e3
    A<="11111011"; B<= "11101000";wait for 10ns; -- -1.1111 * -0.1101e-2 = 1.10010011e-2
    A<="11101010"; B<= "01001011";wait for 10ns; -- -1.1101e-1 * 1.1001 = -1.011010101
    A<="10000011"; B<= "11111101";wait for 10ns; -- -1.0 * -1.1111e2 = 1.1111e2
    A<="01111001"; B<= "00000100";wait for 10ns; -- 1.1111e-2 * 1e1 = 1.1111e-1
    A<="10100010"; B<= "00001000";wait for 10ns; -- -0.101 * 0.0001e-2 = -1.01e-7
    A<="01101110"; B<= "00111000";wait for 10ns; -- 1.1101e3 * 0.0111e-2 = 1.1001011
    A<="01100001"; B<= "10110011";wait for 10ns; -- 0.0111 * -1.011 = -1.001101e-1
    A<="10110101"; B<= "01010011";wait for 10ns; -- -1.0110e2 * 1.101 = -1.0001111e3
    A<="10101100"; B<= "10101101";wait for 10ns; -- -1.0101e1 * -1.0101e2 = 1.10111001e3
    A<="11101101"; B<= "10101101";wait for 10ns; -- -1.1101e2 * -1.0101e2 = 1.001100001e5
    A<="01101010"; B<= "00101001";wait for 10ns; -- 0.11101 * 1.0101e-2 = 1.001100001e-2
    
    wait;            
end process;
end Behavioral;