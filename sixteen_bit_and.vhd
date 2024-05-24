library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity sixteen_bit_and  is
  port (A, B: in std_logic_vector(15 downto 0); outp: out std_logic_vector(15 downto 0));
end entity sixteen_bit_and;

architecture Struct of sixteen_bit_and is
  signal A_BAR, B_BAR : std_logic;
begin
process(a,b)
begin
    outp(0) <= a(0) and b(0);
    outp(1) <= a(1) and b(1);
    outp(2) <= a(2) and b(2);
    outp(3) <= a(3) and b(3);
    outp(4) <= a(4) and b(4);
    outp(5) <= a(5) and b(5);
    outp(6) <= a(6) and b(6);
    outp(7) <= a(7) and b(7);
    outp(8) <= a(8) and b(8);
    outp(9) <= a(9) and b(9);
    outp(10) <= a(10) and b(10);
    outp(11) <= a(11) and b(11);
    outp(12) <= a(12) and b(12);
    outp(13) <= a(13) and b(13);
    outp(14) <= a(14) and b(14);
    outp(15) <= a(15) and b(15);
	 end process;

end Struct;