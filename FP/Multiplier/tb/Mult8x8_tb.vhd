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
    wait;            
end process;
end Behavioral;
