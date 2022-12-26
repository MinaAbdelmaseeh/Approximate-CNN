----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2022 11:59:21 PM
-- Design Name: 
-- Module Name: ThreeBitADD - Behavioral
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

entity ThreeBitADD is
    Port ( X : in STD_LOGIC_VECTOR (2 downto 0);
           Y : in STD_LOGIC_VECTOR (2 downto 0);
           Sout : out STD_LOGIC_VECTOR (2 downto 0);
           C_OUT : out STD_LOGIC);
end ThreeBitADD;

architecture Behavioral of ThreeBitADD is
component FA is
  Port (A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end component;
component HA is
Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;           
signal Carrys: STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
begin
 u1: HA PORT MAP (X(0), Y(0),Sout(0),Carrys(0));
 u2: FA PORT MAP (X(1), Y(1), Carrys(0),Carrys(1),Sout(1));
 u3: FA PORT MAP (X(2), Y(2), Carrys(1),C_OUT,Sout(2));
end Behavioral;
