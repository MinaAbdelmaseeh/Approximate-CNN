library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neural_layer is
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
end neural_layer;
-- i-th neuron = (i+1)*NBITS-1 downto i*NBITS  where neurons are 0-indexed

architecture Behavioral of neural_layer is
type t_Row_Col is array (0 to m-1, 0 to n-1) of STD_LOGIC_VECTOR(NBITS-1 downto 0);
signal W : t_Row_Col;
begin
-- Multiply
Loop_neurons: for i in 0 to m-1 generate
                type arr is array (0 to n-1) of STD_LOGIC_VECTOR(NBITS-1 downto 0);
                signal a : arr;
                signal tmp0 : STD_LOGIC_VECTOR((2*NBITS)-1 downto 0);
                begin
                tmp0<=STD_LOGIC_VECTOR(unsigned(W(i,0)) * unsigned(Inputs( (0+1)*NBITS-1 downto 0*NBITS )));
                a(0)<=tmp0(7 downto 0);
                outputs((i+1)*NBITS-1 downto i*NBITS)<=a(n-1);
Loop_weights:   for j in 1 to n-1 generate
                    signal tmp : STD_LOGIC_VECTOR((2*NBITS)-1 downto 0);
                    signal tmp2: STD_LOGIC_VECTOR(8 downto 0);
                begin
                    tmp<=STD_LOGIC_VECTOR(unsigned(W(i,j)) * unsigned(Inputs( (j+1)*NBITS-1 downto j*NBITS )));
                    --tmp2 <= STD_LOGIC_VECTOR(unsigned(tmp(7 downto 0)) + unsigned(a(j-1)));
                    a(j)<=STD_LOGIC_VECTOR(unsigned(tmp(7 downto 0)) + unsigned(a(j-1)));
                end generate Loop_weights;
  end generate Loop_neurons;

  
process(clk) begin
    if(rising_edge(clk) and write_en='1') then
        W(TO_INTEGER (unsigned(write_i)),TO_INTEGER(unsigned(write_j)))<=write;
    end if;
end process;

end Behavioral;
