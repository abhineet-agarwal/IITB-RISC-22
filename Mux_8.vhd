library ieee;
use ieee.std_logic_1164.all;

entity Mux_8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7: in std_logic_vector(15 downto 0);
			sel: in  std_logic_vector(2 downto 0);
			S: out std_logic_vector(15 downto 0));
end entity Mux_8;

architecture struct of Mux_8 is

component Mux8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7: in std_logic;
			sel: in  std_logic_vector(2 downto 0);
			S: out std_logic);
end component Mux8;
begin
g1 : for i in 0 to 15 generate 
	mux0 : mux8 port map (I0(i),I1(i),I2(i),I3(i),I4(i),I5(i),I6(i),I7(i),sel,s(i));
	end generate;
	
end struct;

