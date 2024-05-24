library ieee;
use ieee.std_logic_1164.all;

entity Mux4 is
	port(I0, I1, I2, I3: in std_logic;
			sel: in  std_logic_vector(1 downto 0);
			S: out std_logic);
end entity Mux4;

architecture struct of Mux4 is

component Mux2 is
        port (I0, I1: in std_logic; S: out std_logic;
			sel: in  std_logic);
end component Mux2;


	signal  s1, s2 : std_logic;
begin
	m1: Mux2
		port map (
			I0 => I0, I1 => I1, sel => sel(0), S => s1
		);
	m2: Mux2
		port map (
			I0 => I2, I1 => I3, sel => sel(0), S => s2
		);
	m3: Mux2
		port map (
			I0 => s1, I1 => s2, sel => sel(1), S => S
		);
	
end architecture struct;