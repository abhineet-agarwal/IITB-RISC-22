library ieee;
use ieee.std_logic_1164.all;

entity Mux_2 is
    port (I0, I1: in std_logic_vector(15 downto 0);sel: in  std_logic; S: out std_logic_vector(15 downto 0));
end entity Mux_2;

architecture struct of Mux_2 is
	
component Mux2 is
    port (I0, I1: in std_logic; S: out std_logic;
			sel: in  std_logic);
end component Mux2;

begin
g1 : for i in 0 to 15 generate 
mux0 : mux2 port map (I0(i),I1(i),s(i), sel);
end generate;

end struct;