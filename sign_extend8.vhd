library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend8 is
	port (inp: in std_logic_vector(7 downto 0); extended: out std_logic_vector(15 downto 0));
end entity sign_extend8;

architecture main of sign_extend8 is
	
	begin

	extended <= "00000000" & inp;

end main;