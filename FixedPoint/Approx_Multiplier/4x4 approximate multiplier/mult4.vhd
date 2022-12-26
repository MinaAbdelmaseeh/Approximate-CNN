----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 09:02:33 PM
-- Design Name: 
-- Module Name: mult4 - Behavioral
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

entity mult4 is
 Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       C : out STD_LOGIC_VECTOR (7 downto 0));
end mult4;

architecture Behavioral of mult4 is
component ThreeBitADD is
Port(X : in STD_LOGIC_VECTOR (2 downto 0);
           Y : in STD_LOGIC_VECTOR (2 downto 0);
           Sout : out STD_LOGIC_VECTOR (2 downto 0);
           C_OUT : out STD_LOGIC);
end component;
component mult2 is
  Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
     B : in STD_LOGIC_VECTOR (1 downto 0);
     C : out STD_LOGIC_VECTOR (2 downto 0));
end component;
component FA is
  Port (A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end component;
component HA is
  Port (A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;
signal C0 : STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
signal C1: STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
signal C2: STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
signal C3: STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
signal S11: STD_LOGIC:= '0';
signal C11: STD_LOGIC:= '0';
signal S12: STD_LOGIC:= '0';
signal C12: STD_LOGIC:= '0';
signal S13: STD_LOGIC:= '0';
signal C13: STD_LOGIC:= '0';
signal S21: STD_LOGIC:= '0';
signal C21: STD_LOGIC:= '0';
signal S22: STD_LOGIC:= '0';
signal C22: STD_LOGIC:= '0';
signal S23: STD_LOGIC:= '0';
signal C23: STD_LOGIC:= '0';
signal x1: STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
signal x2: STD_LOGIC_VECTOR (2 downto 0):= (Others =>'0');
begin
u1: mult2 PORT MAP (A(1 downto 0), B(1 downto 0), C0);
u2: mult2 PORT MAP (A(1 downto 0), B(3 downto 2), C1);
u3: mult2 PORT MAP (A(3 downto 2), B(1 downto 0), C2);
u4: mult2 PORT MAP (A(3 downto 2), B(3 downto 2), C3);
u5: FA Port MAP (C0(2),C1(0),C2(0),C11,S11);
u6: HA Port MAP (C1(1),C2(1),S12,C12);
u7: FA Port MAP (C1(2),C2(2),C3(0),C13,S13);
u8: HA Port MAP (S12,C11,S21,C21);
u9: HA Port MAP (S13,C12,S22,C22);
u10: HA Port MAP (C3(1),C13,S23,C23);
x1(0)<=s22;
x1(1)<=s23;
x1(2)<=C3(2);
x2(0)<=C21;
x2(1)<=C22;
x2(2)<=C23;
u11: ThreeBitADD Port MAP(x1,x2,C(6 downto 4),C(7)); 
C(1 downto 0)<= C0(1 downto 0);
C(2)<=s11;
C(3)<=s21;
end Behavioral;
