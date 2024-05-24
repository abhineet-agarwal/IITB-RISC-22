library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Dflipflop is 
port (d,e,r,p,c,rw: in std_logic; outp :out std_logic);
end entity;

architecture bhv of Dflipflop is

component jk is 
port (j,k,e,r,p,c : in std_logic; outp :out std_logic);
end component jk;

signal d_bar:std_logic;
signal m,n:std_logic;
begin
d_bar<= not d;
m<= d and rw;
n<= d_bar and rw;

jk1: jk port map (j=>m,k=>n,e=>e,r=>r,p=>p,c=>c,outp=>outp);

end bhv;