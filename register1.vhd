library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register1 is
        port(Clk        : in  std_logic;
			 Reset      : in  std_logic;
			 reg_w: in std_logic;
             data_in    : in  std_logic_vector(15 downto 0);
             data_out   : out std_logic_vector(15 downto 0)
				 );
    end entity;
	 

architecture bhv of register1 is

component Dflipflop is 
port (d,e,r,p,c,rw : in std_logic; outp :out std_logic);
end component;

signal a,b: std_logic_vector(15 downto 0);

begin
a <= data_in;

d_ff1: Dflipflop port map ( d=> a(0),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(0));
d_ff2: Dflipflop port map ( d=> a(1),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(1));
d_ff3: Dflipflop port map ( d=> a(2),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(2));
d_ff4: Dflipflop port map ( d=> a(3),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(3));
d_ff5: Dflipflop port map ( d=> a(4),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(4));
d_ff6: Dflipflop port map ( d=> a(5),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(5));
d_ff7: Dflipflop port map ( d=> a(6),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(6));
d_ff8: Dflipflop port map ( d=> a(7),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(7));
d_ff9: Dflipflop port map ( d=> a(8),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(8));
d_ff10: Dflipflop port map ( d=> a(9),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(9));
d_ff11: Dflipflop port map ( d=> a(10),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(10));
d_ff12: Dflipflop port map ( d=> a(11),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(11));
d_ff13: Dflipflop port map ( d=> a(12),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(12));
d_ff14: Dflipflop port map ( d=> a(13),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(13));
d_ff15: Dflipflop port map ( d=> a(14),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(14));
d_ff16: Dflipflop port map ( d=> a(15),e => '1',r=> Reset,p=> '0',c=> Clk ,rw => reg_w,outp=> b(15));

data_out <= b;


end bhv;