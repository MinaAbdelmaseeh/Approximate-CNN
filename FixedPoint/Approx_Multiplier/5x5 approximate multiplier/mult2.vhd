----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 10:44:48 PM
-- Design Name: 
-- Module Name: mult2 - Behavioral
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

entity mult2 is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
       B : in STD_LOGIC_VECTOR (1 downto 0);
       C : out STD_LOGIC_VECTOR (2 downto 0));
end mult2;

architecture Behavioral of mult2 is

begin
C(0)<=A(0) and B(0);
C(1)<=(B(1) and A(0)) or (B(0) and A(1));
C(2) <=(B(1) and A(1));
end Behavioral;
