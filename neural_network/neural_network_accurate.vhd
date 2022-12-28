

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library neural_network;
use neural_network.neural_network_package;

entity neural_network_accurate is
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
end neural_network_accurate;

architecture Behavioral of neural_network_accurate is
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
signal out1,out2 : STD_LOGIC_VECTOR(4*8-1 downto 0);

begin
layer1: neural_layer_accurate_fixed_point 
generic map (
    NBITS=>8,
    n=>2,
    m=>4 
) port map (
Inputs=> Inputs,
outputs=>out1,
write_en=>write_en(0),
clk=>clk,
WB=>WB,
write_i=>write_i,
write_j=>write_j,
write=>write
);

layer2: neural_layer_accurate_fixed_point 
generic map (
    NBITS=>8,
    n=>4,
    m=>4 
) port map (
Inputs=> out1,
outputs=>out2,
write_en=>write_en(1),
clk=>clk,
WB=>WB,
write_i=>write_i,
write_j=>write_j,
write=>write
);

layer3: neural_layer_accurate_fixed_point 
generic map (
    NBITS=>8,
    n=>4,
    m=>2 
) port map (
Inputs=> out2,
outputs=>outputs,
write_en=>write_en(2),
clk=>clk,
WB=>WB,
write_i=>write_i,
write_j=>write_j,
write=>write
);

end Behavioral;
