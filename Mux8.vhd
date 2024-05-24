library ieee;
use ieee.std_logic_1164.all;

entity Mux8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7: in std_logic;
			sel: in  std_logic_vector(2 downto 0);
			S: out std_logic);
end entity Mux8;

architecture struct of Mux8 is

component Mux4 is
	port(I0, I1, I2, I3: in std_logic;sel : std_logic_vector(1 downto 0);
			S: out std_logic);
end component Mux4;

component Mux2 is
        port (I0, I1: in std_logic; S: out std_logic;
			sel: in  std_logic);
end component Mux2;


	signal  s1, s2 : std_logic;
	signal  sig10 : std_logic_vector(1 downto 0);
begin

	sig10 <= (sel(1) & sel(0));
	
	m1: Mux4
		port map (
			I0 => I0, I1 => I1, I2 => I2,I3 => I3, sel => sig10, S => s1
		);
	m2: Mux4
		port map (
			I0 => I4, I1 => I5, I2 => I6,I3 => I7, sel => sig10 , S => s2
		);
	m3: Mux2
		port map (
			I0 => s1, I1 => s2, sel => sel(2), S => S
		);
	
end architecture struct;