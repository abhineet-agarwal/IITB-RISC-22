library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Demux_4 is
  port (d : in std_logic_vector(15 downto 0);s: in std_logic_vector(1 downto 0); y0: out std_logic_vector(15 downto 0);y1 : out std_logic_vector(15 downto 0);y2 : out std_logic_vector(15 downto 0);y3 : out std_logic_vector(15 downto 0));
end entity Demux_4;

architecture Struct of Demux_4 is

component one2four  is
  port (d: in std_logic ; s: in std_logic_vector(1 downto 0) ; y0: out std_logic ;y1: out std_logic;y2: out std_logic;y3: out std_logic);
end component one2four;


begin

g1 : for i in 0 to 15 generate 
demux0 : one2four port map (d(i), s ,y0(i), y1(i), y2(i) ,y3(i));
end generate;

end Struct;