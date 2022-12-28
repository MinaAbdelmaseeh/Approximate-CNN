library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library neural_network;
use neural_network.neural_network_package.all;
entity nerual_network_tb is
    generic (
       NBITS: natural:=8;
       n: natural :=2;
       m: natural :=2 
);
  --Port ( );
end nerual_network_tb;

architecture Behavioral of nerual_network_tb is
--component neural_layer
--    generic (
--           NBITS: natural:=8;
--           n: natural :=2;
--           m: natural :=4 
--    );
--    Port ( Inputs : in STD_LOGIC_VECTOR  ((n*8)-1 downto 0);
--           write_en,clk : in STD_LOGIC;
--           write_i,write_j: in STD_LOGIC_VECTOR(7 downto 0);
--           write : in STD_LOGIC_VECTOR(NBITS-1 downto 0); 
--           outputs : out STD_LOGIC_VECTOR((m*8)-1 downto 0));
--end component;
signal Inputs : STD_LOGIC_VECTOR((n*8)-1 downto 0);
signal output_accurate,output_approx : STD_LOGIC_VECTOR((m*8)-1 downto 0);
signal write : STD_LOGIC_VECTOR(NBITS-1 downto 0);
signal write_i,write_j : STD_LOGIC_VECTOR(7 downto 0);
signal clk,WB : STD_LOGIC;
signal write_en : STD_LOGIC_VECTOR(2 downto 0);
signal tmp,tmp2,tmp3,tmp4,tmp5,tmp6 :integer :=0;
begin
nl: neural_network_accurate port map (
Inputs=>Inputs,
outputs=>output_accurate,
write=>write,
write_i=>write_i,
write_j=>write_j,
write_en=>write_en,
WB=>WB,
clk=>clk
);
n2: neural_network_approx port map (
Inputs=>Inputs,
outputs=>output_approx,
write=>write,
write_i=>write_i,
write_j=>write_j,
write_en=>write_en,
WB=>WB,
clk=>clk
);
process begin
    clk<='1'; wait for 10 ns;
    clk<='0'; wait for 10 ns;
end process;
inputs<=STD_LOGIC_VECTOR(to_unsigned(1, 8))&STD_LOGIC_VECTOR(to_unsigned(2, 8));
process 
begin
neurons1:    for i in 0 to 3 loop
weights1:      for j in 0 to 1 loop
                 write_en<="001";
                 WB<='1';
                 write_i<=STD_LOGIC_VECTOR(to_unsigned(i, write_i'length));
                 write_j<=STD_LOGIC_VECTOR(to_unsigned(j, write_j'length));
                 write  <=STD_LOGIC_VECTOR(to_unsigned(tmp*13, write'length));
--                   write_i<="0000001";
--                   write_j<="0000001";
--                   write<=  "0101010";
                 tmp<=tmp+1;
                 wait for 40 ns;
              end loop weights1;
            end loop neurons1;
            
bb1: for i in 0 to 3 loop
        write_en<="001";
        WB<='0';
        write_i<=STD_LOGIC_VECTOR(to_unsigned(i, write_i'length));
        write  <=STD_LOGIC_VECTOR(to_unsigned(tmp2*8, write'length));
        tmp2<=tmp2+1;
        wait for 40ns; 
    end loop bb1;
    
neurons2:    for i in 0 to 3 loop
weights2:      for j in 0 to 3 loop
                     write_en<="010";
                     WB<='1';
                     write_i<=STD_LOGIC_VECTOR(to_unsigned(i, write_i'length));
                     write_j<=STD_LOGIC_VECTOR(to_unsigned(j, write_j'length));
                     write  <=STD_LOGIC_VECTOR(to_unsigned(tmp3*13, write'length));
    --                   write_i<="0000001";
    --                   write_j<="0000001";
    --                   write<=  "0101010";
                     tmp3<=tmp3+1;
                     wait for 40 ns;
                  end loop weights2;
                end loop neurons2;
                
bb2: for i in 0 to 3 loop
            write_en<="010";
            WB<='0';
            write_i<=STD_LOGIC_VECTOR(to_unsigned(i, write_i'length));
            write  <=STD_LOGIC_VECTOR(to_unsigned(tmp4*13, write'length));
            tmp4<=tmp4+1;
            wait for 40ns; 
        end loop bb2;
neurons3:    for i in 0 to 1 loop
weights3:      for j in 0 to 3 loop
                         write_en<="100";
                         WB<='1';
                         write_i<=STD_LOGIC_VECTOR(to_unsigned(i, write_i'length));
                         write_j<=STD_LOGIC_VECTOR(to_unsigned(j, write_j'length));
                         write  <=STD_LOGIC_VECTOR(to_unsigned(tmp5*13, write'length));
        --                   write_i<="0000001";
        --                   write_j<="0000001";
        --                   write<=  "0101010";
                         tmp5<=tmp5+1;
                         wait for 40 ns;
                      end loop weights3;
                    end loop neurons3;
                    
bb3: for i in 0 to 1 loop
                write_en<="100";
                WB<='0';
                write_i<=STD_LOGIC_VECTOR(to_unsigned(i, write_i'length));
                write  <=STD_LOGIC_VECTOR(to_unsigned(tmp6*11, write'length));
                tmp6<=tmp6+1;
                wait for 40ns; 
            end loop bb3;
write_en<="000";
wait;
end process;

end Behavioral;
