library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity sixteen_bit_mul  is
  port (A3,A2,A1,A0,B3,B2,B1,B0: in std_logic; m: out std_logic_vector(15 downto 0));
end entity sixteen_bit_mul;

architecture Struct of sixteen_bit_mul is

   component fourbitfa is
     port(A3,A2,A1,A0,B3,B2,B1,B0: in std_logic;
          S3,S2,S1,S0,S4: out std_logic);
   end component;
  
  signal a1b0,a2b0,a3b0,a0b1,a1b1,a2b1,a3b1,a0b2,a1b2,a2b2,a3b2,a0b3,a1b3,a2b3,a3b3,s4,s3,s2,s1,s5,s6,s7,s8 : std_logic;

begin
  
 and1 : and_2 port map(a=>a0,b=>b0,y=>m(0));
 and2 : and_2 port map(a=>a1,b=>b0,y=>a1b0);
 and3 : and_2 port map(a=>a2,b=>b0,y=>a2b0);
 and4 : and_2 port map(a=>a3,b=>b0,y=>a3b0);
 and5 : and_2 port map(a=>a0,b=>b1,y=>a0b1);
 and6 : and_2 port map(a=>a1,b=>b1,y=>a1b1);
 and7 : and_2 port map(a=>a2,b=>b1,y=>a2b1);
 and8 : and_2 port map(a=>a3,b=>b1,y=>a3b1);
 and9 : and_2 port map(a=>a0,b=>b2,y=>a0b2);
 and10 : and_2 port map(a=>a1,b=>b2,y=>a1b2);
 and11 : and_2 port map(a=>a2,b=>b2,y=>a2b2);
 and12 : and_2 port map(a=>a3,b=>b2,y=>a3b2);
 and13 : and_2 port map(a=>a0,b=>b3,y=>a0b3);
 and14 : and_2 port map(a=>a1,b=>b3,y=>a1b3);
 and15 : and_2 port map(a=>a2,b=>b3,y=>a2b3);
 and16 : and_2 port map(a=>a3,b=>b3,y=>a3b3);

 fbfa1 : fourbitfa port map(A3=>'0',A2=>a3b0,A1=>a2b0,A0=>a1b0,B3=>a3b1,B2=>a2b1,B1=>a1b1,B0=>a0b1,S3=>s3,S2=>s2,S1=>s1,S0=>m(1),S4=>s4) ;
 fbfa2 : fourbitfa port map(A3=>s4,A2=>s3,A1=>s2,A0=>s1,B3=>a3b2,B2=>a2b2,B1=>a1b2,B0=>a0b2,S3=>s7,S2=>s6,S1=>s5,S0=>m(2),S4=>s8) ;
 fbfa3 : fourbitfa port map(A3=>s8,A2=>s7,A1=>s6,A0=>s5,B3=>a3b3,B2=>a2b3,B1=>a1b3,B0=>a0b3,S3=>m(6),S2=>m(5),S1=>m(4),S0=>m(3),S4=>m(7)) ;
 buff8bit : buff port map("00000000",m(15 downto 8));
-- ensure that GATES.vhdl has an 8-BIT buffer entity named "buff"
 
end Struct;