library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library accurate_arith;
use accurate_arith.accurate_package.all;
library neural_network;
use neural_network.neural_network_package;

entity neural_layer_accurate_fixed_point is
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
end neural_layer_accurate_fixed_point;
-- i-th neuron = (i+1)*NBITS-1 downto i*NBITS  where neurons are 0-indexed

architecture Behavioral of neural_layer_accurate_fixed_point is
component activation_function
    generic (NBITS: natural:=8;
         MANTISSA: natural:=4;
         EXPONENT: natural:=4);
Port ( input : in STD_LOGIC_VECTOR (NBITS-1 downto 0);
       output : out STD_LOGIC_VECTOR(NBITS-1 downto 0));
end component;

type t_Row_Col is array (0 to m-1, 0 to n-1) of STD_LOGIC_VECTOR(NBITS-1 downto 0);
type bias_array is array (0 to m-1) of STD_LOGIC_VECTOR(NBITS-1 downto 0);
signal W : t_Row_Col;
signal B : bias_array;
begin
-- Multiply
Loop_neurons: for i in 0 to m-1 generate
                type arr is array (0 to n-1) of STD_LOGIC_VECTOR(NBITS-1 downto 0);
                signal a : arr;
                signal tmp0,res : STD_LOGIC_VECTOR(NBITS-1 downto 0);
                begin
        --        tmp0<=STD_LOGIC_VECTOR(unsigned(W(i,0)) * unsigned(Inputs( (0+1)*NBITS-1 downto 0*NBITS )));
ll:               Mult8x8_accurate_fixed_point port map (W(i,0), Inputs( (0+1)*NBITS-1 downto 0*NBITS ), tmp0);
                  a(0)<=tmp0;
addr:             Adder8x8_fixed_point port map (a(n-1), B(i),res);
activation_fun:   activation_function port map (res, outputs( (i+1)*NBITS-1 downto i*NBITS ) );
              --    outputs((i+1)*NBITS-1 downto i*NBITS)<=a(n-1);
Loop_weights:   for j in 1 to n-1 generate
                    signal tmp : STD_LOGIC_VECTOR(NBITS-1 downto 0);
                  --  signal tmp2: STD_LOGIC_VECTOR(8 downto 0);
                begin
                  --  tmp<=STD_LOGIC_VECTOR(unsigned(W(i,j)) * unsigned(Inputs( (j+1)*NBITS-1 downto j*NBITS )));
                    --tmp2 <= STD_LOGIC_VECTOR(unsigned(tmp(7 downto 0)) + unsigned(a(j-1)));
ll1:                Mult8x8_accurate_fixed_point port map(W(i,j) , Inputs( (j+1)*NBITS-1 downto j*NBITS ), tmp);
aaa:                Adder8x8_fixed_point port map (tmp, a(j-1) , a(j));
--                    a(j)<=STD_LOGIC_VECTOR(unsigned(tmp(7 downto 0)) + unsigned(a(j-1)));
                end generate Loop_weights;
  end generate Loop_neurons;

  
process(clk) begin
    if(rising_edge(clk) and write_en='1' and WB='1') then
        W(TO_INTEGER (unsigned(write_i)),TO_INTEGER(unsigned(write_j)))<=write;
    elsif(rising_edge(clk) and write_en='1' and WB='0') then
        B(TO_INTEGER (unsigned(write_i))) <= write;
    end if;
end process;

end Behavioral;
