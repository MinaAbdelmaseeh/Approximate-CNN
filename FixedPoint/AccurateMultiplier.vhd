----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 09:34:18 PM
-- Design Name: 
-- Module Name: AccurateMultiplier - Behavioral
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

entity AccurateMultiplier is
Port ( 
    A: in std_logic_vector (1 downto 0);
    B: in std_logic_vector (1 downto 0);
    Output: out std_logic_vector (3 downto 0)
);
end AccurateMultiplier;

architecture Behavioral of AccurateMultiplier is
-- signals
signal AndOne: std_logic;
signal AndTwo: std_logic;
signal AndThree: std_logic;
signal AndInter: std_logic;
begin
AndOne <= A(0) and B(1);
AndTwo <= A(1) and B(0);
AndThree <= A(1) and B(1);
AndInter <= AndOne and AndTwo;
-- Outputs
Output(0) <= A(0) and B(0); --Least Significant Bit
Output(1) <= AndOne xor AndTwo;
Output(2) <= AndInter xor AndThree;
Output(3) <= AndInter and AndThree; --Most Significant Bit

end Behavioral;