library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity one2four  is
  port (d: in std_logic ; s: in std_logic_vector(1 downto 0) ; y0: out std_logic ;y1: out std_logic;y2: out std_logic;y3: out std_logic);
end entity one2four;

architecture kk of one2four is

begin
    y0 <= (not s(0)) and (not s(1)) and d;
    y1 <= s(0) and (not s(1)) and d;
    y2 <= s(1) and (not s(0)) and d;
    y3 <= s(1) and s(0) and d;

end kk;