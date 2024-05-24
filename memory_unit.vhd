library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Memory_unit is
	port(Address:in STD_LOGIC_VECTOR(15 downto 0);
		  data_write: in STD_LOGIC_VECTOR(15 downto 0);
		  clock, MeM: in STD_LOGIC;
		  data_out: out STD_LOGIC_VECTOR(15 downto 0);
		  mem0: out std_logic_vector(15 downto 0)
		  );
end entity Memory_unit;

architecture BHV of Memory_unit is

	type array_of_vectors is ARRAY (255 downto 0) of STD_LOGIC_VECTOR(15 downto 0);

signal memory_storage: array_of_vectors := (0 => "1010000000111100",
                                            1 => "1010001001111101",
														  2 => "0000000001010000",
														  3 => "0010000001011000",
														  4 => "0011000001100000",
														  5 => "0100000010101000",
														  6 => "0101100101110000",
														  7 => "1011110111111111",
														  8 => "1010000111111110",
														  9 => "0001000001010111",
														  10 => "0110001000010000",
														  11 => "1000011001110101",
														  12 => "1001100010101011",
														  13 => "1100101110011011",
														  14 => "1010101100011101",
														  15 => "1010110100011101",
														  16 => "1100101110011011",
														  43 => "1101000000011110",
														  60 => "0000000000100010",
														  61 => "0000000000001001",
														  73 => "0010001001001000",
														  74 => "0010011100101000",
														  75 => "1010011001000000",
														  76 => "1111010001000000",
														  200 => "0000000000000111", 
													 others => "0000000000000000");
	begin
	mem0 <= memory_storage(0);
	-- Process to write data into the memory storage
	memory_write: PROCESS(clock, MeM, data_write, Address)
		begin
			if(clock' event and clock = '1') then
				if (MeM = '0') then
					memory_storage(to_integer(unsigned(Address))) <= data_write(15 downto 0);
				else 
					NULL;
				end if;
			else
				NULL;
			end if;
		end PROCESS;

	-- Process to read data from the memory storage
	memory_read: PROCESS(MeM, Address, memory_storage)
	begin
--		if(clock' event and clock = '1') then
			if (MeM = '1') then
				if (unsigned(Address) < 255) then
					data_out(15 downto 0) <= memory_storage(to_integer(unsigned(Address)));
				else
					data_out <= (others => '0');  -- Default assignment for invalid address
				end if;
			else 
				NULL;
			end if;
--		else 
--			NULL;
--		end if ;
	end PROCESS;


	-- unsigned(Address) converts the Address signal to an unsigned integer to make sure that 
	-- the range of values for Address is non-negative and falls within the valid range (0 to 4095), 
	-- and to_integer then converts that unsigned integer to a standard integer. 
	-- This resulting integer is used as an index to access the memory_storage array.
	
end architecture BHV;