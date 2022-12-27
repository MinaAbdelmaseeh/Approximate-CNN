----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2022 09:32:35 PM
-- Design Name: 
-- Module Name: mult5 - Behavioral
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

entity mult5 is
    Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
           B : in STD_LOGIC_VECTOR (4 downto 0);
           Output : out STD_LOGIC_VECTOR (9 downto 0));
end mult5;

architecture Behavioral of mult5 is
component mult4 is
 Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
      B : in STD_LOGIC_VECTOR (3 downto 0);
      C : out STD_LOGIC_VECTOR (7 downto 0));
end component; 
component HA is
 Port ( A : in STD_LOGIC;
          B : in STD_LOGIC;
          S : out STD_LOGIC;
          Cout : out STD_LOGIC);
end component; 
component FA is
Port(A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end component;         
signal C0: STD_LOGIC_VECTOR (7 downto 0):= (Others =>'0');
signal C1: STD_LOGIC_VECTOR(3 downto 0):= (Others =>'0');
signal C2: STD_LOGIC_VECTOR(3 downto 0):= (Others =>'0');
signal C3: STD_LOGIC:='0';
signal S11: STD_LOGIC:='0';
signal S12: STD_LOGIC:='0';
signal S13: STD_LOGIC:='0';
signal S14: STD_LOGIC:='0';
signal C11: STD_LOGIC:='0';
signal C12: STD_LOGIC:='0';
signal C13: STD_LOGIC:='0';
signal C14: STD_LOGIC:='0';
signal S21: STD_LOGIC:='0';
signal S22: STD_LOGIC:='0';
signal S23: STD_LOGIC:='0';
signal S24: STD_LOGIC:='0';
signal C21: STD_LOGIC:='0';
signal C22: STD_LOGIC:='0';
signal C23: STD_LOGIC:='0';
signal C24: STD_LOGIC:='0';
begin
u1: mult4 port map(A(3 downto 0),B(3 downto 0),C0);
u2: C1<= (A(4)&A(4)&A(4)&A(4))and B(3 downto 0);
u3: C2<= (B(4)&B(4)&B(4)&B(4))and A(3 downto 0);
u4: C3<= A(4) and B(4);
Output(3 downto 0)<=C0(3 downto 0);
u5: FA port map(C0(4),C1(0),C2(0),C11,S11);
u6: FA port map(C0(5),C1(1),C2(1),C12,S12);
u7: FA port map(C0(6),C1(2),C2(2),C13,S13);
u8: FA port map(C0(7),C1(3),C2(3),C14,S14);
u9: HA port map(S12,C11,S21,C21);
u10: FA port map(S13,C12,C21,C22,S22);
u11: FA port map(S14,C13,C22,C23,S23);
u12: FA port map(C3,C14,C23,C24,S24);
Output(4)<=S11;
Output(5)<=S21;
Output(6)<=S22;
Output(7)<=S23;
Output(8)<=S24;
Output(9)<=C24;
end Behavioral;
