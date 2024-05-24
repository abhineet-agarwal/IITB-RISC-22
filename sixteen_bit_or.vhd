library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity sixteen_bit_or  is
  port (A, B: in std_logic_vector(15 downto 0); OUTP: out std_logic_vector(15 downto 0));
end entity sixteen_bit_or;

architecture Struct of sixteen_bit_or is
  signal ABBAR : std_logic;
begin
  process(a,b)
  begin
    outp(0) <= a(0) or b(0);
    outp(1) <= a(1) or b(1);
    outp(2) <= a(2) or b(2);
    outp(3) <= a(3) or b(3);
    outp(4) <= a(4) or b(4);
    outp(5) <= a(5) or b(5);
    outp(6) <= a(6) or b(6);
    outp(7) <= a(7) or b(7);
    outp(8) <= a(8) or b(8);
    outp(9) <= a(9) or b(9);
    outp(10) <= a(10) or b(10);
    outp(11) <= a(11) or b(11);
    outp(12) <= a(12) or b(12);
    outp(13) <= a(13) or b(13);
    outp(14) <= a(14) or b(14);
    outp(15) <= a(15) or b(15);
end process;
end Struct;