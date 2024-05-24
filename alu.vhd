library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(A, B: in std_logic_vector(15 downto 0);
		 control: in std_logic_vector(3 downto 0);
		  z: out std_logic;
		 out_alu: out std_logic_vector(15 downto 0));
end entity alu;

architecture struct of ALU is
    
	 
	component sign_extend8 is
	port (inp: in std_logic_vector(7 downto 0); extended: out std_logic_vector(15 downto 0));
end component sign_extend8;

	component sixteen_bit_adder_sub is
		port(A, B: in std_logic_vector(15 downto 0);
		 M: in std_logic;
		 S: out std_logic_vector(15 downto 0); 
		 Cout: out std_logic);
	end component sixteen_bit_adder_sub;

	component sixteen_bit_and is
		port(A, B: in std_logic_vector(15 downto 0);
		 outp: out std_logic_vector(15 downto 0)
		 );
	end component sixteen_bit_and;

	component sixteen_bit_or is
		port(A, B: in std_logic_vector(15 downto 0);
		 outp: out std_logic_vector(15 downto 0)
		 );
	end component sixteen_bit_or;
	component BitInverter is
    Port ( 
        input_bits : in  std_logic_vector(15 downto 0);
        output_bits : out std_logic_vector(15 downto 0)
    );
end component BitInverter;

component SHIFTer8 is
port (a: in std_logic_vector (15 downto 0);y:out std_logic_vector(15 downto 0));
end component SHIFTer8;

component sixteen_bit_mul  is
  port (A3,A2,A1,A0,B3,B2,B1,B0: in std_logic; m: out std_logic_vector(15 downto 0));
end component sixteen_bit_mul;
	
component Mux_8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7: in std_logic_vector(15 downto 0);
			sel: in  std_logic_vector(2 downto 0);
			S: out std_logic_vector(15 downto 0));
end component Mux_8;


	component zero_check is
		port(A: in std_logic_vector(15 downto 0);
			S: out std_logic);
	end component zero_check;
   
	signal s5_1: std_logic_vector(7 downto 0):="00000000";
	signal s1, s2, s3, s4,s5,K: std_logic_vector(15 downto 0):="0000000000000000";
	signal s6, s7,s8, Abar: std_logic_vector(15 downto 0):="0000000000000000";
begin
	add_instance: sixteen_bit_adder_sub
		port map (
		 	A => A, B => B, M=> '0' ,S => s1
		 );
		sub_instance: sixteen_bit_adder_sub
		port map (
		 	A => A, B => B, M=> '1' ,S => s2
		 );  
	and_instance: sixteen_bit_and
		port map (
			A => A, B => B, outp => s3
		);
	or_instance: sixteen_bit_or
		port map (
			A => A, B => B, outp => s4
		);
		mul_instance: sixteen_bit_mul
		port map (
			A3 => A(3), A2=>A(2), A1=>A(1), A0=>A(0), B3 => B(3), B2=>B(2), B1=>B(1), B0=>B(0), m => s5
		);
		invert: BitInverter
		port map(input_bits=>A, output_bits=>Abar);
		
		imp_instance: sixteen_bit_or
		port map (
			A => Abar, B => B, outp => s6
		);
		
		shifter_instance : shifter8 port map (a,s8);
		
	
	
	Mux0: Mux_8
		port map (
			I0 => s1, I1 => s8, I2 =>s2, I3 => s5, I4=>s3, I5=>s4, I6=> s6, I7=>k, sel(0) => control(0), 
			sel(1) => control(1), sel(2)=>control(2), S => s7
		);
