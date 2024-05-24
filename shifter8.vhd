library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity SHIFTer8 is
port (a: in std_logic_vector (15 downto 0);y:out std_logic_vector(15 downto 0));
end entity SHIFTer8;

architecture Struct of SHIFTer8 is

BEGIN

Y <= A(7 DOWNTO 0) & "00000000";


end Struct;