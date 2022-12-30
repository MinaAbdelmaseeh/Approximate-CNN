----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2022 08:29:42 PM
-- Design Name: 
-- Module Name: adder_8_bit - Behavioral
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

entity adder_8_bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end adder_8_bit;

architecture Behavioral of adder_8_bit is
Component FA is
Port ( 
        A: in std_logic;
        B: in std_logic;
        Cin: in std_logic;
        Cout: out std_logic;
        S: out std_logic
);
end component;
 Component HA is
 Port( A: in std_logic;
      B: in std_logic;
      S: out std_logic;
      Cout: out std_logic);
end component;
signal Carry : std_logic_vector (7 downto 0):= (Others =>'0');
begin
h1: HA Port Map(A(0),B(0),output(0),Carry(0));
F1: FA port map(A(1), B(1), Carry(0),Carry(1),output(1));
F2: FA port map(A(2), B(2), Carry(1),Carry(2),output(2));
F3: FA port map(A(3), B(3), Carry(2),Carry(3),output(3));
F4: FA port map(A(4), B(4), Carry(3),Carry(4),output(4));
F5: FA port map(A(5), B(5), Carry(4),Carry(5),output(5));
F6: FA port map(A(6), B(6), Carry(5),Carry(6),output(6));
F7: FA port map(A(7), B(7), Carry(6),Carry(7),output(7));


end Behavioral;
