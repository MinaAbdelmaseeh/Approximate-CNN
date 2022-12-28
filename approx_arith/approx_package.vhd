

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package approx_package is
constant num : natural := 4;
constant decimal : natural := 4;
component mult8
Port ( 
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        Output: out std_logic_vector(15 downto 0)
);
end component;

component mult5
Port (     A : in STD_LOGIC_VECTOR (4 downto 0);
           B : in STD_LOGIC_VECTOR (4 downto 0);
           Output : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component Mult8x8_approx_fixed_point
    Port ( A : in STD_LOGIC_VECTOR(7 downto 0);
       B : in STD_LOGIC_VECTOR(7 downto 0);
       output : out STD_LOGIC_VECTOR(7 downto 0));
end component;
end approx_package;
