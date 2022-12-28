library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package neural_network_package is
component neural_layer
 generic (
          NBITS: natural:=8;
          n: natural :=2;
          m: natural :=4 
   );
   Port ( Inputs : in STD_LOGIC_VECTOR  ((n*8)-1 downto 0);
          write_en,clk : in STD_LOGIC;
          write_i,write_j: in STD_LOGIC_VECTOR(7 downto 0);
          write : in STD_LOGIC_VECTOR(NBITS-1 downto 0); 
          outputs : out STD_LOGIC_VECTOR((m*8)-1 downto 0));
end component;
component neural_layer_accurate_fixed_point
 generic (
          NBITS: natural:=8;
          n: natural :=2;
          m: natural :=4 
   );
   Port ( Inputs : in STD_LOGIC_VECTOR  ((n*8)-1 downto 0);
          write_en,clk,WB : in STD_LOGIC;
          write_i,write_j: in STD_LOGIC_VECTOR(7 downto 0);
          write : in STD_LOGIC_VECTOR(NBITS-1 downto 0); 
          outputs : out STD_LOGIC_VECTOR((m*8)-1 downto 0));
end component;

component neural_layer_approx_fixed_point
 generic (
          NBITS: natural:=8;
          n: natural :=2;
          m: natural :=4 
   );
   Port ( Inputs : in STD_LOGIC_VECTOR  ((n*8)-1 downto 0);
          write_en,clk,WB : in STD_LOGIC;
          write_i,write_j: in STD_LOGIC_VECTOR(7 downto 0);
          write : in STD_LOGIC_VECTOR(NBITS-1 downto 0); 
          outputs : out STD_LOGIC_VECTOR((m*8)-1 downto 0));
end component;

component activation_function
    generic (NBITS: natural:=8;
         MANTISSA: natural:=4;
         EXPONENT: natural:=4);
Port ( input : in STD_LOGIC_VECTOR (NBITS-1 downto 0);
       output : out STD_LOGIC_VECTOR(NBITS-1 downto 0));
end component;

component neural_network_accurate
 generic (
      NBITS: natural:=8;
      n: natural :=2; -- inputs
      m: natural :=2  -- outputs
);
   Port ( Inputs : in STD_LOGIC_VECTOR  ((n*8)-1 downto 0);
          clk,WB : in STD_LOGIC;
          write_en : in STD_LOGIC_VECTOR(2 downto 0);
          write_i,write_j: in STD_LOGIC_VECTOR(7 downto 0);
          write : in STD_LOGIC_VECTOR(NBITS-1 downto 0); 
          outputs : out STD_LOGIC_VECTOR((m*8)-1 downto 0)
          );
end component;

component neural_network_approx
 generic (
      NBITS: natural:=8;
      n: natural :=2; -- inputs
      m: natural :=2  -- outputs
);
   Port ( Inputs : in STD_LOGIC_VECTOR  ((n*8)-1 downto 0);
          clk,WB : in STD_LOGIC;
          write_en : in STD_LOGIC_VECTOR(2 downto 0);
          write_i,write_j: in STD_LOGIC_VECTOR(7 downto 0);
          write : in STD_LOGIC_VECTOR(NBITS-1 downto 0); 
          outputs : out STD_LOGIC_VECTOR((m*8)-1 downto 0)
          );
end component;
end neural_network_package;
