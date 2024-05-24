library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity rf_file is 
	port (rf_a1, rf_a2, rf_a3: in std_logic_vector(2 downto 0); rf_d3: in std_logic_vector(15 downto 0);
		 rf_d1, rf_d2,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7: out std_logic_vector(15 downto 0); rf_write_in, clk,rst: in std_logic);
end entity;

architecture basic of rf_file is

component register1 is
        port(Clk        : in  std_logic;
			 Reset      : in  std_logic;
			 reg_w: in std_logic;
             data_in    : in  std_logic_vector(15 downto 0);
             data_out   : out std_logic_vector(15 downto 0)
				);
    end component;
	 
	 
component Mux8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7: in std_logic;
			sel: in  std_logic_vector(2 downto 0);
			S: out std_logic);
end component Mux8;

component one2eight  is
  port (d: in std_logic_vector(15 downto 0);s: in std_logic_vector(2 downto 0); y0: out std_logic_vector(15 downto 0); y1: out std_logic_vector(15 downto 0); y2: out std_logic_vector(15 downto 0); y3: out std_logic_vector(15 downto 0); y4: out std_logic_vector(15 downto 0); y5: out std_logic_vector(15 downto 0); y6: out std_logic_vector(15 downto 0); y7: out std_logic_vector(15 downto 0));
end component;

component Demux8 is
 port(
		S: in std_logic;sel: in  std_logic_vector(2 downto 0); I0, I1, I2, I3, I4, I5, I6, I7: out std_logic);
end component Demux8;

			
signal r0,r1,r2,r3,r4,r5,r6,r7: std_logic_vector(15 downto 0);
type regarray is array(7 downto 0) of std_logic_vector(15 downto 0);
signal rfw0,rfw1,rfw2,rfw3,rfw4,rfw5,rfw6,rfw7 :std_logic;


signal rout : regarray ;

begin

reg_0 : register1 port map (clk,rst, rfw0, r0, rout(0));
reg_1 : register1 port map (clk,rst, rfw1, r1, rout(1));
reg_2 : register1 port map (clk,rst, rfw2, r2, rout(2));
reg_3 : register1 port map (clk,rst, rfw3, r3, rout(3));
reg_4 : register1 port map (clk,rst, rfw4, r4, rout(4));
reg_5 : register1 port map (clk,rst, rfw5, r5, rout(5));
reg_6 : register1 port map (clk,rst, rfw6, r6, rout(6));
reg_7 : register1 port map (clk,rst, rfw7, r7, rout(7));


demux1 : one2eight port map (rf_d3,rf_a3, r0,r1,r2,r3,r4,r5,r6,r7);
demux2 : demux8 port map (rf_write_in, rf_a3, rfw0, rfw1, rfw2, rfw3, rfw4, rfw5, rfw6, rfw7); 

g1 : for i in 0 to 15 generate 
mux0 : mux8 port map (rout(0)(i), rout(1)(i), rout(2)(i), rout(3)(i), rout(4)(i), rout(5)(i), rout(6)(i), rout(7)(i),rf_a1,rf_d1(i));
end generate;


g2 : for i in 0 to 15 generate 
mux1 : mux8 port map (rout(0)(i), rout(1)(i), rout(2)(i), rout(3)(i), rout(4)(i), rout(5)(i), rout(6)(i), rout(7)(i),rf_a2,rf_d2(i));
end generate;

reg0 <= rout(0);
reg1 <= rout(1);
reg2 <= rout(2);
reg3 <= rout(3);
reg4 <= rout(4);
reg5 <= rout(5);
reg6 <= rout(6);
reg7 <= rout(7);

end basic;