

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



package accurate_package is
constant num : natural := 4;
constant decimal : natural := 4;
component Mult5x5
    Port ( A : in STD_LOGIC_VECTOR(4 downto 0);
           B : in STD_LOGIC_VECTOR(4 downto 0);
           output : out STD_LOGIC_VECTOR(9 downto 0));
end component;
component AccurateEightBit
Port ( 
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        Output: out std_logic_vector(15 downto 0)
);
end component;

component Mult8x8_accurate_fixed_point
Port ( 
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
);
end component;

component Adder8x8_fixed_point
Port ( 
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
);
end component;
end accurate_package;
