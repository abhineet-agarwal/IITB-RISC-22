library ieee;
use ieee.std_logic_1164.all;
use work.Gates.all;

entity sixteen_bit_adder_sub is
	port(A,B : in std_logic_vector(15 downto 0); M : in std_logic; S : out std_logic_vector(15 downto 0); Cout : out std_logic );
end entity sixteen_bit_adder_sub;	

architecture struct_addsub of sixteen_bit_adder_sub is

component FA  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end component FA;   

signal C : std_logic_vector(16 downto 0) := "00000000000000000";
signal p : std_logic_vector(15 downto 0) := "0000000000000000";

begin

C(0) <= M;
gen: for i in 0 to 15 generate
p(i)<=(M xor B(i));
FA1 : FA port map (A => A(i), B => p(i), Cin => C(i), S => S(i), Cout => c(i+1));
end generate gen;
Cout <= c(16);

end architecture struct_addsub;
