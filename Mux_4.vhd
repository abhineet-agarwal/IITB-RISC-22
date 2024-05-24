library ieee;
use ieee.std_logic_1164.all;

entity Mux_4 is
	port(I0, I1, I2, I3: in std_logic_vector(15 downto 0);sel: in  std_logic_vector(1 downto 0);
			S: out std_logic_vector(15 downto 0));
end entity Mux_4;

architecture struct of Mux_4 is
component Mux4 is
	port(I0, I1, I2, I3: in std_logic;sel : std_logic_vector(1 downto 0);
			S: out std_logic);
end component Mux4;
begin
	g1 : for i in 0 to 15 generate 
	mux0 : mux4 port map (I0(i),I1(i),I2(i),I3(i),sel,s(i));
	end generate;
	
end architecture struct;