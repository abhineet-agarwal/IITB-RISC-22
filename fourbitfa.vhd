library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity fourbitfa  is
  port (A3,A2,A1,A0,B3,B2,B1,B0: in std_logic; S3,S2,S1,S0,S4: out std_logic);
end entity fourbitfa;

architecture Struct of fourbitfa is

  COMPONENT FA is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic); 
  end COMPONENT FA;
  
  signal B0X,B1X,B2X,B3X,C1,C2,C3 : std_logic;
begin
  
  FA1 : FA PORT MAP (A=> A0, B=> B0, Cin=>'0', S=>S0, Cout=>C1);
  FA2 : FA PORT MAP (A=> A1, B=> B1, Cin=>C1, S=>S1, Cout=>C2);
  FA3 : FA PORT MAP (A=> A2, B=> B2, Cin=>C2, S=>S2, Cout=>C3);
  FA4 : FA PORT MAP (A=> A3, B=> B3, Cin=>C3, S=>S3, Cout=>S4);
  
end Struct;