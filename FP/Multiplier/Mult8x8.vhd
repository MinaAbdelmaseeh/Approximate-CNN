-- Our Floating point representation of 8bit number is
-- Sign(1b)  - Mantissa(4b) (+1 hidden bit) - Exponent(3b)
-- mantissa is in the form X.XXX
-- exponent representation  :
-- zero => 000
-- inf  => 111
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mult8x8 is
    generic (NBITS   : natural :=8;
             MANTISSA: natural :=4;
             EXPONENT: natural :=3);
    Port ( A : in STD_LOGIC_VECTOR(NBITS-1 downto 0);
           B : in STD_LOGIC_VECTOR(NBITS-1 downto 0);
           output : out STD_LOGIC_VECTOR(NBITS-1 downto 0));
end Mult8x8;

architecture Behavioral of Mult8x8 is
component Mult5x5
    Port ( A : in STD_LOGIC_VECTOR(4 downto 0);
       B : in STD_LOGIC_VECTOR(4 downto 0);
       output : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component exponent_decode
    generic (NBITS   : natural :=8;
             MANTISSA: natural :=4;
             EXPONENT: natural :=3);
    Port ( A : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
           exp_decode : out STD_LOGIC_VECTOR(EXPONENT-1 downto 0));
end component;

component exponent_encode
    generic (NBITS   : natural :=8;
             MANTISSA: natural :=4;
             EXPONENT: natural :=3);
    Port ( A : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
           denorm,Inf,NaN,Zero : in STD_LOGIC;
           exp_encode : out STD_LOGIC_VECTOR (EXPONENT-1 downto 0));
end component;

component normalizer
    generic (NBITS   : natural :=8;
         MANTISSA: natural :=4;
         EXPONENT: natural :=3);
    Port ( mult_out : in STD_LOGIC_VECTOR((MANTISSA+ MANTISSA+1) downto 0) ;
           exp_a : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0) ;
           exp_b : in STD_LOGIC_VECTOR(EXPONENT-1 downto 0) ;
           mantissa_out : out STD_LOGIC_VECTOR(MANTISSA-1 downto 0) ;
           exp_out : out STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
           denorm,Inf,Zero: out STD_LOGIC);
end component;

signal sign: STD_LOGIC;
signal mult_out: STD_LOGIC_VECTOR(9 downto 0);
signal mult_in1,mult_in2:STD_LOGIC_VECTOR(4 downto 0);

signal mantissa_shift: STD_LOGIC_VECTOR(MANTISSA downto 0);
signal mantissa_out,mantissa_pre: STD_LOGIC_VECTOR(MANTISSA-1 downto 0);

signal exp_norm: STD_LOGIC_VECTOR(2 downto 0);
signal exp_a,exp_b: STD_LOGIC_VECTOR(2 downto 0);
signal exp: STD_LOGIC_VECTOR(EXPONENT+1 downto 0); -- it has size of exponent+2
signal exp_out : STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
signal exp_encode : STD_LOGIC_VECTOR(EXPONENT-1 downto 0);
--- exception flags
signal Zero,Zero_a,Zero_b,Zero_flag: STD_LOGIC:='0';
signal Inf,Inf_a,Inf_b,Inf_flag: STD_LOGIC:='0';
signal denorm: STD_LOGIC :='0';
signal NaN,NaN_a,NaN_b: STD_LOGIC:='0';
signal hidden_a,hidden_b : STD_LOGIC :='0';
begin
-- calculate sign  (0,0)=>0 , (0,1)=>1 , (1,0)=>1 , (1,1)=>0
sign <= A(NBITS-1) xor B(NBITS-1);
-- hidden bits
with A(EXPONENT-1 downto 0) select
    hidden_a<='0' when "000",
              '1' when others;
with B(EXPONENT-1 downto 0) select
    hidden_b<='0' when "000",
              '1' when others;
-- Multiply mantissa
mult_in1<=hidden_a & A(NBITS-2 downto EXPONENT);
mult_in2<=hidden_b & B(NBITS-2 downto EXPONENT);
Multiply: Mult5x5 port map (
A=> mult_in1,
B=> mult_in2,
output=>mult_out
);
                    
Decode_exponent_A: exponent_decode port map(
A=> A(EXPONENT-1 downto 0),
exp_decode => exp_a
);

Decode_exponent_B: exponent_decode port map(
A=> B(EXPONENT-1 downto 0),
exp_decode => exp_b
);
----------------------- Normalizing the mantissa ------------------------
-- on multiplying 2 numbers X.XXXX * X.XXXX = XX.XXXXXX
-- exp_shift represents the place of the most significant 1 relative to the decimal point in order to reach a scientific notation 1.XXXX * 2^shift
normalizer_out: normalizer port map (
mult_out=>mult_out,
exp_a=> exp_a,
exp_b=> exp_b,
mantissa_out=> mantissa_pre,
denorm=>denorm,
Inf=>Inf_flag,
Zero=>Zero_flag,
exp_out=>exp_out
);
Zero<= (Zero_a and (not Inf_b) ) or (Zero_b and (not Inf_a) ) or (Zero_flag and (not Zero_a) and (not Zero_b) and (not Inf_a) and (not Inf_b) );
Inf<= (Inf_a and (not Zero_b)) or (Inf_b and (not Zero_a)) or (Inf_flag and (not Zero_a) and (not Zero_b) and (not Inf_a) and (not Inf_b) );
NaN<= (Inf_a and Zero_b) or (Inf_b and Zero_a) or NaN_a or NaN_b;


--- Check Zero
with A(NBITS-2 downto 0) select -- detect if a = 0
             Zero_a<='1' when "0000000",
                   '0' when others;

with B(NBITS-2 downto 0) select -- detect if b = 0
             Zero_b<='1' when "0000000",
                   '0' when others;
--Zero<= Zero_a or Zero_b or Zero_flag; --- check if the result =0
--- Check Infinity ---
with A(NBITS-2 downto 0) select -- detect if a = inf
             Inf_a<='1' when "0000111",
                   '0' when others;

with B(NBITS-2 downto 0) select -- detect if b = inf
             Inf_b<='1' when "0000111",
                   '0' when others;
---- Check NaN ----
with A(NBITS-2 downto 0) select -- detect if a = inf
             NaN_a<='1' when "0001111",
                   '0' when others;

with B(NBITS-2 downto 0) select -- detect if b = inf
             NaN_b<='1' when "0001111",
                   '0' when others;
--------------------------------------------------------------------
exp_encode_out: exponent_encode port map(
A=>exp_out,
denorm=> denorm,
Inf=>Inf,
NaN=>NaN,
Zero=>Zero,
exp_encode=>exp_encode
);
mantissa_out <= "0000" when Inf='0' and Zero = '1' else 
	 "0000" when Inf = '1' and Zero='0' else 
	 "0001" when NaN = '1' else 
	 mantissa_pre;

output<= sign & mantissa_out & exp_encode;

end Behavioral;
