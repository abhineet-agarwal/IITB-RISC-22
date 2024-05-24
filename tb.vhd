library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is 
end; 
architecture TB_BEHAVIOR of tb is 

component iitb_cpu is
	port (clk, rst: in std_logic; reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,memo: out std_logic_vector(15 downto 0));
end component iitb_cpu;

signal rst: std_logic := '0';
signal clk: std_logic := '1';
signal reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,memo: std_logic_vector(15 downto 0);

begin 
clk <= not clk after 10 ns;
process
begin
  rst <= '1';
  wait for 10 ns;
  rst <= '0';
  wait;
end process;


tb1:iitb_cpu port map (clk,rst,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,memo);

end TB_BEHAVIOR;