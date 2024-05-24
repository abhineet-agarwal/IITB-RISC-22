library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend9 is
	port (inp: in std_logic_vector(8 downto 0); extended: out std_logic_vector(15 downto 0));
end entity sign_extend9;

architecture main of sign_extend9 is
	
	begin

	extended <= "0000000" & inp;

end main;