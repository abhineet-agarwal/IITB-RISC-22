library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Demux8 is
 port(
		S: in std_logic;sel: in  std_logic_vector(2 downto 0); I0, I1, I2, I3, I4, I5, I6, I7: out std_logic);
end entity Demux8;


architecture kk of Demux8 is


begin

I0 <= (not sel(0)) and (not sel(1)) and (not sel(2)) AND S;
I1 <= (sel(0)) and (not sel(1)) and (not sel(2)) AND S;
I2 <= (NOT (sel(0))) and Sel(1) and (not sel(2)) AND S;
I3 <= ((sel(0)) and (sel(1)) and (not sel(2))) AND S; 
I4 <= ((not sel(0)) and (not sel(1)) and (sel(2))) AND S;
I5 <= ((sel(0)) and (not sel(1)) and (sel(2))) AND S;
I6 <= ((not sel(0)) and (sel(1)) and (sel(2))) AND S;
I7 <= ((sel(0)) and (sel(1)) and (sel(2))) AND S;

end kk;