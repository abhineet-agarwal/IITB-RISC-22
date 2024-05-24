library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity one2two  is
  port (d,s: in std_logic; y0,y1: out std_logic);
end entity one2two;

architecture Struct of one2two is
begin

    y0 <= (not s) and d;
    y1 <= s and d;

end Struct;