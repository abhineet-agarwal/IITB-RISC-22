library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jk is 
port (j,k,e,r,p,c : in std_logic; outp :out std_logic);
end entity;

architecture bhv of jk is

signal q: std_logic:='0' ;

begin

PROCESS(C)
variable TMP: std_logic;
begin
if(e='1') then
	if(r='1') then
		tmp:='0';
		elsif(p='1') then
			tmp:='1';
elsif(C='1' and C'EVENT) then

if(J='0' and K='0')then
TMP:=TMP;
elsif(J='1' and K='1')then
TMP:= not TMP;
elsif(J='0' and K='1')then
TMP:='0';
else
TMP:='1';
end if;
end if;
else
tmp:=tmp;
end if;
outp<=TMP;
end PROCESS;
end bhv;
		
	
	




