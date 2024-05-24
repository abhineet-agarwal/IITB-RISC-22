library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity iitb_cpu is
	port (clk, rst: in std_logic; reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,memo: out std_logic_vector(15 downto 0));
end entity iitb_cpu;

architecture main of iitb_cpu is

component Dflipflop is 
port (d,e,r,p,c,rw: in std_logic; outp :out std_logic);
end component;

	 component Mux_2 is
  port (I0, I1: in std_logic_vector(15 downto 0);sel: in  std_logic; S: out std_logic_vector(15 downto 0));
end component Mux_2;

component Mux_4 is
	port(I0, I1, I2, I3: in std_logic_vector(15 downto 0);sel: in  std_logic_vector(1 downto 0);
			S: out std_logic_vector(15 downto 0));
end component Mux_4;

component Demux_2 is
  port (d : in std_logic_vector(15 downto 0);s: in std_logic; y0: out std_logic_vector(15 downto 0);y1 : out std_logic_vector(15 downto 0));
end component Demux_2;

component Demux_4 is
  port (d : in std_logic_vector(15 downto 0);s: in std_logic_vector(1 downto 0); y0: out std_logic_vector(15 downto 0);y1 : out std_logic_vector(15 downto 0);y2 : out std_logic_vector(15 downto 0);y3 : out std_logic_vector(15 downto 0));
end component Demux_4;

component Mux_8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7: in std_logic_vector(15 downto 0);
			sel: in  std_logic_vector(2 downto 0);
			S: out std_logic_vector(15 downto 0));
end component Mux_8;

	component alu is
	port (a, b: in std_logic_vector(15 downto 0);
		  control : in std_logic_vector(3 downto 0);
		  z: out std_logic;
		  out_alu: out std_logic_vector(15 downto 0));
	end component alu;

component rf_file is 
	port (rf_a1, rf_a2, rf_a3: in std_logic_vector(2 downto 0); rf_d3: in std_logic_vector(15 downto 0);
		 rf_d1, rf_d2,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7: out std_logic_vector(15 downto 0); rf_write_in, clk,rst: in std_logic);
end component;

component Memory_unit is
	port(Address:in STD_LOGIC_VECTOR(15 downto 0);
		  data_write: in STD_LOGIC_VECTOR(15 downto 0);
		  clock, MeM: in STD_LOGIC;
		  data_out: out STD_LOGIC_VECTOR(15 downto 0);
		  mem0: out std_logic_vector(15 downto 0)
		  );
end component Memory_unit;

component sign_extend6 is
	port (inp: in std_logic_vector(5 downto 0); extended: out std_logic_vector(15 downto 0));
end component sign_extend6;

component sign_extend8 is
	port (inp: in std_logic_vector(7 downto 0); extended: out std_logic_vector(15 downto 0));
end component sign_extend8;

component sign_extend9 is
	port (inp: in std_logic_vector(8 downto 0); extended: out std_logic_vector(15 downto 0));
end component sign_extend9;

component SHIFTer8 is
	port (a: in std_logic_vector (15 downto 0);y:out std_logic_vector(15 downto 0));
end component SHIFTer8;