--		Mux1: Mux8
--		port map (
--			I0 => s1(1), I1 => s8(1), I2 =>s2(1) , I3 => s5(1), I4=>s3(1), I5=>s4(1), I6=> s6(1), I7=>k(1), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(1)
--		);
----	Mux1: Mux_8
--Mux3: Mux8
--		port map (
--			I0 => s1(2), I1 => s8(2), I2 =>s2(2) , I3 => s5(2), I4=>s3(2), I5=>s4(2), I6=> s6(2), I7=>k(2), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(2)
--		);
----	Mux1: Mux_8
--Mux4: Mux8
--		port map (
--			I0 => s1(3), I1 => s8(3), I2 =>s2(3) , I3 => s5(3), I4=>s3(3), I5=>s4(3), I6=> s6(3), I7=>k(3), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(3)
--		);
----	Mux1: Mux_8
--Mux5: Mux8
--		port map (
--			I0 => s1(4), I1 => s8(4), I2 =>s2(4) , I3 => s5(4), I4=>s3(4), I5=>s4(4), I6=> s6(4), I7=>k(4), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(4)
--		);
----	Mux1: Mux_8
--Mux6: Mux8
--		port map (
--			I0 => s1(5), I1 => s8(5), I2 =>s2(5) , I3 => s5(5), I4=>s3(5), I5=>s4(5), I6=> s6(5), I7=>k(5), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(5)
--		);
----	Mux1: Mux_8
--Mux7: Mux8
--		port map (
--			I0 => s1(6), I1 => s8(6), I2 =>s2(6) , I3 => s5(6), I4=>s3(6), I5=>s4(6), I6=> s6(6), I7=>k(6), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(6)
--		);
----	Mux1: Mux_8
--Mux8: Mux8
--		port map (
--			I0 => s1(7), I1 => s8(7), I2 =>s2(7) , I3 => s5(7), I4=>s3(7), I5=>s4(7), I6=> s6(7), I7=>k(7), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(7)
--		);
----	Mux1: Mux_8
--Mux9: Mux8
--		port map (
--			I0 => s1(8), I1 => s8(8), I2 =>s2(8) , I3 => s5(8), I4=>s3(8), I5=>s4(8), I6=> s6(8), I7=>k(8), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(8)
--		);
----	Mux1: Mux_8
--Mux10: Mux8
--		port map (
--			I0 => s1(9), I1 => s8(9), I2 =>s2(9) , I3 => s5(9), I4=>s3(9), I5=>s4(9), I6=> s6(9), I7=>k(9), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(9)
--		);
----	Mux1: Mux_8
--Mux11: Mux8
--		port map (
--			I0 => s1(10), I1 => s8(10), I2 =>s2(10) , I3 => s5(10), I4=>s3(10), I5=>s4(10), I6=> s6(10), I7=>k(10), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(10)
--		);
----	Mux1: Mux_8
--Mux12: Mux8
--		port map (
--			I0 => s1(11), I1 => s8(11), I2 =>s2(11) , I3 => s5(11), I4=>s3(11), I5=>s4(11), I6=> s6(11), I7=>k(11), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(11)
--		);
----	Mux1: Mux_8
--Mux13: Mux8
--		port map (
--			I0 => s1(12), I1 => s8(12), I2 =>s2(12) , I3 => s5(12), I4=>s3(12), I5=>s4(12), I6=> s6(12), I7=>k(12), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(12)
--		);
----	Mux1: Mux_8
--Mux14: Mux8
--		port map (
--			I0 => s1(13), I1 => s8(13), I2 =>s2(13) , I3 => s5(13), I4=>s3(13), I5=>s4(13), I6=> s6(13), I7=>k(13), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(13)
--		);
----	Mux1: Mux_8
--Mux15: Mux8
--		port map (
--			I0 => s1(14), I1 => s8(14), I2 =>s2(14) , I3 => s5(14), I4=>s3(14), I5=>s4(14), I6=> s6(14), I7=>k(14), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(14)
--		);
----	Mux1: Mux_8
--Mux16: Mux8
--		port map (
--			I0 => s1(15), I1 => s8(15), I2 =>s2(15) , I3 => s5(15), I4=>s3(15), I5=>s4(15), I6=> s6(15), I7=>k(15), sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2), S => s7(15)
--		);
--	Mux1: Mux_8

--	Mux1: Mux_8
--	Mux1: Mux_8
--		port map (
--			I0 => s1(1), I1 => s2(1), I2 => s5(1), I3 => s3(1), I4=>s4(1), I5=>s6(1), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(1)
--		);
--	Mux2: Mux_8
--		port map (
--			I0 => s1(2), I1 => s2(2), I2 => s5(2), I3 => s3(2), I4=>s4(2), I5=>s6(2), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(2)
--		);
--	Mux3: Mux_8
--		port map (
--			I0 => s1(3), I1 => s2(3), I2 => s5(3), I3 => s3(3), I4=>s4(3), I5=>s6(3), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(3)
--		);	
--	Mux4: Mux_8
--		port map (
--			I0 => s1(4), I1 => s2(4), I2 => s5(4), I3 => s3(4), I4=>s4(4), I5=>s6(4), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(4)
--		);	
--	Mux5: Mux_8
--		port map (
--			I0 => s1(5), I1 => s2(5), I2 => s5(5), I3 => s3(5), I4=>s4(5), I5=>s6(5), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(5)
--		);
--	Mux6: Mux_8
--		port map (
--			I0 => s1(6), I1 => s2(6), I2 => s5(6), I3 => s3(6), I4=>s4(6), I5=>s6(6), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(6)
--		);
--	Mux7: Mux_8
--		port map (
--			I0 => s1(7), I1 => s2(7), I2 => s5(7), I3 => s3(7), I4=>s4(7), I5=>s6(7), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(7)
--		);	
--	Mux8: Mux_8
--		port map (
--			I0 => s1(8), I1 => s2(8), I2 => s5(8), I3 => s3(8), I4=>s4(8), I5=>s6(8), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(8)
--		);	
--	Mux9: Mux_8
--		port map (
--			I0 => s1(9), I1 => s2(9), I2 => s5(9), I3 => s3(9), I4=>s4(9), I5=>s6(9), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(9)
--		);
--	Mux10: Mux_8
--		port map (
--			I0 => s1(10), I1 => s2(10), I2 => s5(10), I3 => s3(10), I4=>s4(10), I5=>s6(10), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(10)
--		);	
--	Mux11: Mux_8
--		port map (
--			I0 => s1(11), I1 => s2(11), I2 => s5(11), I3 => s3(11), I4=>s4(11), I5=>s6(11), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(11)
--		);
--	Mux12: Mux_8
--		port map (
--			I0 => s1(12), I1 => s2(12), I2 => s5(12), I3 => s3(12), I4=>s4(12), I5=>s6(12), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(12)
--		);	
--	Mux13: Mux_8
--		port map (
--			I0 => s1(13), I1 => s2(13), I2 => s5(13), I3 => s3(13), I4=>s4(13), I5=>s6(13), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(13)
--		);
--	Mux14: Mux_8
--		port map (
--			I0 => s1(14), I1 => s2(14), I2 => s5(14), I3 => s3(14), I4=>s4(14), I5=>s6(14), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(14)
--		);
--  Mux15: Mux_8
--		port map (
--			I0 => s1(15), I1 => s2(15), I2 => s5(15), I3 => s3(15), I4=>s4(15), I5=>s6(15), I6=> '0', I7=>'0', sel0 => control(0), 
--			sel1 => control(1), sel2=>control(2),   S => s7(15)
--		);		

	out_alu <= s7;

	zero: zero_check
		port map (
			A => s7, S => z
		);

end architecture struct;