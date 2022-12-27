----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2022 09:39:39 PM
-- Design Name: 
-- Module Name: AccurateFiveBit - Behavioral
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

entity AccurateFiveBit is
Port ( 
        A: in std_logic_vector(4 downto 0);
        B: in std_logic_vector(4 downto 0);
        Output: out std_logic_vector(9 downto 0)
);
end AccurateFiveBit;

architecture Behavioral of AccurateFiveBit is
component AccurateMultiplier
Port(
    A: in std_logic_vector(1 downto 0);
    B: in std_logic_vector(1 downto 0);
    Output: out std_logic_vector(3 downto 0)
);
end component;
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
signal Ahighest: std_logic_vector(3 downto 0):="0000";
signal Bhighest: std_logic_vector(3 downto 0):="0000";
signal ProductOne: std_logic_vector(7 downto 0);
signal ProductTwo: std_logic_vector(7 downto 0);
signal ProductThree: std_logic_vector(7 downto 0);
signal ProductFour: std_logic_vector(7 downto 0):="00000000";
signal SumStageOne: std_logic_vector (3 downto 0);
signal CarryStageOne: std_logic_vector(3 downto 0);
signal SumStageTwo: std_logic_vector (3 downto 0);
signal CarryStageTwo: std_logic_vector(3 downto 0); 
signal RippleCarry: std_logic_vector(3 downto 0);
begin
Ahighest(0) <= A(4);
Bhighest(0) <= B(4); 
AccurateFourBit1: AccurateFourBit Port Map(A(3 downto 0),B(3 downto 0),ProductOne);
AccurateFourBit2: AccurateFourBit Port Map(Ahighest,B(3 downto 0),ProductTwo);
AccurateFourBit3: AccurateFourBit Port Map(A(3 downto 0),Bhighest,ProductThree);
AccurateMultiplier1: AccurateMultiplier Port Map(Ahighest(1 downto 0),Bhighest(1 downto 0),ProductFour(3 downto 0));
--Using Wallace Tree
--Stage One
FullAdder1: FullAdder Port Map (ProductOne(4),ProductTwo(0),ProductThree(0),SumStageOne(0),CarryStageOne(0));
FullAdder2: FullAdder Port Map (ProductOne(5),ProductTwo(1),ProductThree(1),SumStageOne(1),CarryStageOne(1));
FullAdder3: FullAdder Port Map (ProductOne(6),ProductTwo(2),ProductThree(2),SumStageOne(2),CarryStageOne(2));
FullAdder4: FullAdder Port Map (ProductOne(7),ProductTwo(3),ProductThree(3),SumStageOne(3),CarryStageOne(3));
--Stage Two
HalfAdder1: HalfAdder Port Map (SumStageOne(1),CarryStageOne(0),SumStageTwo(0),CarryStageTwo(0));
HalfAdder2: HalfAdder Port Map (SumStageOne(2),CarryStageOne(1),SumStageTwo(1),CarryStageTwo(1));
HalfAdder3: HalfAdder Port Map (SumStageOne(3),CarryStageOne(2),SumStageTwo(2),CarryStageTwo(2));
HalfAdder4: HalfAdder Port Map (CarryStageOne(3),ProductFour(0),SumStageTwo(3),CarryStageTwo(3));
--Last Stage
Output(0) <= ProductOne(0);
Output(1) <= ProductOne(1);
Output(2) <= ProductOne(2);
Output(3) <= ProductOne(3);
Output(4) <= SumStageOne(0);
Output(5) <= SumStageTwo(0);
--Using Carry Ripple Adder
FullAdder5: FullAdder Port Map (SumStageTwo(1),CarryStageTwo(0),'0',Output(6),RippleCarry(0));
FullAdder6: FullAdder Port Map (SumStageTwo(2),CarryStageTwo(1),RippleCarry(0),Output(7),RippleCarry(1));
FullAdder7: FullAdder Port Map (SumStageTwo(3),CarryStageTwo(2),RippleCarry(1),Output(8),RippleCarry(2));
FullAdder8: FullAdder Port Map (CarryStageTwo(3),RippleCarry(2),ProductFour(1),Output(9),RippleCarry(3));
end Behavioral;