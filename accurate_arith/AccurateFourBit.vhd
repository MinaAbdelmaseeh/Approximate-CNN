----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 03:50:23 PM
-- Design Name: 
-- Module Name: AccurateFourBit - Behavioral
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

library accurate_arith;
use accurate_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AccurateFourBit is
Port ( 
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        Output: out std_logic_vector(7 downto 0)
);
end AccurateFourBit;

architecture Behavioral of AccurateFourBit is
component AccurateMultiplier
Port(
    A: in std_logic_vector(1 downto 0);
    B: in std_logic_vector(1 downto 0);
    Output: out std_logic_vector(3 downto 0)
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
signal ProductOne: std_logic_vector(3 downto 0);
signal ProductTwo: std_logic_vector(3 downto 0);
signal ProductThree: std_logic_vector(3 downto 0);
signal ProductFour: std_logic_vector(3 downto 0);
signal SumStageOne: std_logic_vector (5 downto 0);
signal CarryStageOne: std_logic_vector(3 downto 0);
signal SumStageTwo: std_logic_vector (4 downto 0);
signal CarryStageTwo: std_logic_vector(3 downto 0); 
signal RippleCarry: std_logic_vector(3 downto 0);
begin 
AccurateMultiplier1: AccurateMultiplier Port Map(A(1 downto 0),B(1 downto 0),ProductOne);
AccurateMultiplier2: AccurateMultiplier Port Map(A(3 downto 2),B(1 downto 0),ProductTwo);
AccurateMultiplier3: AccurateMultiplier Port Map(A(1 downto 0),B(3 downto 2),ProductThree);
AccurateMultiplier4: AccurateMultiplier Port Map(A(3 downto 2),B(3 downto 2),ProductFour);
--Using Wallace Tree
--Stage One
SumStageOne(0) <= ProductOne(0);
SumStageOne(1) <= ProductOne(1);
FullAdder1: FullAdder Port Map (ProductOne(2),ProductTwo(0),ProductThree(0),SumStageOne(2),CarryStageOne(0));
FullAdder2: FullAdder Port Map (ProductOne(3),ProductTwo(1),ProductThree(1),SumStageOne(3),CarryStageOne(1));
HalfAdder1: HalfAdder Port Map (ProductTwo(2),ProductThree(2),SumStageOne(4),CarryStageOne(2));
halfAdder2: HalfAdder Port Map (ProductTwo(3),ProductThree(3),SumStageOne(5),CarryStageOne(3));
--Stage Two
HalfAdder3: HalfAdder Port Map (SumStageOne(3),CarryStageOne(0),SumStageTwo(0),CarryStageTwo(0));
FullAdder6: FullAdder Port Map (SumStageOne(4),CarryStageOne(1),ProductFour(0),SumStageTwo(1),CarryStageTwo(1));
FullAdder7: FullAdder Port Map (SumStageOne(5),CarryStageOne(2),ProductFour(1),SumStageTwo(2),CarryStageTwo(2));
HalfAdder4: HalfAdder Port Map (CarryStageOne(3),ProductFour(2),SumStageTwo(3),CarryStageTwo(3));
SumStageTwo(4) <= ProductFour(3);
--Last Stage
Output(0) <= SumStageOne(0);
Output(1) <= SumStageOne(1);
Output(2) <= SumStageOne(2);
Output(3) <= SumStageTwo(0);
--Using Carry Ripple Adder
FullAdder9: FullAdder Port Map (SumStageTwo(1),CarryStageTwo(0),'0',Output(4),RippleCarry(0));
FullAdder10: FullAdder Port Map (SumStageTwo(2),CarryStageTwo(1),RippleCarry(0),Output(5),RippleCarry(1));
FullAdder11: FullAdder Port Map (SumStageTwo(3),CarryStageTwo(2),RippleCarry(1),Output(6),RippleCarry(2));
FullAdder12: FullAdder Port Map (SumStageTwo(4),CarryStageTwo(3),RippleCarry(2),Output(7),RippleCarry(3));
end Behavioral;
