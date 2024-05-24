library ieee;
use ieee.std_logic_1164.all;

entity FA  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end entity FA;

architecture struct of FA is

	begin
		S <= (A xor B) xor Cin;
		Cout <= (A and B) or (Cin and (A xor B));
		
end architecture struct;