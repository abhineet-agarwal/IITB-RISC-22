library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Demux_2 is
  port (d : in std_logic_vector(15 downto 0);s: in std_logic; y0: out std_logic_vector(15 downto 0);y1 : out std_logic_vector(15 downto 0));
end entity Demux_2;

architecture Struct of Demux_2 is
component one2two  is
  port (d,s: in std_logic; y0,y1: out std_logic);
end component one2two;
begin

g1 : for i in 0 to 15 generate 
demux0 : one2two port map (d(i),s ,y0(i),y1(i));
end generate;

end struct;
