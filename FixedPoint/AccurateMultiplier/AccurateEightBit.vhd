----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 07:04:01 PM
-- Design Name: 
-- Module Name: AccurateEightBit - Behavioral
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

entity AccurateEightBit is
Port ( 
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        Output: out std_logic_vector(15 downto 0)
);
end AccurateEightBit;

architecture Behavioral of AccurateEightBit is
component AccurateFourBit
Port(
    A: in std_logic_vector(3 downto 0);
    B: in std_logic_vector(3 downto 0);
    Output: out std_logic_vector(7 downto 0)
);
end component;
component HalfAdder
Port(
    A: in std_logic;
    B: in std_logic;
    Sum: out std_logic;
    Cout: out std_logic
);
end component;
component FullAdder
Port(
    A: in std_logic;
    B: in std_logic;
    Cin: in std_logic;
    Sum: out std_logic;
    Cout: out std_logic
);
end component;
--signals
signal ProductOne: std_logic_vector(7 downto 0);
signal ProductTwo: std_logic_vector(7 downto 0);
signal ProductThree: std_logic_vector(7 downto 0);
signal ProductFour: std_logic_vector(7 downto 0);
signal SumStageOne: std_logic_vector (7 downto 0);
signal CarryStageOne: std_logic_vector(7 downto 0);
signal SumStageTwo: std_logic_vector (7 downto 0);
signal CarryStageTwo: std_logic_vector(7 downto 0); 
signal RippleCarry: std_logic_vector(9 downto 0);
begin 
AccurateFourBit1: AccurateFourBit Port Map(A(3 downto 0),B(3 downto 0),ProductOne);
AccurateFourBit2: AccurateFourBit Port Map(A(7 downto 4),B(3 downto 0),ProductTwo);
AccurateFourBit3: AccurateFourBit Port Map(A(3 downto 0),B(7 downto 4),ProductThree);
AccurateFourBit4: AccurateFourBit Port Map(A(7 downto 4),B(7 downto 4),ProductFour);
--Using Wallace Tree
--Stage One
FullAdder1: FullAdder Port Map (ProductOne(4),ProductTwo(0),ProductThree(0),SumStageOne(0),CarryStageOne(0));
FullAdder2: FullAdder Port Map (ProductOne(5),ProductTwo(1),ProductThree(1),SumStageOne(1),CarryStageOne(1));
FullAdder3: FullAdder Port Map (ProductOne(6),ProductTwo(2),ProductThree(2),SumStageOne(2),CarryStageOne(2));
FullAdder4: FullAdder Port Map (ProductOne(7),ProductTwo(3),ProductThree(3),SumStageOne(3),CarryStageOne(3));
HalfAdder1: HalfAdder Port Map (ProductTwo(4),ProductThree(4),SumStageOne(4),CarryStageOne(4));
HalfAdder2: HalfAdder Port Map (ProductTwo(5),ProductThree(5),SumStageOne(5),CarryStageOne(5));
HalfAdder3: HalfAdder Port Map (ProductTwo(6),ProductThree(6),SumStageOne(6),CarryStageOne(6));
HalfAdder4: HalfAdder Port Map (ProductTwo(7),ProductThree(7),SumStageOne(7),CarryStageOne(7));
--Stage Two
HalfAdder5: HalfAdder Port Map (SumStageOne(1),CarryStageOne(0),SumStageTwo(0),CarryStageTwo(0));
HalfAdder6: HalfAdder Port Map (SumStageOne(2),CarryStageOne(1),SumStageTwo(1),CarryStageTwo(1));
HalfAdder7: HalfAdder Port Map (SumStageOne(3),CarryStageOne(2),SumStageTwo(2),CarryStageTwo(2));
FullAdder5: FullAdder Port Map (SumStageOne(4),CarryStageOne(3),ProductFour(0),SumStageTwo(3),CarryStageTwo(3));
FullAdder6: FullAdder Port Map (SumStageOne(5),CarryStageOne(4),ProductFour(1),SumStageTwo(4),CarryStageTwo(4));
FullAdder7: FullAdder Port Map (SumStageOne(6),CarryStageOne(5),ProductFour(2),SumStageTwo(5),CarryStageTwo(5));
FullAdder8: FullAdder Port Map (SumStageOne(7),CarryStageOne(6),ProductFour(3),SumStageTwo(6),CarryStageTwo(6));
HalfAdder8: HalfAdder Port Map (CarryStageOne(7),ProductFour(4),SumStageTwo(7),CarryStageTwo(7));
--Last Stage
Output(0) <= ProductOne(0);
Output(1) <= ProductOne(1);
Output(2) <= ProductOne(2);
Output(3) <= ProductOne(3);
Output(4) <= SumStageOne(0);
Output(5) <= SumStageTwo(0);
--Using Carry Ripple Adder
FullAdder9: FullAdder Port Map (SumStageTwo(1),CarryStageTwo(0),'0',Output(6),RippleCarry(0));
FullAdder10: FullAdder Port Map (SumStageTwo(2),CarryStageTwo(1),RippleCarry(0),Output(7),RippleCarry(1));
FullAdder11: FullAdder Port Map (SumStageTwo(3),CarryStageTwo(2),RippleCarry(1),Output(8),RippleCarry(2));
FullAdder12: FullAdder Port Map (SumStageTwo(4),CarryStageTwo(3),RippleCarry(2),Output(9),RippleCarry(3));
FullAdder13: FullAdder Port Map (SumStageTwo(5),CarryStageTwo(4),RippleCarry(3),Output(10),RippleCarry(4));
FullAdder14: FullAdder Port Map (SumStageTwo(6),CarryStageTwo(5),RippleCarry(4),Output(11),RippleCarry(5));
FullAdder15: FullAdder Port Map (SumStageTwo(7),CarryStageTwo(6),RippleCarry(5),Output(12),RippleCarry(6));
FullAdder16: FullAdder Port Map (ProductFour(5),CarryStageTwo(7),RippleCarry(6),Output(13),RippleCarry(7));
FullAdder17: FullAdder Port Map (ProductFour(6),RippleCarry(7),'0',Output(14),RippleCarry(8));
FullAdder18: FullAdder Port Map (ProductFour(7),RippleCarry(8),'0',Output(15),RippleCarry(9));
end Behavioral;
