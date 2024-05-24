library ieee;
use ieee.std_logic_1164.all;

entity zero_check is
	port(A: in std_logic_vector(15 downto 0);
			S: out std_logic);
end entity zero_check;

architecture struct of zero_check is

begin
	-- S is 1 if all input bits are 0
	S <= not(A(0) or A(1) or A(2) or A(3) or A(4) or A(5) or A(6) or A(7) or A(8) or 
				A(9) or A(10) or A(11) or A(12) or A(13) or A(14) or A(15));
end architecture struct;