component register1 is
        port(Clk        : in  std_logic;
				 Reset      : in  std_logic;
				 reg_w		: in std_logic;
             data_in    : in  std_logic_vector(15 downto 0);
             data_out   : out std_logic_vector(15 downto 0)
				 );
    end component;
	type FSMState is (M0, M1, M20,m21, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12, M13, M14, M15, M16,M790,M50,m101
		);
   signal next_fsm_state, fsm_state: FSMState := M0;
	signal instr_reg, memzero: std_logic_vector(15 downto 0):="0000000000000000";
	signal buffer_g, buffer_d, buffer_w,buffer_q, ro, eo, fo, so, lo, no, yo, ao, bo,t0, MEM_data, ALU_A0, ALU_A1, ALU_A2, ALU_A3, ALU_B1, ALU_B2, ALU_B3, ALU_C, RF_D1, RF_D2, RF_D30, RF_D31, RF_D32, RF_D33, RF_D34, RF_D35, SIGN_EXTENDER_6_OUTPUT, SIGN_EXTENDER_9_OUTPUT, SIGN_EXTENDER_8_OUTPUT : std_logic_vector(15 downto 0) :="0000000000000000";
	signal MEM, ALU_Z, Z_FLAG, RF_W, r, p, Z_W, y, x, IR_W, o, m, T1_W, T2_W, T3_W,t: std_logic := '0';
	signal e,l,q, g, a, c, d, w, n,s: std_logic_vector(1 downto 0) := "00";
	signal b,f: std_logic_vector(2 downto 0) := "000";
	signal T1, IR_in, T2, T3, Mem_A0, Mem_A1, Mem_in, shift_out,se9out, shift1,T21, T22, T30, T31, T32, T10, T11 : std_logic_vector(15 downto 0):="0000000000000000";
	signal k : std_logic_vector(3 downto 0) := "0000";
	signal ir11_9, ir8_6, ir5_3,reg0o,reg1o,reg2o,reg3o,reg4o,reg5o,reg6o,reg7o: std_logic_vector(15 downto 0) := "0000000000000000";
	signal ir12and15 : std_logic_vector(1 downto 0) := "00";
	signal Z,rstz,zz: std_logic;

	begin
	
		ir11_9<=("0000000000000" & instr_reg(11 downto 9));
		ir8_6<=("0000000000000" & instr_reg(8 downto 6));
		ir5_3<=("0000000000000" & instr_reg(5 downto 3));
		ir12and15 <= (instr_reg(12) & instr_reg(15));
		rstz <= rst ;
		
		
		--final_out <= "0000000000000000";
		
		dff : Dflipflop port map (d=> alu_z ,e => '1',r=> rst,p=> '0',c=> Clk ,rw => z_w,outp=>z);
		
		Memory1 : memory_unit port map (
			ro, mem_in,clk,MEM,MEM_data,memzero);
		
		Arithmetic_Logical_Unit : alu port map (
			eo, fo, k, ALU_Z, ALU_C
		);

		Register_file : rf_file port map (
			so(2 downto 0), t0(2 downto 0), ao(2 downto 0), bo, RF_D1, RF_D2,reg0o,reg1o,reg2o,reg3o,reg4o,reg5o,reg6o,reg7o, RF_W, clk, rst
		);

		SE6 : sign_extend6 port map (
			instr_reg(5 downto 0), ALU_B2
		);

		SE8 : sign_extend8 port map (
			instr_reg(7 downto 0), SIGN_EXTENDER_8_OUTPUT
		);
		
		SE9 : sign_extend9 port map (
			instr_reg(8 downto 0), se9out
		);
		
		shift: shifter8 port map(shift1, shift_out);
		IR: register1 port map (clk, rst, IR_W, IR_in, instr_reg);
		temp2: register1 port map (clk, rst, T2_W, t21, T2);
		temp3: register1 port map (clk, rst, T3_W, no, T3);
		temp1: register1 port map (clk, rst, T1_W, lo, T1);
      Mux4s: Mux_4 port map (ir11_9, "0000000000000111",ir8_6,"0000000000000000", s, so);
		Mux4l: Mux_4 port map (T10, T11,T22,"0000000000000000", l, lo);
		Mux2r: Mux_2 port map (Mem_A0, Mem_A1, r, ro);
		Mux2t: Mux_2 port map (ir8_6, ir11_9, t, t0);
		Mux4n: Mux_4 port map (T30, T31, T32, "0000000000000000", n, no);
		Mux4a: Mux_4 port map (ir8_6, ir5_3, ir11_9, "0000000000000111", a, ao);
		Mux4e: Mux_4 port map (ALU_A0, ALU_A1, ALU_A2, ALU_A3, e, eo);
		Mux8f: Mux_8 port map ("0000000000000001", ALU_B1, ALU_B2, ALU_B3,se9out,"0000000000000000","0000000000000000","0000000000000000",f, fo);
		Mux8b: Mux_8 port map (RF_D30, RF_D31, RF_D32, RF_D33, RF_D34, RF_D35, "0000000000000000", "0000000000000000", b, bo);
		Demux2m: Demux_2 port map (T1, m, ALU_A2, RF_D33);
		Demux2p: Demux_2 port map (Mem_Data, p, IR_in, T31);
		Demux4w: Demux_4 port map (SIGN_EXTENDER_8_OUTPUT, w, RF_D31, shift1, ALU_A3, buffer_w);
		Demux2o: Demux_2 port map (T3, o, RF_D35, Mem_A1);
		Demux4q: Demux_4 port map (T2, q, ALU_B1, Mem_in,T22,buffer_q);
		Demux2x: Demux_2 port map (shift_out, x, ALU_B3, T32);
		Demux4c: Demux_4 port map (RF_D1, c, T10, Mem_A0, RF_D30, ALU_A0);
		Demux4d: Demux_4 port map (RF_D2, d, T21, buffer_d, RF_D34, ALU_A1);
		Demux4g: Demux_4 port map (ALU_C, g, T30, RF_D32, T11, buffer_g);
		
		--clk_process : process(clk,rst)
		--begin
			--if (clk = '1' and clk'event) then
				--if(rst = '1') then
					--fsm_state <= m1;
--					instr_pointer <= "0000000000000000";    													-
				--else
					--fsm_state <= next_fsm_state;
				--end if;
			--end if;
		--end process;
		
		reg0 <= reg0o;
		reg1 <= reg1o;
		reg2 <= reg2o;
		reg3 <= reg3o;
		reg4 <= reg4o;
		reg5 <= reg5o;
		reg6 <= reg6o;
		reg7 <= reg7o;
		memo <= memzero;
		
		state_transition_process : process(clk, fsm_state)
--		variable _fs : FSMState; 																						

		begin
		

		case( fsm_state ) is
			
				when M1 =>
					zz <= '1';
               A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					IR_W<='0';
					M<='0';
					L<="00";
					T1_W<='1';
					T2_W<='1';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<= "00";
					case (instr_reg(15 downto 12)) is
						when "1100" =>
							next_fsm_state <= M11;
						when "1101" =>
							next_fsm_state <= M13;
						when "1111" =>
							next_fsm_state <= M13;
						when "1011" =>
							next_fsm_state <= M101;
						when "1010" =>
							next_fsm_state <= M101; 
						when others=>
							next_fsm_state <= M20;
						end case;

					
				when M101 =>
					zz <= '1';
               A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					IR_W<='0';
					M<='1';
					L<="00";
					T1_W<='1';
					T2_W<='1';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					X<='0';
					P<='0';
					S<="10";
					t <= '1';
					W<= "00";
					next_fsm_state <= M20;
						
				
				
				when M0 =>
				   zz <= '1';
               A<="00";
					B<="000";
					C<="01";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="000";
					IR_W<='1';
					M<='1';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="01";
					t <= '0';
					W<="00";
               next_fsm_state <= M1;
					
				when M20 =>
					zz <= '1';
               A<="00";
					B<="000";                   
					C<="11";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="000";
					Z_W<='0';
					K<="0000";
					G<="00";                        
					--j<="000";
					IR_W<='0';
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='1';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="01";
					t <= '0';
					W<="00";
					next_fsm_state <= M21;
				
				when m21 =>
					zz <= '1';
               A<="11";
					B<="101";        --change 010 to 101     
					C<="00";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="01";                                
					--j<="000";
					IR_W<='0';

					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					case (instr_reg(15 downto 12)) is
						when "1000" =>
							next_fsm_state <= M7;
						when "0001" =>
							next_fsm_state <= M5;
						when "1010" => 
							next_fsm_state <= M5;
						when "1011" =>
							next_fsm_state <= M5;
						when "1001" =>
							next_fsm_state <= M8;
						when others=>
							next_fsm_state <= M3;
						end case;
						
				when M3 =>
					zz <= '1';
               A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="10";
					F<="001";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="000";
					IR_W<='0';

					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='1';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M4;
				

				when M4 =>
					zz <= '1';
               A<="01";
					B<="101";
					C<="00";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--J<="100";
					IR_W<='0';

					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;
					
				when M5 =>
					zz <= '1';
               A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="10";
					F<="010";
					Z_W<='0';
					K<="0000";
					G<="00";
					--j<="000";
					IR_W<='0';
				
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='1';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					case (ir12and15) is
						when "01" =>
							next_fsm_state <= M9;
						when "10" =>
							next_fsm_state <= M50;
						when "11" =>
							next_fsm_state <= M10;
						when others=>
							null;
						end case;
						
--						
--				when M51 =>
--               A<="00";
--					B<="000";
--					C<="00";
--					D<="00";
--					RF_W<='0';
--					E<="00";
--					F<="00";
--					Z_W<='0';
--					K<=instr_reg(15 downto 12);
--					G<="00";
--					--J<="100";
--					IR_W<='0';
--
--					M<='0';
--					L<="10";
--					T1_W<='1';
--					T2_W<='0';
--					T3_W<='0';
--					R<='0';
--					Mem<='0';
--					N<="00";
--					O<='0';
--					Q<="10";
--					Y<='0';
--					X<='0';
--					P<='0';
--					S<='0';
--					W<="00";
--					next_fsm_state <= M5;		
				
						
				when M7 =>
					zz <= '1';
               A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="101";
					IR_W<='0';
				
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="10";
					O<='0';
					Q<="00";
					
					X<='1';
					P<='0';
					S<="00";
					t <= '0';
					W<="01";
					next_fsm_state <= M790;
					
				when M790 =>
					zz <= '1';
               A<="10";
					B<="101";
					C<="00";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--J<="100";
					IR_W<='0';

					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;
					
				when M8 =>
					zz <= '1';
					A<="10";
					B<="001";
					C<="00";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="000";
					IR_W<='0';
				
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;

				when M9 =>
					zz <= '1';
					A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="000";
					IR_W<='0';

					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='1';
					R<='1';
					Mem<='1';
					N<="01";
					O<='1';
					Q<="00";
					
					X<='0';
					P<='1';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M790;
					
					when M50 =>
					zz <= '1';
               A<="00";
					B<="101";
					C<="00";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--J<="100";
					IR_W<='0';

					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;

				when M10 =>
					zz <= '1';
               A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="000";
					IR_W<='0';
		
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='1';
					Mem<='0';
					N<="00";
					O<='1';
					Q<="01";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;

				when M11 =>
					zz <= '0';
               A<="00";
					B<="000";
					C<="00";
					D<="00";
					RF_W<='0';
					E<="10";
					F<="001";
					Z_W<='1';
					K<="0010";
					G<="00";
					--j<="000";
					IR_W<='0';
			
					M<='1';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M12;

				when M12 =>
					zz <= '0';
					A<="00";
					B<="000";
					C<="11";
					D<="00";
					RF_W<='0';
					E<="00";
					F<="010";
					Z_W<='0';
					K<="0000";
					G<="00";
					--j<="011";
					IR_W<='0';
		
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='1';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="01";
					t <= '0';
					W<="00";
					next_fsm_state <= M16;

				when M13 =>
					zz <= '1';
               A<="10";
					B<="000";
					C<="10";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="000";
					IR_W<='0';
				
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="01";
					t <= '0';
					W<="00";
					case (instr_reg(13)) is
						when '0' =>
							next_fsm_state <= M14;
						when '1' =>
							next_fsm_state <= M15;
						when others=>
							null;
							
						end case;

				when M14 =>
					zz <= '1';
					A<="11";
					B<="010";
					C<="11";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="100";
					Z_W<='0';
					K<="0000";
					G<="01";
					--j<="010";
					IR_W<='0';
			
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="01";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;
					
				when M15 =>
					zz <= '1';
					A<="11";
					B<="100";
					C<="00";
					D<="10";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<=instr_reg(15 downto 12);
					G<="00";
					--j<="001";
					IR_W<='0';
	
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="00";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;
					
				when M16 =>
					zz <= '0';
               A<="11";
					B<= Z & (not z) & Z;
					C<="11";
					D<="00";
					RF_W<='1';
					E<="00";
					F<="000";
					Z_W<='0';
					K<="0000";
					G<="01";
					--j<="000";
					IR_W<='0';
				
					M<='0';
					L<="00";
					T1_W<='0';
					T2_W<='0';
					T3_W<='0';
					R<='0';
					Mem<='1';
					N<="00";
					O<='0';
					Q<="00";
					
					X<='0';
					P<='0';
					S<="01";
					t <= '0';
					W<="00";
					next_fsm_state <= M0;
				when others =>
					null;
			end case ;	
		end process;
		
		clk_process: process(clk,rst,fsm_state)
		
		begin
		
			if(rising_edge(clk)) then
				--T1 <= temp_T1; T2 <= temp_T2; T3 <= temp_T3; T4 <= temp_T4;
				--instr_reg <= instr_reg_var;
				case(rst) is 
					when '1' =>  --if (rst = '1') then
						fsm_state <= M0;

					when others =>
--						a <= "00";
--						b <= "000";
--						RF_W <= '0';
						fsm_state <= next_fsm_state;
					--instr_pointer <= next_IP;
					--final_out <= temp_out;
				end case;
				
			else
				fsm_state<=fsm_state;
				--instr_pointer<=instr_pointer;
			end if;
		end process;
	
	
end main;

