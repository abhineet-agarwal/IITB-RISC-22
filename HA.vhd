library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity HA  is
  port (A, B: in std_logic; S, C: out std_logic);
end entity HA;

architecture Struct of HA is
  
begin
  
  XOR1:XOR_2 port map (A => A, B => B, Y => S);
 
  AND1:AND_2 port map (A => A, B => B, Y => C);
end Struct;